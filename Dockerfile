FROM maven:3.9.6-amazoncorretto-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ /app/src/
RUN mvn install
RUN mvn clean package -DskipTests

FROM amazoncorretto:21.0.2-alpine3.19
WORKDIR /app
COPY --from=build /app/target/inchfab-calculator-api.jar .
EXPOSE 8080
ENTRYPOINT ["java","-jar","inchfab-calculator-api.jar"]
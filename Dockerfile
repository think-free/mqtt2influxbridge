# First stage, building application
FROM golang:alpine AS builder

RUN apk update && apk add git
ADD . /app
WORKDIR /app
RUN go build .

# Last stage : Creating final container
FROM alpine
WORKDIR /
RUN apk update && apk add ca-certificates
COPY --from=builder /app/mqtt2influxbridge /mqtt2influxbridge
ENTRYPOINT /mqtt2influxbridge

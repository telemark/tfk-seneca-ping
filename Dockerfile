###########################################################
#
# Dockerfile for tfk-seneca-ping
#
###########################################################

# Setting the base to nodejs 4.4.5
FROM mhart/alpine-node:4.4.5@sha256:40f8d227019beb78eaf88e0967c2ad7686101b6d328a5975ec2aa984d753e8e2

# Maintainer
MAINTAINER Geir Gåsodden

#### Begin setup ####

# Installs git
RUN apk add --update --no-cache git

# Extra tools for native dependencies
RUN apk add --no-cache make gcc g++ python

# Bundle app source
COPY . /src

# Change working directory
WORKDIR "/src"

# Install dependencies
RUN npm install --production

# Env variables
ENV TFK_SENECA_PING_TAG tfk-seneca-ping
ENV TFK_SENECA_PING_URL http://ping.no
ENV TFK_SENECA_PING_HOST localhost
ENV TFK_SENECA_PING_PORT 8000

# Startup
CMD ["node", "service.js", "--seneca-log=type:act"]
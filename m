Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD9C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjDTRwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDTRvw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:51:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE33A88
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:51:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f7db354092so515911f8f.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682013105; x=1684605105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJGZ153YspBAz4fg+qha3A5IBMhnHXfFhKkznjdfe2g=;
        b=F9imwsm0LDDuJQT7Y0XmfRy5GpIG7c7qr5MBcf27HJCvTeoZ3dwrKmzOTz9IuONd2H
         T7jitSZBbJZdqnvz66EjtYGdyUKPDKVwSw/0BlYhULWp6A3ZEaSt4ooYQNZ6tKfBW3eH
         9IHCgpVVcobKpK4nL22slYlmcNd0gk/8+AEJ6JVKn8Y/LtCKZhb+9KyolwTw3lMWMpt8
         2Uz7/LcAz3grv7RrTxCgbkpCmr+/7vIQeTjreFEeA9eGS5OIy++ci8N9KXKfLI/3URIw
         BEDtU7U3F/R5GV/WBxKPY22/U8JjjURC8y1PcsiKIG5lGxNZXFyYs/XkwKl2EetGTxTQ
         SwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682013105; x=1684605105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJGZ153YspBAz4fg+qha3A5IBMhnHXfFhKkznjdfe2g=;
        b=T9HSnEce5C3ZmcXjevjU/vKVFbmX++q67yvESPzdHNTTbZrbP0U2tyOvFNRxID3i5U
         RZS6pqYLnk9Y1M1Vq0QHuXvbGRGhQBO7zWQ0LlrKDdDSHTsY0uVvRqP9N379CtvZrf7U
         7y7HmfnIX194/3bWHL3p1OgZyNeU1S+cg0Ib3y309Yvo2leNvR06KAqG0yEalJxHLt5K
         /kdgt81aVj8n1F8HZsuv41N+NEjxJou4ln1+gf1OVXzcMptA+5C/YmMPbXg57Nue2x3r
         1d+g/LVstkwhZRRHmHtbU4YsqQAHMRCxwggt65eMcHWdgxkM6qIx4n9Ym96hH6tbiyxu
         vqMQ==
X-Gm-Message-State: AAQBX9eDrj+bsBojOfJJPxV+gIyjao0QFjoKbsEOzNpVn5q6TXhWDR+v
        uPZVDolQjf2R2D8LOav2iXC5xR2KI7E=
X-Google-Smtp-Source: AKy350aQz3SYNip+BTbReKcaee7+UKjdF3OA161BrD2n79ZZ0rTHaWNyv6FmP6OBnFkYmF9n7rchrw==
X-Received: by 2002:a5d:6591:0:b0:2fb:1a68:1d96 with SMTP id q17-20020a5d6591000000b002fb1a681d96mr1697184wru.15.1682013105435;
        Thu, 20 Apr 2023 10:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a056000010400b002fa67f77c16sm2488027wrx.57.2023.04.20.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:51:45 -0700 (PDT)
Message-Id: <pull.1520.git.1682013104508.gitgitgadget@gmail.com>
From:   "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 17:51:44 +0000
Subject: [PATCH] http: document sslcert and sslkey types and extend to proxy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ricky Davidson <Ricky.Davidson@hii-tsd.com>,
        Ricky Davidson <Ricky.Davidson@hii-tsd.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ricky Davidson <Ricky.Davidson@hii-tsd.com>

0a01d41 added http.sslCertType and http.sslKeyType, but:

1. does not document the feature.
2. does not apply to SSL proxy equivalents.

Documents http.sslCertType and http.sslKeyType. Implements
http.proxySSLCertType. Same for http.sslKeyType and
http.proxySSLKeyType equivalents and related environment
variables.

Signed-off-by: Ricky Davidson <Ricky.Davidson@hii-tsd.com>
---
    [PATCH] http: document sslcert and sslkey types and extend to proxy
    
    0a01d41ee4ca7f8afb75219f46f4f1c573465075 wonderfully added
    http.sslCertType and http.sslKeyType, but has a couple problems:
    
     1. does not document the feature.
     2. does not apply to SSL proxy equivalents.
    
    Documents http.sslCertType and http.sslKeyType. Implements
    http.proxySSLCertType. Same for http.sslKeyType and http.proxySSLKeyType
    equivalents and related environment variables.
    
    Signed-off-by: Ricky Davidson Ricky.Davidson@hii-tsd.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1520%2FRicky-Davidson-hii-tsd%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1520/Ricky-Davidson-hii-tsd/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1520

 Documentation/config/http.txt | 24 ++++++++++++++++++++++++
 http.c                        | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index afeeccfbfa7..10a53930e5f 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -34,11 +34,23 @@ http.proxySSLCert::
 	with an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_CERT` environment
 	variable.
 
+http.proxySSLCertType::
+	Format of the client certificate used to authenticate with an HTTPS proxy.
+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
+	variable.
+
 http.proxySSLKey::
 	The pathname of a file that stores a private key to use to authenticate with
 	an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_KEY` environment
 	variable.
 
+http.proxySSLKeyType::
+	Format of the client private key used to authenticate with an HTTPS proxy.
+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
+	variable.
+
 http.proxySSLCertPasswordProtected::
 	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
 	will prompt the user, possibly many times, if the certificate or private key
@@ -161,11 +173,23 @@ http.sslCert::
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
 	variable.
 
+http.sslCertType::
+	Format of the SSL certificate used to authenticate over HTTPS.
+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
+	variable.
+
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
 	variable.
 
+http.sslKeyType::
+	Format of the SSL private key used to authenticate over HTTPS.
+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
+	variable.
+
 http.sslCertPasswordProtected::
 	Enable Git's password prompt for the SSL certificate.  Otherwise
 	OpenSSL will prompt the user, possibly many times, if the
diff --git a/http.c b/http.c
index d5d82c5230f..bee4ea64115 100644
--- a/http.c
+++ b/http.c
@@ -74,7 +74,9 @@ static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
 
 static const char *http_proxy_ssl_cert;
+static const char *http_proxy_ssl_cert_type;
 static const char *http_proxy_ssl_key;
+static const char *http_proxy_ssl_key_type;
 static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
@@ -441,9 +443,13 @@ static int http_options(const char *var, const char *value, void *cb)
 
 	if (!strcmp("http.proxysslcert", var))
 		return git_config_string(&http_proxy_ssl_cert, var, value);
+	if (!strcmp("http.proxysslcerttype", var))
+		return git_config_string(&http_proxy_ssl_cert_type, var, value);
 
 	if (!strcmp("http.proxysslkey", var))
 		return git_config_string(&http_proxy_ssl_key, var, value);
+	if (!strcmp("http.proxysslkeytype", var))
+		return git_config_string(&http_proxy_ssl_key_type, var, value);
 
 	if (!strcmp("http.proxysslcainfo", var))
 		return git_config_string(&http_proxy_ssl_ca_info, var, value);
@@ -1146,9 +1152,13 @@ static CURL *get_curl_handle(void)
 
 			if (http_proxy_ssl_cert)
 				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
+			if (http_proxy_ssl_cert_type)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERTTYPE, http_proxy_ssl_cert_type);
 
 			if (http_proxy_ssl_key)
 				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
+			if (http_proxy_ssl_key_type)
+				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEYTYPE, http_proxy_ssl_key_type);
 
 			if (has_proxy_cert_password())
 				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
@@ -1285,7 +1295,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		max_requests = DEFAULT_MAX_REQUESTS;
 
 	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
+	set_from_env(&http_proxy_ssl_cert_type, "GIT_PROXY_SSL_CERT_TYPE");
 	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
+	set_from_env(&http_proxy_ssl_key_type, "GIT_PROXY_SSL_KEY_TYPE");
 	set_from_env(&http_proxy_ssl_ca_info, "GIT_PROXY_SSL_CAINFO");
 
 	if (getenv("GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED"))

base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
-- 
gitgitgadget

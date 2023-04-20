Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071FC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjDTULt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDTULq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 16:11:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D885170C
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:11:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f4214b430aso598198f8f.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682021502; x=1684613502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dazENGqNSA7izrlf08rFPHPAzuGs3+MWEpTLz/uy9II=;
        b=Yh29g5Kcm2y977K50f+zcQ4Jfx83ptKcqIBtzD+XhPEYDxC6FaB+qcrXbrqOvArx5y
         nqUvuG9luqDHfi3OIzfzUCnOtPLfNABjQkAPDeuLhN8ZPeuQmNczU4GfB6b7xLHOt8Wq
         If1gChHuoJ6GynNG/fDN8R706/FBVrJkl0fzbBhNDqSDSHVEX+QIwL8EoqyVTO7X91jK
         SFlqZQyE68UKy8eDZ81utbkNIi6wC8SFm0OYo+oG8G/lWJWG5VW1N5HeIj4+SDzBZ1kr
         zTlzm2lFbGPdwdztzzKdypsswLxrnrNtP58t0ldPfuKcSZPQ/i8gKY5vLdAkkfYufa1M
         iHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682021502; x=1684613502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dazENGqNSA7izrlf08rFPHPAzuGs3+MWEpTLz/uy9II=;
        b=V0jE+W3RAXut8wdSQ+eWKnH5f+xOp3yFNK9wuOvaOj49U37y6OGV+BtrESmw37BNPh
         9qclDvPws2wOacUeb9FWdphWk/FKIAUF63CnuIRSGNJ3wem5BkC20A5YR1sxLF+gzl8O
         ByUu0WpjlovzRLGnD1tj2V6iX9l7eWTY8q4lCEeAVjKpwi6Z2tPK5BK218Dw2NmW+YI7
         5zDB0s8IXsLGAfHNVliG9fMqCpY/U3xmc1O23n3ve4U8mj3pgDGaEXHDSO8qLFktloU4
         CDg3BGL6gDV0muiUDp4A6xDLosZVhS/L9m1FoIPJtIO8syP18dvdaTJwXKJwb+ucEx9A
         aVhA==
X-Gm-Message-State: AAQBX9efra3LsjSDEI6MDnfgJYYLhcg3OrNGbkilmIZBDnpBgrljkQO7
        0h6sor0+1/bCko5rBAuhWtfNSNh4k30=
X-Google-Smtp-Source: AKy350bRJNcehj3A5+ZCRI8wbbmANC+hUxgHBK3BPbzxkKkAt0QaRYQpVJSSkmtvC8V8RrZASFk6lQ==
X-Received: by 2002:a5d:42c7:0:b0:2f7:8779:3bc3 with SMTP id t7-20020a5d42c7000000b002f787793bc3mr2225637wrr.11.1682021502418;
        Thu, 20 Apr 2023 13:11:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a5d5410000000b002fbc61cd080sm2813730wrv.9.2023.04.20.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:11:42 -0700 (PDT)
Message-Id: <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
References: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
From:   "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 20:11:40 +0000
Subject: [PATCH v3] http: document sslcert and sslkey types and extend to
 proxy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Junio C Hamano [ ]" <gitster@pobox.com>,
        Ricky Davidson <Ricky.Davidson@hii-tsd.com>,
        Ricky Davidson <Ricky.Davidson@hii-tsd.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ricky Davidson <Ricky.Davidson@hii-tsd.com>

0a01d41ee4 (http: add support for different sslcert and sslkey
types., 2023-03-20) added http.sslCertType and http.sslKeyType, but:

1. it does not document the feature.
2. it does not apply to SSL proxy equivalents.

Documents http.sslCertType and http.sslKeyType. Implements
http.proxySSLCertType. Does the same for http.sslKeyType and
http.proxySSLKeyType equivalents and related environment
variables.

Signed-off-by: Ricky Davidson <Ricky.Davidson@hii-tsd.com>
---
    [PATCH] http: document sslcert and sslkey types and extend to proxy
    
    0a01d41ee4 (http: add support for different sslcert and sslkey types.,
    2023-03-20) added http.sslCertType and http.sslKeyType, but:
    
     1. it does not document the feature.
     2. it does not apply to SSL proxy equivalents.
    
    Documents http.sslCertType and http.sslKeyType. Implements
    http.proxySSLCertType. Does the same for http.sslKeyType and
    http.proxySSLKeyType equivalents and related environment variables.
    
    Signed-off-by: Ricky Davidson Ricky.Davidson@hii-tsd.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1520%2FRicky-Davidson-hii-tsd%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1520/Ricky-Davidson-hii-tsd/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1520

Range-diff vs v2:

 1:  78b96f60ec8 ! 1:  020c03104f4 http: document sslcert and sslkey types and extend to proxy
     @@ Metadata
       ## Commit message ##
          http: document sslcert and sslkey types and extend to proxy
      
     -    0a01d41 added http.sslCertType and http.sslKeyType, but:
     +    0a01d41ee4 (http: add support for different sslcert and sslkey
     +    types., 2023-03-20) added http.sslCertType and http.sslKeyType, but:
      
     -    1. does not document the feature.
     -    2. does not apply to SSL proxy equivalents.
     +    1. it does not document the feature.
     +    2. it does not apply to SSL proxy equivalents.
      
          Documents http.sslCertType and http.sslKeyType. Implements
     -    http.proxySSLCertType. Same for http.sslKeyType and
     +    http.proxySSLCertType. Does the same for http.sslKeyType and
          http.proxySSLKeyType equivalents and related environment
          variables.
      


 Documentation/config/http.txt | 24 ++++++++++++++++++++++++
 http.c                        | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index afeeccfbfa7..53386b90185 100644
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
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_KEY_TYPE` environment
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
+	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
+	variable.
+
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
 	variable.
 
+http.sslKeyType::
+	Format of the SSL private key used to authenticate over HTTPS.
+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
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

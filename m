Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7687C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 03:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjDUDgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 23:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDUDgF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 23:36:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837ED1FF0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 20:36:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so1141719f8f.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682048161; x=1684640161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTqrfADNm7DgrO1MZTrU6DrhMA0DU1uQnakQoHJBK3w=;
        b=Ep6cdJhloQoQRISmBn1IxMgfHim6bissEi70XOgNqyCgfKCq8o0d26OT5iny1M1qdK
         82c8Udyuye8DQLQDdCnaLWXrue1MujaYjSI8dtQVxA4VQTtQoMD1uWTuYDziGZ2BwhOR
         KDkebhMcQc/dS7cSM2QzGY/U6tHvVF6i9sVRFQ+S8xKZc7jFNw/r6oZ74fhthFSvU+Lv
         X+C5jwVI3m8gUXM4QC3hB9ctzS9RiNexAkqbSuKGers5R54YNXDAXNjJqifGXKTYRF9F
         mF6XKovFLEx5+ooxXtVT/T6w19h3Tek+JoqzUiOAwd11Cc/RdoVg8rzKsAIcRjHKd0qe
         z/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682048161; x=1684640161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTqrfADNm7DgrO1MZTrU6DrhMA0DU1uQnakQoHJBK3w=;
        b=jsUymAnUjxETSZ7Ma5txwpzdL6e+QAZym4wv3gSa4qWENLW9YNjLMgxvGzlHmkWiBH
         wjiIcjUQ348QxQqV49W7c1IaeMZlLRvuJmM0wUmgZO9tIj+xnXfgWP9FRsCAlAflyjcU
         0Gpx9Gsv0Vp7JonhHihSfwONTUW3XypodsticqAo5CTAEP/9TNie8C7OLdvPRp8B4I5r
         wH/78jfFpAVvlvBP2gXdgyU2rp/rd2ACFda1fDAFe75TjdU6akwdIgkecT9vQfXRSa8w
         2EcXYQKn4+D+2iW+VoBkof3X6IERqRN9eeCgiDf+0CtMeVA5V60G1bFGNwV0+Qqg0rpv
         EyOQ==
X-Gm-Message-State: AAQBX9fIrSkyVq+aR4pIESWJBqCzKXLHSMDxU2B/4qEMtdtq7fRWwuwZ
        XP/o63slRzYYEvY1jkv1aOu2YP1cyHU=
X-Google-Smtp-Source: AKy350YrkunR3mEDgPssDGnfqbKag3qhgRzRiYnBWKnU/d5JCsd2mJpy7O3sCZZIZbdrYNc7ydq7KA==
X-Received: by 2002:a5d:56c4:0:b0:2f6:ca0d:ec1c with SMTP id m4-20020a5d56c4000000b002f6ca0dec1cmr2575121wrw.10.1682048160549;
        Thu, 20 Apr 2023 20:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4bc7000000b002fefe2edb72sm3438905wrt.17.2023.04.20.20.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 20:36:00 -0700 (PDT)
Message-Id: <pull.1520.v4.git.1682048159508.gitgitgadget@gmail.com>
In-Reply-To: <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
References: <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
From:   "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 03:35:59 +0000
Subject: [PATCH v4] http: document sslcert and sslkey types and extend to
 proxy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Junio C Hamano [ ]" <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1520%2FRicky-Davidson-hii-tsd%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1520/Ricky-Davidson-hii-tsd/master-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1520

Range-diff vs v3:

 1:  020c03104f4 ! 1:  c2489a9ed88 http: document sslcert and sslkey types and extend to proxy
     @@ Documentation/config/http.txt: http.proxySSLCert::
       
      +http.proxySSLCertType::
      +	Format of the client certificate used to authenticate with an HTTPS proxy.
     -+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     ++	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
      +	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
     -+	variable.
     ++	variable. For more information on accepted values, see libcurl's
     ++	`CURLOPT_PROXY_SSLCERTTYPE`.
      +
       http.proxySSLKey::
       	The pathname of a file that stores a private key to use to authenticate with
     @@ Documentation/config/http.txt: http.proxySSLCert::
       
      +http.proxySSLKeyType::
      +	Format of the client private key used to authenticate with an HTTPS proxy.
     -+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     ++	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
      +	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_KEY_TYPE` environment
     -+	variable.
     ++	variable. For more information on accepted values, see libcurl's
     ++	`CURLOPT_PROXY_SSLKEYTYPE`.
      +
       http.proxySSLCertPasswordProtected::
       	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
     @@ Documentation/config/http.txt: http.sslCert::
       
      +http.sslCertType::
      +	Format of the SSL certificate used to authenticate over HTTPS.
     -+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     ++	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
      +	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
     -+	variable.
     ++	variable. For more information on accepted values, see libcurl's
     ++	`CURLOPT_SSLCERTTYPE`.
      +
       http.sslKey::
       	File containing the SSL private key when fetching or pushing
     @@ Documentation/config/http.txt: http.sslCert::
       
      +http.sslKeyType::
      +	Format of the SSL private key used to authenticate over HTTPS.
     -+	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     -+	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
     -+	variable.
     ++	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
     ++	a crypto engine. Can be overridden by the `GIT_SSL_KEY_TYPE` environment
     ++	variable. For more information on accepted values, see libcurl's
     ++	`CURLOPT_SSLKEYTYPE`.
      +
       http.sslCertPasswordProtected::
       	Enable Git's password prompt for the SSL certificate.  Otherwise


 Documentation/config/http.txt | 28 ++++++++++++++++++++++++++++
 http.c                        | 12 ++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index afeeccfbfa7..dfca1a54123 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -34,11 +34,25 @@ http.proxySSLCert::
 	with an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_CERT` environment
 	variable.
 
+http.proxySSLCertType::
+	Format of the client certificate used to authenticate with an HTTPS proxy.
+	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
+	variable. For more information on accepted values, see libcurl's
+	`CURLOPT_PROXY_SSLCERTTYPE`.
+
 http.proxySSLKey::
 	The pathname of a file that stores a private key to use to authenticate with
 	an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_KEY` environment
 	variable.
 
+http.proxySSLKeyType::
+	Format of the client private key used to authenticate with an HTTPS proxy.
+	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_KEY_TYPE` environment
+	variable. For more information on accepted values, see libcurl's
+	`CURLOPT_PROXY_SSLKEYTYPE`.
+
 http.proxySSLCertPasswordProtected::
 	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
 	will prompt the user, possibly many times, if the certificate or private key
@@ -161,11 +175,25 @@ http.sslCert::
 	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
 	variable.
 
+http.sslCertType::
+	Format of the SSL certificate used to authenticate over HTTPS.
+	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
+	variable. For more information on accepted values, see libcurl's
+	`CURLOPT_SSLCERTTYPE`.
+
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
 	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
 	variable.
 
+http.sslKeyType::
+	Format of the SSL private key used to authenticate over HTTPS.
+	Example values are `PEM` and `ENG`. The format `ENG` enables loading from
+	a crypto engine. Can be overridden by the `GIT_SSL_KEY_TYPE` environment
+	variable. For more information on accepted values, see libcurl's
+	`CURLOPT_SSLKEYTYPE`.
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

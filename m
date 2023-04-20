Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1A5C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 18:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDTSMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDTSMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 14:12:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EE2715
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 11:12:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id eo4-20020a05600c82c400b003f05a99a841so1542349wmb.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682014324; x=1684606324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7X0QH2k0kBqyXO98NKJVmGFRrDxTx1j08mA1Rtcmo=;
        b=U5ozKOk2sBCVm/nL5dwgKWQ/Y462U8JyLVuLIUoskXQWXIJ3WDd/BQWAQNA+Zun/GU
         p4BTur9EnyUuU5WKAylzS4w6+XGlIELSmHZuEFxm31Q+TZ36DbnlS8Gu3KvEIqItGwiv
         x+SfEdLnfOZPML11pW7hTnuNYhBNKdMKpajKs31Rw5j7zp1vEjMUYu2cd/t/KOwbPlL4
         ERVqgxyR2bx3wOD5+vSBlZUuFzkbMgSO3tf1q4XAo4LZxSWVoB7x/6p+hRPQCLvKtjNB
         P0F0zBei4T8/pG/i4hkABS+ue/dxSkURBda3ErC0MCaEtZI2054PgcjIbo4NDjPvO6gN
         s3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014324; x=1684606324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7X0QH2k0kBqyXO98NKJVmGFRrDxTx1j08mA1Rtcmo=;
        b=JMiQnGjLBM2Ygt2Q3jZ9ZN2CBRhPV0rdSkIUD7vtnGCbQ85wdq88siaPh5sc76G7Og
         5TpnthwQpex8Q4+X8wsaHKv4d5H/Mw2nHcqUCOtt5Bvv846AXh4iNtfkwnOE0O+C6CJE
         BSZzA6FXglTTioHoDBt8NYKyQoVqNkgVu5smY67Ny0ork+VDp8qiBHFrcWUk6p74zEUz
         /jixMbwSbzLqQpTNl9Vlt/p6+bA0SxC4oKJeROJKjMtDHSosZ2QAkPrNBocH12R390Ac
         FrJ8t3kN8ds1jBz7cV4JD2hyshLztGSrUi1obP5S0NwBQQu/SkynEnGYVzVR91NcJlZ8
         93cg==
X-Gm-Message-State: AAQBX9e/lGXcU8lcncYjSx4AWjtlmSNo0EYkfCxx0EQlTR9cYD7bHneC
        iyp7hLiy2SnRkgOheryHqPf+TqL20+E=
X-Google-Smtp-Source: AKy350YicN6UBjh19ux171kSTUzH+3PTjOFlaaEtDBpWtUQlT5/Tfhh39LrJLLhsciB9EdXk5NUMHQ==
X-Received: by 2002:a1c:f608:0:b0:3ee:b3bf:5f7c with SMTP id w8-20020a1cf608000000b003eeb3bf5f7cmr2026280wmc.23.1682014323771;
        Thu, 20 Apr 2023 11:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003ee443bf0c7sm6109198wms.16.2023.04.20.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:12:03 -0700 (PDT)
Message-Id: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
In-Reply-To: <pull.1520.git.1682013104508.gitgitgadget@gmail.com>
References: <pull.1520.git.1682013104508.gitgitgadget@gmail.com>
From:   "Ricky Davidson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Apr 2023 18:12:02 +0000
Subject: [PATCH v2] http: document sslcert and sslkey types and extend to
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1520%2FRicky-Davidson-hii-tsd%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1520/Ricky-Davidson-hii-tsd/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1520

Range-diff vs v1:

 1:  711d90215d0 ! 1:  78b96f60ec8 http: document sslcert and sslkey types and extend to proxy
     @@ Documentation/config/http.txt: http.proxySSLCert::
      +http.proxySSLKeyType::
      +	Format of the client private key used to authenticate with an HTTPS proxy.
      +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     -+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
     ++	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_KEY_TYPE` environment
      +	variable.
      +
       http.proxySSLCertPasswordProtected::
     @@ Documentation/config/http.txt: http.sslCert::
      +http.sslCertType::
      +	Format of the SSL certificate used to authenticate over HTTPS.
      +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     -+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
     ++	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
      +	variable.
      +
       http.sslKey::
     @@ Documentation/config/http.txt: http.sslCert::
      +http.sslKeyType::
      +	Format of the SSL private key used to authenticate over HTTPS.
      +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
     -+	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
     ++	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
      +	variable.
      +
       http.sslCertPasswordProtected::


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

Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD4AC3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9F620866
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEyviMJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgCDSkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:40:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53356 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgCDSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 13:40:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id g134so3329563wme.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 10:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjESvJu7+Ch3biEVvVAJwT1k4RBawfrRQNVn2vEpGY8=;
        b=ZEyviMJ874NbF37Fi+BmLF1q0E8vEYIP9MxIpL7cFR8ZBuor6f3AlJ8PQjFB5Gi7fD
         d+evIQUcLuiQs0UTvgdg+kcS41VncHWgpNA9zXVGJmfkqH4NRrRcn4JWwk6M772RZsOa
         DiLC6YUPqhlkxdSWye8Fc8hA52FZMHGtEpWZM84Gt3ioJngYwlfxo7JyBgQ3cSWUrYGn
         Y9B2+j4tC600K2uSAvfwmCc4LyEwygKT+zPtcDmm1ptlZu329ycM+tv8esqhD8P3r03i
         NZEwkdURdKBLowk20Xdo1+myaSGelDK4r/YOhdyy22jhKgNuHPZT4H73TiGISDkwQ5ck
         yE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjESvJu7+Ch3biEVvVAJwT1k4RBawfrRQNVn2vEpGY8=;
        b=QHLK4p6vuMsKaSTLZemCyICCRfNxyWpxVmKl/70JU+FeqJz6UB7cFdB9yu6E5wNQRI
         WYCu9jmULFMBgqLjV7BjH5SGdlrE1poVf8uKPDcobQSj0EODf7QZ3y4h1LyELAXk81rC
         9deoIRqKEEEWuDSxsCP22G10Q8H4utNqvKr9guhxXuWh9VyGtQKySM/oB710zcn4TsbY
         m2Aglfr15fnmeksf7c/yjmsv91y8TYjOVqm6qN5OVZKPWmUF1Zxs4ShENioEwGLJwALx
         VyecV2IJHUK5ZPFO17t5FH91Oemgmkgzr3KOlSwi2tjapqCjfjPDooqeN1F2INHbVYr6
         uuKQ==
X-Gm-Message-State: ANhLgQ3nRmU3bvtZ6LYxY6PMxsidb2Rrls/kmNet52ouh0x1hyxX2K47
        u64exNWU8ASmrErjrTWDE3/2TvFg
X-Google-Smtp-Source: ADFU+vt07pr8VmtMxUMoxXL+Mnc5ns0eDldqvajRmrGY7L9muboWJtomWAdB8qbWRmLjU76OcCVBwQ==
X-Received: by 2002:a05:600c:14d5:: with SMTP id i21mr894842wmh.186.1583347207839;
        Wed, 04 Mar 2020 10:40:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm5796410wmb.8.2020.03.04.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:40:07 -0800 (PST)
Message-Id: <pull.559.v3.git.1583347206.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
References: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
From:   "Jorge via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 18:40:04 +0000
Subject: [PATCH v3 0/2] Add HTTPS proxy SSL options (cert, key, cainfo)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git currently supports connecting to proxies through HTTPS. However it does
not allow you to configure SSL options when connecting (i.e. client cert,
key, cainfo). These set of commits add the necessary options and
documentation needed to support them.

Libcurl already has support for this so changes are somewhat minimal.

I ran the CI tests and verified manually with an HTTPS proxy that changes
are working as expected. I didn't see integration tests under /t or tests
that verified libcurl integration. 

./bin-wrappers/git -c http.proxy=https://<PROXY-HOSTNAME> \
-c http.proxycert=<CERT> -c http.proxykey=<KEY> \
clone https://github.com/jalopezsilva/dotfiles.git  

Changes since v2:
=================

 * Merged the two initial commits as the second one was adding documentation
   for the first.
 * Removed the SSL Cert password from configuration. I'm using a similar
   function to has_cert_password to retrieve it if needed. 
 * Better names and descriptions were given to the options. 
 * Introduced another commit adding environment variable overrides for the
   new options.

Jorge Lopez Silva (2):
  http: add client cert for HTTPS proxies.
  http: add environment variable for HTTPS proxy.

 Documentation/config/http.txt | 21 ++++++++++
 http.c                        | 74 ++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 5 deletions(-)


base-commit: 51ebf55b9309824346a6589c9f3b130c6f371b8f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-559%2Fjalopezsilva%2Fhttps_proxy_ssl_options-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-559/jalopezsilva/https_proxy_ssl_options-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/559

Range-diff vs v2:

 1:  a5d980e7501 ! 1:  e18b342819b http: add client cert for HTTPS proxies.
     @@ -9,13 +9,44 @@
      
          A client certificate can provide an alternative way of authentication
          instead of using 'ProxyAuthorization' or other more common methods of
     -    authentication.
     +    authentication.  Libcurl supports this functionality already so changes
     +    are somewhat minimal. The feature is guarded by the first available
     +    libcurl version that supports these options.
      
     -    Libcurl supports this functionality already. The feature is guarded by
     -    the first available libcurl version that supports these options.
     +    4 configuration options are added and documented, cert, key, cert
     +    password protected and CA info. The CA info should be used to specify a
     +    different CA path to validate the HTTPS proxy cert.
      
          Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
      
     + diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
     + --- a/Documentation/config/http.txt
     + +++ b/Documentation/config/http.txt
     +@@
     + * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
     + --
     + 
     ++http.proxySSLCert::
     ++	The pathname of a file that stores a client certificate to use to authenticate
     ++	with an HTTPS proxy.
     ++
     ++http.proxySSLKey::
     ++	The pathname of a file that stores a private key to use to authenticate with
     ++	an HTTPS proxy.
     ++
     ++http.proxySSLCertPasswordProtected::
     ++	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
     ++	will prompt the user, possibly many times, if the certificate or private key
     ++	is encrypted.
     ++
     ++http.proxySSLCAInfo::
     ++	Pathname to the file containing the certificate bundle that should be used to
     ++	verify the proxy with when using an HTTPS proxy.
     ++
     + http.emptyAuth::
     + 	Attempt authentication without seeking a username or password.  This
     + 	can be used to attempt GSS-Negotiate authentication without specifying
     +
       diff --git a/http.c b/http.c
       --- a/http.c
       +++ b/http.c
     @@ -24,12 +55,11 @@
       static const char *curl_http_proxy;
       static const char *http_proxy_authmethod;
      +
     -+#if LIBCURL_VERSION_NUM >= 0x073400
      +static const char *http_proxy_ssl_cert;
      +static const char *http_proxy_ssl_key;
     -+static const char *http_proxy_ssl_keypasswd;
     -+#endif
      +static const char *http_proxy_ssl_ca_info;
     ++static struct credential proxy_cert_auth = CREDENTIAL_INIT;
     ++static int proxy_ssl_cert_password_required;
      +
       static struct {
       	const char *name;
     @@ -38,23 +68,45 @@
       	if (!strcmp("http.proxyauthmethod", var))
       		return git_config_string(&http_proxy_authmethod, var, value);
       
     -+#if LIBCURL_VERSION_NUM >= 0x073400
     -+	if (!strcmp("http.proxycert", var))
     ++	if (!strcmp("http.proxysslcert", var))
      +		return git_config_string(&http_proxy_ssl_cert, var, value);
      +
     -+	if (!strcmp("http.proxykey", var))
     ++	if (!strcmp("http.proxysslkey", var))
      +		return git_config_string(&http_proxy_ssl_key, var, value);
      +
     -+	if (!strcmp("http.proxykeypass", var))
     -+		return git_config_string(&http_proxy_ssl_keypasswd, var, value);
     -+
     -+	if (!strcmp("http.proxycainfo", var))
     ++	if (!strcmp("http.proxysslcainfo", var))
      +		return git_config_string(&http_proxy_ssl_ca_info, var, value);
     -+#endif
     ++
     ++	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
     ++		proxy_ssl_cert_password_required = git_config_bool(var, value);
     ++		return 0;
     ++	}
      +
       	if (!strcmp("http.cookiefile", var))
       		return git_config_pathname(&curl_cookie_file, var, value);
       	if (!strcmp("http.savecookies", var)) {
     +@@
     + 	return 1;
     + }
     + 
     ++#if LIBCURL_VERSION_NUM >= 0x073400
     ++static int has_proxy_cert_password(void)
     ++{
     ++	if (http_proxy_ssl_cert == NULL || proxy_ssl_cert_password_required != 1)
     ++		return 0;
     ++	if (!proxy_cert_auth.password) {
     ++		proxy_cert_auth.protocol = xstrdup("cert");
     ++		proxy_cert_auth.username = xstrdup("");
     ++		proxy_cert_auth.path = xstrdup(http_proxy_ssl_cert);
     ++		credential_fill(&proxy_cert_auth);
     ++	}
     ++	return 1;
     ++}
     ++#endif
     ++
     + #if LIBCURL_VERSION_NUM >= 0x071900
     + static void set_curl_keepalive(CURL *c)
     + {
      @@
       #if LIBCURL_VERSION_NUM >= 0x073400
       		curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
     @@ -82,16 +134,28 @@
      +		else if (starts_with(curl_http_proxy, "https")) {
      +			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
      +
     -+			if (http_proxy_ssl_cert != NULL)
     ++			if (http_proxy_ssl_cert)
      +				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
      +
     -+			if (http_proxy_ssl_key != NULL)
     ++			if (http_proxy_ssl_key)
      +				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
      +
     -+			if (http_proxy_ssl_keypasswd != NULL)
     -+				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_keypasswd);
     -+
     ++			if (has_proxy_cert_password())
     ++				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
      +		}
       #endif
       		if (strstr(curl_http_proxy, "://"))
       			credential_from_url(&proxy_auth, curl_http_proxy);
     +@@
     + 	}
     + 	ssl_cert_password_required = 0;
     + 
     ++	if (proxy_cert_auth.password != NULL) {
     ++		memset(proxy_cert_auth.password, 0, strlen(proxy_cert_auth.password));
     ++		FREE_AND_NULL(proxy_cert_auth.password);
     ++	}
     ++	proxy_ssl_cert_password_required = 0;
     ++
     + 	FREE_AND_NULL(cached_accept_language);
     + }
     + 
 2:  c40207a3928 ! 2:  086c5e59fb2 config: documentation for HTTPS proxy client cert.
     @@ -1,10 +1,12 @@
      Author: Jorge Lopez Silva <jalopezsilva@gmail.com>
      
     -    config: documentation for HTTPS proxy client cert.
     +    http: add environment variable for HTTPS proxy.
      
     -    The commit adds 4 options, client cert, key, key password and CA info.
     -    The CA info can be used to specify a different CA path to validate the
     -    HTTPS proxy cert.
     +    This commit adds four environment variables that can be used to
     +    configure the proxy cert, proxy ssl key, the proxy cert password
     +    protected flag, and the CA info for the proxy.
     +
     +    Documentation for the options was also updated.
      
          Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
      
     @@ -12,23 +14,49 @@
       --- a/Documentation/config/http.txt
       +++ b/Documentation/config/http.txt
      @@
     - * `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
     - --
       
     -+http.proxycert::
     -+	File indicating a client certificate to use to authenticate with an HTTPS proxy.
     -+
     -+http.proxykey::
     -+	File indicating a private key to use to authenticate with an HTTPS proxy.
     -+
     -+http.proxykeypass::
     -+	When communicating to the proxy using TLS (using an HTTPS proxy), use this
     -+	option along `http.proxykey` to indicate a password for the key.
     -+
     -+http.proxycainfo::
     -+	File containing the certificates to verify the proxy with when using an HTTPS
     -+	proxy.
     -+
     + http.proxySSLCert::
     + 	The pathname of a file that stores a client certificate to use to authenticate
     +-	with an HTTPS proxy.
     ++	with an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_CERT` environment
     ++	variable.
     + 
     + http.proxySSLKey::
     + 	The pathname of a file that stores a private key to use to authenticate with
     +-	an HTTPS proxy.
     ++	an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_KEY` environment
     ++	variable.
     + 
     + http.proxySSLCertPasswordProtected::
     + 	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
     + 	will prompt the user, possibly many times, if the certificate or private key
     +-	is encrypted.
     ++	is encrypted. Can be overriden by the `GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED`
     ++	environment variable.
     + 
     + http.proxySSLCAInfo::
     + 	Pathname to the file containing the certificate bundle that should be used to
     +-	verify the proxy with when using an HTTPS proxy.
     ++	verify the proxy with when using an HTTPS proxy. Can be overriden by the
     ++	`GIT_PROXY_SSL_CAINFO` environment variable.
     + 
       http.emptyAuth::
       	Attempt authentication without seeking a username or password.  This
     - 	can be used to attempt GSS-Negotiate authentication without specifying
     +
     + diff --git a/http.c b/http.c
     + --- a/http.c
     + +++ b/http.c
     +@@
     + 		max_requests = DEFAULT_MAX_REQUESTS;
     + #endif
     + 
     ++	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
     ++	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
     ++	set_from_env(&http_proxy_ssl_ca_info, "GIT_PROXY_SSL_CAINFO");
     ++
     ++	if (getenv("GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED"))
     ++		proxy_ssl_cert_password_required = 1;
     ++
     + 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
     + 		curl_ftp_no_epsv = 1;
     + 

-- 
gitgitgadget

Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF49C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34A024670
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 23:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3+nF2gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBZXYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:24:02 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42308 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 18:24:01 -0500
Received: by mail-wr1-f53.google.com with SMTP id p18so944647wre.9
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yeAO3Pezl7wJaafCCagdtVxtX7jhCEBujJPNywf2xGU=;
        b=a3+nF2gp0RLIBm45Y5+8hpybTnxFO8b7lzy8k5xYPBnAoz1K0jpDi2sHEbDLCzO55m
         cNN5VgLpwNl/EOl/qCvan6MCd+xKYI9MEk+w+YaViDWXZthHP+palvYpsIxX0IVyFBql
         jGg7/7pwksxWnFs5LV6hXjES24iTh3tG8F1yu/b7ulUtrDbNgIiY8Nr+KRYp92RIq1Bg
         zpD7nb1Qn4ECzhh8nkynnf7ztSm61ajVKbZwQLGc9Q7FeMGZollTaNb2Wd1VZMoyD0IX
         Hs/hbQYb0v/+2OnhHM4VCipt/4fVpw/UzNiorxkPqiE6UB2ATgmvjsKBBf0oZcirbq/d
         9JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yeAO3Pezl7wJaafCCagdtVxtX7jhCEBujJPNywf2xGU=;
        b=hRo9Zc9JXnlFxUAcRlgfSHv2hF66g7jyfqARcUezLLaviPpHkd2oBn08hLvUGfPR3K
         QI0dPn1H6+ygz3/4YrYD6Mzbl3IYhIC5QKZSgzO2BPPHC/exw+LjFK1/e3WLpY7CYqOv
         ZK0HVyRL/Ys5SRB9zZPFTCh55hYx99/dd20iU6qe6WU7ZjqEs/cYK9C/spqN9EC2FsqZ
         OzWbc2MW9vnlb2s8rBhT4fVvy0m9gvgNDe5U2r4KmBctoHEz9DPwdR2njX5K31F5LNU0
         u/q8MVZWzz+XHOaERJmooJX6PBClXBfNQ4mgvAe0yRcwvUuDPO5XTJaHJwO9dzxxZd9q
         psrg==
X-Gm-Message-State: APjAAAVHYAmIlmXo+OL9aNDKkGd5nqLfJnUg6Ikr7ToXhXZG4PAefGSI
        JjqRE1cThkVCAs2ja1Fek7ykCJP8
X-Google-Smtp-Source: APXvYqy3fQiNWujc2fuvz9rYtMXk0ATWKYH0fVzCXnW+M084QX9D60pUVjl3WbtdGK1V0s+k0HnKbg==
X-Received: by 2002:adf:ea91:: with SMTP id s17mr950454wrm.129.1582759439594;
        Wed, 26 Feb 2020 15:23:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm5072435wme.12.2020.02.26.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:23:58 -0800 (PST)
Message-Id: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.git.1582321003.gitgitgadget@gmail.com>
References: <pull.559.git.1582321003.gitgitgadget@gmail.com>
From:   "Jorge via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 23:23:56 +0000
Subject: [PATCH v2 0/2] Add HTTPS proxy SSL options (cert, key, cainfo)
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

Jorge Lopez Silva (2):
  http: add client cert for HTTPS proxies.
  config: documentation for HTTPS proxy client cert.

 Documentation/config/http.txt | 14 ++++++++++
 http.c                        | 48 +++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)


base-commit: 51ebf55b9309824346a6589c9f3b130c6f371b8f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-559%2Fjalopezsilva%2Fhttps_proxy_ssl_options-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-559/jalopezsilva/https_proxy_ssl_options-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/559

Range-diff vs v1:

 1:  3cf866d0384 ! 1:  a5d980e7501 http: add client cert for HTTPS proxies.
     @@ -27,7 +27,7 @@
      +#if LIBCURL_VERSION_NUM >= 0x073400
      +static const char *http_proxy_ssl_cert;
      +static const char *http_proxy_ssl_key;
     -+static const char *http_proxy_ssl_key_passwd;
     ++static const char *http_proxy_ssl_keypasswd;
      +#endif
      +static const char *http_proxy_ssl_ca_info;
      +
     @@ -46,7 +46,7 @@
      +		return git_config_string(&http_proxy_ssl_key, var, value);
      +
      +	if (!strcmp("http.proxykeypass", var))
     -+		return git_config_string(&http_proxy_ssl_key_passwd, var, value);
     ++		return git_config_string(&http_proxy_ssl_keypasswd, var, value);
      +
      +	if (!strcmp("http.proxycainfo", var))
      +		return git_config_string(&http_proxy_ssl_ca_info, var, value);
     @@ -77,23 +77,21 @@
       #endif
       #if LIBCURL_VERSION_NUM >= 0x073400
      -		else if (starts_with(curl_http_proxy, "https"))
     +-			curl_easy_setopt(result,
     +-				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
      +		else if (starts_with(curl_http_proxy, "https")) {
     - 			curl_easy_setopt(result,
     - 				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
     ++			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
      +
     -+			if (http_proxy_ssl_cert != NULL) {
     -+				curl_easy_setopt(result,
     -+					CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
     -+				}
     -+			if (http_proxy_ssl_key != NULL) {
     -+				curl_easy_setopt(result,
     -+					CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
     -+				}
     -+			if (http_proxy_ssl_key_passwd != NULL) {
     -+				curl_easy_setopt(result,
     -+					CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_key_passwd);
     -+				}
     -+			}
     ++			if (http_proxy_ssl_cert != NULL)
     ++				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
     ++
     ++			if (http_proxy_ssl_key != NULL)
     ++				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
     ++
     ++			if (http_proxy_ssl_keypasswd != NULL)
     ++				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, http_proxy_ssl_keypasswd);
     ++
     ++		}
       #endif
       		if (strstr(curl_http_proxy, "://"))
       			credential_from_url(&proxy_auth, curl_http_proxy);
 2:  583fdd0fe9b = 2:  c40207a3928 config: documentation for HTTPS proxy client cert.

-- 
gitgitgadget

Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A8FC3F2D7
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F058020866
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQcO1h9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgCDSkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:40:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgCDSkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 13:40:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so3733191wrw.5
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F3LuTOhW40GypCnHTEcYMCQNB8WAKbN9VOah4xuFBJ8=;
        b=DQcO1h9vlfY/1ydWJcnfmhmT+7/nf3HIBCzs/+JmkJoIKsawQ6PjlpgxDMseOCsX//
         Hqe140XureJyav2mjbZ6ONijo3dy4RIITj7e/YUdT9NEhICMsdyhzqr3rGgSKtkhT+OI
         Armq2ia3/Aer9Mpabg4GQ/SyIbTRWZFx3//J093JLzCZEW1/3vU50NZnCb55cX4B20WE
         nwctNm6A5RUy4vAWxrh5BcS09bG3e6AtIORJrZ85jLD54oJfyoo/JkVbcN9A73RwMn6+
         YsbDUWCaQ03UKCtYAiltDhtvepIqwF1KL0DwD+0ur/Q1y9aVtGMZEcipERo8WdsPtOd0
         XmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F3LuTOhW40GypCnHTEcYMCQNB8WAKbN9VOah4xuFBJ8=;
        b=NVd4JaQ8TF/SHXrx2aE8rOqU3sQpHx/Lig0iBOK7ki7cnepkj88xrKl8chlzTfzz/x
         t7bLLp0v9WL1rec1p6yevwJcIVLevCdqSAv1sDGC6BTHsRd/rpq3PziOkdTm8lq5/Utk
         PR4KomM0WnfJJazusGouP1B+AB7EavHW8LL9ijDTfkxEmoTs3rLaBhlKaIL2DGDDD4kA
         TUMkuaui8s7iZyh37cpHqrDEHWyh1t3DUiEphVkm2xKp9c5xwqT99SWw1LrYaGP49rDi
         3P4gVx+YbQ5sqzFfXPnCZ4URD5EFE+CZMmkpP6RS/MH14+JsWQBV8OKZ2rfOZG/jrbuB
         CeKw==
X-Gm-Message-State: ANhLgQ1uhUOhwviLKT+LV6wC1OcRFIYp0IPLtfoZpL1kq8u1hfrEUFIc
        H+V15oRobR0C8Vydi2yibwIXiEyS
X-Google-Smtp-Source: ADFU+vtSsD5X8sNlzKWlLEw96mw5LkMoHoL/oNGxAlY6jRrns+Cp51u81P+eRXM3YujnIiLcIi0bPg==
X-Received: by 2002:a5d:5012:: with SMTP id e18mr5584251wrt.419.1583347209221;
        Wed, 04 Mar 2020 10:40:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm5610581wme.2.2020.03.04.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:40:08 -0800 (PST)
Message-Id: <086c5e59fb2a94249fc42129222baf22d9f093b2.1583347206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.559.v3.git.1583347206.gitgitgadget@gmail.com>
References: <pull.559.v2.git.1582759438.gitgitgadget@gmail.com>
        <pull.559.v3.git.1583347206.gitgitgadget@gmail.com>
From:   "Jorge Lopez Silva via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 18:40:06 +0000
Subject: [PATCH v3 2/2] http: add environment variable for HTTPS proxy.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>,
        Jorge Lopez Silva <jalopezsilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jorge Lopez Silva <jalopezsilva@gmail.com>

This commit adds four environment variables that can be used to
configure the proxy cert, proxy ssl key, the proxy cert password
protected flag, and the CA info for the proxy.

Documentation for the options was also updated.

Signed-off-by: Jorge Lopez Silva <jalopezsilva@gmail.com>
---
 Documentation/config/http.txt | 12 ++++++++----
 http.c                        |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7d398f9afba..3968fbb697a 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -31,20 +31,24 @@ http.proxyAuthMethod::
 
 http.proxySSLCert::
 	The pathname of a file that stores a client certificate to use to authenticate
-	with an HTTPS proxy.
+	with an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_CERT` environment
+	variable.
 
 http.proxySSLKey::
 	The pathname of a file that stores a private key to use to authenticate with
-	an HTTPS proxy.
+	an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_KEY` environment
+	variable.
 
 http.proxySSLCertPasswordProtected::
 	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
 	will prompt the user, possibly many times, if the certificate or private key
-	is encrypted.
+	is encrypted. Can be overriden by the `GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED`
+	environment variable.
 
 http.proxySSLCAInfo::
 	Pathname to the file containing the certificate bundle that should be used to
-	verify the proxy with when using an HTTPS proxy.
+	verify the proxy with when using an HTTPS proxy. Can be overriden by the
+	`GIT_PROXY_SSL_CAINFO` environment variable.
 
 http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
diff --git a/http.c b/http.c
index 8d616b5d60e..4283be9479b 100644
--- a/http.c
+++ b/http.c
@@ -1211,6 +1211,13 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		max_requests = DEFAULT_MAX_REQUESTS;
 #endif
 
+	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
+	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
+	set_from_env(&http_proxy_ssl_ca_info, "GIT_PROXY_SSL_CAINFO");
+
+	if (getenv("GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED"))
+		proxy_ssl_cert_password_required = 1;
+
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;
 
-- 
gitgitgadget

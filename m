Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCFC761AF
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjCTP5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjCTP52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 11:57:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B13C7AB
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:48:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so10820146wrq.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679327331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94hDeh2dg66c2gKm3t2tnEcn2Xk/Y0DaR0mU9L6wdm8=;
        b=EBR80B1QAuW7D8C5IfBEIwU4D6m4Dp73l5i4C1E7bvv16UQFRVnfrjvdjNAkryMuLk
         cJf98CGhPuJ1yJ3RGE96AdAii3wxabbk/kkc9eDGfcLKMrUlZbOyIp6B7IDRK09YMwS7
         d73GIHAtLGOb+l9Wcq3nPrFABkXyajDhk21izbZkDcsun9k7ujPydx/AvsYcFjpV4VBE
         5crWOcnFET2hDIz5jileYpCKiYcQwqlrYZbNs7/PcDsyDqpAhlOR3NlxSHW8OyCuoSF3
         GPvSpUlzfZPsFznMcYmyYLYyCKFCOANztckQFU5Q4aeHjc4K0BFuYOYJL8Snha7ZJShh
         EhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94hDeh2dg66c2gKm3t2tnEcn2Xk/Y0DaR0mU9L6wdm8=;
        b=mXJX0eZV8yvwTPoY5m+X0IpWHUiSsGjTLGEw6Lib6fxG3Vpbz+vvFM/DIGzi8JoLQ1
         F6Y6AzsMd5DgXHV9MFEpALFFPQz+Cf2wK5jkGDrnsDGK4HMUjuL06vLvypLdYSmDA2OX
         HncWt7dMVkINeincNt7ugdmtf/5d9CZBBtDGd3mQHe8B+hIzbkEZfWzcFROD9v2FnfqA
         nuHmL//Kxw3YI0BlYjpS3GYe7xxIMXxXkOu1o05KSID0XesO/bNL+rJpGIZPNNYirhc9
         CyGgkzhyxtYOLEgy6V3k5GJCcG17iZ0VEv+8BOXK0CpOGK/0DDsJYZOAiokgGOGzVYIo
         /l6w==
X-Gm-Message-State: AO0yUKUdefNlLp+2GPEt7QPb7M+hNnTAS9hfAk7wmtyLWltU7Fs8nUTl
        45b1ykLH3F6olMY70sHZMwgdB5b5ISY=
X-Google-Smtp-Source: AK7set8kT8u9rzlYzHgBYNPhtJEwB2JbCwe7uDZ3omt1UAUokxxBGec5TMMcfyoa/LJzcqNNQPJL7Q==
X-Received: by 2002:a5d:50c3:0:b0:2d4:3f3b:cdb7 with SMTP id f3-20020a5d50c3000000b002d43f3bcdb7mr7072606wrt.67.1679327331002;
        Mon, 20 Mar 2023 08:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a056000011100b002d30fe0d2fcsm9201875wrx.13.2023.03.20.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:48:50 -0700 (PDT)
Message-Id: <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
In-Reply-To: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
From:   "Stanislav Malishevskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 15:48:49 +0000
Subject: [PATCH v2] http: add support for different sslcert and sslkey types.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>

Basically git work with default curl ssl type - PEM. But for support
eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
and as sslkey type. So there added additional options for http to make
that possible.

Signed-off-by: Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>
---
    http: add support for different sslcert and sslkey types.
    
    Basically git work with default curl ssl type - PEM. But for support
    eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
    and as sslkey type. So there added additional options for http to make
    that possible.
    
    Signed-off-by: Stanislav Malishevskiy stanislav.malishevskiy@gmail.com
    
    Changes since v1:
    
     * Fixed the commit message (found by Khalid Masum)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1474%2Fsmalishevskiy%2Fssl_types_support-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1474/smalishevskiy/ssl_types_support-v2
Pull-Request: https://github.com/git/git/pull/1474

Range-diff vs v1:

 1:  a4b2284dd36 ! 1:  899a0761d99 That change for support different sslcert and sslkey types.
     @@ Metadata
      Author: Stanislav Malishevskiy <s.malishevskiy@auriga.com>
      
       ## Commit message ##
     -    That change for support different sslcert and sslkey types.
     +    http: add support for different sslcert and sslkey types.
      
          Basically git work with default curl ssl type - PEM. But for support
          eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
     -    and as sslkey type. So there added additional options for http for make
     +    and as sslkey type. So there added additional options for http to make
          that possible.
      
     -    Signed-off-by: Stanislav Malishevskiy stanislav.malishevskiy@gmail.com
     +    Signed-off-by: Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>
      
       ## http.c ##
      @@ http.c: static int curl_ssl_verify = -1;


 http.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/http.c b/http.c
index dbe4d29ef7a..d5d82c5230f 100644
--- a/http.c
+++ b/http.c
@@ -40,6 +40,7 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *curl_http_version = NULL;
 static const char *ssl_cert;
+static const char *ssl_cert_type;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
 static struct {
@@ -59,6 +60,7 @@ static struct {
 #endif
 };
 static const char *ssl_key;
+static const char *ssl_key_type;
 static const char *ssl_capath;
 static const char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
@@ -374,8 +376,12 @@ static int http_options(const char *var, const char *value, void *cb)
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_pathname(&ssl_cert, var, value);
+	if (!strcmp("http.sslcerttype", var))
+		return git_config_string(&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
 		return git_config_pathname(&ssl_key, var, value);
+	if (!strcmp("http.sslkeytype", var))
+		return git_config_string(&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
@@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
 
 	if (ssl_cert)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
+	if (ssl_cert_type)
+		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_type);
 	if (has_cert_password())
 		curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
 	if (ssl_key)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+	if (ssl_key_type)
+		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_key_type);
 	if (ssl_capath)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
@@ -1252,7 +1262,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		curl_ssl_verify = 0;
 
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
+	set_from_env(&ssl_cert_type, "GIT_SSL_CERT_TYPE");
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
+	set_from_env(&ssl_key_type, "GIT_SSL_KEY_TYPE");
 	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
 	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
 

base-commit: 950264636c68591989456e3ba0a5442f93152c1a
-- 
gitgitgadget

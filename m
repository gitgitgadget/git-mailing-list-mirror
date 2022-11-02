Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF447C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKBWJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBWJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2D2BC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so244900wrh.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTgFRH8NvEuDL6qrOKVv8nBrf31Xj7wIMu+UBji2a3E=;
        b=m1ppMQni66EjR/OYmtFZWK+fz3jQR3D1OdPtNFYnDseg2t2T5v/pCOxLk7DaLD5Jes
         ApD0WOm6FQdMbMSLZqVJBsY0D5zprD1nr/W4PLnwn+KOm06ulDSUgDQ1NBvEGksAeY75
         E8thvPoaqYXoYM6t/S2Qf+8mJPgaOKR1h4/48NRoOg5cHSiKpj75HHCAoD0B5yDtAJJc
         h5xoEyroTsgRI2HVP+xhOjMUZsaohIt61O3HkxdaVk2AKCUhvrYJQ5AP4V8vlY0t8h+H
         KjJSn+VYwqU8WvOT2zPgiqmksE5iADFXNujMwuYdg/xRrV5emH81CqlOYjk7x5dpDWGz
         nKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTgFRH8NvEuDL6qrOKVv8nBrf31Xj7wIMu+UBji2a3E=;
        b=ck86UD780X0VyTkwpfjN/xo8BQIRZlNcrdKceovTCA3ES42MgoOpqKCObIK6KsjXFR
         YZwIGqwQYA2PSVHlEtrZBSy+hdRMhrN4256chvVsdiyzcGzhJjP9H5jCvO2fXFexqtg7
         EBIsO4ojnTZAXVPn44hcB4+ctYspkvjFU2Z+v/A4NKcvASi2g2R2wYw5NK73sEeQSF72
         QNIeaFexDOxeiHgtg54abV8+5ORaPRB/irObFUMYiYwB5GsDkv7ymUPcMxpUlyx8Nuh2
         XQEkh2P6pdVrKy9XMjNPMY7q8X+OtkypLPoNXsWSuyFoxRHAP4eMi2Yo+h2J6pSaOV58
         K99Q==
X-Gm-Message-State: ACrzQf37PSov7oFI1hTadxfcu0QAyMVDex/0E0VGxGP08P4uy1PJHVwy
        0QkLdvsrK66Yjp53NQ8BcbvJZuii2PY=
X-Google-Smtp-Source: AMsMyM72xeSmjPU/nb1K66wPPMsRkaf7Y+Vu6c3Tu5QsC8u2JXI70DK1u2UMzscZUkpQG7dkpW5FpQ==
X-Received: by 2002:adf:dd91:0:b0:236:a261:6930 with SMTP id x17-20020adfdd91000000b00236a2616930mr16349168wrl.551.1667426976689;
        Wed, 02 Nov 2022 15:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b002322bff5b3bsm5044477wru.54.2022.11.02.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:35 -0700 (PDT)
Message-Id: <4d75ca29cc5506031c003998b3d27709d0e541b9.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:22 +0000
Subject: [PATCH v3 04/11] http: move proactive auth to first slot creation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Rather than proactively seek credentials to authenticate a request at
`http_init()` time, do it when the first `active_request_slot` is
created.

Because credential helpers may modify the headers used for a request we
can only auth when a slot is created (when we can first start to gather
request headers).

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index f2ebb17c8c4..17b47195d22 100644
--- a/http.c
+++ b/http.c
@@ -515,18 +515,18 @@ static int curl_empty_auth_enabled(void)
 	return 0;
 }
 
-static void init_curl_http_auth(CURL *result)
+static void init_curl_http_auth(struct active_request_slot *slot)
 {
 	if (!http_auth.username || !*http_auth.username) {
 		if (curl_empty_auth_enabled())
-			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
+			curl_easy_setopt(slot->curl, CURLOPT_USERPWD, ":");
 		return;
 	}
 
 	credential_fill(&http_auth);
 
-	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
-	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
+	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
+	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
 }
 
 /* *var must be free-able */
@@ -901,9 +901,6 @@ static CURL *get_curl_handle(void)
 #endif
 	}
 
-	if (http_proactive_auth)
-		init_curl_http_auth(result);
-
 	if (getenv("GIT_SSL_VERSION"))
 		ssl_version = getenv("GIT_SSL_VERSION");
 	if (ssl_version && *ssl_version) {
@@ -1260,6 +1257,7 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
+	int proactive_auth = 0;
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1282,6 +1280,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 		slot = active_queue_head;
 		if (!slot) {
 			active_queue_head = newslot;
+
+			/* Auth first slot if asked for proactive auth */
+			proactive_auth = http_proactive_auth;
 		} else {
 			while (slot->next != NULL)
 				slot = slot->next;
@@ -1336,8 +1337,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-	if (http_auth.password || curl_empty_auth_enabled())
-		init_curl_http_auth(slot->curl);
+
+	if (http_auth.password || curl_empty_auth_enabled() || proactive_auth)
+		init_curl_http_auth(slot);
 
 	return slot;
 }
-- 
gitgitgadget


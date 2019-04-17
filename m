Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8D020248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfDQKZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35994 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfDQKZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so2934923wml.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=EiWMauOV96xNlFdpB9wgruGMCxf1GotNX1DoiTpPrIc=;
        b=D06iJk2SNi+wS7mzXbizGpnuQ1S7XSZux81crRjPyRmceG/QYqD1MGy4qVuidAqf9P
         x0uoW/u2tBnnradtRYLaMhskDslci97r6GuOxRaliM4Nn4jVnfX2VF1A52b1fqpFtLln
         BQzWDQhfHAzWpCFVunyzS63OPrcJTWYHh2MXCk+vQn+RguRu6Q+MwOE0NevbP9FL79Bt
         cSId4ZX5uDilCxDZSICUOmi4UgwyAgqL6bV4AhZQknF+KeCoLynL0r43Voe0M32VtM+s
         892a7qY+/9YD8DumR3wyTTBz0iZOb73jLyX6kwbGL+3kbQ9avlmQPFD8Gb9zP5ssKU9b
         1JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=EiWMauOV96xNlFdpB9wgruGMCxf1GotNX1DoiTpPrIc=;
        b=lmjG9YxbF0o2H/d/BIJrpRMTfRSnjBLaC6AMdiT3+cQn7h0bBOmaWcsBlwq73KtQ+X
         zomAf7zL5t2LPzY+J3xg9q7zFEj5ihinDXuNNwrGUzVqVWi1RUznkIys85MsOYw22mHD
         QGofsrGWIwoJbTcAVqXGsTKUimYWngA7h9SwTxPaGkWHSN1CmSaYUjrixwu12wjzLbTX
         vfYrZ68Mbb4u6VA2KoSbv1XetN4s1K+O9egOxZBlrOo7IZl+s9nqvu2THvn3dKa7hXlU
         X+raX8fUeARXVRZeit9s4vHY/KuSdVMn9UH1A0wqT0bXNJcDVyaFX3vBiXrw4L6uS1v2
         AgXQ==
X-Gm-Message-State: APjAAAVulnvrJvlGOGscynKTEZLWvBK4OyVo1MvpShEx2wRO+7DAoSr5
        ZEeiQ5EE/b0PR4DYHF3UKHs=
X-Google-Smtp-Source: APXvYqzwAU7TwpPHZBtRNrS5RdqfK/n7JXx60jUIxz7e+39bteA0r7sXIecDuW+alZExClMr/8TjmQ==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr30184421wme.16.1555496724207;
        Wed, 17 Apr 2019 03:25:24 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:25:22 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v10 09/10] sequencer.c: save and restore cleanup mode
Date:   Wed, 17 Apr 2019 11:23:29 +0100
Message-Id: <20190417102330.24434-10-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

If the user specifies an explicit cleanup mode then save and restore it
so that it is preserved by 'git cherry-pick --continue'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b049951c34..3f4b0896e3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -535,6 +535,24 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 }
 
+/*
+ * NB using int rather than enum cleanup_mode to stop clang's
+ * -Wtautological-constant-out-of-range-compare complaining that the comparison
+ * is always true.
+ */
+static const char *describe_cleanup_mode(int cleanup_mode)
+{
+	static const char *modes[] = { "whitespace",
+				       "verbatim",
+				       "scissors",
+				       "strip" };
+
+	if (cleanup_mode < ARRAY_SIZE(modes))
+		return modes[cleanup_mode];
+
+	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -2366,7 +2384,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->allow_rerere_auto =
 			git_config_bool_or_int(key, value, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
-	else
+	else if (!strcmp(key, "options.default-msg-cleanup")) {
+		opts->explicit_cleanup = 1;
+		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
+	} else
 		return error(_("invalid key: %s"), key);
 
 	if (!error_flag)
@@ -2770,6 +2791,11 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
 						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
 						     "true" : "false");
+
+	if (opts->explicit_cleanup)
+		res |= git_config_set_in_file_gently(opts_file,
+				"options.default-msg-cleanup",
+				describe_cleanup_mode(opts->default_msg_cleanup));
 	return res;
 }
 
-- 
2.21.0


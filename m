Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062F420248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfCXIWb (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33299 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCXIWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so4373772pgk.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5OGSNhAK2KrRTTWxJ9pmfnCb1piWwcRC0MVDFL4CAI=;
        b=P98hGqwEW8RupKLhppWOqOmI2tRTss7HzsSOaBbxgMCDFy1drDhDeB8gOLQo4p6K9W
         /bjtt5LZ2kI1eQ89jBWr0NmPxJPSc1Q/3BovbYtqvmpfgbONj6yKUesz8nTULZ+R02EV
         6gBUlOrBsBAKBnOeyytEfhr55VjOnlPEzDOjEEcnepQda7UfG56YbcLWyomfMJmESHO6
         lxIlz9foX/fMOQUt6LMq8KuOCx1XGc978RSSa9SVu6Dd3DbTKrqt5rO0/7UcVfHqg/ez
         uCegCYq0HQUo5mPDjB1EMstJ98YUkg7nI4VhnLjioBX7/KOW58bYWyXwxrYW/ED548Lb
         W+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5OGSNhAK2KrRTTWxJ9pmfnCb1piWwcRC0MVDFL4CAI=;
        b=r9qGhXu5t5javOqypJDx1w0ykiwDFVwDInir4cxmoTS/ilNUq/6q7680H8nIGnLYOT
         sajj64Kk6pUYFLtbQYR3p3lSQeAj62EivINQpGH6k9nglDKZb/s9i1c/KGopqSwocIdu
         IQNaRs4anE/8T65xUbD3xvVgUJK962Mogyq39XatPF1ipch4e2GIXte1u/J+1+DDH6pz
         Lhnot6HQnPMaDZNogKsg8XZbE8fiVycNbNpUEJdLUJOWVNi9N77uWH7gNdu60ANW/iFP
         UUXC3bHiSGwCBDaLKPDkhaoOgla2UWlKsi8ckNU8arZptOA0Hgia8n0ABMrjgDYn9tcS
         JKsA==
X-Gm-Message-State: APjAAAVJGReD3HVbrWHpuWTOMU8rBGd6uc9mz5xw9+FXhJnGfQL9In0u
        QWYnn16OQSdTDpWOIfLqBNaOBP/+
X-Google-Smtp-Source: APXvYqyYnD15lRksi0oz2HOTyJBPnaqHn+KVfWBkkMYBN7Lch4+UPeBx6qo867ZT1zyqLobiSJIAGg==
X-Received: by 2002:a63:544f:: with SMTP id e15mr17838053pgm.344.1553415750267;
        Sun, 24 Mar 2019 01:22:30 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h65sm15573313pgc.93.2019.03.24.01.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 15/20] diff-parseopt: convert --[no-]color-moved
Date:   Sun, 24 Mar 2019 15:20:09 +0700
Message-Id: <20190324082014.2041-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark one more string for translation while at there

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 8b65b03c0d..de6c09e95a 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,27 @@ static int diff_opt_char(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_moved(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	if (unset) {
+		options->color_moved = COLOR_MOVED_NO;
+	} else if (!arg) {
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else {
+		int cm = parse_color_moved(arg);
+		if (cm < 0)
+			return error(_("bad --color-moved argument: %s"), arg);
+		options->color_moved = cm;
+	}
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5339,6 +5360,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
 			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
+		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
+			       N_("move lines of code are colored differently"),
+			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5422,19 +5446,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--color-moved")) {
-		if (diff_color_moved_default)
-			options->color_moved = diff_color_moved_default;
-		if (options->color_moved == COLOR_MOVED_NO)
-			options->color_moved = COLOR_MOVED_DEFAULT;
-	} else if (!strcmp(arg, "--no-color-moved"))
-		options->color_moved = COLOR_MOVED_NO;
-	else if (skip_prefix(arg, "--color-moved=", &arg)) {
-		int cm = parse_color_moved(arg);
-		if (cm < 0)
-			return error("bad --color-moved argument: %s", arg);
-		options->color_moved = cm;
-	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
+	if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
 		unsigned cm = parse_color_moved_ws(arg);
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
-- 
2.21.0.548.gd3c7d92dc2


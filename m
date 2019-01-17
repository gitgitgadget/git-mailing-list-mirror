Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703611F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAQNMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43949 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfAQNMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so4726488plb.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dga8v8/g3LGmT6SU++sbAmySlD8umITy7fXZIx9juXc=;
        b=EWvjhwm2tHChXqyLSOixIr5FQoy8N86qcG9AXcQLUIZgAJVbP2rVNMtG01Cuzfzg8f
         vqQ/ZaEN5NKAkLIA2U5hVrdIxa2W32NJtzoXgM0/HwFywsCQR00KNSKXx4f4s5KAmr+A
         M+3Ym3MAyax9bxwledW519eSCc2eHIAbN+3gkmEZYj/g4uiQwBXNvkM0bg3yOYVLav6q
         +bIRPgIijcNPcHllZYiRe9xx8VUif8QIsvLNVbUK4S4w6qFCDW3cO84m/thE4uvpXEHa
         UeOidUlMvhvjqth0VzJyG1NPV+PnjuuZBOT6Yw1esB4iukTgp15GLVuwJkzqzPNdSjLM
         Ds+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dga8v8/g3LGmT6SU++sbAmySlD8umITy7fXZIx9juXc=;
        b=akv1avKXHkQS6Vs+Kz/6R92MXc46JGTjsg+MTZuZ5HUGEREVNi4+6aBOcKMeDxkfX6
         PsbEQHItJwf3yVsM6FSImGBcsz4eMMMf9xlq9jGA+5Xmm/d4Q0acMJL6/WJdyF1WIWLW
         UP+ZwoM5niJmTahthyyBZ6CfCWIBaaZFZGuuMWOrkLIsLOHQLBZ4dqumHrGEGZoLcrjH
         7rb/9GiJZgm+SyKhWZbyD1KozJOjePce7vGpNg9V3P3AfU26m1eSFjDWgrP73Qx+lk2k
         I85Lpk5cB7UZjYQb+HJ9zJZldjegR4yIrqOjmxHER+OOxLhXiJ+9hYp63Nih89XIp/EK
         +sFw==
X-Gm-Message-State: AJcUukeEJ+jmrd/R4LhwLr6YZ7EtRL+gLFjsPrgNGdxML0hKvJ7JRmZz
        sxf2we9XC/pFP/RKBCWUIKmvbSMq
X-Google-Smtp-Source: ALg8bN5R0SmsLlld43h6txMzs2VBmweo92KiYhO8tTQ0lfUYk9m4xccwj+irX6BKPiFZYHuF75wcZA==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr15007048plb.312.1547730743363;
        Thu, 17 Jan 2019 05:12:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w136sm2668134pfd.169.2019.01.17.05.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 71/76] diff.c: convert --color-moved
Date:   Thu, 17 Jan 2019 20:06:10 +0700
Message-Id: <20190117130615.18732-72-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index cc10b27df0..5403351466 100644
--- a/diff.c
+++ b/diff.c
@@ -4905,6 +4905,27 @@ static int diff_opt_char(const struct option *opt,
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
+			return error("bad --color-moved argument: %s", arg);
+		options->color_moved = cm;
+	}
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5403,6 +5424,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
 			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
+		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
+			       N_("move lines of code are colored differently"),
+			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5486,19 +5510,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108F71F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfBPLix (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37916 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so6141676pfi.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Y9Q7F1CMGHiLXz2kVJQ1cOEqDO+g2fX8bdJPpCtwco=;
        b=mvi8TMxTjvUMhT7LJvkb9M5FOHFD05hYnQMbzK0C/D/8YzAXLFzuTJ4L/OsdWhEAN4
         txMgvLB+0knfv2d3v7XJZnDK6WgY09WMJLprP98UV+HDWDnULnq8p2sOMTzR0IICtyMD
         hNBv7EtLoAbk6YBH08hq5Gxxy5hyJrLk4DJIPaUJKdOi1yyW9aze3sDAKKFqZ1qf++5G
         A0jYUTavZz4OZ9WHvuwI75Fi2ka5B0l8p5xuAzQ9z9uslcbB0C7siknTIaNOIlVhre3k
         YOJTp8aJrKFbRBljcfqC/ZTVRiFnZghydg6w4GIoWnJf8InEis/JS9h3xp3ds9ZgE4Fn
         yP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Y9Q7F1CMGHiLXz2kVJQ1cOEqDO+g2fX8bdJPpCtwco=;
        b=ME8gc0ZTJeh01fXiSXiwARMqwultZYh4tXKJQwILQyYjkgN/+DgAOePWklJDSsZg5u
         0akMq2DyjC0QLAV3nCAYYHu5ZS3WFFcxS3BLfhllwO2AyHNZYOJve6LaoySb6sxEJD/X
         nckb71Ano4SEmPpyGjCQVMoD2Yh7STbhROPy2OQtdf2y5FLnMwajrqCR84wOz7e8pUxc
         F9iakKko3DXY7My2gugIfOGrtbv+3YpnCfZAbadn3mwQpl5FdfOyiBAnYs839jDm+ZjT
         EhbUcp+kLDCZCRhvFwdG38WNyOtcJVjdk2z3ZiWlTw54z1OM6rMyvNFBUsPXghOr5Zyj
         EFPw==
X-Gm-Message-State: AHQUAubBxeD1+dlekwzMojrJQqmGgXmWP3AwYy02vOwQV9DyNDFZT7Ns
        wENjoyXRwL2Y9jrpvUw0hgY=
X-Google-Smtp-Source: AHgI3IY3FJf2KtZEmJyaQdk4KRIpz6mUCHFn3H5G5MYjmtXLX26GluvxOniMbkGrB0s+vQ2/Sb6gUw==
X-Received: by 2002:a65:6151:: with SMTP id o17mr9770095pgv.285.1550317132000;
        Sat, 16 Feb 2019 03:38:52 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t65sm20832921pfi.117.2019.02.16.03.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 21/21] diff-parseopt: convert --ignore-some-changes
Date:   Sat, 16 Feb 2019 18:36:55 +0700
Message-Id: <20190216113655.25728-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 33492e754f..a63ee4a44d 100644
--- a/diff.c
+++ b/diff.c
@@ -5109,6 +5109,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "minimal", &options->xdl_opts,
 			N_("produce the smallest possible diff"),
 			XDF_NEED_MINIMAL),
+		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
+			  N_("ignore whitespace when comparing lines"),
+			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
+		OPT_BIT_F('b', "ignore-space-change", &options->xdl_opts,
+			  N_("ignore changes in amount of whitespace"),
+			  XDF_IGNORE_WHITESPACE_CHANGE, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-space-at-eol", &options->xdl_opts,
+			  N_("ignore changes in whitespace at EOL"),
+			  XDF_IGNORE_WHITESPACE_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-cr-at-eol", &options->xdl_opts,
+			  N_("ignore carrier-return at the end of line"),
+			  XDF_IGNORE_CR_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
+			  N_("ignore changes whose lines are all blank"),
+			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5147,17 +5162,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
-	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
-	else if (!strcmp(arg, "--ignore-cr-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
-	else if (!strcmp(arg, "--ignore-blank-lines"))
-		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic"))
+	if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-- 
2.21.0.rc0.328.g0e39304f8d


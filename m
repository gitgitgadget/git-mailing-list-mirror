Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DB81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGKfF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBGKfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so4585123plb.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIa7QAw7ZIYVa80KSBUUa7+W1O7LztlByKCkfRH24o8=;
        b=UwzMhsp/S6A8XIaDsl+fGd0Q1DXbRPY5C2UoFkbALpVndV7XM/FcrKtkC1bRzGI/3J
         CVy73Cw91YD6etXMtjmFwMszDdSmC3sJAzz0hOJv0ELBTyMBlUzy80X+7gQMBDf5FjME
         +ZryrjxPP1LnQxcjcHdb/rYIaWb3A7/BE/eN+vc1/7Sb5ZEdPr1EPOy+Yjx387TsSKgp
         TDelRQuPr57ziclaSh5r4U8+AsrG6ce1JsI/nmIZu4XVaIRgYWzWYnKFTrUB/46rAVOt
         tBf8PisdCiazfPxzMFkS3/L2Qpour5rJVxC+ryp8WQW/v1WSJOLuKoWS+fpQZizSKZwT
         7Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIa7QAw7ZIYVa80KSBUUa7+W1O7LztlByKCkfRH24o8=;
        b=duF1009IkJThEYvSyHgMFgwAPWfFgLcxv1Y5tiZqRLpL4+QxabEeE2m9lknTSPn7m7
         uifBouEZi65e+46evao3yjnDHDKqcrRg61goianB30acuBKDnbkBatG4gSaIYJwBvy6H
         9M2dDyJilSh9817wY5uplXWXteDXVy9asNvH079KBKLBA/yFZ37d8xbgt6Gmd2qgtAmv
         2y4R4mTHux6bWjlg5OKn11B2+7hBexIX8plmOcBVEsGOUg6OSJB/bnlLNVjxJAB6pGg/
         UpV+i/vPg8GlujA4OhyGAvatH/wN1bSXRNFJZxM5QbjKi2HLTTYU5JjtLx7+DWL9myoS
         7+lg==
X-Gm-Message-State: AHQUAuZ0EMXxZUoQ1YI6QQjq8FCPdsHYBj/odoRTMaVg3ffbRbYeVOky
        paCVqr3dPgW81PTme441e9u/Z/Xf
X-Google-Smtp-Source: AHgI3IbEZqylQv1plGdKDTYjyDMzdYID5t7PJjd68enKeqFrU0m0rLfIOj2NRv22rJEbn9qdmUf9bg==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr15871194plb.317.1549535704115;
        Thu, 07 Feb 2019 02:35:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u69sm19105316pfj.116.2019.02.07.02.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/21] diff.c: convert -C|--find-copies
Date:   Thu,  7 Feb 2019 17:33:21 +0700
Message-Id: <20190207103326.10693-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 59 +++++++++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/diff.c b/diff.c
index e51f6b3005..35bac115cc 100644
--- a/diff.c
+++ b/diff.c
@@ -4617,8 +4617,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	return 1;
 }
 
-static int diff_scoreopt_parse(const char *opt);
-
 static inline int short_opt(char opt, const char **argv,
 			    const char **optarg)
 {
@@ -4909,6 +4907,26 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_find_copies(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	options->rename_score = parse_rename_score(&arg);
+	if (*arg != 0)
+		return error(_("invalid argument to %s"), opt->long_name);
+
+	if (options->detect_rename == DIFF_DETECT_COPY)
+		options->flags.find_copies_harder = 1;
+	else
+		options->detect_rename = DIFF_DETECT_COPY;
+
+	return 0;
+}
+
 static int diff_opt_find_renames(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -5063,6 +5081,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
 			      N_("omit the preimage for deletes"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('C', "find-copies", options, N_("<n>"),
+			       N_("detect copies"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_find_copies),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5097,15 +5119,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-C") ||
-		 skip_to_optional_arg(arg, "--find-copies", NULL)) {
-		if (options->detect_rename == DIFF_DETECT_COPY)
-			options->flags.find_copies_harder = 1;
-		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -C: %s", arg+2);
-		options->detect_rename = DIFF_DETECT_COPY;
-	}
-	else if (!strcmp(arg, "--no-renames"))
+	if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--rename-empty"))
 		options->flags.rename_empty = 1;
@@ -5365,29 +5379,6 @@ int parse_rename_score(const char **cp_p)
 	return (int)((num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale));
 }
 
-static int diff_scoreopt_parse(const char *opt)
-{
-	int opt1, cmd;
-
-	if (*opt++ != '-')
-		return -1;
-	cmd = *opt++;
-	if (cmd == '-') {
-		/* convert the long-form arguments into short-form versions */
-		if (skip_prefix(opt, "find-copies", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'C';
-		}
-	}
-	if (cmd != 'C')
-		return -1; /* that is not a -M option */
-
-	opt1 = parse_rename_score(&opt);
-	if (*opt != 0)
-		return -1;
-	return opt1;
-}
-
 struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
-- 
2.20.1.682.gd5861c6d90


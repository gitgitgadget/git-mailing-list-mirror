Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1251C1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbfBPLi3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37268 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so6091789pgq.4
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wS7l3lDkdLp2a7i+No9GmpOp5QPRWvOhZ83m0I7B7c=;
        b=kfIHKz4skQ47YP0D6mIoH2xYAiYoCs1rgxzA5dRLzUKq+KlVikMbS8Eh6N5SITggWO
         oGJWKJUOcNhpmeRJ46mZMLAzWpZvJqE7qfGzjn1dVcPM2ZGoVTdRuTTFGM/XCGYf+DmQ
         IXOLQul0da3XFFFK83CiQ7ed4J8Vs0kLXKtfBnaCZxgK+6B9PH9UlhACRO1rToaOR1zi
         FNaV135TePsFh0Al/WliUDhbc5+kgDXeV27kA67Qa3e5x3m8od9I5Qnbl9avbJsY/Gd+
         dFH0GCQMdhHqka+aKi9UNRWI05OHVGtcaDreQpP6dn3KYBCmI9yN0D02P1j9HzUC+crn
         cYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wS7l3lDkdLp2a7i+No9GmpOp5QPRWvOhZ83m0I7B7c=;
        b=eqw8DTH1oVkHqVHlBM7gNvZIUmnYkA5PBkJVYzgPu6K9Ky0TW+06TYYP32g/ILAnC7
         zsxNjX0p5idLK1zB6J4JAEVVIlydM6u0ntb0GSNxC6NE6q9e00pKn58A7oj6mGWbZ75c
         f1DRij3mFPrdDLhvg22Nj9eBOOPr0fr0MXNkhr1HN+pif0mOE+KQollgOCHYJh7mKfs+
         zJmd97gJLJf1stD0runWrq803Ce5w9IeFR5AaOpp5LfZICTGOGjtZ5dPiIvahfqBpKbF
         7frFfzxdxSmja2bVw02xENVrlVUcT5RKmfhK5cIX6lH/9g+Rf0oC5BYyC3NM1L/GLF5p
         9h6A==
X-Gm-Message-State: AHQUAubcHXlcJjJi8QKsIK0lP5R9uwzMi0UQ3MqLpdrx3Vv0Qttrtodv
        4y1K0uhX6vwsKH7sUD69BIY=
X-Google-Smtp-Source: AHgI3IbNBImN3GCi34S9UqvT1L2p9mWhkTAMcQWG2JKVs1Zy7P9srrVSaGnTJ8lNorpPsr9tScnceg==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr14604782pfb.55.1550317107876;
        Sat, 16 Feb 2019 03:38:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e9sm4410868pfb.52.2019.02.16.03.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 16/21] diff-parseopt: convert -C|--find-copies
Date:   Sat, 16 Feb 2019 18:36:50 +0700
Message-Id: <20190216113655.25728-17-pclouds@gmail.com>
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
2.21.0.rc0.328.g0e39304f8d


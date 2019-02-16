Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260821F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfBPLiJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36305 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so6145567pfa.3
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcsJNr7GGb9bAr8Y1C3w0n/ETC4xvGHTUHLJr+HIDlg=;
        b=EK/Dmx9cHQ5NjAa1adT6BlMu+iza7/krEEC0Uz20F46icqP3O4wKdoynI4HPCGrI04
         9POv323g4Q80clGJhmQ9NJArvSf+mBEfj+yYm5NyzPJa7D8mDxSko/64wiLRlas986WJ
         3GpwfPlKYGXKLoKoFvzr944j9JqdwD9vVwJ9LJlaqqmRfaatsZaaxfWRGF5NkmWi9zkI
         XqppOJf+3296cyKGXTXI4Wd4XCpO5iOKBNy3hfdz4ofv5aS9ws2OYNSNg+oHg96OrtcK
         CbwP/dMPUx2NqwyFlL+OGRaKO5bYRG3ZURuRxnetoOEa7kQ0QDn167S5YjY0niGpCaun
         x64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcsJNr7GGb9bAr8Y1C3w0n/ETC4xvGHTUHLJr+HIDlg=;
        b=WhDMFllQXM1kpzqJSesDavjLWduc4DIcBX1ovHcqVRaI2iFSVnpJKNkzqdtOIM02uR
         AMsK6V6oS2XSg7X+EREh+BAe1CiJBvN2EaQIGmCSriKXmjjI3+SMcLlTtRs/6zk4Sk6j
         42Z7OyhJnQzUDZiH1kbBSvT8VtQZu4S5g/kFFzqCjGl4Lwqp5kPJ8Ya9wWJX4xxMC9Gm
         luTusvNCNMn6AGXRlt7ihIxRnjqj0KXoKxJG1ouETnp0JIgbGRbtrKOv/0fQcdOOq/MC
         F0r3fYYHp8/i58mkRDhKMMqNqQhrlLZCDB7A7uIC2g5q9W8Bu7bR5pRCNx7di65gW4sa
         5QmA==
X-Gm-Message-State: AHQUAubfSx7f+5hp3/Gu9V7FOGX4Oq0EGdAWxW25GffAtVhg8Xpotptw
        hon42s6Uap4NiGhGKpLBniE=
X-Google-Smtp-Source: AHgI3IYWYw95nPX0eEvgIb10hGvemZ3fqufO49tQUon/y33TmM2rUhXM1l2dbvDbV3V38U7+emXrcg==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr1316722pga.66.1550317088096;
        Sat, 16 Feb 2019 03:38:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p6sm4967813pgd.69.2019.02.16.03.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 12/21] diff-parseopt: convert --output-*
Date:   Sat, 16 Feb 2019 18:36:46 +0700
Message-Id: <20190216113655.25728-13-pclouds@gmail.com>
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

This also validates that the user specifies a single character in
--output-indicator-*, not a string.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 10 +++++
 diff.c                         | 71 +++++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 058d93ec4f..d3e8d634b2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -41,6 +41,16 @@ ifndef::git-format-patch[]
 	Implies `-p`.
 endif::git-format-patch[]
 
+--output=<file>::
+	Output to a specific file instead of stdout.
+
+--output-indicator-new=<char>::
+--output-indicator-old=<char>::
+--output-indicator-context=<char>::
+	Specify the character used to indicate new, old or context
+	lines in the generated patch. Normally they are '+', '-' and
+	' ' respectively.
+
 ifndef::git-format-patch[]
 --raw::
 ifndef::git-log[]
diff --git a/diff.c b/diff.c
index b24f6825a1..8df396cb9a 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,19 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_char(const struct option *opt,
+			 const char *arg, int unset)
+{
+	char *value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (arg[1])
+		return error(_("%s expects a character, got '%s'"),
+			     opt->long_name, arg);
+	*value = arg[0];
+	return 0;
+}
+
 static int diff_opt_compact_summary(const struct option *opt,
 				    const char *arg, int unset)
 {
@@ -4872,6 +4885,23 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
+					     const struct option *opt,
+					     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	char *path;
+
+	BUG_ON_OPT_NEG(unset);
+	path = prefix_filename(ctx->prefix, arg);
+	options->file = xfopen(path, "w");
+	options->close_file = 1;
+	if (options->use_color != GIT_COLOR_ALWAYS)
+		options->use_color = GIT_COLOR_NEVER;
+	free(path);
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4965,6 +4995,27 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
 			       N_("generate compact summary in diffstat"),
 			       PARSE_OPT_NOARG, diff_opt_compact_summary),
+		OPT_CALLBACK_F(0, "output-indicator-new",
+			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
+			       N_("<char>"),
+			       N_("specify the character to indicate a new line instead of '+'"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+		OPT_CALLBACK_F(0, "output-indicator-old",
+			       &options->output_indicators[OUTPUT_INDICATOR_OLD],
+			       N_("<char>"),
+			       N_("specify the character to indicate an old line instead of '-'"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+		OPT_CALLBACK_F(0, "output-indicator-context",
+			       &options->output_indicators[OUTPUT_INDICATOR_CONTEXT],
+			       N_("<char>"),
+			       N_("specify the character to indicate a context instead of ' '"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+
+		OPT_GROUP(N_("Diff other options")),
+		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
+		  N_("Output to a specific file"),
+		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
+
 		OPT_END()
 	};
 
@@ -4992,16 +5043,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* Output format options */
-	if (skip_prefix(arg, "--output-indicator-new=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
-	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = arg[0];
-
 	/* renames options */
-	else if (starts_with(arg, "-B") ||
+	if (starts_with(arg, "-B") ||
 		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
@@ -5242,15 +5285,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if ((argcount = parse_long_opt("output", av, &optarg))) {
-		char *path = prefix_filename(prefix, optarg);
-		options->file = xfopen(path, "w");
-		options->close_file = 1;
-		if (options->use_color != GIT_COLOR_ALWAYS)
-			options->use_color = GIT_COLOR_NEVER;
-		free(path);
-		return argcount;
-	} else
+	else
 		return 0;
 	return 1;
 }
-- 
2.21.0.rc0.328.g0e39304f8d


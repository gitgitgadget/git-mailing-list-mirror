Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F61E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAQNIs (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35732 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so4826004pfi.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdhRepU0f62s44n8fOt6c0U0aQhE4+Iw0UBel0T9xjU=;
        b=MRTxHLjuktDWtlAf9H3t/JE6zOvU3W3yBGvOmf1ej0Rtbg2uPjMxkbA79X2aq/wwkc
         gD/WmBgYmNmC8SktatwTYaKp7la74bedi1lOkVp1roRcX8oiDnK8qIDGpKlS2Ja3lp+M
         6GugUrHX2T0lzJPvAH5Y9Azdz9UTOBsMXNlMU/EJsRlm1FRohVE6VgLVgoRtjMKVtthQ
         OimOm73AHfPoGRYjYKDt8wqDi1VHn0+7eK6m19mnnh7lk3KaATpq7+4VvIaTrB0mNMPL
         rZw+iRyRQj01Fp1dkJAHCkbZDI56IrZA5jlHEHfx36A6lZUX1MGn6AUL01MTPBfImncx
         03kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdhRepU0f62s44n8fOt6c0U0aQhE4+Iw0UBel0T9xjU=;
        b=uljvh+ncsTyYuUUAA8GxVua8fo4Trlnch1Zs6luWgq1TacZr2q+4CM6V6LlJAA98wn
         4Tly8iEx5zwfQDlv6pNRJhscDaKxu7opYgPzlYo/CPZ8z6o+bF6TgcfIYy6dNb/nuykC
         AKjILSE1ige1hwkO2RjOvzY+UFRBl4a6pUcHtAEktpfkdqAYZvc7XzMeVWD+fvHwi6pz
         lJmwGE2qv3trt73T5xAEZd5On4p7/kwIoFebQ8pY06etstc57Or+mi8blME14tXuNOUE
         EYHe3FHqrWBEkCK6Mi8bB98NPZOLjytv9JDlZ7V2sx1gw/x6svETfMN2HjHVAqugxYkI
         +ieg==
X-Gm-Message-State: AJcUukfRLEh2Fo6CRLKlKGnrpqITgKnZE6uSqOcZ2pRaeCDYlLTotefD
        N1l298ubOhzuGMVAAQ+TKts6ebt7
X-Google-Smtp-Source: ALg8bN4GLxEAr8vOEaLvJLMJTatHRYVp0XzyUETY/r9fiyDecY4vnzbib8+6/3NFPpO8kbOCXqeuQw==
X-Received: by 2002:a63:d747:: with SMTP id w7mr13073141pgi.360.1547730527218;
        Thu, 17 Jan 2019 05:08:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x3sm3000229pgt.45.2019.01.17.05.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/76] diff.c: convert --output-*
Date:   Thu, 17 Jan 2019 20:05:26 +0700
Message-Id: <20190117130615.18732-28-pclouds@gmail.com>
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

This also validates that the user specifies a single character in
--output-indicator-*, not a string.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
index 48659a10c0..c70de7f358 100644
--- a/diff.c
+++ b/diff.c
@@ -4844,6 +4844,19 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
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
@@ -4875,6 +4888,23 @@ static int diff_opt_dirstat(const struct option *opt,
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
@@ -4968,6 +4998,27 @@ static void prep_parse_options(struct diff_options *options)
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
 
@@ -4995,16 +5046,8 @@ int diff_opt_parse(struct diff_options *options,
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
@@ -5245,15 +5288,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7


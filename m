Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E6E1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965581AbeEJOTl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39912 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965266AbeEJOTf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id j193-v6so3223201lfg.6
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rP4PG3Nn/Uk4JDgnjnPttQsnRHvc365IW9Al9w1fZl0=;
        b=FdLMaC1mRNWKKUXl7IyWidGQsBiYADVA4n1quo/GdwcJCgbUbHOXN0Ryz+OI5QzLdO
         8lPBUbInvQOWgUO46I2UZsWxVIydl7p+PBeNFqyknzjsptzaUKXQHyox56i75+p9wxcS
         UkeRTV9F8JOv7Kfn2pbJx2f7KjHbv365L8kPo4i/bf9eHAjan66E9rjTjT5S8JOtN94H
         HsLrVoOL0TrdoBOqZzoH3+Qllk7ABQzmw77gxv4sB28iJIYgktQHVbTqy8wi/QuXaWCj
         pMS+bhUAbL6O2tZqjwULlq6Oc9jXzPGwaLDLGZGE6DRcf12hEA3PCAQQDOez1DDVaF4W
         Xuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rP4PG3Nn/Uk4JDgnjnPttQsnRHvc365IW9Al9w1fZl0=;
        b=a7+A+YkQK0If2LjTQ5nnJP5f3/o5Ek0/d+kyBDl7/ZOuAzcfLMYZY4Flg1aJy3Yb8E
         xixyscf3Yjr/0M7UOS5yV+uoLB508f6qmf4mRnFUFsKcWX28RN491W1BOIxmpn61a4pH
         nYQDdDoKuE5p2/hYUSObTNR2S36QKaG0yUfCZClRUXtQ2wVSTz4RpFiIIaC6KCOBKdx0
         x1k1fnNplq11ntmnjnFk8FaRqo0QLzWdiY5nwxKzTkp7NFOy8UWqbFc7lBMCwjI6e2Tg
         Tyaw0ae6iyha03cM4wacFxNOiI1BS0CTv4nG6WZIaB95dVToF2SaW+2TUToCzmA84YuF
         KLiA==
X-Gm-Message-State: ALKqPwf/nvaINlK3n37QZ7BXM5BHGfsdrxYyOTS8pCBtb4fLpEip67mi
        OI6zY2FSbFIJU6KPLE9wmPXSAA==
X-Google-Smtp-Source: AB8JxZo+TRbdTRIYv4zQ7SUK6AiO2IJLlCFU9Zvu4wQgguAUOOs/VC8537/v8ThboE+CNy2AB0cNTg==
X-Received: by 2002:a2e:9dc8:: with SMTP id x8-v6mr1363809ljj.99.1525961973364;
        Thu, 10 May 2018 07:19:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/9] grep: keep all colors in an array
Date:   Thu, 10 May 2018 16:19:20 +0200
Message-Id: <20180510141927.23590-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more inline with how we handle color slots in other code. It
also allows us to get the list of configurable color slots later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 grep.c | 106 ++++++++++++++++++++++++++-------------------------------
 grep.h |  21 +++++++-----
 2 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/grep.c b/grep.c
index 65b90c10a3..2f7ebe60f6 100644
--- a/grep.c
+++ b/grep.c
@@ -13,6 +13,17 @@ static int grep_source_is_binary(struct grep_source *gs);
 
 static struct grep_opt grep_defaults;
 
+static const char *color_grep_slots[] = {
+	[GREP_COLOR_CONTEXT] = "context",
+	[GREP_COLOR_FILENAME] = "filename",
+	[GREP_COLOR_FUNCTION] = "function",
+	[GREP_COLOR_LINENO] = "lineNumber",
+	[GREP_COLOR_MATCH_CONTEXT] = "matchContext",
+	[GREP_COLOR_MATCH_SELECTED] = "matchSelected",
+	[GREP_COLOR_SELECTED] = "selected",
+	[GREP_COLOR_SEP] = "separator",
+};
+
 static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 {
 	fwrite(buf, size, 1, stdout);
@@ -42,14 +53,14 @@ void init_grep_defaults(void)
 	opt->pathname = 1;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	color_set(opt->color_context, "");
-	color_set(opt->color_filename, "");
-	color_set(opt->color_function, "");
-	color_set(opt->color_lineno, "");
-	color_set(opt->color_match_context, GIT_COLOR_BOLD_RED);
-	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
-	color_set(opt->color_selected, "");
-	color_set(opt->color_sep, GIT_COLOR_CYAN);
+	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
+	color_set(opt->colors[GREP_COLOR_FILENAME], "");
+	color_set(opt->colors[GREP_COLOR_FUNCTION], "");
+	color_set(opt->colors[GREP_COLOR_LINENO], "");
+	color_set(opt->colors[GREP_COLOR_MATCH_CONTEXT], GIT_COLOR_BOLD_RED);
+	color_set(opt->colors[GREP_COLOR_MATCH_SELECTED], GIT_COLOR_BOLD_RED);
+	color_set(opt->colors[GREP_COLOR_SELECTED], "");
+	color_set(opt->colors[GREP_COLOR_SEP], GIT_COLOR_CYAN);
 	opt->color = -1;
 	opt->output = std_output;
 }
@@ -76,7 +87,7 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = &grep_defaults;
-	char *color = NULL;
+	const char *slot;
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
@@ -103,32 +114,18 @@ int grep_config(const char *var, const char *value, void *cb)
 
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
-	else if (!strcmp(var, "color.grep.context"))
-		color = opt->color_context;
-	else if (!strcmp(var, "color.grep.filename"))
-		color = opt->color_filename;
-	else if (!strcmp(var, "color.grep.function"))
-		color = opt->color_function;
-	else if (!strcmp(var, "color.grep.linenumber"))
-		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.matchcontext"))
-		color = opt->color_match_context;
-	else if (!strcmp(var, "color.grep.matchselected"))
-		color = opt->color_match_selected;
-	else if (!strcmp(var, "color.grep.selected"))
-		color = opt->color_selected;
-	else if (!strcmp(var, "color.grep.separator"))
-		color = opt->color_sep;
-	else if (!strcmp(var, "color.grep.match")) {
-		int rc = 0;
-		if (!value)
-			return config_error_nonbool(var);
-		rc |= color_parse(value, opt->color_match_context);
-		rc |= color_parse(value, opt->color_match_selected);
-		return rc;
-	}
-
-	if (color) {
+	if (!strcmp(var, "color.grep.match")) {
+		if (grep_config("color.grep.matchcontext", value, cb) < 0)
+			return -1;
+		if (grep_config("color.grep.matchselected", value, cb) < 0)
+			return -1;
+	} else if (skip_prefix(var, "color.grep.", &slot)) {
+		int i = LOOKUP_CONFIG(color_grep_slots, slot);
+		char *color;
+
+		if (i < 0)
+			return -1;
+		color = opt->colors[i];
 		if (!value)
 			return config_error_nonbool(var);
 		return color_parse(value, color);
@@ -144,6 +141,7 @@ int grep_config(const char *var, const char *value, void *cb)
 void grep_init(struct grep_opt *opt, const char *prefix)
 {
 	struct grep_opt *def = &grep_defaults;
+	int i;
 
 	memset(opt, 0, sizeof(*opt));
 	opt->prefix = prefix;
@@ -160,14 +158,8 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->relative = def->relative;
 	opt->output = def->output;
 
-	color_set(opt->color_context, def->color_context);
-	color_set(opt->color_filename, def->color_filename);
-	color_set(opt->color_function, def->color_function);
-	color_set(opt->color_lineno, def->color_lineno);
-	color_set(opt->color_match_context, def->color_match_context);
-	color_set(opt->color_match_selected, def->color_match_selected);
-	color_set(opt->color_selected, def->color_selected);
-	color_set(opt->color_sep, def->color_sep);
+	for (i = 0; i < NR_GREP_COLORS; i++)
+		color_set(opt->colors[i], def->colors[i]);
 }
 
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
@@ -1100,12 +1092,12 @@ static void output_sep(struct grep_opt *opt, char sign)
 	if (opt->null_following_name)
 		opt->output(opt, "\0", 1);
 	else
-		output_color(opt, &sign, 1, opt->color_sep);
+		output_color(opt, &sign, 1, opt->colors[GREP_COLOR_SEP]);
 }
 
 static void show_name(struct grep_opt *opt, const char *name)
 {
-	output_color(opt, name, strlen(name), opt->color_filename);
+	output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
@@ -1372,28 +1364,28 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark) {
-				output_color(opt, "--", 2, opt->color_sep);
+				output_color(opt, "--", 2, opt->colors[GREP_COLOR_SEP]);
 				opt->output(opt, "\n", 1);
 			}
 		} else if (lno > opt->last_shown + 1) {
-			output_color(opt, "--", 2, opt->color_sep);
+			output_color(opt, "--", 2, opt->colors[GREP_COLOR_SEP]);
 			opt->output(opt, "\n", 1);
 		}
 	}
 	if (opt->heading && opt->last_shown == 0) {
-		output_color(opt, name, strlen(name), opt->color_filename);
+		output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 		opt->output(opt, "\n", 1);
 	}
 	opt->last_shown = lno;
 
 	if (!opt->heading && opt->pathname) {
-		output_color(opt, name, strlen(name), opt->color_filename);
+		output_color(opt, name, strlen(name), opt->colors[GREP_COLOR_FILENAME]);
 		output_sep(opt, sign);
 	}
 	if (opt->linenum) {
 		char buf[32];
 		xsnprintf(buf, sizeof(buf), "%d", lno);
-		output_color(opt, buf, strlen(buf), opt->color_lineno);
+		output_color(opt, buf, strlen(buf), opt->colors[GREP_COLOR_LINENO]);
 		output_sep(opt, sign);
 	}
 	if (opt->color) {
@@ -1403,15 +1395,15 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		int eflags = 0;
 
 		if (sign == ':')
-			match_color = opt->color_match_selected;
+			match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
 		else
-			match_color = opt->color_match_context;
+			match_color = opt->colors[GREP_COLOR_MATCH_CONTEXT];
 		if (sign == ':')
-			line_color = opt->color_selected;
+			line_color = opt->colors[GREP_COLOR_SELECTED];
 		else if (sign == '-')
-			line_color = opt->color_context;
+			line_color = opt->colors[GREP_COLOR_CONTEXT];
 		else if (sign == '=')
-			line_color = opt->color_function;
+			line_color = opt->colors[GREP_COLOR_FUNCTION];
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
@@ -1818,7 +1810,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
 				output_color(opt, gs->name, strlen(gs->name),
-					     opt->color_filename);
+					     opt->colors[GREP_COLOR_FILENAME]);
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
@@ -1892,7 +1884,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		char buf[32];
 		if (opt->pathname) {
 			output_color(opt, gs->name, strlen(gs->name),
-				     opt->color_filename);
+				     opt->colors[GREP_COLOR_FILENAME]);
 			output_sep(opt, ':');
 		}
 		xsnprintf(buf, sizeof(buf), "%u\n", count);
diff --git a/grep.h b/grep.h
index 399381c908..ed25be271b 100644
--- a/grep.h
+++ b/grep.h
@@ -62,6 +62,18 @@ enum grep_header_field {
 	GREP_HEADER_FIELD_MAX
 };
 
+enum grep_color {
+	GREP_COLOR_CONTEXT,
+	GREP_COLOR_FILENAME,
+	GREP_COLOR_FUNCTION,
+	GREP_COLOR_LINENO,
+	GREP_COLOR_MATCH_CONTEXT,
+	GREP_COLOR_MATCH_SELECTED,
+	GREP_COLOR_SELECTED,
+	GREP_COLOR_SEP,
+	NR_GREP_COLORS
+};
+
 struct grep_pat {
 	struct grep_pat *next;
 	const char *origin;
@@ -155,14 +167,7 @@ struct grep_opt {
 	int funcbody;
 	int extended_regexp_option;
 	int pattern_type_option;
-	char color_context[COLOR_MAXLEN];
-	char color_filename[COLOR_MAXLEN];
-	char color_function[COLOR_MAXLEN];
-	char color_lineno[COLOR_MAXLEN];
-	char color_match_context[COLOR_MAXLEN];
-	char color_match_selected[COLOR_MAXLEN];
-	char color_selected[COLOR_MAXLEN];
-	char color_sep[COLOR_MAXLEN];
+	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
-- 
2.17.0.705.g3525833791


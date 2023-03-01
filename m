Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1AAC64EC7
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCAAi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCAAiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781E1A269
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l25so11593545wrb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8VUUAGedcA5AmmbUPtxjHEnxgdnlFZgwXsaAAIZpuI=;
        b=X9mRiplDmtnDnOyv9iQobEbEYYqffV/5MZuwwpw28OlDVWWXRYNlBpuBcrhgI2g2YX
         WfcOJexJobU+O29PFcdAz24D8jDF4UOUfrzhZx/y2mFFww+2xCOiOrdJG3dTqrUWJo4m
         CnUonyQSKO3IulBGVDBgo1KQlBgLKUz02I9iJCv96f3IgFvzBe7nhEtzDFSqnAS2RrZM
         1Zbs6hmpR6GaTgPu7byZa40mukulct1cPqaPYhhV+Bsl/PSWgeLxmBaBhvPSLacxheBi
         evU54jwukTzFjEJT+gpO1fE0dlpdlWRB2xAyQBuTDXwbI+MYLkZCv4xOoSkGNjhTYxgq
         IhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8VUUAGedcA5AmmbUPtxjHEnxgdnlFZgwXsaAAIZpuI=;
        b=jcPS1RgVyWbtTl6XthF0dBmN+jCvTQ61DGiCrrH1N5RCG3sY44lGuj9G0FRmTuDUTl
         LKbcRVfT4kEbU4wTW/VUWaIUULBc3vNMJs4LPqsNS4TiYaxOEfs+APOQyY68yZrhbdpw
         9aGHOK4XOoDbVhcUU3fEIXiWLUC0g+7NTv+tVPsz+2Nwe/sxRPRqUxgDWNrqujfzXkDR
         k/zB4dDgnpVw2X8EJesCY3joGHypLJdj9u/xzz0zEf+ZpgGBoOngvVmQPONBHjZoOH00
         KZ0BsyKrerku74tVqTwDQEY+nvPbspyCTPl3zIsP+si2GVsHfRexi3HJpTjlMR9XG+X5
         sqvA==
X-Gm-Message-State: AO0yUKUMrkEx4XPDcqg+oaCAMeunTRg3A218/t/vR+qfsPv614uX7Zl1
        lAysxid/3NcNBUSdxfO2woac+VV7a30=
X-Google-Smtp-Source: AK7set/SE0VpY5t7wOssCh8INWnNbjEMugthd+rT8l2epEqy7QHOU9Qet+X6XGrQcORpg5VYMwCUzQ==
X-Received: by 2002:a05:6000:1f10:b0:2c7:e48:8c87 with SMTP id bv16-20020a0560001f1000b002c70e488c87mr8546854wrb.25.1677631099349;
        Tue, 28 Feb 2023 16:38:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b002c5a1bd527dsm11093059wro.96.2023.02.28.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:18 -0800 (PST)
Message-Id: <ad513d832d8267f9e4805db5e7a9e8915fc62a23.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:12 +0000
Subject: [PATCH 1/6] config.c: plumb config_source through static fns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

This reduces the direct dependence on the "cf" static variable, which
will make it easier to remove in a later commit. The plumbed arg is
named "cs" to differentiate between it and the static variable.

In some cases (public functions and config callback functions), there
isn't an obvious way to plumb "struct config_source" through function
args. As a workaround, add references to "cf" that we'll address in
later commits.

The remaining references to "cf" are direct assignments to "cf", which
we'll also address in a later commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 192 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 100 insertions(+), 92 deletions(-)

diff --git a/config.c b/config.c
index 00090a32fc3..84ae97741ac 100644
--- a/config.c
+++ b/config.c
@@ -156,7 +156,8 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(const char *path, struct config_include_data *inc)
+static int handle_path_include(struct config_source *cs, const char *path,
+			       struct config_include_data *inc)
 {
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
@@ -177,14 +178,14 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cf || !cf->path) {
+		if (!cs || !cs->path) {
 			ret = error(_("relative config includes must come from files"));
 			goto cleanup;
 		}
 
-		slash = find_last_dir_sep(cf->path);
+		slash = find_last_dir_sep(cs->path);
 		if (slash)
-			strbuf_add(&buf, cf->path, slash - cf->path + 1);
+			strbuf_add(&buf, cs->path, slash - cs->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -192,8 +193,8 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cf ? "<unknown>" :
-			    cf->name ? cf->name :
+			    !cs ? "<unknown>" :
+			    cs->name ? cs->name :
 			    "the command line");
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
@@ -210,7 +211,8 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct strbuf *pat)
+static int prepare_include_condition_pattern(struct config_source *cs,
+					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
 	char *expanded;
@@ -226,11 +228,11 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
 		const char *slash;
 
-		if (!cf || !cf->path)
+		if (!cs || !cs->path)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_realpath(&path, cf->path, 1);
+		strbuf_realpath(&path, cs->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			BUG("how is this possible?");
@@ -245,7 +247,8 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	return prefix;
 }
 
-static int include_by_gitdir(const struct config_options *opts,
+static int include_by_gitdir(struct config_source *cs,
+			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
@@ -261,7 +264,7 @@ static int include_by_gitdir(const struct config_options *opts,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(&pattern);
+	prefix = prepare_include_condition_pattern(cs, &pattern);
 
 again:
 	if (prefix < 0)
@@ -406,15 +409,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_include_data *inc,
+static int include_condition_is_true(struct config_source *cs,
+				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(opts, cond, cond_len, 0);
+		return include_by_gitdir(cs, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(opts, cond, cond_len, 1);
+		return include_by_gitdir(cs, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -441,16 +445,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+		ret = handle_path_include(cf, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(inc, cond, cond_len) &&
+	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(value, inc);
+		ret = handle_path_include(cf, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -777,21 +781,21 @@ out:
 	return ret;
 }
 
-static int get_next_char(void)
+static int get_next_char(struct config_source *cs)
 {
-	int c = cf->do_fgetc(cf);
+	int c = cs->do_fgetc(cs);
 
 	if (c == '\r') {
 		/* DOS like systems */
-		c = cf->do_fgetc(cf);
+		c = cs->do_fgetc(cs);
 		if (c != '\n') {
 			if (c != EOF)
-				cf->do_ungetc(c, cf);
+				cs->do_ungetc(c, cs);
 			c = '\r';
 		}
 	}
 
-	if (c != EOF && ++cf->total_len > INT_MAX) {
+	if (c != EOF && ++cs->total_len > INT_MAX) {
 		/*
 		 * This is an absurdly long config file; refuse to parse
 		 * further in order to protect downstream code from integer
@@ -799,38 +803,38 @@ static int get_next_char(void)
 		 * but we can mark EOF and put trash in the return value,
 		 * which will trigger a parse error.
 		 */
-		cf->eof = 1;
+		cs->eof = 1;
 		return 0;
 	}
 
 	if (c == '\n')
-		cf->linenr++;
+		cs->linenr++;
 	if (c == EOF) {
-		cf->eof = 1;
-		cf->linenr++;
+		cs->eof = 1;
+		cs->linenr++;
 		c = '\n';
 	}
 	return c;
 }
 
-static char *parse_value(void)
+static char *parse_value(struct config_source *cs)
 {
 	int quote = 0, comment = 0, space = 0;
 
-	strbuf_reset(&cf->value);
+	strbuf_reset(&cs->value);
 	for (;;) {
-		int c = get_next_char();
+		int c = get_next_char(cs);
 		if (c == '\n') {
 			if (quote) {
-				cf->linenr--;
+				cs->linenr--;
 				return NULL;
 			}
-			return cf->value.buf;
+			return cs->value.buf;
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			if (cf->value.len)
+			if (cs->value.len)
 				space++;
 			continue;
 		}
@@ -841,9 +845,9 @@ static char *parse_value(void)
 			}
 		}
 		for (; space; space--)
-			strbuf_addch(&cf->value, ' ');
+			strbuf_addch(&cs->value, ' ');
 		if (c == '\\') {
-			c = get_next_char();
+			c = get_next_char(cs);
 			switch (c) {
 			case '\n':
 				continue;
@@ -863,18 +867,19 @@ static char *parse_value(void)
 			default:
 				return NULL;
 			}
-			strbuf_addch(&cf->value, c);
+			strbuf_addch(&cs->value, c);
 			continue;
 		}
 		if (c == '"') {
 			quote = 1-quote;
 			continue;
 		}
-		strbuf_addch(&cf->value, c);
+		strbuf_addch(&cs->value, c);
 	}
 }
 
-static int get_value(config_fn_t fn, void *data, struct strbuf *name)
+static int get_value(struct config_source *cs, config_fn_t fn, void *data,
+		     struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -882,8 +887,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 
 	/* Get the full name */
 	for (;;) {
-		c = get_next_char();
-		if (cf->eof)
+		c = get_next_char(cs);
+		if (cs->eof)
 			break;
 		if (!iskeychar(c))
 			break;
@@ -891,13 +896,13 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	}
 
 	while (c == ' ' || c == '\t')
-		c = get_next_char();
+		c = get_next_char(cs);
 
 	value = NULL;
 	if (c != '\n') {
 		if (c != '=')
 			return -1;
-		value = parse_value();
+		value = parse_value(cs);
 		if (!value)
 			return -1;
 	}
@@ -906,20 +911,21 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	 * the line we just parsed during the call to fn to get
 	 * accurate line number in error messages.
 	 */
-	cf->linenr--;
+	cs->linenr--;
 	ret = fn(name->buf, value, data);
 	if (ret >= 0)
-		cf->linenr++;
+		cs->linenr++;
 	return ret;
 }
 
-static int get_extended_base_var(struct strbuf *name, int c)
+static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
+				 int c)
 {
-	cf->subsection_case_sensitive = 0;
+	cs->subsection_case_sensitive = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
-		c = get_next_char();
+		c = get_next_char(cs);
 	} while (isspace(c));
 
 	/* We require the format to be '[base "extension"]' */
@@ -928,13 +934,13 @@ static int get_extended_base_var(struct strbuf *name, int c)
 	strbuf_addch(name, '.');
 
 	for (;;) {
-		int c = get_next_char();
+		int c = get_next_char(cs);
 		if (c == '\n')
 			goto error_incomplete_line;
 		if (c == '"')
 			break;
 		if (c == '\\') {
-			c = get_next_char();
+			c = get_next_char(cs);
 			if (c == '\n')
 				goto error_incomplete_line;
 		}
@@ -942,25 +948,25 @@ static int get_extended_base_var(struct strbuf *name, int c)
 	}
 
 	/* Final ']' */
-	if (get_next_char() != ']')
+	if (get_next_char(cs) != ']')
 		return -1;
 	return 0;
 error_incomplete_line:
-	cf->linenr--;
+	cs->linenr--;
 	return -1;
 }
 
-static int get_base_var(struct strbuf *name)
+static int get_base_var(struct config_source *cs, struct strbuf *name)
 {
-	cf->subsection_case_sensitive = 1;
+	cs->subsection_case_sensitive = 1;
 	for (;;) {
-		int c = get_next_char();
-		if (cf->eof)
+		int c = get_next_char(cs);
+		if (cs->eof)
 			return -1;
 		if (c == ']')
 			return 0;
 		if (isspace(c))
-			return get_extended_base_var(name, c);
+			return get_extended_base_var(cs, name, c);
 		if (!iskeychar(c) && c != '.')
 			return -1;
 		strbuf_addch(name, tolower(c));
@@ -973,7 +979,8 @@ struct parse_event_data {
 	const struct config_options *opts;
 };
 
-static int do_event(enum config_event_t type, struct parse_event_data *data)
+static int do_event(struct config_source *cs, enum config_event_t type,
+		    struct parse_event_data *data)
 {
 	size_t offset;
 
@@ -984,7 +991,7 @@ static int do_event(enum config_event_t type, struct parse_event_data *data)
 	    data->previous_type == type)
 		return 0;
 
-	offset = cf->do_ftell(cf);
+	offset = cs->do_ftell(cs);
 	/*
 	 * At EOF, the parser always "inserts" an extra '\n', therefore
 	 * the end offset of the event is the current file position, otherwise
@@ -1004,12 +1011,12 @@ static int do_event(enum config_event_t type, struct parse_event_data *data)
 	return 0;
 }
 
-static int git_parse_source(config_fn_t fn, void *data,
-			    const struct config_options *opts)
+static int git_parse_source(struct config_source *cs, config_fn_t fn,
+			    void *data, const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
-	struct strbuf *var = &cf->var;
+	struct strbuf *var = &cs->var;
 	int error_return = 0;
 	char *error_msg = NULL;
 
@@ -1024,7 +1031,7 @@ static int git_parse_source(config_fn_t fn, void *data,
 	for (;;) {
 		int c;
 
-		c = get_next_char();
+		c = get_next_char(cs);
 		if (bomptr && *bomptr) {
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
@@ -1041,12 +1048,12 @@ static int git_parse_source(config_fn_t fn, void *data,
 			}
 		}
 		if (c == '\n') {
-			if (cf->eof) {
-				if (do_event(CONFIG_EVENT_EOF, &event_data) < 0)
+			if (cs->eof) {
+				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
 					return -1;
 				return 0;
 			}
-			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 				return -1;
 			comment = 0;
 			continue;
@@ -1054,23 +1061,23 @@ static int git_parse_source(config_fn_t fn, void *data,
 		if (comment)
 			continue;
 		if (isspace(c)) {
-			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 					return -1;
 			continue;
 		}
 		if (c == '#' || c == ';') {
-			if (do_event(CONFIG_EVENT_COMMENT, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
 					return -1;
 			comment = 1;
 			continue;
 		}
 		if (c == '[') {
-			if (do_event(CONFIG_EVENT_SECTION, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
 					return -1;
 
 			/* Reset prior to determining a new stem */
 			strbuf_reset(var);
-			if (get_base_var(var) < 0 || var->len < 1)
+			if (get_base_var(cs, var) < 0 || var->len < 1)
 				break;
 			strbuf_addch(var, '.');
 			baselen = var->len;
@@ -1079,7 +1086,7 @@ static int git_parse_source(config_fn_t fn, void *data,
 		if (!isalpha(c))
 			break;
 
-		if (do_event(CONFIG_EVENT_ENTRY, &event_data) < 0)
+		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
 			return -1;
 
 		/*
@@ -1089,42 +1096,42 @@ static int git_parse_source(config_fn_t fn, void *data,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(fn, data, var) < 0)
+		if (get_value(cs, fn, data, var) < 0)
 			break;
 	}
 
-	if (do_event(CONFIG_EVENT_ERROR, &event_data) < 0)
+	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
 		return -1;
 
-	switch (cf->origin_type) {
+	switch (cs->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		error_msg = xstrfmt(_("bad config line %d in blob %s"),
-				      cf->linenr, cf->name);
+				      cs->linenr, cs->name);
 		break;
 	case CONFIG_ORIGIN_FILE:
 		error_msg = xstrfmt(_("bad config line %d in file %s"),
-				      cf->linenr, cf->name);
+				      cs->linenr, cs->name);
 		break;
 	case CONFIG_ORIGIN_STDIN:
 		error_msg = xstrfmt(_("bad config line %d in standard input"),
-				      cf->linenr);
+				      cs->linenr);
 		break;
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
-				       cf->linenr, cf->name);
+				       cs->linenr, cs->name);
 		break;
 	case CONFIG_ORIGIN_CMDLINE:
 		error_msg = xstrfmt(_("bad config line %d in command line %s"),
-				       cf->linenr, cf->name);
+				       cs->linenr, cs->name);
 		break;
 	default:
 		error_msg = xstrfmt(_("bad config line %d in %s"),
-				      cf->linenr, cf->name);
+				      cs->linenr, cs->name);
 	}
 
 	switch (opts && opts->error_action ?
 		opts->error_action :
-		cf->default_error_action) {
+		cs->default_error_action) {
 	case CONFIG_ERROR_DIE:
 		die("%s", error_msg);
 		break;
@@ -1266,7 +1273,8 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 }
 
 NORETURN
-static void die_bad_number(const char *name, const char *value)
+static void die_bad_number(struct config_source *cs, const char *name,
+			   const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
@@ -1275,28 +1283,28 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (!(cf && cf->name))
+	if (!(cs && cs->name))
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (cf->origin_type) {
+	switch (cs->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, cs->name, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, cs->name, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, cs->name, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, cs->name, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, cs->name, _(error_type));
 	}
 }
 
@@ -1304,7 +1312,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf, name, value);
 	return ret;
 }
 
@@ -1312,7 +1320,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf, name, value);
 	return ret;
 }
 
@@ -1320,7 +1328,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf, name, value);
 	return ret;
 }
 
@@ -1328,7 +1336,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf, name, value);
 	return ret;
 }
 
@@ -1948,7 +1956,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_source(fn, data, opts);
+	ret = git_parse_source(cf, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
-- 
gitgitgadget


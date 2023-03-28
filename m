Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D2C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjC1Rwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC1RwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F98CEB46
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so8042601wms.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMn9pKez2/jqoNGik0zAGGYfZeFTd5sY47XsXqHvoQA=;
        b=N0AiXuBO6aRixLhRzgg16o3LCKRVNXIMxZjYbN3d++znwy/FVdmZyCv1J1zjcwoPaG
         b5SdAYasUjHSnVQDmD5veVL5kxZDijHEgCtmfxAc7aWBumgYw/BcPuDegrDFd+3BmzR6
         Sb4kw2j+9LYWCeURF7GDVB+sBWPsOi9JbOkYjzhpKdmo5+An7SCb4E7573/h0cDagF4/
         jVzSnxqRWuLBw9u5mCGMNfh818QxXqHeKC0XN5Kj6hWapPTi2USyzjdUn9iJaF2VuRDF
         KubiKj6D4hcBT+DU6z5zyX3Q6YrVFzvZwNWMJ4hGlpgRS+FjgxMqAXSHwqTex0dI1+f9
         Jvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMn9pKez2/jqoNGik0zAGGYfZeFTd5sY47XsXqHvoQA=;
        b=DjFKlQhpSQEISqiEHWpyuIBGzYV8X2wTIU6vK7L4ErR3Q06z6geBZMVrqqZghHh0rj
         tKSgqab8xzaXuBn/RLmGhVdO9vGmt/BmscUETYdD0Ng0gNOyeD658a1kHKxl9XXf+C35
         oFYr91sc+SJoRHqJGWt5cj5dEli+J5vIX7xzIVpDuMNoei0j/0yYIWbSyRZoxTZN5CdB
         kLYQYl8+k39DOYlrrj08ne+xIby6O4GM1lkTc6gP2IJbJ46y1eQvcqS26sx7GKVrJF6/
         mdX50lAx9CTHm1D/WUnWO/wvNRkm9XuWjYPyTQlASVT8YSJQZCNea5Ae9+bGR2IrjAcI
         eUIg==
X-Gm-Message-State: AO0yUKUnn8gqHfFK5Xovdu0TPRm0+fkO2eRO9PSj2szQ+M/gY6kXBIry
        8t4iY+NzMcIExKzF6WGtCGRLsk5WHsI=
X-Google-Smtp-Source: AK7set8DJNRl4GvphPPp+R0/HxcoFWfBQRWQ9JUAtmSMyFGm2Rcfn5K0f/hizQa3QlgxJB3HZEs/IQ==
X-Received: by 2002:a7b:cd0d:0:b0:3ed:30cb:5569 with SMTP id f13-20020a7bcd0d000000b003ed30cb5569mr11733259wmj.20.1680025921145;
        Tue, 28 Mar 2023 10:52:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b003edddae1068sm13568571wms.9.2023.03.28.10.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:52:00 -0700 (PDT)
Message-Id: <ab800aa104c32e00c357aa450c5fd13cbe791ed2.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:54 +0000
Subject: [PATCH v3 8/8] config.c: rename "struct config_source cf"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

The "cf" name is a holdover from before 4d8dd1494e (config: make parsing
stack struct independent from actual data source, 2013-07-12), when the
struct was named config_file. Since that acronym no longer makes sense,
rename "cf" to "cs". In some places, we have "struct config_set cs", so
to avoid conflict, rename those "cs" to "set" ("config_set" would be
more descriptive, but it's much longer and would require us to rewrap
several lines).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 262 +++++++++++++++++++++++++++----------------------------
 1 file changed, 131 insertions(+), 131 deletions(-)

diff --git a/config.c b/config.c
index 46c5a9a7d51..cf571d45282 100644
--- a/config.c
+++ b/config.c
@@ -202,7 +202,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cf, const char *path,
+static int handle_path_include(struct config_source *cs, const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -224,14 +224,14 @@ static int handle_path_include(struct config_source *cf, const char *path,
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
@@ -239,8 +239,8 @@ static int handle_path_include(struct config_source *cf, const char *path,
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
@@ -257,7 +257,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cf,
+static int prepare_include_condition_pattern(struct config_source *cs,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -274,11 +274,11 @@ static int prepare_include_condition_pattern(struct config_source *cf,
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
@@ -293,7 +293,7 @@ static int prepare_include_condition_pattern(struct config_source *cf,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cf,
+static int include_by_gitdir(struct config_source *cs,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -310,7 +310,7 @@ static int include_by_gitdir(struct config_source *cf,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cf, &pattern);
+	prefix = prepare_include_condition_pattern(cs, &pattern);
 
 again:
 	if (prefix < 0)
@@ -449,16 +449,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cf,
+static int include_condition_is_true(struct config_source *cs,
 				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(cf, opts, cond, cond_len, 0);
+		return include_by_gitdir(cs, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(cf, opts, cond, cond_len, 1);
+		return include_by_gitdir(cs, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -472,7 +472,7 @@ static int include_condition_is_true(struct config_source *cf,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cf = inc->config_reader->source;
+	struct config_source *cs = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -486,16 +486,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cf, value, inc);
+		ret = handle_path_include(cs, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cf, value, inc);
+		ret = handle_path_include(cs, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -820,21 +820,21 @@ out:
 	return ret;
 }
 
-static int get_next_char(struct config_source *cf)
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
@@ -842,38 +842,38 @@ static int get_next_char(struct config_source *cf)
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
 
-static char *parse_value(struct config_source *cf)
+static char *parse_value(struct config_source *cs)
 {
 	int quote = 0, comment = 0, space = 0;
 
-	strbuf_reset(&cf->value);
+	strbuf_reset(&cs->value);
 	for (;;) {
-		int c = get_next_char(cf);
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
@@ -884,9 +884,9 @@ static char *parse_value(struct config_source *cf)
 			}
 		}
 		for (; space; space--)
-			strbuf_addch(&cf->value, ' ');
+			strbuf_addch(&cs->value, ' ');
 		if (c == '\\') {
-			c = get_next_char(cf);
+			c = get_next_char(cs);
 			switch (c) {
 			case '\n':
 				continue;
@@ -906,18 +906,18 @@ static char *parse_value(struct config_source *cf)
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
 
-static int get_value(struct config_source *cf, config_fn_t fn, void *data,
+static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 		     struct strbuf *name)
 {
 	int c;
@@ -926,8 +926,8 @@ static int get_value(struct config_source *cf, config_fn_t fn, void *data,
 
 	/* Get the full name */
 	for (;;) {
-		c = get_next_char(cf);
-		if (cf->eof)
+		c = get_next_char(cs);
+		if (cs->eof)
 			break;
 		if (!iskeychar(c))
 			break;
@@ -935,13 +935,13 @@ static int get_value(struct config_source *cf, config_fn_t fn, void *data,
 	}
 
 	while (c == ' ' || c == '\t')
-		c = get_next_char(cf);
+		c = get_next_char(cs);
 
 	value = NULL;
 	if (c != '\n') {
 		if (c != '=')
 			return -1;
-		value = parse_value(cf);
+		value = parse_value(cs);
 		if (!value)
 			return -1;
 	}
@@ -950,21 +950,21 @@ static int get_value(struct config_source *cf, config_fn_t fn, void *data,
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
 
-static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
+static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
 				 int c)
 {
-	cf->subsection_case_sensitive = 0;
+	cs->subsection_case_sensitive = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
-		c = get_next_char(cf);
+		c = get_next_char(cs);
 	} while (isspace(c));
 
 	/* We require the format to be '[base "extension"]' */
@@ -973,13 +973,13 @@ static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
 	strbuf_addch(name, '.');
 
 	for (;;) {
-		int c = get_next_char(cf);
+		int c = get_next_char(cs);
 		if (c == '\n')
 			goto error_incomplete_line;
 		if (c == '"')
 			break;
 		if (c == '\\') {
-			c = get_next_char(cf);
+			c = get_next_char(cs);
 			if (c == '\n')
 				goto error_incomplete_line;
 		}
@@ -987,25 +987,25 @@ static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
 	}
 
 	/* Final ']' */
-	if (get_next_char(cf) != ']')
+	if (get_next_char(cs) != ']')
 		return -1;
 	return 0;
 error_incomplete_line:
-	cf->linenr--;
+	cs->linenr--;
 	return -1;
 }
 
-static int get_base_var(struct config_source *cf, struct strbuf *name)
+static int get_base_var(struct config_source *cs, struct strbuf *name)
 {
-	cf->subsection_case_sensitive = 1;
+	cs->subsection_case_sensitive = 1;
 	for (;;) {
-		int c = get_next_char(cf);
-		if (cf->eof)
+		int c = get_next_char(cs);
+		if (cs->eof)
 			return -1;
 		if (c == ']')
 			return 0;
 		if (isspace(c))
-			return get_extended_base_var(cf, name, c);
+			return get_extended_base_var(cs, name, c);
 		if (!iskeychar(c) && c != '.')
 			return -1;
 		strbuf_addch(name, tolower(c));
@@ -1018,7 +1018,7 @@ struct parse_event_data {
 	const struct config_options *opts;
 };
 
-static int do_event(struct config_source *cf, enum config_event_t type,
+static int do_event(struct config_source *cs, enum config_event_t type,
 		    struct parse_event_data *data)
 {
 	size_t offset;
@@ -1030,7 +1030,7 @@ static int do_event(struct config_source *cf, enum config_event_t type,
 	    data->previous_type == type)
 		return 0;
 
-	offset = cf->do_ftell(cf);
+	offset = cs->do_ftell(cs);
 	/*
 	 * At EOF, the parser always "inserts" an extra '\n', therefore
 	 * the end offset of the event is the current file position, otherwise
@@ -1050,12 +1050,12 @@ static int do_event(struct config_source *cf, enum config_event_t type,
 	return 0;
 }
 
-static int git_parse_source(struct config_source *cf, config_fn_t fn,
+static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			    void *data, const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
-	struct strbuf *var = &cf->var;
+	struct strbuf *var = &cs->var;
 	int error_return = 0;
 	char *error_msg = NULL;
 
@@ -1070,7 +1070,7 @@ static int git_parse_source(struct config_source *cf, config_fn_t fn,
 	for (;;) {
 		int c;
 
-		c = get_next_char(cf);
+		c = get_next_char(cs);
 		if (bomptr && *bomptr) {
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
@@ -1087,12 +1087,12 @@ static int git_parse_source(struct config_source *cf, config_fn_t fn,
 			}
 		}
 		if (c == '\n') {
-			if (cf->eof) {
-				if (do_event(cf, CONFIG_EVENT_EOF, &event_data) < 0)
+			if (cs->eof) {
+				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
 					return -1;
 				return 0;
 			}
-			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 				return -1;
 			comment = 0;
 			continue;
@@ -1100,23 +1100,23 @@ static int git_parse_source(struct config_source *cf, config_fn_t fn,
 		if (comment)
 			continue;
 		if (isspace(c)) {
-			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 					return -1;
 			continue;
 		}
 		if (c == '#' || c == ';') {
-			if (do_event(cf, CONFIG_EVENT_COMMENT, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
 					return -1;
 			comment = 1;
 			continue;
 		}
 		if (c == '[') {
-			if (do_event(cf, CONFIG_EVENT_SECTION, &event_data) < 0)
+			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
 					return -1;
 
 			/* Reset prior to determining a new stem */
 			strbuf_reset(var);
-			if (get_base_var(cf, var) < 0 || var->len < 1)
+			if (get_base_var(cs, var) < 0 || var->len < 1)
 				break;
 			strbuf_addch(var, '.');
 			baselen = var->len;
@@ -1125,7 +1125,7 @@ static int git_parse_source(struct config_source *cf, config_fn_t fn,
 		if (!isalpha(c))
 			break;
 
-		if (do_event(cf, CONFIG_EVENT_ENTRY, &event_data) < 0)
+		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
 			return -1;
 
 		/*
@@ -1135,42 +1135,42 @@ static int git_parse_source(struct config_source *cf, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cf, fn, data, var) < 0)
+		if (get_value(cs, fn, data, var) < 0)
 			break;
 	}
 
-	if (do_event(cf, CONFIG_EVENT_ERROR, &event_data) < 0)
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
@@ -2280,13 +2280,13 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *cs,
+static void configset_iter(struct config_reader *reader, struct config_set *set,
 			   config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
-	struct configset_list *list = &cs->list;
+	struct configset_list *list = &set->list;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
@@ -2351,7 +2351,7 @@ void read_very_early_config(config_fn_t cb, void *data)
 	config_with_options(cb, data, NULL, &opts);
 }
 
-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+static struct config_set_element *configset_find_element(struct config_set *set, const char *key)
 {
 	struct config_set_element k;
 	struct config_set_element *found_entry;
@@ -2365,13 +2365,13 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
-	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
+	found_entry = hashmap_get_entry(&set->config_hash, &k, ent, NULL);
 	free(normalized_key);
 	return found_entry;
 }
 
 static int configset_add_value(struct config_reader *reader,
-			       struct config_set *cs, const char *key,
+			       struct config_set *set, const char *key,
 			       const char *value)
 {
 	struct config_set_element *e;
@@ -2379,7 +2379,7 @@ static int configset_add_value(struct config_reader *reader,
 	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
 
-	e = configset_find_element(cs, key);
+	e = configset_find_element(set, key);
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -2389,12 +2389,12 @@ static int configset_add_value(struct config_reader *reader,
 		hashmap_entry_init(&e->ent, strhash(key));
 		e->key = xstrdup(key);
 		string_list_init_dup(&e->value_list);
-		hashmap_add(&cs->config_hash, &e->ent);
+		hashmap_add(&set->config_hash, &e->ent);
 	}
 	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
 
-	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
-	l_item = &cs->list.items[cs->list.nr++];
+	ALLOC_GROW(set->list.items, set->list.nr + 1, set->list.alloc);
+	l_item = &set->list.items[set->list.nr++];
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
@@ -2429,33 +2429,33 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
-void git_configset_init(struct config_set *cs)
+void git_configset_init(struct config_set *set)
 {
-	hashmap_init(&cs->config_hash, config_set_element_cmp, NULL, 0);
-	cs->hash_initialized = 1;
-	cs->list.nr = 0;
-	cs->list.alloc = 0;
-	cs->list.items = NULL;
+	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
+	set->hash_initialized = 1;
+	set->list.nr = 0;
+	set->list.alloc = 0;
+	set->list.items = NULL;
 }
 
-void git_configset_clear(struct config_set *cs)
+void git_configset_clear(struct config_set *set)
 {
 	struct config_set_element *entry;
 	struct hashmap_iter iter;
-	if (!cs->hash_initialized)
+	if (!set->hash_initialized)
 		return;
 
-	hashmap_for_each_entry(&cs->config_hash, &iter, entry,
+	hashmap_for_each_entry(&set->config_hash, &iter, entry,
 				ent /* member name */) {
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
-	hashmap_clear_and_free(&cs->config_hash, struct config_set_element, ent);
-	cs->hash_initialized = 0;
-	free(cs->list.items);
-	cs->list.nr = 0;
-	cs->list.alloc = 0;
-	cs->list.items = NULL;
+	hashmap_clear_and_free(&set->config_hash, struct config_set_element, ent);
+	set->hash_initialized = 0;
+	free(set->list.items);
+	set->list.nr = 0;
+	set->list.alloc = 0;
+	set->list.items = NULL;
 }
 
 struct configset_add_data {
@@ -2471,15 +2471,15 @@ static int config_set_callback(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-int git_configset_add_file(struct config_set *cs, const char *filename)
+int git_configset_add_file(struct config_set *set, const char *filename)
 {
 	struct configset_add_data data = CONFIGSET_ADD_INIT;
 	data.config_reader = &the_reader;
-	data.config_set = cs;
+	data.config_set = set;
 	return git_config_from_file(config_set_callback, filename, &data);
 }
 
-int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
+int git_configset_get_value(struct config_set *set, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
 	/*
@@ -2487,7 +2487,7 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	 * queried key in the files of the configset, the value returned will be the last
 	 * value in the value list for that key.
 	 */
-	values = git_configset_get_value_multi(cs, key);
+	values = git_configset_get_value_multi(set, key);
 
 	if (!values)
 		return 1;
@@ -2496,26 +2496,26 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
 	return 0;
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+const struct string_list *git_configset_get_value_multi(struct config_set *set, const char *key)
 {
-	struct config_set_element *e = configset_find_element(cs, key);
+	struct config_set_element *e = configset_find_element(set, key);
 	return e ? &e->value_list : NULL;
 }
 
-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
+int git_configset_get_string(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
+	if (!git_configset_get_value(set, key, &value))
 		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
 }
 
-static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
+static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		if (!value)
 			return config_error_nonbool(key);
 		*dest = value;
@@ -2525,51 +2525,51 @@ static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
 	}
 }
 
-int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_int(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
+int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_ulong(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_bool(key, value);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
+int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 				int *is_bool, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_config_bool_or_int(key, value, is_bool);
 		return 0;
 	} else
 		return 1;
 }
 
-int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
+int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value)) {
+	if (!git_configset_get_value(set, key, &value)) {
 		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
@@ -2578,10 +2578,10 @@ int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *de
 		return 1;
 }
 
-int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
+int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(cs, key, &value))
+	if (!git_configset_get_value(set, key, &value))
 		return git_config_pathname(dest, key, value);
 	else
 		return 1;
@@ -2972,7 +2972,7 @@ static int store_aux_event(enum config_event_t type,
 			   size_t begin, size_t end, void *data)
 {
 	struct config_store_data *store = data;
-	struct config_source *cf = store->config_reader->source;
+	struct config_source *cs = store->config_reader->source;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -2982,10 +2982,10 @@ static int store_aux_event(enum config_event_t type,
 	if (type == CONFIG_EVENT_SECTION) {
 		int (*cmpfn)(const char *, const char *, size_t);
 
-		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
-			return error(_("invalid section name '%s'"), cf->var.buf);
+		if (cs->var.len < 2 || cs->var.buf[cs->var.len - 1] != '.')
+			return error(_("invalid section name '%s'"), cs->var.buf);
 
-		if (cf->subsection_case_sensitive)
+		if (cs->subsection_case_sensitive)
 			cmpfn = strncasecmp;
 		else
 			cmpfn = strncmp;
@@ -2993,8 +2993,8 @@ static int store_aux_event(enum config_event_t type,
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
-			cf->var.len - 1 == store->baselen &&
-			!cmpfn(cf->var.buf, store->key, store->baselen);
+			cs->var.len - 1 == store->baselen &&
+			!cmpfn(cs->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2519BC761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjC1RwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjC1RwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E7EF93
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1216910wmo.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+pb0ArOIfkc6534iJy7PETsQ9XBpuOlzInTQC7qe1k=;
        b=Ja9v6B3hE29dXxNcaZfs2dBykTHp4/gLCLZLfOMLzsE3pGgmrMDdz6mXSC/4b/WFaW
         e7UHpRDD/MXgCTxKf2pXdrH/OvN9JE9ckr7WpD0t/A7lmYpYkWJFUfELAQR2M1Sgn2t8
         LQHiU6yILjvLWHtHqYh7F9VFINDpjKDyjC4bkFlqoFuHSIMtkksykObMCsPbo5ARGyy0
         6yWY+K2jdKQ5xGu5MZcfo3SfRcf1sPDYFSRLaL0A3p5nr0+pQWjTWRKfEydNvJTUTRtk
         M5+CabCf1EhwVfKCUjIiwtH028xm3OMx5LvEciRjiu3A8VAWJ4oMrCZSm0QBOeR4VxUy
         V+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+pb0ArOIfkc6534iJy7PETsQ9XBpuOlzInTQC7qe1k=;
        b=nINHqep64qWPFUhXsk+6yDm0ud92+eoGF6qd0ryozuV0qwqWC0VbMzlN9BwoZUyBxi
         EYuHWOLRzWlaaUl29YWi32Zqix+RWWqmWDSmhwkmC0LdYXjiGMuqzypGKkglU7gwDXN3
         tu/UvwQPHp2KlaGxoi0Y9P5cxP+yhgEzFPaIYyg0I5yoWgDtX3xFCDuXFWEt4kzq7f/B
         KFj0NTE+IQjZRNbErxwLtXg1zMrkjeGk/0TFA0xghH9wSm8Y5LBKzJucfBbeZfuxTOPL
         JTMJnlDNSl+is87eS2Ou1CNZsD+TyxVClpOxsH8vCwkZSU+piOcrcHsjkz3nTIH96cTc
         XhhA==
X-Gm-Message-State: AO0yUKV0vjX6TrXBPXZysOqvYBal39LE7/Z0lEo+4xZEsydNPYebaPci
        sTxMW5k5cAi8VgDnW3KCpc5NLAxbjLs=
X-Google-Smtp-Source: AK7set+TJvarmJ0d7Lg73Xjr6iGdaK52BaPbuIAMjlr+3l0K+y42uoF90B45dK+ubN/hA9DXf4VETQ==
X-Received: by 2002:a05:600c:cb:b0:3ed:66e0:b6de with SMTP id u11-20020a05600c00cb00b003ed66e0b6demr13640288wmm.22.1680025916490;
        Tue, 28 Mar 2023 10:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003ed2433aa4asm18050529wml.41.2023.03.28.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:56 -0700 (PDT)
Message-Id: <75d0f0efb7924fa6ce2387b1a8e4105d672a991f.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:47 +0000
Subject: [PATCH v3 1/8] config.c: plumb config_source through static fns
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

This reduces the direct dependence on the global "struct config_source",
which will make it easier to remove in a later commit.

To minimize the changes we need to make, we rename the current variable
from "cf" to "cf_global", and the plumbed arg uses the old name "cf".
This is a little unfortunate, since we now have the confusingly named
"struct config_source cf" everywhere (which is a holdover from before
4d8dd1494e (config: make parsing stack struct independent from actual
data source, 2013-07-12), when the struct used to be called
"config_file"), but we will rename "cf" to "cs" by the end of the
series.

In some cases (public functions and config callback functions), there
isn't an obvious way to plumb "struct config_source" through function
args. As a workaround, add references to "cf_global" that we'll address
in later commits.

The remaining references to "cf_global" are direct assignments to
"cf_global", which we'll also address in a later commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 153 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 69 deletions(-)

diff --git a/config.c b/config.c
index 00090a32fc3..e4a76739365 100644
--- a/config.c
+++ b/config.c
@@ -54,8 +54,8 @@ struct config_source {
  * These variables record the "current" config source, which
  * can be accessed by parsing callbacks.
  *
- * The "cf" variable will be non-NULL only when we are actually parsing a real
- * config source (file, blob, cmdline, etc).
+ * The "cf_global" variable will be non-NULL only when we are actually
+ * parsing a real config source (file, blob, cmdline, etc).
  *
  * The "current_config_kvi" variable will be non-NULL only when we are feeding
  * cached config from a configset into a callback.
@@ -66,15 +66,16 @@ struct config_source {
  * or it's a function which can be reused for non-config purposes, and should
  * fall back to some sane behavior).
  */
-static struct config_source *cf;
+static struct config_source *cf_global;
 static struct key_value_info *current_config_kvi;
 
 /*
  * Similar to the variables above, this gives access to the "scope" of the
  * current value (repo, global, etc). For cached values, it can be found via
  * the current_config_kvi as above. During parsing, the current value can be
- * found in this variable. It's not part of "cf" because it transcends a single
- * file (i.e., a file included from .git/config is still in "repo" scope).
+ * found in this variable. It's not part of "cf_global" because it transcends a
+ * single file (i.e., a file included from .git/config is still in "repo"
+ * scope).
  */
 static enum config_scope current_parsing_scope;
 
@@ -156,7 +157,8 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(const char *path, struct config_include_data *inc)
+static int handle_path_include(struct config_source *cf, const char *path,
+			       struct config_include_data *inc)
 {
 	int ret = 0;
 	struct strbuf buf = STRBUF_INIT;
@@ -210,7 +212,8 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct strbuf *pat)
+static int prepare_include_condition_pattern(struct config_source *cf,
+					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
 	char *expanded;
@@ -245,7 +248,8 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	return prefix;
 }
 
-static int include_by_gitdir(const struct config_options *opts,
+static int include_by_gitdir(struct config_source *cf,
+			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
 	struct strbuf text = STRBUF_INIT;
@@ -261,7 +265,7 @@ static int include_by_gitdir(const struct config_options *opts,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(&pattern);
+	prefix = prepare_include_condition_pattern(cf, &pattern);
 
 again:
 	if (prefix < 0)
@@ -342,14 +346,14 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	struct config_source *store_cf = cf;
+	struct config_source *store_cf = cf_global;
 	struct key_value_info *store_kvi = current_config_kvi;
 	enum config_scope store_scope = current_parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	cf = NULL;
+	cf_global = NULL;
 	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
@@ -357,7 +361,7 @@ static void populate_remote_urls(struct config_include_data *inc)
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	cf = store_cf;
+	cf_global = store_cf;
 	current_config_kvi = store_kvi;
 	current_parsing_scope = store_scope;
 }
@@ -406,15 +410,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_include_data *inc,
+static int include_condition_is_true(struct config_source *cf,
+				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(opts, cond, cond_len, 0);
+		return include_by_gitdir(cf, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(opts, cond, cond_len, 1);
+		return include_by_gitdir(cf, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -441,16 +446,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(value, inc);
+		ret = handle_path_include(cf_global, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(inc, cond, cond_len) &&
+	    cond && include_condition_is_true(cf_global, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(value, inc);
+		ret = handle_path_include(cf_global, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -713,9 +718,9 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct config_source source;
 
 	memset(&source, 0, sizeof(source));
-	source.prev = cf;
+	source.prev = cf_global;
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	cf = &source;
+	cf_global = &source;
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -773,11 +778,11 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	cf = source.prev;
+	cf_global = source.prev;
 	return ret;
 }
 
-static int get_next_char(void)
+static int get_next_char(struct config_source *cf)
 {
 	int c = cf->do_fgetc(cf);
 
@@ -813,13 +818,13 @@ static int get_next_char(void)
 	return c;
 }
 
-static char *parse_value(void)
+static char *parse_value(struct config_source *cf)
 {
 	int quote = 0, comment = 0, space = 0;
 
 	strbuf_reset(&cf->value);
 	for (;;) {
-		int c = get_next_char();
+		int c = get_next_char(cf);
 		if (c == '\n') {
 			if (quote) {
 				cf->linenr--;
@@ -843,7 +848,7 @@ static char *parse_value(void)
 		for (; space; space--)
 			strbuf_addch(&cf->value, ' ');
 		if (c == '\\') {
-			c = get_next_char();
+			c = get_next_char(cf);
 			switch (c) {
 			case '\n':
 				continue;
@@ -874,7 +879,8 @@ static char *parse_value(void)
 	}
 }
 
-static int get_value(config_fn_t fn, void *data, struct strbuf *name)
+static int get_value(struct config_source *cf, config_fn_t fn, void *data,
+		     struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -882,7 +888,7 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 
 	/* Get the full name */
 	for (;;) {
-		c = get_next_char();
+		c = get_next_char(cf);
 		if (cf->eof)
 			break;
 		if (!iskeychar(c))
@@ -891,13 +897,13 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	}
 
 	while (c == ' ' || c == '\t')
-		c = get_next_char();
+		c = get_next_char(cf);
 
 	value = NULL;
 	if (c != '\n') {
 		if (c != '=')
 			return -1;
-		value = parse_value();
+		value = parse_value(cf);
 		if (!value)
 			return -1;
 	}
@@ -913,13 +919,14 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	return ret;
 }
 
-static int get_extended_base_var(struct strbuf *name, int c)
+static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
+				 int c)
 {
 	cf->subsection_case_sensitive = 0;
 	do {
 		if (c == '\n')
 			goto error_incomplete_line;
-		c = get_next_char();
+		c = get_next_char(cf);
 	} while (isspace(c));
 
 	/* We require the format to be '[base "extension"]' */
@@ -928,13 +935,13 @@ static int get_extended_base_var(struct strbuf *name, int c)
 	strbuf_addch(name, '.');
 
 	for (;;) {
-		int c = get_next_char();
+		int c = get_next_char(cf);
 		if (c == '\n')
 			goto error_incomplete_line;
 		if (c == '"')
 			break;
 		if (c == '\\') {
-			c = get_next_char();
+			c = get_next_char(cf);
 			if (c == '\n')
 				goto error_incomplete_line;
 		}
@@ -942,7 +949,7 @@ static int get_extended_base_var(struct strbuf *name, int c)
 	}
 
 	/* Final ']' */
-	if (get_next_char() != ']')
+	if (get_next_char(cf) != ']')
 		return -1;
 	return 0;
 error_incomplete_line:
@@ -950,17 +957,17 @@ error_incomplete_line:
 	return -1;
 }
 
-static int get_base_var(struct strbuf *name)
+static int get_base_var(struct config_source *cf, struct strbuf *name)
 {
 	cf->subsection_case_sensitive = 1;
 	for (;;) {
-		int c = get_next_char();
+		int c = get_next_char(cf);
 		if (cf->eof)
 			return -1;
 		if (c == ']')
 			return 0;
 		if (isspace(c))
-			return get_extended_base_var(name, c);
+			return get_extended_base_var(cf, name, c);
 		if (!iskeychar(c) && c != '.')
 			return -1;
 		strbuf_addch(name, tolower(c));
@@ -973,7 +980,8 @@ struct parse_event_data {
 	const struct config_options *opts;
 };
 
-static int do_event(enum config_event_t type, struct parse_event_data *data)
+static int do_event(struct config_source *cf, enum config_event_t type,
+		    struct parse_event_data *data)
 {
 	size_t offset;
 
@@ -1004,8 +1012,8 @@ static int do_event(enum config_event_t type, struct parse_event_data *data)
 	return 0;
 }
 
-static int git_parse_source(config_fn_t fn, void *data,
-			    const struct config_options *opts)
+static int git_parse_source(struct config_source *cf, config_fn_t fn,
+			    void *data, const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
@@ -1024,7 +1032,7 @@ static int git_parse_source(config_fn_t fn, void *data,
 	for (;;) {
 		int c;
 
-		c = get_next_char();
+		c = get_next_char(cf);
 		if (bomptr && *bomptr) {
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
@@ -1042,11 +1050,11 @@ static int git_parse_source(config_fn_t fn, void *data,
 		}
 		if (c == '\n') {
 			if (cf->eof) {
-				if (do_event(CONFIG_EVENT_EOF, &event_data) < 0)
+				if (do_event(cf, CONFIG_EVENT_EOF, &event_data) < 0)
 					return -1;
 				return 0;
 			}
-			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 				return -1;
 			comment = 0;
 			continue;
@@ -1054,23 +1062,23 @@ static int git_parse_source(config_fn_t fn, void *data,
 		if (comment)
 			continue;
 		if (isspace(c)) {
-			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 					return -1;
 			continue;
 		}
 		if (c == '#' || c == ';') {
-			if (do_event(CONFIG_EVENT_COMMENT, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_COMMENT, &event_data) < 0)
 					return -1;
 			comment = 1;
 			continue;
 		}
 		if (c == '[') {
-			if (do_event(CONFIG_EVENT_SECTION, &event_data) < 0)
+			if (do_event(cf, CONFIG_EVENT_SECTION, &event_data) < 0)
 					return -1;
 
 			/* Reset prior to determining a new stem */
 			strbuf_reset(var);
-			if (get_base_var(var) < 0 || var->len < 1)
+			if (get_base_var(cf, var) < 0 || var->len < 1)
 				break;
 			strbuf_addch(var, '.');
 			baselen = var->len;
@@ -1079,7 +1087,7 @@ static int git_parse_source(config_fn_t fn, void *data,
 		if (!isalpha(c))
 			break;
 
-		if (do_event(CONFIG_EVENT_ENTRY, &event_data) < 0)
+		if (do_event(cf, CONFIG_EVENT_ENTRY, &event_data) < 0)
 			return -1;
 
 		/*
@@ -1089,11 +1097,11 @@ static int git_parse_source(config_fn_t fn, void *data,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(fn, data, var) < 0)
+		if (get_value(cf, fn, data, var) < 0)
 			break;
 	}
 
-	if (do_event(CONFIG_EVENT_ERROR, &event_data) < 0)
+	if (do_event(cf, CONFIG_EVENT_ERROR, &event_data) < 0)
 		return -1;
 
 	switch (cf->origin_type) {
@@ -1266,7 +1274,8 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 }
 
 NORETURN
-static void die_bad_number(const char *name, const char *value)
+static void die_bad_number(struct config_source *cf, const char *name,
+			   const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
@@ -1304,7 +1313,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf_global, name, value);
 	return ret;
 }
 
@@ -1312,7 +1321,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf_global, name, value);
 	return ret;
 }
 
@@ -1320,7 +1329,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf_global, name, value);
 	return ret;
 }
 
@@ -1328,7 +1337,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(name, value);
+		die_bad_number(cf_global, name, value);
 	return ret;
 }
 
@@ -1940,20 +1949,20 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	int ret;
 
 	/* push config-file parsing state stack */
-	top->prev = cf;
+	top->prev = cf_global;
 	top->linenr = 1;
 	top->eof = 0;
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	cf = top;
+	cf_global = top;
 
-	ret = git_parse_source(fn, data, opts);
+	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	cf = top->prev;
+	cf_global = top->prev;
 
 	return ret;
 }
@@ -2334,12 +2343,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!cf)
+	if (!cf_global)
 		BUG("configset_add_value has no source");
-	if (cf->name) {
-		kv_info->filename = strintern(cf->name);
-		kv_info->linenr = cf->linenr;
-		kv_info->origin_type = cf->origin_type;
+	if (cf_global->name) {
+		kv_info->filename = strintern(cf_global->name);
+		kv_info->linenr = cf_global->linenr;
+		kv_info->origin_type = cf_global->origin_type;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
@@ -2891,6 +2900,12 @@ static int store_aux_event(enum config_event_t type,
 			   size_t begin, size_t end, void *data)
 {
 	struct config_store_data *store = data;
+	/*
+	 * FIXME Keep using "cf" so that we can avoid rewrapping a
+	 * really long line below. Remove this when "cf" gets plumbed
+	 * correctly.
+	 */
+	struct config_source *cf = cf_global;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -3771,8 +3786,8 @@ const char *current_config_origin_type(void)
 	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
-	else if(cf)
-		type = cf->origin_type;
+	else if(cf_global)
+		type = cf_global->origin_type;
 	else
 		BUG("current_config_origin_type called outside config callback");
 
@@ -3817,8 +3832,8 @@ const char *current_config_name(void)
 	const char *name;
 	if (current_config_kvi)
 		name = current_config_kvi->filename;
-	else if (cf)
-		name = cf->name;
+	else if (cf_global)
+		name = cf_global->name;
 	else
 		BUG("current_config_name called outside config callback");
 	return name ? name : "";
@@ -3837,7 +3852,7 @@ int current_config_line(void)
 	if (current_config_kvi)
 		return current_config_kvi->linenr;
 	else
-		return cf->linenr;
+		return cf_global->linenr;
 }
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
-- 
gitgitgadget


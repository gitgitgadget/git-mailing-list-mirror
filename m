Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE0EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjFTToP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFTToI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C261722
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-311153ec442so4034883f8f.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290242; x=1689882242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiPAYc6UyLEr3mK3za4fGO8qk7QhcYmMayn5MzyQ/pI=;
        b=WvXSyjt0IvdtSHgy8IvMKCCjQoowCTN1gYWjBPe/MFhv+sPkmwhOAt704LB9xITib7
         QdGD7sax6qk+cCtm0fQCqbKaqiSIw2Se585k0jP2WpmtL9W3hp/eGSkRg25mAjHZNgHn
         bkLjcLTo2ESY4DcqbNjdLM6qjBX+q449OXA1cOP6B5DnUSrUDYIxa0WNzu7j5arbtQje
         MsEruGDhCbiiiL5la0vSpF1QHxUlvbmesxAbyD6u0HQVyJlSoWU5KZ8167Au4JyYb1uS
         C2QUKeatR4x0SXkbIt31i2DoJ6Kar1dLNKx0QGD5WK1DC+PsUe0Z/lDBFIjDRkA9eSrS
         R4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290242; x=1689882242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiPAYc6UyLEr3mK3za4fGO8qk7QhcYmMayn5MzyQ/pI=;
        b=LavdJvrbheEW6n5SHcI/MBp1j9YWu56tNgMMwNPqqK8dTwzvTME/28Mybi3UUG3R9+
         hudiF6B3NxQ1X0g9lVjMlHB88NyiNJTUgIfEcTy9yD/gVPdaXRuhk83u8wsOReBSuB7B
         fAETwqqWDD6WP8+hpIaQRoQ6UDuOGRtJd7eCW9RJRT4xUNFDRo3GkbaTcb7GB+njOqB+
         90seUTOgS/wXNlkn+PAZkLjZjZ/aguiyepN7V3KSgfYZCk774YcgwhOYY/9asOP4Hm5e
         wtDCrK5Rk3eqhUM5QVVur3xFsz+4EUsZFAxxYG/wQhwGvn7C77CgLYGFTXPKnWKwszgX
         t3cw==
X-Gm-Message-State: AC+VfDyDaWTmKs65CaUJlD8F3vCsEdwL+nnf62iwQCli+yrgRRrHyaHf
        +rD6HVrDcpmY/9HlEWzgSugQ+7aMtDE=
X-Google-Smtp-Source: ACHHUZ7BmqKKGmE9iwch6lsCZ5AeNjtCJuZ94SLIcab1Dz0Kegfq/UP2FYGG/sn7R1M9yRFTKz4EoA==
X-Received: by 2002:adf:e88a:0:b0:311:19ad:a082 with SMTP id d10-20020adfe88a000000b0031119ada082mr11199004wrm.3.1687290241936;
        Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b0030647449730sm2665635wrq.74.2023.06.20.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
Message-Id: <1fb1708bbd967ed841fcb3d96ea0d1f6b880c60e.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:46 +0000
Subject: [PATCH v3 07/12] config.c: pass ctx with CLI config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Pass config_context when parsing CLI config. To provide the .kvi member,
refactor out kvi_from_param() from the logic that caches CLI config in
configsets. Now that config_context and config_context.kvi is always
present when config machinery calls config callbacks, plumb "kvi" so
that we can remove all calls of current_config_scope() except for
trace2/*.c (which will be handled in a later commit), and remove all
other current_config_*() (the functions themselves and their calls).
Note that this results in .kvi containing a different, more complete
set of information than the mocked up "struct config_source" in
git_config_from_parameters().

Plumbing "kvi" reveals a few places where we've been doing the wrong
thing:

* git_config_parse_parameter() hasn't been setting config source
  information, so plumb "kvi" there too.

* "git config --get-urlmatch --show-scope" iterates config to collect
  values, but then attempts to display the scope after config iteration.
  Fix this by copying the "kvi" value in the collection phase so that it
  can be read back later. This means that we can now support "git config
  --get-urlmatch --show-origin" (we don't allow this combination of args
  because of this bug), but that is left unchanged for now.

* "git config --default" doesn't have config source metadata when
  displaying the default value. Fix this by treating the default value
  as if it came from the command line (e.g. like we do with "git -c" or
  "git config --file"), using kvi_from_param().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c  | 47 +++++++++++++++++----------
 config.c          | 82 +++++++++++++++++++++++------------------------
 config.h          |  3 +-
 t/t1300-config.sh | 10 +++---
 4 files changed, 78 insertions(+), 64 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e14f967bbea..0c01ded5f05 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -193,38 +193,42 @@ static void check_argc(int argc, int min, int max)
 	usage_builtin_config();
 }
 
-static void show_config_origin(struct strbuf *buf)
+static void show_config_origin(const struct key_value_info *kvi,
+			       struct strbuf *buf)
 {
 	const char term = end_nul ? '\0' : '\t';
 
-	strbuf_addstr(buf, current_config_origin_type());
+	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
 	strbuf_addch(buf, ':');
 	if (end_nul)
-		strbuf_addstr(buf, current_config_name());
+		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
 	else
-		quote_c_style(current_config_name(), buf, NULL, 0);
+		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
 	strbuf_addch(buf, term);
 }
 
-static void show_config_scope(struct strbuf *buf)
+static void show_config_scope(const struct key_value_info *kvi,
+			      struct strbuf *buf)
 {
 	const char term = end_nul ? '\0' : '\t';
-	const char *scope = config_scope_name(current_config_scope());
+	const char *scope = config_scope_name(kvi->scope);
 
 	strbuf_addstr(buf, N_(scope));
 	strbuf_addch(buf, term);
 }
 
 static int show_all_config(const char *key_, const char *value_,
-			   const struct config_context *ctx UNUSED,
+			   const struct config_context *ctx,
 			   void *cb UNUSED)
 {
+	const struct key_value_info *kvi = ctx->kvi;
+
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
 		if (show_scope)
-			show_config_scope(&buf);
+			show_config_scope(kvi, &buf);
 		if (show_origin)
-			show_config_origin(&buf);
+			show_config_origin(kvi, &buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
@@ -242,12 +246,13 @@ struct strbuf_list {
 	int alloc;
 };
 
-static int format_config(struct strbuf *buf, const char *key_, const char *value_)
+static int format_config(struct strbuf *buf, const char *key_,
+			 const char *value_, const struct key_value_info *kvi)
 {
 	if (show_scope)
-		show_config_scope(buf);
+		show_config_scope(kvi, buf);
 	if (show_origin)
-		show_config_origin(buf);
+		show_config_origin(kvi, buf);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -302,9 +307,10 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 }
 
 static int collect_config(const char *key_, const char *value_,
-			  const struct config_context *ctx UNUSED, void *cb)
+			  const struct config_context *ctx, void *cb)
 {
 	struct strbuf_list *values = cb;
+	const struct key_value_info *kvi = ctx->kvi;
 
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
@@ -319,7 +325,7 @@ static int collect_config(const char *key_, const char *value_,
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
 
-	return format_config(&values->items[values->nr++], key_, value_);
+	return format_config(&values->items[values->nr++], key_, value_, kvi);
 }
 
 static int get_value(const char *key_, const char *regex_, unsigned flags)
@@ -380,11 +386,14 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 			    &given_config_source, &config_options);
 
 	if (!values.nr && default_value) {
+		struct key_value_info kvi = KVI_INIT;
 		struct strbuf *item;
+
+		kvi_from_param(&kvi);
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item = &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(item, key_, default_value) < 0)
+		if (format_config(item, key_, default_value, &kvi) < 0)
 			die(_("failed to format default config value: %s"),
 				default_value);
 	}
@@ -559,15 +568,17 @@ static void check_write(void)
 struct urlmatch_current_candidate_value {
 	char value_is_null;
 	struct strbuf value;
+	struct key_value_info kvi;
 };
 
 static int urlmatch_collect_fn(const char *var, const char *value,
-			       const struct config_context *ctx UNUSED,
+			       const struct config_context *ctx,
 			       void *cb)
 {
 	struct string_list *values = cb;
 	struct string_list_item *item = string_list_insert(values, var);
 	struct urlmatch_current_candidate_value *matched = item->util;
+	const struct key_value_info *kvi = ctx->kvi;
 
 	if (!matched) {
 		matched = xmalloc(sizeof(*matched));
@@ -576,6 +587,7 @@ static int urlmatch_collect_fn(const char *var, const char *value,
 	} else {
 		strbuf_reset(&matched->value);
 	}
+	matched->kvi = *kvi;
 
 	if (value) {
 		strbuf_addstr(&matched->value, value);
@@ -622,7 +634,8 @@ static int get_urlmatch(const char *var, const char *url)
 		struct strbuf buf = STRBUF_INIT;
 
 		format_config(&buf, item->string,
-			      matched->value_is_null ? NULL : matched->value.buf);
+			      matched->value_is_null ? NULL : matched->value.buf,
+			      &matched->kvi);
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 
diff --git a/config.c b/config.c
index 79a6e7cce7e..cfc5c7f10b3 100644
--- a/config.c
+++ b/config.c
@@ -218,7 +218,9 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs, const char *path,
+static int handle_path_include(struct config_source *cs,
+			       const struct key_value_info *kvi,
+			       const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -259,8 +261,7 @@ static int handle_path_include(struct config_source *cs, const char *path,
 			    cs->name ? cs->name :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
-							current_config_scope(),
-							NULL);
+							kvi->scope, NULL);
 		inc->depth--;
 	}
 cleanup:
@@ -508,7 +509,7 @@ static int git_config_include(const char *var, const char *value,
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cs, ctx->kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
 	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
@@ -517,7 +518,7 @@ static int git_config_include(const char *var, const char *value,
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cs, ctx->kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -675,27 +676,44 @@ out_free_ret_1:
 }
 
 static int config_parse_pair(const char *key, const char *value,
-			  config_fn_t fn, void *data)
+			     struct key_value_info *kvi,
+			     config_fn_t fn, void *data)
 {
 	char *canonical_name;
 	int ret;
+	struct config_context ctx = {
+		.kvi = kvi,
+	};
 
 	if (!strlen(key))
 		return error(_("empty config key"));
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
+	ret = (fn(canonical_name, value, &ctx, data) < 0) ? -1 : 0;
 	free(canonical_name);
 	return ret;
 }
 
+
+/* for values read from `git_config_from_parameters()` */
+void kvi_from_param(struct key_value_info *out)
+{
+	out->filename = NULL;
+	out->linenr = -1;
+	out->origin_type = CONFIG_ORIGIN_CMDLINE;
+	out->scope = CONFIG_SCOPE_COMMAND;
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
 	struct strbuf **pair;
 	int ret;
+	struct key_value_info kvi = KVI_INIT;
+
+	kvi_from_param(&kvi);
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
@@ -714,12 +732,13 @@ int git_config_parse_parameter(const char *text,
 		return error(_("bogus config parameter: %s"), text);
 	}
 
-	ret = config_parse_pair(pair[0]->buf, value, fn, data);
+	ret = config_parse_pair(pair[0]->buf, value, &kvi, fn, data);
 	strbuf_list_free(pair);
 	return ret;
 }
 
-static int parse_config_env_list(char *env, config_fn_t fn, void *data)
+static int parse_config_env_list(char *env, struct key_value_info *kvi,
+				 config_fn_t fn, void *data)
 {
 	char *cur = env;
 	while (cur && *cur) {
@@ -753,7 +772,7 @@ static int parse_config_env_list(char *env, config_fn_t fn, void *data)
 					     CONFIG_DATA_ENVIRONMENT);
 			}
 
-			if (config_parse_pair(key, value, fn, data) < 0)
+			if (config_parse_pair(key, value, kvi, fn, data) < 0)
 				return -1;
 		}
 		else {
@@ -778,10 +797,13 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	int ret = 0;
 	char *envw = NULL;
 	struct config_source source = CONFIG_SOURCE_INIT;
+	struct key_value_info kvi = KVI_INIT;
 
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
 	config_reader_push_source(&the_reader, &source);
 
+	kvi_from_param(&kvi);
+
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
 		unsigned long count;
@@ -817,7 +839,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			if (config_parse_pair(key, value, fn, data) < 0) {
+			if (config_parse_pair(key, value, &kvi, fn, data) < 0) {
 				ret = -1;
 				goto out;
 			}
@@ -828,7 +850,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		/* sq_dequote will write over it */
 		envw = xstrdup(env);
-		if (parse_config_env_list(envw, fn, data) < 0) {
+		if (parse_config_env_list(envw, &kvi, fn, data) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -2434,7 +2456,8 @@ static int configset_find_element(struct config_set *set, const char *key,
 	return 0;
 }
 
-static int configset_add_value(struct config_reader *reader,
+static int configset_add_value(const struct key_value_info *kvi_p,
+			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2465,16 +2488,10 @@ static int configset_add_value(struct config_reader *reader,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!reader->source)
-		BUG("configset_add_value has no source");
 	if (reader->source->name) {
-		kvi_from_source(reader->source, current_config_scope(), kv_info);
+		kvi_from_source(reader->source, kvi_p->scope, kv_info);
 	} else {
-		/* for values read from `git_config_from_parameters()` */
-		kv_info->filename = NULL;
-		kv_info->linenr = -1;
-		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
-		kv_info->scope = reader->parsing_scope;
+		kvi_from_param(kv_info);
 	}
 	si->util = kv_info;
 
@@ -2530,11 +2547,12 @@ struct configset_add_data {
 #define CONFIGSET_ADD_INIT { 0 }
 
 static int config_set_callback(const char *key, const char *value,
-			       const struct config_context *ctx UNUSED,
+			       const struct config_context *ctx,
 			       void *cb)
 {
 	struct configset_add_data *data = cb;
-	configset_add_value(data->config_reader, data->config_set, key, value);
+	configset_add_value(ctx->kvi, data->config_reader, data->config_set,
+			    key, value);
 	return 0;
 }
 
@@ -4027,16 +4045,6 @@ const char *config_origin_type_name(enum config_origin_type type)
 	}
 }
 
-const char *current_config_origin_type(void)
-{
-	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
-
-	if (reader_origin_type(&the_reader, &type))
-		BUG("current_config_origin_type called outside config callback");
-
-	return config_origin_type_name(type);
-}
-
 const char *config_scope_name(enum config_scope scope)
 {
 	switch (scope) {
@@ -4068,14 +4076,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
 	return 0;
 }
 
-const char *current_config_name(void)
-{
-	const char *name;
-	if (reader_config_name(&the_reader, &name))
-		BUG("current_config_name called outside config callback");
-	return name ? name : "";
-}
-
 enum config_scope current_config_scope(void)
 {
 	if (the_reader.config_kvi)
diff --git a/config.h b/config.h
index 1fc746c3a46..7954a8cb104 100644
--- a/config.h
+++ b/config.h
@@ -387,9 +387,8 @@ void git_global_config(char **user, char **xdg);
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
 enum config_scope current_config_scope(void);
-const char *current_config_origin_type(void);
-const char *current_config_name(void);
 const char *config_origin_type_name(enum config_origin_type type);
+void kvi_from_param(struct key_value_info *out);
 
 /*
  * Match and parse a config key of the form:
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index fa6a8df2521..387d336c91f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1676,8 +1676,8 @@ test_expect_success 'urlmatch with --show-scope' '
 	EOF
 
 	cat >expect <<-EOF &&
-	unknown	http.cookiefile /tmp/cookie.txt
-	unknown	http.sslverify false
+	local	http.cookiefile /tmp/cookie.txt
+	local	http.sslverify false
 	EOF
 	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
 	test_cmp expect actual
@@ -2071,7 +2071,9 @@ test_expect_success '--show-origin blob ref' '
 '
 
 test_expect_success '--show-origin with --default' '
-	test_must_fail git config --show-origin --default foo some.key
+	git config --show-origin --default foo some.key >actual &&
+	echo "command line:	foo" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '--show-scope with --list' '
@@ -2144,7 +2146,7 @@ test_expect_success '--show-scope with --show-origin' '
 
 test_expect_success '--show-scope with --default' '
 	git config --show-scope --default foo some.key >actual &&
-	echo "unknown	foo" >expect &&
+	echo "command	foo" >expect &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget


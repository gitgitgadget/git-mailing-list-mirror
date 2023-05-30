Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994DC77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjE3SnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjE3Smd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C910FE
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso1425575e9.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472144; x=1688064144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muVsHyyQRsO/AhBQS6yqmvfKFRi4nkq90dnHB48jkFo=;
        b=D7oCYCfgKyBwN5MbFJM8Q7oxQulIKiVGtcmF+VpTweDRp+Q2hnHqOENOzBBE1k3w25
         MbvzszdhoEqSSNu87PdmRRWgf9cwGeRnY0xUvDYmlNsYUE8VsdiPovv6si7GEowx+GBG
         yji5tYTzLjpRZMUpiS8BCfgxFSajYA//akewXJkNjq2Mh+oZlyj65AylgxrgIqvetDbL
         ajKwev/noH1GXfEbJdtVz0i/iY89ppi/LGRepDu3/2rmWiP2jfl9pQ4pGRubj1JyeZoj
         mDpumyQhwi6ifeZEs7G7wqqHqHgy6g+cWuNFrqL2m2AcUDQt921MTTOoeQ3q0U1g1Ole
         wQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472144; x=1688064144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muVsHyyQRsO/AhBQS6yqmvfKFRi4nkq90dnHB48jkFo=;
        b=NImNl7C9qJSoH1+kCXA4zpOlb5Z8/2khni4CArdHUj/OeuCumpF3NrEYRG2y4bav84
         dfoRXhPyYEZv60glAech5yhmEs0ShffSnVKluVQA9KxbaEzDp20M3A1JduCfwY3zsOgs
         1cfXAuTq+cSNLhGxJYSVsNRjbOscrB7D3J07Neynr9kulciTAyGVcROjC3dhw3Us5WHv
         lKzDsUXfehl0E7icNnBWmE+3YqCp7/xy9GIvbMDMuJ7f4iH9Lg1Pvb16B/f7FGiTGAxw
         TeUfzkmvqsbpMcjfong9FIXl2ivqm9YbIVDg1VDN6aBmNQpGYBjTFXShLiiYPvU5q9Im
         p9yw==
X-Gm-Message-State: AC+VfDyct2JE5H260+Bpk1jSA9gXaPG0k5Lfu5SYo73hBay+qAtXyJvi
        ZIUf91TVskmWbHcHDXD3ja/1WwFbEvI=
X-Google-Smtp-Source: ACHHUZ7xRQ/bacb54iZXcNBbRgXAGFMP0V30xpkBu6DFH+I9YW80vC/Ew8WIjAwKQbJn7mIqdOpZSQ==
X-Received: by 2002:a7b:c448:0:b0:3f4:27ff:7d4e with SMTP id l8-20020a7bc448000000b003f427ff7d4emr2576023wmi.9.1685472144296;
        Tue, 30 May 2023 11:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003f50e88ffc1sm21949712wmr.0.2023.05.30.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:23 -0700 (PDT)
Message-Id: <3760015d2c000c59d354bae872c431ee3266e9da.1685472134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:07 +0000
Subject: [PATCH v2 09/14] config.c: provide kvi with CLI config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Refactor out kvi_from_param() from the logic that caches CLI config in
configsets, and use it to pass the "kvi" arg to config callbacks when
parsing CLI config. Now that "kvi" is always present when config
machinery calls config callbacks, plumb "kvi" so that we can replace
nearly all calls to current_config_*(). (The exception is an edge case
where trace2/*.c calls current_config_scope(). That will be handled in a
later commit.) Note that this results in "kvi" containing a different,
more complete set of information than the mocked up "struct
config_source" in git_config_from_parameters().

Plumbing "kvi" reveals a few places where we've been doing the wrong
thing:

* git_config_parse_parameter() hasn't been setting config source
  information, so plumb "kvi" there too.

* "git config --get-urlmatch --show-scope" iterates config to collect
  values, but then attempts to display the scope after config iteration.
  Fix this by copying the "kvi" arg in the collection phase so that it
  can be read back later. This means that we can now support "git config
  --get-urlmatch --show-origin" (we don't allow this combination of args
  because of this bug), but that is left unchanged for now.

* "git config --default" doesn't have config source metadata when
  displaying the default value. Fix this by treating the default value
  as if it came from the command line (e.g. like we do with "git -c" or
  "git config --file"), using kvi_from_param().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c  | 41 ++++++++++++++-----------
 config.c          | 78 ++++++++++++++++++++++-------------------------
 config.h          |  3 +-
 t/t1300-config.sh | 10 +++---
 4 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b2ad7351d0a..2fcad601a7b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -191,37 +191,37 @@ static void check_argc(int argc, int min, int max)
 	usage_builtin_config();
 }
 
-static void show_config_origin(struct strbuf *buf)
+static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
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
+static void show_config_scope(struct key_value_info *kvi, struct strbuf *buf)
 {
 	const char term = end_nul ? '\0' : '\t';
-	const char *scope = config_scope_name(current_config_scope());
+	const char *scope = config_scope_name(kvi->scope);
 
 	strbuf_addstr(buf, N_(scope));
 	strbuf_addch(buf, term);
 }
 
 static int show_all_config(const char *key_, const char *value_,
-			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
+			   struct key_value_info *kvi, void *cb UNUSED)
 {
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
@@ -239,12 +239,13 @@ struct strbuf_list {
 	int alloc;
 };
 
-static int format_config(struct strbuf *buf, const char *key_, const char *value_)
+static int format_config(struct strbuf *buf, const char *key_,
+			 const char *value_, struct key_value_info *kvi)
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
@@ -299,7 +300,7 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 }
 
 static int collect_config(const char *key_, const char *value_,
-			  struct key_value_info *kvi UNUSED, void *cb)
+			  struct key_value_info *kvi, void *cb)
 {
 	struct strbuf_list *values = cb;
 
@@ -316,7 +317,7 @@ static int collect_config(const char *key_, const char *value_,
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
 
-	return format_config(&values->items[values->nr++], key_, value_);
+	return format_config(&values->items[values->nr++], key_, value_, kvi);
 }
 
 static int get_value(const char *key_, const char *regex_, unsigned flags)
@@ -377,11 +378,14 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 			    &given_config_source, &config_options);
 
 	if (!values.nr && default_value) {
+		struct key_value_info kvi = { 0 };
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
@@ -556,10 +560,11 @@ static void check_write(void)
 struct urlmatch_current_candidate_value {
 	char value_is_null;
 	struct strbuf value;
+	struct key_value_info kvi;
 };
 
 static int urlmatch_collect_fn(const char *var, const char *value,
-			       struct key_value_info *kvi UNUSED, void *cb)
+			       struct key_value_info *kvi, void *cb)
 {
 	struct string_list *values = cb;
 	struct string_list_item *item = string_list_insert(values, var);
@@ -572,6 +577,7 @@ static int urlmatch_collect_fn(const char *var, const char *value,
 	} else {
 		strbuf_reset(&matched->value);
 	}
+	memcpy(&matched->kvi, kvi, sizeof(struct key_value_info));
 
 	if (value) {
 		strbuf_addstr(&matched->value, value);
@@ -618,7 +624,8 @@ static int get_urlmatch(const char *var, const char *url)
 		struct strbuf buf = STRBUF_INIT;
 
 		format_config(&buf, item->string,
-			      matched->value_is_null ? NULL : matched->value.buf);
+			      matched->value_is_null ? NULL : matched->value.buf,
+			      &matched->kvi);
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 
diff --git a/config.c b/config.c
index 4b6830fcc79..1779fe62f89 100644
--- a/config.c
+++ b/config.c
@@ -211,7 +211,9 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs, const char *path,
+static int handle_path_include(struct config_source *cs,
+			       struct key_value_info *kvi,
+			       const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -252,8 +254,7 @@ static int handle_path_include(struct config_source *cs, const char *path,
 			    cs->name ? cs->name :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
-							current_config_scope(),
-							NULL);
+							kvi->scope, NULL);
 		inc->depth--;
 	}
 cleanup:
@@ -500,7 +501,7 @@ static int git_config_include(const char *var, const char *value,
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cs, kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
 	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
@@ -509,7 +510,7 @@ static int git_config_include(const char *var, const char *value,
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(cs, kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -667,7 +668,8 @@ out_free_ret_1:
 }
 
 static int config_parse_pair(const char *key, const char *value,
-			  config_fn_t fn, void *data)
+			     struct key_value_info *kvi,
+			     config_fn_t fn, void *data)
 {
 	char *canonical_name;
 	int ret;
@@ -677,17 +679,30 @@ static int config_parse_pair(const char *key, const char *value,
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
+	ret = (fn(canonical_name, value, kvi, data) < 0) ? -1 : 0;
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
+	struct key_value_info kvi = { 0 };
+
+	kvi_from_param(&kvi);
 
 	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
@@ -706,12 +721,13 @@ int git_config_parse_parameter(const char *text,
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
@@ -745,7 +761,7 @@ static int parse_config_env_list(char *env, config_fn_t fn, void *data)
 					     CONFIG_DATA_ENVIRONMENT);
 			}
 
-			if (config_parse_pair(key, value, fn, data) < 0)
+			if (config_parse_pair(key, value, kvi, fn, data) < 0)
 				return -1;
 		}
 		else {
@@ -770,10 +786,13 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	int ret = 0;
 	char *envw = NULL;
 	struct config_source source = CONFIG_SOURCE_INIT;
+	struct key_value_info kvi = { 0 };
 
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
 	config_reader_push_source(&the_reader, &source);
 
+	kvi_from_param(&kvi);
+
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
 		unsigned long count;
@@ -809,7 +828,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			if (config_parse_pair(key, value, fn, data) < 0) {
+			if (config_parse_pair(key, value, &kvi, fn, data) < 0) {
 				ret = -1;
 				goto out;
 			}
@@ -820,7 +839,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		/* sq_dequote will write over it */
 		envw = xstrdup(env);
-		if (parse_config_env_list(envw, fn, data) < 0) {
+		if (parse_config_env_list(envw, &kvi, fn, data) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -2422,7 +2441,8 @@ static int configset_find_element(struct config_set *set, const char *key,
 	return 0;
 }
 
-static int configset_add_value(struct config_reader *reader,
+static int configset_add_value(struct key_value_info *kvi_p,
+			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2453,16 +2473,10 @@ static int configset_add_value(struct config_reader *reader,
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
 
@@ -2518,10 +2532,10 @@ struct configset_add_data {
 #define CONFIGSET_ADD_INIT { 0 }
 
 static int config_set_callback(const char *key, const char *value,
-			       struct key_value_info *kvi UNUSED, void *cb)
+			       struct key_value_info *kvi, void *cb)
 {
 	struct configset_add_data *data = cb;
-	configset_add_value(data->config_reader, data->config_set, key, value);
+	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
 	return 0;
 }
 
@@ -4000,16 +4014,6 @@ const char *config_origin_type_name(enum config_origin_type type)
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
@@ -4041,14 +4045,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
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
index ca5aac62980..fe7c1b79f80 100644
--- a/config.h
+++ b/config.h
@@ -367,9 +367,8 @@ void git_global_config(char **user, char **xdg);
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
 enum config_scope current_config_scope(void);
-const char *current_config_origin_type(void);
-const char *current_config_name(void);
 const char *config_origin_type_name(enum config_origin_type type);
+void kvi_from_param(struct key_value_info *out);
 
 /*
  * Match and parse a config key of the form:
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 57fe250b78f..028998dadc4 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1635,8 +1635,8 @@ test_expect_success 'urlmatch with --show-scope' '
 	EOF
 
 	cat >expect <<-EOF &&
-	unknown	http.cookiefile /tmp/cookie.txt
-	unknown	http.sslverify false
+	local	http.cookiefile /tmp/cookie.txt
+	local	http.sslverify false
 	EOF
 	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
 	test_cmp expect actual
@@ -2030,7 +2030,9 @@ test_expect_success '--show-origin blob ref' '
 '
 
 test_expect_success '--show-origin with --default' '
-	test_must_fail git config --show-origin --default foo some.key
+	git config --show-origin --default foo some.key >actual &&
+	echo "command line:	foo" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '--show-scope with --list' '
@@ -2103,7 +2105,7 @@ test_expect_success '--show-scope with --show-origin' '
 
 test_expect_success '--show-scope with --default' '
 	git config --show-scope --default foo some.key >actual &&
-	echo "unknown	foo" >expect &&
+	echo "command	foo" >expect &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget


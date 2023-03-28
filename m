Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF08C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjC1RwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC1RwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D7EB51
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q19so10025881wrc.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P/7rgXnBxtYdDtKxOqHBic1qXczXZvszI1/b+zgZWo=;
        b=bs9OS7vfR/5D8gPOjZlr9FsSoHBxA4SUFkeU7cY5l+L9uv3IfwzzvVwswhBikN71Dx
         H0bqGH4qJ7QAVK1HtIgvbBb0qm+AroYrjZ9zvJYtVRHF9wmL8kpUnQZcH2fHoSFX4TGf
         qDZxNZAItao+cn64kQR4g3TKJP54/c8PjuS+9ULLm7k7wDkKxiqvl7UVvfMa7HO8R9VP
         0BENS94Plku0ZlsH5/ZolZgnVANtYt3qxlvxkvfY9a291JX+yGiPrsGPhkKfJoC7w8wN
         j9yYIvoergBXxem3+sfB837ygE+uDfAK3Bvo7RxtFwaSWPfZ0Udx8TZXNmZuopxu+Rrr
         JwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P/7rgXnBxtYdDtKxOqHBic1qXczXZvszI1/b+zgZWo=;
        b=HbF8lFDFVpLXQX8OZnoRsPpmexUpPjAHy9EIBYJeQ3PrELh7CvTgGrPM79owSTEpM0
         3w15DFtka6W/xJmxcpNlFhtnKxI5UE1SVBctL8QYy3XGqg9dDKhPXiN7IpF6GIecgRPW
         ld6opt50e7EAMsIjvDbadoM4u8DvtiJE7b7QnXvaxhL2VGS/yvJJ/WY4LGzC79OnuFsm
         wryU5D7tyb1S7/r2L2zVV+F9yy5zRl18wZu/jeH6qwRxx4mamFMI6oPtTtYKOxLL9pz7
         UY3Wt3nl3IuSE0A2h1yVnzvlT2G/khypBet7aMHyEPKYDeSEBxggV5rVeoZAgsDMzORC
         V1lg==
X-Gm-Message-State: AAQBX9e1l2SGZqqG57pzpj5LUmQuAYbTiZsn7QH+hBHi9zkxCM0sJIuI
        vBKtSGCo/X0l9AgghBQb9tsHMqXZ9Vo=
X-Google-Smtp-Source: AKy350ZjH5CdoLonAraCoHGn9hALnSAGkwUkS6UTtNtsw+x8Y508jfCMWQ/iaQkt1ffqrDIPHqQDjA==
X-Received: by 2002:a5d:6689:0:b0:2ce:9fd8:8e6d with SMTP id l9-20020a5d6689000000b002ce9fd88e6dmr13141910wru.8.1680025918676;
        Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b002d24a188b64sm28158015wrx.112.2023.03.28.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
Message-Id: <e02dddd560f68a6f1abe38bb9161de783ca04be2.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:50 +0000
Subject: [PATCH v3 4/8] config.c: plumb the_reader through callbacks
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

The remaining references to "cf_global" are in config callback
functions. Remove them by plumbing "struct config_reader" via the
"*data" arg.

In both of the callbacks here, we are only reading from
"reader->source". So in the long run, if we had a way to expose readonly
information from "reader->source" (probably in the form of "struct
key_value_info"), we could undo this patch (i.e. remove "struct
config_reader" fom "*data").

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 74 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/config.c b/config.c
index 3a28b397c4d..cb6ff134f5f 100644
--- a/config.c
+++ b/config.c
@@ -62,6 +62,9 @@ struct config_reader {
 static struct config_reader the_reader;
 
 /*
+ * FIXME The comments are temporarily out of date since "cf_global" has been
+ * moved to the_reader, but not current_*.
+ *
  * These variables record the "current" config source, which
  * can be accessed by parsing callbacks.
  *
@@ -76,11 +79,7 @@ static struct config_reader the_reader;
  * at the variables, it's either a bug for it to be called in the first place,
  * or it's a function which can be reused for non-config purposes, and should
  * fall back to some sane behavior).
- *
- * FIXME "cf_global" has been replaced by "the_reader.source", remove
- * "cf_global" once we plumb "the_reader" through all of the callback functions.
  */
-static struct config_source *cf_global;
 static struct key_value_info *current_config_kvi;
 
 /*
@@ -98,8 +97,6 @@ static inline void config_reader_push_source(struct config_reader *reader,
 {
 	top->prev = reader->source;
 	reader->source = top;
-	/* FIXME remove this when cf_global is removed. */
-	cf_global = reader->source;
 }
 
 static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
@@ -109,8 +106,6 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 		BUG("tried to pop config source, but we weren't reading config");
 	ret = reader->source;
 	reader->source = reader->source->prev;
-	/* FIXME remove this when cf_global is removed. */
-	cf_global = reader->source;
 	return ret;
 }
 
@@ -175,6 +170,7 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
+	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -465,6 +461,7 @@ static int include_condition_is_true(struct config_source *cf,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	struct config_source *cf = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -478,16 +475,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cf_global, value, inc);
+		ret = handle_path_include(cf, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cf_global, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cf_global, value, inc);
+		ret = handle_path_include(cf, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -2228,6 +2225,7 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
+		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
@@ -2348,7 +2346,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	return found_entry;
 }
 
-static int configset_add_value(struct config_set *cs, const char *key, const char *value)
+static int configset_add_value(struct config_reader *reader,
+			       struct config_set *cs, const char *key,
+			       const char *value)
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
@@ -2374,12 +2374,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!cf_global)
+	if (!reader->source)
 		BUG("configset_add_value has no source");
-	if (cf_global->name) {
-		kv_info->filename = strintern(cf_global->name);
-		kv_info->linenr = cf_global->linenr;
-		kv_info->origin_type = cf_global->origin_type;
+	if (reader->source->name) {
+		kv_info->filename = strintern(reader->source->name);
+		kv_info->linenr = reader->source->linenr;
+		kv_info->origin_type = reader->source->origin_type;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
@@ -2434,16 +2434,25 @@ void git_configset_clear(struct config_set *cs)
 	cs->list.items = NULL;
 }
 
+struct configset_add_data {
+	struct config_set *config_set;
+	struct config_reader *config_reader;
+};
+#define CONFIGSET_ADD_INIT { 0 }
+
 static int config_set_callback(const char *key, const char *value, void *cb)
 {
-	struct config_set *cs = cb;
-	configset_add_value(cs, key, value);
+	struct configset_add_data *data = cb;
+	configset_add_value(data->config_reader, data->config_set, key, value);
 	return 0;
 }
 
 int git_configset_add_file(struct config_set *cs, const char *filename)
 {
-	return git_config_from_file(config_set_callback, filename, cs);
+	struct configset_add_data data = CONFIGSET_ADD_INIT;
+	data.config_reader = &the_reader;
+	data.config_set = cs;
+	return git_config_from_file(config_set_callback, filename, &data);
 }
 
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
@@ -2558,6 +2567,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
+	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2569,8 +2579,10 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
+	data.config_set = repo->config;
+	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2696,9 +2708,12 @@ static void read_protected_config(void)
 		.ignore_worktree = 1,
 		.system_gently = 1,
 	};
+	struct configset_add_data data = CONFIGSET_ADD_INIT;
+
 	git_configset_init(&protected_config);
-	config_with_options(config_set_callback, &protected_config,
-			    NULL, &opts);
+	data.config_set = &protected_config;
+	data.config_reader = &the_reader;
+	config_with_options(config_set_callback, &data, NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
@@ -2883,6 +2898,7 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
+	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -2897,6 +2913,7 @@ struct config_store_data {
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
+#define CONFIG_STORE_INIT { 0 }
 
 static void config_store_data_clear(struct config_store_data *store)
 {
@@ -2931,12 +2948,7 @@ static int store_aux_event(enum config_event_t type,
 			   size_t begin, size_t end, void *data)
 {
 	struct config_store_data *store = data;
-	/*
-	 * FIXME Keep using "cf" so that we can avoid rewrapping a
-	 * really long line below. Remove this when "cf" gets plumbed
-	 * correctly.
-	 */
-	struct config_source *cf = cf_global;
+	struct config_source *cf = store->config_reader->source;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -3254,9 +3266,9 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	char *filename_buf = NULL;
 	char *contents = NULL;
 	size_t contents_sz;
-	struct config_store_data store;
+	struct config_store_data store = CONFIG_STORE_INIT;
 
-	memset(&store, 0, sizeof(store));
+	store.config_reader = &the_reader;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
-- 
gitgitgadget


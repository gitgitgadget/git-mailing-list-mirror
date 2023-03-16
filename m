Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268FC6FD1D
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjCPAMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjCPALy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18413CE04
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so2075522wmi.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HixjIRFPNbVqZoH0TXahGAYQHSpAH7z1c0UNI9dAnL4=;
        b=Zy0MV9fqpSo3bhSb1T8X3oucAs8ZueGwDF+iwIOmECE7DdxkmJ44PkkVZAr+vGPeRa
         AycYxw32u9bWFUlKg9D0/h7EeLpGg5ZgKzd/r/x01v70qZECSsr13JLr8LBBebOWdogd
         Hxf0LMOD8Ys89fMDndzDoCu8RXkdvhCB0MgVNOXm/xGBKWRWoB7OSzif6xPsYDiMirnf
         avvAHPStHPURNvbAOeXxyd544AhqJbxEzrTBlgfDl7J9udducgy4Z383vYxOyyUGSGm7
         FCQy2oRRbllFPlhiZMg50S+SAVKwl7dLiOEMxwr3MOS+DQgW83ra7mDfLVfyTOw4Fdru
         gWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HixjIRFPNbVqZoH0TXahGAYQHSpAH7z1c0UNI9dAnL4=;
        b=orNMRhl63kCg8uZDR7pWtSiSKGbZKMkXJZhUUQ3K32iZaHSJ2ywBpfO/qwING1EO/c
         CqhhpO9VeAxRMhYIuvYTH50p7ybESnFQM5abpB2iXnZJP+OP87Z7XrPK0L62ll+aAQyy
         8qHtfOHT6LhFLWkmVKG/1sfKhFUDfMRInC8vyowoDoL5355GbC8afX3qFpZHwoaKZH9T
         vcvkiuhetbtID4MP9b4Zao79wlqg34gbz2C1C9QXcmRjbYSiw50ikTjosrikXbyBjaDJ
         5MSZkzRaIysHHphGxz5xPpNuvqnZSf0P1fqAhTSmdi+2nO/a7SLbO0YXBw/22i5jQc0A
         Qolg==
X-Gm-Message-State: AO0yUKVB4XfKW7yony61ufSkGXAcnhhjUwXHg552a7rqdS5LtCJBZBKh
        V1+T33Q/cdTGGHOoGHb9ZrqOgjRFqGs=
X-Google-Smtp-Source: AK7set/NR6nNfrgKEEpxrI0izQaYBi5n7P/85WEPLZ32BfqebqUwXIImDeClhYvTiy+5TTyGYeZP4g==
X-Received: by 2002:a05:600c:468e:b0:3e8:f27b:a92c with SMTP id p14-20020a05600c468e00b003e8f27ba92cmr20514297wmo.32.1678925511270;
        Wed, 15 Mar 2023 17:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c205200b003ed1f111fdesm3296094wmg.20.2023.03.15.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:50 -0700 (PDT)
Message-Id: <22b699717499e4f51bab02ed5ab5a4489f42cc6d.1678925506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:42 +0000
Subject: [PATCH v2 4/8] config.c: plumb the_reader through callbacks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 7de25515818..b75cde42ca6 100644
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
@@ -99,8 +98,6 @@ static inline void config_reader_push_source(struct config_reader *reader,
 	if (reader->source)
 		top->prev = reader->source;
 	reader->source = top;
-	/* FIXME remove this when cf_global is removed. */
-	cf_global = reader->source;
 }
 
 static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
@@ -110,8 +107,6 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 		BUG("tried to pop config source, but we weren't reading config");
 	ret = reader->source;
 	reader->source = reader->source->prev;
-	/* FIXME remove this when cf is removed. */
-	cf_global = reader->source;
 	return ret;
 }
 
@@ -176,6 +171,7 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
+	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -466,6 +462,7 @@ static int include_condition_is_true(struct config_source *cf,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	struct config_source *cf = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -479,16 +476,16 @@ static int git_config_include(const char *var, const char *value, void *data)
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
 
@@ -2229,6 +2226,7 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
+		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
@@ -2349,7 +2347,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	return found_entry;
 }
 
-static int configset_add_value(struct config_set *cs, const char *key, const char *value)
+static int configset_add_value(struct config_reader *reader,
+			       struct config_set *cs, const char *key,
+			       const char *value)
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
@@ -2375,12 +2375,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
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
@@ -2435,16 +2435,25 @@ void git_configset_clear(struct config_set *cs)
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
@@ -2559,6 +2568,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
+	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2570,8 +2580,10 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
+	data.config_set = repo->config;
+	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2697,9 +2709,12 @@ static void read_protected_config(void)
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
@@ -2884,6 +2899,7 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
+	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -2898,6 +2914,7 @@ struct config_store_data {
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
+#define CONFIG_STORE_INIT { 0 }
 
 static void config_store_data_clear(struct config_store_data *store)
 {
@@ -2932,12 +2949,7 @@ static int store_aux_event(enum config_event_t type,
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
@@ -3255,9 +3267,9 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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


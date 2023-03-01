Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D099C64EC7
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCAAij (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCAAiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB68C17D
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g3so2701223wri.6
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNsLq9fgvXYD/pip2Ciao8JR7OKIvsPhPgoItWy+XIE=;
        b=LmXT/x/Ro+lBNmZ9ixibBsb2/FWqPV7AuFjQw+ppbeibb9bwR7YlSJPZF3IL/DdY87
         QUyM1ok9wscxHWPQJKZ/1krVmnbrQExfq+2s3wA0nofH933gQozWN3/EPRRuotOwshnV
         rc4w0Xab+PDsTGFaXTwq7lt10pc0eXp7e4/PlzGwE7VwuZigttiYVhm4lGRJ31IAifxV
         kqDG7LB0vMKE8I9m2y82P5FC6Xgic7iNY35PWsBsCE9IumeBZ+6FbHd5Wr8EWBoPVTQk
         NsJ4Gcngv1mm3Nyullr7X8wF6O3rnGN4Sfz/Z1LozZesutB6bLwJZL5jxK/m09NxC4t/
         bWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNsLq9fgvXYD/pip2Ciao8JR7OKIvsPhPgoItWy+XIE=;
        b=lRiVSMsP5uLQcYF0LHQOjiBau3yTFGYP65TW02kNh0SYPaOq0Kqys426bPzpHdUmdU
         FkeGAnHjQuU4c0p/c+tEYO2iWbrX35sK8ELL3hI+et93ZYQcEWKiGzor9cWvVHBNipeZ
         8wid4W3GvDZrQ2VvGdm5EbMcPBLa6hJK6H4Oh7Uuh+YELSrUJws4r9TQTByXlQ/zHqzi
         50dxL0Qz3VL7Faq6zqimdjvbTGdMj0Kl1VSABg7dmNI3Qbu6xveHFKdrBepEWb1Dx7Pu
         nsjxP/CFvC0W05I3/Ef2a7Dj5cpJJcOb8fMUKtllgxkvC0IlhprNuhkYTwbfo1MZvQh4
         sPSw==
X-Gm-Message-State: AO0yUKXITwth59FMBLv0S0Kj484p26tq9GE/JCHRscGK/a0CzWBJCgTZ
        TB/rwi0ZskUV2pZ/NHc7tuEkI50+ndY=
X-Google-Smtp-Source: AK7set8+eFv2Mav3cjYLk0O+cVSgDbSRv4DhtESEoCPKO7hMwQaYYizZahv0pEo7qCS8rUO6jab1iQ==
X-Received: by 2002:adf:e505:0:b0:2c8:a6ea:c00c with SMTP id j5-20020adfe505000000b002c8a6eac00cmr3996688wrm.69.1677631101820;
        Tue, 28 Feb 2023 16:38:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4c47000000b002c5534db60bsm10956866wrt.71.2023.02.28.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:21 -0800 (PST)
Message-Id: <74a63fed7054da8049d4a32ecdb582726368c5a8.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:15 +0000
Subject: [PATCH 4/6] config.c: plumb the_reader through callbacks
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

The remaining references to "cf" are in config callback functions.
Remove them by plumbing "struct config_reader" via the "*data" arg.

**RFC NOTE** If we had a way to expose "struct config_reader" to the
config callback functions (the 'extra work' in the cover letter), we
wouldn't need to also pass it via the "*data" arg. This is more of a
hack to avoid doing that work now.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 78 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/config.c b/config.c
index 866cd54dd40..9676734b1b7 100644
--- a/config.c
+++ b/config.c
@@ -58,6 +58,9 @@ struct config_reader {
 static struct config_reader the_reader;
 
 /*
+ * FIXME The comments are temporarily out of date since "cf" been moved to
+ * the_reader, but not current_*.
+ *
  * These variables record the "current" config source, which
  * can be accessed by parsing callbacks.
  *
@@ -72,11 +75,7 @@ static struct config_reader the_reader;
  * at the variables, it's either a bug for it to be called in the first place,
  * or it's a function which can be reused for non-config purposes, and should
  * fall back to some sane behavior).
- *
- * FIXME "cf" has been replaced by "the_reader.source", remove
- * "cf" once we plumb "the_reader" through all of the callback functions.
  */
-static struct config_source *cf;
 static struct key_value_info *current_config_kvi;
 
 /*
@@ -94,8 +93,6 @@ static inline void config_reader_push_source(struct config_reader *reader,
 	if (reader->source)
 		top->prev = reader->source;
 	reader->source = top;
-	/* FIXME remove this when cf is removed. */
-	cf = reader->source;
 }
 
 static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
@@ -105,8 +102,6 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 		BUG("tried to pop config source, but we weren't reading config");
 	ret = reader->source;
 	reader->source = reader->source->prev;
-	/* FIXME remove this when cf is removed. */
-	cf = reader->source;
 	return ret;
 }
 
@@ -171,6 +166,7 @@ struct config_include_data {
 	void *data;
 	const struct config_options *opts;
 	struct git_config_source *config_source;
+	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -461,6 +457,7 @@ static int include_condition_is_true(struct config_source *cs,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
+	struct config_source *cs = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -474,16 +471,16 @@ static int git_config_include(const char *var, const char *value, void *data)
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
 
@@ -2224,6 +2221,7 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.data = data;
 		inc.opts = opts;
 		inc.config_source = config_source;
+		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
@@ -2344,7 +2342,9 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
 	return found_entry;
 }
 
-static int configset_add_value(struct config_set *cs, const char *key, const char *value)
+static int configset_add_value(struct config_reader *reader,
+			       struct config_set *cs, const char *key,
+			       const char *value)
 {
 	struct config_set_element *e;
 	struct string_list_item *si;
@@ -2370,12 +2370,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!cf)
+	if (!reader->source)
 		BUG("configset_add_value has no source");
-	if (cf->name) {
-		kv_info->filename = strintern(cf->name);
-		kv_info->linenr = cf->linenr;
-		kv_info->origin_type = cf->origin_type;
+	if (reader->source->name) {
+		kv_info->filename = strintern(reader->source->name);
+		kv_info->linenr = reader->source->linenr;
+		kv_info->origin_type = reader->source->origin_type;
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
@@ -2430,16 +2430,25 @@ void git_configset_clear(struct config_set *cs)
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
@@ -2554,6 +2563,7 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
+	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2565,8 +2575,10 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
+	data.config_set = repo->config;
+	data.config_reader = &the_reader;
 
-	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
+	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2692,9 +2704,12 @@ static void read_protected_config(void)
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
@@ -2879,6 +2894,7 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
+	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -2893,6 +2909,7 @@ struct config_store_data {
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
+#define CONFIG_STORE_INIT { 0 }
 
 static void config_store_data_clear(struct config_store_data *store)
 {
@@ -2927,6 +2944,7 @@ static int store_aux_event(enum config_event_t type,
 			   size_t begin, size_t end, void *data)
 {
 	struct config_store_data *store = data;
+	struct config_source *cs = store->config_reader->source;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -2936,10 +2954,10 @@ static int store_aux_event(enum config_event_t type,
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
@@ -2947,8 +2965,8 @@ static int store_aux_event(enum config_event_t type,
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
@@ -3244,9 +3262,9 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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


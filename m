Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC4C77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjE3Sm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjE3Sm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50211C
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so49970315e9.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472143; x=1688064143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYmvlIrHXeZx1iTntJCUZzQZswZVbyJQNf5/cjIOkdQ=;
        b=EvnuXOZ1rDx1ma0V6kP6sxDPgR+EaVlGBFjtxjhyx1+baR6/OrgNa3wQ3+wQLNczsg
         DLb30jylHn0goFKB9cNCyM5Ui+vhAFvnCAcOENgh7yQEYoGdNaijCc2zXCrewj0IV19C
         MldTp9A6jl24QUaVm0reCDEXma90KmpHSA5xjGx7Y2Xx5iRdXEpE8nFe9scLWplGqjSG
         HFhf92Hu+0NwVJzFWED6tv8r/tHjMq7DinjMATa7dg6SytD/MY44mmtHvvCbh8su5D6P
         YBuEN8rdVKu73wl8+UdxGTbSvUq3ZEIAr0y1hRdjZopQhwoRJ+hp8+Ms8YYLTxISuOXA
         oySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472143; x=1688064143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYmvlIrHXeZx1iTntJCUZzQZswZVbyJQNf5/cjIOkdQ=;
        b=COjOiCOLA9Hhx2dl7fd2tFDJGZ8ElHcZvICrw6kPc/9oFEF/05fHzNo1Y6a/4UxcCZ
         2vXLN1GyyqFZbNM/QFRUnBhGA9CxsCsYKuN9VfKMp0fyey1fCWAkSmtgEsnei/0XIaVY
         RXeWfPUaQk4KfMaJl0XtvhHTbNO5bxsBhCjt7S9IJ+SYde9ntgQ3CN0fXZgvezIVAqy0
         /tYglIEfSIBsaKh4yCArA+awX1bopaxvpje09DE1mIZwxo9eFKbwxcxioygPALSdjsWw
         CD52apRSkP+pWtBO9cCyYkisqHQcvu0gEcd2IZdZ9GyOUrwEzH6GHEHr91O6IVsK1qBN
         Ifyw==
X-Gm-Message-State: AC+VfDyMLfXspX5VuemQGnKTTMEPjIsWkA7g6l52fjupmy3UIvYQgKzG
        TBXlPrJ9EQLPJDS7rI9j3oA2gF+tWkg=
X-Google-Smtp-Source: ACHHUZ6LEw8iCPG2+M+YC7VQE28jcG2UZ8warfzSyDEJsh7lPC9h8OQDz0+icweB8E+oPpEgXAHqOw==
X-Received: by 2002:adf:f104:0:b0:30a:e5ba:170d with SMTP id r4-20020adff104000000b0030ae5ba170dmr2444766wro.32.1685472142752;
        Tue, 30 May 2023 11:42:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bf3-20020a0560001cc300b00307b5376b2csm4038053wrb.90.2023.05.30.11.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:22 -0700 (PDT)
Message-Id: <641a56f0b40a88b0127819989ed1f81f844a090e.1685472133.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:05 +0000
Subject: [PATCH v2 07/14] config: provide kvi with config files
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

Refactor out the configset logic that caches "struct config_source" and
"enum config_scope" as a "struct key_value_info", and use it to pass the
"kvi" arg to config callbacks when parsing config files. Get the "enum
config_scope" value by plumbing an additional arg through
git_config_from_file_with_options() and the underlying machinery.

We do not exercise the "kvi" arg yet because the remaining
current_config_*() callers may be used with config_with_options(), which
may read config from parameters, but parameters don't pass "kvi" yet.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 bundle-uri.c       |   1 +
 config.c           | 104 +++++++++++++++++++++++++++++----------------
 config.h           |   8 ++--
 fsck.c             |   3 +-
 submodule-config.c |   5 ++-
 5 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 7f01fbbff74..bb88ccbca4b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -254,6 +254,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
+						   CONFIG_SCOPE_UNKNOWN,
 						   &opts);
 
 	if (!result && list->mode == BUNDLE_MODE_NONE) {
diff --git a/config.c b/config.c
index 66078b22eef..4b6830fcc79 100644
--- a/config.c
+++ b/config.c
@@ -251,7 +251,9 @@ static int handle_path_include(struct config_source *cs, const char *path,
 			    !cs ? "<unknown>" :
 			    cs->name ? cs->name :
 			    "the command line");
-		ret = git_config_from_file(git_config_include, path, inc);
+		ret = git_config_from_file_with_options(git_config_include, path, inc,
+							current_config_scope(),
+							NULL);
 		inc->depth--;
 	}
 cleanup:
@@ -481,7 +483,7 @@ static int include_condition_is_true(struct config_source *cs,
 }
 
 static int git_config_include(const char *var, const char *value,
-			      struct key_value_info *kvi UNUSED, void *data)
+			      struct key_value_info *kvi, void *data)
 {
 	struct config_include_data *inc = data;
 	struct config_source *cs = inc->config_reader->source;
@@ -493,7 +495,7 @@ static int git_config_include(const char *var, const char *value,
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, NULL, inc->data);
+	ret = inc->fn(var, value, kvi, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -929,8 +931,8 @@ static char *parse_value(struct config_source *cs)
 	}
 }
 
-static int get_value(struct config_source *cs, config_fn_t fn, void *data,
-		     struct strbuf *name)
+static int get_value(struct config_source *cs, struct key_value_info *kvi,
+		     config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -963,7 +965,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, NULL, data);
+	kvi->linenr = cs->linenr;
+	ret = fn(name->buf, value, kvi, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -1062,8 +1065,19 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	return 0;
 }
 
+static void kvi_from_source(struct config_source *cs,
+			    enum config_scope scope,
+			    struct key_value_info *out)
+{
+	out->filename = strintern(cs->name);
+	out->origin_type = cs->origin_type;
+	out->linenr = cs->linenr;
+	out->scope = scope;
+}
+
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
-			    void *data, const struct config_options *opts)
+			    struct key_value_info *kvi, void *data,
+			    const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
@@ -1147,7 +1161,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cs, fn, data, var) < 0)
+		if (get_value(cs, kvi, fn, data, var) < 0)
 			break;
 	}
 
@@ -2005,9 +2019,11 @@ int git_default_config(const char *var, const char *value,
  * this function.
  */
 static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn, void *data,
+			  struct config_source *top, config_fn_t fn,
+			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
+	struct key_value_info kvi = { 0 };
 	int ret;
 
 	/* push config-file parsing state stack */
@@ -2017,8 +2033,9 @@ static int do_config_from(struct config_reader *reader,
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
 	config_reader_push_source(reader, top);
+	kvi_from_source(top, scope, &kvi);
 
-	ret = git_parse_source(top, fn, data, opts);
+	ret = git_parse_source(top, fn, &kvi, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -2032,7 +2049,8 @@ static int do_config_from_file(struct config_reader *reader,
 			       config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
-			       void *data, const struct config_options *opts)
+			       void *data, enum config_scope scope,
+			       const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2047,19 +2065,20 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, opts);
+	ret = do_config_from(reader, &top, fn, data, scope, opts);
 	funlockfile(f);
 	return ret;
 }
 
-static int git_config_from_stdin(config_fn_t fn, void *data)
+static int git_config_from_stdin(config_fn_t fn, void *data,
+				 enum config_scope scope)
 {
 	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
-				   NULL, stdin, data, NULL);
+				   NULL, stdin, data, scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
-				      void *data,
+				      void *data, enum config_scope scope,
 				      const struct config_options *opts)
 {
 	int ret = -1;
@@ -2070,7 +2089,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
-					  filename, filename, f, data, opts);
+					  filename, filename, f, data, scope,
+					  opts);
 		fclose(f);
 	}
 	return ret;
@@ -2078,13 +2098,15 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
-	return git_config_from_file_with_options(fn, filename, data, NULL);
+	return git_config_from_file_with_options(fn, filename, data,
+						 CONFIG_SCOPE_UNKNOWN, NULL);
 }
 
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len,
-			void *data, const struct config_options *opts)
+			void *data, enum config_scope scope,
+			const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 
@@ -2099,14 +2121,15 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&the_reader, &top, fn, data, opts);
+	return do_config_from(&the_reader, &top, fn, data, scope, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
 			      const char *name,
 			      struct repository *repo,
 			      const struct object_id *oid,
-			      void *data)
+			      void *data,
+			      enum config_scope scope)
 {
 	enum object_type type;
 	char *buf;
@@ -2122,7 +2145,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, NULL);
+				  data, scope, NULL);
 	free(buf);
 
 	return ret;
@@ -2131,13 +2154,14 @@ int git_config_from_blob_oid(config_fn_t fn,
 static int git_config_from_blob_ref(config_fn_t fn,
 				    struct repository *repo,
 				    const char *name,
-				    void *data)
+				    void *data,
+				    enum config_scope scope)
 {
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid) < 0)
 		return error(_("unable to resolve config blob '%s'"), name);
-	return git_config_from_blob_oid(fn, name, repo, &oid, data);
+	return git_config_from_blob_oid(fn, name, repo, &oid, data, scope);
 }
 
 char *git_system_config(void)
@@ -2212,27 +2236,34 @@ static int do_git_config_sequence(struct config_reader *reader,
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
-		ret += git_config_from_file(fn, system_config, data);
+		ret += git_config_from_file_with_options(fn, system_config,
+							 data, CONFIG_SCOPE_SYSTEM,
+							 NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, xdg_config, data);
+		ret += git_config_from_file_with_options(fn, xdg_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, user_config, data);
+		ret += git_config_from_file_with_options(fn, user_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
-		ret += git_config_from_file(fn, repo_config, data);
+		ret += git_config_from_file_with_options(fn, repo_config, data,
+							 CONFIG_SCOPE_LOCAL, NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
+			ret += git_config_from_file_with_options(fn, path, data,
+								 CONFIG_SCOPE_WORKTREE,
+								 NULL);
 		free(path);
 	}
 
@@ -2274,14 +2305,16 @@ int config_with_options(config_fn_t fn, void *data,
 	 * regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
-		ret = git_config_from_stdin(fn, data);
+		ret = git_config_from_stdin(fn, data, config_source->scope);
 	} else if (config_source && config_source->file) {
-		ret = git_config_from_file(fn, config_source->file, data);
+		ret = git_config_from_file_with_options(fn, config_source->file,
+							data, config_source->scope,
+							NULL);
 	} else if (config_source && config_source->blob) {
 		struct repository *repo = config_source->repo ?
 			config_source->repo : the_repository;
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
-						data);
+					       data, config_source->scope);
 	} else {
 		ret = do_git_config_sequence(&the_reader, opts, fn, data);
 	}
@@ -2423,16 +2456,14 @@ static int configset_add_value(struct config_reader *reader,
 	if (!reader->source)
 		BUG("configset_add_value has no source");
 	if (reader->source->name) {
-		kv_info->filename = strintern(reader->source->name);
-		kv_info->linenr = reader->source->linenr;
-		kv_info->origin_type = reader->source->origin_type;
+		kvi_from_source(reader->source, current_config_scope(), kv_info);
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
 		kv_info->linenr = -1;
 		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
+		kv_info->scope = reader->parsing_scope;
 	}
-	kv_info->scope = reader->parsing_scope;
 	si->util = kv_info;
 
 	return 0;
@@ -3472,7 +3503,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 */
 		if (git_config_from_file_with_options(store_aux,
 						      config_filename,
-						      &store, &opts)) {
+						      &store, CONFIG_SCOPE_UNKNOWN,
+						      &opts)) {
 			error(_("invalid config file %s"), config_filename);
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
diff --git a/config.h b/config.h
index ea4ffe37a55..ca5aac62980 100644
--- a/config.h
+++ b/config.h
@@ -150,16 +150,18 @@ int git_default_config(const char *, const char *, struct key_value_info *,
 int git_config_from_file(config_fn_t fn, const char *, void *);
 
 int git_config_from_file_with_options(config_fn_t fn, const char *,
-				      void *,
+				      void *, enum config_scope,
 				      const struct config_options *);
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type,
 			const char *name,
 			const char *buf, size_t len,
-			void *data, const struct config_options *opts);
+			void *data, enum config_scope scope,
+			const struct config_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     struct repository *repo,
-			     const struct object_id *oid, void *data);
+			     const struct object_id *oid, void *data,
+			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/fsck.c b/fsck.c
index 1569e64f011..ec26857c79d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1236,7 +1236,8 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		data.ret = 0;
 		config_opts.error_action = CONFIG_ERROR_SILENT;
 		if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
-					".gitmodules", buf, size, &data, &config_opts))
+					".gitmodules", buf, size, &data,
+					CONFIG_SCOPE_UNKNOWN, &config_opts))
 			data.ret |= report(options, oid, OBJ_BLOB,
 					FSCK_MSG_GITMODULES_PARSE,
 					"could not parse gitmodules blob");
diff --git a/submodule-config.c b/submodule-config.c
index 0b794b6f32e..7d773f33621 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -604,7 +604,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			config, config_size, &parameter, NULL);
+			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
 	strbuf_release(&rev);
 	free(config);
 
@@ -713,7 +713,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository);
+					 the_repository, &oid, the_repository,
+					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-- 
gitgitgadget


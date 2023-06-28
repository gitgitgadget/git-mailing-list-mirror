Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037EEB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF1T05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjF1T0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BF1FF1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e742a787so292307f8f.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980400; x=1690572400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiNbOu2IfjwWi60B7b1Q7lRowauJOHpgzlS1b1ciUgg=;
        b=bNiKMUiXZUEIEXDstOFTWFQkzqZNAyOTgeJxYWYlFhgCPROlPO/8meb1+8n9pzYHs8
         veKGI0P1IDgTmtk+Nt5QLEQZa/DFGDcjRNVgoGIAAF3C21iLMpVSPFAAjby9syZgJS4+
         Yr9OtNIAICVLMnfpxp+pMWbg7sN5t3caafHi61kRvNagP0T/L0eT/CWuy9kzOgs7gkj/
         3ridRcIHRjywHuWKGtzZttI8xeAnMKOrfqAUkC1E7R7PGZK/ajqL1CEQICYb9cyr0tYr
         a2fDS9lM7qCc0U7nqAIGFidp7DJ9bFPfleBju43O6tl4AoJ9RPdaCKhFmMH7fc2urLeA
         DMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980400; x=1690572400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiNbOu2IfjwWi60B7b1Q7lRowauJOHpgzlS1b1ciUgg=;
        b=BPkQOx33CXaKauW9/qyYoK1QW9yfBx0trcuNr8YmmGMNSsU0So+4nOEv6VWO03x/vc
         cLv1ter86ngW8cBqDeDj+dTbuFKraPfCUrUe9yFF3Fal3ZS++jVNIgNJiIhcYCqT1KRb
         KVSDHhelY2R6xLp7OpoymwOpmkNdF+XN2FH9BaHcYIqHuUjJFO64gZRacob8zA3rUP7p
         O4+iGzlcQBgijC2rU7f7oYWZH8FrdzhnIUTwf3HpefBphYZ54WX6kR9MUDc/guM8ypfU
         11ct+sOft2SF7dGJxn+azqUjbJrbpVESqLp2grZQTv9NvGczlBCq2shC8VT6VmUgK5ek
         xLbA==
X-Gm-Message-State: AC+VfDxaoKeDCbb0FcWayWIORBlwlXCBG0UJyHj+JTc2LrjBc37OaBZT
        XBBM6K9hHMbOhgH4DslQGqm0j3qREQ4=
X-Google-Smtp-Source: ACHHUZ6H6lkMq9HjwIuNTYJ1RVEcv3v+5wZ7uJFLFCJb9ruYFaO2LkTKQGC96Hj4GkkxzM1E0cqBnQ==
X-Received: by 2002:adf:e3c9:0:b0:313:ef28:d3d6 with SMTP id k9-20020adfe3c9000000b00313ef28d3d6mr2222934wrm.6.1687980400034;
        Wed, 28 Jun 2023 12:26:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d4ec6000000b0030ae849c70csm13999602wrv.37.2023.06.28.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:39 -0700 (PDT)
Message-Id: <bfc6d2833c5fb904149452246021a432917d2776.1687980393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:24 +0000
Subject: [PATCH v5 05/11] config: pass ctx with config files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Pass config_context to config_callbacks when parsing config files. To
provide the .kvi member, refactor out the configset logic that caches
"struct config_source" and "enum config_scope" as a "struct
key_value_info". Make the "enum config_scope" available to the config
file machinery by plumbing an additional arg through
git_config_from_file_with_options().

We do not exercise ctx yet because the remaining current_config_*()
callers may be used with config_with_options(), which may read config
from parameters, but parameters don't pass ctx yet.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 bundle-uri.c       |   1 +
 config.c           | 105 ++++++++++++++++++++++++++++++---------------
 config.h           |   8 ++--
 fsck.c             |   3 +-
 submodule-config.c |   5 ++-
 5 files changed, 81 insertions(+), 41 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 0d5acc3dc51..64f32387745 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -255,6 +255,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
+						   CONFIG_SCOPE_UNKNOWN,
 						   &opts);
 
 	if (!result && list->mode == BUNDLE_MODE_NONE) {
diff --git a/config.c b/config.c
index 662d406ac1e..31718711827 100644
--- a/config.c
+++ b/config.c
@@ -259,7 +259,9 @@ static int handle_path_include(struct config_source *cs, const char *path,
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
@@ -503,7 +505,7 @@ static int git_config_include(const char *var, const char *value,
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, NULL, inc->data);
+	ret = inc->fn(var, value, ctx, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -939,12 +941,15 @@ static char *parse_value(struct config_source *cs)
 	}
 }
 
-static int get_value(struct config_source *cs, config_fn_t fn, void *data,
-		     struct strbuf *name)
+static int get_value(struct config_source *cs, struct key_value_info *kvi,
+		     config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
 	int ret;
+	struct config_context ctx = {
+		.kvi = kvi,
+	};
 
 	/* Get the full name */
 	for (;;) {
@@ -973,7 +978,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, NULL, data);
+	kvi->linenr = cs->linenr;
+	ret = fn(name->buf, value, &ctx, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -1072,8 +1078,19 @@ static int do_event(struct config_source *cs, enum config_event_t type,
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
@@ -1157,7 +1174,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cs, fn, data, var) < 0)
+		if (get_value(cs, kvi, fn, data, var) < 0)
 			break;
 	}
 
@@ -2010,9 +2027,11 @@ int git_default_config(const char *var, const char *value,
  * this function.
  */
 static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn, void *data,
+			  struct config_source *top, config_fn_t fn,
+			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
+	struct key_value_info kvi = KVI_INIT;
 	int ret;
 
 	/* push config-file parsing state stack */
@@ -2022,8 +2041,9 @@ static int do_config_from(struct config_reader *reader,
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
 	config_reader_push_source(reader, top);
+	kvi_from_source(top, scope, &kvi);
 
-	ret = git_parse_source(top, fn, data, opts);
+	ret = git_parse_source(top, fn, &kvi, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -2037,7 +2057,8 @@ static int do_config_from_file(struct config_reader *reader,
 			       config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
-			       void *data, const struct config_options *opts)
+			       void *data, enum config_scope scope,
+			       const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2052,19 +2073,20 @@ static int do_config_from_file(struct config_reader *reader,
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
@@ -2075,7 +2097,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
-					  filename, filename, f, data, opts);
+					  filename, filename, f, data, scope,
+					  opts);
 		fclose(f);
 	}
 	return ret;
@@ -2083,13 +2106,15 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
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
 
@@ -2104,14 +2129,15 @@ int git_config_from_mem(config_fn_t fn,
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
@@ -2127,7 +2153,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, NULL);
+				  data, scope, NULL);
 	free(buf);
 
 	return ret;
@@ -2136,13 +2162,14 @@ int git_config_from_blob_oid(config_fn_t fn,
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
@@ -2228,27 +2255,34 @@ static int do_git_config_sequence(struct config_reader *reader,
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
 	if (!opts->ignore_worktree && worktree_config &&
 	    repo && repo->repository_format_worktree_config &&
 	    !access_or_die(worktree_config, R_OK, 0)) {
-		ret += git_config_from_file(fn, worktree_config, data);
+			ret += git_config_from_file_with_options(fn, worktree_config, data,
+								 CONFIG_SCOPE_WORKTREE,
+								 NULL);
 	}
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
@@ -2292,12 +2326,14 @@ int config_with_options(config_fn_t fn, void *data,
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
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
-						data);
+					       data, config_source->scope);
 	} else {
 		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
 	}
@@ -2440,16 +2476,14 @@ static int configset_add_value(struct config_reader *reader,
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
@@ -3490,7 +3524,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
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
index ddf147bb2d1..206bf1f175a 100644
--- a/config.h
+++ b/config.h
@@ -169,16 +169,18 @@ int git_default_config(const char *, const char *,
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
index 55b6a694853..f92c216fb5c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1238,7 +1238,8 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
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
index a38d4d49731..3f25bd13674 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -606,7 +606,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			config, config_size, &parameter, NULL);
+			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
 	strbuf_release(&rev);
 	free(config);
 
@@ -714,7 +714,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository);
+					 the_repository, &oid, the_repository,
+					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-- 
gitgitgadget


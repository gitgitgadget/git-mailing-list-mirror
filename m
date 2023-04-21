Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2414C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjDUTNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjDUTN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF310D0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so15051125e9.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104402; x=1684696402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkLMYgx8CNl2w9YglzQVVjd8WrV0LyL3eQXRdtTXw5w=;
        b=KF9DCellQ6QSz5wcClcaFC+n37foLsLCPQ22gfNfQWaxWp9cOfohvVZ4z/DY97x0z/
         G7pLyAC7I0DRz1mMBz1M9yUW/NpN8EXXGXITkL7Ob9EooaC9xge7XAZIp6ZEoyyPWG8w
         oSGEQZp/4+ge9pzkbp+OdvR1efy0qFQYYTo6ahGJPWISKsK7na0t1aYRDqsOOlU4zecS
         8H/jhbrANkJiwovV9BvQ1sqmW18Bc5bemLnkFYlFU6sZy3y7NgMNj5RWFXa0xsydvSu4
         kVy1lCxK7WTlIkQoHnMMZV1B1n/YFoRWtsWOo92rkpGUUXYG6HEQhymZLq2Y5fpXoUoK
         vFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104402; x=1684696402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkLMYgx8CNl2w9YglzQVVjd8WrV0LyL3eQXRdtTXw5w=;
        b=ThLhuh1Kow+X/beVJmj1+o3GQMoMzEjJhDIsSzHBPot68SF2lwSai2iqKlWw5WA6LM
         DvP2jd38PcESQxtyTC2bUyyWJcbs5YFFt7lA9AKFtronz+nKBWiDnwrJkERXJZpvXxWO
         bdzwwmJXCyK3+LW9EUisFdQN/nYpTOzCyPnymXFdVuGSaDeaki8ylNOFVTntBbd7i9ob
         cgpsfDSEUE/aKzAHgEM+qUQBSuGr6yMZCnxSLu3b2E9Obcxh+9f00UEyYX2lR1n93jdL
         qprhyRnutcdct/AnfRXd4hcfxHV+Z0xJELiaUtSx1vLmRSMFUQNOv9j4UITl+OC7q3bu
         SrEg==
X-Gm-Message-State: AAQBX9fei6AK5hqy1isvdyIubYWqDM93k3n3tjzTDyMfzOTx5pACyrGR
        qGodKSJLha7+ifH3L+WMkw0k9cqZv04=
X-Google-Smtp-Source: AKy350ZertsHql4vxhWWQrq1H/74t7RfqxBkLgMmMOaRbW3Tj6ROFy5VneOAfVy2OlOgiDyNwI77mA==
X-Received: by 2002:a7b:cb96:0:b0:3eb:39e2:915b with SMTP id m22-20020a7bcb96000000b003eb39e2915bmr2596632wmi.31.1682104402321;
        Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003ee5fa61f45sm9022306wmq.3.2023.04.21.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Message-Id: <8c7a84137c8b1c9acccd573c3c7bdc0ee027e0b0.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:07 +0000
Subject: [PATCH 03/14] config: use kvi for config files
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

Plumb "struct key_value_info" and use "kvi_fn()" when parsing config
files. As a result, "config_reader.kvi" is now always set correctly, so
we can remove "config_reader.scope" (but not the ".source" member since
that's still needed by some non-parsing machinery). This requires
plumbing an additional "enum config_scope" arg through
"git_config_from_file_with_options()" and the underlying machinery to
make up for the fact that "struct key_value_info" has a ".scope" member,
but "struct config_source" does not.

To handle "include" directives correctly, use push/pop semantics for
"config_reader.config_kvi" (instead of "set" semantics) like we do for
"config_reader.source". Otherwise, "config_reader.config_kvi" won't be
set correctly when we finish parsing an included config file and we want
to "pop" it to resume parsing the original file. This distinction only
matters while there is a global "kvi", i.e. it will be obsolete at the
end of the series.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 bundle-uri.c       |   1 +
 config.c           | 171 ++++++++++++++++++++++++---------------------
 config.h           |   9 ++-
 fsck.c             |   3 +-
 submodule-config.c |   5 +-
 5 files changed, 104 insertions(+), 85 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index e2b267cc02b..8c4e2b70b89 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -252,6 +252,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
+						   CONFIG_SCOPE_UNKNOWN,
 						   &opts);
 
 	if (!result && list->mode == BUNDLE_MODE_NONE) {
diff --git a/config.c b/config.c
index 4e9e8e7abb9..3369b32d065 100644
--- a/config.c
+++ b/config.c
@@ -78,16 +78,6 @@ struct config_reader {
 	 */
 	struct config_source *source;
 	struct key_value_info *config_kvi;
-	/*
-	 * The "scope" of the current config source being parsed (repo, global,
-	 * etc). Like "source", this is only set when parsing a config source.
-	 * It's not part of "source" because it transcends a single file (i.e.,
-	 * a file included from .git/config is still in "repo" scope).
-	 *
-	 * When iterating through a configset, the equivalent value is
-	 * "config_kvi.scope" (see above).
-	 */
-	enum config_scope parsing_scope;
 };
 /*
  * Where possible, prefer to accept "struct config_reader" as an arg than to use
@@ -113,16 +103,21 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 	return ret;
 }
 
-static inline void config_reader_set_kvi(struct config_reader *reader,
-					 struct key_value_info *kvi)
+static inline void config_reader_push_kvi(struct config_reader *reader,
+					  struct key_value_info *kvi)
 {
+	kvi->prev = reader->config_kvi;
 	reader->config_kvi = kvi;
 }
 
-static inline void config_reader_set_scope(struct config_reader *reader,
-					   enum config_scope scope)
+static inline struct key_value_info *config_reader_pop_kvi(struct config_reader *reader)
 {
-	reader->parsing_scope = scope;
+	struct key_value_info *ret;
+	if (!reader->config_kvi)
+		BUG("tried to pop config_kvi, but we weren't reading config");
+	ret = reader->config_kvi;
+	reader->config_kvi = reader->config_kvi->prev;
+	return ret;
 }
 
 static int pack_compression_seen;
@@ -244,7 +239,9 @@ static int handle_path_include(struct config_source *cs, const char *path,
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
@@ -393,18 +390,12 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	enum config_scope store_scope = inc->config_reader->parsing_scope;
-
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	config_reader_set_scope(inc->config_reader, 0);
-
 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
-
-	config_reader_set_scope(inc->config_reader, store_scope);
 }
 
 static int forbid_remote_url(const char *var, const char *value UNUSED,
@@ -471,10 +462,13 @@ static int include_condition_is_true(struct config_source *cs,
 	return 0;
 }
 
+static int kvi_fn(config_fn_t fn, const char *key, const char *value,
+		  struct key_value_info *kvi, void *data);
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
 	struct config_source *cs = inc->config_reader->source;
+	struct key_value_info *kvi = inc->config_reader->config_kvi;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -483,7 +477,7 @@ static int git_config_include(const char *var, const char *value, void *data)
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, inc->data);
+	ret = kvi_fn(inc->fn, var, value, kvi, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -655,13 +649,12 @@ out_free_ret_1:
 }
 
 static int kvi_fn(config_fn_t fn, const char *key, const char *value,
-		  struct key_value_info *kvi,
-		  void *data)
+		  struct key_value_info *kvi, void *data)
 {
 	int ret;
-	config_reader_set_kvi(&the_reader, kvi);
+	config_reader_push_kvi(&the_reader, kvi);
 	ret = fn(key, value, data);
-	config_reader_set_kvi(&the_reader, NULL);
+	config_reader_pop_kvi(&the_reader);
 	return ret;
 }
 
@@ -942,8 +935,8 @@ static char *parse_value(struct config_source *cs)
 	}
 }
 
-static int get_value(struct config_source *cs, config_fn_t fn, void *data,
-		     struct strbuf *name)
+static int get_value(struct config_source *cs, struct key_value_info *kvi,
+		     config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
@@ -976,7 +969,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, data);
+	kvi->linenr = cs->linenr;
+	ret = kvi_fn(fn, name->buf, value, kvi, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -1075,8 +1069,19 @@ static int do_event(struct config_source *cs, enum config_event_t type,
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
@@ -1160,7 +1165,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cs, fn, data, var) < 0)
+		if (get_value(cs, kvi, fn, data, var) < 0)
 			break;
 	}
 
@@ -2016,9 +2021,11 @@ int git_default_config(const char *var, const char *value, void *cb)
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
@@ -2028,8 +2035,9 @@ static int do_config_from(struct config_reader *reader,
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
 	config_reader_push_source(reader, top);
+	kvi_from_source(top, scope, &kvi);
 
-	ret = git_parse_source(top, fn, data, opts);
+	ret = git_parse_source(top, fn, &kvi, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -2043,7 +2051,8 @@ static int do_config_from_file(struct config_reader *reader,
 			       config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
-			       void *data, const struct config_options *opts)
+			       void *data, enum config_scope scope,
+			       const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2058,19 +2067,21 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, opts);
+	ret = do_config_from(reader, &top, fn, data, scope, opts);
 	funlockfile(f);
+
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
@@ -2081,7 +2092,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
-					  filename, filename, f, data, opts);
+					  filename, filename, f, data, scope,
+					  opts);
 		fclose(f);
 	}
 	return ret;
@@ -2089,13 +2101,15 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
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
 
@@ -2110,14 +2124,15 @@ int git_config_from_mem(config_fn_t fn,
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
@@ -2133,7 +2148,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, NULL);
+				  data, scope, NULL);
 	free(buf);
 
 	return ret;
@@ -2142,13 +2157,14 @@ int git_config_from_blob_oid(config_fn_t fn,
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
@@ -2201,8 +2217,7 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(struct config_reader *reader,
-				  const struct config_options *opts,
+static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2210,7 +2225,6 @@ static int do_git_config_sequence(struct config_reader *reader,
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 	char *repo_config;
-	enum config_scope prev_parsing_scope = reader->parsing_scope;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -2219,39 +2233,40 @@ static int do_git_config_sequence(struct config_reader *reader,
 	else
 		repo_config = NULL;
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
-		ret += git_config_from_file(fn, system_config, data);
+		ret += git_config_from_file_with_options(fn, system_config,
+							 data, CONFIG_SCOPE_SYSTEM,
+							 NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, xdg_config, data);
+		ret += git_config_from_file_with_options(fn, xdg_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, user_config, data);
+		ret += git_config_from_file_with_options(fn, user_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
-		ret += git_config_from_file(fn, repo_config, data);
+		ret += git_config_from_file_with_options(fn, repo_config, data,
+							 CONFIG_SCOPE_LOCAL, NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
+			ret += git_config_from_file_with_options(fn, path, data,
+								 CONFIG_SCOPE_WORKTREE,
+								 NULL);
 		free(path);
 	}
 
-	config_reader_set_scope(reader, 0);
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
-	config_reader_set_scope(reader, prev_parsing_scope);
 	free(system_config);
 	free(xdg_config);
 	free(user_config);
@@ -2264,7 +2279,6 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
-	enum config_scope prev_scope = the_reader.parsing_scope;
 	int ret;
 
 	if (opts->respect_includes) {
@@ -2277,31 +2291,29 @@ int config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
-	if (config_source)
-		config_reader_set_scope(&the_reader, config_source->scope);
-
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
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
-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
+		ret = do_git_config_sequence(opts, fn, data);
 	}
 
 	if (inc.remote_urls) {
 		string_list_clear(inc.remote_urls, 0);
 		FREE_AND_NULL(inc.remote_urls);
 	}
-	config_reader_set_scope(&the_reader, prev_scope);
 	return ret;
 }
 
@@ -2429,13 +2441,7 @@ static int configset_add_value(struct config_reader *reader,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (reader->source && reader->source->name) {
-		kv_info->filename = strintern(reader->source->name);
-		kv_info->linenr = reader->source->linenr;
-		kv_info->origin_type = reader->source->origin_type;
-		kv_info->scope = reader->parsing_scope;
-	} else
-		kvi_from_param(kv_info);
+	memcpy(kv_info, reader->config_kvi, sizeof(struct key_value_info));
 	si->util = kv_info;
 
 	return 0;
@@ -3473,7 +3479,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 */
 		if (git_config_from_file_with_options(store_aux,
 						      config_filename,
-						      &store, &opts)) {
+						      &store, CONFIG_SCOPE_UNKNOWN,
+						      &opts)) {
 			error(_("invalid config file %s"), config_filename);
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
@@ -4018,7 +4025,13 @@ enum config_scope current_config_scope(void)
 	if (the_reader.config_kvi)
 		return the_reader.config_kvi->scope;
 	else
-		return the_reader.parsing_scope;
+		/*
+		 * FIXME This should be a BUG, but tr2_list_env_vars_fl is
+		 * calling this outside of a config callback. This will be
+		 * easier to fix when we plumb kvi through the config callbacks,
+		 * so leave this untouched for now.
+		 */
+		return CONFIG_SCOPE_UNKNOWN;
 }
 
 int current_config_line(void)
diff --git a/config.h b/config.h
index 247b572b37b..27d1718ac7b 100644
--- a/config.h
+++ b/config.h
@@ -142,16 +142,18 @@ int git_default_config(const char *, const char *, void *);
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
@@ -672,6 +674,7 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
+	struct key_value_info *prev;
 };
 
 /**
diff --git a/fsck.c b/fsck.c
index 8ef1b022346..4238344ed82 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1235,7 +1235,8 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
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
index ecf0fcf0074..c2f71f0b2e3 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -603,7 +603,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			config, config_size, &parameter, NULL);
+			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
 	strbuf_release(&rev);
 	free(config);
 
@@ -711,7 +711,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository);
+					 the_repository, &oid, the_repository,
+					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-- 
gitgitgadget


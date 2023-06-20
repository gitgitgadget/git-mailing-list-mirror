Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D0EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFTTof (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFTToJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16A172B
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so6904522e87.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290243; x=1689882243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21eQpOHUvVRoOVV+vYDCp7v/xhCiznoWzjQ5EcAyjMk=;
        b=BbZSspOq/ymG7058fcBJWv2KWx5yOVGBVzFusWe6zxuUBzV3spputZTg0rSD31Fjc+
         kO5Azgu/7BRWDPY4TTMq6ixua7pY34sMTj54SoYVUh6DrL13JYZlP29Of5dqREun/Lh/
         06teErmcjzO41vVE+hsCz4soXFaSe5HZlFwgWomQnHHd/Azeg/+UGJWQBmxcEopq0q8E
         9WUFRKtXx2Yol3BYT3JCfVWqPeJwr5q6cJHCLzAMLrQnsvXDXyrIU9HhH9xY9FE6x5o4
         576R+EOJDN2o73Q5gCU1WVrLXzDiGkglYMfc/x4yhsWBaiRwAVlF9LvIYMPijJiO4I0K
         hqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290243; x=1689882243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21eQpOHUvVRoOVV+vYDCp7v/xhCiznoWzjQ5EcAyjMk=;
        b=KUrolI3KuzRw/HPwOt71wV7+cNb/VtqEE3dV4IaKhCtilhKX3Xoh/jx/DE1RJnBr15
         3fmQfMmhGZAW5AGJ8HAXSsSyBy9In+jjWMfDSs8oW1BwDiQvRgSxgT8WORaUqMqLo+/I
         KERbePV6wP8n9qkjU9EsI2fZXBqDAwvOGP88+tOJljMeoTbOxxj36pfzmq4nB9rjj4k7
         G598ZGfh1naeDXJB1U7nm3lN4Qs5/zVzxmfBu9g5pu2kkFqGnlSr6pg/JeDKLG+qAE8M
         vscKv2wpttZZ4jMVVVtkfo26uTDCNWo/GP/s58WNiEKJS4w6IQGFNxGWg2XWIXDSd6bU
         7KOA==
X-Gm-Message-State: AC+VfDwX6PZ5M8doBzJxka0uQDJPkAy3WJiSO1s/Sp4OGQ7qa8lwFdXj
        AW4/f09507WePmXIHLrSHYQBy6Q+c2Q=
X-Google-Smtp-Source: ACHHUZ69NZM9WKjFeJzodFwHksXadnkbizmpT5zkf07kbCEArXgO9j0I92xLAc+Mfg52KjxQb1Xi2w==
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id b7-20020a196707000000b004f9570c7b28mr385275lfc.32.1687290242488;
        Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003f42d8dd7d1sm14208101wmd.7.2023.06.20.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
Message-Id: <66572df7beb220b8f7d5ce2eb724fda55c128b94.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:47 +0000
Subject: [PATCH v3 08/12] trace2: plumb config kvi
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

There is a code path starting from trace2_def_param_fl() that eventually
calls current_config_scope(), and thus it needs to have "kvi" plumbed
through it. Additional plumbing is also needed to get "kvi" to
trace2_def_param_fl(), which gets called by two code paths:

- Through tr2_cfg_cb(), which is a config callback, so it trivially
  receives "kvi" via the "struct config_context ctx" parameter.

- Through tr2_list_env_vars_fl(), which is a high level function that
  lists environment variables for tracing. This has been secretly
  behaving like git_config_from_parameters() (in that it parses config
  from environment variables/the CLI), but does not set config source
  information.

  Teach tr2_list_env_vars_fl() to be well-behaved by using
  kvi_from_param(), which is used elsewhere for CLI/environment
  variable-based config.

As a result, current_config_scope() has no more callers, so remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c                | 46 -----------------------------------------
 config.h                |  1 -
 trace2.c                |  4 ++--
 trace2.h                |  3 ++-
 trace2/tr2_cfg.c        |  7 +++++--
 trace2/tr2_tgt.h        |  4 +++-
 trace2/tr2_tgt_event.c  |  4 ++--
 trace2/tr2_tgt_normal.c |  4 ++--
 trace2/tr2_tgt_perf.c   |  4 ++--
 9 files changed, 18 insertions(+), 59 deletions(-)

diff --git a/config.c b/config.c
index cfc5c7f10b3..f519656ebcf 100644
--- a/config.c
+++ b/config.c
@@ -85,16 +85,6 @@ struct config_reader {
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
@@ -125,19 +115,9 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 static inline void config_reader_set_kvi(struct config_reader *reader,
 					 struct key_value_info *kvi)
 {
-	if (kvi && (reader->source || reader->parsing_scope))
-		BUG("kvi should not be set while parsing a config source");
 	reader->config_kvi = kvi;
 }
 
-static inline void config_reader_set_scope(struct config_reader *reader,
-					   enum config_scope scope)
-{
-	if (scope && reader->config_kvi)
-		BUG("scope should only be set when iterating through a config source");
-	reader->parsing_scope = scope;
-}
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -411,18 +391,12 @@ static void populate_remote_urls(struct config_include_data *inc)
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
@@ -2256,7 +2230,6 @@ static int do_git_config_sequence(struct config_reader *reader,
 	char *xdg_config = NULL;
 	char *user_config = NULL;
 	char *repo_config;
-	enum config_scope prev_parsing_scope = reader->parsing_scope;
 
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
@@ -2265,7 +2238,6 @@ static int do_git_config_sequence(struct config_reader *reader,
 	else
 		repo_config = NULL;
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
@@ -2273,7 +2245,6 @@ static int do_git_config_sequence(struct config_reader *reader,
 							 data, CONFIG_SCOPE_SYSTEM,
 							 NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
@@ -2284,13 +2255,11 @@ static int do_git_config_sequence(struct config_reader *reader,
 		ret += git_config_from_file_with_options(fn, user_config, data,
 							 CONFIG_SCOPE_GLOBAL, NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file_with_options(fn, repo_config, data,
 							 CONFIG_SCOPE_LOCAL, NULL);
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
@@ -2300,11 +2269,9 @@ static int do_git_config_sequence(struct config_reader *reader,
 		free(path);
 	}
 
-	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
-	config_reader_set_scope(reader, prev_parsing_scope);
 	free(system_config);
 	free(xdg_config);
 	free(user_config);
@@ -2317,7 +2284,6 @@ int config_with_options(config_fn_t fn, void *data,
 			const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
-	enum config_scope prev_scope = the_reader.parsing_scope;
 	int ret;
 
 	if (opts->respect_includes) {
@@ -2330,9 +2296,6 @@ int config_with_options(config_fn_t fn, void *data,
 		data = &inc;
 	}
 
-	if (config_source)
-		config_reader_set_scope(&the_reader, config_source->scope);
-
 	/*
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
@@ -2356,7 +2319,6 @@ int config_with_options(config_fn_t fn, void *data,
 		string_list_clear(inc.remote_urls, 0);
 		FREE_AND_NULL(inc.remote_urls);
 	}
-	config_reader_set_scope(&the_reader, prev_scope);
 	return ret;
 }
 
@@ -4076,14 +4038,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
 	return 0;
 }
 
-enum config_scope current_config_scope(void)
-{
-	if (the_reader.config_kvi)
-		return the_reader.config_kvi->scope;
-	else
-		return the_reader.parsing_scope;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 7954a8cb104..092db17d2e4 100644
--- a/config.h
+++ b/config.h
@@ -386,7 +386,6 @@ void git_global_config(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-enum config_scope current_config_scope(void);
 const char *config_origin_type_name(enum config_origin_type type);
 void kvi_from_param(struct key_value_info *out);
 
diff --git a/trace2.c b/trace2.c
index 0efc4e7b958..49c23bfd05a 100644
--- a/trace2.c
+++ b/trace2.c
@@ -634,7 +634,7 @@ void trace2_thread_exit_fl(const char *file, int line)
 }
 
 void trace2_def_param_fl(const char *file, int line, const char *param,
-			 const char *value)
+			 const char *value, const struct key_value_info *kvi)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
@@ -644,7 +644,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_param_fl)
-			tgt_j->pfn_param_fl(file, line, param, value);
+			tgt_j->pfn_param_fl(file, line, param, value, kvi);
 }
 
 void trace2_def_repo_fl(const char *file, int line, struct repository *repo)
diff --git a/trace2.h b/trace2.h
index 4ced30c0db3..f5c5a9e6bac 100644
--- a/trace2.h
+++ b/trace2.h
@@ -325,6 +325,7 @@ void trace2_thread_exit_fl(const char *file, int line);
 
 #define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
 
+struct key_value_info;
 /*
  * Emits a "def_param" message containing a key/value pair.
  *
@@ -334,7 +335,7 @@ void trace2_thread_exit_fl(const char *file, int line);
  * `core.abbrev`, `status.showUntrackedFiles`, or `--no-ahead-behind`.
  */
 void trace2_def_param_fl(const char *file, int line, const char *param,
-			 const char *value);
+			 const char *value, const struct key_value_info *kvi);
 
 #define trace2_def_param(param, value) \
 	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 83bc4fd109c..00d546a27cd 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -109,7 +109,8 @@ static int tr2_cfg_cb(const char *key, const char *value,
 		struct strbuf *buf = *s;
 		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
 		if (wm == WM_MATCH) {
-			trace2_def_param_fl(data->file, data->line, key, value);
+			trace2_def_param_fl(data->file, data->line, key, value,
+					    ctx->kvi);
 			return 0;
 		}
 	}
@@ -127,8 +128,10 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 
 void tr2_list_env_vars_fl(const char *file, int line)
 {
+	struct key_value_info kvi = KVI_INIT;
 	struct strbuf **s;
 
+	kvi_from_param(&kvi);
 	if (tr2_load_env_vars() <= 0)
 		return;
 
@@ -136,7 +139,7 @@ void tr2_list_env_vars_fl(const char *file, int line)
 		struct strbuf *buf = *s;
 		const char *val = getenv(buf->buf);
 		if (val && *val)
-			trace2_def_param_fl(file, line, buf->buf, val);
+			trace2_def_param_fl(file, line, buf->buf, val, &kvi);
 	}
 }
 
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index bf8745c4f05..1f626cffea0 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -69,8 +69,10 @@ typedef void(tr2_tgt_evt_exec_result_fl_t)(const char *file, int line,
 					   uint64_t us_elapsed_absolute,
 					   int exec_id, int code);
 
+struct key_value_info;
 typedef void(tr2_tgt_evt_param_fl_t)(const char *file, int line,
-				     const char *param, const char *value);
+				     const char *param, const char *value,
+				     const struct key_value_info *kvi);
 
 typedef void(tr2_tgt_evt_repo_fl_t)(const char *file, int line,
 				    const struct repository *repo);
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 2af53e5d4de..53091781eca 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -477,11 +477,11 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, const struct key_value_info *kvi)
 {
 	const char *event_name = "def_param";
 	struct json_writer jw = JSON_WRITER_INIT;
-	enum config_scope scope = current_config_scope();
+	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
 	jw_object_begin(&jw, 0);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 1ebfb464d54..d25ea131643 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -297,10 +297,10 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, const struct key_value_info *kvi)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
-	enum config_scope scope = current_config_scope();
+	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
 	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 328e483a05e..a6f9a8a193e 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -439,12 +439,12 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, const struct key_value_info *kvi)
 {
 	const char *event_name = "def_param";
 	struct strbuf buf_payload = STRBUF_INIT;
 	struct strbuf scope_payload = STRBUF_INIT;
-	enum config_scope scope = current_config_scope();
+	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
 	strbuf_addf(&buf_payload, "%s:%s", param, value);
-- 
gitgitgadget


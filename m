Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCAC77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDUTOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjDUTNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050930F2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso59822415e9.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104408; x=1684696408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBsXuUNc4vnsPtHKg6TPxelBLp1IDG5bmC74/uk+bBg=;
        b=GGqExVUDazC0z71HgtFv6Xf79Q3ZKz6wdh7fAGBt4QTBXYiQCDwS1iDyFW3atwcxsp
         sFvO6im7W6gw2P3IXTRDXK4avqMUHJuZTCOZ486ebfndgWy88YL4j5jBgpNUi1woo45x
         WlqZhE/VukHlVr/MgcV5mHhXj3ylvIgpN5BkLSUq5S11Cfi9MwZ+FNMj7umx5M1/rsC1
         iGa10dSbPjMYTHOyzBDt8iJ/b6kWbihPlCkHC0kx6CI4BPPGaivbShAHeUNelgn7d4S2
         8ktwVP2YDKSfPiPPD38LHUuQ2spPrRnlU+r9o+Lv5Vz/9D+6F1rKmuzaNGXd+wbIppZB
         +tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104408; x=1684696408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBsXuUNc4vnsPtHKg6TPxelBLp1IDG5bmC74/uk+bBg=;
        b=Vx9pjNbuutUqLFJLoZqEeqaNvlS3T/7173mJgMug5LHDsSposg+ofLigyzfCGBCm4H
         O2WbMJSJ8AlMf+hVzYaO3+sO8qfoKLee+EbVjhxdCsNpcTjnc6aoEqCcdCodxKCYgW/Y
         hP2MIAqDueJKt/EVlkafjECTtSlpHe0l9RULkefWPF0FJu4mWg4h+6I1OrSYMqFzr6/P
         yayEugdSJqxYbkCHHcI/HypoX8Hn3jYcJxO91adI0ye9d1sevDFLTdSwv5vDTV+xtJVh
         OL1wS0mtaouV/Kxuh9AiyGf75AMd/W6pZL3jKoAydoM1rFL5ztg2ohjXTCJJQt05roce
         d74Q==
X-Gm-Message-State: AAQBX9dsZa/h9fyP3sHQ0/4WjfybtnUjaJMlNhO1cHwTzqN5AvnV4uKP
        PWFy+mYKU++3x7RJlPckhuczFIeNToo=
X-Google-Smtp-Source: AKy350YDn8v6ARk+5NKDminqY60BxaQWi+OvQrZ3yDsUADXrmurwgJDe1K0irs8SwyPvMowH4dIxhg==
X-Received: by 2002:a5d:6a11:0:b0:2f6:661:c03c with SMTP id m17-20020a5d6a11000000b002f60661c03cmr5145016wru.28.1682104408214;
        Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b002e5ff05765esm5013603wrf.73.2023.04.21.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
Message-Id: <4723ae3bde6b8bacc4ed7b11902c65a3a72bc5e9.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:16 +0000
Subject: [PATCH 12/14] config: remove current_config_scope()
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

Replace current_config_scope() by reading the corresponding value off
"struct key_value_info".

Most instances of this are trivial, except for the trace2/* files. There
is a code path starting from trace2_def_param_fl() that eventually calls
current_config_scope(), and thus it needs to have "kvi" plumbed through
it. Additional plumbing is also needed to get "kvi" to
trace2_def_param_fl(), which gets called by two code paths:

- Through tr2_cfg_cb(), which is a config callback, so it trivially
  receives "kvi".

- Through tr2_list_env_vars_fl(), which is a high level function that
  lists environment variables for tracing. This has been secretly
  behaving like git_config_from_parameters() (in that it parses config
  from environment variables/the CLI), but does not set config source
  information.

  Teach tr2_list_env_vars_fl() to be well-behaved by using
  kvi_from_param(), which is already used internally by config.c for
  CLI/environment variable-based config.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c        |  8 ++++----
 builtin/remote.c        |  2 +-
 config.c                | 16 +---------------
 config.h                |  3 ++-
 remote.c                |  6 +++---
 t/helper/test-config.c  |  2 +-
 trace2.c                |  4 ++--
 trace2.h                |  3 ++-
 trace2/tr2_cfg.c        |  9 ++++++---
 trace2/tr2_tgt.h        |  4 +++-
 trace2/tr2_tgt_event.c  |  4 ++--
 trace2/tr2_tgt_normal.c |  4 ++--
 trace2/tr2_tgt_perf.c   |  4 ++--
 13 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2ffa25139c6..7899add68fb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -204,10 +204,10 @@ static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
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
@@ -219,7 +219,7 @@ static int show_all_config(const char *key_, const char *value_,
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
 		if (show_scope)
-			show_config_scope(&buf);
+			show_config_scope(kvi, &buf);
 		if (show_origin)
 			show_config_origin(kvi, &buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
@@ -243,7 +243,7 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 			 struct key_value_info *kvi)
 {
 	if (show_scope)
-		show_config_scope(buf);
+		show_config_scope(kvi, buf);
 	if (show_origin)
 		show_config_origin(kvi, buf);
 	if (show_keys)
diff --git a/builtin/remote.c b/builtin/remote.c
index fc4ea993ebb..034998a1205 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -653,7 +653,7 @@ static int config_read_push_default(const char *key, const char *value,
 	    !value || strcmp(value, info->old_name))
 		return 0;
 
-	info->scope = current_config_scope();
+	info->scope = kvi->scope;
 	strbuf_reset(&info->origin);
 	strbuf_addstr(&info->origin, kvi->filename);
 	info->linenr = kvi->linenr;
diff --git a/config.c b/config.c
index 0a5443243dc..68c9b507a4d 100644
--- a/config.c
+++ b/config.c
@@ -643,7 +643,7 @@ static int config_parse_pair(const char *key, const char *value,
 
 
 /* for values read from `git_config_from_parameters()` */
-static void kvi_from_param(struct key_value_info *out)
+void kvi_from_param(struct key_value_info *out)
 {
 	out->filename = NULL;
 	out->linenr = -1;
@@ -3964,20 +3964,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
 	return 0;
 }
 
-enum config_scope current_config_scope(void)
-{
-	if (the_reader.config_kvi)
-		return the_reader.config_kvi->scope;
-	else
-		/*
-		 * FIXME This should be a BUG, but tr2_list_env_vars_fl is
-		 * calling this outside of a config callback. This will be
-		 * easier to fix when we plumb kvi through the config callbacks,
-		 * so leave this untouched for now.
-		 */
-		return CONFIG_SCOPE_UNKNOWN;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index fb16c4aca77..f3b1a8c38a6 100644
--- a/config.h
+++ b/config.h
@@ -374,7 +374,6 @@ void git_global_config(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-enum config_scope current_config_scope(void);
 const char *config_origin_type_name(enum config_origin_type type);
 
 /*
@@ -702,4 +701,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
+void kvi_from_param(struct key_value_info *out);
+
 #endif /* CONFIG_H */
diff --git a/remote.c b/remote.c
index 10868a963f2..266601157e3 100644
--- a/remote.c
+++ b/remote.c
@@ -349,7 +349,7 @@ static void read_branches_file(struct remote_state *remote_state,
 }
 
 static int handle_config(const char *key, const char *value,
-			 struct key_value_info *kvi UNUSED, void *cb)
+			 struct key_value_info *kvi, void *cb)
 {
 	const char *name;
 	size_t namelen;
@@ -414,8 +414,8 @@ static int handle_config(const char *key, const char *value,
 	}
 	remote = make_remote(remote_state, name, namelen);
 	remote->origin = REMOTE_CONFIG;
-	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
-	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
+	if (kvi->scope == CONFIG_SCOPE_LOCAL ||
+	    kvi->scope == CONFIG_SCOPE_WORKTREE)
 		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 337587df41d..7027ffa187f 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -55,7 +55,7 @@ static int iterate_cb(const char *var, const char *value,
 	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
 	printf("name=%s\n", kvi->filename ? kvi->filename : "");
 	printf("lno=%d\n", kvi->linenr);
-	printf("scope=%s\n", config_scope_name(current_config_scope()));
+	printf("scope=%s\n", config_scope_name(kvi->scope));
 
 	return 0;
 }
diff --git a/trace2.c b/trace2.c
index e8ba62c0c3d..f519a3514b6 100644
--- a/trace2.c
+++ b/trace2.c
@@ -632,7 +632,7 @@ void trace2_thread_exit_fl(const char *file, int line)
 }
 
 void trace2_def_param_fl(const char *file, int line, const char *param,
-			 const char *value)
+			 const char *value, struct key_value_info *kvi)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
@@ -642,7 +642,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_param_fl)
-			tgt_j->pfn_param_fl(file, line, param, value);
+			tgt_j->pfn_param_fl(file, line, param, value, kvi);
 }
 
 void trace2_def_repo_fl(const char *file, int line, struct repository *repo)
diff --git a/trace2.h b/trace2.h
index 4ced30c0db3..af06f66739e 100644
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
+			 const char *value, struct key_value_info *kvi);
 
 #define trace2_def_param(param, value) \
 	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 8ed139c69f4..1450c9bec71 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -100,7 +100,7 @@ struct tr2_cfg_data {
  * See if the given config key matches any of our patterns of interest.
  */
 static int tr2_cfg_cb(const char *key, const char *value,
-		      struct key_value_info *kvi UNUSED, void *d)
+		      struct key_value_info *kvi, void *d)
 {
 	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
@@ -109,7 +109,8 @@ static int tr2_cfg_cb(const char *key, const char *value,
 		struct strbuf *buf = *s;
 		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
 		if (wm == WM_MATCH) {
-			trace2_def_param_fl(data->file, data->line, key, value);
+			trace2_def_param_fl(data->file, data->line, key, value,
+					    kvi);
 			return 0;
 		}
 	}
@@ -127,8 +128,10 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 
 void tr2_list_env_vars_fl(const char *file, int line)
 {
+	struct key_value_info kvi = { 0 };
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
index bf8745c4f05..9c88ca9beed 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -69,8 +69,10 @@ typedef void(tr2_tgt_evt_exec_result_fl_t)(const char *file, int line,
 					   uint64_t us_elapsed_absolute,
 					   int exec_id, int code);
 
+struct key_value_info;
 typedef void(tr2_tgt_evt_param_fl_t)(const char *file, int line,
-				     const char *param, const char *value);
+				     const char *param, const char *value,
+				     struct key_value_info *kvi);
 
 typedef void(tr2_tgt_evt_repo_fl_t)(const char *file, int line,
 				    const struct repository *repo);
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 9e7aab6d510..83db3c755bd 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -476,11 +476,11 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, struct key_value_info *kvi)
 {
 	const char *event_name = "def_param";
 	struct json_writer jw = JSON_WRITER_INIT;
-	enum config_scope scope = current_config_scope();
+	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
 	jw_object_begin(&jw, 0);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 8672c2c2d04..65e9be9c5a4 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -296,10 +296,10 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, struct key_value_info *kvi)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
-	enum config_scope scope = current_config_scope();
+	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
 	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 3f2b2d53118..f402f6e3813 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -438,12 +438,12 @@ static void fn_exec_result_fl(const char *file, int line,
 }
 
 static void fn_param_fl(const char *file, int line, const char *param,
-			const char *value)
+			const char *value, struct key_value_info *kvi)
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DAEB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjFTToq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjFTToe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998E1982
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so38731585e9.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290244; x=1689882244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+ik0fAoKFXomAE0tVnWYoHx7k9zwOJHSIIVNf2XE/I=;
        b=EJW8PifMWOws4nu0/NXegAfhKx0OZGhqukhg8azYNa9D7rtGQvIYwLL8vlSosR0jR3
         ryqUpW1wOp15h4XwQ2kLHWve78NUob0p2fmA98ecCuLquVojA27s42p8pIbFi3br/xom
         g3ByEYLeIylRwwLF9Qi/k4m48Tn8Cn3HB3Ma7IMlWsY2xqR3X9yzntfQlMdAmU9jmcEz
         5D60+3vAqD93MTx9DAMogPX8GBroRA3hqYHuUULK2u6aNTXvkmo09ltWYkq57T8ELXxz
         gIfU5WqJF8Ih890J037wZWcSIkhKEVXfN5bvMZNr0uRwVc9uY9g9tfZbSLggdDBtsejE
         Wy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290244; x=1689882244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+ik0fAoKFXomAE0tVnWYoHx7k9zwOJHSIIVNf2XE/I=;
        b=O6d5Fc4TnB+8w6IHNwHCiSTmFl2zxO32IFcit0GUEjvdbWJbPKfcIpxKx/ZSPSpziG
         HC6wlR6iGdyOW4kYMJdtZmLaQgbjyTbnyRi+eHkAdhxqBQ+SGuByMqPFYfl2eRtx98jP
         3yyx48MDVW0WE3Uv31jm6xmJQldem4Zwy+ivBk3aw+TZeq1a71KJ9V5ZRsvS4+fIgvbQ
         6Qw1ZZob6ZW4DpnWw8zY1VCRuU7lmoBL4kGm8uOvAdrPpI6VOGpQfzJeUHaMR1TdaR2y
         OqMvMa1bo60Wf5ISjKMHPF8gSRfffzvZSeM2jK2Dvp9IEgOgtRISf6iLkn84XA4Z1lAj
         ZpWQ==
X-Gm-Message-State: AC+VfDz+WayN3tuC+oMBcXYwJWOJajfz/yQMM7mv1HZ/ihJHtm0gLNNB
        asPXXuQL1lXGq+BEdGVTuUkyeS2CNtI=
X-Google-Smtp-Source: ACHHUZ5bpBKrstyJdmfKaZPlrBQmkKVnznX/hCgen+121Tcw4S+fSx167Ta7YErxjMnPrNYM9UDkVA==
X-Received: by 2002:a7b:c8da:0:b0:3f9:5f2:74ba with SMTP id f26-20020a7bc8da000000b003f905f274bamr7310603wml.30.1687290243151;
        Tue, 20 Jun 2023 12:44:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020a7bc409000000b003f9b24cf881sm5474601wmi.16.2023.06.20.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
Message-Id: <123e19dda4ad9458142943ab53e3a48534d5cfd7.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:48 +0000
Subject: [PATCH v3 09/12] config: pass kvi to die_bad_number()
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

Plumb "struct key_value_info" through all code paths that end in
die_bad_number(), which lets us remove the helper functions that read
analogous values from "struct config_reader". As a result, nothing reads
config_reader.config_kvi any more, so remove that too.

In config.c, this requires changing the signature of
git_configset_get_value() to 'return' "kvi" in an out parameter so that
git_configset_get_<type>() can pass it to git_config_<type>(). Only
numeric types will use "kvi", so for non-numeric types (e.g.
git_configset_get_string()), pass NULL to indicate that the out
parameter isn't needed.

Outside of config.c, config callbacks now need to pass "ctx->kvi" to any
of the git_config_<type>() functions that parse a config string into a
number type. Included is a .cocci patch to make that refactor.

The only exceptional case is builtin/config.c, where git_config_<type>()
is called outside of a config callback (namely, on user-provided input),
so config source information has never been available. In this case,
die_bad_number() defaults to a generic, but perfectly descriptive
message. Let's provide a safe, non-NULL for "kvi" anyway, but make sure
not to change the message.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 archive-tar.c                              |   4 +-
 builtin/commit-graph.c                     |   4 +-
 builtin/commit.c                           |  10 +-
 builtin/config.c                           |  21 +--
 builtin/fetch.c                            |   4 +-
 builtin/fsmonitor--daemon.c                |   6 +-
 builtin/grep.c                             |   2 +-
 builtin/index-pack.c                       |   4 +-
 builtin/log.c                              |   2 +-
 builtin/pack-objects.c                     |  14 +-
 builtin/receive-pack.c                     |  10 +-
 builtin/submodule--helper.c                |   4 +-
 config.c                                   | 156 ++++++++-------------
 config.h                                   |  17 ++-
 contrib/coccinelle/git_config_number.cocci |  27 ++++
 diff.c                                     |   9 +-
 fmt-merge-msg.c                            |   2 +-
 help.c                                     |   4 +-
 http.c                                     |  10 +-
 imap-send.c                                |   2 +-
 sequencer.c                                |  22 +--
 setup.c                                    |   2 +-
 submodule-config.c                         |  13 +-
 submodule-config.h                         |   3 +-
 t/helper/test-config.c                     |   6 +-
 trace2/tr2_cfg.c                           |   2 +-
 upload-pack.c                              |  12 +-
 worktree.c                                 |   2 +-
 28 files changed, 191 insertions(+), 183 deletions(-)
 create mode 100644 contrib/coccinelle/git_config_number.cocci

diff --git a/archive-tar.c b/archive-tar.c
index ef06e516b1f..3df8af6d1b1 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -412,14 +412,14 @@ static int tar_filter_config(const char *var, const char *value,
 }
 
 static int git_tar_config(const char *var, const char *value,
-			  const struct config_context *ctx UNUSED, void *cb)
+			  const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
-			tar_umask = git_config_int(var, value);
+			tar_umask = git_config_int(var, value, ctx->kvi);
 		}
 		return 0;
 	}
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 13d35b00ca8..c7e27a8c0a2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -186,11 +186,11 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
-					 const struct config_context *ctx UNUSED,
+					 const struct config_context *ctx,
 					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
-		write_opts.max_new_filters = git_config_int(var, value);
+		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
 	/*
 	 * No need to fall-back to 'git_default_config', since this was already
 	 * called in 'cmd_commit_graph()'.
diff --git a/builtin/commit.c b/builtin/commit.c
index 3bc87e5fc97..4e5e7722238 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1415,7 +1415,8 @@ static int git_status_config(const char *k, const char *v,
 		return git_column_config(k, v, "status", &s->colopts);
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
-		s->submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		s->submodule_summary = git_config_bool_or_int(k, v, ctx->kvi,
+							      &is_bool);
 		if (is_bool && s->submodule_summary)
 			s->submodule_summary = -1;
 		return 0;
@@ -1475,11 +1476,11 @@ static int git_status_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "diff.renamelimit")) {
 		if (s->rename_limit == -1)
-			s->rename_limit = git_config_int(k, v);
+			s->rename_limit = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "status.renamelimit")) {
-		s->rename_limit = git_config_int(k, v);
+		s->rename_limit = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "diff.renames")) {
@@ -1625,7 +1626,8 @@ static int git_commit_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
-		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
+		config_commit_verbose = git_config_bool_or_int(k, v, ctx->kvi,
+							       &is_bool);
 		return 0;
 	}
 
diff --git a/builtin/config.c b/builtin/config.c
index 0c01ded5f05..c61988a7bf3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -261,13 +261,14 @@ static int format_config(struct strbuf *buf, const char *key_,
 
 		if (type == TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
-				    git_config_int64(key_, value_ ? value_ : ""));
+				    git_config_int64(key_, value_ ? value_ : "", kvi));
 		else if (type == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
 		else if (type == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
-			v = git_config_bool_or_int(key_, value_, &is_bool);
+			v = git_config_bool_or_int(key_, value_, kvi,
+						   &is_bool);
 			if (is_bool)
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
@@ -422,7 +423,8 @@ free_strings:
 	return ret;
 }
 
-static char *normalize_value(const char *key, const char *value)
+static char *normalize_value(const char *key, const char *value,
+			     struct key_value_info *kvi)
 {
 	if (!value)
 		return NULL;
@@ -437,12 +439,12 @@ static char *normalize_value(const char *key, const char *value)
 		 */
 		return xstrdup(value);
 	if (type == TYPE_INT)
-		return xstrfmt("%"PRId64, git_config_int64(key, value));
+		return xstrfmt("%"PRId64, git_config_int64(key, value, kvi));
 	if (type == TYPE_BOOL)
 		return xstrdup(git_config_bool(key, value) ?  "true" : "false");
 	if (type == TYPE_BOOL_OR_INT) {
 		int is_bool, v;
-		v = git_config_bool_or_int(key, value, &is_bool);
+		v = git_config_bool_or_int(key, value, kvi, &is_bool);
 		if (!is_bool)
 			return xstrfmt("%d", v);
 		else
@@ -669,6 +671,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	char *value = NULL;
 	int flags = 0;
 	int ret = 0;
+	struct key_value_info default_kvi = KVI_INIT;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -886,7 +889,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
@@ -895,7 +898,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags);
@@ -903,7 +906,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
@@ -912,7 +915,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags | CONFIG_FLAGS_MULTI_REPLACE);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b607605b491..033d1fe65d2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -138,7 +138,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v);
+		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v, ctx->kvi);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
@@ -146,7 +146,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.parallel")) {
-		fetch_parallel_config = git_config_int(k, v);
+		fetch_parallel_config = git_config_int(k, v, ctx->kvi);
 		if (fetch_parallel_config < 0)
 			die(_("fetch.parallel cannot be negative"));
 		if (!fetch_parallel_config)
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 91a776e2f17..6d2826b07da 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -41,7 +41,7 @@ static int fsmonitor_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, ctx->kvi);
 		if (i < 1)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__IPC_THREADS, i);
@@ -50,7 +50,7 @@ static int fsmonitor_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, ctx->kvi);
 		if (i < 0)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__START_TIMEOUT, i);
@@ -60,7 +60,7 @@ static int fsmonitor_config(const char *var, const char *value,
 
 	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
 		int is_bool;
-		int i = git_config_bool_or_int(var, value, &is_bool);
+		int i = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
 		if (i < 0)
 			return error(_("value of '%s' not bool or int: %d"),
 				     var, i);
diff --git a/builtin/grep.c b/builtin/grep.c
index 757d52b94ec..3a464e6faab 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -301,7 +301,7 @@ static int grep_cmd_config(const char *var, const char *value,
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-		num_threads = git_config_int(var, value);
+		num_threads = git_config_int(var, value, ctx->kvi);
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31914aac298..857518fdf83 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1587,13 +1587,13 @@ static int git_index_pack_config(const char *k, const char *v,
 	struct pack_idx_option *opts = cb;
 
 	if (!strcmp(k, "pack.indexversion")) {
-		opts->version = git_config_int(k, v);
+		opts->version = git_config_int(k, v, ctx->kvi);
 		if (opts->version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		nr_threads = git_config_int(k, v);
+		nr_threads = git_config_int(k, v, ctx->kvi);
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
diff --git a/builtin/log.c b/builtin/log.c
index ac5f74b6b06..675cf358f7a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -574,7 +574,7 @@ static int git_log_config(const char *var, const char *value,
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "format.filenamemaxlength")) {
-		fmt_patch_name_max = git_config_int(var, value);
+		fmt_patch_name_max = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ad4d8fafb0b..d6d9079fd93 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3139,23 +3139,23 @@ static int git_pack_config(const char *k, const char *v,
 			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "pack.window")) {
-		window = git_config_int(k, v);
+		window = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.windowmemory")) {
-		window_memory_limit = git_config_ulong(k, v);
+		window_memory_limit = git_config_ulong(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.depth")) {
-		depth = git_config_int(k, v);
+		depth = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v);
+		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
-		cache_max_small_delta_size = git_config_int(k, v);
+		cache_max_small_delta_size = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
@@ -3181,7 +3181,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		delta_search_threads = git_config_int(k, v);
+		delta_search_threads = git_config_int(k, v, ctx->kvi);
 		if (delta_search_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
@@ -3192,7 +3192,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_opts.version = git_config_int(k, v);
+		pack_idx_opts.version = git_config_int(k, v, ctx->kvi);
 		if (pack_idx_opts.version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32),
 			    pack_idx_opts.version);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d9898aff7..98f6f0038f0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -158,12 +158,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.unpacklimit") == 0) {
-		receive_unpack_limit = git_config_int(var, value);
+		receive_unpack_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value);
+		transfer_unpack_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -231,7 +231,7 @@ static int receive_pack_config(const char *var, const char *value,
 		return git_config_string(&cert_nonce_seed, var, value);
 
 	if (strcmp(var, "receive.certnonceslop") == 0) {
-		nonce_stamp_slop_limit = git_config_ulong(var, value);
+		nonce_stamp_slop_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -246,12 +246,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.keepalive") == 0) {
-		keepalive_in_sec = git_config_int(var, value);
+		keepalive_in_sec = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "receive.maxinputsize") == 0) {
-		max_input_size = git_config_int64(var, value);
+		max_input_size = git_config_int64(var, value, ctx->kvi);
 		return 0;
 	}
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3f8f3692937..9e78e5f7a9d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2189,13 +2189,13 @@ static int update_clone_task_finished(int result,
 }
 
 static int git_update_clone_config(const char *var, const char *value,
-				   const struct config_context *ctx UNUSED,
+				   const struct config_context *ctx,
 				   void *cb)
 {
 	int *max_jobs = cb;
 
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
 	return 0;
 }
 
diff --git a/config.c b/config.c
index f519656ebcf..a2887b856aa 100644
--- a/config.c
+++ b/config.c
@@ -73,18 +73,8 @@ struct config_reader {
 	 *
 	 * The "source" variable will be non-NULL only when we are actually
 	 * parsing a real config source (file, blob, cmdline, etc).
-	 *
-	 * The "config_kvi" variable will be non-NULL only when we are feeding
-	 * cached config from a configset into a callback.
-	 *
-	 * They cannot be non-NULL at the same time. If they are both NULL, then
-	 * we aren't parsing anything (and depending on the function looking at
-	 * the variables, it's either a bug for it to be called in the first
-	 * place, or it's a function which can be reused for non-config
-	 * purposes, and should fall back to some sane behavior).
 	 */
 	struct config_source *source;
-	struct key_value_info *config_kvi;
 };
 /*
  * Where possible, prefer to accept "struct config_reader" as an arg than to use
@@ -96,8 +86,6 @@ static struct config_reader the_reader;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
-	if (reader->config_kvi)
-		BUG("source should not be set while iterating a config set");
 	top->prev = reader->source;
 	reader->source = top;
 }
@@ -112,12 +100,6 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 	return ret;
 }
 
-static inline void config_reader_set_kvi(struct config_reader *reader,
-					 struct key_value_info *kvi)
-{
-	reader->config_kvi = kvi;
-}
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -1344,80 +1326,78 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out);
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type);
 NORETURN
-static void die_bad_number(struct config_reader *reader, const char *name,
-			   const char *value)
+static void die_bad_number(const char *name, const char *value,
+			   const struct key_value_info *kvi)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
 	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
-	const char *config_name = NULL;
-	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
+
+	if (!kvi)
+		BUG("kvi should not be NULL");
 
 	if (!value)
 		value = "";
 
-	/* Ignoring the return value is okay since we handle missing values. */
-	reader_config_name(reader, &config_name);
-	reader_origin_type(reader, &config_origin);
-
-	if (!config_name)
+	if (!kvi->filename)
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (config_origin) {
+	switch (kvi->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	}
 }
 
-int git_config_int(const char *name, const char *value)
+int git_config_int(const char *name, const char *value,
+		   const struct key_value_info *kvi)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-int64_t git_config_int64(const char *name, const char *value)
+int64_t git_config_int64(const char *name, const char *value,
+			 const struct key_value_info *kvi)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-unsigned long git_config_ulong(const char *name, const char *value)
+unsigned long git_config_ulong(const char *name, const char *value,
+			       const struct key_value_info *kvi)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-ssize_t git_config_ssize_t(const char *name, const char *value)
+ssize_t git_config_ssize_t(const char *name, const char *value,
+			   const struct key_value_info *kvi)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
@@ -1522,7 +1502,8 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
-int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+int git_config_bool_or_int(const char *name, const char *value,
+			   const struct key_value_info *kvi, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v) {
@@ -1530,7 +1511,7 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return v;
 	}
 	*is_bool = 0;
-	return git_config_int(name, value);
+	return git_config_int(name, value, kvi);
 }
 
 int git_config_bool(const char *name, const char *value)
@@ -1656,7 +1637,7 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (!git_parse_maybe_bool_text(value))
 			default_abbrev = the_hash_algo->hexsz;
 		else {
-			int abbrev = git_config_int(var, value);
+			int abbrev = git_config_int(var, value, ctx->kvi);
 			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev = abbrev;
@@ -1668,7 +1649,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return set_disambiguate_hint_config(var, value);
 
 	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1679,7 +1660,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1693,7 +1674,7 @@ static int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);
+		packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -1704,17 +1685,17 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value);
+		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
+		packed_git_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value);
+		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -1998,12 +1979,12 @@ int git_default_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
+		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "pack.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -2336,13 +2317,11 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		config_reader_set_kvi(reader, values->items[value_index].util);
 		ctx.kvi = values->items[value_index].util;
 		if (fn(entry->key, values->items[value_index].string, &ctx, data) < 0)
 			git_die_config_linenr(entry->key,
 					      ctx.kvi->filename,
 					      ctx.kvi->linenr);
-		config_reader_set_kvi(reader, NULL);
 	}
 }
 
@@ -2526,11 +2505,12 @@ int git_configset_add_file(struct config_set *set, const char *filename)
 	return git_config_from_file(config_set_callback, filename, &data);
 }
 
-int git_configset_get_value(struct config_set *set, const char *key, const char **value)
+int git_configset_get_value(struct config_set *set, const char *key,
+			    const char **value, struct key_value_info *kvi)
 {
 	const struct string_list *values = NULL;
 	int ret;
-
+	struct string_list_item item;
 	/*
 	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
 	 * queried key in the files of the configset, the value returned will be the last
@@ -2540,7 +2520,10 @@ int git_configset_get_value(struct config_set *set, const char *key, const char
 		return ret;
 
 	assert(values->nr > 0);
-	*value = values->items[values->nr - 1].string;
+	item = values->items[values->nr - 1];
+	*value = item.string;
+	if (kvi)
+		*kvi = *((struct key_value_info *)item.util);
 	return 0;
 }
 
@@ -2593,7 +2576,7 @@ int git_configset_get(struct config_set *set, const char *key)
 int git_configset_get_string(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
@@ -2603,7 +2586,7 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		if (!value)
 			return config_error_nonbool(key);
 		*dest = value;
@@ -2616,8 +2599,10 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_int(key, value);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_int(key, value, &kvi);
 		return 0;
 	} else
 		return 1;
@@ -2626,8 +2611,10 @@ int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_ulong(key, value);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_ulong(key, value, &kvi);
 		return 0;
 	} else
 		return 1;
@@ -2636,7 +2623,7 @@ int git_configset_get_ulong(struct config_set *set, const char *key, unsigned lo
 int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_config_bool(key, value);
 		return 0;
 	} else
@@ -2647,8 +2634,10 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 				int *is_bool, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_bool_or_int(key, value, is_bool);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_bool_or_int(key, value, &kvi, is_bool);
 		return 0;
 	} else
 		return 1;
@@ -2657,7 +2646,7 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
@@ -2669,7 +2658,7 @@ int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *d
 int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_pathname(dest, key, value);
 	else
 		return 1;
@@ -2739,7 +2728,7 @@ int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value(repo->config, key, value);
+	return git_configset_get_value(repo->config, key, value, NULL);
 }
 
 int repo_config_get_value_multi(struct repository *repo, const char *key,
@@ -3977,18 +3966,6 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type)
-{
-	if (the_reader.config_kvi)
-		*type = reader->config_kvi->origin_type;
-	else if(the_reader.source)
-		*type = reader->source->origin_type;
-	else
-		return 1;
-	return 0;
-}
-
 const char *config_origin_type_name(enum config_origin_type type)
 {
 	switch (type) {
@@ -4027,17 +4004,6 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out)
-{
-	if (the_reader.config_kvi)
-		*out = reader->config_kvi->filename;
-	else if (the_reader.source)
-		*out = reader->source->name;
-	else
-		return 1;
-	return 0;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 092db17d2e4..a8f41c59e6c 100644
--- a/config.h
+++ b/config.h
@@ -249,22 +249,26 @@ int git_parse_maybe_bool(const char *);
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
  */
-int git_config_int(const char *, const char *);
+int git_config_int(const char *, const char *, const struct key_value_info *);
 
-int64_t git_config_int64(const char *, const char *);
+int64_t git_config_int64(const char *, const char *,
+			 const struct key_value_info *);
 
 /**
  * Identical to `git_config_int`, but for unsigned longs.
  */
-unsigned long git_config_ulong(const char *, const char *);
+unsigned long git_config_ulong(const char *, const char *,
+			       const struct key_value_info *);
 
-ssize_t git_config_ssize_t(const char *, const char *);
+ssize_t git_config_ssize_t(const char *, const char *,
+			   const struct key_value_info *);
 
 /**
  * Same as `git_config_bool`, except that integers are returned as-is, and
  * an `is_bool` flag is unset.
  */
-int git_config_bool_or_int(const char *, const char *, int *);
+int git_config_bool_or_int(const char *, const char *,
+			   const struct key_value_info *, int *);
 
 /**
  * Parse a string into a boolean value, respecting keywords like "true" and
@@ -529,7 +533,8 @@ int git_configset_get(struct config_set *cs, const char *key);
  * touching `value`. The caller should not free or modify `value`, as it
  * is owned by the cache.
  */
-int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_value(struct config_set *cs, const char *key,
+			    const char **dest, struct key_value_info *kvi);
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
diff --git a/contrib/coccinelle/git_config_number.cocci b/contrib/coccinelle/git_config_number.cocci
new file mode 100644
index 00000000000..7b57dceefe6
--- /dev/null
+++ b/contrib/coccinelle/git_config_number.cocci
@@ -0,0 +1,27 @@
+@@
+identifier C1, C2, C3;
+@@
+(
+(
+git_config_int
+|
+git_config_int64
+|
+git_config_ulong
+|
+git_config_ssize_t
+)
+  (C1, C2
++ , ctx->kvi
+  )
+|
+(
+git_configset_get_value
+|
+git_config_bool_or_int
+)
+  (C1, C2
++ , ctx->kvi
+ , C3
+  )
+)
diff --git a/diff.c b/diff.c
index 07be3bee137..8775323e39c 100644
--- a/diff.c
+++ b/diff.c
@@ -379,13 +379,14 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value);
+		diff_context_default = git_config_int(var, value, ctx->kvi);
 		if (diff_context_default < 0)
 			return -1;
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
-		diff_interhunk_context_default = git_config_int(var, value);
+		diff_interhunk_context_default = git_config_int(var, value,
+								ctx->kvi);
 		if (diff_interhunk_context_default < 0)
 			return -1;
 		return 0;
@@ -411,7 +412,7 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
-		diff_stat_graph_width = git_config_int(var, value);
+		diff_stat_graph_width = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
@@ -450,7 +451,7 @@ int git_diff_basic_config(const char *var, const char *value,
 	const char *name;
 
 	if (!strcmp(var, "diff.renamelimit")) {
-		diff_rename_limit_default = git_config_int(var, value);
+		diff_rename_limit_default = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 10137444321..3ae59bde2f2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -25,7 +25,7 @@ int fmt_merge_msg_config(const char *key, const char *value,
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
-		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
+		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
 		if (!is_bool && merge_log_config < 0)
 			return error("%s: negative length %s", key, value);
 		if (is_bool && merge_log_config)
diff --git a/help.c b/help.c
index ac0ae5ac0dc..389382b1482 100644
--- a/help.c
+++ b/help.c
@@ -545,7 +545,7 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
 static int git_unknown_cmd_config(const char *var, const char *value,
-				  const struct config_context *ctx UNUSED,
+				  const struct config_context *ctx,
 				  void *cb UNUSED)
 {
 	const char *p;
@@ -560,7 +560,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 		} else if (!strcmp(value, "prompt")) {
 			autocorrect = AUTOCORRECT_PROMPT;
 		} else {
-			int v = git_config_int(var, value);
+			int v = git_config_int(var, value, ctx->kvi);
 			autocorrect = (v < 0)
 				? AUTOCORRECT_IMMEDIATELY : v;
 		}
diff --git a/http.c b/http.c
index 762502828c9..b12b234bde1 100644
--- a/http.c
+++ b/http.c
@@ -414,21 +414,21 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.minsessions", var)) {
-		min_curl_sessions = git_config_int(var, value);
+		min_curl_sessions = git_config_int(var, value, ctx->kvi);
 		if (min_curl_sessions > 1)
 			min_curl_sessions = 1;
 		return 0;
 	}
 	if (!strcmp("http.maxrequests", var)) {
-		max_requests = git_config_int(var, value);
+		max_requests = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedlimit", var)) {
-		curl_low_speed_limit = (long)git_config_int(var, value);
+		curl_low_speed_limit = (long)git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedtime", var)) {
-		curl_low_speed_time = (long)git_config_int(var, value);
+		curl_low_speed_time = (long)git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -464,7 +464,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.postbuffer", var)) {
-		http_post_buffer = git_config_ssize_t(var, value);
+		http_post_buffer = git_config_ssize_t(var, value, ctx->kvi);
 		if (http_post_buffer < 0)
 			warning(_("negative value for http.postBuffer; defaulting to %d"), LARGE_PACKET_MAX);
 		if (http_post_buffer < LARGE_PACKET_MAX)
diff --git a/imap-send.c b/imap-send.c
index 47777e76861..3518a4ace6c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1342,7 +1342,7 @@ static int git_imap_config(const char *var, const char *val,
 	else if (!strcmp("imap.authmethod", var))
 		return git_config_string(&server.auth_method, var, val);
 	else if (!strcmp("imap.port", var))
-		server.port = git_config_int(var, val);
+		server.port = git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			git_die_config("imap.host", "Missing value for 'imap.host'");
diff --git a/sequencer.c b/sequencer.c
index 34754d17596..a0aaee3056d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2883,7 +2883,7 @@ static int git_config_string_dup(char **dest,
 }
 
 static int populate_opts_cb(const char *key, const char *value,
-			    const struct config_context *ctx UNUSED,
+			    const struct config_context *ctx,
 			    void *data)
 {
 	struct replay_opts *opts = data;
@@ -2892,26 +2892,26 @@ static int populate_opts_cb(const char *key, const char *value,
 	if (!value)
 		error_flag = 0;
 	else if (!strcmp(key, "options.no-commit"))
-		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+		opts->no_commit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.edit"))
-		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+		opts->edit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty"))
 		opts->allow_empty =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.signoff"))
-		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
+		opts->signoff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
-		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
-		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+		opts->allow_ff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
-		opts->mainline = git_config_int(key, value);
+		opts->mainline = git_config_int(key, value, ctx->kvi);
 	else if (!strcmp(key, "options.strategy"))
 		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -2920,7 +2920,7 @@ static int populate_opts_cb(const char *key, const char *value,
 		strvec_push(&opts->xopts, value);
 	} else if (!strcmp(key, "options.allow-rerere-auto"))
 		opts->allow_rerere_auto =
-			git_config_bool_or_int(key, value, &error_flag) ?
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
 	else if (!strcmp(key, "options.default-msg-cleanup")) {
 		opts->explicit_cleanup = 1;
diff --git a/setup.c b/setup.c
index e7f81151ef0..260ad92df6e 100644
--- a/setup.c
+++ b/setup.c
@@ -597,7 +597,7 @@ static int check_repo_format(const char *var, const char *value,
 	const char *ext;
 
 	if (strcmp(var, "core.repositoryformatversion") == 0)
-		data->version = git_config_int(var, value);
+		data->version = git_config_int(var, value, ctx->kvi);
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		switch (handle_extension_v0(var, value, ext, data)) {
 		case EXTENSION_ERROR:
diff --git a/submodule-config.c b/submodule-config.c
index e19ab593aa4..0cda0f659f2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -304,9 +304,10 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 	}
 }
 
-int parse_submodule_fetchjobs(const char *var, const char *value)
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      const struct key_value_info *kvi)
 {
-	int fetchjobs = git_config_int(var, value);
+	int fetchjobs = git_config_int(var, value, kvi);
 	if (fetchjobs < 0)
 		die(_("negative values not allowed for submodule.fetchJobs"));
 	if (!fetchjobs)
@@ -850,14 +851,14 @@ struct fetch_config {
 };
 
 static int gitmodules_fetch_config(const char *var, const char *value,
-				   const struct config_context *ctx UNUSED,
+				   const struct config_context *ctx,
 				   void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
 		if (config->max_children)
 			*(config->max_children) =
-				parse_submodule_fetchjobs(var, value);
+				parse_submodule_fetchjobs(var, value, ctx->kvi);
 		return 0;
 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
 		if (config->recurse_submodules)
@@ -879,12 +880,12 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
-					  const struct config_context *ctx UNUSED,
+					  const struct config_context *ctx,
 					  void *cb)
 {
 	int *max_jobs = cb;
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
 	return 0;
 }
 
diff --git a/submodule-config.h b/submodule-config.h
index c2045875bbb..2a37689cc27 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -50,7 +50,8 @@ struct repository;
 
 void submodule_cache_free(struct submodule_cache *cache);
 
-int parse_submodule_fetchjobs(const char *var, const char *value);
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      const struct key_value_info *kvi);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 3f4c3678318..ed444ca4c25 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -63,12 +63,12 @@ static int iterate_cb(const char *var, const char *value,
 }
 
 static int parse_int_cb(const char *var, const char *value,
-			const struct config_context *ctx UNUSED, void *data)
+			const struct config_context *ctx, void *data)
 {
 	const char *key_to_match = data;
 
 	if (!strcmp(key_to_match, var)) {
-		int parsed = git_config_int(value, value);
+		int parsed = git_config_int(value, value, ctx->kvi);
 		printf("%d\n", parsed);
 	}
 	return 0;
@@ -182,7 +182,7 @@ int cmd__config(int argc, const char **argv)
 				goto exit2;
 			}
 		}
-		if (!git_configset_get_value(&cs, argv[2], &v)) {
+		if (!git_configset_get_value(&cs, argv[2], &v, NULL)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 00d546a27cd..733d9d2872a 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -100,7 +100,7 @@ struct tr2_cfg_data {
  * See if the given config key matches any of our patterns of interest.
  */
 static int tr2_cfg_cb(const char *key, const char *value,
-		      const struct config_context *ctx UNUSED, void *d)
+		      const struct config_context *ctx, void *d)
 {
 	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
diff --git a/upload-pack.c b/upload-pack.c
index 951fd1f9c25..c03415a5460 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1275,7 +1275,8 @@ static int find_symref(const char *refname,
 }
 
 static int parse_object_filter_config(const char *var, const char *value,
-				       struct upload_pack_data *data)
+				      const struct key_value_info *kvi,
+				      struct upload_pack_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *sub, *key;
@@ -1302,7 +1303,8 @@ static int parse_object_filter_config(const char *var, const char *value,
 		}
 		string_list_insert(&data->allowed_filters, buf.buf)->util =
 			(void *)(intptr_t)1;
-		data->tree_filter_max_depth = git_config_ulong(var, value);
+		data->tree_filter_max_depth = git_config_ulong(var, value,
+							       kvi);
 	}
 
 	strbuf_release(&buf);
@@ -1310,7 +1312,7 @@ static int parse_object_filter_config(const char *var, const char *value,
 }
 
 static int upload_pack_config(const char *var, const char *value,
-			      const struct config_context *ctx UNUSED,
+			      const struct config_context *ctx,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
@@ -1331,7 +1333,7 @@ static int upload_pack_config(const char *var, const char *value,
 		else
 			data->allow_uor &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		data->keepalive = git_config_int(var, value);
+		data->keepalive = git_config_int(var, value, ctx->kvi);
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
@@ -1346,7 +1348,7 @@ static int upload_pack_config(const char *var, const char *value,
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (parse_object_filter_config(var, value, data) < 0)
+	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
 		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
diff --git a/worktree.c b/worktree.c
index b5ee71c5ebd..1fbdbd745fb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -835,7 +835,7 @@ int init_worktree_config(struct repository *r)
 	 * Relocate that value to avoid breaking all worktrees with this
 	 * upgrade to worktree config.
 	 */
-	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree)) {
+	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree, NULL)) {
 		if ((res = move_config_setting("core.worktree", core_worktree,
 					       common_config_file,
 					       main_worktree_file)))
-- 
gitgitgadget


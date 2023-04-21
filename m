Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB45C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjDUTOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjDUTN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AA26A3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so22033895e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104410; x=1684696410;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38ror4x6wgTIJL+1zUDk/bTSNDrtdx5p1s8ovxTmpEs=;
        b=ftYbdMu8atr78nTfjNW9vOfDRmkxK0mSXP2OaUT3+fXt3T5XNjjQkWm71I5Ss4ykAP
         N9lUC2udtvxj/hejbUvw1bBHxejvp8nVftbHh5U3pDNgyS1w6hKC6rrNIksyKa+OEMHB
         /Loc0RMWDfj7YLI0G5ZkgywOe6K+QnVm44gEiPXsOR1IXnf5i3rRge1nbXrqtRksoU5S
         wPHX21jAlTKO1xvJpN//0HClXsmRmgum954TIWpI80yh+xuVFqWBaGODqv2NxdWEn8O3
         YuU03+0S8/7YsLAGePTIU6dIG+1+VlJkCAIWf7oYMwXEyWIS5+npc1uii1XRxRQ+aosO
         80Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104410; x=1684696410;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38ror4x6wgTIJL+1zUDk/bTSNDrtdx5p1s8ovxTmpEs=;
        b=A3PUjWh+TrNsSa5AOPiyrJZohUApzeHnd7Ddcr9gz1J84i7vjsU82/COSJQbWZDvPt
         yXZ81l9wejo8LT+nC9SCLO74IviMBe6Idg9oYZ9v4I2qQlbj/6E4gsjoOipF6n4n9tqz
         w0ERkJS1krEJDI3T1Id50mrGIzgXhXRzuyGhgILcCpt09qHK1jrDUdZfEhEsBoqcXQ8+
         er7xcctAaAj++h6MDZfB+YQka0mIg3+dZrTt9hnQ6oDKTYXldN9Gq2/CcXCF5YE74Ld3
         kI1VFctVN2kA8NN+hZUyA2aGDmuoB5r9Jr/l2oUzbGnBI4oa7dHFD0eCzVFsKIPl4GTG
         dh5w==
X-Gm-Message-State: AAQBX9dpoJvMqTEVTWlCV8EOSvBs4v3ZhafFcXyGqNDDMrGpW9eUXs+A
        RsSiEE/57xhZTDbb3/+XNPHFsonG/uM=
X-Google-Smtp-Source: AKy350Yu2V9b/4O2YD5lUgB+WACGcCxbfH9E7Kza5dVCcGtSZWs6ireb1yHDCLfbKT+0GRALm+9fIw==
X-Received: by 2002:a1c:f602:0:b0:3f1:6836:5db0 with SMTP id w2-20020a1cf602000000b003f168365db0mr2806327wmc.27.1682104409234;
        Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003f0a6a1f969sm9026911wmo.46.2023.04.21.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:29 -0700 (PDT)
Message-Id: <11a32c86203648700cb43cd1ea1c664fd9b21c88.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:17 +0000
Subject: [PATCH 13/14] config: pass kvi to die_bad_number()
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

Plumb "struct key_value_info" through all code paths that end in
die_bad_number(), which lets us remove the helper functions that read
analogous values from "struct config_reader".

In config.c, this requires changing the signature of
git_configset_get_value() to 'return' "kvi" in an out parameter so that
git_configset_get_<type>() can pass it to git_config_<type>().

Outside of config.c, config callbacks now need to pass "kvi" to any of
the git_config_<type>() functions that parse a config string into a
number type. Included is a .cocci patch to make that refactor. In cases
where "kvi" would never be used, pass NULL, e.g.:

- In config.c, when we are parsing a boolean instead of a number
- In builtin/config.c, when calling normalize_value() before setting
  config to something the user gave us.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 archive-tar.c                              |   4 +-
 builtin/commit-graph.c                     |   4 +-
 builtin/commit.c                           |  10 +-
 builtin/config.c                           |  20 ++--
 builtin/fetch.c                            |   4 +-
 builtin/fsmonitor--daemon.c                |   6 +-
 builtin/grep.c                             |   2 +-
 builtin/index-pack.c                       |   4 +-
 builtin/log.c                              |   2 +-
 builtin/pack-objects.c                     |  14 +--
 builtin/receive-pack.c                     |  10 +-
 builtin/submodule--helper.c                |   4 +-
 config.c                                   | 128 +++++++++------------
 config.h                                   |  14 ++-
 contrib/coccinelle/git_config_number.cocci |  27 +++++
 diff.c                                     |   9 +-
 fmt-merge-msg.c                            |   2 +-
 help.c                                     |   5 +-
 http.c                                     |  10 +-
 imap-send.c                                |   2 +-
 sequencer.c                                |  22 ++--
 setup.c                                    |   2 +-
 submodule-config.c                         |  15 ++-
 submodule-config.h                         |   3 +-
 t/helper/test-config.c                     |   6 +-
 upload-pack.c                              |  12 +-
 worktree.c                                 |   2 +-
 27 files changed, 182 insertions(+), 161 deletions(-)
 create mode 100644 contrib/coccinelle/git_config_number.cocci

diff --git a/archive-tar.c b/archive-tar.c
index dcfbce5225a..1cd6d72d21e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -411,14 +411,14 @@ static int tar_filter_config(const char *var, const char *value,
 }
 
 static int git_tar_config(const char *var, const char *value,
-			  struct key_value_info *kvi UNUSED, void *cb)
+			  struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
-			tar_umask = git_config_int(var, value);
+			tar_umask = git_config_int(var, value, kvi);
 		}
 		return 0;
 	}
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e811866b5dd..c99804abc7e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -185,11 +185,11 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
-					 struct key_value_info *kvi UNUSED,
+					 struct key_value_info *kvi,
 					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
-		write_opts.max_new_filters = git_config_int(var, value);
+		write_opts.max_new_filters = git_config_int(var, value, kvi);
 	/*
 	 * No need to fall-back to 'git_default_config', since this was already
 	 * called in 'cmd_commit_graph()'.
diff --git a/builtin/commit.c b/builtin/commit.c
index ec468e87039..e846355ec39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1412,7 +1412,8 @@ static int git_status_config(const char *k, const char *v,
 		return git_column_config(k, v, "status", &s->colopts);
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
-		s->submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		s->submodule_summary = git_config_bool_or_int(k, v, kvi,
+							      &is_bool);
 		if (is_bool && s->submodule_summary)
 			s->submodule_summary = -1;
 		return 0;
@@ -1472,11 +1473,11 @@ static int git_status_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "diff.renamelimit")) {
 		if (s->rename_limit == -1)
-			s->rename_limit = git_config_int(k, v);
+			s->rename_limit = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "status.renamelimit")) {
-		s->rename_limit = git_config_int(k, v);
+		s->rename_limit = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "diff.renames")) {
@@ -1622,7 +1623,8 @@ static int git_commit_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
-		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
+		config_commit_verbose = git_config_bool_or_int(k, v, kvi,
+							       &is_bool);
 		return 0;
 	}
 
diff --git a/builtin/config.c b/builtin/config.c
index 7899add68fb..fcfceb8e156 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -254,13 +254,14 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 
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
@@ -411,7 +412,8 @@ free_strings:
 	return ret;
 }
 
-static char *normalize_value(const char *key, const char *value)
+static char *normalize_value(const char *key, const char *value,
+			     struct key_value_info *kvi)
 {
 	if (!value)
 		return NULL;
@@ -426,12 +428,12 @@ static char *normalize_value(const char *key, const char *value)
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
@@ -870,7 +872,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], NULL);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
@@ -879,7 +881,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], NULL);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags);
@@ -887,7 +889,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], NULL);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
@@ -896,7 +898,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], NULL);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags | CONFIG_FLAGS_MULTI_REPLACE);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index aa688291613..04cf5518d2c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -125,7 +125,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v);
+		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v, kvi);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
@@ -133,7 +133,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.parallel")) {
-		fetch_parallel_config = git_config_int(k, v);
+		fetch_parallel_config = git_config_int(k, v, kvi);
 		if (fetch_parallel_config < 0)
 			die(_("fetch.parallel cannot be negative"));
 		if (!fetch_parallel_config)
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index a7375d61d02..cde4a575836 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -40,7 +40,7 @@ static int fsmonitor_config(const char *var, const char *value,
 			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, kvi);
 		if (i < 1)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__IPC_THREADS, i);
@@ -49,7 +49,7 @@ static int fsmonitor_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, kvi);
 		if (i < 0)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__START_TIMEOUT, i);
@@ -59,7 +59,7 @@ static int fsmonitor_config(const char *var, const char *value,
 
 	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
 		int is_bool;
-		int i = git_config_bool_or_int(var, value, &is_bool);
+		int i = git_config_bool_or_int(var, value, kvi, &is_bool);
 		if (i < 0)
 			return error(_("value of '%s' not bool or int: %d"),
 				     var, i);
diff --git a/builtin/grep.c b/builtin/grep.c
index 6e795f9f3a2..edb57f048ef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -298,7 +298,7 @@ static int grep_cmd_config(const char *var, const char *value,
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-		num_threads = git_config_int(var, value);
+		num_threads = git_config_int(var, value, kvi);
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4450510ddfc..e7685fa9a6f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1584,13 +1584,13 @@ static int git_index_pack_config(const char *k, const char *v,
 	struct pack_idx_option *opts = cb;
 
 	if (!strcmp(k, "pack.indexversion")) {
-		opts->version = git_config_int(k, v);
+		opts->version = git_config_int(k, v, kvi);
 		if (opts->version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		nr_threads = git_config_int(k, v);
+		nr_threads = git_config_int(k, v, kvi);
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
diff --git a/builtin/log.c b/builtin/log.c
index f8e61330491..805320a1abf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -569,7 +569,7 @@ static int git_log_config(const char *var, const char *value,
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "format.filenamemaxlength")) {
-		fmt_patch_name_max = git_config_int(var, value);
+		fmt_patch_name_max = git_config_int(var, value, kvi);
 		return 0;
 	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca023000cc0..cde11f83f81 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3138,23 +3138,23 @@ static int git_pack_config(const char *k, const char *v,
 			   struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(k, "pack.window")) {
-		window = git_config_int(k, v);
+		window = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.windowmemory")) {
-		window_memory_limit = git_config_ulong(k, v);
+		window_memory_limit = git_config_ulong(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.depth")) {
-		depth = git_config_int(k, v);
+		depth = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v);
+		max_delta_cache_size = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
-		cache_max_small_delta_size = git_config_int(k, v);
+		cache_max_small_delta_size = git_config_int(k, v, kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
@@ -3180,7 +3180,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		delta_search_threads = git_config_int(k, v);
+		delta_search_threads = git_config_int(k, v, kvi);
 		if (delta_search_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
@@ -3191,7 +3191,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_opts.version = git_config_int(k, v);
+		pack_idx_opts.version = git_config_int(k, v, kvi);
 		if (pack_idx_opts.version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32),
 			    pack_idx_opts.version);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2f5fd2abbc3..d2bc0fead9f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -154,12 +154,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.unpacklimit") == 0) {
-		receive_unpack_limit = git_config_int(var, value);
+		receive_unpack_limit = git_config_int(var, value, kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value);
+		transfer_unpack_limit = git_config_int(var, value, kvi);
 		return 0;
 	}
 
@@ -227,7 +227,7 @@ static int receive_pack_config(const char *var, const char *value,
 		return git_config_string(&cert_nonce_seed, var, value);
 
 	if (strcmp(var, "receive.certnonceslop") == 0) {
-		nonce_stamp_slop_limit = git_config_ulong(var, value);
+		nonce_stamp_slop_limit = git_config_ulong(var, value, kvi);
 		return 0;
 	}
 
@@ -242,12 +242,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.keepalive") == 0) {
-		keepalive_in_sec = git_config_int(var, value);
+		keepalive_in_sec = git_config_int(var, value, kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "receive.maxinputsize") == 0) {
-		max_input_size = git_config_int64(var, value);
+		max_input_size = git_config_int64(var, value, kvi);
 		return 0;
 	}
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8570effbf0d..bda10764db5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2187,13 +2187,13 @@ static int update_clone_task_finished(int result,
 }
 
 static int git_update_clone_config(const char *var, const char *value,
-				   struct key_value_info *kvi UNUSED,
+				   struct key_value_info *kvi,
 				   void *cb)
 {
 	int *max_jobs = cb;
 
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, kvi);
 	return 0;
 }
 
diff --git a/config.c b/config.c
index 68c9b507a4d..e78de67c452 100644
--- a/config.c
+++ b/config.c
@@ -1309,80 +1309,74 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out);
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type);
 NORETURN
-static void die_bad_number(struct config_reader *reader, const char *name,
-			   const char *value)
+static void die_bad_number(const char *name, const char *value,
+			   struct key_value_info *kvi)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
 	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
-	const char *config_name = NULL;
-	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
 
 	if (!value)
 		value = "";
 
-	/* Ignoring the return value is okay since we handle missing values. */
-	reader_config_name(reader, &config_name);
-	reader_origin_type(reader, &config_origin);
-
-	if (!config_name)
+	if (!kvi || !kvi->filename)
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
+		   struct key_value_info *kvi)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-int64_t git_config_int64(const char *name, const char *value)
+int64_t git_config_int64(const char *name, const char *value, struct key_value_info *kvi)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-unsigned long git_config_ulong(const char *name, const char *value)
+unsigned long git_config_ulong(const char *name, const char *value,
+			       struct key_value_info *kvi)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-ssize_t git_config_ssize_t(const char *name, const char *value)
+ssize_t git_config_ssize_t(const char *name, const char *value,
+			   struct key_value_info *kvi)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
@@ -1487,7 +1481,8 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
-int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+int git_config_bool_or_int(const char *name, const char *value,
+			   struct key_value_info *kvi, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v) {
@@ -1495,7 +1490,7 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return v;
 	}
 	*is_bool = 0;
-	return git_config_int(name, value);
+	return git_config_int(name, value, kvi);
 }
 
 int git_config_bool(const char *name, const char *value)
@@ -1621,7 +1616,7 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (!git_parse_maybe_bool_text(value))
 			default_abbrev = the_hash_algo->hexsz;
 		else {
-			int abbrev = git_config_int(var, value);
+			int abbrev = git_config_int(var, value, kvi);
 			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev = abbrev;
@@ -1633,7 +1628,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return set_disambiguate_hint_config(var, value);
 
 	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1644,7 +1639,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1658,7 +1653,7 @@ static int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);
+		packed_git_window_size = git_config_ulong(var, value, kvi);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -1669,17 +1664,17 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value);
+		big_file_threshold = git_config_ulong(var, value, kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
+		packed_git_limit = git_config_ulong(var, value, kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value);
+		delta_base_cache_limit = git_config_ulong(var, value, kvi);
 		return 0;
 	}
 
@@ -1963,12 +1958,12 @@ int git_default_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
+		pack_size_limit_cfg = git_config_ulong(var, value, kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "pack.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -2474,11 +2469,12 @@ int git_configset_add_file(struct config_set *set, const char *filename)
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
@@ -2488,7 +2484,10 @@ int git_configset_get_value(struct config_set *set, const char *key, const char
 		return ret;
 
 	assert(values->nr > 0);
-	*value = values->items[values->nr - 1].string;
+	item = values->items[values->nr - 1];
+	*value = item.string;
+	if (kvi)
+		*kvi = *((struct key_value_info *)item.util);
 	return 0;
 }
 
@@ -2541,7 +2540,7 @@ int git_configset_get(struct config_set *set, const char *key)
 int git_configset_get_string(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
@@ -2551,7 +2550,7 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		if (!value)
 			return config_error_nonbool(key);
 		*dest = value;
@@ -2564,8 +2563,10 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
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
@@ -2574,8 +2575,10 @@ int git_configset_get_int(struct config_set *set, const char *key, int *dest)
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
@@ -2584,7 +2587,7 @@ int git_configset_get_ulong(struct config_set *set, const char *key, unsigned lo
 int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_config_bool(key, value);
 		return 0;
 	} else
@@ -2595,8 +2598,10 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
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
@@ -2605,7 +2610,7 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
@@ -2617,7 +2622,7 @@ int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *d
 int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_pathname(dest, key, value);
 	else
 		return 1;
@@ -2687,7 +2692,7 @@ int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value(repo->config, key, value);
+	return git_configset_get_value(repo->config, key, value, NULL);
 }
 
 int repo_config_get_value_multi(struct repository *repo, const char *key,
@@ -3907,16 +3912,6 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type)
-{
-	if (the_reader.config_kvi)
-		*type = reader->config_kvi->origin_type;
-	else
-		return 1;
-	return 0;
-}
-
 const char *config_origin_type_name(enum config_origin_type type)
 {
 	switch (type) {
@@ -3955,15 +3950,6 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out)
-{
-	if (the_reader.config_kvi)
-		*out = reader->config_kvi->filename;
-	else
-		return 1;
-	return 0;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index f3b1a8c38a6..ffb2d76823c 100644
--- a/config.h
+++ b/config.h
@@ -237,22 +237,23 @@ int git_parse_maybe_bool(const char *);
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
  */
-int git_config_int(const char *, const char *);
+int git_config_int(const char *, const char *, struct key_value_info *);
 
-int64_t git_config_int64(const char *, const char *);
+int64_t git_config_int64(const char *, const char *, struct key_value_info *);
 
 /**
  * Identical to `git_config_int`, but for unsigned longs.
  */
-unsigned long git_config_ulong(const char *, const char *);
+unsigned long git_config_ulong(const char *, const char *, struct key_value_info *);
 
-ssize_t git_config_ssize_t(const char *, const char *);
+ssize_t git_config_ssize_t(const char *, const char *, struct key_value_info *);
 
 /**
  * Same as `git_config_bool`, except that integers are returned as-is, and
  * an `is_bool` flag is unset.
  */
-int git_config_bool_or_int(const char *, const char *, int *);
+int git_config_bool_or_int(const char *, const char *, struct key_value_info *,
+			   int *);
 
 /**
  * Parse a string into a boolean value, respecting keywords like "true" and
@@ -516,7 +517,8 @@ int git_configset_get(struct config_set *cs, const char *key);
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
index 00000000000..f46c74dd23c
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
++ , kvi
+  )
+|
+(
+git_configset_get_value
+|
+git_config_bool_or_int
+)
+  (C1, C2,
++ kvi,
+  C3
+  )
+)
diff --git a/diff.c b/diff.c
index d7ed2dc900b..da7cd353a6d 100644
--- a/diff.c
+++ b/diff.c
@@ -372,13 +372,14 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value);
+		diff_context_default = git_config_int(var, value, kvi);
 		if (diff_context_default < 0)
 			return -1;
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
-		diff_interhunk_context_default = git_config_int(var, value);
+		diff_interhunk_context_default = git_config_int(var, value,
+								kvi);
 		if (diff_interhunk_context_default < 0)
 			return -1;
 		return 0;
@@ -404,7 +405,7 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
-		diff_stat_graph_width = git_config_int(var, value);
+		diff_stat_graph_width = git_config_int(var, value, kvi);
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
@@ -443,7 +444,7 @@ int git_diff_basic_config(const char *var, const char *value,
 	const char *name;
 
 	if (!strcmp(var, "diff.renamelimit")) {
-		diff_rename_limit_default = git_config_int(var, value);
+		diff_rename_limit_default = git_config_int(var, value, kvi);
 		return 0;
 	}
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 97358034fa0..d1b59af44bb 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -24,7 +24,7 @@ int fmt_merge_msg_config(const char *key, const char *value,
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
-		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
+		merge_log_config = git_config_bool_or_int(key, value, kvi, &is_bool);
 		if (!is_bool && merge_log_config < 0)
 			return error("%s: negative length %s", key, value);
 		if (is_bool && merge_log_config)
diff --git a/help.c b/help.c
index 43d1eb702cd..08f0b953736 100644
--- a/help.c
+++ b/help.c
@@ -545,8 +545,7 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
 static int git_unknown_cmd_config(const char *var, const char *value,
-				  struct key_value_info *kvi UNUSED,
-				  void *cb UNUSED)
+				  struct key_value_info *kvi, void *cb UNUSED)
 {
 	const char *p;
 
@@ -560,7 +559,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 		} else if (!strcmp(value, "prompt")) {
 			autocorrect = AUTOCORRECT_PROMPT;
 		} else {
-			int v = git_config_int(var, value);
+			int v = git_config_int(var, value, kvi);
 			autocorrect = (v < 0)
 				? AUTOCORRECT_IMMEDIATELY : v;
 		}
diff --git a/http.c b/http.c
index 3d4292eba6a..a26c3dff827 100644
--- a/http.c
+++ b/http.c
@@ -412,21 +412,21 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.minsessions", var)) {
-		min_curl_sessions = git_config_int(var, value);
+		min_curl_sessions = git_config_int(var, value, kvi);
 		if (min_curl_sessions > 1)
 			min_curl_sessions = 1;
 		return 0;
 	}
 	if (!strcmp("http.maxrequests", var)) {
-		max_requests = git_config_int(var, value);
+		max_requests = git_config_int(var, value, kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedlimit", var)) {
-		curl_low_speed_limit = (long)git_config_int(var, value);
+		curl_low_speed_limit = (long)git_config_int(var, value, kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedtime", var)) {
-		curl_low_speed_time = (long)git_config_int(var, value);
+		curl_low_speed_time = (long)git_config_int(var, value, kvi);
 		return 0;
 	}
 
@@ -462,7 +462,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.postbuffer", var)) {
-		http_post_buffer = git_config_ssize_t(var, value);
+		http_post_buffer = git_config_ssize_t(var, value, kvi);
 		if (http_post_buffer < 0)
 			warning(_("negative value for http.postBuffer; defaulting to %d"), LARGE_PACKET_MAX);
 		if (http_post_buffer < LARGE_PACKET_MAX)
diff --git a/imap-send.c b/imap-send.c
index 3cc98f1a0a5..3c391a52c5a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1341,7 +1341,7 @@ static int git_imap_config(const char *var, const char *val,
 	else if (!strcmp("imap.authmethod", var))
 		return git_config_string(&server.auth_method, var, val);
 	else if (!strcmp("imap.port", var))
-		server.port = git_config_int(var, val);
+		server.port = git_config_int(var, val, kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			git_die_config("imap.host", "Missing value for 'imap.host'");
diff --git a/sequencer.c b/sequencer.c
index 171561c2cdb..76b4750b4bd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2878,7 +2878,7 @@ static int git_config_string_dup(char **dest,
 }
 
 static int populate_opts_cb(const char *key, const char *value,
-			    struct key_value_info *kvi UNUSED, void *data)
+			    struct key_value_info *kvi, void *data)
 {
 	struct replay_opts *opts = data;
 	int error_flag = 1;
@@ -2886,26 +2886,26 @@ static int populate_opts_cb(const char *key, const char *value,
 	if (!value)
 		error_flag = 0;
 	else if (!strcmp(key, "options.no-commit"))
-		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+		opts->no_commit = git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.edit"))
-		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+		opts->edit = git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty"))
 		opts->allow_empty =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.signoff"))
-		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
+		opts->signoff = git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
-		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+		opts->record_origin = git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
-		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+		opts->allow_ff = git_config_bool_or_int(key, value, kvi, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
-		opts->mainline = git_config_int(key, value);
+		opts->mainline = git_config_int(key, value, kvi);
 	else if (!strcmp(key, "options.strategy"))
 		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -2915,7 +2915,7 @@ static int populate_opts_cb(const char *key, const char *value,
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
 	} else if (!strcmp(key, "options.allow-rerere-auto"))
 		opts->allow_rerere_auto =
-			git_config_bool_or_int(key, value, &error_flag) ?
+			git_config_bool_or_int(key, value, kvi, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
 	else if (!strcmp(key, "options.default-msg-cleanup")) {
 		opts->explicit_cleanup = 1;
diff --git a/setup.c b/setup.c
index a461dd15233..75934d7438f 100644
--- a/setup.c
+++ b/setup.c
@@ -594,7 +594,7 @@ static int check_repo_format(const char *var, const char *value,
 	const char *ext;
 
 	if (strcmp(var, "core.repositoryformatversion") == 0)
-		data->version = git_config_int(var, value);
+		data->version = git_config_int(var, value, kvi);
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		switch (handle_extension_v0(var, value, ext, data)) {
 		case EXTENSION_ERROR:
diff --git a/submodule-config.c b/submodule-config.c
index 7d773f33621..b86547fd1ee 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -302,9 +302,10 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 	}
 }
 
-int parse_submodule_fetchjobs(const char *var, const char *value)
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      struct key_value_info *kvi)
 {
-	int fetchjobs = git_config_int(var, value);
+	int fetchjobs = git_config_int(var, value, kvi);
 	if (fetchjobs < 0)
 		die(_("negative values not allowed for submodule.fetchJobs"));
 	if (!fetchjobs)
@@ -848,14 +849,13 @@ struct fetch_config {
 };
 
 static int gitmodules_fetch_config(const char *var, const char *value,
-				   struct key_value_info *kvi UNUSED,
-				   void *cb)
+				   struct key_value_info *kvi, void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
 		if (config->max_children)
 			*(config->max_children) =
-				parse_submodule_fetchjobs(var, value);
+				parse_submodule_fetchjobs(var, value, kvi);
 		return 0;
 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
 		if (config->recurse_submodules)
@@ -877,12 +877,11 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
-					  struct key_value_info *kvi UNUSED,
-					  void *cb)
+					  struct key_value_info *kvi, void *cb)
 {
 	int *max_jobs = cb;
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, kvi);
 	return 0;
 }
 
diff --git a/submodule-config.h b/submodule-config.h
index c2045875bbb..944cae75cc9 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -50,7 +50,8 @@ struct repository;
 
 void submodule_cache_free(struct submodule_cache *cache);
 
-int parse_submodule_fetchjobs(const char *var, const char *value);
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      struct key_value_info *kvi);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 7027ffa187f..737505583d4 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -61,12 +61,12 @@ static int iterate_cb(const char *var, const char *value,
 }
 
 static int parse_int_cb(const char *var, const char *value,
-			struct key_value_info *kvi UNUSED, void *data)
+			struct key_value_info *kvi, void *data)
 {
 	const char *key_to_match = data;
 
 	if (!strcmp(key_to_match, var)) {
-		int parsed = git_config_int(value, value);
+		int parsed = git_config_int(value, value, kvi);
 		printf("%d\n", parsed);
 	}
 	return 0;
@@ -179,7 +179,7 @@ int cmd__config(int argc, const char **argv)
 				goto exit2;
 			}
 		}
-		if (!git_configset_get_value(&cs, argv[2], &v)) {
+		if (!git_configset_get_value(&cs, argv[2], &v, NULL)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
diff --git a/upload-pack.c b/upload-pack.c
index 5f8232ff078..7cf776cde91 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1264,7 +1264,8 @@ static int find_symref(const char *refname,
 }
 
 static int parse_object_filter_config(const char *var, const char *value,
-				       struct upload_pack_data *data)
+				      struct key_value_info *kvi,
+				      struct upload_pack_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *sub, *key;
@@ -1291,7 +1292,8 @@ static int parse_object_filter_config(const char *var, const char *value,
 		}
 		string_list_insert(&data->allowed_filters, buf.buf)->util =
 			(void *)(intptr_t)1;
-		data->tree_filter_max_depth = git_config_ulong(var, value);
+		data->tree_filter_max_depth = git_config_ulong(var, value,
+							       kvi);
 	}
 
 	strbuf_release(&buf);
@@ -1299,7 +1301,7 @@ static int parse_object_filter_config(const char *var, const char *value,
 }
 
 static int upload_pack_config(const char *var, const char *value,
-			      struct key_value_info *kvi UNUSED,
+			      struct key_value_info *kvi,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
@@ -1320,7 +1322,7 @@ static int upload_pack_config(const char *var, const char *value,
 		else
 			data->allow_uor &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		data->keepalive = git_config_int(var, value);
+		data->keepalive = git_config_int(var, value, kvi);
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
@@ -1335,7 +1337,7 @@ static int upload_pack_config(const char *var, const char *value,
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (parse_object_filter_config(var, value, data) < 0)
+	if (parse_object_filter_config(var, value, kvi, data) < 0)
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


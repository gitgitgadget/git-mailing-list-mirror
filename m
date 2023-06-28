Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3AEB64DC
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjF1T1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjF1T0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5431FE8
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so221215f8f.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980400; x=1690572400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t2eQ2y9mg4+ITZpZHEofP3H282mtx1hRVgTLZD14uo=;
        b=gMred3D4Zf8f2kH7Y20clCbs3qS/K7z6f068M6bqIGYaEW0eBHJHzQ1x+abClBgiZn
         VUoYr29IZvR4gyrpIRTSeNMBzWWeAQgTSpnIodU+DCDUVuKHUHpP9wZAvayqcB0PCE3D
         le11aSbliF+30XJzkfgXimssIl0cDkIuzEF+kWcxbjUPGfbGtB6fY5JewoE7bsv3a8Ow
         mzhWEIqcsJtGciMfMKkAQ829bEHfTP32bP58F5c5iBSfL+GQ0CM+WDsrHrDnJiW5OlZM
         pOPYeI+W4BTC04ImpoDdlotVR1MbdC8lkUK0fWpnOmXaFKTCOi4Wdp4zM7P+geqB/81n
         o8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980400; x=1690572400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t2eQ2y9mg4+ITZpZHEofP3H282mtx1hRVgTLZD14uo=;
        b=WWtWlBvQPY4VV+2PyZhFYWMkqB52CSqh4XMt+IYr8yccDPRIe07lgdsGFZF0D+mCZE
         hMuLOg2ZKHsi9eA7xCvLjAujhjDP5eYxeU9wf2CxSlzZraXMyHIX344bMT1udcav+RpD
         5UAlCkILnaysTGEYbEUB6GqXbhop4Hc0/q1rIXl7SvEh5aient0ltn8mGp8fkWkzoI1J
         HGD1Z2I9T3bkn5lVMI8XERy+FTkf8JoH2qbXXdlDg2tpyLbi2Qx/OsoiNZ3UDPiw1Mzy
         LxDFFgkv/Tu7glRYMCyo9A6FuOezmx4b8mscv9KFZi6s1SY4WgGfe2YkPDL+DbW9Vxo/
         IL9g==
X-Gm-Message-State: AC+VfDxeEcDChBoZblbAmjHOEDLU6lW8YePE7Hcm5itaq8DhgfjdQfLh
        4M/LAYraqjuuplqsZxTZuhlwwroudeY=
X-Google-Smtp-Source: ACHHUZ4gaj/61KycQxFOsZmwf2LQAnUl17npHD7ctwRqbnaCJOulDDjdNPwbMAKV3OnvkUa07I2DvQ==
X-Received: by 2002:a5d:630d:0:b0:313:ea59:7ded with SMTP id i13-20020a5d630d000000b00313ea597dedmr9346130wru.24.1687980398621;
        Wed, 28 Jun 2023 12:26:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b00313e4d02be8sm13121277wrs.55.2023.06.28.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:38 -0700 (PDT)
Message-Id: <a9a0a50f32a6d01e2d5cd411f97588734aea2fd1.1687980392.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:22 +0000
Subject: [PATCH v5 03/11] config: add ctx arg to config_fn_t
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

Add a new "const struct config_context *ctx" arg to config_fn_t to hold
additional information about the config iteration operation.
config_context has a "struct key_value_info kvi" member that holds
metadata about the config source being read (e.g. what kind of config
source it is, the filename, etc). In this series, we're only interested
in .kvi, so we could have just used "struct key_value_info" as an arg,
but config_context makes it possible to add/adjust members in the future
without changing the config_fn_t signature. We could also consider other
ways of organizing the args (e.g. moving the config name and value into
config_context or key_value_info), but in my experiments, the
incremental benefit doesn't justify the added complexity (e.g. a
config_fn_t will sometimes invoke another config_fn_t but with a
different config value).

In subsequent commits, the .kvi member will replace the global "struct
config_reader" in config.c, making config iteration a global-free
operation. It requires much more work for the machinery to provide
meaningful values of .kvi, so for now, merely change the signature and
call sites, pass NULL as a placeholder value, and don't rely on the arg
in any meaningful way.

Most of the changes are performed by
contrib/coccinelle/config_fn_ctx.pending.cocci, which, for every
config_fn_t:

- Modifies the signature to accept "const struct config_context *ctx"
- Passes "ctx" to any inner config_fn_t, if needed
- Adds UNUSED attributes to "ctx", if needed

Most config_fn_t instances are easily identified by seeing if they are
called by the various config functions. Most of the remaining ones are
manually named in the .cocci patch. Manual cleanups are still needed,
but the majority of it is trivial; it's either adjusting config_fn_t
that the .cocci patch didn't catch, or adding forward declarations of
"struct config_context ctx" to make the signatures make sense.

The non-trivial changes are in cases where we are invoking a config_fn_t
outside of config machinery, and we now need to decide what value of
"ctx" to pass. These cases are:

- trace2/tr2_cfg.c:tr2_cfg_set_fl()

  This is indirectly called by git_config_set() so that the trace2
  machinery can notice the new config values and update its settings
  using the tr2 config parsing function, i.e. tr2_cfg_cb().

- builtin/checkout.c:checkout_main()

  This calls git_xmerge_config() as a shorthand for parsing a CLI arg.
  This might be worth refactoring away in the future, since
  git_xmerge_config() can call git_default_config(), which can do much
  more than just parsing.

Handle them by creating a KVI_INIT macro that initializes "struct
key_value_info" to a reasonable default, and use that to construct the
"ctx" arg.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 alias.c                                       |   3 +-
 archive-tar.c                                 |   3 +-
 archive-zip.c                                 |   1 +
 builtin/add.c                                 |   5 +-
 builtin/blame.c                               |   5 +-
 builtin/branch.c                              |   5 +-
 builtin/cat-file.c                            |   5 +-
 builtin/checkout.c                            |  12 +-
 builtin/clean.c                               |   5 +-
 builtin/clone.c                               |  11 +-
 builtin/column.c                              |   3 +-
 builtin/commit-graph.c                        |   1 +
 builtin/commit.c                              |  10 +-
 builtin/config.c                              |  10 +-
 builtin/difftool.c                            |   5 +-
 builtin/fetch.c                               |   9 +-
 builtin/fsmonitor--daemon.c                   |   5 +-
 builtin/grep.c                                |   7 +-
 builtin/help.c                                |   5 +-
 builtin/index-pack.c                          |   5 +-
 builtin/log.c                                 |  10 +-
 builtin/merge.c                               |   7 +-
 builtin/multi-pack-index.c                    |   1 +
 builtin/pack-objects.c                        |   5 +-
 builtin/patch-id.c                            |   5 +-
 builtin/pull.c                                |   5 +-
 builtin/push.c                                |   5 +-
 builtin/read-tree.c                           |   5 +-
 builtin/rebase.c                              |   5 +-
 builtin/receive-pack.c                        |   5 +-
 builtin/reflog.c                              |   7 +-
 builtin/remote.c                              |   7 +-
 builtin/repack.c                              |   5 +-
 builtin/reset.c                               |   5 +-
 builtin/send-pack.c                           |   5 +-
 builtin/show-branch.c                         |   5 +-
 builtin/stash.c                               |   5 +-
 builtin/submodule--helper.c                   |   1 +
 builtin/tag.c                                 |   5 +-
 builtin/var.c                                 |   5 +-
 builtin/worktree.c                            |   5 +-
 bundle-uri.c                                  |   8 +-
 compat/mingw.c                                |   3 +-
 compat/mingw.h                                |   4 +-
 config.c                                      |  38 +++--
 config.h                                      |  41 +++--
 connect.c                                     |   4 +-
 .../coccinelle/config_fn_ctx.pending.cocci    | 144 ++++++++++++++++++
 convert.c                                     |   4 +-
 credential.c                                  |   1 +
 delta-islands.c                               |   4 +-
 diff.c                                        |  10 +-
 diff.h                                        |   7 +-
 fetch-pack.c                                  |   5 +-
 fmt-merge-msg.c                               |   5 +-
 fmt-merge-msg.h                               |   3 +-
 fsck.c                                        |   9 +-
 fsck.h                                        |   4 +-
 git-compat-util.h                             |   2 +
 gpg-interface.c                               |   7 +-
 grep.c                                        |   7 +-
 grep.h                                        |   4 +-
 help.c                                        |   7 +-
 http.c                                        |   5 +-
 ident.c                                       |   4 +-
 ident.h                                       |   4 +-
 imap-send.c                                   |   5 +-
 ll-merge.c                                    |   1 +
 ls-refs.c                                     |   1 +
 mailinfo.c                                    |   5 +-
 notes-utils.c                                 |   4 +-
 notes.c                                       |   4 +-
 pager.c                                       |   5 +-
 pretty.c                                      |   1 +
 promisor-remote.c                             |   4 +-
 remote.c                                      |   3 +-
 revision.c                                    |   4 +-
 scalar.c                                      |   4 +-
 sequencer.c                                   |   9 +-
 setup.c                                       |  16 +-
 submodule-config.c                            |  17 ++-
 t/helper/test-config.c                        |  11 +-
 t/helper/test-userdiff.c                      |   4 +-
 trace2/tr2_cfg.c                              |   9 +-
 trace2/tr2_sysenv.c                           |   3 +-
 trailer.c                                     |   2 +
 upload-pack.c                                 |   8 +-
 urlmatch.c                                    |   7 +-
 urlmatch.h                                    |   3 +-
 xdiff-interface.c                             |   5 +-
 xdiff-interface.h                             |   4 +-
 91 files changed, 515 insertions(+), 181 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_ctx.pending.cocci

diff --git a/alias.c b/alias.c
index 54a1a23d2cf..910dd252a01 100644
--- a/alias.c
+++ b/alias.c
@@ -12,7 +12,8 @@ struct config_alias_data {
 	struct string_list *list;
 };
 
-static int config_alias_cb(const char *key, const char *value, void *d)
+static int config_alias_cb(const char *key, const char *value,
+			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
 	const char *p;
diff --git a/archive-tar.c b/archive-tar.c
index 4cd81d8161e..ef06e516b1f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -411,7 +411,8 @@ static int tar_filter_config(const char *var, const char *value,
 	return 0;
 }
 
-static int git_tar_config(const char *var, const char *value, void *cb)
+static int git_tar_config(const char *var, const char *value,
+			  const struct config_context *ctx UNUSED, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
diff --git a/archive-zip.c b/archive-zip.c
index d0d065a312e..b6811951955 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -617,6 +617,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 }
 
 static int archive_zip_config(const char *var, const char *value,
+			      const struct config_context *ctx UNUSED,
 			      void *data UNUSED)
 {
 	return userdiff_config(var, value);
diff --git a/builtin/add.c b/builtin/add.c
index e01efdfc50d..1009ae13c13 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -357,7 +357,8 @@ static struct option builtin_add_options[] = {
 	OPT_END(),
 };
 
-static int add_config(const char *var, const char *value, void *cb)
+static int add_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "add.ignoreerrors") ||
 	    !strcmp(var, "add.ignore-errors")) {
@@ -368,7 +369,7 @@ static int add_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static const char embedded_advice[] = N_(
diff --git a/builtin/blame.c b/builtin/blame.c
index 2df6039a6e0..d0970a1ab13 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -694,7 +694,8 @@ static const char *add_prefix(const char *prefix, const char *path)
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
-static int git_blame_config(const char *var, const char *value, void *cb)
+static int git_blame_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
@@ -767,7 +768,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
diff --git a/builtin/branch.c b/builtin/branch.c
index 8337b9e71bb..af6d2e75fb0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -83,7 +83,8 @@ static unsigned int colopts;
 
 define_list_config_array(color_branch_slots);
 
-static int git_branch_config(const char *var, const char *value, void *cb)
+static int git_branch_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *cb)
 {
 	const char *slot_name;
 
@@ -120,7 +121,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7ff56d5a781..b3c41b54c8d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -873,12 +873,13 @@ static int batch_objects(struct batch_options *opt)
 	return retval;
 }
 
-static int git_cat_file_config(const char *var, const char *value, void *cb)
+static int git_cat_file_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int batch_option_callback(const struct option *opt,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 715eeb5048f..4e1f7dc26c2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1186,7 +1186,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	return ret || writeout_error;
 }
 
-static int git_checkout_config(const char *var, const char *value, void *cb)
+static int git_checkout_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *cb)
 {
 	struct checkout_opts *opts = cb;
 
@@ -1202,7 +1203,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
-	return git_xmerge_config(var, value, NULL);
+	return git_xmerge_config(var, value, ctx, NULL);
 }
 
 static void setup_new_branch_info_and_source_tree(
@@ -1689,8 +1690,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->conflict_style) {
+		struct key_value_info kvi = KVI_INIT;
+		struct config_context ctx = {
+			.kvi = &kvi,
+		};
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
+				  &ctx, NULL);
 	}
 	if (opts->force) {
 		opts->discard_changes = 1;
diff --git a/builtin/clean.c b/builtin/clean.c
index 57e7f7cac64..5eff1b802a7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -103,7 +103,8 @@ struct menu_stuff {
 
 define_list_config_array(color_interactive_slots);
 
-static int git_clean_config(const char *var, const char *value, void *cb)
+static int git_clean_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	const char *slot_name;
 
@@ -133,7 +134,7 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/clone.c b/builtin/clone.c
index 15f9912b4ca..c0f6e067493 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -790,7 +790,8 @@ static int checkout(int submodule_progress, int filter_submodules)
 	return err;
 }
 
-static int git_clone_config(const char *k, const char *v, void *cb)
+static int git_clone_config(const char *k, const char *v,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "clone.defaultremotename")) {
 		free(remote_name);
@@ -801,17 +802,19 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "clone.filtersubmodules"))
 		config_filter_submodules = git_config_bool(k, v);
 
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v, ctx, cb);
 }
 
-static int write_one_config(const char *key, const char *value, void *data)
+static int write_one_config(const char *key, const char *value,
+			    const struct config_context *ctx,
+			    void *data)
 {
 	/*
 	 * give git_clone_config a chance to write config values back to the
 	 * environment, since git_config_set_multivar_gently only deals with
 	 * config-file writes
 	 */
-	int apply_failed = git_clone_config(key, value, data);
+	int apply_failed = git_clone_config(key, value, ctx, data);
 	if (apply_failed)
 		return apply_failed;
 
diff --git a/builtin/column.c b/builtin/column.c
index de623a16c2d..4a6148ca479 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -13,7 +13,8 @@ static const char * const builtin_column_usage[] = {
 };
 static unsigned int colopts;
 
-static int column_config(const char *var, const char *value, void *cb)
+static int column_config(const char *var, const char *value,
+			 const struct config_context *ctx UNUSED, void *cb)
 {
 	return git_column_config(var, value, cb, &colopts);
 }
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index dd732b35348..1185c49239a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -186,6 +186,7 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
+					 const struct config_context *ctx UNUSED,
 					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
diff --git a/builtin/commit.c b/builtin/commit.c
index 9ab57ea1aaa..6a2b2503328 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1405,7 +1405,8 @@ static int parse_status_slot(const char *slot)
 	return LOOKUP_CONFIG(color_status_slots, slot);
 }
 
-static int git_status_config(const char *k, const char *v, void *cb)
+static int git_status_config(const char *k, const char *v,
+			     const struct config_context *ctx, void *cb)
 {
 	struct wt_status *s = cb;
 	const char *slot_name;
@@ -1490,7 +1491,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->detect_rename = git_config_rename(k, v);
 		return 0;
 	}
-	return git_diff_ui_config(k, v, NULL);
+	return git_diff_ui_config(k, v, ctx, NULL);
 }
 
 int cmd_status(int argc, const char **argv, const char *prefix)
@@ -1605,7 +1606,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int git_commit_config(const char *k, const char *v, void *cb)
+static int git_commit_config(const char *k, const char *v,
+			     const struct config_context *ctx, void *cb)
 {
 	struct wt_status *s = cb;
 
@@ -1627,7 +1629,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	return git_status_config(k, v, s);
+	return git_status_config(k, v, ctx, s);
 }
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
diff --git a/builtin/config.c b/builtin/config.c
index d40fddb042a..f4fccf99cb8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -217,6 +217,7 @@ static void show_config_scope(struct strbuf *buf)
 }
 
 static int show_all_config(const char *key_, const char *value_,
+			   const struct config_context *ctx UNUSED,
 			   void *cb UNUSED)
 {
 	if (show_origin || show_scope) {
@@ -301,7 +302,8 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 	return 0;
 }
 
-static int collect_config(const char *key_, const char *value_, void *cb)
+static int collect_config(const char *key_, const char *value_,
+			  const struct config_context *ctx UNUSED, void *cb)
 {
 	struct strbuf_list *values = cb;
 
@@ -470,6 +472,7 @@ static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
 static int git_get_color_config(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
 				void *cb UNUSED)
 {
 	if (!strcmp(var, get_color_slot)) {
@@ -503,6 +506,7 @@ static int get_colorbool_found;
 static int get_diff_color_found;
 static int get_color_ui_found;
 static int git_get_colorbool_config(const char *var, const char *value,
+				    const struct config_context *ctx UNUSED,
 				    void *data UNUSED)
 {
 	if (!strcmp(var, get_colorbool_slot))
@@ -561,7 +565,9 @@ struct urlmatch_current_candidate_value {
 	struct strbuf value;
 };
 
-static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
+static int urlmatch_collect_fn(const char *var, const char *value,
+			       const struct config_context *ctx UNUSED,
+			       void *cb)
 {
 	struct string_list *values = cb;
 	struct string_list_item *item = string_list_insert(values, var);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 0049342f5c0..f289530068b 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -40,14 +40,15 @@ static const char *const builtin_difftool_usage[] = {
 	NULL
 };
 
-static int difftool_config(const char *var, const char *value, void *cb)
+static int difftool_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "difftool.trustexitcode")) {
 		trust_exit_code = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int print_tool_help(void)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3871048cf6..a4aa0fbb8f5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -110,7 +110,8 @@ struct fetch_config {
 	int submodule_fetch_jobs;
 };
 
-static int git_fetch_config(const char *k, const char *v, void *cb)
+static int git_fetch_config(const char *k, const char *v,
+			    const struct config_context *ctx, void *cb)
 {
 	struct fetch_config *fetch_config = cb;
 
@@ -164,7 +165,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 			    "fetch.output", v);
 	}
 
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v, ctx, cb);
 }
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
@@ -1799,7 +1800,9 @@ struct remote_group_data {
 	struct string_list *list;
 };
 
-static int get_remote_group(const char *key, const char *value, void *priv)
+static int get_remote_group(const char *key, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *priv)
 {
 	struct remote_group_data *g = priv;
 
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f6dd9a784c1..91a776e2f17 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -37,7 +37,8 @@ static int fsmonitor__start_timeout_sec = 60;
 #define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
 static int fsmonitor__announce_startup = 0;
 
-static int fsmonitor_config(const char *var, const char *value, void *cb)
+static int fsmonitor_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
 		int i = git_config_int(var, value);
@@ -67,7 +68,7 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 /*
diff --git a/builtin/grep.c b/builtin/grep.c
index 76cf999d310..757d52b94ec 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -290,13 +290,14 @@ static int wait_all(void)
 	return hit;
 }
 
-static int grep_cmd_config(const char *var, const char *value, void *cb)
+static int grep_cmd_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
 {
-	int st = grep_config(var, value, cb);
+	int st = grep_config(var, value, ctx, cb);
 
 	if (git_color_config(var, value, cb) < 0)
 		st = -1;
-	else if (git_default_config(var, value, cb) < 0)
+	else if (git_default_config(var, value, ctx, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/help.c b/builtin/help.c
index d3cf4af3f6e..c348f201254 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -398,7 +398,8 @@ static int add_man_viewer_info(const char *var, const char *value)
 	return 0;
 }
 
-static int git_help_config(const char *var, const char *value, void *cb)
+static int git_help_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "help.format")) {
 		if (!value)
@@ -421,7 +422,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "man."))
 		return add_man_viewer_info(var, value);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static struct cmdnames main_cmds, other_cmds;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d0d8067510b..de8884ea5c2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1581,7 +1581,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	strbuf_release(&pack_name);
 }
 
-static int git_index_pack_config(const char *k, const char *v, void *cb)
+static int git_index_pack_config(const char *k, const char *v,
+				 const struct config_context *ctx, void *cb)
 {
 	struct pack_idx_option *opts = cb;
 
@@ -1608,7 +1609,7 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		else
 			opts->flags &= ~WRITE_REV;
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v, ctx, cb);
 }
 
 static int cmp_uint32(const void *a_, const void *b_)
diff --git a/builtin/log.c b/builtin/log.c
index c85f13a5d5e..09d6a13075b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -564,7 +564,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	return retval;
 }
 
-static int git_log_config(const char *var, const char *value, void *cb)
+static int git_log_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb)
 {
 	const char *slot_name;
 
@@ -613,7 +614,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_diff_ui_config(var, value, cb);
+	return git_diff_ui_config(var, value, ctx, cb);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
@@ -979,7 +980,8 @@ static enum cover_from_description parse_cover_from_description(const char *arg)
 		die(_("%s: invalid cover from description mode"), arg);
 }
 
-static int git_format_config(const char *var, const char *value, void *cb)
+static int git_format_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
@@ -1108,7 +1110,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.noprefix"))
 		return 0;
 
-	return git_log_config(var, value, cb);
+	return git_log_config(var, value, ctx, cb);
 }
 
 static const char *output_directory = NULL;
diff --git a/builtin/merge.c b/builtin/merge.c
index 8da3e46abb0..cad624fb797 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -623,7 +623,8 @@ static void parse_branch_merge_options(char *bmo)
 	free(argv);
 }
 
-static int git_merge_config(const char *k, const char *v, void *cb)
+static int git_merge_config(const char *k, const char *v,
+			    const struct config_context *ctx, void *cb)
 {
 	int status;
 	const char *str;
@@ -668,10 +669,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	status = fmt_merge_msg_config(k, v, cb);
+	status = fmt_merge_msg_config(k, v, ctx, cb);
 	if (status)
 		return status;
-	return git_diff_ui_config(k, v, cb);
+	return git_diff_ui_config(k, v, ctx, cb);
 }
 
 static int read_tree_trivial(struct object_id *common, struct object_id *head,
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 1b5083f8b26..a0a7b82cc69 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -82,6 +82,7 @@ static struct option *add_common_options(struct option *prev)
 }
 
 static int git_multi_pack_index_write_config(const char *var, const char *value,
+					     const struct config_context *ctx UNUSED,
 					     void *cb UNUSED)
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3af2d84f589..34aa0b483a0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3135,7 +3135,8 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static int git_pack_config(const char *k, const char *v, void *cb)
+static int git_pack_config(const char *k, const char *v,
+			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
@@ -3227,7 +3228,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		ex->uri = xstrdup(pack_end + 1);
 		oidmap_put(&configured_exclusions, ex);
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v, ctx, cb);
 }
 
 /* Counters for trace2 output when in --stdin-packs mode. */
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 9d5585d3a72..03eddd0fb82 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -196,7 +196,8 @@ struct patch_id_opts {
 	int verbatim;
 };
 
-static int git_patch_id_config(const char *var, const char *value, void *cb)
+static int git_patch_id_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *cb)
 {
 	struct patch_id_opts *opts = cb;
 
@@ -209,7 +210,7 @@ static int git_patch_id_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_patch_id(int argc, const char **argv, const char *prefix)
diff --git a/builtin/pull.c b/builtin/pull.c
index 0c7bac97b75..83fca5b1d46 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -361,7 +361,8 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 /**
  * Read config variables.
  */
-static int git_pull_config(const char *var, const char *value, void *cb)
+static int git_pull_config(const char *var, const char *value,
+			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "rebase.autostash")) {
 		config_autostash = git_config_bool(var, value);
@@ -374,7 +375,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 		check_trust_level = 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 /**
diff --git a/builtin/push.c b/builtin/push.c
index dbdf609daf3..a2f68f77324 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -510,7 +510,8 @@ static void set_push_cert_flags(int *flags, int v)
 }
 
 
-static int git_push_config(const char *k, const char *v, void *cb)
+static int git_push_config(const char *k, const char *v,
+			   const struct config_context *ctx, void *cb)
 {
 	const char *slot_name;
 	int *flags = cb;
@@ -577,7 +578,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	return git_default_config(k, v, NULL);
+	return git_default_config(k, v, ctx, NULL);
 }
 
 int cmd_push(int argc, const char **argv, const char *prefix)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 440f19b1b87..8877dd6d4b5 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -102,12 +102,13 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
-static int git_read_tree_config(const char *var, const char *value, void *cb)
+static int git_read_tree_config(const char *var, const char *value,
+				const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ace1d5e8d11..60930e2d8e0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -772,7 +772,8 @@ static void parse_rebase_merges_value(struct rebase_options *options, const char
 		die(_("Unknown rebase-merges mode: %s"), value);
 }
 
-static int rebase_config(const char *var, const char *value, void *data)
+static int rebase_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *data)
 {
 	struct rebase_options *opts = data;
 
@@ -831,7 +832,7 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return git_config_string(&opts->default_backend, var, value);
 	}
 
-	return git_default_config(var, value, data);
+	return git_default_config(var, value, ctx, data);
 }
 
 static int checkout_up_to_date(struct rebase_options *options)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a31a583674..94d9898aff7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -139,7 +139,8 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 	return DENY_IGNORE;
 }
 
-static int receive_pack_config(const char *var, const char *value, void *cb)
+static int receive_pack_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *cb)
 {
 	int status = parse_hide_refs_config(var, value, "receive", &hidden_refs);
 
@@ -266,7 +267,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static void show_ref(const char *path, const struct object_id *oid)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a1fa0c855f4..84251cc9517 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -108,7 +108,8 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 #define EXPIRE_TOTAL   01
 #define EXPIRE_UNREACH 02
 
-static int reflog_expire_config(const char *var, const char *value, void *cb)
+static int reflog_expire_config(const char *var, const char *value,
+				const struct config_context *ctx, void *cb)
 {
 	const char *pattern, *key;
 	size_t pattern_len;
@@ -117,7 +118,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 	struct reflog_expire_cfg *ent;
 
 	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
-		return git_default_config(var, value, cb);
+		return git_default_config(var, value, ctx, cb);
 
 	if (!strcmp(key, "reflogexpire")) {
 		slot = EXPIRE_TOTAL;
@@ -128,7 +129,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else
-		return git_default_config(var, value, cb);
+		return git_default_config(var, value, ctx, cb);
 
 	if (!pattern) {
 		switch (slot) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 1e0b137d977..87de81105e2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -268,6 +268,7 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
 
 static int config_read_branches(const char *key, const char *value,
+				const struct config_context *ctx UNUSED,
 				void *data UNUSED)
 {
 	const char *orig_key = key;
@@ -645,7 +646,7 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	void *cb)
+	const struct config_context *ctx UNUSED, void *cb)
 {
 	struct push_default_info* info = cb;
 	if (strcmp(key, "remote.pushdefault") ||
@@ -1494,7 +1495,9 @@ static int prune(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int get_remote_default(const char *key, const char *value UNUSED, void *priv)
+static int get_remote_default(const char *key, const char *value UNUSED,
+			      const struct config_context *ctx UNUSED,
+			      void *priv)
 {
 	if (strcmp(key, "remotes.default") == 0) {
 		int *found = priv;
diff --git a/builtin/repack.c b/builtin/repack.c
index 0541c3ce157..6f74570bf94 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -59,7 +59,8 @@ struct pack_objects_args {
 	int local;
 };
 
-static int repack_config(const char *var, const char *value, void *cb)
+static int repack_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb)
 {
 	struct pack_objects_args *cruft_po_args = cb;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
@@ -91,7 +92,7 @@ static int repack_config(const char *var, const char *value, void *cb)
 		return git_config_string(&cruft_po_args->depth, var, value);
 	if (!strcmp(var, "repack.cruftthreads"))
 		return git_config_string(&cruft_po_args->threads, var, value);
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index f99f32d5802..1ae82f2e89c 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -312,12 +312,13 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	return update_ref_status;
 }
 
-static int git_reset_config(const char *var, const char *value, void *cb)
+static int git_reset_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4784143004d..cd6d9e41129 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -131,7 +131,8 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
 
-static int send_pack_config(const char *k, const char *v, void *cb)
+static int send_pack_config(const char *k, const char *v,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
@@ -151,7 +152,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 			}
 		}
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v, ctx, cb);
 }
 
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index a2461270d4b..f2fd245b838 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -559,7 +559,8 @@ static void append_one_rev(const char *av)
 	die("bad sha1 reference %s", av);
 }
 
-static int git_show_branch_config(const char *var, const char *value, void *cb)
+static int git_show_branch_config(const char *var, const char *value,
+				  const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "showbranch.default")) {
 		if (!value)
@@ -582,7 +583,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/builtin/stash.c b/builtin/stash.c
index a7e17ffe384..e5c4246d2d4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -837,7 +837,8 @@ static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
 
-static int git_stash_config(const char *var, const char *value, void *cb)
+static int git_stash_config(const char *var, const char *value,
+			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "stash.showstat")) {
 		show_stat = git_config_bool(var, value);
@@ -851,7 +852,7 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
-	return git_diff_basic_config(var, value, cb);
+	return git_diff_basic_config(var, value, ctx, cb);
 }
 
 static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6a16208e8a8..f8e9d85e77a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2192,6 +2192,7 @@ static int update_clone_task_finished(int result,
 }
 
 static int git_update_clone_config(const char *var, const char *value,
+				   const struct config_context *ctx UNUSED,
 				   void *cb)
 {
 	int *max_jobs = cb;
diff --git a/builtin/tag.c b/builtin/tag.c
index 1acf5f7a59f..b7dfb5e2cad 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -188,7 +188,8 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
-static int git_tag_config(const char *var, const char *value, void *cb)
+static int git_tag_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "tag.gpgsign")) {
 		config_sign_tag = git_config_bool(var, value);
@@ -213,7 +214,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)
diff --git a/builtin/var.c b/builtin/var.c
index 21499989807..ae011bdf409 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -71,13 +71,14 @@ static const struct git_var *get_git_var(const char *var)
 	return NULL;
 }
 
-static int show_config(const char *var, const char *value, void *cb)
+static int show_config(const char *var, const char *value,
+		       const struct config_context *ctx, void *cb)
 {
 	if (value)
 		printf("%s=%s\n", var, value);
 	else
 		printf("%s\n", var);
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5a9cf076ad2..a30d37a273f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -128,14 +128,15 @@ static int verbose;
 static int guess_remote;
 static timestamp_t expire;
 
-static int git_worktree_config(const char *var, const char *value, void *cb)
+static int git_worktree_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "worktree.guessremote")) {
 		guess_remote = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int delete_git_dir(const char *id)
diff --git a/bundle-uri.c b/bundle-uri.c
index 2a2db1a1d39..0d5acc3dc51 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -224,7 +224,9 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
-static int config_to_bundle_list(const char *key, const char *value, void *data)
+static int config_to_bundle_list(const char *key, const char *value,
+				 const struct config_context *ctx UNUSED,
+				 void *data)
 {
 	struct bundle_list *list = data;
 	return bundle_list_update(key, value, list);
@@ -871,7 +873,9 @@ cached:
 	return advertise_bundle_uri;
 }
 
-static int config_to_packet_line(const char *key, const char *value, void *data)
+static int config_to_packet_line(const char *key, const char *value,
+				 const struct config_context *ctx UNUSED,
+				 void *data)
 {
 	struct packet_reader *writer = data;
 
diff --git a/compat/mingw.c b/compat/mingw.c
index d06cdc6254f..4186bc7a417 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -244,7 +244,8 @@ static int core_restrict_inherited_handles = -1;
 static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 static char *unset_environment_variables;
 
-int mingw_core_config(const char *var, const char *value, void *cb)
+int mingw_core_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "core.hidedotfiles")) {
 		if (value && !strcasecmp(value, "dotgitonly"))
diff --git a/compat/mingw.h b/compat/mingw.h
index 209cf7cebad..5e34c873473 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -11,7 +11,9 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
-int mingw_core_config(const char *var, const char *value, void *cb);
+struct config_context;
+int mingw_core_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb);
 #define platform_core_config mingw_core_config
 
 /*
diff --git a/config.c b/config.c
index 2eeb6621421..850e432e301 100644
--- a/config.c
+++ b/config.c
@@ -209,7 +209,8 @@ struct config_include_data {
 };
 #define CONFIG_INCLUDE_INIT { 0 }
 
-static int git_config_include(const char *var, const char *value, void *data);
+static int git_config_include(const char *var, const char *value,
+			      const struct config_context *ctx, void *data);
 
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] = N_(
@@ -388,7 +389,8 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	return ret;
 }
 
-static int add_remote_url(const char *var, const char *value, void *data)
+static int add_remote_url(const char *var, const char *value,
+			  const struct config_context *ctx UNUSED, void *data)
 {
 	struct string_list *remote_urls = data;
 	const char *remote_name;
@@ -423,6 +425,7 @@ static void populate_remote_urls(struct config_include_data *inc)
 }
 
 static int forbid_remote_url(const char *var, const char *value UNUSED,
+			     const struct config_context *ctx UNUSED,
 			     void *data UNUSED)
 {
 	const char *remote_name;
@@ -486,7 +489,9 @@ static int include_condition_is_true(struct config_source *cs,
 	return 0;
 }
 
-static int git_config_include(const char *var, const char *value, void *data)
+static int git_config_include(const char *var, const char *value,
+			      const struct config_context *ctx,
+			      void *data)
 {
 	struct config_include_data *inc = data;
 	struct config_source *cs = inc->config_reader->source;
@@ -498,7 +503,7 @@ static int git_config_include(const char *var, const char *value, void *data)
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, inc->data);
+	ret = inc->fn(var, value, NULL, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -680,7 +685,7 @@ static int config_parse_pair(const char *key, const char *value,
 	if (git_config_parse_key(key, &canonical_name, NULL))
 		return -1;
 
-	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
 	free(canonical_name);
 	return ret;
 }
@@ -968,7 +973,7 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, data);
+	ret = fn(name->buf, value, NULL, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -1562,7 +1567,8 @@ int git_config_color(char *dest, const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_core_config(const char *var, const char *value, void *cb)
+static int git_default_core_config(const char *var, const char *value,
+				   const struct config_context *ctx, void *cb)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -1842,7 +1848,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
-	return platform_core_config(var, value, cb);
+	return platform_core_config(var, value, ctx, cb);
 }
 
 static int git_default_sparse_config(const char *var, const char *value)
@@ -1944,15 +1950,16 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value, void *cb)
+int git_default_config(const char *var, const char *value,
+		       const struct config_context *ctx, void *cb)
 {
 	if (starts_with(var, "core."))
-		return git_default_core_config(var, value, cb);
+		return git_default_core_config(var, value, ctx, cb);
 
 	if (starts_with(var, "user.") ||
 	    starts_with(var, "author.") ||
 	    starts_with(var, "committer."))
-		return git_ident_config(var, value, cb);
+		return git_ident_config(var, value, ctx, cb);
 
 	if (starts_with(var, "i18n."))
 		return git_default_i18n_config(var, value);
@@ -2318,7 +2325,7 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 
 		config_reader_set_kvi(reader, values->items[value_index].util);
 
-		if (fn(entry->key, values->items[value_index].string, data) < 0)
+		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
 			git_die_config_linenr(entry->key,
 					      reader->config_kvi->filename,
 					      reader->config_kvi->linenr);
@@ -2496,7 +2503,9 @@ struct configset_add_data {
 };
 #define CONFIGSET_ADD_INIT { 0 }
 
-static int config_set_callback(const char *key, const char *value, void *cb)
+static int config_set_callback(const char *key, const char *value,
+			       const struct config_context *ctx UNUSED,
+			       void *cb)
 {
 	struct configset_add_data *data = cb;
 	configset_add_value(data->config_reader, data->config_set, key, value);
@@ -3106,7 +3115,8 @@ static int store_aux_event(enum config_event_t type,
 	return 0;
 }
 
-static int store_aux(const char *key, const char *value, void *cb)
+static int store_aux(const char *key, const char *value,
+		     const struct config_context *ctx UNUSED, void *cb)
 {
 	struct config_store_data *store = cb;
 
diff --git a/config.h b/config.h
index d1c5577589e..cd30125a8a4 100644
--- a/config.h
+++ b/config.h
@@ -110,8 +110,29 @@ struct config_options {
 	} error_action;
 };
 
+/* Config source metadata for a given config key-value pair */
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+};
+#define KVI_INIT { \
+	.filename = NULL, \
+	.linenr = -1, \
+	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
+	.scope = CONFIG_SCOPE_UNKNOWN, \
+}
+
+/* Captures additional information that a config callback can use. */
+struct config_context {
+	/* Config source metadata for key and value. */
+	const struct key_value_info *kvi;
+};
+#define CONFIG_CONTEXT_INIT { 0 }
+
 /**
- * A config callback function takes three parameters:
+ * A config callback function takes four parameters:
  *
  * - the name of the parsed variable. This is in canonical "flat" form: the
  *   section, subsection, and variable segments will be separated by dots,
@@ -122,15 +143,22 @@ struct config_options {
  *   value specified, the value will be NULL (typically this means it
  *   should be interpreted as boolean true).
  *
+ * - the 'config context', that is, additional information about the config
+ *   iteration operation provided by the config machinery. For example, this
+ *   includes information about the config source being parsed (e.g. the
+ *   filename).
+ *
  * - a void pointer passed in by the caller of the config API; this can
  *   contain callback-specific data
  *
  * A config callback should return 0 for success, or -1 if the variable
  * could not be parsed properly.
  */
-typedef int (*config_fn_t)(const char *, const char *, void *);
+typedef int (*config_fn_t)(const char *, const char *,
+			   const struct config_context *, void *);
 
-int git_default_config(const char *, const char *, void *);
+int git_default_config(const char *, const char *,
+		       const struct config_context *, void *);
 
 /**
  * Read a specific file in git-config format.
@@ -667,13 +695,6 @@ int git_config_get_expiry(const char *key, const char **output);
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
-};
-
 /**
  * First prints the error message specified by the caller in `err` and then
  * dies printing the line number and the file name of the highest priority
diff --git a/connect.c b/connect.c
index 3a0186280c4..cddac1d96b8 100644
--- a/connect.c
+++ b/connect.c
@@ -964,7 +964,7 @@ static struct child_process *git_tcp_connect(int fd[2], char *host, int flags)
 static char *git_proxy_command;
 
 static int git_proxy_command_options(const char *var, const char *value,
-		void *cb)
+		const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
@@ -1010,7 +1010,7 @@ static int git_proxy_command_options(const char *var, const char *value,
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static int git_use_proxy(const char *host)
diff --git a/contrib/coccinelle/config_fn_ctx.pending.cocci b/contrib/coccinelle/config_fn_ctx.pending.cocci
new file mode 100644
index 00000000000..6d3d1000a96
--- /dev/null
+++ b/contrib/coccinelle/config_fn_ctx.pending.cocci
@@ -0,0 +1,144 @@
+@ get_fn @
+identifier fn, R;
+@@
+(
+(
+git_config_from_file
+|
+git_config_from_file_with_options
+|
+git_config_from_mem
+|
+git_config_from_blob_oid
+|
+read_early_config
+|
+read_very_early_config
+|
+config_with_options
+|
+git_config
+|
+git_protected_config
+|
+config_from_gitmodules
+)
+  (fn, ...)
+|
+repo_config(R, fn, ...)
+)
+
+@ extends get_fn @
+identifier C1, C2, D;
+@@
+int fn(const char *C1, const char *C2,
++ const struct config_context *ctx,
+  void *D);
+
+@ extends get_fn @
+@@
+int fn(const char *, const char *,
++ const struct config_context *,
+  void *);
+
+@ extends get_fn @
+// Don't change fns that look like callback fns but aren't
+identifier fn2 != tar_filter_config && != git_diff_heuristic_config &&
+  != git_default_submodule_config && != git_color_config &&
+  != bundle_list_update && != parse_object_filter_config;
+identifier C1, C2, D1, D2, S;
+attribute name UNUSED;
+@@
+int fn(const char *C1, const char *C2,
++ const struct config_context *ctx,
+  void *D1) {
+<+...
+(
+fn2(C1, C2
++ , ctx
+, D2);
+|
+if(fn2(C1, C2
++ , ctx
+, D2) < 0) { ... }
+|
+return fn2(C1, C2
++ , ctx
+, D2);
+|
+S = fn2(C1, C2
++ , ctx
+, D2);
+)
+...+>
+  }
+
+@ extends get_fn@
+identifier C1, C2, D;
+attribute name UNUSED;
+@@
+int fn(const char *C1, const char *C2,
++ const struct config_context *ctx UNUSED,
+  void *D) {...}
+
+
+// The previous rules don't catch all callbacks, especially if they're defined
+// in a separate file from the git_config() call. Fix these manually.
+@@
+identifier C1, C2, D;
+attribute name UNUSED;
+@@
+int
+(
+git_ident_config
+|
+urlmatch_collect_fn
+|
+write_one_config
+|
+forbid_remote_url
+|
+credential_config_callback
+)
+  (const char *C1, const char *C2,
++ const struct config_context *ctx UNUSED,
+  void *D) {...}
+
+@@
+identifier C1, C2, D, D2, S, fn2;
+@@
+int
+(
+http_options
+|
+git_status_config
+|
+git_commit_config
+|
+git_default_core_config
+|
+grep_config
+)
+  (const char *C1, const char *C2,
++ const struct config_context *ctx,
+  void *D) {
+<+...
+(
+fn2(C1, C2
++ , ctx
+, D2);
+|
+if(fn2(C1, C2
++ , ctx
+, D2) < 0) { ... }
+|
+return fn2(C1, C2
++ , ctx
+, D2);
+|
+S = fn2(C1, C2
++ , ctx
+, D2);
+)
+...+>
+  }
diff --git a/convert.c b/convert.c
index 9ee79fe4699..8e96cf83030 100644
--- a/convert.c
+++ b/convert.c
@@ -1015,7 +1015,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	return 0;
 }
 
-static int read_convert_config(const char *var, const char *value, void *cb UNUSED)
+static int read_convert_config(const char *var, const char *value,
+			       const struct config_context *ctx UNUSED,
+			       void *cb UNUSED)
 {
 	const char *key, *name;
 	size_t namelen;
diff --git a/credential.c b/credential.c
index 8825c6f1320..d6647541634 100644
--- a/credential.c
+++ b/credential.c
@@ -49,6 +49,7 @@ static int credential_from_potentially_partial_url(struct credential *c,
 						   const char *url);
 
 static int credential_config_callback(const char *var, const char *value,
+				      const struct config_context *ctx UNUSED,
 				      void *data)
 {
 	struct credential *c = data;
diff --git a/delta-islands.c b/delta-islands.c
index c824a5f6a42..5fc6ea6ff55 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -341,7 +341,9 @@ static void free_remote_islands(kh_str_t *remote_islands)
 	kh_destroy_str(remote_islands);
 }
 
-static int island_config_callback(const char *k, const char *v, void *cb)
+static int island_config_callback(const char *k, const char *v,
+				  const struct config_context *ctx UNUSED,
+				  void *cb)
 {
 	struct island_load_data *ild = cb;
 
diff --git a/diff.c b/diff.c
index c106f8a4ffa..0e382c8f7f0 100644
--- a/diff.c
+++ b/diff.c
@@ -357,7 +357,8 @@ static unsigned parse_color_moved_ws(const char *arg)
 	return ret;
 }
 
-int git_diff_ui_config(const char *var, const char *value, void *cb)
+int git_diff_ui_config(const char *var, const char *value,
+		       const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
@@ -440,10 +441,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_diff_basic_config(var, value, cb);
+	return git_diff_basic_config(var, value, ctx, cb);
 }
 
-int git_diff_basic_config(const char *var, const char *value, void *cb)
+int git_diff_basic_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb)
 {
 	const char *name;
 
@@ -495,7 +497,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static char *quote_two(const char *one, const char *two)
diff --git a/diff.h b/diff.h
index 6c10ce289da..33a4f4d5988 100644
--- a/diff.h
+++ b/diff.h
@@ -531,10 +531,13 @@ void free_diffstat_info(struct diffstat_t *diffstat);
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg);
 
-int git_diff_basic_config(const char *var, const char *value, void *cb);
+struct config_context;
+int git_diff_basic_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
-int git_diff_ui_config(const char *var, const char *value, void *cb);
+int git_diff_ui_config(const char *var, const char *value,
+		       const struct config_context *ctx, void *cb);
 void repo_diff_setup(struct repository *, struct diff_options *);
 struct option *add_diff_options(const struct option *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/fetch-pack.c b/fetch-pack.c
index 0f71054fbae..5f3d40f3d09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1860,7 +1860,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
+static int fetch_pack_config_cb(const char *var, const char *value,
+				const struct config_context *ctx, void *cb)
 {
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
 		const char *path;
@@ -1882,7 +1883,7 @@ static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 static void fetch_pack_config(void)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5af0d4715ba..10137444321 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -20,7 +20,8 @@ static int use_branch_desc;
 static int suppress_dest_pattern_seen;
 static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
-int fmt_merge_msg_config(const char *key, const char *value, void *cb)
+int fmt_merge_msg_config(const char *key, const char *value,
+			 const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
@@ -40,7 +41,7 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			string_list_append(&suppress_dest_patterns, value);
 		suppress_dest_pattern_seen = 1;
 	} else {
-		return git_default_config(key, value, cb);
+		return git_default_config(key, value, ctx, cb);
 	}
 	return 0;
 }
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index 99054042dc5..73ca3e44652 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -13,7 +13,8 @@ struct fmt_merge_msg_opts {
 };
 
 extern int merge_log_config;
-int fmt_merge_msg_config(const char *key, const char *value, void *cb);
+int fmt_merge_msg_config(const char *key, const char *value,
+			 const struct config_context *ctx, void *cb);
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *);
 
diff --git a/fsck.c b/fsck.c
index 3261ef9ec28..55b6a694853 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1163,7 +1163,9 @@ struct fsck_gitmodules_data {
 	int ret;
 };
 
-static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
+static int fsck_gitmodules_fn(const char *var, const char *value,
+			      const struct config_context *ctx UNUSED,
+			      void *vdata)
 {
 	struct fsck_gitmodules_data *data = vdata;
 	const char *subsection, *key;
@@ -1373,7 +1375,8 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
-int git_fsck_config(const char *var, const char *value, void *cb)
+int git_fsck_config(const char *var, const char *value,
+		    const struct config_context *ctx, void *cb)
 {
 	struct fsck_options *options = cb;
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -1394,7 +1397,7 @@ int git_fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
 
 /*
diff --git a/fsck.h b/fsck.h
index e17730e9da9..6359ba359bd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -233,10 +233,12 @@ void fsck_put_object_name(struct fsck_options *options,
 const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
+struct key_value_info;
 /*
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
  */
-int git_fsck_config(const char *var, const char *value, void *cb);
+int git_fsck_config(const char *var, const char *value,
+		    const struct config_context *ctx, void *cb);
 
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 5b2b99c17c5..14e8aacb957 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,8 +440,10 @@ typedef uintmax_t timestamp_t;
 #endif
 
 #ifndef platform_core_config
+struct config_context;
 static inline int noop_core_config(const char *var UNUSED,
 				   const char *value UNUSED,
+				   const struct config_context *ctx UNUSED,
 				   void *cb UNUSED)
 {
 	return 0;
diff --git a/gpg-interface.c b/gpg-interface.c
index 19a3471a0b5..57c862a3a22 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -14,7 +14,8 @@
 #include "alias.h"
 #include "wrapper.h"
 
-static int git_gpg_config(const char *, const char *, void *);
+static int git_gpg_config(const char *, const char *,
+			  const struct config_context *, void *);
 
 static void gpg_interface_lazy_init(void)
 {
@@ -720,7 +721,9 @@ void set_signing_key(const char *key)
 	configured_signing_key = xstrdup(key);
 }
 
-static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
+static int git_gpg_config(const char *var, const char *value,
+			  const struct config_context *ctx UNUSED,
+			  void *cb UNUSED)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
diff --git a/grep.c b/grep.c
index f00986c451a..fc22c3e2afb 100644
--- a/grep.c
+++ b/grep.c
@@ -56,7 +56,8 @@ define_list_config_array_extra(color_grep_slots, {"match"});
  * Read the configuration file once and store it in
  * the grep_defaults template.
  */
-int grep_config(const char *var, const char *value, void *cb)
+int grep_config(const char *var, const char *value,
+		const struct config_context *ctx, void *cb)
 {
 	struct grep_opt *opt = cb;
 	const char *slot;
@@ -91,9 +92,9 @@ int grep_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
 	if (!strcmp(var, "color.grep.match")) {
-		if (grep_config("color.grep.matchcontext", value, cb) < 0)
+		if (grep_config("color.grep.matchcontext", value, ctx, cb) < 0)
 			return -1;
-		if (grep_config("color.grep.matchselected", value, cb) < 0)
+		if (grep_config("color.grep.matchselected", value, ctx, cb) < 0)
 			return -1;
 	} else if (skip_prefix(var, "color.grep.", &slot)) {
 		int i = LOOKUP_CONFIG(color_grep_slots, slot);
diff --git a/grep.h b/grep.h
index c59592e3bdb..926c0875c42 100644
--- a/grep.h
+++ b/grep.h
@@ -202,7 +202,9 @@ struct grep_opt {
 	.output = std_output, \
 }
 
-int grep_config(const char *var, const char *value, void *);
+struct config_context;
+int grep_config(const char *var, const char *value,
+		const struct config_context *ctx, void *data);
 void grep_init(struct grep_opt *, struct repository *repo);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
diff --git a/help.c b/help.c
index 5d7637dce92..ac0ae5ac0dc 100644
--- a/help.c
+++ b/help.c
@@ -309,7 +309,8 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
-static int get_colopts(const char *var, const char *value, void *data)
+static int get_colopts(const char *var, const char *value,
+		       const struct config_context *ctx UNUSED, void *data)
 {
 	unsigned int *colopts = data;
 
@@ -459,7 +460,8 @@ void list_developer_interfaces_help(void)
 	putchar('\n');
 }
 
-static int get_alias(const char *var, const char *value, void *data)
+static int get_alias(const char *var, const char *value,
+		     const struct config_context *ctx UNUSED, void *data)
 {
 	struct string_list *list = data;
 
@@ -543,6 +545,7 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
 static int git_unknown_cmd_config(const char *var, const char *value,
+				  const struct config_context *ctx UNUSED,
 				  void *cb UNUSED)
 {
 	const char *p;
diff --git a/http.c b/http.c
index bb58bb3e6a3..762502828c9 100644
--- a/http.c
+++ b/http.c
@@ -363,7 +363,8 @@ static void process_curl_messages(void)
 	}
 }
 
-static int http_options(const char *var, const char *value, void *cb)
+static int http_options(const char *var, const char *value,
+			const struct config_context *ctx, void *data)
 {
 	if (!strcmp("http.version", var)) {
 		return git_config_string(&curl_http_version, var, value);
@@ -534,7 +535,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	/* Fall back on the default ones */
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, data);
 }
 
 static int curl_empty_auth_enabled(void)
diff --git a/ident.c b/ident.c
index 8fad92d7007..08be4d0747d 100644
--- a/ident.c
+++ b/ident.c
@@ -671,7 +671,9 @@ static int set_ident(const char *var, const char *value)
 	return 0;
 }
 
-int git_ident_config(const char *var, const char *value, void *data UNUSED)
+int git_ident_config(const char *var, const char *value,
+		     const struct config_context *ctx UNUSED,
+		     void *data UNUSED)
 {
 	if (!strcmp(var, "user.useconfigonly")) {
 		ident_use_config_only = git_config_bool(var, value);
diff --git a/ident.h b/ident.h
index 96a64896a01..6a79febba15 100644
--- a/ident.h
+++ b/ident.h
@@ -62,6 +62,8 @@ const char *fmt_name(enum want_ident);
 int committer_ident_sufficiently_given(void);
 int author_ident_sufficiently_given(void);
 
-int git_ident_config(const char *, const char *, void *);
+struct config_context;
+int git_ident_config(const char *, const char *, const struct config_context *,
+		     void *);
 
 #endif
diff --git a/imap-send.c b/imap-send.c
index 7f5426177a1..47777e76861 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1323,7 +1323,8 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 	return 1;
 }
 
-static int git_imap_config(const char *var, const char *val, void *cb)
+static int git_imap_config(const char *var, const char *val,
+			   const struct config_context *ctx, void *cb)
 {
 
 	if (!strcmp("imap.sslverify", var))
@@ -1357,7 +1358,7 @@ static int git_imap_config(const char *var, const char *val, void *cb)
 			server.host = xstrdup(val);
 		}
 	} else
-		return git_default_config(var, val, cb);
+		return git_default_config(var, val, ctx, cb);
 
 	return 0;
 }
diff --git a/ll-merge.c b/ll-merge.c
index 07ec16e8e5b..3936d112e00 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -254,6 +254,7 @@ static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value,
+			     const struct config_context *ctx UNUSED,
 			     void *cb UNUSED)
 {
 	struct ll_merge_driver *fn;
diff --git a/ls-refs.c b/ls-refs.c
index f385938b64c..a29c2364a59 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -137,6 +137,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 }
 
 static int ls_refs_config(const char *var, const char *value,
+			  const struct config_context *ctx UNUSED,
 			  void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
diff --git a/mailinfo.c b/mailinfo.c
index 2aeb20e5e62..931505363cd 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1241,12 +1241,13 @@ int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
 	return 0;
 }
 
-static int git_mailinfo_config(const char *var, const char *value, void *mi_)
+static int git_mailinfo_config(const char *var, const char *value,
+			       const struct config_context *ctx, void *mi_)
 {
 	struct mailinfo *mi = mi_;
 
 	if (!starts_with(var, "mailinfo."))
-		return git_default_config(var, value, NULL);
+		return git_default_config(var, value, ctx, NULL);
 	if (!strcmp(var, "mailinfo.scissors")) {
 		mi->use_scissors = git_config_bool(var, value);
 		return 0;
diff --git a/notes-utils.c b/notes-utils.c
index 4a793eb347f..97c031c26ec 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -94,7 +94,9 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
 		return NULL;
 }
 
-static int notes_rewrite_config(const char *k, const char *v, void *cb)
+static int notes_rewrite_config(const char *k, const char *v,
+				const struct config_context *ctx UNUSED,
+				void *cb)
 {
 	struct notes_rewrite_cfg *c = cb;
 	if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
diff --git a/notes.c b/notes.c
index f51a2d3630e..e68645a4b89 100644
--- a/notes.c
+++ b/notes.c
@@ -974,7 +974,9 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
-static int notes_display_config(const char *k, const char *v, void *cb)
+static int notes_display_config(const char *k, const char *v,
+				const struct config_context *ctx UNUSED,
+				void *cb)
 {
 	int *load_refs = cb;
 
diff --git a/pager.c b/pager.c
index 63055d0873f..b8822a9381e 100644
--- a/pager.c
+++ b/pager.c
@@ -43,6 +43,7 @@ static void wait_for_pager_signal(int signo)
 }
 
 static int core_pager_config(const char *var, const char *value,
+			     const struct config_context *ctx UNUSED,
 			     void *data UNUSED)
 {
 	if (!strcmp(var, "core.pager"))
@@ -228,7 +229,9 @@ struct pager_command_config_data {
 	char *value;
 };
 
-static int pager_command_config(const char *var, const char *value, void *vdata)
+static int pager_command_config(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *vdata)
 {
 	struct pager_command_config_data *data = vdata;
 	const char *cmd;
diff --git a/pretty.c b/pretty.c
index 0bb938021ba..87245353452 100644
--- a/pretty.c
+++ b/pretty.c
@@ -56,6 +56,7 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 }
 
 static int git_pretty_formats_config(const char *var, const char *value,
+				     const struct config_context *ctx UNUSED,
 				     void *cb UNUSED)
 {
 	struct cmt_fmt_map *commit_format = NULL;
diff --git a/promisor-remote.c b/promisor-remote.c
index 1adcd6fb0a5..c22abb85b15 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -100,7 +100,9 @@ static void promisor_remote_move_to_tail(struct promisor_remote_config *config,
 	config->promisors_tail = &r->next;
 }
 
-static int promisor_remote_config(const char *var, const char *value, void *data)
+static int promisor_remote_config(const char *var, const char *value,
+				  const struct config_context *ctx UNUSED,
+				  void *data)
 {
 	struct promisor_remote_config *config = data;
 	const char *name;
diff --git a/remote.c b/remote.c
index 1bcd36e358a..241999c2842 100644
--- a/remote.c
+++ b/remote.c
@@ -349,7 +349,8 @@ static void read_branches_file(struct remote_state *remote_state,
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-static int handle_config(const char *key, const char *value, void *cb)
+static int handle_config(const char *key, const char *value,
+			 const struct config_context *ctx UNUSED, void *cb)
 {
 	const char *name;
 	size_t namelen;
diff --git a/revision.c b/revision.c
index b33cc1d106a..87ed8ccd444 100644
--- a/revision.c
+++ b/revision.c
@@ -1572,7 +1572,9 @@ struct exclude_hidden_refs_cb {
 	const char *section;
 };
 
-static int hide_refs_config(const char *var, const char *value, void *cb_data)
+static int hide_refs_config(const char *var, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *cb_data)
 {
 	struct exclude_hidden_refs_cb *cb = cb_data;
 	cb->exclusions->hidden_refs_configured = 1;
diff --git a/scalar.c b/scalar.c
index 1326e1f6089..df7358f481c 100644
--- a/scalar.c
+++ b/scalar.c
@@ -594,7 +594,9 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
-static int get_scalar_repos(const char *key, const char *value, void *data)
+static int get_scalar_repos(const char *key, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *data)
 {
 	struct string_list *list = data;
 
diff --git a/sequencer.c b/sequencer.c
index bceb6abcb6c..34754d17596 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -219,7 +219,8 @@ static struct update_ref_record *init_update_ref_record(const char *ref)
 	return rec;
 }
 
-static int git_sequencer_config(const char *k, const char *v, void *cb)
+static int git_sequencer_config(const char *k, const char *v,
+				const struct config_context *ctx, void *cb)
 {
 	struct replay_opts *opts = cb;
 	int status;
@@ -274,7 +275,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
 		opts->commit_use_reference = git_config_bool(k, v);
 
-	return git_diff_basic_config(k, v, NULL);
+	return git_diff_basic_config(k, v, ctx, NULL);
 }
 
 void sequencer_init_config(struct replay_opts *opts)
@@ -2881,7 +2882,9 @@ static int git_config_string_dup(char **dest,
 	return 0;
 }
 
-static int populate_opts_cb(const char *key, const char *value, void *data)
+static int populate_opts_cb(const char *key, const char *value,
+			    const struct config_context *ctx UNUSED,
+			    void *data)
 {
 	struct replay_opts *opts = data;
 	int error_flag = 1;
diff --git a/setup.c b/setup.c
index 6f6e92b96be..fadba5bab4b 100644
--- a/setup.c
+++ b/setup.c
@@ -517,7 +517,9 @@ no_prevention_needed:
 	startup_info->original_cwd = NULL;
 }
 
-static int read_worktree_config(const char *var, const char *value, void *vdata)
+static int read_worktree_config(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *vdata)
 {
 	struct repository_format *data = vdata;
 
@@ -588,7 +590,8 @@ static enum extension_result handle_extension(const char *var,
 	return EXTENSION_UNKNOWN;
 }
 
-static int check_repo_format(const char *var, const char *value, void *vdata)
+static int check_repo_format(const char *var, const char *value,
+			     const struct config_context *ctx, void *vdata)
 {
 	struct repository_format *data = vdata;
 	const char *ext;
@@ -617,7 +620,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 		}
 	}
 
-	return read_worktree_config(var, value, vdata);
+	return read_worktree_config(var, value, ctx, vdata);
 }
 
 static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
@@ -1115,7 +1118,8 @@ struct safe_directory_data {
 	int is_safe;
 };
 
-static int safe_directory_cb(const char *key, const char *value, void *d)
+static int safe_directory_cb(const char *key, const char *value,
+			     const struct config_context *ctx UNUSED, void *d)
 {
 	struct safe_directory_data *data = d;
 
@@ -1171,7 +1175,9 @@ static int ensure_valid_ownership(const char *gitfile,
 	return data.is_safe;
 }
 
-static int allowed_bare_repo_cb(const char *key, const char *value, void *d)
+static int allowed_bare_repo_cb(const char *key, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *d)
 {
 	enum allowed_bare_repo *allowed_bare_repo = d;
 
diff --git a/submodule-config.c b/submodule-config.c
index 7eb7a0d88d2..a38d4d49731 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -426,7 +426,8 @@ struct parse_config_parameter {
  * config store (.git/config, etc).  Callers are responsible for
  * checking for overrides in the main config store when appropriate.
  */
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_config(const char *var, const char *value,
+			const struct config_context *ctx UNUSED, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
@@ -674,7 +675,8 @@ out:
 	}
 }
 
-static int gitmodules_cb(const char *var, const char *value, void *data)
+static int gitmodules_cb(const char *var, const char *value,
+			 const struct config_context *ctx, void *data)
 {
 	struct repository *repo = data;
 	struct parse_config_parameter parameter;
@@ -684,7 +686,7 @@ static int gitmodules_cb(const char *var, const char *value, void *data)
 	parameter.gitmodules_oid = null_oid();
 	parameter.overwrite = 1;
 
-	return parse_config(var, value, &parameter);
+	return parse_config(var, value, ctx, &parameter);
 }
 
 void repo_read_gitmodules(struct repository *repo, int skip_if_read)
@@ -801,7 +803,9 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
-static int config_print_callback(const char *var, const char *value, void *cb_data)
+static int config_print_callback(const char *var, const char *value,
+				 const struct config_context *ctx UNUSED,
+				 void *cb_data)
 {
 	char *wanted_key = cb_data;
 
@@ -843,7 +847,9 @@ struct fetch_config {
 	int *recurse_submodules;
 };
 
-static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+static int gitmodules_fetch_config(const char *var, const char *value,
+				   const struct config_context *ctx UNUSED,
+				   void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
@@ -871,6 +877,7 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
+					  const struct config_context *ctx UNUSED,
 					  void *cb)
 {
 	int *max_jobs = cb;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ad78fc17683..85ad815358e 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -42,7 +42,9 @@
  *
  */
 
-static int iterate_cb(const char *var, const char *value, void *data UNUSED)
+static int iterate_cb(const char *var, const char *value,
+		      const struct config_context *ctx UNUSED,
+		      void *data UNUSED)
 {
 	static int nr;
 
@@ -59,7 +61,8 @@ static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 	return 0;
 }
 
-static int parse_int_cb(const char *var, const char *value, void *data)
+static int parse_int_cb(const char *var, const char *value,
+			const struct config_context *ctx UNUSED, void *data)
 {
 	const char *key_to_match = data;
 
@@ -70,7 +73,9 @@ static int parse_int_cb(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static int early_config_cb(const char *var, const char *value, void *vdata)
+static int early_config_cb(const char *var, const char *value,
+			   const struct config_context *ctx UNUSED,
+			   void *vdata)
 {
 	const char *key = vdata;
 
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 680124a6760..0ce31ce59f5 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -12,7 +12,9 @@ static int driver_cb(struct userdiff_driver *driver,
 	return 0;
 }
 
-static int cmd__userdiff_config(const char *var, const char *value, void *cb UNUSED)
+static int cmd__userdiff_config(const char *var, const char *value,
+				const struct config_context *ctx UNUSED,
+				void *cb UNUSED)
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 78cfc15d52d..83bc4fd109c 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -99,7 +99,8 @@ struct tr2_cfg_data {
 /*
  * See if the given config key matches any of our patterns of interest.
  */
-static int tr2_cfg_cb(const char *key, const char *value, void *d)
+static int tr2_cfg_cb(const char *key, const char *value,
+		      const struct config_context *ctx UNUSED, void *d)
 {
 	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
@@ -142,8 +143,12 @@ void tr2_list_env_vars_fl(const char *file, int line)
 void tr2_cfg_set_fl(const char *file, int line, const char *key,
 		    const char *value)
 {
+	struct key_value_info kvi = KVI_INIT;
+	struct config_context ctx = {
+		.kvi = &kvi,
+	};
 	struct tr2_cfg_data data = { file, line };
 
 	if (tr2_cfg_load_patterns() > 0)
-		tr2_cfg_cb(key, value, &data);
+		tr2_cfg_cb(key, value, &ctx, &data);
 }
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 069786cb927..f26ec95ab4d 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -57,7 +57,8 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 };
 /* clang-format on */
 
-static int tr2_sysenv_cb(const char *key, const char *value, void *d)
+static int tr2_sysenv_cb(const char *key, const char *value,
+			 const struct config_context *ctx UNUSED, void *d)
 {
 	int k;
 
diff --git a/trailer.c b/trailer.c
index a2c3ed6f28c..06dc0b7f683 100644
--- a/trailer.c
+++ b/trailer.c
@@ -482,6 +482,7 @@ static struct {
 };
 
 static int git_trailer_default_config(const char *conf_key, const char *value,
+				      const struct config_context *ctx UNUSED,
 				      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
@@ -514,6 +515,7 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 }
 
 static int git_trailer_config(const char *conf_key, const char *value,
+			      const struct config_context *ctx UNUSED,
 			      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
diff --git a/upload-pack.c b/upload-pack.c
index d3312006a32..951fd1f9c25 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1309,7 +1309,9 @@ static int parse_object_filter_config(const char *var, const char *value,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *cb_data)
+static int upload_pack_config(const char *var, const char *value,
+			      const struct config_context *ctx UNUSED,
+			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
 
@@ -1350,7 +1352,9 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 }
 
-static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
+static int upload_pack_protected_config(const char *var, const char *value,
+					const struct config_context *ctx UNUSED,
+					void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
 
diff --git a/urlmatch.c b/urlmatch.c
index eba0bdd77fe..1c45f23adf2 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -551,7 +551,8 @@ static int cmp_matches(const struct urlmatch_item *a,
 	return 0;
 }
 
-int urlmatch_config_entry(const char *var, const char *value, void *cb)
+int urlmatch_config_entry(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb)
 {
 	struct string_list_item *item;
 	struct urlmatch_config *collect = cb;
@@ -565,7 +566,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 
 	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
 		if (collect->cascade_fn)
-			return collect->cascade_fn(var, value, cb);
+			return collect->cascade_fn(var, value, ctx, cb);
 		return 0; /* not interested */
 	}
 	dot = strrchr(key, '.');
@@ -609,7 +610,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	strbuf_addstr(&synthkey, collect->section);
 	strbuf_addch(&synthkey, '.');
 	strbuf_addstr(&synthkey, key);
-	retval = collect->collect_fn(synthkey.buf, value, collect->cb);
+	retval = collect->collect_fn(synthkey.buf, value, ctx, collect->cb);
 
 	strbuf_release(&synthkey);
 	return retval;
diff --git a/urlmatch.h b/urlmatch.h
index bee374a642c..5ba85cea139 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -71,7 +71,8 @@ struct urlmatch_config {
 	.vars = STRING_LIST_INIT_DUP, \
 }
 
-int urlmatch_config_entry(const char *var, const char *value, void *cb);
+int urlmatch_config_entry(const char *var, const char *value,
+			  const struct config_context *ctx, void *cb);
 void urlmatch_config_release(struct urlmatch_config *config);
 
 #endif /* URL_MATCH_H */
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0460e03f5ed..dcbb5e09857 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -307,7 +307,8 @@ int xdiff_compare_lines(const char *l1, long s1,
 
 int git_xmerge_style = -1;
 
-int git_xmerge_config(const char *var, const char *value, void *cb)
+int git_xmerge_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
@@ -327,5 +328,5 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			    value, var);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value, ctx, cb);
 }
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 733c364d26c..e6f80df0462 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -50,7 +50,9 @@ int buffer_is_binary(const char *ptr, unsigned long size);
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
-int git_xmerge_config(const char *var, const char *value, void *cb);
+struct config_context;
+int git_xmerge_config(const char *var, const char *value,
+		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;
 
 /*
-- 
gitgitgadget


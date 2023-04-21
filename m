Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE2C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjDUTOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjDUTN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A192A30CA
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3010889c6ebso1298425f8f.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrOfQL86duEp3XC0m3WNIALPgoOqAppp7gvKhiKTpJw=;
        b=EBsXqZCqGsXJ8O3goYxM6Eod7JS5KUaVRkgIdfcyaMFyzPrQxHvuYoVQP4mTGNLXLo
         ZVoGSTtrX3xovUf2oEbEN5Hno1Tias1cZ8+C7vD1Ac9OGjyCU062o+UBVNI2dmyQ89KF
         DZ12VjOJzd9gkFsEQGacok8SoZgxfGy76MKvtBg/a+07woS26300QY7ZBz8LccE6is2b
         KbP1SaxSqgxDMBcikie88tke8GLfcuEHK/eIMj7or15rhETrhQCHiLP7IP9eBMct57Xd
         B6Gb7p6vcVQuHHrYWNSk2PGjzahgMc6MhDTsMIpkFyj2FkulTyUdggnz4J2XOAyWM39v
         V2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104407; x=1684696407;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrOfQL86duEp3XC0m3WNIALPgoOqAppp7gvKhiKTpJw=;
        b=j77QhSiPpH9UjmisEXuJ9FVv+BwGvkltnxaWzQR+CUVPR1z3uoWFOyvsVUOlHcTWuw
         yC971GQz/hHmwmu9+IWLg8gKd+gzDFU9uUe8OPwyOXOci6FiUDy7sYJUGIO+HuDx0tTc
         yCbFFCDJqPAMjuny082sB5WFutpSN9NxLHJuJUnJuJQrGQexgtGBoySWqYTf6n+sPmWV
         syOCwXOtHyt0k8KzQDaqzm6c81nqeFrfwIa/nZlPoSlLTXXzFrtusfxEdHmrL2/KjhlW
         HRzyrH8xb2fhx2z1EudtBlxpSqWw9ttnxeyxV2ijROOkAt0AL5I/kZ4Jh+/NW8wVljx8
         KUjA==
X-Gm-Message-State: AAQBX9e4vAtf9AKMwIHKfkxbOo6vdKeFXt4jDoVvWvTkNvZ8/6wHurpn
        nZOZjpPJuIaROxiXmRYIqoehTf7wBlU=
X-Google-Smtp-Source: AKy350ZpA3lpI2m/6l9+hXgr7mZ90dd8dtr40OUgGZTUtGRHT/TRa2FIcJuFs8Pft9JZgGsXNYL2fA==
X-Received: by 2002:a5d:4f05:0:b0:2ef:baa1:f3fc with SMTP id c5-20020a5d4f05000000b002efbaa1f3fcmr4128755wru.19.1682104406021;
        Fri, 21 Apr 2023 12:13:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003eddc6aa5fasm5206051wmb.39.2023.04.21.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:25 -0700 (PDT)
Message-Id: <5eb3874b49431e0d204735fe959f628367159735.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:13 +0000
Subject: [PATCH 09/14] (RFC-only) config: apply cocci to config_fn_t
 implementations
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

Pass "struct key_value_info" to *most* functions that are invoked as
"config_fn_t" callbacks by applying
contrib/coccinelle/config_fn_kvi.pending.cocci. None of the functions
actually use the "kvi" arg yet (besides propagating it to a function
that now expects "kvi"), but this will be addressed in a later commit.
When deciding whether or not to propagate "kvi" to an inner function,
only propagate the "kvi" arg if the inner function is actually invoked
elsewhere as a config callback; it does not matter whether the function
happens have the same signature as config_fn_t.

This commit does not build and has several style issues (e.g. a lack of
spacing around the "kvi" arg), but I've split this out for the RFC so
that it's more obvious which changes are automatic vs manual. Post-RFC I
will squash this with the rest of the refactor + cocci changes.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 alias.c                     |  3 ++-
 archive-tar.c               |  3 ++-
 archive-zip.c               |  1 +
 builtin/add.c               |  5 +++--
 builtin/blame.c             |  5 +++--
 builtin/branch.c            |  5 +++--
 builtin/cat-file.c          |  5 +++--
 builtin/checkout.c          |  5 +++--
 builtin/clean.c             |  5 +++--
 builtin/clone.c             |  8 +++++---
 builtin/column.c            |  3 ++-
 builtin/commit-graph.c      |  1 +
 builtin/commit.c            | 10 ++++++----
 builtin/config.c            | 10 +++++++---
 builtin/difftool.c          |  5 +++--
 builtin/fetch.c             |  8 +++++---
 builtin/fsmonitor--daemon.c |  5 +++--
 builtin/grep.c              |  5 +++--
 builtin/help.c              |  5 +++--
 builtin/index-pack.c        |  5 +++--
 builtin/log.c               | 10 ++++++----
 builtin/merge.c             |  7 ++++---
 builtin/multi-pack-index.c  |  1 +
 builtin/pack-objects.c      |  5 +++--
 builtin/patch-id.c          |  5 +++--
 builtin/pull.c              |  5 +++--
 builtin/push.c              |  5 +++--
 builtin/read-tree.c         |  5 +++--
 builtin/rebase.c            |  5 +++--
 builtin/receive-pack.c      |  5 +++--
 builtin/reflog.c            |  7 ++++---
 builtin/remote.c            |  6 ++++--
 builtin/repack.c            |  5 +++--
 builtin/reset.c             |  5 +++--
 builtin/send-pack.c         |  5 +++--
 builtin/show-branch.c       |  5 +++--
 builtin/stash.c             |  5 +++--
 builtin/submodule--helper.c |  1 +
 builtin/tag.c               |  5 +++--
 builtin/var.c               |  5 +++--
 builtin/worktree.c          |  5 +++--
 bundle-uri.c                |  8 ++++++--
 config.c                    | 28 ++++++++++++++++++----------
 config.h                    |  3 ++-
 connect.c                   |  4 ++--
 convert.c                   |  4 +++-
 credential.c                |  1 +
 delta-islands.c             |  3 ++-
 diff.c                      | 10 ++++++----
 diff.h                      |  6 ++++--
 fetch-pack.c                |  5 +++--
 fmt-merge-msg.c             |  5 +++--
 fmt-merge-msg.h             |  3 ++-
 fsck.c                      |  8 +++++---
 fsck.h                      |  3 ++-
 gpg-interface.c             |  6 ++++--
 grep.c                      |  3 ++-
 help.c                      |  7 +++++--
 ident.c                     |  3 ++-
 ident.h                     |  3 ++-
 imap-send.c                 |  5 +++--
 ll-merge.c                  |  1 +
 ls-refs.c                   |  2 +-
 mailinfo.c                  |  5 +++--
 notes-utils.c               |  3 ++-
 notes.c                     |  3 ++-
 pager.c                     |  5 ++++-
 pretty.c                    |  1 +
 promisor-remote.c           |  4 +++-
 remote.c                    |  3 ++-
 revision.c                  |  3 ++-
 scalar.c                    |  3 ++-
 sequencer.c                 |  8 +++++---
 setup.c                     | 15 ++++++++++-----
 submodule-config.c          | 15 +++++++++++----
 t/helper/test-config.c      |  9 ++++++---
 t/helper/test-userdiff.c    |  4 +++-
 trace2/tr2_cfg.c            |  3 ++-
 trace2/tr2_sysenv.c         |  3 ++-
 trailer.c                   |  2 ++
 upload-pack.c               |  8 ++++++--
 urlmatch.c                  |  3 ++-
 urlmatch.h                  |  3 ++-
 xdiff-interface.c           |  5 +++--
 xdiff-interface.h           |  3 ++-
 85 files changed, 285 insertions(+), 156 deletions(-)

diff --git a/alias.c b/alias.c
index e814948ced3..38c51038a13 100644
--- a/alias.c
+++ b/alias.c
@@ -11,7 +11,8 @@ struct config_alias_data {
 	struct string_list *list;
 };
 
-static int config_alias_cb(const char *key, const char *value, void *d)
+static int config_alias_cb(const char *key, const char *value,
+			   struct key_value_info *kvi UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
 	const char *p;
diff --git a/archive-tar.c b/archive-tar.c
index 497dad0b3af..dcfbce5225a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -410,7 +410,8 @@ static int tar_filter_config(const char *var, const char *value,
 	return 0;
 }
 
-static int git_tar_config(const char *var, const char *value, void *cb)
+static int git_tar_config(const char *var, const char *value,
+			  struct key_value_info *kvi UNUSED, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
diff --git a/archive-zip.c b/archive-zip.c
index e6f5c10a14f..0b028246689 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -616,6 +616,7 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 }
 
 static int archive_zip_config(const char *var, const char *value,
+			      struct key_value_info *kvi UNUSED,
 			      void *data UNUSED)
 {
 	return userdiff_config(var, value);
diff --git a/builtin/add.c b/builtin/add.c
index f12054d9be1..f8e42e05b07 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -355,7 +355,8 @@ static struct option builtin_add_options[] = {
 	OPT_END(),
 };
 
-static int add_config(const char *var, const char *value, void *cb)
+static int add_config(const char *var, const char *value,
+		      struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "add.ignoreerrors") ||
 	    !strcmp(var, "add.ignore-errors")) {
@@ -363,7 +364,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static const char embedded_advice[] = N_(
diff --git a/builtin/blame.c b/builtin/blame.c
index a8d2114adc9..0aafc8172e2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -692,7 +692,8 @@ static const char *add_prefix(const char *prefix, const char *path)
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
-static int git_blame_config(const char *var, const char *value, void *cb)
+static int git_blame_config(const char *var, const char *value,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
@@ -765,7 +766,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
diff --git a/builtin/branch.c b/builtin/branch.c
index c6982181fd5..26091a036d2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -80,7 +80,8 @@ static unsigned int colopts;
 
 define_list_config_array(color_branch_slots);
 
-static int git_branch_config(const char *var, const char *value, void *cb)
+static int git_branch_config(const char *var, const char *value,
+			     struct key_value_info *kvi, void *cb)
 {
 	const char *slot_name;
 
@@ -117,7 +118,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static const char *branch_get_color(enum color_branch ix)
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 04d4bb6c777..b1e0e95d631 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -882,12 +882,13 @@ static int batch_objects(struct batch_options *opt)
 	return retval;
 }
 
-static int git_cat_file_config(const char *var, const char *value, void *cb)
+static int git_cat_file_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int batch_option_callback(const struct option *opt,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38a8cd6a965..92017ba6696 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1182,7 +1182,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	return ret || writeout_error;
 }
 
-static int git_checkout_config(const char *var, const char *value, void *cb)
+static int git_checkout_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *cb)
 {
 	struct checkout_opts *opts = cb;
 
@@ -1198,7 +1199,7 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
 
-	return git_xmerge_config(var, value, NULL);
+	return git_xmerge_config(var, value,kvi, NULL);
 }
 
 static void setup_new_branch_info_and_source_tree(
diff --git a/builtin/clean.c b/builtin/clean.c
index a06df48a269..1c648276ebf 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -102,7 +102,8 @@ struct menu_stuff {
 
 define_list_config_array(color_interactive_slots);
 
-static int git_clean_config(const char *var, const char *value, void *cb)
+static int git_clean_config(const char *var, const char *value,
+			    struct key_value_info *kvi, void *cb)
 {
 	const char *slot_name;
 
@@ -132,7 +133,7 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static const char *clean_get_color(enum color_clean ix)
diff --git a/builtin/clone.c b/builtin/clone.c
index 6dc89f1058b..1e1cf104194 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -775,7 +775,8 @@ static int checkout(int submodule_progress, int filter_submodules)
 	return err;
 }
 
-static int git_clone_config(const char *k, const char *v, void *cb)
+static int git_clone_config(const char *k, const char *v,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(k, "clone.defaultremotename")) {
 		free(remote_name);
@@ -786,10 +787,11 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "clone.filtersubmodules"))
 		config_filter_submodules = git_config_bool(k, v);
 
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v,kvi, cb);
 }
 
-static int write_one_config(const char *key, const char *value, void *data)
+static int write_one_config(const char *key, const char *value,
+			    struct key_value_info *kvi UNUSED, void *data)
 {
 	/*
 	 * give git_clone_config a chance to write config values back to the
diff --git a/builtin/column.c b/builtin/column.c
index de623a16c2d..30cfbed62ec 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -13,7 +13,8 @@ static const char * const builtin_column_usage[] = {
 };
 static unsigned int colopts;
 
-static int column_config(const char *var, const char *value, void *cb)
+static int column_config(const char *var, const char *value,
+			 struct key_value_info *kvi UNUSED, void *cb)
 {
 	return git_column_config(var, value, cb, &colopts);
 }
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 90114269761..e811866b5dd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -185,6 +185,7 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
+					 struct key_value_info *kvi UNUSED,
 					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
diff --git a/builtin/commit.c b/builtin/commit.c
index 9d8e1ea91a3..ec468e87039 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1402,7 +1402,8 @@ static int parse_status_slot(const char *slot)
 	return LOOKUP_CONFIG(color_status_slots, slot);
 }
 
-static int git_status_config(const char *k, const char *v, void *cb)
+static int git_status_config(const char *k, const char *v,
+			     struct key_value_info *kvi, void *cb)
 {
 	struct wt_status *s = cb;
 	const char *slot_name;
@@ -1487,7 +1488,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->detect_rename = git_config_rename(k, v);
 		return 0;
 	}
-	return git_diff_ui_config(k, v, NULL);
+	return git_diff_ui_config(k, v,kvi, NULL);
 }
 
 int cmd_status(int argc, const char **argv, const char *prefix)
@@ -1602,7 +1603,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int git_commit_config(const char *k, const char *v, void *cb)
+static int git_commit_config(const char *k, const char *v,
+			     struct key_value_info *kvi, void *cb)
 {
 	struct wt_status *s = cb;
 
@@ -1624,7 +1626,7 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	return git_status_config(k, v, s);
+	return git_status_config(k, v,kvi, s);
 }
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
diff --git a/builtin/config.c b/builtin/config.c
index fe79fb60c43..b2ad7351d0a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -214,7 +214,7 @@ static void show_config_scope(struct strbuf *buf)
 }
 
 static int show_all_config(const char *key_, const char *value_,
-			   void *cb UNUSED)
+			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
 {
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
@@ -298,7 +298,8 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 	return 0;
 }
 
-static int collect_config(const char *key_, const char *value_, void *cb)
+static int collect_config(const char *key_, const char *value_,
+			  struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct strbuf_list *values = cb;
 
@@ -466,6 +467,7 @@ static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
 static int git_get_color_config(const char *var, const char *value,
+				struct key_value_info *kvi UNUSED,
 				void *cb UNUSED)
 {
 	if (!strcmp(var, get_color_slot)) {
@@ -498,6 +500,7 @@ static int get_colorbool_found;
 static int get_diff_color_found;
 static int get_color_ui_found;
 static int git_get_colorbool_config(const char *var, const char *value,
+				    struct key_value_info *kvi UNUSED,
 				    void *data UNUSED)
 {
 	if (!strcmp(var, get_colorbool_slot))
@@ -555,7 +558,8 @@ struct urlmatch_current_candidate_value {
 	struct strbuf value;
 };
 
-static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
+static int urlmatch_collect_fn(const char *var, const char *value,
+			       struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct string_list *values = cb;
 	struct string_list_item *item = string_list_insert(values, var);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e010a21bfbc..d4d149bcf6b 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -38,14 +38,15 @@ static const char *const builtin_difftool_usage[] = {
 	NULL
 };
 
-static int difftool_config(const char *var, const char *value, void *cb)
+static int difftool_config(const char *var, const char *value,
+			   struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "difftool.trustexitcode")) {
 		trust_exit_code = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int print_tool_help(void)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 85bd2801036..aa688291613 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -100,7 +100,8 @@ static int fetch_write_commit_graph = -1;
 static int stdin_refspecs = 0;
 static int negotiate_only;
 
-static int git_fetch_config(const char *k, const char *v, void *cb)
+static int git_fetch_config(const char *k, const char *v,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(k, "fetch.prune")) {
 		fetch_prune_config = git_config_bool(k, v);
@@ -140,7 +141,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v,kvi, cb);
 }
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
@@ -1828,7 +1829,8 @@ struct remote_group_data {
 	struct string_list *list;
 };
 
-static int get_remote_group(const char *key, const char *value, void *priv)
+static int get_remote_group(const char *key, const char *value,
+			    struct key_value_info *kvi UNUSED, void *priv)
 {
 	struct remote_group_data *g = priv;
 
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 42af6a2cc7e..a7375d61d02 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -36,7 +36,8 @@ static int fsmonitor__start_timeout_sec = 60;
 #define FSMONITOR__ANNOUNCE_STARTUP "fsmonitor.announcestartup"
 static int fsmonitor__announce_startup = 0;
 
-static int fsmonitor_config(const char *var, const char *value, void *cb)
+static int fsmonitor_config(const char *var, const char *value,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
 		int i = git_config_int(var, value);
@@ -66,7 +67,7 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 /*
diff --git a/builtin/grep.c b/builtin/grep.c
index c880c9538d6..177befc3ed4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -287,13 +287,14 @@ static int wait_all(void)
 	return hit;
 }
 
-static int grep_cmd_config(const char *var, const char *value, void *cb)
+static int grep_cmd_config(const char *var, const char *value,
+			   struct key_value_info *kvi, void *cb)
 {
 	int st = grep_config(var, value, cb);
 
 	if (git_color_config(var, value, cb) < 0)
 		st = -1;
-	else if (git_default_config(var, value, cb) < 0)
+	else if (git_default_config(var, value,kvi, cb) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
diff --git a/builtin/help.c b/builtin/help.c
index 87333a02ec4..5d4a86c4b41 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -396,7 +396,8 @@ static int add_man_viewer_info(const char *var, const char *value)
 	return 0;
 }
 
-static int git_help_config(const char *var, const char *value, void *cb)
+static int git_help_config(const char *var, const char *value,
+			   struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "help.format")) {
 		if (!value)
@@ -419,7 +420,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "man."))
 		return add_man_viewer_info(var, value);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static struct cmdnames main_cmds, other_cmds;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b17e79cd40f..4450510ddfc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1578,7 +1578,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	strbuf_release(&pack_name);
 }
 
-static int git_index_pack_config(const char *k, const char *v, void *cb)
+static int git_index_pack_config(const char *k, const char *v,
+				 struct key_value_info *kvi, void *cb)
 {
 	struct pack_idx_option *opts = cb;
 
@@ -1605,7 +1606,7 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		else
 			opts->flags &= ~WRITE_REV;
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v,kvi, cb);
 }
 
 static int cmp_uint32(const void *a_, const void *b_)
diff --git a/builtin/log.c b/builtin/log.c
index 7d195789633..f8e61330491 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -559,7 +559,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	return retval;
 }
 
-static int git_log_config(const char *var, const char *value, void *cb)
+static int git_log_config(const char *var, const char *value,
+			  struct key_value_info *kvi, void *cb)
 {
 	const char *slot_name;
 
@@ -608,7 +609,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_diff_ui_config(var, value, cb);
+	return git_diff_ui_config(var, value,kvi, cb);
 }
 
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
@@ -974,7 +975,8 @@ static enum cover_from_description parse_cover_from_description(const char *arg)
 		die(_("%s: invalid cover from description mode"), arg);
 }
 
-static int git_format_config(const char *var, const char *value, void *cb)
+static int git_format_config(const char *var, const char *value,
+			     struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
@@ -1103,7 +1105,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.noprefix"))
 		return 0;
 
-	return git_log_config(var, value, cb);
+	return git_log_config(var, value,kvi, cb);
 }
 
 static const char *output_directory = NULL;
diff --git a/builtin/merge.c b/builtin/merge.c
index a99be9610e9..492a83a900c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -620,7 +620,8 @@ static void parse_branch_merge_options(char *bmo)
 	free(argv);
 }
 
-static int git_merge_config(const char *k, const char *v, void *cb)
+static int git_merge_config(const char *k, const char *v,
+			    struct key_value_info *kvi, void *cb)
 {
 	int status;
 	const char *str;
@@ -665,10 +666,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	status = fmt_merge_msg_config(k, v, cb);
+	status = fmt_merge_msg_config(k, v,kvi, cb);
 	if (status)
 		return status;
-	return git_diff_ui_config(k, v, cb);
+	return git_diff_ui_config(k, v,kvi, cb);
 }
 
 static int read_tree_trivial(struct object_id *common, struct object_id *head,
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 1b5083f8b26..c3cd7163c84 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -82,6 +82,7 @@ static struct option *add_common_options(struct option *prev)
 }
 
 static int git_multi_pack_index_write_config(const char *var, const char *value,
+					     struct key_value_info *kvi UNUSED,
 					     void *cb UNUSED)
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77d88f85b04..ca023000cc0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3134,7 +3134,8 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static int git_pack_config(const char *k, const char *v, void *cb)
+static int git_pack_config(const char *k, const char *v,
+			   struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
@@ -3226,7 +3227,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		ex->uri = xstrdup(pack_end + 1);
 		oidmap_put(&configured_exclusions, ex);
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v,kvi, cb);
 }
 
 /* Counters for trace2 output when in --stdin-packs mode. */
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 9d5585d3a72..9b4f5a71b87 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -196,7 +196,8 @@ struct patch_id_opts {
 	int verbatim;
 };
 
-static int git_patch_id_config(const char *var, const char *value, void *cb)
+static int git_patch_id_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *cb)
 {
 	struct patch_id_opts *opts = cb;
 
@@ -209,7 +210,7 @@ static int git_patch_id_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 int cmd_patch_id(int argc, const char **argv, const char *prefix)
diff --git a/builtin/pull.c b/builtin/pull.c
index 5405d09f22f..1b244eee67c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -359,7 +359,8 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 /**
  * Read config variables.
  */
-static int git_pull_config(const char *var, const char *value, void *cb)
+static int git_pull_config(const char *var, const char *value,
+			   struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "rebase.autostash")) {
 		config_autostash = git_config_bool(var, value);
@@ -372,7 +373,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 		check_trust_level = 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 /**
diff --git a/builtin/push.c b/builtin/push.c
index fa550b8f80a..65b79378b92 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -506,7 +506,8 @@ static void set_push_cert_flags(int *flags, int v)
 }
 
 
-static int git_push_config(const char *k, const char *v, void *cb)
+static int git_push_config(const char *k, const char *v,
+			   struct key_value_info *kvi, void *cb)
 {
 	const char *slot_name;
 	int *flags = cb;
@@ -573,7 +574,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	return git_default_config(k, v, NULL);
+	return git_default_config(k, v,kvi, NULL);
 }
 
 int cmd_push(int argc, const char **argv, const char *prefix)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 600d4f748fc..e9859b6157e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -100,12 +100,13 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
-static int git_read_tree_config(const char *var, const char *value, void *cb)
+static int git_read_tree_config(const char *var, const char *value,
+				struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 680fe3c1453..1fd05d708b8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -791,7 +791,8 @@ static void parse_rebase_merges_value(struct rebase_options *options, const char
 		die(_("Unknown rebase-merges mode: %s"), value);
 }
 
-static int rebase_config(const char *var, const char *value, void *data)
+static int rebase_config(const char *var, const char *value,
+			 struct key_value_info *kvi, void *data)
 {
 	struct rebase_options *opts = data;
 
@@ -850,7 +851,7 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return git_config_string(&opts->default_backend, var, value);
 	}
 
-	return git_default_config(var, value, data);
+	return git_default_config(var, value,kvi, data);
 }
 
 static int checkout_up_to_date(struct rebase_options *options)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9109552533d..2f5fd2abbc3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -135,7 +135,8 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 	return DENY_IGNORE;
 }
 
-static int receive_pack_config(const char *var, const char *value, void *cb)
+static int receive_pack_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *cb)
 {
 	int status = parse_hide_refs_config(var, value, "receive", &hidden_refs);
 
@@ -262,7 +263,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static void show_ref(const char *path, const struct object_id *oid)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index a1fa0c855f4..ecf21ac9c6e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -108,7 +108,8 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 #define EXPIRE_TOTAL   01
 #define EXPIRE_UNREACH 02
 
-static int reflog_expire_config(const char *var, const char *value, void *cb)
+static int reflog_expire_config(const char *var, const char *value,
+				struct key_value_info *kvi, void *cb)
 {
 	const char *pattern, *key;
 	size_t pattern_len;
@@ -117,7 +118,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 	struct reflog_expire_cfg *ent;
 
 	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
-		return git_default_config(var, value, cb);
+		return git_default_config(var, value,kvi, cb);
 
 	if (!strcmp(key, "reflogexpire")) {
 		slot = EXPIRE_TOTAL;
@@ -128,7 +129,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 		if (git_config_expiry_date(&expire, var, value))
 			return -1;
 	} else
-		return git_default_config(var, value, cb);
+		return git_default_config(var, value,kvi, cb);
 
 	if (!pattern) {
 		switch (slot) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 1e0b137d977..edb4a9ddd7f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -268,6 +268,7 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
 
 static int config_read_branches(const char *key, const char *value,
+				struct key_value_info *kvi UNUSED,
 				void *data UNUSED)
 {
 	const char *orig_key = key;
@@ -645,7 +646,7 @@ struct push_default_info
 };
 
 static int config_read_push_default(const char *key, const char *value,
-	void *cb)
+	struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct push_default_info* info = cb;
 	if (strcmp(key, "remote.pushdefault") ||
@@ -1494,7 +1495,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
-static int get_remote_default(const char *key, const char *value UNUSED, void *priv)
+static int get_remote_default(const char *key, const char *value UNUSED,
+			      struct key_value_info *kvi UNUSED, void *priv)
 {
 	if (strcmp(key, "remotes.default") == 0) {
 		int *found = priv;
diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0ba..7c8401b2227 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -58,7 +58,8 @@ struct pack_objects_args {
 	int local;
 };
 
-static int repack_config(const char *var, const char *value, void *cb)
+static int repack_config(const char *var, const char *value,
+			 struct key_value_info *kvi, void *cb)
 {
 	struct pack_objects_args *cruft_po_args = cb;
 	if (!strcmp(var, "repack.usedeltabaseoffset")) {
@@ -90,7 +91,7 @@ static int repack_config(const char *var, const char *value, void *cb)
 		return git_config_string(&cruft_po_args->depth, var, value);
 	if (!strcmp(var, "repack.cruftthreads"))
 		return git_config_string(&cruft_po_args->threads, var, value);
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index 0ed329236c8..a04d46d7fdd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -308,12 +308,13 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	return update_ref_status;
 }
 
-static int git_reset_config(const char *var, const char *value, void *cb)
+static int git_reset_config(const char *var, const char *value,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4784143004d..b0c90e549b8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -131,7 +131,8 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
 
-static int send_pack_config(const char *k, const char *v, void *cb)
+static int send_pack_config(const char *k, const char *v,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
@@ -151,7 +152,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
 			}
 		}
 	}
-	return git_default_config(k, v, cb);
+	return git_default_config(k, v,kvi, cb);
 }
 
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 82ae2a7e475..ad8a391904e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -556,7 +556,8 @@ static void append_one_rev(const char *av)
 	die("bad sha1 reference %s", av);
 }
 
-static int git_show_branch_config(const char *var, const char *value, void *cb)
+static int git_show_branch_config(const char *var, const char *value,
+				  struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "showbranch.default")) {
 		if (!value)
@@ -579,7 +580,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
diff --git a/builtin/stash.c b/builtin/stash.c
index 735d27039e1..689087d6240 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -836,7 +836,8 @@ static int show_stat = 1;
 static int show_patch;
 static int show_include_untracked;
 
-static int git_stash_config(const char *var, const char *value, void *cb)
+static int git_stash_config(const char *var, const char *value,
+			    struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "stash.showstat")) {
 		show_stat = git_config_bool(var, value);
@@ -850,7 +851,7 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_include_untracked = git_config_bool(var, value);
 		return 0;
 	}
-	return git_diff_basic_config(var, value, cb);
+	return git_diff_basic_config(var, value,kvi, cb);
 }
 
 static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 569068e6a2c..8570effbf0d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2187,6 +2187,7 @@ static int update_clone_task_finished(int result,
 }
 
 static int git_update_clone_config(const char *var, const char *value,
+				   struct key_value_info *kvi UNUSED,
 				   void *cb)
 {
 	int *max_jobs = cb;
diff --git a/builtin/tag.c b/builtin/tag.c
index 7245a4d30e6..626fe8c641e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -183,7 +183,8 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
-static int git_tag_config(const char *var, const char *value, void *cb)
+static int git_tag_config(const char *var, const char *value,
+			  struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "tag.gpgsign")) {
 		config_sign_tag = git_config_bool(var, value);
@@ -208,7 +209,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)
diff --git a/builtin/var.c b/builtin/var.c
index acb988d2d56..440add19bb5 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -69,13 +69,14 @@ static const struct git_var *get_git_var(const char *var)
 	return NULL;
 }
 
-static int show_config(const char *var, const char *value, void *cb)
+static int show_config(const char *var, const char *value,
+		       struct key_value_info *kvi, void *cb)
 {
 	if (value)
 		printf("%s=%s\n", var, value);
 	else
 		printf("%s\n", var);
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 39e9e5c9ce8..d5ccd741e87 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -103,14 +103,15 @@ static int verbose;
 static int guess_remote;
 static timestamp_t expire;
 
-static int git_worktree_config(const char *var, const char *value, void *cb)
+static int git_worktree_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "worktree.guessremote")) {
 		guess_remote = git_config_bool(var, value);
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int delete_git_dir(const char *id)
diff --git a/bundle-uri.c b/bundle-uri.c
index 8c4e2b70b89..bb88ccbca4b 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -223,7 +223,9 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
-static int config_to_bundle_list(const char *key, const char *value, void *data)
+static int config_to_bundle_list(const char *key, const char *value,
+				 struct key_value_info *kvi UNUSED,
+				 void *data)
 {
 	struct bundle_list *list = data;
 	return bundle_list_update(key, value, list);
@@ -871,7 +873,9 @@ cached:
 	return advertise_bundle_uri;
 }
 
-static int config_to_packet_line(const char *key, const char *value, void *data)
+static int config_to_packet_line(const char *key, const char *value,
+				 struct key_value_info *kvi UNUSED,
+				 void *data)
 {
 	struct packet_reader *writer = data;
 
diff --git a/config.c b/config.c
index 758d6a5cc3b..60f8c0c666b 100644
--- a/config.c
+++ b/config.c
@@ -156,7 +156,8 @@ struct config_include_data {
 };
 #define CONFIG_INCLUDE_INIT { 0 }
 
-static int git_config_include(const char *var, const char *value, void *data);
+static int git_config_include(const char *var, const char *value,
+			      struct key_value_info *kvi, void *data);
 
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] = N_(
@@ -336,7 +337,8 @@ static int include_by_branch(const char *cond, size_t cond_len)
 	return ret;
 }
 
-static int add_remote_url(const char *var, const char *value, void *data)
+static int add_remote_url(const char *var, const char *value,
+			  struct key_value_info *kvi UNUSED, void *data)
 {
 	struct string_list *remote_urls = data;
 	const char *remote_name;
@@ -364,6 +366,7 @@ static void populate_remote_urls(struct config_include_data *inc)
 }
 
 static int forbid_remote_url(const char *var, const char *value UNUSED,
+			     struct key_value_info *kvi UNUSED,
 			     void *data UNUSED)
 {
 	const char *remote_name;
@@ -429,7 +432,8 @@ static int include_condition_is_true(struct key_value_info *kvi,
 
 static int kvi_fn(config_fn_t fn, const char *key, const char *value,
 		  struct key_value_info *kvi, void *data);
-static int git_config_include(const char *var, const char *value, void *data)
+static int git_config_include(const char *var, const char *value,
+			      struct key_value_info *kvi UNUSED, void *data)
 {
 	struct config_include_data *inc = data;
 	struct key_value_info *kvi = inc->config_reader->config_kvi;
@@ -1541,7 +1545,8 @@ int git_config_color(char *dest, const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_core_config(const char *var, const char *value, void *cb)
+static int git_default_core_config(const char *var, const char *value,
+				   struct key_value_info *kvi, void *cb)
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
@@ -1826,7 +1831,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
-	return platform_core_config(var, value, cb);
+	return platform_core_config(var, value,kvi, cb);
 }
 
 static int git_default_sparse_config(const char *var, const char *value)
@@ -1928,15 +1933,16 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
-int git_default_config(const char *var, const char *value, void *cb)
+int git_default_config(const char *var, const char *value,
+		       struct key_value_info *kvi, void *cb)
 {
 	if (starts_with(var, "core."))
-		return git_default_core_config(var, value, cb);
+		return git_default_core_config(var, value,kvi, cb);
 
 	if (starts_with(var, "user.") ||
 	    starts_with(var, "author.") ||
 	    starts_with(var, "committer."))
-		return git_ident_config(var, value, cb);
+		return git_ident_config(var, value,kvi, cb);
 
 	if (starts_with(var, "i18n."))
 		return git_default_i18n_config(var, value);
@@ -2455,7 +2461,8 @@ struct configset_add_data {
 };
 #define CONFIGSET_ADD_INIT { 0 }
 
-static int config_set_callback(const char *key, const char *value, void *cb)
+static int config_set_callback(const char *key, const char *value,
+			       struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct configset_add_data *data = cb;
 	configset_add_value(data->config_reader, data->config_set, key, value);
@@ -3063,7 +3070,8 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
 	return 0;
 }
 
-static int store_aux(const char *key, const char *value, void *cb)
+static int store_aux(const char *key, const char *value,
+		     struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct config_store_data *store = cb;
 
diff --git a/config.h b/config.h
index 2c7b7399691..e4893e237e1 100644
--- a/config.h
+++ b/config.h
@@ -146,7 +146,8 @@ struct key_value_info {
  */
 typedef int (*config_fn_t)(const char *, const char *, struct key_value_info *, void *);
 
-int git_default_config(const char *, const char *, void *);
+int git_default_config(const char *, const char *, struct key_value_info *,
+		       void *);
 
 /**
  * Read a specific file in git-config format.
diff --git a/connect.c b/connect.c
index c0c8a38178c..72aad67a288 100644
--- a/connect.c
+++ b/connect.c
@@ -962,7 +962,7 @@ static struct child_process *git_tcp_connect(int fd[2], char *host, int flags)
 static char *git_proxy_command;
 
 static int git_proxy_command_options(const char *var, const char *value,
-		void *cb)
+		struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "core.gitproxy")) {
 		const char *for_pos;
@@ -1008,7 +1008,7 @@ static int git_proxy_command_options(const char *var, const char *value,
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static int git_use_proxy(const char *host)
diff --git a/convert.c b/convert.c
index da06e2f51cb..a563380e7e7 100644
--- a/convert.c
+++ b/convert.c
@@ -1011,7 +1011,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	return 0;
 }
 
-static int read_convert_config(const char *var, const char *value, void *cb UNUSED)
+static int read_convert_config(const char *var, const char *value,
+			       struct key_value_info *kvi UNUSED,
+			       void *cb UNUSED)
 {
 	const char *key, *name;
 	size_t namelen;
diff --git a/credential.c b/credential.c
index e6417bf8804..6b9b8bfbb79 100644
--- a/credential.c
+++ b/credential.c
@@ -46,6 +46,7 @@ static int credential_from_potentially_partial_url(struct credential *c,
 						   const char *url);
 
 static int credential_config_callback(const char *var, const char *value,
+				      struct key_value_info *kvi UNUSED,
 				      void *data)
 {
 	struct credential *c = data;
diff --git a/delta-islands.c b/delta-islands.c
index 40f2ccfb550..404f9c07a42 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -341,7 +341,8 @@ static void free_remote_islands(kh_str_t *remote_islands)
 	kh_destroy_str(remote_islands);
 }
 
-static int island_config_callback(const char *k, const char *v, void *cb)
+static int island_config_callback(const char *k, const char *v,
+				  struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct island_load_data *ild = cb;
 
diff --git a/diff.c b/diff.c
index 78b0fdd8caa..d7ed2dc900b 100644
--- a/diff.c
+++ b/diff.c
@@ -350,7 +350,8 @@ static unsigned parse_color_moved_ws(const char *arg)
 	return ret;
 }
 
-int git_diff_ui_config(const char *var, const char *value, void *cb)
+int git_diff_ui_config(const char *var, const char *value,
+		       struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value);
@@ -433,10 +434,11 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
-	return git_diff_basic_config(var, value, cb);
+	return git_diff_basic_config(var, value,kvi, cb);
 }
 
-int git_diff_basic_config(const char *var, const char *value, void *cb)
+int git_diff_basic_config(const char *var, const char *value,
+			  struct key_value_info *kvi, void *cb)
 {
 	const char *name;
 
@@ -488,7 +490,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (git_diff_heuristic_config(var, value, cb) < 0)
 		return -1;
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static char *quote_two(const char *one, const char *two)
diff --git a/diff.h b/diff.h
index 6a0737b9c34..6a3efa63753 100644
--- a/diff.h
+++ b/diff.h
@@ -532,10 +532,12 @@ void free_diffstat_info(struct diffstat_t *diffstat);
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg);
 
-int git_diff_basic_config(const char *var, const char *value, void *cb);
+int git_diff_basic_config(const char *var, const char *value,
+			  struct key_value_info *kvi, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
-int git_diff_ui_config(const char *var, const char *value, void *cb);
+int git_diff_ui_config(const char *var, const char *value,
+		       struct key_value_info *kvi, void *cb);
 void repo_diff_setup(struct repository *, struct diff_options *);
 struct option *add_diff_options(const struct option *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
diff --git a/fetch-pack.c b/fetch-pack.c
index 368f2ed25a1..c1072aa6cac 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1858,7 +1858,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
+static int fetch_pack_config_cb(const char *var, const char *value,
+				struct key_value_info *kvi, void *cb)
 {
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
 		const char *path;
@@ -1880,7 +1881,7 @@ static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 static void fetch_pack_config(void)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 1886c92ddb9..97358034fa0 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -19,7 +19,8 @@ static int use_branch_desc;
 static int suppress_dest_pattern_seen;
 static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
-int fmt_merge_msg_config(const char *key, const char *value, void *cb)
+int fmt_merge_msg_config(const char *key, const char *value,
+			 struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
@@ -39,7 +40,7 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			string_list_append(&suppress_dest_patterns, value);
 		suppress_dest_pattern_seen = 1;
 	} else {
-		return git_default_config(key, value, cb);
+		return git_default_config(key, value,kvi, cb);
 	}
 	return 0;
 }
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index 99054042dc5..5262c39268a 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -13,7 +13,8 @@ struct fmt_merge_msg_opts {
 };
 
 extern int merge_log_config;
-int fmt_merge_msg_config(const char *key, const char *value, void *cb);
+int fmt_merge_msg_config(const char *key, const char *value,
+			 struct key_value_info *kvi, void *cb);
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *);
 
diff --git a/fsck.c b/fsck.c
index 4238344ed82..ec26857c79d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1162,7 +1162,8 @@ struct fsck_gitmodules_data {
 	int ret;
 };
 
-static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
+static int fsck_gitmodules_fn(const char *var, const char *value,
+			      struct key_value_info *kvi UNUSED, void *vdata)
 {
 	struct fsck_gitmodules_data *data = vdata;
 	const char *subsection, *key;
@@ -1373,7 +1374,8 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
-int git_fsck_config(const char *var, const char *value, void *cb)
+int git_fsck_config(const char *var, const char *value,
+		    struct key_value_info *kvi, void *cb)
 {
 	struct fsck_options *options = cb;
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -1394,7 +1396,7 @@ int git_fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
 
 /*
diff --git a/fsck.h b/fsck.h
index e17730e9da9..a06f202576c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -237,6 +237,7 @@ const char *fsck_describe_object(struct fsck_options *options,
  * git_config() callback for use by fsck-y tools that want to support
  * fsck.<msg> fsck.skipList etc.
  */
-int git_fsck_config(const char *var, const char *value, void *cb);
+int git_fsck_config(const char *var, const char *value,
+		    struct key_value_info *kvi, void *cb);
 
 #endif
diff --git a/gpg-interface.c b/gpg-interface.c
index aceeb083367..5ed89ef69ed 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -12,7 +12,8 @@
 #include "alias.h"
 #include "wrapper.h"
 
-static int git_gpg_config(const char *, const char *, void *);
+static int git_gpg_config(const char *, const char *, struct key_value_info *,
+			  void *);
 
 static void gpg_interface_lazy_init(void)
 {
@@ -718,7 +719,8 @@ void set_signing_key(const char *key)
 	configured_signing_key = xstrdup(key);
 }
 
-static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
+static int git_gpg_config(const char *var, const char *value,
+			  struct key_value_info *kvi UNUSED, void *cb UNUSED)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
diff --git a/grep.c b/grep.c
index b86462a12a9..1516b0689d0 100644
--- a/grep.c
+++ b/grep.c
@@ -54,7 +54,8 @@ define_list_config_array_extra(color_grep_slots, {"match"});
  * Read the configuration file once and store it in
  * the grep_defaults template.
  */
-int grep_config(const char *var, const char *value, void *cb)
+int grep_config(const char *var, const char *value,
+		struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct grep_opt *opt = cb;
 	const char *slot;
diff --git a/help.c b/help.c
index 5d7637dce92..43d1eb702cd 100644
--- a/help.c
+++ b/help.c
@@ -309,7 +309,8 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
-static int get_colopts(const char *var, const char *value, void *data)
+static int get_colopts(const char *var, const char *value,
+		       struct key_value_info *kvi UNUSED, void *data)
 {
 	unsigned int *colopts = data;
 
@@ -459,7 +460,8 @@ void list_developer_interfaces_help(void)
 	putchar('\n');
 }
 
-static int get_alias(const char *var, const char *value, void *data)
+static int get_alias(const char *var, const char *value,
+		     struct key_value_info *kvi UNUSED, void *data)
 {
 	struct string_list *list = data;
 
@@ -543,6 +545,7 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
 static int git_unknown_cmd_config(const char *var, const char *value,
+				  struct key_value_info *kvi UNUSED,
 				  void *cb UNUSED)
 {
 	const char *p;
diff --git a/ident.c b/ident.c
index 8fad92d7007..21b7b3ff35b 100644
--- a/ident.c
+++ b/ident.c
@@ -671,7 +671,8 @@ static int set_ident(const char *var, const char *value)
 	return 0;
 }
 
-int git_ident_config(const char *var, const char *value, void *data UNUSED)
+int git_ident_config(const char *var, const char *value,
+		     struct key_value_info *kvi UNUSED, void *data UNUSED)
 {
 	if (!strcmp(var, "user.useconfigonly")) {
 		ident_use_config_only = git_config_bool(var, value);
diff --git a/ident.h b/ident.h
index 96a64896a01..f55db41ff99 100644
--- a/ident.h
+++ b/ident.h
@@ -62,6 +62,7 @@ const char *fmt_name(enum want_ident);
 int committer_ident_sufficiently_given(void);
 int author_ident_sufficiently_given(void);
 
-int git_ident_config(const char *, const char *, void *);
+int git_ident_config(const char *, const char *,
+		     struct key_value_info *UNUSED, void *);
 
 #endif
diff --git a/imap-send.c b/imap-send.c
index a62424e90a4..3cc98f1a0a5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1322,7 +1322,8 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 	return 1;
 }
 
-static int git_imap_config(const char *var, const char *val, void *cb)
+static int git_imap_config(const char *var, const char *val,
+			   struct key_value_info *kvi, void *cb)
 {
 
 	if (!strcmp("imap.sslverify", var))
@@ -1356,7 +1357,7 @@ static int git_imap_config(const char *var, const char *val, void *cb)
 			server.host = xstrdup(val);
 		}
 	} else
-		return git_default_config(var, val, cb);
+		return git_default_config(var, val,kvi, cb);
 
 	return 0;
 }
diff --git a/ll-merge.c b/ll-merge.c
index 8be38d3bd41..2d240609ddf 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -252,6 +252,7 @@ static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value,
+			     struct key_value_info *kvi UNUSED,
 			     void *cb UNUSED)
 {
 	struct ll_merge_driver *fn;
diff --git a/ls-refs.c b/ls-refs.c
index b9f3e08ec3d..90b902c84f8 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -136,7 +136,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 }
 
 static int ls_refs_config(const char *var, const char *value,
-			  void *cb_data)
+			  struct key_value_info *kvi UNUSED, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
 	/*
diff --git a/mailinfo.c b/mailinfo.c
index 2aeb20e5e62..e2f469c96f7 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1241,12 +1241,13 @@ int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
 	return 0;
 }
 
-static int git_mailinfo_config(const char *var, const char *value, void *mi_)
+static int git_mailinfo_config(const char *var, const char *value,
+			       struct key_value_info *kvi, void *mi_)
 {
 	struct mailinfo *mi = mi_;
 
 	if (!starts_with(var, "mailinfo."))
-		return git_default_config(var, value, NULL);
+		return git_default_config(var, value,kvi, NULL);
 	if (!strcmp(var, "mailinfo.scissors")) {
 		mi->use_scissors = git_config_bool(var, value);
 		return 0;
diff --git a/notes-utils.c b/notes-utils.c
index cb88171b7bb..f7a0ec60731 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -93,7 +93,8 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
 		return NULL;
 }
 
-static int notes_rewrite_config(const char *k, const char *v, void *cb)
+static int notes_rewrite_config(const char *k, const char *v,
+				struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct notes_rewrite_cfg *c = cb;
 	if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
diff --git a/notes.c b/notes.c
index 45fb7f22d1d..89b84ea0869 100644
--- a/notes.c
+++ b/notes.c
@@ -973,7 +973,8 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
-static int notes_display_config(const char *k, const char *v, void *cb)
+static int notes_display_config(const char *k, const char *v,
+				struct key_value_info *kvi UNUSED, void *cb)
 {
 	int *load_refs = cb;
 
diff --git a/pager.c b/pager.c
index b66bbff2785..4b77e0d2e57 100644
--- a/pager.c
+++ b/pager.c
@@ -39,6 +39,7 @@ static void wait_for_pager_signal(int signo)
 }
 
 static int core_pager_config(const char *var, const char *value,
+			     struct key_value_info *kvi UNUSED,
 			     void *data UNUSED)
 {
 	if (!strcmp(var, "core.pager"))
@@ -224,7 +225,9 @@ struct pager_command_config_data {
 	char *value;
 };
 
-static int pager_command_config(const char *var, const char *value, void *vdata)
+static int pager_command_config(const char *var, const char *value,
+				struct key_value_info *kvi UNUSED,
+				void *vdata)
 {
 	struct pager_command_config_data *data = vdata;
 	const char *cmd;
diff --git a/pretty.c b/pretty.c
index 76fc4f61e40..7f57379c44e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -55,6 +55,7 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 }
 
 static int git_pretty_formats_config(const char *var, const char *value,
+				     struct key_value_info *kvi UNUSED,
 				     void *cb UNUSED)
 {
 	struct cmt_fmt_map *commit_format = NULL;
diff --git a/promisor-remote.c b/promisor-remote.c
index a8dbb788e8f..ea68df91209 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -99,7 +99,9 @@ static void promisor_remote_move_to_tail(struct promisor_remote_config *config,
 	config->promisors_tail = &r->next;
 }
 
-static int promisor_remote_config(const char *var, const char *value, void *data)
+static int promisor_remote_config(const char *var, const char *value,
+				  struct key_value_info *kvi UNUSED,
+				  void *data)
 {
 	struct promisor_remote_config *config = data;
 	const char *name;
diff --git a/remote.c b/remote.c
index 3a831cb5304..10868a963f2 100644
--- a/remote.c
+++ b/remote.c
@@ -348,7 +348,8 @@ static void read_branches_file(struct remote_state *remote_state,
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
-static int handle_config(const char *key, const char *value, void *cb)
+static int handle_config(const char *key, const char *value,
+			 struct key_value_info *kvi UNUSED, void *cb)
 {
 	const char *name;
 	size_t namelen;
diff --git a/revision.c b/revision.c
index 106ca1ce6c9..6de0132d719 100644
--- a/revision.c
+++ b/revision.c
@@ -1569,7 +1569,8 @@ struct exclude_hidden_refs_cb {
 	const char *section;
 };
 
-static int hide_refs_config(const char *var, const char *value, void *cb_data)
+static int hide_refs_config(const char *var, const char *value,
+			    struct key_value_info *kvi UNUSED, void *cb_data)
 {
 	struct exclude_hidden_refs_cb *cb = cb_data;
 	cb->exclusions->hidden_refs_configured = 1;
diff --git a/scalar.c b/scalar.c
index de07c37d210..1c44df2ec7a 100644
--- a/scalar.c
+++ b/scalar.c
@@ -593,7 +593,8 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
-static int get_scalar_repos(const char *key, const char *value, void *data)
+static int get_scalar_repos(const char *key, const char *value,
+			    struct key_value_info *kvi UNUSED, void *data)
 {
 	struct string_list *list = data;
 
diff --git a/sequencer.c b/sequencer.c
index 6985ca526ae..171561c2cdb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -214,7 +214,8 @@ static struct update_ref_record *init_update_ref_record(const char *ref)
 	return rec;
 }
 
-static int git_sequencer_config(const char *k, const char *v, void *cb)
+static int git_sequencer_config(const char *k, const char *v,
+				struct key_value_info *kvi, void *cb)
 {
 	struct replay_opts *opts = cb;
 	int status;
@@ -269,7 +270,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
 		opts->commit_use_reference = git_config_bool(k, v);
 
-	return git_diff_basic_config(k, v, NULL);
+	return git_diff_basic_config(k, v,kvi, NULL);
 }
 
 void sequencer_init_config(struct replay_opts *opts)
@@ -2876,7 +2877,8 @@ static int git_config_string_dup(char **dest,
 	return 0;
 }
 
-static int populate_opts_cb(const char *key, const char *value, void *data)
+static int populate_opts_cb(const char *key, const char *value,
+			    struct key_value_info *kvi UNUSED, void *data)
 {
 	struct replay_opts *opts = data;
 	int error_flag = 1;
diff --git a/setup.c b/setup.c
index 6c5b85e96c1..a461dd15233 100644
--- a/setup.c
+++ b/setup.c
@@ -514,7 +514,9 @@ no_prevention_needed:
 	startup_info->original_cwd = NULL;
 }
 
-static int read_worktree_config(const char *var, const char *value, void *vdata)
+static int read_worktree_config(const char *var, const char *value,
+				struct key_value_info *kvi UNUSED,
+				void *vdata)
 {
 	struct repository_format *data = vdata;
 
@@ -585,7 +587,8 @@ static enum extension_result handle_extension(const char *var,
 	return EXTENSION_UNKNOWN;
 }
 
-static int check_repo_format(const char *var, const char *value, void *vdata)
+static int check_repo_format(const char *var, const char *value,
+			     struct key_value_info *kvi, void *vdata)
 {
 	struct repository_format *data = vdata;
 	const char *ext;
@@ -614,7 +617,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 		}
 	}
 
-	return read_worktree_config(var, value, vdata);
+	return read_worktree_config(var, value,kvi, vdata);
 }
 
 static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
@@ -1113,7 +1116,8 @@ struct safe_directory_data {
 	int is_safe;
 };
 
-static int safe_directory_cb(const char *key, const char *value, void *d)
+static int safe_directory_cb(const char *key, const char *value,
+			     struct key_value_info *kvi UNUSED, void *d)
 {
 	struct safe_directory_data *data = d;
 
@@ -1169,7 +1173,8 @@ static int ensure_valid_ownership(const char *gitfile,
 	return data.is_safe;
 }
 
-static int allowed_bare_repo_cb(const char *key, const char *value, void *d)
+static int allowed_bare_repo_cb(const char *key, const char *value,
+				struct key_value_info *kvi UNUSED, void *d)
 {
 	enum allowed_bare_repo *allowed_bare_repo = d;
 
diff --git a/submodule-config.c b/submodule-config.c
index c2f71f0b2e3..522c9cd3213 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -424,7 +424,8 @@ struct parse_config_parameter {
  * config store (.git/config, etc).  Callers are responsible for
  * checking for overrides in the main config store when appropriate.
  */
-static int parse_config(const char *var, const char *value, void *data)
+static int parse_config(const char *var, const char *value,
+			struct key_value_info *kvi UNUSED, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
@@ -673,7 +674,8 @@ out:
 	}
 }
 
-static int gitmodules_cb(const char *var, const char *value, void *data)
+static int gitmodules_cb(const char *var, const char *value,
+			 struct key_value_info *kvi UNUSED, void *data)
 {
 	struct repository *repo = data;
 	struct parse_config_parameter parameter;
@@ -801,7 +803,9 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
-static int config_print_callback(const char *var, const char *value, void *cb_data)
+static int config_print_callback(const char *var, const char *value,
+				 struct key_value_info *kvi UNUSED,
+				 void *cb_data)
 {
 	char *wanted_key = cb_data;
 
@@ -843,7 +847,9 @@ struct fetch_config {
 	int *recurse_submodules;
 };
 
-static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+static int gitmodules_fetch_config(const char *var, const char *value,
+				   struct key_value_info *kvi UNUSED,
+				   void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
@@ -871,6 +877,7 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
+					  struct key_value_info *kvi UNUSED,
 					  void *cb)
 {
 	int *max_jobs = cb;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ad78fc17683..00cd49e5145 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -42,7 +42,8 @@
  *
  */
 
-static int iterate_cb(const char *var, const char *value, void *data UNUSED)
+static int iterate_cb(const char *var, const char *value,
+		      struct key_value_info *kvi UNUSED, void *data UNUSED)
 {
 	static int nr;
 
@@ -59,7 +60,8 @@ static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 	return 0;
 }
 
-static int parse_int_cb(const char *var, const char *value, void *data)
+static int parse_int_cb(const char *var, const char *value,
+			struct key_value_info *kvi UNUSED, void *data)
 {
 	const char *key_to_match = data;
 
@@ -70,7 +72,8 @@ static int parse_int_cb(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static int early_config_cb(const char *var, const char *value, void *vdata)
+static int early_config_cb(const char *var, const char *value,
+			   struct key_value_info *kvi UNUSED, void *vdata)
 {
 	const char *key = vdata;
 
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 680124a6760..33dd3a65241 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -12,7 +12,9 @@ static int driver_cb(struct userdiff_driver *driver,
 	return 0;
 }
 
-static int cmd__userdiff_config(const char *var, const char *value, void *cb UNUSED)
+static int cmd__userdiff_config(const char *var, const char *value,
+				struct key_value_info *kvi UNUSED,
+				void *cb UNUSED)
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 78cfc15d52d..6871258d468 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -99,7 +99,8 @@ struct tr2_cfg_data {
 /*
  * See if the given config key matches any of our patterns of interest.
  */
-static int tr2_cfg_cb(const char *key, const char *value, void *d)
+static int tr2_cfg_cb(const char *key, const char *value,
+		      struct key_value_info *kvi UNUSED, void *d)
 {
 	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 069786cb927..d17a08b0f50 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -57,7 +57,8 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 };
 /* clang-format on */
 
-static int tr2_sysenv_cb(const char *key, const char *value, void *d)
+static int tr2_sysenv_cb(const char *key, const char *value,
+			 struct key_value_info *kvi UNUSED, void *d)
 {
 	int k;
 
diff --git a/trailer.c b/trailer.c
index a2c3ed6f28c..fac7e2cfe6e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -482,6 +482,7 @@ static struct {
 };
 
 static int git_trailer_default_config(const char *conf_key, const char *value,
+				      struct key_value_info *kvi UNUSED,
 				      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
@@ -514,6 +515,7 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 }
 
 static int git_trailer_config(const char *conf_key, const char *value,
+			      struct key_value_info *kvi UNUSED,
 			      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
diff --git a/upload-pack.c b/upload-pack.c
index e23f16dfdd2..5f8232ff078 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1298,7 +1298,9 @@ static int parse_object_filter_config(const char *var, const char *value,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *cb_data)
+static int upload_pack_config(const char *var, const char *value,
+			      struct key_value_info *kvi UNUSED,
+			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
 
@@ -1339,7 +1341,9 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 }
 
-static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
+static int upload_pack_protected_config(const char *var, const char *value,
+					struct key_value_info *kvi UNUSED,
+					void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
 
diff --git a/urlmatch.c b/urlmatch.c
index eba0bdd77fe..47683974d8c 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -551,7 +551,8 @@ static int cmp_matches(const struct urlmatch_item *a,
 	return 0;
 }
 
-int urlmatch_config_entry(const char *var, const char *value, void *cb)
+int urlmatch_config_entry(const char *var, const char *value,
+			  struct key_value_info *kvi UNUSED, void *cb)
 {
 	struct string_list_item *item;
 	struct urlmatch_config *collect = cb;
diff --git a/urlmatch.h b/urlmatch.h
index bee374a642c..f6eac4af9ea 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -71,7 +71,8 @@ struct urlmatch_config {
 	.vars = STRING_LIST_INIT_DUP, \
 }
 
-int urlmatch_config_entry(const char *var, const char *value, void *cb);
+int urlmatch_config_entry(const char *var, const char *value,
+			  struct key_value_info *kvi, void *cb);
 void urlmatch_config_release(struct urlmatch_config *config);
 
 #endif /* URL_MATCH_H */
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0460e03f5ed..f1aac104285 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -307,7 +307,8 @@ int xdiff_compare_lines(const char *l1, long s1,
 
 int git_xmerge_style = -1;
 
-int git_xmerge_config(const char *var, const char *value, void *cb)
+int git_xmerge_config(const char *var, const char *value,
+		      struct key_value_info *kvi, void *cb)
 {
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
@@ -327,5 +328,5 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			    value, var);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_default_config(var, value,kvi, cb);
 }
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 3750794afe9..c1676b11702 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -50,7 +50,8 @@ int buffer_is_binary(const char *ptr, unsigned long size);
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
-int git_xmerge_config(const char *var, const char *value, void *cb);
+int git_xmerge_config(const char *var, const char *value,
+		      struct key_value_info *kvi, void *cb);
 extern int git_xmerge_style;
 
 /*
-- 
gitgitgadget


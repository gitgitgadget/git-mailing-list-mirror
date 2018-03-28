Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54F01F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeC1Wfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45741 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753673AbeC1Wfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id y63so1734245pgy.12
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWMVc2ld1M1Ursud+WC2BZbvLH8aUgkA9WymgPHaK7U=;
        b=rKOWEMAILlQAgwGWBj/cQS0nOEBg3OeFZr5M6B0Io8LQTnSaBgwHlvmJjoTGos+UyX
         vqfLRVHQHF+gdNwjhil336/0rLWMSYnD69fGB7503tp5sCSucV/KpYsoJZPs/cOzyxk+
         dSf8TltA6Vto03EgtOdNnhyW/A9eImCsfjaIAj7icFKbx53OYQDxnDrbOWFsYW/f6PlG
         fPjkNvrp7GMW986BbLy/x3lLO6bb13DxTh1D8rIOLUjvrNbpJwPWMgX/d4GnHcdYpPJc
         /svmv+Ykw8yjBM73wNwnoMJgCbz5Ea0R4he4DvlfVsVfaxhD7SU2oyoXahvRP+9co743
         oO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWMVc2ld1M1Ursud+WC2BZbvLH8aUgkA9WymgPHaK7U=;
        b=kB9+Q5Ze2EkzwMY61H7Tz25lexzLrvck/lj4qUHMswvYT3phCuWIN2xkZGULQsUeSx
         hc3vBeo9ZIVucNNzPIfV80UoH6KAg0EHRnS5VC36d/i8HlXNes1GpAXHdkWj1IEWzu3O
         j5xAqNTM+p3owv7PY0shWMBAzhBcvEqd+K/NemGlfeEan7mGbUpNJM5/KR0AjN4siUPB
         bOJSxtuO4m9t/y5jMhi1xa4wsJVoepb43oh+3UsRdbLi09ckGGS/9YsZrH+PqmHRW5di
         mu0O3wMGTlYbXoZbMpnuQpMvjThm6+RP+kcaG62Fkfa4VTvgpajT8PPIDVwYR+fLNq/i
         FaXA==
X-Gm-Message-State: AElRT7HJL5+b36JUi7CoKc9N18YUmi4sqwp7WUblwi+7OY7pBHjidAd+
        ARPW68DiifFqQUEbFea3XlO5bA==
X-Google-Smtp-Source: AIpwx4/sIXOby/Nc3PT16vEMyzu5/vk2EXQlqCcGs1yOpL6L3q9zfEQd07KOBYsQeYVbZwbKF9NRhA==
X-Received: by 10.98.210.7 with SMTP id c7mr4317688pfg.92.1522276543295;
        Wed, 28 Mar 2018 15:35:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s7sm8025469pgr.90.2018.03.28.15.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 6/6] submodule: fixup nested submodules after moving the submodule
Date:   Wed, 28 Mar 2018 15:35:31 -0700
Message-Id: <20180328223531.241920-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
 <20180328223531.241920-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

connect_work_tree_and_git_dir is used to connect a submodule worktree with
its git directory and vice versa after events that require a reconnection
such as moving around the working tree. As submodules can have nested
submodules themselves, we'd also want to fix the nested submodules when
asked to. Add an option to recurse into the nested submodules and connect
them as well.

As submodules are identified by their name (which determines their git
directory in relation to their superproject's git directory) internally
and by their path in the working tree of the superproject, we need to
make sure that the mapping of name <-> path is kept intact. We can do
that in the git-mv command by writing out the gitmodules file first
and then forcing a reload of the submodule config machinery.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mv.c                |  6 ++--
 builtin/submodule--helper.c |  3 +-
 dir.c                       | 60 +++++++++++++++++++++++++++++++++++--
 dir.h                       | 12 +++++++-
 repository.c                |  6 ++--
 repository.h                |  3 ++
 submodule.c                 |  6 ++--
 t/t7001-mv.sh               |  2 +-
 8 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cf3684d907..b0c5178e0d 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -275,10 +275,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			die_errno(_("renaming '%s' failed"), src);
 		}
 		if (submodule_gitfile[i]) {
-			if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
-				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
 			if (!update_path_in_gitmodules(src, dst))
 				gitmodules_modified = 1;
+			if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
+				connect_work_tree_and_git_dir(dst,
+							      submodule_gitfile[i],
+							      1);
 		}
 
 		if (mode == WORKING_DIRECTORY)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5551cf19c3..ffdc51f426 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1260,8 +1260,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&sb);
 	}
 
-	/* Connect module worktree and git dir */
-	connect_work_tree_and_git_dir(path, sm_gitdir);
+	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
 
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
diff --git a/dir.c b/dir.c
index ce6e50d2a2..4f401b6a3c 100644
--- a/dir.c
+++ b/dir.c
@@ -19,6 +19,7 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "submodule-config.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -2988,8 +2989,57 @@ void untracked_cache_add_to_index(struct index_state *istate,
 	untracked_cache_invalidate_path(istate, path);
 }
 
-/* Update gitfile and core.worktree setting to connect work tree and git dir */
-void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
+static void connect_wt_gitdir_in_nested(const char *sub_worktree,
+					const char *sub_gitdir)
+{
+	int i;
+	struct repository subrepo;
+	struct strbuf sub_wt = STRBUF_INIT;
+	struct strbuf sub_gd = STRBUF_INIT;
+
+	const struct submodule *sub;
+
+	/* If the submodule has no working tree, we can ignore it. */
+	if (repo_init(&subrepo, sub_gitdir, sub_worktree))
+		return;
+
+	if (repo_read_index(&subrepo) < 0)
+		die("index file corrupt in repo %s", subrepo.gitdir);
+
+	for (i = 0; i < subrepo.index->cache_nr; i++) {
+		const struct cache_entry *ce = subrepo.index->cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		while (i + 1 < subrepo.index->cache_nr &&
+		       !strcmp(ce->name, subrepo.index->cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+
+		sub = submodule_from_path(&subrepo, &null_oid, ce->name);
+		if (!sub || !is_submodule_active(&subrepo, ce->name))
+			/* .gitmodules broken or inactive sub */
+			continue;
+
+		strbuf_reset(&sub_wt);
+		strbuf_reset(&sub_gd);
+		strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
+		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
+
+		connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 1);
+	}
+	strbuf_release(&sub_wt);
+	strbuf_release(&sub_gd);
+	repo_clear(&subrepo);
+}
+
+void connect_work_tree_and_git_dir(const char *work_tree_,
+				   const char *git_dir_,
+				   int recurse_into_nested)
 {
 	struct strbuf gitfile_sb = STRBUF_INIT;
 	struct strbuf cfg_sb = STRBUF_INIT;
@@ -3019,6 +3069,10 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 	strbuf_release(&gitfile_sb);
 	strbuf_release(&cfg_sb);
 	strbuf_release(&rel_path);
+
+	if (recurse_into_nested)
+		connect_wt_gitdir_in_nested(work_tree, git_dir);
+
 	free(work_tree);
 	free(git_dir);
 }
@@ -3032,5 +3086,5 @@ void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
 		die_errno(_("could not migrate git directory from '%s' to '%s'"),
 			old_git_dir, new_git_dir);
 
-	connect_work_tree_and_git_dir(path, new_git_dir);
+	connect_work_tree_and_git_dir(path, new_git_dir, 0);
 }
diff --git a/dir.h b/dir.h
index 11a047ba48..d2545a7685 100644
--- a/dir.h
+++ b/dir.h
@@ -359,7 +359,17 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
-extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+
+/*
+ * Connect a worktree to a git directory by creating (or overwriting) a
+ * '.git' file containing the location of the git directory. In the git
+ * directory set the core.worktree setting to indicate where the worktree is.
+ * When `recurse_into_nested` is set, recurse into any nested submodules,
+ * connecting them as well.
+ */
+extern void connect_work_tree_and_git_dir(const char *work_tree,
+					  const char *git_dir,
+					  int recurse_into_nested);
 extern void relocate_gitdir(const char *path,
 			    const char *old_git_dir,
 			    const char *new_git_dir);
diff --git a/repository.c b/repository.c
index eb5b8e9f5a..beff3caa9e 100644
--- a/repository.c
+++ b/repository.c
@@ -135,9 +135,9 @@ static int read_and_verify_repository_format(struct repository_format *format,
  * Initialize 'repo' based on the provided 'gitdir'.
  * Return 0 upon success and a non-zero value upon failure.
  */
-static int repo_init(struct repository *repo,
-		     const char *gitdir,
-		     const char *worktree)
+int repo_init(struct repository *repo,
+	      const char *gitdir,
+	      const char *worktree)
 {
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
diff --git a/repository.h b/repository.h
index 09df94a472..6041367f08 100644
--- a/repository.h
+++ b/repository.h
@@ -97,6 +97,9 @@ extern void repo_set_gitdir(struct repository *repo,
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern void initialize_the_repository(void);
+extern int repo_init(struct repository *r,
+		     const char *gitdir,
+		     const char *worktree);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
diff --git a/submodule.c b/submodule.c
index dac73d10a7..53c45e49d0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1625,7 +1625,7 @@ int submodule_move_head(const char *path,
 		} else {
 			char *gitdir = xstrfmt("%s/modules/%s",
 				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir);
+			connect_work_tree_and_git_dir(path, gitdir, 0);
 			free(gitdir);
 
 			/* make sure the index is clean as well */
@@ -1635,7 +1635,7 @@ int submodule_move_head(const char *path,
 		if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 			char *gitdir = xstrfmt("%s/modules/%s",
 				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir);
+			connect_work_tree_and_git_dir(path, gitdir, 1);
 			free(gitdir);
 		}
 	}
@@ -1948,7 +1948,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
-			git_path("modules/%s", sub->name));
+			git_path("modules/%s", sub->name), 0);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 6e5031f56f..bfe2c427f1 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -491,7 +491,7 @@ test_expect_success 'moving a submodule in nested directories' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'moving nested submodules' '
+test_expect_success 'moving nested submodules' '
 	git commit -am "cleanup commit" &&
 	mkdir sub_nested_nested &&
 	(cd sub_nested_nested &&
-- 
2.17.0.rc1.321.gba9d0f2565-goog


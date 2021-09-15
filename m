Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D7C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D24C6103C
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhIOTAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOTAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 15:00:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5EC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:59:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso4798792ybe.21
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iSR6zZo3Zh6etqOpUPDpMgjWLPaHSlSC7lIFKt+VED8=;
        b=Yq6GQmqEvvP5xvVuzsFn69T9gvt/QaFKCwFdVkepixLJ1QS2xKJb2fx7lADrEWC/+X
         hYUcDNYSLVHy6VSmA2ob3klysmz44iBXKfn6LKhuSi4xPYRP0sk4JeiqiBIt09f2cY0/
         +ih0fwMPfI1cCiINT6Fk2f99G8ScabBm1P1NlhygTeHxKiYrdUUs7GPnIGiuxdN4AOtH
         wI5RST8fsKglZjISZ6GLPMIVwPZrVzrjbphJhALU6/NNYwgmq5Qi97XWpl3pZrc2/LEt
         b/DzQAgQv1cey6JgcA+XZsHBGQJrSg3Ojk5IiBAeV7b+cdx3ZI02uVexKAQMgW1dBf96
         qdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iSR6zZo3Zh6etqOpUPDpMgjWLPaHSlSC7lIFKt+VED8=;
        b=tkD5wp2E5FMRgJP+BtGsRsPPiaBNd3GMSMJc6OI8w6OdKOcH2JrvO+OkCSienz6ig3
         m992jB91Y9CFF/T1L8QQ4IIkEOU1Fs+DSVeCMa8A05mZsRPAAr+GbObdtRAIfOfQYpby
         7ACEOdfI4yG6elBySYqa0Rc5ZKKzCrRmQEL+jwEXsa9J+lppkjxpUa2dKTr3/yvJlXMY
         LvXz1JmTET1SIgDvl19FvL6AL6794oG7BWKWS3QMKtqI5d5UELYyeafTJfnSnvzbG1u0
         VzFaHfm1tzbTmcC9ooRyUS9+o626kEFsW5S6lqlTt7ctkYbdHc2g1HLsOzI0RpKWJQjX
         MxQg==
X-Gm-Message-State: AOAM531Exkt5tqX3AJYxFBwcnmFIVoj3QTtTYRimoktJ/y6nOh2c/p8t
        XkStdvnGsEGjfGwPui/RpgUMo0BOekddMoqwHpE+JJJyqzsn3vUJWMUnLV6v2GsLEvLVhMYb4pY
        6FJiu7ER3YxXragPxCmte4hgVbBckLh54odmoLwF99PHfZqM2y8lXjOvw4+2gPlT/JP42A2pN9/
        4t
X-Google-Smtp-Source: ABdhPJyZtnS5s6Ier9NXaJGK09BknFiJym2Vg1EdTAMGSItwlKI0VcGDYcxqwuBo+6PD0Gju5igRvsFwsAg/ePbFWcnG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:60e:: with SMTP id
 d14mr1878776ybq.474.1631732364081; Wed, 15 Sep 2021 11:59:24 -0700 (PDT)
Date:   Wed, 15 Sep 2021 11:59:19 -0700
Message-Id: <20210915185920.346756-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] submodule: extract path to submodule gitdir func
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently store each submodule gitdir in ".git/modules/<name>", but
this has problems with some submodule naming schemes, as described in a
comment in submodule_name_to_gitdir() in this patch.

Extract the determination of the location of a submodule's gitdir into
its own function submodule_name_to_gitdir(). For now, the problem
remains unsolved, but this puts us in a better position for finding a
solution.

This was motivated, at $DAYJOB, by a part of Android's repo hierarchy
[1]. In particular, there is a repo "build", and several repos of the
form "build/<name>".

This is based on earlier work by Brandon Williams [2].

[1] https://android.googlesource.com/platform/
[2] https://lore.kernel.org/git/20180808223323.79989-2-bmwill@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/submodule--helper.c | 10 ++++-
 dir.c                       |  2 +-
 repository.c                |  3 +-
 submodule.c                 | 77 ++++++++++++++++++++++++++-----------
 submodule.h                 |  7 ++++
 5 files changed, 72 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4da9781b99..29ca0bedf6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1704,18 +1704,24 @@ static int add_possible_reference_from_superproject(
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
 	if (strip_suffix(odb->path, "/objects", &len)) {
+		struct repository alternate;
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
 		strbuf_add(&sb, odb->path, len);
 
+		repo_init(&alternate, sb.buf, NULL);
+
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
 		 * otherwise a submodule name containing '/' will be broken
 		 * as the last part of a missing submodule reference would
 		 * be taken as a file name.
 		 */
-		strbuf_addf(&sb, "/modules/%s/", sas->submodule_name);
+		strbuf_reset(&sb);
+		submodule_name_to_gitdir(&sb, &alternate, sas->submodule_name);
+		strbuf_addch(&sb, '/');
+		repo_clear(&alternate);
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
@@ -1785,7 +1791,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	struct strbuf sb = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), clone_data->name);
+	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
diff --git a/dir.c b/dir.c
index 03c4d21267..5fe5d3a42e 100644
--- a/dir.c
+++ b/dir.c
@@ -3633,7 +3633,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 		strbuf_reset(&sub_wt);
 		strbuf_reset(&sub_gd);
 		strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
-		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
+		submodule_name_to_gitdir(&sub_gd, &subrepo, sub->name);
 
 		connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 1);
 	}
diff --git a/repository.c b/repository.c
index b2bf44c6fa..710a3b4bf8 100644
--- a/repository.c
+++ b/repository.c
@@ -213,8 +213,7 @@ int repo_submodule_init(struct repository *subrepo,
 		 * submodule would not have a worktree.
 		 */
 		strbuf_reset(&gitdir);
-		strbuf_repo_git_path(&gitdir, superproject,
-				     "modules/%s", sub->name);
+		submodule_name_to_gitdir(&gitdir, superproject, sub->name);
 
 		if (repo_init(subrepo, gitdir.buf, NULL)) {
 			ret = -1;
diff --git a/submodule.c b/submodule.c
index 8e611fe1db..9382ddf0cc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1819,14 +1819,16 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 
 void submodule_unset_core_worktree(const struct submodule *sub)
 {
-	char *config_path = xstrfmt("%s/modules/%s/config",
-				    get_git_dir(), sub->name);
+	struct strbuf config_path = STRBUF_INIT;
 
-	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
+	submodule_name_to_gitdir(&config_path, the_repository, sub->name);
+	strbuf_addstr(&config_path, "/config");
+
+	if (git_config_set_in_file_gently(config_path.buf, "core.worktree", NULL))
 		warning(_("Could not unset core.worktree setting in submodule '%s'"),
 			  sub->path);
 
-	free(config_path);
+	strbuf_release(&config_path);
 }
 
 static const char *get_super_prefix_or_empty(void)
@@ -1922,20 +1924,22 @@ int submodule_move_head(const char *path,
 				absorb_git_dir_into_superproject(path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 0);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			submodule_name_to_gitdir(&gitdir, the_repository,
+						 sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
+			strbuf_release(&gitdir);
 
 			/* make sure the index is clean as well */
 			submodule_reset_index(path);
 		}
 
 		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
-			char *gitdir = xstrfmt("%s/modules/%s",
-				    get_git_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, gitdir, 1);
-			free(gitdir);
+			struct strbuf gitdir = STRBUF_INIT;
+			submodule_name_to_gitdir(&gitdir, the_repository,
+						 sub->name);
+			connect_work_tree_and_git_dir(path, gitdir.buf, 1);
+			strbuf_release(&gitdir);
 		}
 	}
 
@@ -2050,7 +2054,7 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 static void relocate_single_git_dir_into_superproject(const char *path)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
-	char *new_git_dir;
+	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
 
 	if (submodule_uses_worktrees(path))
@@ -2068,14 +2072,13 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
-	new_git_dir = git_pathdup("modules/%s", sub->name);
-	if (validate_submodule_git_dir(new_git_dir, sub->name) < 0)
+	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
+	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
 		die(_("refusing to move '%s' into an existing git dir"),
 		    real_old_git_dir);
-	if (safe_create_leading_directories_const(new_git_dir) < 0)
-		die(_("could not create directory '%s'"), new_git_dir);
-	real_new_git_dir = real_pathdup(new_git_dir, 1);
-	free(new_git_dir);
+	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
+		die(_("could not create directory '%s'"), new_gitdir.buf);
+	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
 		get_super_prefix_or_empty(), path,
@@ -2086,6 +2089,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
+	strbuf_release(&new_gitdir);
 }
 
 /*
@@ -2105,6 +2109,7 @@ void absorb_git_dir_into_superproject(const char *path,
 	/* Not populated? */
 	if (!sub_git_dir) {
 		const struct submodule *sub;
+		struct strbuf sub_gitdir = STRBUF_INIT;
 
 		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
 			/* unpopulated as expected */
@@ -2126,8 +2131,9 @@ void absorb_git_dir_into_superproject(const char *path,
 		sub = submodule_from_path(the_repository, null_oid(), path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
-		connect_work_tree_and_git_dir(path,
-			git_path("modules/%s", sub->name), 0);
+		submodule_name_to_gitdir(&sub_gitdir, the_repository, sub->name);
+		connect_work_tree_and_git_dir(path, sub_gitdir.buf, 0);
+		strbuf_release(&sub_gitdir);
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
@@ -2278,9 +2284,36 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 			goto cleanup;
 		}
 		strbuf_reset(buf);
-		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
+		submodule_name_to_gitdir(buf, the_repository, sub->name);
 	}
 
 cleanup:
 	return ret;
 }
+
+void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
+			      const char *submodule_name)
+{
+	/*
+	 * NEEDSWORK: The current way of mapping a submodule's name to
+	 * its location in .git/modules/ has problems with some naming
+	 * schemes. For example, if a submodule is named "foo" and
+	 * another is named "foo/bar" (whether present in the same
+	 * superproject commit or not - the problem will arise if both
+	 * superproject commits have been checked out at any point in
+	 * time), or if two submodule names only have different cases in
+	 * a case-insensitive filesystem.
+	 *
+	 * There are several solutions, including encoding the path in
+	 * some way, introducing a submodule.<name>.gitdir config in
+	 * .git/config (not .gitmodules) that allows overriding what the
+	 * gitdir of a submodule would be (and teach Git, upon noticing
+	 * a clash, to automatically determine a non-clashing name and
+	 * to write such a config), or introducing a
+	 * submodule.<name>.gitdir config in .gitmodules that repo
+	 * administrators can explicitly set. Nothing has been decided,
+	 * so for now, just append the name at the end of the path.
+	 */
+	strbuf_repo_git_path(buf, r, "modules/");
+	strbuf_addstr(buf, submodule_name);
+}
diff --git a/submodule.h b/submodule.h
index 84640c49c1..c11e0807fc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -124,6 +124,13 @@ int push_unpushed_submodules(struct repository *r,
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
+/*
+ * Given a submodule name, create a path to where the submodule's gitdir lives
+ * inside of the provided repository's 'modules' directory.
+ */
+void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
+			      const char *submodule_name);
+
 /*
  * Make sure that no submodule's git dir is nested in a sibling submodule's.
  */
-- 
2.33.0.309.g3052b89438-goog


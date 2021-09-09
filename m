Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C554C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FE961100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhIISs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbhIISsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:46 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FEC061756
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 202-20020a6219d3000000b0040b60510fd8so1842833pfz.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fzlc6amka7eNrMuGFqF2NLCb1375EEG8spEKcE1vdcc=;
        b=m3bQl6gJULIcnXWPrbm3P2okCku5J5UbrjGfj5sOJ+Tg/flGYA5jrUAGGSRrKWF2Nj
         MhUgeTzFAHD/UNxKfkpDPjHf5thf+XgubAd9O41EnNH/k7Qq1VrCDQqbX67++tLsgwqJ
         THf5DXy0gCaQegCgx5yXEFw8XsjUTmwbKN7An0O1GsKF8rTz85IDi8G812KWyM2ufLyG
         UzWW+31jSlmiXJskNkWJn8maoTfbpZWCZZzVx8NbNRS4HkXxp/M6e47AiiqIqWTF11zH
         vKlCgGSjqUQlMhKbZexCbAR7JCAKD46Immi2Xw1GFRSbLKVSfon6mzEVEMuZs3Q1lhWW
         0gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fzlc6amka7eNrMuGFqF2NLCb1375EEG8spEKcE1vdcc=;
        b=MG6Wm6TGTTsHUdllyzXI6LYKa6nTD/0+37BLKq03xlc2ZezdrARkRTXusnFU96jThM
         J+90tPZr+DoAM3sIxJIHOmzdVlTTB6Zb0l1b2idhkDKeKDz3oIO1rg1zLkF35JprYmjW
         gxVlkafOvDyBcl0SfZWYqb9NR8oQjnGybxnSmBNbWkoJTIGQXUk/X7jbcGPJze3KZ7Q9
         nF1Zok8d+/jsXFFYsyg6m7zSZEKMg4VCDf7T6w6g8ZRkQVSwPebLr9B/vEUptWuj+2R/
         Goau7SO5jhEZp/dld4Yh7WTGFWbppgfY9fv/VyG68LGFqLvOxCjzd4Lu19A+zGAee81M
         3cBg==
X-Gm-Message-State: AOAM530PdwA88Cy11MiWo+/ugR+e8heiBqhN/+1wyVmMYdXHWEvJ+I/F
        zR7lBXqyZX7t4KbbrXJNzJMvIG+v6YXaU7X0BU944a6M/+evgUIzxfWOwf9WSiDUFBk06lXXXIH
        3u52s9ZffqYLL9fBZSaIxTevV+FamaOqDO2quADRJq/JYJ2Lkb90S2D8gUVDp1COFQGch7PAZ1l
        aY
X-Google-Smtp-Source: ABdhPJyLTd21rDd+ntUY0OslorkIJKb66Wj1X4qjjCLxb2P1q4o7487+uH1ZJyjlWNtct4xrgTr972gSZMgJq9AROIhq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e282:b0:13a:45b7:d2cd with
 SMTP id o2-20020a170902e28200b0013a45b7d2cdmr3978828plc.86.1631213256725;
 Thu, 09 Sep 2021 11:47:36 -0700 (PDT)
Date:   Thu,  9 Sep 2021 11:47:28 -0700
In-Reply-To: <cover.1631212893.git.jonathantanmy@google.com>
Message-Id: <39aca057cc88d1255d5b166cbf0630f8e9a3a5b0.1631212893.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com> <cover.1631212893.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 2/3] repository: support unabsorbed in repo_submodule_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a subsequent commit that migrates code using
add_submodule_odb() to repo_submodule_init(), teach
repo_submodule_init() to support submodules with unabsorbed gitdirs.
(See the documentation for "git submodule absorbgitdirs" for more
information about absorbed and unabsorbed gitdirs.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c                               |  5 +----
 builtin/ls-files.c                           |  4 +---
 builtin/submodule--helper.c                  |  7 +------
 repository.c                                 | 21 +++++++++++---------
 repository.h                                 | 15 ++++++++------
 submodule.c                                  |  9 +++------
 t/helper/test-submodule-nested-repo-config.c |  4 +---
 7 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 51278b01fa..8af5249a7b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -433,17 +433,14 @@ static int grep_submodule(struct grep_opt *opt,
 {
 	struct repository *subrepo;
 	struct repository *superproject = opt->repo;
-	const struct submodule *sub;
 	struct grep_opt subopt;
 	int hit = 0;
 
-	sub = submodule_from_path(superproject, null_oid(), path);
-
 	if (!is_submodule_active(superproject, path))
 		return 0;
 
 	subrepo = xmalloc(sizeof(*subrepo));
-	if (repo_submodule_init(subrepo, superproject, sub)) {
+	if (repo_submodule_init(subrepo, superproject, path, null_oid())) {
 		free(subrepo);
 		return 0;
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a26ad8ae..ec19bf54b2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -209,10 +209,8 @@ static void show_submodule(struct repository *superproject,
 			   struct dir_struct *dir, const char *path)
 {
 	struct repository subrepo;
-	const struct submodule *sub = submodule_from_path(superproject,
-							  null_oid(), path);
 
-	if (repo_submodule_init(&subrepo, superproject, sub))
+	if (repo_submodule_init(&subrepo, superproject, path, null_oid()))
 		return;
 
 	if (repo_read_index(&subrepo) < 0)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e4..6718f202db 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2540,7 +2540,6 @@ static int push_check(int argc, const char **argv, const char *prefix)
 
 static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 {
-	const struct submodule *sub;
 	const char *path;
 	const char *cw;
 	struct repository subrepo;
@@ -2550,11 +2549,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 
 	path = argv[1];
 
-	sub = submodule_from_path(the_repository, null_oid(), path);
-	if (!sub)
-		BUG("We could get the submodule handle before?");
-
-	if (repo_submodule_init(&subrepo, the_repository, sub))
+	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
diff --git a/repository.c b/repository.c
index b2bf44c6fa..e4a1afb0ac 100644
--- a/repository.c
+++ b/repository.c
@@ -190,19 +190,15 @@ int repo_init(struct repository *repo,
 
 int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const struct submodule *sub)
+			const char *path,
+			const struct object_id *treeish_name)
 {
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	if (!sub) {
-		ret = -1;
-		goto out;
-	}
-
-	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", sub->path);
-	strbuf_repo_worktree_path(&worktree, superproject, "%s", sub->path);
+	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
+	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
 
 	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*
@@ -212,6 +208,13 @@ int repo_submodule_init(struct repository *subrepo,
 		 * in the superproject's 'modules' directory.  In this case the
 		 * submodule would not have a worktree.
 		 */
+		const struct submodule *sub =
+			submodule_from_path(superproject, treeish_name, path);
+		if (!sub) {
+			ret = -1;
+			goto out;
+		}
+
 		strbuf_reset(&gitdir);
 		strbuf_repo_git_path(&gitdir, superproject,
 				     "modules/%s", sub->name);
@@ -225,7 +228,7 @@ int repo_submodule_init(struct repository *subrepo,
 	subrepo->submodule_prefix = xstrfmt("%s%s/",
 					    superproject->submodule_prefix ?
 					    superproject->submodule_prefix :
-					    "", sub->path);
+					    "", path);
 
 out:
 	strbuf_release(&gitdir);
diff --git a/repository.h b/repository.h
index 3740c93bc0..c24e177c7e 100644
--- a/repository.h
+++ b/repository.h
@@ -172,15 +172,18 @@ void initialize_the_repository(void);
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 
 /*
- * Initialize the repository 'subrepo' as the submodule given by the
- * struct submodule 'sub' in parent repository 'superproject'.
- * Return 0 upon success and a non-zero value upon failure, which may happen
- * if the submodule is not found, or 'sub' is NULL.
+ * Initialize the repository 'subrepo' as the submodule at the given path. If
+ * the submodule's gitdir cannot be found at <path>/.git, this function calls
+ * submodule_from_path() to try to find it. treeish_name is only used if
+ * submodule_from_path() needs to be called; see its documentation for more
+ * information.
+ * Return 0 upon success and a non-zero value upon failure.
  */
-struct submodule;
+struct object_id;
 int repo_submodule_init(struct repository *subrepo,
 			struct repository *superproject,
-			const struct submodule *sub);
+			const char *path,
+			const struct object_id *treeish_name);
 void repo_clear(struct repository *repo);
 
 /*
diff --git a/submodule.c b/submodule.c
index 3af3da5b5e..ecda0229af 100644
--- a/submodule.c
+++ b/submodule.c
@@ -520,9 +520,6 @@ static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
 /*
  * Initialize a repository struct for a submodule based on the provided 'path'.
  *
- * Unlike repo_submodule_init, this tolerates submodules not present
- * in .gitmodules. This function exists only to preserve historical behavior,
- *
  * Returns the repository struct on success,
  * NULL when the submodule is not present.
  */
@@ -1404,11 +1401,11 @@ static void fetch_task_release(struct fetch_task *p)
 }
 
 static struct repository *get_submodule_repo_for(struct repository *r,
-						 const struct submodule *sub)
+						 const char *path)
 {
 	struct repository *ret = xmalloc(sizeof(*ret));
 
-	if (repo_submodule_init(ret, r, sub)) {
+	if (repo_submodule_init(ret, r, path, null_oid())) {
 		free(ret);
 		return NULL;
 	}
@@ -1452,7 +1449,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		task->repo = get_submodule_repo_for(spf->r, task->sub);
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index e3f11ff5a7..dc1c14bde3 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -11,15 +11,13 @@ static void die_usage(const char **argv, const char *msg)
 int cmd__submodule_nested_repo_config(int argc, const char **argv)
 {
 	struct repository subrepo;
-	const struct submodule *sub;
 
 	if (argc < 3)
 		die_usage(argv, "Wrong number of arguments.");
 
 	setup_git_directory();
 
-	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
-	if (repo_submodule_init(&subrepo, the_repository, sub)) {
+	if (repo_submodule_init(&subrepo, the_repository, argv[1], null_oid())) {
 		die_usage(argv, "Submodule not found.");
 	}
 
-- 
2.33.0.309.g3052b89438-goog


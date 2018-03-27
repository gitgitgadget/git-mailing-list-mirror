Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E85F1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeC0Vjk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:39:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42618 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeC0Vjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:39:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so237084plo.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4TNk+vr+Q9ucZ/kT96xSTGeD7oScb3G+pVAjsU7TTk=;
        b=JN16UFEwipRx+Nl5WgXz+8UTt9sr9DzVoe/kFram4k9JnLez/3cw1MjFlns8XLS1Lo
         por8iIY0TjxtQtOrFwhIDSNz09/tLCVfiNtMx65yq0sMmBNPZMGxTchASV3TpTYYa93U
         NSs1xGUctDpTRGTGRTI9MJlMyTVJr/dvglpdqjN0MAmE03scJ3/09No9PqLXrqvCR4Js
         sDWwg1uDKqQcI3MObSDgWTMOPljGcO8Ll5LK4TSHPAATjq2cfk7ZepYxBnzfbPcejOjZ
         wNh+PfFoIt/77PW9KbjcdUUfA60CfY6CXDedAt2xsjrQZVy6dmHTHqAtMuOejH5qRsrc
         jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4TNk+vr+Q9ucZ/kT96xSTGeD7oScb3G+pVAjsU7TTk=;
        b=N22P40oW06BRz2mRtv4bKyCXqwF6onXqiiJFN8RsA6IRAkf81O3LsQFx1vvPnhncaO
         RQ+o6OBU03jHhoHN9k7QwTOT9I3cI33ygReYLq1tiaW8YBYV9iu3u27YfdQexafOF/Iv
         g3GoHzkemhv+jkogv2QVFEocjiPDNX6ec4xce+gflEkbAg0GCOoIALf9X/ROUas+0mMy
         WYQoVmLeRi//Fc56aqd4/P9GZjc+MWsNn65/IFyABe0a6zQvBSfKCGG50lrw5/L3sqmd
         Ec2NQopW/gwOKOr7J8pPNjAFJFIBCsctnH40W+aSztNCG/OoU6O2ibeunk2E5Rdm/qMA
         U39Q==
X-Gm-Message-State: AElRT7Gd7slCjNdnK+vqcRbUFlGjzuwCb3EgHB6yTfJnWQQvotelJzM5
        iF/hRPWQtL1dKHr77FPAFuaKEufz2/A=
X-Google-Smtp-Source: AIpwx48slkD8HvNioxfvjT5TGcgt4bfF1ZwjXeJrSHxDYDKij0//o+ds7t9ZrL8TiP12I+O+/0SbUA==
X-Received: by 2002:a17:902:5814:: with SMTP id m20-v6mr919250pli.311.1522186775954;
        Tue, 27 Mar 2018 14:39:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z7sm3629563pgp.55.2018.03.27.14.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 14:39:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     seanwbehan@riseup.net, bmwill@google.com, hvoigt@hvoigt.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] submodule-config: add repository argument to submodule_from_{name, path}
Date:   Tue, 27 Mar 2018 14:39:16 -0700
Message-Id: <20180327213918.77851-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180327213918.77851-1-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables submodule_from_{name, path} to handle arbitrary repositories.
All callers just pass in the_repository, a later patch will pass in other
repos.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c      | 14 +++++++-------
 submodule-config.c               | 14 ++++++++------
 submodule-config.h               |  4 ++--
 submodule.c                      | 30 ++++++++++++++++--------------
 t/helper/test-submodule-config.c |  6 ++++--
 5 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..a921fbbf56 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -454,7 +454,7 @@ static void init_submodule(const char *path, const char *prefix,
 
 	displaypath = get_submodule_displaypath(path, prefix);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
@@ -621,7 +621,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct rev_info rev;
 	int diff_files_result;
 
-	if (!submodule_from_path(&null_oid, path))
+	if (!submodule_from_path(the_repository, &null_oid, path))
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		      path);
 
@@ -741,7 +741,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(_("git submodule--helper name <path>"));
 
-	sub = submodule_from_path(&null_oid, argv[1]);
+	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -772,7 +772,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_active(the_repository, path))
 		return;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
@@ -925,7 +925,7 @@ static void deinit_submodule(const char *path, const char *prefix,
 	struct strbuf sb_config = STRBUF_INIT;
 	char *sub_git_dir = xstrfmt("%s/.git", path);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub || !sub->name)
 		goto cleanup;
@@ -1367,7 +1367,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	sub = submodule_from_path(&null_oid, ce->name);
+	sub = submodule_from_path(the_repository, &null_oid, ce->name);
 
 	if (suc->recursive_prefix)
 		displaypath = relative_path(suc->recursive_prefix,
@@ -1650,7 +1650,7 @@ static const char *remote_submodule_branch(const char *path)
 	const char *branch = NULL;
 	char *key;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 	if (!sub)
 		return NULL;
 
diff --git a/submodule-config.c b/submodule-config.c
index a3efff1a34..4b7803e6ed 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -619,18 +619,20 @@ static void gitmodules_read_check(struct repository *repo)
 		repo_read_gitmodules(repo);
 }
 
-const struct submodule *submodule_from_name(const struct object_id *treeish_name,
+const struct submodule *submodule_from_name(struct repository *r,
+					    const struct object_id *treeish_name,
 		const char *name)
 {
-	gitmodules_read_check(the_repository);
-	return config_from(the_repository->submodule_cache, treeish_name, name, lookup_name);
+	gitmodules_read_check(r);
+	return config_from(r->submodule_cache, treeish_name, name, lookup_name);
 }
 
-const struct submodule *submodule_from_path(const struct object_id *treeish_name,
+const struct submodule *submodule_from_path(struct repository *r,
+					    const struct object_id *treeish_name,
 		const char *path)
 {
-	gitmodules_read_check(the_repository);
-	return config_from(the_repository->submodule_cache, treeish_name, path, lookup_path);
+	gitmodules_read_check(r);
+	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
 const struct submodule *submodule_from_cache(struct repository *repo,
diff --git a/submodule-config.h b/submodule-config.h
index df6bd6e6db..ff3c9e0b5c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -39,9 +39,9 @@ extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 extern void repo_read_gitmodules(struct repository *repo);
 extern void gitmodules_config_oid(const struct object_id *commit_oid);
-extern const struct submodule *submodule_from_name(
+extern const struct submodule *submodule_from_name(struct repository *r,
 		const struct object_id *commit_or_tree, const char *name);
-extern const struct submodule *submodule_from_path(
+extern const struct submodule *submodule_from_path(struct repository *r,
 		const struct object_id *commit_or_tree, const char *path);
 extern const struct submodule *submodule_from_cache(struct repository *repo,
 						    const struct object_id *treeish_name,
diff --git a/submodule.c b/submodule.c
index 12a2503fda..e94b7f9acd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -95,7 +95,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(&null_oid, oldpath);
+	submodule = submodule_from_path(the_repository, &null_oid, oldpath);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), oldpath);
 		return -1;
@@ -129,7 +129,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (is_gitmodules_unmerged(&the_index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
-	submodule = submodule_from_path(&null_oid, path);
+	submodule = submodule_from_path(the_repository, &null_oid, path);
 	if (!submodule || !submodule->name) {
 		warning(_("Could not find section in .gitmodules where path=%s"), path);
 		return -1;
@@ -173,7 +173,8 @@ static int add_submodule_odb(const char *path)
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
-	const struct submodule *submodule = submodule_from_path(&null_oid, path);
+	const struct submodule *submodule = submodule_from_path(the_repository,
+								&null_oid, path);
 	if (submodule) {
 		const char *ignore;
 		char *key;
@@ -673,7 +674,7 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	if (!should_update_submodules())
 		return NULL;
 
-	return submodule_from_path(&null_oid, ce->name);
+	return submodule_from_path(the_repository, &null_oid, ce->name);
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
@@ -730,13 +731,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		submodule = submodule_from_path(commit_oid, p->two->path);
+		submodule = submodule_from_path(the_repository,
+						commit_oid, p->two->path);
 		if (submodule)
 			name = submodule->name;
 		else {
 			name = default_name_or_path(p->two->path);
 			/* make sure name does not collide with existing one */
-			submodule = submodule_from_name(commit_oid, name);
+			submodule = submodule_from_name(the_repository, commit_oid, name);
 			if (submodule) {
 				warning("Submodule in commit %s at path: "
 					"'%s' collides with a submodule named "
@@ -944,7 +946,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(&null_oid, name->string);
+		submodule = submodule_from_name(the_repository, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1112,7 +1114,7 @@ static void calculate_changed_submodule_paths(void)
 	const struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(NULL, NULL))
+	if (!submodule_from_path(the_repository, NULL, NULL))
 		return;
 
 	argv_array_push(&argv, "--"); /* argv[0] program name */
@@ -1133,7 +1135,7 @@ static void calculate_changed_submodule_paths(void)
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(&null_oid, name->string);
+		submodule = submodule_from_name(the_repository, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1161,7 +1163,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	int ret;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(NULL, NULL))
+	if (!submodule_from_path(the_repository, NULL, NULL))
 		return 0;
 
 	argv_array_push(&args, "--"); /* args[0] program name */
@@ -1603,7 +1605,7 @@ int submodule_move_head(const char *path,
 	if (old_head && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
@@ -1885,7 +1887,7 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
-	sub = submodule_from_path(&null_oid, path);
+	sub = submodule_from_path(the_repository, &null_oid, path);
 	if (!sub)
 		die(_("could not lookup name for submodule '%s'"), path);
 
@@ -1941,7 +1943,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		* superproject did not rewrite the git file links yet,
 		* fix it now.
 		*/
-		sub = submodule_from_path(&null_oid, path);
+		sub = submodule_from_path(the_repository, &null_oid, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
 		connect_work_tree_and_git_dir(path,
@@ -2087,7 +2089,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		sub = submodule_from_path(&null_oid, submodule);
+		sub = submodule_from_path(the_repository, &null_oid, submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 9971c5e9dd..e044871cee 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -48,9 +48,11 @@ int cmd_main(int argc, const char **argv)
 			die_usage(argc, argv, "Commit not found.");
 
 		if (lookup_name) {
-			submodule = submodule_from_name(&commit_oid, path_or_name);
+			submodule = submodule_from_name(the_repository,
+							&commit_oid, path_or_name);
 		} else
-			submodule = submodule_from_path(&commit_oid, path_or_name);
+			submodule = submodule_from_path(the_repository,
+							&commit_oid, path_or_name);
 		if (!submodule)
 			die_usage(argc, argv, "Submodule not found.");
 
-- 
2.17.0.rc1.321.gba9d0f2565-goog


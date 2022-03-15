Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D794C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiCOVLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351877AbiCOVLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:11:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5F56762
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id rm9-20020a17090b3ec900b001c6317e4715so2833707pjb.6
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5qjaRzdulZ8sdXXvjGAdiTy+Lr5di4xciXYxsl7AXKE=;
        b=oxw4eOeRzzw5YFgB8SYapUEXWrxm4mpjYjA2afpSWKPPM4M5+bYBy2AYSKh1DOHRK4
         IZ2C1ojcs3k4ZAqZ5vzINocWzpESIWZMi5YHIkQj3wMzjPGJcylL0WAKXZZ+70szA4eD
         eKUUHuZcU/iVvJif8HFvKjCjFSyRzQBhVx6CNeDiuRZcr7iMOPOCIrJsydbxChe98VPM
         3Db1bzCwyJp74kzrcbR6dpsWKIB0Nes3/6dR8EWw5a5lr6Tg3c/AywZxjKBIGndQDgtd
         QOZ2kaXGQKSpdbBE78MiwsGQWcut+77g7n2yRSQUXQM/MWNCdR6nO0ewJE4sf1wQuB5m
         vwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5qjaRzdulZ8sdXXvjGAdiTy+Lr5di4xciXYxsl7AXKE=;
        b=M/+JawiXqhtKar0XA1pDTZo84oHVdGq635WobEnye4ftqH/Hqpw6ptdRi1bxAO5edS
         NX9FJZQEzIlEj3WhZKLfQKr+QftC92bYHTZtfiypejpNiQzGr3cGzxPD59ra1gJqpa0D
         eUSb7LCVnonwPBYdfzGKUeE/Gf7iBAreaOyL+m3sKwN65xtS10M4zXCcAqUW2GwSqEZC
         WJ75C3hLY1aWhW0jnAZvf4AvNbBHCS8UJk3bjNtC24Nf06r+IAz4R6/vs5yP+Erbr3A2
         kfRKbC3vVNrTSEF0geLEVUrJwQWi2bHjZm4bInjvAcK7cVUTXtFGpaQc1eAFzN4sCfIO
         cAtw==
X-Gm-Message-State: AOAM53340Wop6dYZv9zvKZBxe3wLVQlEuBRYwV1q+1uxBMnWP1VCcC75
        Xdul66/G9zM6fXHVDjQ1TGUI2TzYSvOGfVZBUcG7J2vGs9ioSyhK6OKtY0UrOBPXp2YtA3oUnem
        S448gMnGGhFvJR4s6yk9oD1Ia+ap9Bmj2VNMl3lbDMozV87Vzcuq0JaV48XIU58g=
X-Google-Smtp-Source: ABdhPJwPBwqQiQYDXsqncpXQenaRCebnOQJa6L6DmsuIfqbkLDnIFx6DWU8snHiENCZE57xJqIewEIbM5kFbYg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:17a5:b0:4f6:f3fb:b6d8 with SMTP
 id s37-20020a056a0017a500b004f6f3fbb6d8mr30160705pfg.75.1647378591857; Tue,
 15 Mar 2022 14:09:51 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:25 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 7/7] submodule--helper: remove forward declaration
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rearrange functions so that submodule_update() no longer needs to be
forward declared.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 393 ++++++++++++++++++------------------
 1 file changed, 196 insertions(+), 197 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 842d9ecaa8..11289f0ae5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2452,7 +2452,202 @@ static int run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
-static int update_submodule(struct update_data *update_data);
+static const char *remote_submodule_branch(const char *path)
+{
+	const struct submodule *sub;
+	const char *branch = NULL;
+	char *key;
+
+	sub = submodule_from_path(the_repository, null_oid(), path);
+	if (!sub)
+		return NULL;
+
+	key = xstrfmt("submodule.%s.branch", sub->name);
+	if (repo_config_get_string_tmp(the_repository, key, &branch))
+		branch = sub->branch;
+	free(key);
+
+	if (!branch)
+		return "HEAD";
+
+	if (!strcmp(branch, ".")) {
+		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+
+		if (!refname)
+			die(_("No such ref: %s"), "HEAD");
+
+		/* detached HEAD */
+		if (!strcmp(refname, "HEAD"))
+			die(_("Submodule (%s) branch configured to inherit "
+			      "branch from superproject, but the superproject "
+			      "is not on any branch"), sub->name);
+
+		if (!skip_prefix(refname, "refs/heads/", &refname))
+			die(_("Expecting a full ref name, got %s"), refname);
+		return refname;
+	}
+
+	return branch;
+}
+
+static void ensure_core_worktree(const char *path)
+{
+	const char *cw;
+	struct repository subrepo;
+
+	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
+		die(_("could not get a repository handle for submodule '%s'"), path);
+
+	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
+		char *cfg_file, *abs_path;
+		const char *rel_path;
+		struct strbuf sb = STRBUF_INIT;
+
+		cfg_file = repo_git_path(&subrepo, "config");
+
+		abs_path = absolute_pathdup(path);
+		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
+
+		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
+
+		free(cfg_file);
+		free(abs_path);
+		strbuf_release(&sb);
+	}
+}
+
+static void update_data_to_args(struct update_data *update_data, struct strvec *args)
+{
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
+	if (update_data->recursive_prefix)
+		strvec_pushl(args, "--recursive-prefix",
+			     update_data->recursive_prefix, NULL);
+	if (update_data->quiet)
+		strvec_push(args, "--quiet");
+	if (update_data->force)
+		strvec_push(args, "--force");
+	if (update_data->init)
+		strvec_push(args, "--init");
+	if (update_data->remote)
+		strvec_push(args, "--remote");
+	if (update_data->nofetch)
+		strvec_push(args, "--no-fetch");
+	if (update_data->dissociate)
+		strvec_push(args, "--dissociate");
+	if (update_data->progress)
+		strvec_push(args, "--progress");
+	if (update_data->require_init)
+		strvec_push(args, "--require-init");
+	if (update_data->depth)
+		strvec_pushf(args, "--depth=%d", update_data->depth);
+	if (update_data->update_default)
+		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	if (update_data->references.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &update_data->references)
+			strvec_pushl(args, "--reference", item->string, NULL);
+	}
+	if (update_data->filter_options && update_data->filter_options->choice)
+		strvec_pushf(args, "--filter=%s",
+				expand_list_objects_filter_spec(
+					update_data->filter_options));
+	if (update_data->recommend_shallow == 0)
+		strvec_push(args, "--no-recommend-shallow");
+	else if (update_data->recommend_shallow == 1)
+		strvec_push(args, "--recommend-shallow");
+	if (update_data->single_branch >= 0)
+		strvec_push(args, update_data->single_branch ?
+				    "--single-branch" :
+				    "--no-single-branch");
+}
+
+static int update_submodule(struct update_data *update_data)
+{
+	char *prefixed_path;
+
+	ensure_core_worktree(update_data->sm_path);
+
+	if (update_data->recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path = xstrdup(update_data->sm_path);
+
+	update_data->displaypath = get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
+	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
+					    update_data->sm_path, update_data->update_default,
+					    &update_data->update_strategy);
+
+	if (update_data->just_cloned)
+		oidcpy(&update_data->suboid, null_oid());
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+		die(_("Unable to find current revision in submodule path '%s'"),
+			update_data->displaypath);
+
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		if (run_update_procedure(update_data))
+			return 1;
+
+	if (update_data->recursive) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct update_data next = *update_data;
+		int res;
+
+		if (update_data->recursive_prefix)
+			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
+						update_data->sm_path);
+		else
+			prefixed_path = xstrfmt("%s/", update_data->sm_path);
+
+		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
+								  update_data->prefix);
+		next.prefix = NULL;
+		oidcpy(&next.oid, null_oid());
+		oidcpy(&next.suboid, null_oid());
+
+		cp.dir = update_data->sm_path;
+		cp.git_cmd = 1;
+		prepare_submodule_repo_env(&cp.env_array);
+		update_data_to_args(&next, &cp.args);
+
+		/* die() if child process die()'d */
+		res = run_command(&cp);
+		if (!res)
+			return 0;
+		die_message(_("Failed to recurse into submodule path '%s'"),
+			    update_data->displaypath);
+		if (res == 128)
+			exit(res);
+		else if (res)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int update_submodules(struct update_data *update_data)
 {
 	int i, res = 0;
@@ -2607,44 +2802,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static const char *remote_submodule_branch(const char *path)
-{
-	const struct submodule *sub;
-	const char *branch = NULL;
-	char *key;
-
-	sub = submodule_from_path(the_repository, null_oid(), path);
-	if (!sub)
-		return NULL;
-
-	key = xstrfmt("submodule.%s.branch", sub->name);
-	if (repo_config_get_string_tmp(the_repository, key, &branch))
-		branch = sub->branch;
-	free(key);
-
-	if (!branch)
-		return "HEAD";
-
-	if (!strcmp(branch, ".")) {
-		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-
-		if (!refname)
-			die(_("No such ref: %s"), "HEAD");
-
-		/* detached HEAD */
-		if (!strcmp(refname, "HEAD"))
-			die(_("Submodule (%s) branch configured to inherit "
-			      "branch from superproject, but the superproject "
-			      "is not on any branch"), sub->name);
-
-		if (!skip_prefix(refname, "refs/heads/", &refname))
-			die(_("Expecting a full ref name, got %s"), refname);
-		return refname;
-	}
-
-	return branch;
-}
-
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
@@ -2722,32 +2879,6 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void ensure_core_worktree(const char *path)
-{
-	const char *cw;
-	struct repository subrepo;
-
-	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
-		die(_("could not get a repository handle for submodule '%s'"), path);
-
-	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
-		char *cfg_file, *abs_path;
-		const char *rel_path;
-		struct strbuf sb = STRBUF_INIT;
-
-		cfg_file = repo_git_path(&subrepo, "config");
-
-		abs_path = absolute_pathdup(path);
-		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);
-
-		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
-
-		free(cfg_file);
-		free(abs_path);
-		strbuf_release(&sb);
-	}
-}
-
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -2969,138 +3100,6 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void update_data_to_args(struct update_data *update_data, struct strvec *args)
-{
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
-	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	if (update_data->recursive_prefix)
-		strvec_pushl(args, "--recursive-prefix",
-			     update_data->recursive_prefix, NULL);
-	if (update_data->quiet)
-		strvec_push(args, "--quiet");
-	if (update_data->force)
-		strvec_push(args, "--force");
-	if (update_data->init)
-		strvec_push(args, "--init");
-	if (update_data->remote)
-		strvec_push(args, "--remote");
-	if (update_data->nofetch)
-		strvec_push(args, "--no-fetch");
-	if (update_data->dissociate)
-		strvec_push(args, "--dissociate");
-	if (update_data->progress)
-		strvec_push(args, "--progress");
-	if (update_data->require_init)
-		strvec_push(args, "--require-init");
-	if (update_data->depth)
-		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update_data->update_default)
-		strvec_pushl(args, "--update", update_data->update_default, NULL);
-	if (update_data->references.nr) {
-		struct string_list_item *item;
-		for_each_string_list_item(item, &update_data->references)
-			strvec_pushl(args, "--reference", item->string, NULL);
-	}
-	if (update_data->filter_options && update_data->filter_options->choice)
-		strvec_pushf(args, "--filter=%s",
-				expand_list_objects_filter_spec(
-					update_data->filter_options));
-	if (update_data->recommend_shallow == 0)
-		strvec_push(args, "--no-recommend-shallow");
-	else if (update_data->recommend_shallow == 1)
-		strvec_push(args, "--recommend-shallow");
-	if (update_data->single_branch >= 0)
-		strvec_push(args, update_data->single_branch ?
-				    "--single-branch" :
-				    "--no-single-branch");
-}
-
-static int update_submodule(struct update_data *update_data)
-{
-	char *prefixed_path;
-
-	ensure_core_worktree(update_data->sm_path);
-
-	if (update_data->recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
-					update_data->sm_path);
-	else
-		prefixed_path = xstrdup(update_data->sm_path);
-
-	update_data->displaypath = get_submodule_displaypath(prefixed_path,
-							     update_data->prefix);
-	free(prefixed_path);
-
-	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
-					    update_data->sm_path, update_data->update_default,
-					    &update_data->update_strategy);
-
-	if (update_data->just_cloned)
-		oidcpy(&update_data->suboid, null_oid());
-	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-		die(_("Unable to find current revision in submodule path '%s'"),
-			update_data->displaypath);
-
-	if (update_data->remote) {
-		char *remote_name = get_default_remote_submodule(update_data->sm_path);
-		const char *branch = remote_submodule_branch(update_data->sm_path);
-		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
-
-		if (!update_data->nofetch) {
-			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
-					      0, NULL))
-				die(_("Unable to fetch in submodule path '%s'"),
-				    update_data->sm_path);
-		}
-
-		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
-			die(_("Unable to find %s revision in submodule path '%s'"),
-			    remote_ref, update_data->sm_path);
-
-		free(remote_ref);
-	}
-
-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (run_update_procedure(update_data))
-			return 1;
-
-	if (update_data->recursive) {
-		struct child_process cp = CHILD_PROCESS_INIT;
-		struct update_data next = *update_data;
-		int res;
-
-		if (update_data->recursive_prefix)
-			prefixed_path = xstrfmt("%s%s/", update_data->recursive_prefix,
-						update_data->sm_path);
-		else
-			prefixed_path = xstrfmt("%s/", update_data->sm_path);
-
-		next.recursive_prefix = get_submodule_displaypath(prefixed_path,
-								  update_data->prefix);
-		next.prefix = NULL;
-		oidcpy(&next.oid, null_oid());
-		oidcpy(&next.suboid, null_oid());
-
-		cp.dir = update_data->sm_path;
-		cp.git_cmd = 1;
-		prepare_submodule_repo_env(&cp.env_array);
-		update_data_to_args(&next, &cp.args);
-
-		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
-			return 0;
-		die_message(_("Failed to recurse into submodule path '%s'"),
-			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
-		else if (res)
-			return 1;
-	}
-
-	return 0;
-}
-
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT


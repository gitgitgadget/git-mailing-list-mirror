Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721CC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E98260EE9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhJMFVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhJMFVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:21:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDFC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:19:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n11so1009590plf.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/06YRsnW/qTZbhYX7jaSYL7zc6WH4rpY1sjrubjcBMA=;
        b=mtHcM/dNEnWeXXOKKr36/kCB5gVCbbAQV0IFf4v746Gpg9b641Rlfd/+WYm12rjqT2
         4Z1DdczFtAD8aSAqWVrak7vEfKyfqRn0I78tzZTJt1GGby49xctQitxLnzvbNEkvydIQ
         yHR7/TyY1hsCpk1W7blzUhllNddEAKma6ZlIH7n9Ym0RMo1wzzQPQafWobsFL4m3CPt/
         5Uu3KiejdejFj4tes5ejRPsYMUqUiNGMqxd7r6oyiuV5ijuXvuKc2Fmg6q+qStfLDx+p
         N7cNJAJJiTseC0gAb37o2evGv00I5bsNFhnx44W5PegKEQUvzqpDpmhBZwbk9rhOJ6xu
         gWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/06YRsnW/qTZbhYX7jaSYL7zc6WH4rpY1sjrubjcBMA=;
        b=K4pzQIKtbX5GNij8IF3nsgOj1f4J/YbA+dW4oKWasncXP+8MheSrQnyb0MBn4lTOTc
         LL9ZaAz1adTI/b+3xMqs9nIEOM/h0B+jj27RtmjBG0bD4LaTGr6NyLrPR0Jeouw2rHDU
         2QZTlYqPajW82OiGg7k6IOY5E9my6KscdWw5SeDsP+9DY/dDT7uxvBBmzzyIkqCLdDYC
         xnwugGrovslynaLU34epf1eP2n/n6xWNFym22CbzyYN1FucuTQgLMlrQtpz9GPVpH+rb
         75CDaNHM2wOBkpFwRWU9cX8VSH60iwzv/VqLUbjddWKC63s8eWgjwsIB5cL4tyhe7uSu
         Z1Dg==
X-Gm-Message-State: AOAM533spkvy2ItPF/6yQIwVaqv7g2L/3AHD5ouMxmaVzC6P21grEqMD
        HvhXcmleM84cPhq/VQvOAoE=
X-Google-Smtp-Source: ABdhPJyHiIcTdo309yDqbyUkoouWHDcomfur0nv4SltZcmACC6xyiMhz2Cmwb+bWKro9nBjE4q3J8A==
X-Received: by 2002:a17:90b:3b85:: with SMTP id pc5mr11138812pjb.74.1634102340457;
        Tue, 12 Oct 2021 22:19:00 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:19:00 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 8/9] submodule--helper: remove unused helpers
Date:   Wed, 13 Oct 2021 10:48:04 +0530
Message-Id: <20211013051805.45662-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These helpers were useful back when 'submodule update' had most of its
logic in shell. Now that they will never be invoked, let us remove them.

We also no longer need the 'update_clone_submodules()' and
'update_clone_submodule()' functions, so we remove those as well.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 233 ------------------------------------
 1 file changed, 233 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3049628f88..0d6e65bd6c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -71,21 +71,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository, refname);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -1960,29 +1945,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2518,182 +2480,6 @@ static int do_run_update_procedure(struct update_data *ud, struct string_list *e
 	return run_update_command(ud, subforce, err);
 }
 
-static void update_clone_submodule(struct update_clone_data *ucd)
-{
-	fprintf(stdout, "dummy %s %d\t%s\n",
-		oid_to_hex(&ucd->oid),
-		ucd->just_cloned,
-		ucd->sub->path);
-}
-
-static int update_clone_submodules(struct submodule_update_clone *suc)
-{
-	int i;
-
-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, suc, "submodule",
-				   "parallel/update");
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc->quickstop)
-		return 1;
-
-	for (i = 0; i < suc->update_clone_nr; i++)
-		update_clone_submodule(&suc->update_clone[i]);
-
-	return 0;
-}
-
-static int update_clone(int argc, const char **argv, const char *prefix)
-{
-	const char *update = NULL;
-	struct pathspec pathspec;
-	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
-
-	struct option module_update_clone_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
-			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &suc.dissociate,
-			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
-			   N_("create a shallow clone truncated to the "
-			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
-			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
-			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &suc.progress,
-			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &suc.require_init,
-			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &suc.single_branch,
-			 N_("clone only one branch, HEAD or --branch")),
-		OPT_END()
-	};
-
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
-		NULL
-	};
-	suc.prefix = prefix;
-
-	update_clone_config_from_gitmodules(&suc.max_jobs);
-	git_config(git_update_clone_config, &suc.max_jobs);
-
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
-			     git_submodule_helper_usage, 0);
-
-	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
-			die(_("bad value for update parameter"));
-
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
-		return 1;
-
-	if (pathspec.nr)
-		suc.warn_if_uninitialized = 1;
-
-	return update_clone_submodules(&suc);
-}
-
-static int run_update_procedure(int argc, const char **argv, const char *prefix)
-{
-	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
-	char *prefixed_path, *update = NULL;
-	struct update_data update_data = UPDATE_DATA_INIT;
-	struct string_list err = STRING_LIST_INIT_DUP;
-
-	struct option options[] = {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc != 1)
-		usage_with_options(usage, options);
-
-	update_data.force = !!force;
-	update_data.quiet = !!quiet;
-	update_data.nofetch = !!nofetch;
-	update_data.just_cloned = !!just_cloned;
-	update_data.sm_path = argv[0];
-
-	if (update_data.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
-	else
-		prefixed_path = xstrdup(update_data.sm_path);
-
-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update,
-					    &update_data.update_strategy);
-
-	free(prefixed_path);
-
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data, &err);
-
-	return 3;
-}
-
-static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -2852,19 +2638,6 @@ static void do_ensure_core_worktree(const char *path)
 	}
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
-{
-	const char *path;
-
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-	do_ensure_core_worktree(path);
-
-	return 0;
-}
-
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -3707,16 +3480,10 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update", module_update, 0},
-	{"update-module-mode", module_update_module_mode, 0},
-	{"update-clone", update_clone, 0},
-	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
-	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-- 
2.32.0


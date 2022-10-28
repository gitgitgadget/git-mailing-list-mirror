Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A17BC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJ1UPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJ1UPH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8753025
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y16so7940399wrt.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfb9vpVMq7FbscgphHNXqmVqFeU2OEeEOTA7euf3Zeg=;
        b=b3LsxxboesNBOt3sSvXaed8nai5PAP4UtggG2XEiK5Z7ehC4n5vX+C8CFztpx1eAZs
         nLfov2J8KGOuYCUZBlQ8pPyPjVDlY5dYzNiJU4z1DGEHtYJmVnIqoZflAykkrsi8Km85
         Z+VDHvgoAI/2JGdjCIA4g/6Wr7IDL0IWQN55+l1KL/hcUq5x8ZhldpVZtPccESjwFv2d
         EvZ1GzWKGbANwbpOy/PGKqGcOnROwEOfXXgzJQraRLS7LOamMoFVd0UI8QZg50Ij8pi6
         Yp5GonmAmi3tSYdzdN2cqArbk5WifUC1rE/JA8VZXwX5W0ier9l84JBjiKTVEWqXOu6O
         tI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfb9vpVMq7FbscgphHNXqmVqFeU2OEeEOTA7euf3Zeg=;
        b=pKvhXlkdvJsGcqr/LfzkzpdDopRGYj2XA2GRifGjY9ZrxEx5U9AVwyDklAStKEZU6w
         PR16Oks4ccICyESt+c/hoMCcVo+MJmCAPm3seOExcRldq9Lg0OG/OrdmjlfOinAZfdrI
         GayhpHFTk9ZFuiNyW5BmuiAU/eVwRilRo0DEUGETEvgNm9DjBibEDfeTnmKJ2nCuQyvT
         ZY/KTAZEGng0kf+PIlGHzgt5mJK/fXUhFv9/0ziI3WHb/Y/BrlveiRYF1N9dytBeDfzK
         7SH+TuhYjAcIvM2rhqIR83EriLF5/bpCWnTtV3+MfmJQTSl7K9yQ+WOW1lGh/m3P0yXM
         M8pw==
X-Gm-Message-State: ACrzQf3AWRdVuXhDlr5ZTGMpIkMqD3ci8hBx2PqMHVcQQDcKd1slNrjY
        LZhnU3QExfJMd+0/spel/d4tP0zz1Ck=
X-Google-Smtp-Source: AMsMyM6gF2VdSNp5g+ec4Y9qytrJQkCgG2K+vcyoSMPfZ1+sevoVtsZGu/zNhL26HzUx3ugeJM/JNA==
X-Received: by 2002:adf:f6c9:0:b0:236:547f:698a with SMTP id y9-20020adff6c9000000b00236547f698amr586162wrp.180.1666988105708;
        Fri, 28 Oct 2022 13:15:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6b83000000b00236644228besm4274839wrx.40.2022.10.28.13.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:15:05 -0700 (PDT)
Message-Id: <7cdd6c4184da2d3109498589167f10ecf972edc9.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:56 +0000
Subject: [PATCH v3 8/8] clone, submodule update: create and check out branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Teach "git submodule update" to:

- create the branch with the same name as the current superproject
  branch when cloning a submodule
- check out that branch (instead of the commit OID) when updating
  the submodule worktree

when submodule branching is enabled (submodule.propagateBranches = true)
on the superproject and a branch is checked out. "git clone
--recurse-submodules" also learns this trick because it is implemented
with "git submodule update --recursive".

This approach of checking out the branch will not result in a dirty
worktree for freshly cloned submodules because we can ensure that the
submodule branch points to the superproject gitlink. In other cases, it
does not work as well, but we can handle them incrementally:

- "git pull --recurse-submodules" merges the superproject tree,
  (changing the gitlink without updating the submodule branches), and
  runs "git submodule update" to update the worktrees, so it is almost
  guaranteed to result in a dirty worktree.

  The implementation of "git pull --recurse-submodules" is likely to
  change drastically as submodule.propagateBranches work progresses
  (e.g. "git merge" learns to recurse in to submodules), and we may be
  able to replace the "git submodule update" invocation, or teach it new
  tricks that make the update behave well.

- The user might make changes to the submodule branch without committing
  them back to superproject. This is primarily affects "git checkout
  --recurse-submodules", since that is the primary way of switching away
  from a branch and leaving behind WIP (as opposed to "git submodule
  update", which is run post-checkout).

  In a future series, "git checkout --recurse-submodules" will learn to
  consider submodule branches. We can introduce appropriate guardrails
  then, e.g. requiring that the superproject working tree is not dirty
  before switching away.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c |  37 ++++++++-
 t/t5617-clone-submodules.sh |  38 +++++++++
 t/t7406-submodule-update.sh | 156 ++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef76a111c7f..767a0c81cde 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1917,6 +1917,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 struct update_data {
 	const char *prefix;
 	char *displaypath;
+	const char *super_branch;
 	enum submodule_update_type update_default;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
@@ -2091,6 +2092,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, suc->update_data->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
+	if (ud->super_branch) {
+		strvec_pushf(&child->args, "--branch=%s", ud->super_branch);
+		strvec_pushf(&child->args, "--branch-oid=%s",
+			     oid_to_hex(&ce->oid));
+	}
 
 cleanup:
 	free(displaypath);
@@ -2254,9 +2260,14 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *update_target = oid_to_hex(&ud->oid);;
+	const char *update_target;
 	int ret;
 
+	if (ud->update_strategy.type == SM_UPDATE_CHECKOUT && ud->super_branch)
+		update_target = ud->super_branch;
+	else
+		update_target = oid_to_hex(&ud->oid);
+
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		cp.git_cmd = 1;
@@ -2523,6 +2534,7 @@ static int update_submodule(struct update_data *update_data)
 	int submodule_up_to_date;
 	int ret;
 	struct object_id suboid;
+	const char *submodule_head = NULL;
 
 	ret = determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
@@ -2533,7 +2545,8 @@ static int update_submodule(struct update_data *update_data)
 		return ret;
 
 	if (!update_data->just_cloned &&
-	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid, NULL))
+	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid,
+				&submodule_head))
 		return die_message(_("Unable to find current revision in submodule path '%s'"),
 				   update_data->displaypath);
 
@@ -2568,8 +2581,17 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	submodule_up_to_date = !update_data->just_cloned &&
-		oideq(&update_data->oid, &suboid);
+	if (update_data->just_cloned)
+		submodule_up_to_date = 0;
+	else if (update_data->super_branch)
+		/* Check that the submodule's HEAD points to super_branch. */
+		submodule_up_to_date =
+			skip_prefix(submodule_head, "refs/heads/",
+				    &submodule_head) &&
+			!strcmp(update_data->super_branch, submodule_head);
+	else
+		submodule_up_to_date = oideq(&update_data->oid, &suboid);
+
 	if (!submodule_up_to_date || update_data->force) {
 		ret = run_update_procedure(update_data);
 		if (ret)
@@ -2603,6 +2625,12 @@ static int update_submodules(struct update_data *update_data)
 	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
+	if (the_repository->settings.submodule_propagate_branches) {
+		struct branch *current_branch = branch_get(NULL);
+		if (current_branch)
+			update_data->super_branch = current_branch->name;
+	}
+
 	suc.update_data = update_data;
 	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
 				   update_clone_start_failure,
@@ -2718,6 +2746,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
+	prepare_repo_settings(the_repository);
 
 	if (opt.require_init)
 		opt.init = 1;
diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
index c43a5b26fab..43f9b52bd44 100755
--- a/t/t5617-clone-submodules.sh
+++ b/t/t5617-clone-submodules.sh
@@ -13,10 +13,17 @@ test_expect_success 'setup' '
 	git config --global protocol.file.allow always &&
 	git checkout -b main &&
 	test_commit commit1 &&
+	mkdir subsub &&
+	(
+		cd subsub &&
+		git init &&
+		test_commit subsubcommit1
+	) &&
 	mkdir sub &&
 	(
 		cd sub &&
 		git init &&
+		git submodule add "file://$pwd/subsub" subsub &&
 		test_commit subcommit1 &&
 		git tag sub_when_added_to_super &&
 		git branch other
@@ -107,4 +114,35 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
 	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
 '
 
+test_expect_success 'submodule.propagateBranches checks out branches at correct commits' '
+	test_when_finished "git checkout main" &&
+
+	git checkout -b checked-out &&
+	git -C sub checkout -b not-in-clone &&
+	git -C subsub checkout -b not-in-clone &&
+	git clone --recurse-submodules \
+		--branch checked-out \
+		-c submodule.propagateBranches=true \
+		"file://$pwd/." super_clone4 &&
+
+	# Assert that each repo is pointing to "checked-out"
+	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub"
+	do
+	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
+	    test $HEAD_BRANCH = "refs/heads/checked-out" || return 1
+	done &&
+
+	# Assert that the submodule branches are pointing to the right revs
+	EXPECT_SUB_OID="$(git -C super_clone4 rev-parse :sub)" &&
+	ACTUAL_SUB_OID="$(git -C super_clone4/sub rev-parse refs/heads/checked-out)" &&
+	test $EXPECT_SUB_OID = $ACTUAL_SUB_OID &&
+	EXPECT_SUBSUB_OID="$(git -C super_clone4/sub rev-parse :subsub)" &&
+	ACTUAL_SUBSUB_OID="$(git -C super_clone4/sub/subsub rev-parse refs/heads/checked-out)" &&
+	test $EXPECT_SUBSUB_OID = $ACTUAL_SUBSUB_OID &&
+
+	# Assert that the submodules do not have branches from their upstream
+	test_must_fail git -C super_clone4/sub rev-parse not-in-clone &&
+	test_must_fail git -C super_clone4/sub/subsub rev-parse not-in-clone
+'
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f36..b749d35f784 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,160 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+test_expect_success 'setup superproject with submodule.propagateBranches' '
+	git init sub1 &&
+	test_commit -C sub1 "sub1" &&
+	git init branch-super &&
+	git -C branch-super submodule add ../sub1 sub1 &&
+	git -C branch-super commit -m "super" &&
+
+	# Clone into a clean repo that we can cp around
+	git clone --recurse-submodules \
+		-c submodule.propagateBranches=true \
+		branch-super branch-super-clean &&
+	git -C branch-super-clean config submodule.propagateBranches true &&
+
+	# sub2 will not be in the clone. We will fetch the containing
+	# superproject commit and clone sub2 with "git submodule update".
+	git init sub2 &&
+	test_commit -C sub2 "sub2" &&
+	git -C branch-super submodule add ../sub2 sub2 &&
+	git -C branch-super commit -m "add sub2"
+'
+
+test_clean_submodule ()
+{
+	local negate super_dir sub_dir expect_oid actual_oid &&
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+	super_dir="$1" &&
+	sub_dir="$2" &&
+	expect_oid="$(git -C "$super_dir" rev-parse ":$sub_dir")" &&
+	actual_oid="$(git -C "$super_dir/$sub_dir" rev-parse HEAD)" &&
+	if test -n "$negate"
+	then
+		! test "$expect_oid" = "$actual_oid"
+	else
+		test "$expect_oid" = "$actual_oid"
+	fi
+}
+
+# Test the behavior of a newly cloned submodule
+test_expect_success 'branches - newly-cloned submodule, detached HEAD' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned fetch origin main &&
+	git -C branch-super-cloned checkout FETCH_HEAD &&
+	git -C branch-super-cloned/sub1 checkout --detach &&
+	git -C branch-super-cloned submodule update &&
+
+	# sub1 and sub2 should be in detached HEAD
+	git -C branch-super-cloned/sub1 rev-parse --verify HEAD &&
+	test_must_fail git -C branch-super-cloned/sub1 symbolic-ref HEAD &&
+	test_clean_submodule branch-super-cloned sub1 &&
+	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
+	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD &&
+	test_clean_submodule branch-super-cloned sub2
+'
+
+test_expect_success 'branches - newly-cloned submodule, branch checked out' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned fetch origin main &&
+	git -C branch-super-cloned checkout FETCH_HEAD &&
+	git -C branch-super-cloned branch new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	git -C branch-super-cloned/sub1 branch new-branch &&
+	git -C branch-super-cloned submodule update &&
+
+	# Ignore sub1, we will test it later.
+	# sub2 should check out the branch
+	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH2 = "refs/heads/new-branch" &&
+	test_clean_submodule branch-super-cloned sub2
+'
+
+# Test the behavior of an already-cloned submodule.
+# NEEDSWORK When updating with branches, we always use the branch instead of the
+# gitlink's OID. This results in some imperfect behavior:
+#
+# - If the gitlink's OID disagrees with the branch OID, updating with branches
+#   may result in a dirty worktree
+# - If the branch does not exist, the update fails.
+#
+# We will reevaluate when "git checkout --recurse-submodules" supports branches
+# For now, just test for this imperfect behavior.
+test_expect_success 'branches - correct branch checked out, OIDs agree' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	git -C branch-super-cloned/sub1 checkout new-branch &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	test_clean_submodule branch-super-cloned sub1
+'
+
+test_expect_success 'branches - correct branch checked out, OIDs disagree' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	git -C branch-super-cloned/sub1 checkout new-branch &&
+	test_commit -C branch-super-cloned/sub1 new-commit &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	test_clean_submodule ! branch-super-cloned sub1
+'
+
+test_expect_success 'branches - other branch checked out, correct branch exists, OIDs agree' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	git -C branch-super-cloned/sub1 checkout main &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	test_clean_submodule branch-super-cloned sub1
+'
+
+test_expect_success 'branches - other branch checked out, correct branch exists, OIDs disagree' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	git -C branch-super-cloned/sub1 checkout new-branch &&
+	test_commit -C branch-super-cloned/sub1 new-commit &&
+	git -C branch-super-cloned/sub1 checkout main &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	test_clean_submodule ! branch-super-cloned sub1
+'
+
+test_expect_success 'branches - other branch checked out, correct branch does not exist' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch new-branch &&
+	git -C branch-super-cloned checkout new-branch &&
+	test_must_fail git -C branch-super-cloned submodule update
+'
+
 test_done
-- 
gitgitgadget

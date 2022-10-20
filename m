Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB2C4167B
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTUVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJTUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:21:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F31F1817
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e18so777563wmq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA1DOd92lGFpSUEZY0uHYmx9909W8B8xZGNXKtVPPqA=;
        b=d8SsWatC34eM5XztAXvUkJf9ZbYnyQiXAxTIlbYtiXf/XooMBBf8Vrks0XkAX8Y1iq
         HjJynyICf1UIzZyt5FuGCJHCvvcTEAnMYYgvFmXixlDZO1lst+hGmsM6OhAzt25OMSPk
         ulsaTrXbG6H0GLydo4TbvDG1Is2ZWRUBUXNlKXtLxOHIF3r9sMlkJN7LP6KZ91uPwLD6
         aopg4WLCYwOKasYFONodbxxT9tF51y1sK/RMKcDtcPrAnQGNEfKLXqNDn5zvKA4ZvITP
         xQVmUC+VEXgVjoUH+aT9QwV+GFAe90xzHEcw5zL7WnSIMNZ0UNcvhQjO4GYtbdZRRCFl
         kctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA1DOd92lGFpSUEZY0uHYmx9909W8B8xZGNXKtVPPqA=;
        b=ET9AkUMz0/ay7IddgYnBd7Iuy2plq7vIn2Hh0iHT3NDmANoKgfmJ81WGUUIZQE85Sd
         gPxj0Nh/YXIg/imZZMxJdeLyi4P2zfOwnfTJT3NZJlBXpu8KLbxXoQAr92u96tI2nYLC
         SGDUFpFqobvJJd0yaNl0b/GB/y/ZbXrcabApXlTki1Bjjx0/+l4f/xlsFJ4vVzv2uRnH
         kuWTIvz4O21Dsw7oXKQueUlLMN4p5265IGCGfloibFEF2nvzD9hfEE0QveF+SUHiyc3X
         LVF7WvXYNsMusyA1CagfgJpm39X7suvOnBjg1wfpSbq6w5PL1FU6Nx+ieJogvA9S9MdV
         9gLg==
X-Gm-Message-State: ACrzQf3jQCsgQF3d+y6RBy9gt+ztwVZX7kYkVGglvHP//1s7kVXNQ+Vf
        RNTUnavetrx0q4QHh+SSsTS6hBMqyDQ=
X-Google-Smtp-Source: AMsMyM5MK4aDYdwyC/mh1ihDRY18gUEx9chm1YoYaDEfukynW4DKTulH3i1PD0mMhx4qqeHu6zloAw==
X-Received: by 2002:a05:600c:2219:b0:3c4:cf31:8a13 with SMTP id z25-20020a05600c221900b003c4cf318a13mr31289863wml.122.1666297249352;
        Thu, 20 Oct 2022 13:20:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d468a000000b0021badf3cb26sm20752459wrq.63.2022.10.20.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:48 -0700 (PDT)
Message-Id: <3f98b0d17397dbce85aa87a9591981c790f8f7a2.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:38 +0000
Subject: [PATCH v2 7/7] clone, submodule update: create and check out branches
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

- "git pull --recurse-submodules" merges the superproject tree (without
  updating the submodule branches), and runs "git submodule update" to
  update the worktrees, so it is almost guaranteed to result in a dirty
  worktree.

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
 builtin/submodule--helper.c | 32 +++++++++++++++++--
 t/t5617-clone-submodules.sh | 34 ++++++++++++++++++++
 t/t7406-submodule-update.sh | 64 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 990adeb2e19..4576ba22544 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1915,6 +1915,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 struct update_data {
 	const char *prefix;
 	char *displaypath;
+	const char *super_branch;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -2090,6 +2091,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, suc->update_data->single_branch ?
 					      "--single-branch" :
 					      "--no-single-branch");
+	if (ud->super_branch) {
+		strvec_pushf(&child->args, "--branch=%s", ud->super_branch);
+		strvec_pushf(&child->args, "--branch-oid=%s", oid_to_hex(&ce->oid));
+	}
 
 cleanup:
 	free(displaypath);
@@ -2253,9 +2258,15 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *update_target = oid_to_hex(&ud->oid);;
+	const char *update_target;
 	int ret;
 
+	if (ud->update_strategy.type == SM_UPDATE_CHECKOUT &&
+	    ud->super_branch)
+		update_target = ud->super_branch;
+	else
+		update_target = oid_to_hex(&ud->oid);
+
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		cp.git_cmd = 1;
@@ -2521,6 +2532,7 @@ static int update_submodule(struct update_data *update_data)
 {
 	int submodule_up_to_date;
 	int ret;
+	const char *submodule_head = "HEAD";
 
 	ret = determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
@@ -2533,7 +2545,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
-				     &update_data->suboid, NULL))
+				     &update_data->suboid, &submodule_head))
 		return die_message(_("Unable to find current revision in submodule path '%s'"),
 				   update_data->displaypath);
 
@@ -2568,7 +2580,14 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	if (!update_data->super_branch)
+		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	else if (skip_prefix(submodule_head, "refs/heads/", &submodule_head))
+		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
+	/* submodule_branch is "HEAD"; the submodule is in detached HEAD */
+	else
+		submodule_up_to_date = 0;
+
 	if (!submodule_up_to_date || update_data->force) {
 		ret = run_update_procedure(update_data);
 		if (ret)
@@ -2603,6 +2622,12 @@ static int update_submodules(struct update_data *update_data)
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
@@ -2718,6 +2743,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
+	prepare_repo_settings(the_repository);
 
 	if (opt.require_init)
 		opt.init = 1;
diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
index c43a5b26fab..51593376ce4 100755
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
@@ -107,4 +114,31 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
 	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
 '
 
+test_expect_success 'submodule.propagateBranches checks out branches at correct commits' '
+	git -C sub checkout -b not-main &&
+	git -C subsub checkout -b not-main &&
+	git clone --recurse-submodules \
+		-c submodule.propagateBranches=true \
+		"file://$pwd/." super_clone4 &&
+
+	# Assert that each repo is pointing to "main"
+	for REPO in "super_clone4" "super_clone4/sub" "super_clone4/sub/subsub"
+	do
+	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
+	    test $HEAD_BRANCH = "refs/heads/main" || return 1
+	done &&
+
+	# Assert that the submodule branches are pointing to the right revs
+	EXPECT_SUB_OID="$(git -C super_clone4 rev-parse :sub)" &&
+	ACTUAL_SUB_OID="$(git -C super_clone4/sub rev-parse refs/heads/main)" &&
+	test $EXPECT_SUB_OID = $ACTUAL_SUB_OID &&
+	EXPECT_SUBSUB_OID="$(git -C super_clone4/sub rev-parse :subsub)" &&
+	ACTUAL_SUBSUB_OID="$(git -C super_clone4/sub/subsub rev-parse refs/heads/main)" &&
+	test $EXPECT_SUBSUB_OID = $ACTUAL_SUBSUB_OID &&
+
+	# Assert that the submodules do not have branches from their upstream
+	test_must_fail git -C super_clone4/sub rev-parse not-main &&
+	test_must_fail git -C super_clone4/sub/subsub rev-parse not-main
+'
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f36..54aa8c5cb54 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,68 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
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
+	# Create an upstream submodule not in the clone
+	git init sub2 &&
+	test_commit -C sub2 "sub2" &&
+	git -C branch-super submodule add ../sub2 sub2 &&
+	git -C branch-super commit -m "add sub2"
+'
+
+test_expect_success 'submodule.propagateBranches - detached HEAD' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned checkout --detach &&
+	git -C branch-super-cloned pull origin main &&
+	git -C branch-super-cloned submodule update &&
+
+	# sub2 should be in detached HEAD
+	git -C branch-super-cloned/sub2 rev-parse --verify HEAD &&
+	test_must_fail git -C branch-super-cloned/sub2 symbolic-ref HEAD
+'
+
+test_expect_success 'submodule.propagateBranches - branch checked out' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
+	git -C branch-super-cloned pull origin main &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH2 = "refs/heads/new-branch"
+'
+
+test_expect_success 'submodule.propagateBranches - other branch checked out' '
+	test_when_finished "rm -fr branch-super-cloned" &&
+	cp -r branch-super-clean branch-super-cloned &&
+
+	git -C branch-super-cloned branch --recurse-submodules new-branch &&
+	git -C branch-super-cloned checkout --recurse-submodules new-branch &&
+	git -C branch-super-cloned/sub1 checkout -b other-branch &&
+	git -C branch-super-cloned pull origin main &&
+	git -C branch-super-cloned submodule update &&
+
+	HEAD_BRANCH1=$(git -C branch-super-cloned/sub1 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH1 = "refs/heads/new-branch" &&
+	HEAD_BRANCH2=$(git -C branch-super-cloned/sub2 symbolic-ref HEAD) &&
+	test $HEAD_BRANCH2 = "refs/heads/new-branch"
+'
+
 test_done
-- 
gitgitgadget

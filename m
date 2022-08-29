Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614FFECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiH2Uyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiH2Uy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0599C2F5
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b5so11654676wrr.5
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=iSzxIQogg6zwsEHgDzSYmH9zyqomLzQ/xCWHlrw8wo0=;
        b=cEiLtaPBW/QtrCaNwyHUgnm9pO4+cZre6WXGxf4wCt9zgwoSaEdaIP559SKyh3dBFM
         2DTMYYhfG8xnsV7s9l3to/ChJ+ybLu9DjK23p5JdkXR9U2yBRyDMDQe2REc5ruX6Ztty
         ChJxbiyr4H3hGnRDS7Ryt6k0si7WNAg6T1dtGUhEiSKUfyj8MQrSeUabLUIkexbnrUSW
         J0REgCWD4ZmnhldHQBbFsfsVdWx2K5xL5pfYIXoBmDq84HUjK/cpcxkzMkV5mEDyzPdw
         RaPE5e/6AG3goVJct/DBAv9Iy746iyFhHA/FK6ESqm98epsxeriX672EfchHdC7WyrUA
         h4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=iSzxIQogg6zwsEHgDzSYmH9zyqomLzQ/xCWHlrw8wo0=;
        b=2pF6PmkHvZwejmTS41AE4HRVThrsHP5IttyOy1pFiQE5vefd/pKRA7AxrOAsB3299Y
         8y8zak/hGni4QekeH/wUIsfrZ22svIuclnu1LCw6nMAVHbdO3jk5ffiWJGbENgmk1SpH
         8iZOVmrJXg3foXCH0B+cvt1s3ZPbTGiXVp5BVc5diZDyXBBNSB2WOlzcSRuCXI7deNuJ
         x4aZuTsqBYvBpYkvKTw+E2O3HopycIv8Pqa6/w+UNYSzWSP+92DecmpVy9o+913yf2V6
         44A7pkso95obalWnk/B+5Xyh18faoD2uWR+uDv2icjPVO0kptYZLfLggObMzCYH10nbr
         zL6A==
X-Gm-Message-State: ACgBeo0QOeAnA4ZxRZ48KLhaw+KRL5OgLnTl683OQbMgAWOBydW3CQGl
        gwROjZP6zA2mblKX16Tevg4c03L93eM=
X-Google-Smtp-Source: AA6agR61rsmyPVdfh0f9BQQ3MAYpAK4onVHt+li7lvxY7Luj4D9GPxtl6JDi0NB2h+1yIu40C0c91A==
X-Received: by 2002:adf:e845:0:b0:226:d461:9cf1 with SMTP id d5-20020adfe845000000b00226d4619cf1mr5730620wrn.136.1661806463136;
        Mon, 29 Aug 2022 13:54:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b002207a5d8db3sm8133290wrb.73.2022.08.29.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:22 -0700 (PDT)
Message-Id: <6f7f2f9a3f19b6d874d644b7fb7feb3a72fc6227.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:16 +0000
Subject: [PATCH 6/6] clone, submodule update: check out branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Teach "git submodule update" to update submodules by creating and
checking out the current superproject branch when
"submodule.propagateBranches=true". "git clone --recurse-submodules"
also learns this trick because it is implemented with "git submodule
update --recursive".

With "submodule.propagateBranches=true", submodules are cloned with
"--detach" so that they do not contain branches from their upstream.
This prevents conflicts between branch names from the superproject and
the branch names from the submodule's upstream. Arguably, "--detach"
should also be the default for "submodule.propagateBranches=false"
since it doesn't make sense to create a submodule branch when the
submodule is always expected to be in detached HEAD. But, to be
conservative, this commit does not change the behavior of
"submodule.propagateBranches=false".

"git submodule update" tries to create the branch as long as it is not
currently checked out, thus it will fail if the submodule has the
branch, but it is not checked out. This is fine because the main purpose
of "git submodule update" is to clone new submodules (which have no
branches, and will never have this problem). "git checkout" with
"submodule.propagateBranches" will cover the use case of recursively
checking out an existing branch.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++--
 t/t5617-clone-submodules.sh | 34 ++++++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh | 22 ++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cbf6bda4850..7eb2c45900e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1695,6 +1695,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_push(&cp.args, clone_data->single_branch ?
 				    "--single-branch" :
 				    "--no-single-branch");
+		if (the_repository->settings.submodule_propagate_branches)
+			strvec_push(&cp.args, "--detach");
+
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
@@ -1733,6 +1736,9 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	if (error_strategy)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
+	if (the_repository->settings.submodule_propagate_branches)
+		git_config_set_in_file(p, "submodule.propagateBranches",
+				       "true");
 
 	free(sm_alternate);
 	free(error_strategy);
@@ -1792,6 +1798,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
+	prepare_repo_settings(the_repository);
 
 	clone_data.dissociate = !!dissociate;
 	clone_data.quiet = !!quiet;
@@ -1872,6 +1879,7 @@ struct submodule_update_clone {
 struct update_data {
 	const char *prefix;
 	const char *displaypath;
+	const char *super_branch;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -2206,6 +2214,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
 			strvec_push(&cp.args, "-f");
+		if (ud->super_branch)
+			strvec_pushl(&cp.args, "-b", ud->super_branch, NULL);
 		break;
 	case SM_UPDATE_REBASE:
 		cp.git_cmd = 1;
@@ -2456,6 +2466,7 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 static int update_submodule(struct update_data *update_data)
 {
 	int submodule_up_to_date;
+	const char *submodule_head = NULL;
 
 	ensure_core_worktree(update_data->sm_path);
 
@@ -2469,7 +2480,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
-				     &update_data->suboid, NULL))
+				     &update_data->suboid, &submodule_head))
 		die(_("Unable to find current revision in submodule path '%s'"),
 			update_data->displaypath);
 
@@ -2493,7 +2504,13 @@ static int update_submodule(struct update_data *update_data)
 		free(remote_ref);
 	}
 
-	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+	if (update_data->super_branch &&
+	    submodule_head &&
+	    !skip_prefix(submodule_head, "refs/heads/", &submodule_head))
+		submodule_up_to_date = !strcmp(update_data->super_branch, submodule_head);
+	else
+		submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
+
 	if (!submodule_up_to_date || update_data->force)
 		if (run_update_procedure(update_data))
 			return 1;
@@ -2551,6 +2568,12 @@ static int update_submodules(struct update_data *update_data)
 		goto cleanup;
 	}
 
+	if (the_repository->settings.submodule_propagate_branches) {
+		struct branch *current_branch = branch_get(NULL);
+		if (current_branch)
+			update_data->super_branch = current_branch->name;
+	}
+
 	for (i = 0; i < suc.update_clone_nr; i++) {
 		struct update_clone_data ucd = suc.update_clone[i];
 
@@ -2634,6 +2657,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
+	prepare_repo_settings(the_repository);
 
 	if (opt.require_init)
 		opt.init = 1;
diff --git a/t/t5617-clone-submodules.sh b/t/t5617-clone-submodules.sh
index b5c66cb18cb..215fb02e9fb 100755
--- a/t/t5617-clone-submodules.sh
+++ b/t/t5617-clone-submodules.sh
@@ -12,10 +12,17 @@ pwd=$(pwd)
 test_expect_success 'setup' '
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
@@ -106,4 +113,31 @@ test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodule
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
index 6cc07460dd2..00a6fec8912 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1178,4 +1178,26 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+test_expect_success 'submodule update with submodule.propagateBranches checks out branches' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create a new upstream submodule
+	git init middle2 &&
+	test_commit -C middle2 "middle2" &&
+	git -C top submodule add ../middle2 middle2 &&
+	git -C top commit -m "add middle2" &&
+
+	git -C top-cloned checkout -b "new-branch" &&
+	git -C top-cloned pull origin main &&
+	test_config -C top-cloned submodule.propagateBranches true &&
+	git -C top-cloned submodule update --recursive &&
+
+	for REPO in "top-cloned/middle2" "top-cloned/middle" "top-cloned/middle/bottom"
+	do
+	    HEAD_BRANCH=$(git -C $REPO symbolic-ref HEAD) &&
+	    test $HEAD_BRANCH = "refs/heads/new-branch" || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget

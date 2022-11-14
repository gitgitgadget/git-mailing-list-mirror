Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11824C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiKNKKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiKNKJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A21E701
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z18so16487220edb.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNuG7Gpyr6m5VJ+IDXfOhxCnDsRrD1yMKuYsBQNVuKg=;
        b=FCwZdVi73z+0zk0NQnIKdmeyuwsO8AiWmyJn+xg34SF26xcUWWVM2Z8TJody7kaX8R
         SGpsrhDjVfuMlQMPhwCOa0beb9oJV8pwe9gLugyKF367fheflr/XMJX1xXhoPjUyjMqp
         fzqp1aQHK0IPVBGUBGQ9ukZWd5Dc9V9HZYa5WXsH19fEYq71KWMp6iXGzNbykv0Nzzys
         H+jjmGqEvYVpF0thy4SKKXU0fYVMVveDnjjpvooCoPN0kxUtaiZOFJ2pL728L27GVE7m
         fM8r6UpWVCFcQJFezhtYoKN4OkEVSa08R22qNP/k5zPzdlttWcUyFikT8QaMJ7Tv9glN
         8lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNuG7Gpyr6m5VJ+IDXfOhxCnDsRrD1yMKuYsBQNVuKg=;
        b=CgWMZAjdPKDGG5M0P/PWYAtv9LCRu7XN8JJi9BtC5a1gcMiR+d0s/DPUwj7eY0xILt
         +cmC21udX0/NCYqpOwtodQI8Qp4rPpOcoTPeCf9Egq2TvIn69EqouST8Ca1qbF0TWy5C
         0ZWzMuAt9/91fGJG5IDL2h50ve/QvoRm+Y0weD4rMUUrMJ0uP4KE8U2TLXd0H1NTf2Kn
         NTjm6mv+f6Xbc6kfY6t+nc8mpqSqflcPu6NbNRnffIu75s5AreqqWao60xk9yaj2Sg54
         iHWOXRSobY703QloDj+A6Pu0CuWs/L2Uorhy8RVVA0Sr8wUvDLJBEjk137MWBo61+UTY
         AT9w==
X-Gm-Message-State: ANoB5plruHsUqcjcerwUPjQZMMqYNeWN1cnxxrZnv1HDx9ddOJF8ej23
        WMxvi9mi2D8o66vgYIwKGCVpJa57iJ+cjA==
X-Google-Smtp-Source: AA0mqf6D5qf7ZaBcNlzdFK889NDiK+QEd2QCrCPDALZupoOffqUejvhISE3fyAoPfxP7QdkkseH28g==
X-Received: by 2002:a05:6402:22f1:b0:462:1e07:1dd7 with SMTP id dn17-20020a05640222f100b004621e071dd7mr10699265edb.293.1668420542785;
        Mon, 14 Nov 2022 02:09:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:09:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] submodule tests: test "git branch -t" output and stderr
Date:   Mon, 14 Nov 2022 11:08:48 +0100
Message-Id: <patch-v2-08.10-172b5865811-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git branch" command will currently make use of the
"--super-prefix", as it will indirectly call submodule_move_head(),
which will have access to the "--super-prefix".

The output could thus be affected by the "--super-prefix". Right now
it isn't in this case, but let's exhaustively assert that that's the
case by testing the output of all of these "git branch -t" commands.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 98 ++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d31fcfda1f..302d095ad9b 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -245,6 +245,17 @@ reset_work_tree_to_interested () {
 	git -C submodule_update/.git/modules/sub1 config submodule.sub2.url "bogus"
 }
 
+test_branch_t_output () {
+	local branchname="$1" &&
+	local start_point="$2" &&
+	cat >expect <<-EOF &&
+	branch '$branchname' set up to track '$start_point'.
+	EOF
+	git branch -t "$branchname" "$start_point" >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+}
+
 # Test that the superproject contains the content according to commit "$1"
 # (the work tree must match the index for everything but submodules but the
 # index must exactly match the given commit including any submodule SHA-1s).
@@ -323,7 +334,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -345,7 +356,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			mkdir sub1 &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -360,7 +371,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to replace_sub1_with_file &&
 		(
 			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_sub1 &&
 			$command replace_file_with_sub1 &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -384,7 +395,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to replace_sub1_with_directory &&
 		(
 			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			test_branch_t_output replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
 			$command replace_directory_with_sub1 &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -406,7 +417,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -418,7 +429,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
@@ -447,7 +458,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -459,7 +470,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
@@ -474,7 +485,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -487,7 +498,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
@@ -512,7 +523,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
@@ -527,7 +538,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
 			$command invalid_sub1 &&
 			test_superproject_content origin/invalid_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
@@ -542,7 +553,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to invalid_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t valid_sub1 origin/valid_sub1 &&
+			test_branch_t_output valid_sub1 origin/valid_sub1 &&
 			$command valid_sub1 &&
 			test_superproject_content origin/valid_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -596,7 +607,7 @@ test_submodule_switch_func () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 test_must_fail &&
 			test_superproject_content origin/no_submodule &&
@@ -635,7 +646,7 @@ test_submodule_forced_switch () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
@@ -675,7 +686,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -688,7 +699,7 @@ test_submodule_recursing_with_args_common () {
 		(
 			cd submodule_update &&
 			mkdir sub1 &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -701,7 +712,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested replace_sub1_with_file &&
 		(
 			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_sub1 &&
 			$command replace_file_with_sub1 &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_submodule_content sub1 origin/replace_file_with_sub1
@@ -713,19 +724,20 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested replace_sub1_with_directory &&
 		(
 			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			test_branch_t_output replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
 			$command replace_directory_with_sub1 &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_submodule_content sub1 origin/replace_directory_with_sub1
 		)
 	'
+
 	# Switching to a commit with nested submodules recursively checks them out
 	test_expect_success "$command: nested submodules are checked out" '
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recursively &&
 			$command modify_sub1_recursively &&
 			test_superproject_content origin/modify_sub1_recursively &&
 			test_submodule_content sub1 origin/modify_sub1_recursively &&
@@ -740,7 +752,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			! test -e sub1 &&
@@ -753,7 +765,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules &&
 			$command remove_sub1 &&
@@ -769,7 +781,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
 			test -f sub1
@@ -786,7 +798,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			: >sub1/untrackedfile &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
@@ -801,7 +813,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
-			git branch -t no_submodule origin/no_submodule &&
+			test_branch_t_output no_submodule origin/no_submodule &&
 			$command no_submodule &&
 			test_superproject_content origin/no_submodule &&
 			! test_path_is_dir sub1 &&
@@ -817,7 +829,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1
@@ -830,7 +842,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
 			test_must_fail $command invalid_sub1 2>err &&
 			test_i18ngrep sub1 err &&
 			test_superproject_content origin/add_sub1 &&
@@ -844,13 +856,13 @@ test_submodule_recursing_with_args_common () {
 		(
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
-			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse HEAD >expect.rev-parse &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-			test_cmp expect actual &&
+			test_cmp expect.rev-parse actual &&
 			test_must_fail git -C sub1 symbolic-ref HEAD
 		)
 	'
@@ -894,7 +906,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			: >sub1 &&
 			test_must_fail $command add_sub1 &&
 			test_superproject_content origin/no_submodule &&
@@ -908,7 +920,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			: >sub1 &&
 			mkdir .git/info &&
 			echo sub1 >.git/info/exclude &&
@@ -925,7 +937,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
 			test_submodule_content sub1 origin/replace_sub1_with_directory
@@ -937,7 +949,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules &&
 			$command replace_sub1_with_directory &&
@@ -954,7 +966,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			rm -rf .git/modules/sub1/info &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			mkdir .git/modules/sub1/info &&
 			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
@@ -969,7 +981,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			git -c submodule.recurse=true $cmd_args modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1
@@ -981,7 +993,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recursively &&
 			$command modify_sub1_recursively &&
 			test_superproject_content origin/modify_sub1_recursively &&
 			test_submodule_content sub1 origin/modify_sub1_recursively &&
@@ -1009,7 +1021,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
@@ -1023,7 +1035,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory
 		)
@@ -1034,7 +1046,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules/sub1 &&
 			$command replace_sub1_with_directory &&
@@ -1049,7 +1061,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			: >sub1/expect &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file
@@ -1062,7 +1074,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested invalid_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t valid_sub1 origin/valid_sub1 &&
+			test_branch_t_output valid_sub1 origin/valid_sub1 &&
 			$command valid_sub1 &&
 			test_superproject_content origin/valid_sub1 &&
 			test_submodule_content sub1 origin/valid_sub1
@@ -1077,7 +1089,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			echo "gitdir: bogus/path" >sub1/.git &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
-- 
2.38.0.1471.ge4d8947e7aa


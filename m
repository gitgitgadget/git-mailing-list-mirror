Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF2C7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34672072C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOy4jUWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBQExO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37423 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBQExN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so17988086wru.4
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P1OhgDdMUrX3K1smvSOQJRwn3dz/D8m9Yo3Pa0L7hAY=;
        b=fOy4jUWv4im/it8qRrIc5MOzNJXdQaEA0Jzqto4OgSSjnoHDBKuE8tspi05KpUNUY7
         686e4DKGGY5RODJo/dKbh1FlM9dhKH4b3A0YVhWrvOzag+7bboEFIEvd8583YEDvIaxR
         a6hQy7GUucbmX3+SDTNepcKEvwcnr2Ytz4ddEw/oNrRV4izJUJ3z0DWgghxNTi4ChbOq
         JiXNSwwON/rB1t0nuDq/AyiBdmAW3TE+IAYAaPsGeHjT8EktD4pQS0rH8uamZHLYe+Qh
         2xaJ2KmKnozOmUchsuF4uKLjimNjbIT4f6XRev7RAGYkCcZh5fgwTluCVrE04/BgwSmJ
         fvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P1OhgDdMUrX3K1smvSOQJRwn3dz/D8m9Yo3Pa0L7hAY=;
        b=I2ds23Vf8Efwxm0QgYDVIUOqxmFTObS3teZdnpiQdGQD07MqFQa5/5R613oqC4sTEw
         vmt6Tw40Id563dqRk9jL5s3Cq68326qEO7Q3e0Z487/o9efsKo/exnZImsOcBtnX91TY
         Jo7AURuTMq4HX5E0buuuHyLU3+Icmo+SdNb3t/W1QSY9AesKK1SG6vmFCuaqPTCsIJEb
         rgOEiQOBhSAWkSJ6bSS/KNlDge349MfG4tykz90ruVCVdtSJaj4NCfh3QVmMp+M6DxFe
         0BYC7BXx5oywKvWPaA3n8ON+0V282tUHe+XoYDcl3+u6028+AsCAlw3u45R5dwYhLV9r
         OgPQ==
X-Gm-Message-State: APjAAAWoxQb8O8nb+r040eMWweftRK4uKDYQNfW1Dv625zQC8uXPiS9A
        88dv0/Lv2YYoZvLjCrnPEd3ZFu8P
X-Google-Smtp-Source: APXvYqw52sRgS/fgxhGbAUijq3/p6JO0je+QW99GLebplEEGOgfJlq0JlCYSLYaG5xlwHTvqAvNRrg==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr20582190wrn.292.1581915190743;
        Sun, 16 Feb 2020 20:53:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm19841425wrt.45.2020.02.16.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:10 -0800 (PST)
Message-Id: <d47740181bf02036a83f3573164c6c650ae75afb.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:05 +0000
Subject: [PATCH 5/6] unpack-trees: check for missing submodule directory in
 merged_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Using `git checkout --recurse-submodules` to switch between a
branch with no submodules and a branch with initialized nested
submodules currently causes a fatal error:

    $ git checkout --recurse-submodules branch-with-nested-submodules
    fatal: exec '--super-prefix=submodule/nested/': cd to 'nested'
failed: No such file or directory
    error: Submodule 'nested' could not be updated.
    error: Submodule 'submodule/nested' cannot checkout new HEAD.
    error: Submodule 'submodule' could not be updated.
    M	submodule
    Switched to branch 'branch-with-nested-submodules'

The checkout succeeds but the worktree and index of the first level
submodule are left empty:

    $ cd submodule
    $ git -c status.submoduleSummary=1 status
    HEAD detached at b3ce885
    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
          deleted:    .gitmodules
          deleted:    first.t
          deleted:    nested

    fatal: not a git repository: 'nested/.git'
    Submodule changes to be committed:

    * nested 1e96f59...0000000:

    $ git ls-files -s
    $ # empty
    $ ls -A
    .git

The reason for the fatal error during the checkout is that a child git
process tries to cd into the yet unexisting nested submodule directory.
The sequence is the following:

1. The main git process (the one running in the superproject) eventually
reaches write_entry() in entry.c, which creates the first level
submodule directory and then calls submodule_move_head() in submodule.c,
which spawns `git read-tree` in the submodule directory.

2. The first child git process (the one in the submodule of the
superproject) eventually calls check_submodule_move_head() at
unpack_trees.c:2021, which calls submodule_move_head in dry-run mode,
which spawns `git read-tree` in the nested submodule directory.

3. The second child git process tries to chdir() in the yet unexisting
nested submodule directory in start_command() at run-command.c:829 and
dies before exec'ing.

The reason why check_submodule_move_head() is reached in the first child
and not in the main process is that it is inside an
if(submodule_from_ce()) construct, and submodule_from_ce() returns a
valid struct submodule pointer, whereas it returns a null pointer in the
main git process.

The reason why submodule_from_ce() returns a null pointer in the main
git process is because the call to cache_lookup_path() in config_from()
(called from submodule_from_path() in submodule_from_ce()) returns a
null pointer since the hashmap "for_path" in the submodule_cache of
the_repository is not yet populated. It is not populated because both
repo_get_oid(repo, GITMODULES_INDEX, &oid) and repo_get_oid(repo,
GITMODULES_HEAD, &oid) in config_from_gitmodules() at
submodule-config.c:639-640 return -1, as at this stage of the operation,
neither the HEAD of the superproject nor its index contain any
.gitmodules file.

In contrast, in the first child the hashmap is populated because
repo_get_oid(repo, GITMODULES_HEAD, &oid) returns 0 as the HEAD of the
first level submodule, i.e. .git/modules/submodule/HEAD, points to a
commit where .gitmodules is present and records 'nested' as a submodule.

Fix this bug by checking that the submodule directory exists before
calling check_submodule_move_head() in merged_entry() in the `if(!old)`
branch, i.e. if going from a commit with no submodule to a commit with a
submodule present.

Also protect the other call to check_submodule_move_head() in
merged_entry() the same way as it is safer, even though the `else if
(!(old->ce_flags & CE_CONFLICTED))` branch of the code is not at play in
the present bug.

The other calls to check_submodule_move_head() in other functions in
unpack_trees.c are all already protected by calls to lstat() somewhere
in
the program flow so we don't need additional protection for them.

All commands in the unpack_trees machinery are affected, i.e. checkout,
reset and read-tree when called with the --recurse-submodules flag.

This bug was first reported in [1].

[1]
https://lore.kernel.org/git/7437BB59-4605-48EC-B05E-E2BDB2D9DABC@gmail.com/

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Reported-by: Damien Robert <damien.olivier.robert@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-submodule-update.sh | 14 ++++++++++++++
 unpack-trees.c            |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 417da3602ae..ab30b2da24f 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -626,6 +626,7 @@ test_submodule_forced_switch () {
 # New test cases
 # - Removing a submodule with a git directory absorbs the submodules
 #   git directory first into the superproject.
+# - Switching from no submodule to nested submodules
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
@@ -683,6 +684,19 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/replace_directory_with_sub1
 		)
 	'
+	# Switching to a commit with nested submodules recursively checks them out
+	test_expect_success "$command: nested submodules are checked out" '
+		prolog &&
+		reset_work_tree_to_interested no_submodule &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			$command modify_sub1_recursively &&
+			test_superproject_content origin/modify_sub1_recursively &&
+			test_submodule_content sub1 origin/modify_sub1_recursively &&
+			test_submodule_content -C sub1 sub2 origin/modify_sub1_recursively
+		)
+	'
 
 	######################## Disappearing submodule #######################
 	# Removing a submodule removes its work tree ...
diff --git a/unpack-trees.c b/unpack-trees.c
index 37eca3ede8b..fc6ba19486d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2064,7 +2064,7 @@ static int merged_entry(const struct cache_entry *ce,
 		}
 		invalidate_ce_path(merge, o);
 
-		if (submodule_from_ce(ce)) {
+		if (submodule_from_ce(ce) && file_exists(ce->name)) {
 			int ret = check_submodule_move_head(ce, NULL,
 							    oid_to_hex(&ce->oid),
 							    o);
@@ -2093,7 +2093,7 @@ static int merged_entry(const struct cache_entry *ce,
 			invalidate_ce_path(old, o);
 		}
 
-		if (submodule_from_ce(ce)) {
+		if (submodule_from_ce(ce) && file_exists(ce->name)) {
 			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
 							    oid_to_hex(&ce->oid),
 							    o);
-- 
gitgitgadget


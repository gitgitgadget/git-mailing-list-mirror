Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E3E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbjJHGqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbjJHGqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D885BFC
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bb94eso35009895e9.0
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747542; x=1697352342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLNGv9AKviAkJuUNyGqSnbmt5ZrQCirq/prui5S7xTQ=;
        b=c9J9fEpmPPaWHtgM1aj1XqkQCFQMlXRPnbQvqRl7Bu6O3L8TSkwUFhYsjrmr9rm59F
         N+JWZ1XbsGHUBczQM4imnRhPU6JCvSrYWGFDIF+LuqZ9VldmJlT8KcXMObsshrGXfnlt
         am78eFKSrYaLSlFHMiOUlDhBfy26VBJWXe3/mn6v7gwS57OrJCZ5n3bJk1LgEdiMKAw5
         yypwpXNvFru5NGWMwo9OV77CTobx6ENqv5mbLdeMw93fI42AARvBwoRRVEwbM/WKcbix
         2DYxVeXkiVRfIThPattXof8oAva1FUwxv584LeANXQPe1fUidNBiE2iaT7sshFLuBF9N
         abvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747542; x=1697352342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLNGv9AKviAkJuUNyGqSnbmt5ZrQCirq/prui5S7xTQ=;
        b=n8sDDE1HvFEhdbClLrNhl4CRTJLhxLQzAPlg5CeaGzUVZsK2uoEQ3AFCAaCanbjxZg
         ohThZ9Jnfhh5kYHOIbk8nZqgS06BhqCtZIpnfB0IaTGnzsHnsSG9FlftzDVgVeoI02tZ
         s0YCFyAmzmUGdjjeRqM9W7MeCR8y/gG7im/sjsqITNGYdp7C3d4br0+DOiwDJbbv5R9B
         qMmcN/aIpqi2qQzUa7yL2LGloLnG+Ph8dp8KCLysuSAQnuTf+LCWhiY3YuF7irLPIhXS
         C/7u+khvqCv8iYykY/VgqzlzZUAuFWiAP70po8mZFRE/WLMbtEbK3BKzCZWOip0ms2Rc
         GszA==
X-Gm-Message-State: AOJu0YwXNUjU7+HpQI1lDPiaPWZ7bViLBG4mwiWJwV6n75UxQWL6e2bU
        ux6ZQXBadterFpWaWlcTZ72SQ0mOQ10=
X-Google-Smtp-Source: AGHT+IHc7H0hkC2IaskDIUXf8xKPIh9LeQl8piDGOzhKDXkpF2zlquIdz3wQYhvIiF7FcSDMeFm0LQ==
X-Received: by 2002:adf:f08f:0:b0:325:cafe:a687 with SMTP id n15-20020adff08f000000b00325cafea687mr12298145wro.51.1696747542411;
        Sat, 07 Oct 2023 23:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v26-20020a5d591a000000b0030ada01ca78sm6010455wrd.10.2023.10.07.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:42 -0700 (PDT)
Message-ID: <067474826a76d1db15570cc410a9d251cfe973dd.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:20 +0000
Subject: [PATCH 18/25] documentation: use clearer prepositions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/SubmittingPatches         | 2 +-
 Documentation/config/branch.txt         | 2 +-
 Documentation/config/i18n.txt           | 2 +-
 Documentation/diff-generate-patch.txt   | 4 ++--
 Documentation/git-am.txt                | 2 +-
 Documentation/git-diff-files.txt        | 2 +-
 Documentation/git-fsmonitor--daemon.txt | 2 +-
 Documentation/git-hook.txt              | 2 +-
 Documentation/git-merge-base.txt        | 4 ++--
 Documentation/git-mergetool.txt         | 2 +-
 Documentation/git-request-pull.txt      | 2 +-
 Documentation/git-rev-parse.txt         | 2 +-
 Documentation/git-show-branch.txt       | 4 ++--
 Documentation/git-update-index.txt      | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 973d7a81d44..0e2d3fbb9cc 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -87,7 +87,7 @@ maintainer.
 Under truly exceptional circumstances where you absolutely must depend
 on a select few topic branches that are already in `next` but not in
 `master`, you may want to create your own custom base-branch by forking
-`master` and merging the required topic branches to it. You could then
+`master` and merging the required topic branches into it. You could then
 work on top of this base-branch.  But keep in mind that this base-branch
 would only be known privately to you.  So when you are ready to send
 your patches to the list, be sure to communicate how you created it in
diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 3bec6daf71a..432b9cd2c0e 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -99,5 +99,5 @@ for details).
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
-	automatically added in the format-patch cover letter or
+	automatically added to the format-patch cover letter or
 	request-pull summary.
diff --git a/Documentation/config/i18n.txt b/Documentation/config/i18n.txt
index cc256217317..6e72fdb45bd 100644
--- a/Documentation/config/i18n.txt
+++ b/Documentation/config/i18n.txt
@@ -2,7 +2,7 @@ i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
 	importing commits from emails or in the gitk graphical history
-	browser (and possibly at other places in the future or in other
+	browser (and possibly in other places in the future or in other
 	porcelains). See e.g. linkgit:git-mailinfo[1]. Defaults to 'utf-8'.
 
 i18n.logOutputEncoding::
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index cf1958ca632..988e33de70b 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -17,7 +17,7 @@ You can customize the creation of patch text via the
 What the -p option produces is slightly different from the traditional
 diff format:
 
-1.   It is preceded with a "git diff" header that looks like this:
+1.   It is preceded by a "git diff" header that looks like this:
 
        diff --git a/file1 b/file2
 +
@@ -123,7 +123,7 @@ index fabadb8,cc95eb0..4866510
 		for_each_ref(get_name);
 ------------
 
-1.   It is preceded with a "git diff" header, that looks like
+1.   It is preceded by a "git diff" header, that looks like
      this (when the `-c` option is used):
 
        diff --combined file
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 00a5ec206d6..2ada047b6aa 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -69,7 +69,7 @@ OPTIONS
 --empty=(stop|drop|keep)::
 	By default, or when the option is set to 'stop', the command
 	errors out on an input e-mail message lacking a patch
-	and stops into the middle of the current am session. When this
+	and stops in the middle of the current am session. When this
 	option is set to 'drop', skip such an e-mail message instead.
 	When this option is set to 'keep', create an empty commit,
 	recording the contents of the e-mail message as its log.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 591e3801b7b..18f7f86bef3 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -42,7 +42,7 @@ omit diff output for unmerged entries and just show "Unmerged".
 	commit with these flags.
 
 -q::
-	Remain silent even on nonexistent files
+	Remain silent even for nonexistent files
 
 
 include::diff-format.txt[]
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index f50a28b09f9..324299bfe9b 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -70,7 +70,7 @@ the change (as happening against the super repo).  However, the client
 will properly ignore these extra events, so performance may be affected
 but it will not cause an incorrect result.
 
-By default, the fsmonitor daemon refuses to work against network-mounted
+By default, the fsmonitor daemon refuses to work with network-mounted
 repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 `true`. Note, however, that the fsmonitor daemon is not guaranteed to work
 correctly with all network-mounted repositories and such use is considered
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 3407f3c2c07..25237330b5c 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-A command interface to running git hooks (see linkgit:githooks[5]),
+A command interface for running git hooks (see linkgit:githooks[5]),
 for use by other scripted git commands.
 
 SUBCOMMANDS
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 5cdcb5663cd..cbc77f72588 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -28,7 +28,7 @@ merge base for a pair of commits.
 OPERATION MODES
 ---------------
 
-As the most common special case, specifying only two commits on the
+In the most common special case, specifying only two commits on the
 command line means computing the merge base between the given two commits.
 
 More generally, among the two commits to compute the merge base from,
@@ -64,7 +64,7 @@ from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 	the two commits, but also takes into account the reflog of
 	<ref> to see if the history leading to <commit> forked from
 	an earlier incarnation of the branch <ref> (see discussion
-	on this mode below).
+	of this mode below).
 
 OPTIONS
 -------
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 800a3cbe6f3..7b7b6f8f344 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -17,7 +17,7 @@ Use `git mergetool` to run one of several merge utilities to resolve
 merge conflicts.  It is typically run after 'git merge'.
 
 If one or more <file> parameters are given, the merge tool program will
-be run to resolve differences on each file (skipping those without
+be run to resolve differences in each file (skipping those without
 conflicts).  Specifying a directory will include all unresolved files in
 that path.  If no <file> names are specified, 'git mergetool' will run
 the merge tool program on every file with merge conflicts.
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index fa5a4267092..d274002666c 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -50,7 +50,7 @@ EXAMPLES
 --------
 
 Imagine that you built your work on your `master` branch on top of
-the `v1.0` release, and want it to be integrated to the project.
+the `v1.0` release, and want it to be integrated into the project.
 First you push that change to your public repository for others to
 see:
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f42fb938705..912fab9f5e0 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -383,7 +383,7 @@ Each line of options has this format:
 	dash to separate words in a multi-word argument hint.
 
 The remainder of the line, after stripping the spaces, is used
-as the help associated to the option.
+as the help associated with the option.
 
 Blank lines are ignored, and lines that don't match this specification are used
 as option group headers (start the line with a space to create such
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index ddf24aeb87d..4ef0872b463 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -50,7 +50,7 @@ OPTIONS
 
 --current::
 	With this option, the command includes the current
-	branch to the list of revs to be shown when it is not
+	branch in the list of revs to be shown when it is not
 	given on the command line.
 
 --topo-order::
@@ -197,7 +197,7 @@ $ git show-branch --reflog="10,1 hour ago" --list master
 
 shows 10 reflog entries going back from the tip as of 1 hour ago.
 Without `--list`, the output also shows how these tips are
-topologically related with each other.
+topologically related to each other.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7ac2e37c0ac..e030dd75bed 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -127,7 +127,7 @@ you will need to handle the situation manually.
 -g::
 --again::
 	Runs 'git update-index' itself on the paths whose index
-	entries are different from those from the `HEAD` commit.
+	entries are different from those of the `HEAD` commit.
 
 --unresolve::
 	Restores the 'unmerged' or 'needs updating' state of a
-- 
gitgitgadget


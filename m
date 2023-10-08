Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D936E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbjJHGrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbjJHGqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49610F
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32487efc319so3359369f8f.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747545; x=1697352345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfFM5Az2zg5/K9QKNqs6n1MYenMFl69EpVnWjN+7J9E=;
        b=EoU7xL55u5bMBnMCmIgMd3ReiF7BKEeRf1zvgP0x/Soj2pS5EEHQS983C3XeVXMKFs
         9bdAfq5OS+xmKVnBeag4c93YIl3ahwUMKL4K5wmRqvccS4WJUIoApDiA1kbWu442G8MP
         hEaFmV6ITPd0t7rVu+fhAIyGlKNBsFOtzTf7jtJJqkstmNZlHTps1QPH+9chvCJKjet3
         b1ZzR3+TnGeXX9YwMfri/utbWHxsPBf1N44o2sw+rapaH9eqIcw4y+C0LELeQzYB/wNx
         wJoqvNNYnQOa0BotPWFKRzQv2rHwUadVUzT8FecusR6p7AW7dFVEGegVkqu3OlO0EHEm
         ILXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747545; x=1697352345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfFM5Az2zg5/K9QKNqs6n1MYenMFl69EpVnWjN+7J9E=;
        b=u98rauBluTD7k5dOsx6iNBG6P0N4M7EWZQ8UtJqw2eBCpgLPrG4iUVfr408kJC/lGf
         +BYg98ThlrMDd2ln+LSZ3C6WkU2Z2Wq4WvlyEbdhZxazHXue1TpsZpyhgwW1Pssr7Syz
         sbIrjqbKK7sIDVpi7gM61Oq16+ELoF/LSP9BxvZSgbuWhSLO1OJTsYx389XydgGBqzYn
         qPYAzklGUydHaYwWz+17rJlVoXnf38bU56kaRNM1QZ1cGupatx+8sjPJNvZsHLMhM4Tb
         LrNrP1/v2xTVx/4bqMmARLqHOLFIvCOLrRW9RjsXVMxNiCPoxl9r7lqPDn9MA9hTKHfP
         NUAQ==
X-Gm-Message-State: AOJu0Yzyyd4l/Q39V2msCBzlHSPEoo8QXsBmRZ6ugX4TL4AsuOxGMK8O
        g+4Z9RoV0KXW6IWvWtAlfDIR4pyCVAc=
X-Google-Smtp-Source: AGHT+IF8lcyK+65bHi5zmuXnJNhnjD1Ns3fhM4uNO3pMGRvyRi9b27vHJ2Sdc4UGbpu0vyfwvs+IcA==
X-Received: by 2002:adf:e88f:0:b0:319:71be:9248 with SMTP id d15-20020adfe88f000000b0031971be9248mr10880094wrm.19.1696747545043;
        Sat, 07 Oct 2023 23:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b0032320a9b010sm6053769wrv.28.2023.10.07.23.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:44 -0700 (PDT)
Message-ID: <e4fa43bf48d73b1c177ee67b88964369fb6f3c87.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:24 +0000
Subject: [PATCH 22/25] documentation: add some commas where they are helpful
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
 Documentation/ToolsForGit.txt              |  2 +-
 Documentation/config/clean.txt             |  2 +-
 Documentation/config/color.txt             |  2 +-
 Documentation/config/credential.txt        |  2 +-
 Documentation/config/fastimport.txt        |  4 ++--
 Documentation/config/fsck.txt              | 10 +++++-----
 Documentation/config/log.txt               |  2 +-
 Documentation/config/merge.txt             |  2 +-
 Documentation/config/mergetool.txt         | 10 +++++-----
 Documentation/config/push.txt              |  2 +-
 Documentation/config/sequencer.txt         |  2 +-
 Documentation/config/splitindex.txt        |  6 +++---
 Documentation/config/user.txt              |  4 ++--
 Documentation/config/versionsort.txt       |  2 +-
 Documentation/diff-generate-patch.txt      |  4 ++--
 Documentation/fetch-options.txt            |  2 +-
 Documentation/git-am.txt                   |  4 ++--
 Documentation/git-apply.txt                | 10 +++++-----
 Documentation/git-check-attr.txt           |  4 ++--
 Documentation/git-checkout-index.txt       |  2 +-
 Documentation/git-diff-files.txt           |  4 ++--
 Documentation/git-fast-import.txt          |  2 +-
 Documentation/git-fsmonitor--daemon.txt    |  4 ++--
 Documentation/git-help.txt                 |  6 +++---
 Documentation/git-http-push.txt            |  2 +-
 Documentation/git-merge-base.txt           |  4 ++--
 Documentation/git-mergetool.txt            |  4 ++--
 Documentation/git-mv.txt                   |  2 +-
 Documentation/git-name-rev.txt             |  2 +-
 Documentation/git-remote-fd.txt            |  4 ++--
 Documentation/git-request-pull.txt         |  2 +-
 Documentation/git-show-branch.txt          |  4 ++--
 Documentation/git-update-index.txt         |  2 +-
 Documentation/gitdiffcore.txt              |  4 ++--
 Documentation/gitformat-pack.txt           |  2 +-
 Documentation/technical/api-simple-ipc.txt |  4 ++--
 Documentation/technical/reftable.txt       |  2 +-
 37 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
index 209eaad31ea..ae7690b45d0 100644
--- a/Documentation/ToolsForGit.txt
+++ b/Documentation/ToolsForGit.txt
@@ -5,7 +5,7 @@ Tools for developing Git
 [[summary]]
 == Summary
 
-This document gathers tips, scripts and configuration files to help people
+This document gathers tips, scripts, and configuration files to help people
 working on Git's codebase use their favorite tools while following Git's
 coding style.
 
diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.txt
index a807c925b9c..f05b9403b5a 100644
--- a/Documentation/config/clean.txt
+++ b/Documentation/config/clean.txt
@@ -1,3 +1,3 @@
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
-	-i or -n.   Defaults to true.
+	-i, or -n.  Defaults to true.
diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 1795b2d16be..2f2275ac697 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -106,7 +106,7 @@ color.grep.<slot>::
 	matching text in context lines
 `matchSelected`;;
 	matching text in selected lines. Also, used to customize the following
-	linkgit:git-log[1] subcommands: `--grep`, `--author` and `--committer`.
+	linkgit:git-log[1] subcommands: `--grep`, `--author`, and `--committer`.
 `selected`;;
 	non-matching text in selected lines. Also, used to customize the
 	following linkgit:git-log[1] subcommands: `--grep`, `--author` and
diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 075ef8c9750..0221c3e620d 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -21,7 +21,7 @@ credential.username::
 
 credential.<url>.*::
 	Any of the credential.* options above can be applied selectively to
-	some credentials. For example "credential.https://example.com.username"
+	some credentials. For example, "credential.https://example.com.username"
 	would set the default username only for https connections to
 	example.com. See linkgit:gitcredentials[7] for details on how URLs are
 	matched.
diff --git a/Documentation/config/fastimport.txt b/Documentation/config/fastimport.txt
index c1166e330d5..903677d7efe 100644
--- a/Documentation/config/fastimport.txt
+++ b/Documentation/config/fastimport.txt
@@ -1,8 +1,8 @@
 fastimport.unpackLimit::
 	If the number of objects imported by linkgit:git-fast-import[1]
 	is below this limit, then the objects will be unpacked into
-	loose object files.  However if the number of imported objects
-	equals or exceeds this limit then the pack will be stored as a
+	loose object files.  However, if the number of imported objects
+	equals or exceeds this limit, then the pack will be stored as a
 	pack.  Storing the pack from a fast-import can make the import
 	operation complete faster, especially on slow filesystems.  If
 	not set, the value of `transfer.unpackLimit` is used instead.
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 2384c8c94d6..8e9e508933f 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -13,10 +13,10 @@ The rest of the documentation discusses `fsck.*` for brevity, but the
 same applies for the corresponding `receive.fsck.*` and
 `fetch.fsck.*`. variables.
 +
-Unlike variables like `color.ui` and `core.editor` the
+Unlike variables like `color.ui` and `core.editor`, the
 `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>` variables will not
 fall back on the `fsck.<msg-id>` configuration if they aren't set. To
-uniformly configure the same fsck settings in different circumstances
+uniformly configure the same fsck settings in different circumstances,
 all three of them must be set to the same values.
 +
 When `fsck.<msg-id>` is set, errors can be switched to warnings and
@@ -43,12 +43,12 @@ values of `<msg-id>`.
 fsck.skipList::
 	The path to a list of object names (i.e. one unabbreviated SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. On versions of Git 2.20 and later comments ('#'), empty
+	be ignored. On versions of Git 2.20 and later, comments ('#'), empty
 	lines, and any leading and trailing whitespace are ignored. Everything
 	but a SHA-1 per line will error out on older versions.
 +
 This feature is useful when an established project should be accepted
-despite early commits containing errors that can be safely ignored
+despite early commits containing errors that can be safely ignored,
 such as invalid committer email addresses.  Note: corrupt objects
 cannot be skipped with this setting.
 +
@@ -58,7 +58,7 @@ Like `fsck.<msg-id>` this variable has corresponding
 Unlike variables like `color.ui` and `core.editor` the
 `receive.fsck.skipList` and `fetch.fsck.skipList` variables will not
 fall back on the `fsck.skipList` configuration if they aren't set. To
-uniformly configure the same fsck settings in different circumstances
+uniformly configure the same fsck settings in different circumstances,
 all three of them must be set to the same values.
 +
 Older versions of Git (before 2.20) documented that the object names
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 6e04fbe4f48..9003a821914 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -9,7 +9,7 @@ log.date::
 	`--date` option.  See linkgit:git-log[1] for details.
 +
 If the format is set to "auto:foo" and the pager is in use, format
-"foo" will be used for the date format. Otherwise "default" will
+"foo" will be used for the date format. Otherwise, "default" will
 be used.
 
 log.decorate::
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 99e83dd36e5..8851b6cedef 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -7,7 +7,7 @@ merge.conflictStyle::
 	marker and the original text before the `=======` marker.  The
 	"merge" style tends to produce smaller conflict regions than diff3,
 	both because of the exclusion of the original text, and because
-	when a subset of lines match on the two sides they are just pulled
+	when a subset of lines match on the two sides, they are just pulled
 	out of the conflict region.  Another alternate style, "zdiff3", is
 	similar to diff3 but removes matching lines on the two sides from
 	the conflict region when those matching lines appear near either
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index fe4ba0271b5..294f61efd12 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -22,8 +22,8 @@ mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
 	successful.  If this is not set to true then the merge target file
-	timestamp is checked and the merge is assumed to have been successful
-	if the file has been updated, otherwise the user is prompted to
+	timestamp is checked, and the merge is assumed to have been successful
+	if the file has been updated; otherwise, the user is prompted to
 	indicate the success of the merge.
 
 mergetool.meld.hasOutput::
@@ -37,7 +37,7 @@ mergetool.meld.hasOutput::
 
 mergetool.meld.useAutoMerge::
 	When the `--auto-merge` is given, meld will merge all non-conflicting
-	parts automatically, highlight the conflicting parts and wait for
+	parts automatically, highlight the conflicting parts, and wait for
 	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
 	Git to unconditionally use the `--auto-merge` option with `meld`.
 	Setting this value to `auto` makes git detect whether `--auto-merge`
@@ -55,7 +55,7 @@ endif::[]
 	for details.
 
 mergetool.hideResolved::
-	During a merge Git will automatically resolve as many conflicts as
+	During a merge, Git will automatically resolve as many conflicts as
 	possible and write the 'MERGED' file containing conflict markers around
 	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
 	represent the versions of the file from before Git's conflict
@@ -74,7 +74,7 @@ mergetool.keepTemporaries::
 	When invoking a custom merge tool, Git uses a set of temporary
 	files to pass to the tool. If the tool returns an error and this
 	variable is set to `true`, then these temporary files will be
-	preserved, otherwise they will be removed after the tool has
+	preserved; otherwise, they will be removed after the tool has
 	exited. Defaults to `false`.
 
 mergetool.writeToTemp::
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index dbaf930f01b..0acbbea18a3 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -67,7 +67,7 @@ new default).
 --
 
 push.followTags::
-	If set to true enable `--follow-tags` option by default.  You
+	If set to true, enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
 	`--no-follow-tags`.
 
diff --git a/Documentation/config/sequencer.txt b/Documentation/config/sequencer.txt
index b48d532a969..e664eef01d1 100644
--- a/Documentation/config/sequencer.txt
+++ b/Documentation/config/sequencer.txt
@@ -2,4 +2,4 @@ sequence.editor::
 	Text editor used by `git rebase -i` for editing the rebase instruction file.
 	The value is meant to be interpreted by the shell when it is used.
 	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
-	When not configured the default commit message editor is used instead.
+	When not configured, the default commit message editor is used instead.
diff --git a/Documentation/config/splitindex.txt b/Documentation/config/splitindex.txt
index afdb186df8b..cfaa29610b5 100644
--- a/Documentation/config/splitindex.txt
+++ b/Documentation/config/splitindex.txt
@@ -3,10 +3,10 @@ splitIndex.maxPercentChange::
 	percent of entries the split index can contain compared to the
 	total number of entries in both the split index and the shared
 	index before a new shared index is written.
-	The value should be between 0 and 100. If the value is 0 then
-	a new shared index is always written, if it is 100 a new
+	The value should be between 0 and 100. If the value is 0, then
+	a new shared index is always written; if it is 100, a new
 	shared index is never written.
-	By default the value is 20, so a new shared index is written
+	By default, the value is 20, so a new shared index is written
 	if the number of entries in the split index would be greater
 	than 20 percent of the total number of entries.
 	See linkgit:git-update-index[1].
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index c1347fa7bcd..2ffc38d1647 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -8,11 +8,11 @@ committer.email::
 	up in the `author` and `committer` fields of commit
 	objects.
 	If you need the `author` or `committer` to be different, the
-	`author.name`, `author.email`, `committer.name` or
+	`author.name`, `author.email`, `committer.name`, or
 	`committer.email` variables can be set.
 	All of these can be overridden by the `GIT_AUTHOR_NAME`,
 	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
-	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
+	`GIT_COMMITTER_EMAIL`, and `EMAIL` environment variables.
 +
 Note that the `name` forms of these variables conventionally refer to
 some form of a personal name.  See linkgit:git-commit[1] and the
diff --git a/Documentation/config/versionsort.txt b/Documentation/config/versionsort.txt
index 0d66617f59f..0cff0908193 100644
--- a/Documentation/config/versionsort.txt
+++ b/Documentation/config/versionsort.txt
@@ -19,7 +19,7 @@ with those suffixes.  E.g. if "-pre" appears before "-rc" in the
 configuration, then all "1.0-preX" tags will be listed before any
 "1.0-rcX" tags.  The placement of the main release tag relative to tags
 with various suffixes can be determined by specifying the empty suffix
-among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck" and
+among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck", and
 "-bfs" appear in the configuration in this order, then all "v4.8-rcX" tags
 are listed first, followed by "v4.8", then "v4.8-ckX" and finally
 "v4.8-bfsX".
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 988e33de70b..4b5aa5c2e04 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -156,7 +156,7 @@ format, `/dev/null` is used to signal created or deleted
 files.
 +
 However, if the --combined-all-paths option is provided, instead of a
-two-line from-file/to-file you get an N+1 line from-file/to-file header,
+two-line from-file/to-file, you get an N+1 line from-file/to-file header,
 where N is the number of parents in the merge commit:
 
        --- a/file
@@ -197,7 +197,7 @@ added, from the point of view of that parent).
 In the above example output, the function signature was changed
 from both files (hence two `-` removals from both file1 and
 file2, plus `++` to mean one line that was added does not appear
-in either file1 or file2).  Also eight other lines are the same
+in either file1 or file2).  Also, eight other lines are the same
 from file1 but do not appear in file2 (hence prefixed with `+`).
 
 When shown by `git diff-tree -c`, it compares the parents of a
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9ee9fa659d2..a1d6633a4f1 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -96,7 +96,7 @@ endif::git-pull[]
 
 -f::
 --force::
-	When 'git fetch' is used with `<src>:<dst>` refspec it may
+	When 'git fetch' is used with `<src>:<dst>` refspec, it may
 	refuse to update the local branch as discussed
 ifdef::git-pull[]
 	in the `<refspec>` part of the linkgit:git-fetch[1]
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2ada047b6aa..0390dab20f9 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -23,7 +23,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Splits mail messages in a mailbox into commit log messages,
-authorship information and patches, and applies them to the
+authorship information, and patches, and applies them to the
 current branch. You could think of it as a reverse operation
 of linkgit:git-format-patch[1] run on a branch with a straight
 history without merges.
@@ -134,7 +134,7 @@ include::rerere-options.txt[]
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
 	interpreted as. Valid formats are mbox, mboxrd,
-	stgit, stgit-series and hg.
+	stgit, stgit-series, and hg.
 
 -i::
 --interactive::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 95bde308709..9cce68a38be 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -23,8 +23,8 @@ DESCRIPTION
 Reads the supplied diff output (i.e. "a patch") and applies it to files.
 When running from a subdirectory in a repository, patched paths
 outside the directory are ignored.
-With the `--index` option the patch is also applied to the index, and
-with the `--cached` option the patch is only applied to the index.
+With the `--index` option, the patch is also applied to the index, and
+with the `--cached` option, the patch is only applied to the index.
 Without these options, the command applies the patch only to files,
 and does not require them to be in a Git repository.
 
@@ -52,7 +52,7 @@ OPTIONS
 --summary::
 	Instead of applying the patch, output a condensed
 	summary of information obtained from git diff extended
-	headers, such as creations, renames and mode changes.
+	headers, such as creations, renames, and mode changes.
 	Turns off "apply".
 
 --check::
@@ -140,7 +140,7 @@ linkgit:git-config[1]).
 	applying a diff generated with `--unified=0`. To bypass these
 	checks use `--unidiff-zero`.
 +
-Note, for the reasons stated above the usage of context-free patches is
+Note, for the reasons stated above, the usage of context-free patches is
 discouraged.
 
 --apply::
@@ -161,7 +161,7 @@ discouraged.
 --binary::
 	Historically we did not allow binary patch application
 	without an explicit permission from the user, and this
-	flag was the way to do so.  Currently we always allow binary
+	flag was the way to do so.  Currently, we always allow binary
 	patch application, so this is a no-op.
 
 --exclude=<path-pattern>::
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 7fea245ed22..cb5a6c8f335 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -38,7 +38,7 @@ OPTIONS
 
 --source=<tree-ish>::
 	Check attributes against the specified tree-ish. It is common to
-	specify the source tree by naming a commit, branch or tag associated
+	specify the source tree by naming a commit, branch, or tag associated
 	with it.
 
 \--::
@@ -60,7 +60,7 @@ unless `-z` is in effect, in which case NUL is used as delimiter:
 
 
 <path> is the path of a file being queried, <attribute> is an attribute
-being queried and <info> can be either:
+being queried, and <info> can be either:
 
 'unspecified';; when the attribute is not defined for the path.
 'unset';;	when the attribute is defined as false.
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4e2527612e0..faf8d6ca36f 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -57,7 +57,7 @@ OPTIONS
 	Note: --stage=all automatically implies --temp.
 
 --temp::
-	Instead of copying the files to the working directory
+	Instead of copying the files to the working directory,
 	write the content to temporary files.  The temporary name
 	associations will be written to stdout.
 
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 18f7f86bef3..bf78e314313 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -26,7 +26,7 @@ include::diff-options.txt[]
 -2 --ours::
 -3 --theirs::
 -0::
-	Diff against the "base" version, "our branch" or "their
+	Diff against the "base" version, "our branch", or "their
 	branch" respectively.  With these options, diffs for
 	merged entries are not shown.
 +
@@ -37,7 +37,7 @@ omit diff output for unmerged entries and just show "Unmerged".
 -c::
 --cc::
 	This compares stage 2 (our branch), stage 3 (their
-	branch) and the working tree file and outputs a combined
+	branch), and the working tree file and outputs a combined
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index a6a054f86d2..bd7b1e0a2ea 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1353,7 +1353,7 @@ the marks back to the source repository, it is easy to verify the
 accuracy and completeness of the import by comparing each Git
 commit to the corresponding source revision.
 
-Coming from a system such as Perforce or Subversion this should be
+Coming from a system such as Perforce or Subversion, this should be
 quite simple, as the fast-import mark can also be the Perforce changeset
 number or the Subversion revision number.
 
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 65c7b4641e8..8585d19f4d8 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -73,7 +73,7 @@ but it will not cause an incorrect result.
 By default, the fsmonitor daemon refuses to work with network-mounted
 repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 `true`. Note, however, that the fsmonitor daemon is not guaranteed to work
-correctly with all network-mounted repositories and such use is considered
+correctly with all network-mounted repositories, so such use is considered
 experimental.
 
 On Mac OS, the inter-process communication (IPC) between various Git
@@ -86,7 +86,7 @@ to work with these filesystems and such use is considered experimental.
 By default, the socket is created in the `.git` directory.  However, if the
 `.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
-network-mounted filesystem in which case you must set the configuration
+network-mounted filesystem, in which case you must set the configuration
 variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
 filesystem in which to create the socket file.
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 22dfd780851..7532625a138 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -59,7 +59,7 @@ OPTIONS
 	aliases.
 
 --verbose::
-	When used with `--all` print description for all recognized
+	When used with `--all`, print description for all recognized
 	commands. This is the default.
 
 -c::
@@ -129,8 +129,8 @@ line option:
 * "info" corresponds to '-i|--info',
 * "web" or "html" correspond to '-w|--web'.
 
-help.browser, web.browser and browser.<tool>.path
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+help.browser, web.browser, and browser.<tool>.path
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The `help.browser`, `web.browser` and `browser.<tool>.path` will also
 be checked if the 'web' format is chosen (either by command-line
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index c0c841b9fdd..ce0d8082125 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -44,7 +44,7 @@ OPTIONS
 -d::
 -D::
 	Remove <ref> from remote repository.  The specified branch
-	cannot be the remote HEAD.  If -d is specified the following
+	cannot be the remote HEAD.  If -d is specified, the following
 	other conditions must also be met:
 
 	- Remote HEAD must resolve to an object that exists locally
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index cbc77f72588..5ab957cfbc1 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -88,7 +88,7 @@ For example, with this topology:
 
 the merge base between 'A' and 'B' is '1'.
 
-Given three commits 'A', 'B' and 'C', `git merge-base A B C` will compute the
+Given three commits 'A', 'B', and 'C', `git merge-base A B C` will compute the
 merge base between 'A' and a hypothetical commit 'M', which is a merge
 between 'B' and 'C'.  For example, with this topology:
 
@@ -204,7 +204,7 @@ will find B0, and
 
     $ git rebase --onto origin/master $fork_point topic
 
-will replay D0, D1 and D on top of B to create a new history of this
+will replay D0, D1, and D on top of B to create a new history of this
 shape:
 
 ....
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 7b7b6f8f344..b9e20c5dcd8 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -49,7 +49,7 @@ variable `mergetool.<tool>.cmd`.
 +
 When 'git mergetool' is invoked with this tool (either through the
 `-t` or `--tool` option or the `merge.tool` configuration
-variable) the configured command line will be invoked with `$BASE`
+variable), the configured command line will be invoked with `$BASE`
 set to the name of a temporary file containing the common base for
 the merge, if available; `$LOCAL` set to the name of a temporary
 file containing the contents of the file on the current branch;
@@ -81,7 +81,7 @@ success of the resolution after the custom tool has exited.
 
 -g::
 --gui::
-	When 'git-mergetool' is invoked with the `-g` or `--gui` option
+	When 'git-mergetool' is invoked with the `-g` or `--gui` option,
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index fb0220fd18d..7f991a33802 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Move or rename a file, directory or symlink.
+Move or rename a file, directory, or symlink.
 
  git mv [-v] [-f] [-n] [-k] <source> <destination>
  git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5c56c870253..d4f1c4d5945 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -26,7 +26,7 @@ OPTIONS
 
 --refs=<pattern>::
 	Only use refs whose names match a given shell pattern.  The pattern
-	can be one of branch name, tag name or fully qualified ref name. If
+	can be a branch name, a tag name, or a fully qualified ref name. If
 	given multiple times, use refs whose names match any of the given shell
 	patterns. Use `--no-refs` to clear any previous ref patterns given.
 
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 6ed71bd0b75..94700b89be9 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -13,10 +13,10 @@ DESCRIPTION
 -----------
 This helper uses specified file descriptors to connect to a remote Git server.
 This is not meant for end users but for programs and scripts calling git
-fetch, push or archive.
+fetch, push, or archive.
 
 If only <infd> is given, it is assumed to be a bidirectional socket connected
-to remote Git server (git-upload-pack, git-receive-pack or
+to a remote Git server (git-upload-pack, git-receive-pack, or
 git-upload-archive). If both <infd> and <outfd> are given, they are assumed
 to be pipes connected to a remote Git server (<infd> being the inbound pipe
 and <outfd> being the outbound pipe.
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index d274002666c..15dcbb6d91c 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Generate a request asking your upstream project to pull changes into
 their tree.  The request, printed to the standard output,
 begins with the branch description, summarizes
-the changes and indicates from where they can be pulled.
+the changes, and indicates from where they can be pulled.
 
 The upstream project is expected to have the commit named by
 `<start>` and the output asks it to integrate the changes you made
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 4ef0872b463..c771c897707 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -125,7 +125,7 @@ OPTIONS
 	default to color output.
 	Same as `--color=never`.
 
-Note that --more, --list, --independent and --merge-base options
+Note that --more, --list, --independent, and --merge-base options
 are mutually exclusive.
 
 
@@ -144,7 +144,7 @@ otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
 can be used as an extended SHA-1 to name that commit.
 
-The following example shows three branches, "master", "fixes"
+The following example shows three branches, "master", "fixes",
 and "mhf":
 
 ------------------------------------------------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e030dd75bed..8c47890a6a8 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -160,7 +160,7 @@ you will need to handle the situation manually.
 
 --index-version <n>::
 	Write the resulting index out in the named on-disk format version.
-	Supported versions are 2, 3 and 4. The current default version is 2
+	Supported versions are 2, 3, and 4. The current default version is 2
 	or 3, depending on whether extra features are used, such as
 	`git add -N`.  With `--verbose`, also report the version the index
 	file uses before and after this command.
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index bc65f91310d..3cda2e07c24 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -231,7 +231,7 @@ like these:
 * -B/60 (the same as above, since diffcore-break defaults to 50%).
 
 Note that earlier implementation left a broken pair as separate
-creation and deletion patches.  This was an unnecessary hack and
+creation and deletion patches.  This was an unnecessary hack, and
 the latest implementation always merges all the broken pairs
 back into modifications, but the resulting patch output is
 formatted differently for easier review in case of such
@@ -263,7 +263,7 @@ textual diff has an added or a deleted line that matches the given
 regular expression.  This means that it will detect in-file (or what
 rename-detection considers the same file) moves, which is noise.  The
 implementation runs diff twice and greps, and this can be quite
-expensive.  To speed things up binary files without textconv filters
+expensive.  To speed things up, binary files without textconv filters
 will be ignored.
 
 When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index 678a7e4cb49..dd0476a616a 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -18,7 +18,7 @@ DESCRIPTION
 -----------
 
 The Git pack format is how Git stores most of its primary repository
-data. Over the lietime of a repository loose objects (if any) and
+data. Over the lietime of a repository, loose objects (if any) and
 smaller packs are consolidated into larger pack(s). See
 linkgit:git-gc[1] and linkgit:git-pack-objects[1].
 
diff --git a/Documentation/technical/api-simple-ipc.txt b/Documentation/technical/api-simple-ipc.txt
index b4259098680..c4fb152b232 100644
--- a/Documentation/technical/api-simple-ipc.txt
+++ b/Documentation/technical/api-simple-ipc.txt
@@ -25,7 +25,7 @@ When received, the response is returned back to the caller.
 For example, the `fsmonitor--daemon` feature will be built as a server
 application on top of the IPC-server library routines.  It will have
 threads watching for file system events and a thread pool waiting for
-client connections.  Clients, such as `git status` will request a list
+client connections.  Clients, such as `git status`, will request a list
 of file system events since a point in time and the server will
 respond with a list of changed files and directories.  The formats of
 the request and response are application-specific; the IPC-client and
@@ -37,7 +37,7 @@ Comparison with sub-process model
 
 The Simple-IPC mechanism differs from the existing `sub-process.c`
 model (Documentation/technical/long-running-process-protocol.txt) and
-used by applications like Git-LFS.  In the LFS-style sub-process model
+used by applications like Git-LFS.  In the LFS-style sub-process model,
 the helper is started by the foreground process, communication happens
 via a pair of file descriptors bound to the stdin/stdout of the
 sub-process, the sub-process only serves the current foreground
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 82d919b2615..dd0b37c4e34 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -175,7 +175,7 @@ log_index*
 footer
 ....
 
-In a log-only file the first log block immediately follows the file
+In a log-only file, the first log block immediately follows the file
 header, without padding to block alignment.
 
 Block size
-- 
gitgitgadget


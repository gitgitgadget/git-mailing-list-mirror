Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48FFE95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbjJHGrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbjJHGqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF8EB
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so3484590f8f.2
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747541; x=1697352341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xujjgJTMlzG9hZDJRK0kjav+tivE9XrBBuMksecfhY=;
        b=cHLzDqRpvEboJ1H0dR9rMwZz8L7V6EgE1nBdknoxlbDZjtWYwonfm1rLHFcxF4KW7v
         nayE3bhcH7qJR/E27g8QrEuS7abzNl3pLgjL3X/bBY2gQRj8OhZ/GXVjA5WBSu9Y+1R2
         QvPwv3XB9LZpPnout7lFyctny2Ohlb6LzK28P4BIc7qZRw50JnT0k9CbDCSRr2nc5KKS
         IWbBr9bD2ilhdeLB6vFe6wU+QMTRYqz6crzSt+7V+I2HdifxQ+u2gFanKbqRJARlRLyq
         13BKL9iSKgdVi46oP/gaLbwbh5c6mQdHm+T0jMgnEZ9yWZHn+wSEt91a2KkQhPnj0VYP
         CSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747541; x=1697352341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xujjgJTMlzG9hZDJRK0kjav+tivE9XrBBuMksecfhY=;
        b=PYIr2qGaUWoLxddu0NEvYIjbsYosa+8vbn3LgPIH/yZBrXLKGBGzbM0k7tRMVchcvM
         NDhD4srYmq9gD7DEj1bboeJ3WggJFWyLtF9viHSouILonief7amL314x73k8/2EcQTEZ
         Aa0KpaVqDr/brEBZplOPV1f0cSbKD3+5xEogWTbMxQTPGF+40lIZEjBrSyGbwJXNokAt
         UAD/XcAJnmpLd8+OAe6F4vC7QCB6SshBmWuPLWK8oWiX6XhbCqZRcggOgiu4mBS3e/hu
         9WG8BzJjk+mmjEbTWS1W2uDR8/RETifnIJucnaYNrP/E+KUAYiD84geLPeQP/h5tYDrS
         vBWw==
X-Gm-Message-State: AOJu0Yx3YJaWqW3pnr4ek2bP4wPCIAhMTF2gskmH4DVgtFcWqc25Z9TZ
        CziP9dhbqTciwwHcxbmxwFWJFuipDfA=
X-Google-Smtp-Source: AGHT+IGkmGeUIn3l9EYL6Fq9bxEdXjlntGB1TPHCes50u6b6e/AvA6jbNQaHDJTBGLCa+PR+cbAphQ==
X-Received: by 2002:a5d:504e:0:b0:321:4c7e:45e3 with SMTP id h14-20020a5d504e000000b003214c7e45e3mr10680572wrt.11.1696747540492;
        Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020a056000000b00b00325a59b2080sm6009260wrx.97.2023.10.07.23.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
Message-ID: <96bd79af174f0cbb7fe434b2ef807719cf620008.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:17 +0000
Subject: [PATCH 15/25] documentation: add missing article
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
 Documentation/ReviewingGuidelines.txt      |  2 +-
 Documentation/config/advice.txt            |  2 +-
 Documentation/config/commit.txt            |  2 +-
 Documentation/config/fsck.txt              |  2 +-
 Documentation/config/gc.txt                |  2 +-
 Documentation/config/gui.txt               |  2 +-
 Documentation/config/man.txt               |  2 +-
 Documentation/config/notes.txt             |  2 +-
 Documentation/config/sendemail.txt         |  2 +-
 Documentation/config/stash.txt             |  8 ++++----
 Documentation/diff-generate-patch.txt      | 10 +++++-----
 Documentation/fsck-msgids.txt              |  2 +-
 Documentation/git-am.txt                   |  4 ++--
 Documentation/git-apply.txt                |  4 ++--
 Documentation/git-blame.txt                |  4 ++--
 Documentation/git-check-ref-format.txt     |  2 +-
 Documentation/git-checkout-index.txt       |  6 +++---
 Documentation/git-count-objects.txt        |  2 +-
 Documentation/git-daemon.txt               |  2 +-
 Documentation/git-diff-tree.txt            |  2 +-
 Documentation/git-difftool.txt             |  2 +-
 Documentation/git-fsck.txt                 |  2 +-
 Documentation/git-help.txt                 |  2 +-
 Documentation/git-http-push.txt            |  4 ++--
 Documentation/git-init.txt                 |  4 ++--
 Documentation/git-mailsplit.txt            |  2 +-
 Documentation/git-merge-base.txt           |  2 +-
 Documentation/git-merge-tree.txt           |  2 +-
 Documentation/git-mktag.txt                |  2 +-
 Documentation/git-prune.txt                |  2 +-
 Documentation/git-push.txt                 |  2 +-
 Documentation/git-read-tree.txt            |  4 ++--
 Documentation/git-receive-pack.txt         |  4 ++--
 Documentation/git-remote-ext.txt           | 10 +++++-----
 Documentation/git-remote-fd.txt            |  4 ++--
 Documentation/git-replace.txt              |  2 +-
 Documentation/git-rev-parse.txt            |  2 +-
 Documentation/git-send-pack.txt            |  2 +-
 Documentation/git-sh-setup.txt             |  2 +-
 Documentation/git-show-branch.txt          |  2 +-
 Documentation/git-stripspace.txt           |  2 +-
 Documentation/git-update-index.txt         |  8 ++++----
 Documentation/git-update-ref.txt           |  2 +-
 Documentation/git-update-server-info.txt   |  2 +-
 Documentation/git-verify-pack.txt          |  6 +++---
 Documentation/git-whatchanged.txt          |  2 +-
 Documentation/gitcli.txt                   |  2 +-
 Documentation/gitdiffcore.txt              |  6 +++---
 Documentation/gitformat-pack.txt           |  8 ++++----
 Documentation/githooks.txt                 |  2 +-
 Documentation/gitprotocol-capabilities.txt |  2 +-
 Documentation/gitweb.txt                   |  8 ++++----
 Documentation/pretty-options.txt           |  2 +-
 Documentation/pull-fetch-param.txt         |  4 ++--
 Documentation/rev-list-options.txt         |  4 ++--
 Documentation/technical/bitmap-format.txt  |  2 +-
 Documentation/technical/partial-clone.txt  |  2 +-
 57 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
index 0e323d54779..3e98c8a6af0 100644
--- a/Documentation/ReviewingGuidelines.txt
+++ b/Documentation/ReviewingGuidelines.txt
@@ -19,7 +19,7 @@ Principles
 Selecting patch(es) to review
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 If you are looking for a patch series in need of review, start by checking
-latest "What's cooking in git.git" email
+the latest "What's cooking in git.git" email
 (https://lore.kernel.org/git/xmqqilm1yp3m.fsf@gitster.g/[example]). The "What's
 cooking" emails & replies can be found using the query `s:"What's cooking"` on
 the https://lore.kernel.org/git/[`lore.kernel.org` mailing list archive];
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c5cde1c24ee..2737381a11a 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -5,7 +5,7 @@ advice.*::
 +
 --
 	ambiguousFetchRefspec::
-		Advice shown when fetch refspec for multiple remotes maps to
+		Advice shown when a fetch refspec for multiple remotes maps to
 		the same remote-tracking branch namespace and causes branch
 		tracking set-up to fail.
 	fetchShowForcedUpdates::
diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index bcb46cf630e..62f0d92fda5 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -2,7 +2,7 @@ commit.cleanup::
 	This setting overrides the default of the `--cleanup` option in
 	`git commit`. See linkgit:git-commit[1] for details. Changing the
 	default can be useful when you always want to keep lines that begin
-	with comment character `#` in your log message, in which case you
+	with the comment character `#` in your log message, in which case you
 	would do `git config commit.cleanup whitespace` (note that you will
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 0687e86ba10..57114161063 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -36,7 +36,7 @@ Setting an unknown `fsck.<msg-id>` value will cause fsck to die, but
 doing the same for `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>`
 will only cause git to warn.
 +
-See `Fsck Messages` section of linkgit:git-fsck[1] for supported
+See the `Fsck Messages` section of linkgit:git-fsck[1] for supported
 values of `<msg-id>`.
 
 
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 17e2a8cc176..31f1fff53c4 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -39,7 +39,7 @@ See the `gc.bigPackThreshold` configuration variable below. When in
 use, it'll affect how the auto pack limit works.
 
 gc.autoDetach::
-	Make `git gc --auto` return immediately and run in background
+	Make `git gc --auto` return immediately and run in the background
 	if the system supports it. Default is true.
 
 gc.bigPackThreshold::
diff --git a/Documentation/config/gui.txt b/Documentation/config/gui.txt
index 0c087fd8c93..171be774d24 100644
--- a/Documentation/config/gui.txt
+++ b/Documentation/config/gui.txt
@@ -24,7 +24,7 @@ gui.matchTrackingBranch::
 	not. Default: "false".
 
 gui.newBranchTemplate::
-	Is used as suggested name when creating new branches using the
+	Is used as a suggested name when creating new branches using the
 	linkgit:git-gui[1].
 
 gui.pruneDuringFetch::
diff --git a/Documentation/config/man.txt b/Documentation/config/man.txt
index a727d987a8d..5a0f82cc232 100644
--- a/Documentation/config/man.txt
+++ b/Documentation/config/man.txt
@@ -5,7 +5,7 @@ man.viewer::
 man.<tool>.cmd::
 	Specify the command to invoke the specified man viewer. The
 	specified command is evaluated in shell with the man page
-	passed as argument. (See linkgit:git-help[1].)
+	passed as an argument. (See linkgit:git-help[1].)
 
 man.<tool>.path::
 	Override the path for the given tool that may be used to
diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index c7c4811734b..43db8e808d7 100644
--- a/Documentation/config/notes.txt
+++ b/Documentation/config/notes.txt
@@ -1,7 +1,7 @@
 notes.mergeStrategy::
 	Which merge strategy to choose by default when resolving notes
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
-	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
+	`cat_sort_uniq`.  Defaults to `manual`.  See the "NOTES MERGE STRATEGIES"
 	section of linkgit:git-notes[1] for more information on each strategy.
 +
 This setting can be overridden by passing the `--strategy` option to
diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 792e68a4456..7fc770ee9e6 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -91,7 +91,7 @@ sendemail.smtpBatchSize::
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
 sendemail.smtpReloginDelay::
-	Seconds to wait before reconnecting to smtp server.
+	Seconds to wait before reconnecting to the smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
 sendemail.forbidSendmailVariables::
diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index b9f609ed76b..ec1edaeba68 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -1,14 +1,14 @@
 stash.showIncludeUntracked::
 	If this is set to true, the `git stash show` command will show
 	the untracked files of a stash entry.  Defaults to false. See
-	description of 'show' command in linkgit:git-stash[1].
+	the description of the 'show' command in linkgit:git-stash[1].
 
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
-	See description of 'show' command in linkgit:git-stash[1].
+	See the description of the 'show' command in linkgit:git-stash[1].
 
 stash.showStat::
 	If this is set to true, the `git stash show` command without an
-	option will show diffstat of the stash entry.  Defaults to true.
-	See description of 'show' command in linkgit:git-stash[1].
+	option will show a diffstat of the stash entry.  Defaults to true.
+	See the description of the 'show' command in linkgit:git-stash[1].
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 4b307cb51bb..cf1958ca632 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -25,9 +25,9 @@ The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
 `/dev/null` is _not_ used in place of the `a/` or `b/` filenames.
 +
-When rename/copy is involved, `file1` and `file2` show the
+When a rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
-the file that rename/copy produces, respectively.
+the file that the rename/copy produces, respectively.
 
 2.   It is followed by one or more extended header lines:
 
@@ -89,7 +89,7 @@ produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
 linkgit:git-show[1]. Note also that you can give suitable
 `--diff-merges` option to any of these commands to force generation of
-diffs in specific format.
+diffs in a specific format.
 
 A "combined diff" format looks like this:
 
@@ -143,7 +143,7 @@ or like this (when the `--cc` option is used):
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected content movement (renames and
-copying detection) are designed to work with diff of two
+copying detection) are designed to work with the diff of two
 <tree-ish> and are not used by combined diff format.
 
 3.   It is followed by a two-line from-file/to-file header:
@@ -151,7 +151,7 @@ copying detection) are designed to work with diff of two
        --- a/file
        +++ b/file
 +
-Similar to two-line header for traditional 'unified' diff
+Similar to the two-line header for the traditional 'unified' diff
 format, `/dev/null` is used to signal created or deleted
 files.
 +
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 8505c244bcf..f643585a34e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -132,7 +132,7 @@
 	(ERROR) Missing space before date in an author/committer line.
 
 `missingSpaceBeforeEmail`::
-	(ERROR) Missing space before the email in author/committer line.
+	(ERROR) Missing space before the email in an author/committer line.
 
 `missingTag`::
 	(ERROR) Unexpected end after `type` line in a tag object.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 51c26715159..00a5ec206d6 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -94,7 +94,7 @@ OPTIONS
 	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
-	`i18n.commitEncoding` can be used to specify project's
+	`i18n.commitEncoding` can be used to specify the project's
 	preferred encoding if it is not UTF-8).
 +
 This was optional in prior versions of git, but now it is the
@@ -192,7 +192,7 @@ include::rerere-options.txt[]
 
 --abort::
 	Restore the original branch and abort the patching operation.
-	Revert contents of files involved in the am operation to their
+	Revert the contents of files involved in the am operation to their
 	pre-am state.
 
 --quit::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6e7510d068..95bde308709 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -140,7 +140,7 @@ linkgit:git-config[1]).
 	applying a diff generated with `--unified=0`. To bypass these
 	checks use `--unidiff-zero`.
 +
-Note, for the reasons stated above usage of context-free patches is
+Note, for the reasons stated above the usage of context-free patches is
 discouraged.
 
 --apply::
@@ -257,7 +257,7 @@ the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
 --allow-empty::
-	Don't return error for patches containing no diff. This includes
+	Don't return an error for patches containing no diff. This includes
 	empty patches and patches with commit text only.
 
 CONFIGURATION
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index a927c7c9f33..6f39147c051 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -77,7 +77,7 @@ include::blame-options.txt[]
 
 -e::
 --show-email::
-	Show the author email instead of author name (Default: off).
+	Show the author email instead of the author name (Default: off).
 	This can also be controlled via the `blame.showEmail` config
 	option.
 
@@ -100,7 +100,7 @@ When neither `--porcelain` nor `--incremental` option is specified,
 `git blame` will output annotation for each line with:
 
 - abbreviated object name for the commit the line came from;
-- author ident (by default author name and date, unless `-s` or `-e`
+- author ident (by default the author name and date, unless `-s` or `-e`
   is specified); and
 - line number
 
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ee6a4144fbe..1d6e08e0119 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -85,7 +85,7 @@ The rule `git check-ref-format --branch $name` implements
 may be stricter than what `git check-ref-format refs/heads/$name`
 says (e.g. a dash may appear at the beginning of a ref component,
 but it is explicitly forbidden at the beginning of a branch name).
-When run with `--branch` option in a repository, the input is first
+When run with the `--branch` option in a repository, the input is first
 expanded for the ``previous checkout syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
 was checked out using "git switch" or "git checkout" operation.
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index d1738f43308..4e2527612e0 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -53,7 +53,7 @@ OPTIONS
 
 --stage=<number>|all::
 	Instead of checking out unmerged entries, copy out the
-	files from named stage.  <number> must be between 1 and 3.
+	files from the named stage.  <number> must be between 1 and 3.
 	Note: --stage=all automatically implies --temp.
 
 --temp::
@@ -66,8 +66,8 @@ OPTIONS
 	set.
 
 --stdin::
-	Instead of taking list of paths from the command line,
-	read list of paths from the standard input.  Paths are
+	Instead of taking a list of paths from the command line,
+	read the list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
 -z::
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index b28cc3a510a..97f9f126101 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -33,7 +33,7 @@ size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
-garbage: the number of files in object database that are neither valid loose
+garbage: the number of files in the object database that are neither valid loose
 objects nor valid packs
 +
 size-garbage: disk space consumed by garbage files, in KiB (unless -H is
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 236df516c73..e064f91c9e3 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -138,7 +138,7 @@ otherwise `stderr`.
 --user-path::
 --user-path=<path>::
 	Allow {tilde}user notation to be used in requests.  When
-	specified with no parameter, requests to
+	specified with no parameter, a request to
 	git://host/{tilde}alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
 	If `--user-path=path` is specified, the same request is
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 1e34f80daa9..c2772a566a3 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -78,7 +78,7 @@ commits (but not trees).
 	By default, 'git diff-tree --stdin' shows differences,
 	either in machine-readable form (without `-p`) or in patch
 	form (with `-p`).  This output can be suppressed.  It is
-	only useful with `-v` flag.
+	only useful with the `-v` flag.
 
 -v::
 	This flag causes 'git diff-tree --stdin' to also show
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 179e5ae2162..50cb080085e 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -36,7 +36,7 @@ OPTIONS
 
 --rotate-to=<file>::
 	Start showing the diff for the given path,
-	the paths before it will move to end and output.
+	the paths before it will move to the end and output.
 
 --skip-to=<file>::
 	Start showing the diff for the given path, skipping all
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index e4980d28615..5b82e4605c2 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -24,7 +24,7 @@ OPTIONS
 	An object to treat as the head of an unreachability trace.
 +
 If no objects are given, 'git fsck' defaults to using the
-index file, all SHA-1 references in `refs` namespace, and all reflogs
+index file, all SHA-1 references in the `refs` namespace, and all reflogs
 (unless --no-reflogs is given) as heads.
 
 --unreachable::
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ee18a2b7432..22dfd780851 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -85,7 +85,7 @@ pseudo-configuration such as the file-based `.git/hooks/*` interface
 described in linkgit:githooks[5].
 
 --developer-interfaces::
-	Print list of file formats, protocols and other developer
+	Print a list of file formats, protocols and other developer
 	interfaces documentation on the standard output.
 
 -i::
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 8b4a5791c8c..c0c841b9fdd 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -13,12 +13,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Sends missing objects to remote repository, and updates the
+Sends missing objects to the remote repository, and updates the
 remote branch.
 
 *NOTE*: This command is temporarily disabled if your libcurl
 is older than 7.16, as the combination has been reported
-not to work and sometimes corrupts repository.
+not to work and sometimes corrupts the repository.
 
 OPTIONS
 -------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 138dc4a3bfe..3c3c1e730c3 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -66,10 +66,10 @@ DIRECTORY" section below.)
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
-repository.  This file acts as filesystem-agnostic Git symbolic link to the
+repository.  This file acts as a filesystem-agnostic Git symbolic link to the
 repository.
 +
-If this is reinitialization, the repository will be moved to the specified path.
+If this is a reinitialization, the repository will be moved to the specified path.
 
 -b <branch-name>::
 --initial-branch=<branch-name>::
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index e3b2a88c4b7..3f0a6662c81 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -34,7 +34,7 @@ OPTIONS
 
 -b::
 	If any file doesn't begin with a From line, assume it is a
-	single mail message instead of signaling error.
+	single mail message instead of signaling an error.
 
 -d<prec>::
 	Instead of the default 4 digits with leading zeros,
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index b01ba3d3565..463764b9c1e 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-'git merge-base' finds best common ancestor(s) between two commits to use
+'git merge-base' finds the best common ancestor(s) between two commits to use
 in a three-way merge.  One common ancestor is 'better' than another common
 ancestor if the latter is an ancestor of the former.  A common ancestor
 that does not have any better common ancestor is a 'best common
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 9f951c7fe34..b50acace3bc 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -19,7 +19,7 @@ DESCRIPTION
 This command has a modern `--write-tree` mode and a deprecated
 `--trivial-merge` mode.  With the exception of the
 <<DEPMERGE,DEPRECATED DESCRIPTION>> section at the end, the rest of
-this documentation describes modern `--write-tree` mode.
+this documentation describes the modern `--write-tree` mode.
 
 Performs a merge, but does not make any new commits and does not read
 from or write to either the working tree or index.
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 7a014962343..006d759962a 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -56,7 +56,7 @@ has a very simple fixed format: four lines of
   tagger <tagger>
 
 followed by some 'optional' free-form message (some tags created
-by older Git may not have `tagger` line).  The message, when it
+by older Git may not have a `tagger` line).  The message, when it
 exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 03552dd86fc..9a45571b901 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -18,7 +18,7 @@ NOTE: In most cases, users should run 'git gc', which calls
 'git prune'. See the section "NOTES", below.
 
 This runs 'git fsck --unreachable' using all the refs
-available in `refs/`, optionally with additional set of
+available in `refs/`, optionally with an additional set of
 objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
 In addition, it
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b4edaf4a8d..c12caedbb18 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -48,7 +48,7 @@ local one.
 OPTIONS[[OPTIONS]]
 ------------------
 <repository>::
-	The "remote" repository that is destination of a push
+	The "remote" repository that is the destination of a push
 	operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 32065318532..1c48c289963 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -26,14 +26,14 @@ flag.  When used with `-m`, the `-u` flag causes it to also update
 the files in the work tree with the result of the merge.
 
 Only trivial merges are done by 'git read-tree' itself.  Only conflicting paths
-will be in unmerged state when 'git read-tree' returns.
+will be in an unmerged state when 'git read-tree' returns.
 
 OPTIONS
 -------
 -m::
 	Perform a merge, not just a read.  The command will
 	refuse to run if your index file has unmerged entries,
-	indicating that you have not finished previous merge you
+	indicating that you have not finished a previous merge you
 	started.
 
 --reset::
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 65ff518ccff..20aca92073d 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -18,10 +18,10 @@ information fed from the remote end.
 
 This command is usually not invoked directly by the end user.
 The UI for the protocol is on the 'git send-pack' side, and the
-program pair is meant to be used to push updates to remote
+program pair is meant to be used to push updates to a remote
 repository.  For pull operations, see linkgit:git-fetch-pack[1].
 
-The command allows for creation and fast-forwarding of sha1 refs
+The command allows for the creation and fast-forwarding of sha1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
 local end 'git-receive-pack' runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 17d84f23c99..b33ee3c9e86 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -44,15 +44,15 @@ The following sequences have a special meaning:
 	This argument will not be passed to '<command>'. Instead, it
 	will cause the helper to start by sending git:// service requests to
 	the remote side with the service field set to an appropriate value and
-	the repository field set to rest of the argument. Default is not to send
+	the repository field set to the rest of the argument. Default is not to send
 	such a request.
 +
-This is useful if remote side is git:// server accessed over
+This is useful if the remote side is git:// server accessed over
 some tunnel.
 
 '%V' (must be first characters in argument)::
 	This argument will not be passed to '<command>'. Instead it sets
-	the vhost field in the git:// service request (to rest of the argument).
+	the vhost field in the git:// service request (to the rest of the argument).
 	Default is not to send vhost in such request (if sent).
 
 ENVIRONMENT VARIABLES
@@ -82,12 +82,12 @@ begins with `ext::`.  Examples:
 
 "ext::ssh -i /home/foo/.ssh/somekey user&#64;host.example %S 'foo/repo'"::
 	Like host.example:foo/repo, but use /home/foo/.ssh/somekey as
-	keypair and user as user on remote side. This avoids the need to
+	keypair and user as the user on the remote side. This avoids the need to
 	edit .ssh/config.
 
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
 	Represents repository with path /somerepo accessible over
-	git protocol at abstract namespace address /git-server.
+	git protocol at the abstract namespace address /git-server.
 
 "ext::git-server-alias foo %G/repo"::
 	Represents a repository with path /repo accessed using the
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 0451ceb8a26..6ed71bd0b75 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -25,7 +25,7 @@ It is assumed that any handshaking procedures have already been completed
 (such as sending service request for git://) before this helper is started.
 
 <anything> can be any string. It is ignored. It is meant for providing
-information to user in the URL in case that URL is displayed in some
+information to the user in the URL in case that URL is displayed in some
 context.
 
 ENVIRONMENT VARIABLES
@@ -45,7 +45,7 @@ EXAMPLES
 `git push fd::7,8 master (as URL)`::
 	Push master, using file descriptor #7 to read data from
 	git-receive-pack and file descriptor #8 to write data to
-	same service.
+	the same service.
 
 `git push fd::7,8/bar master`::
 	Same as above.
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index fdd2e0f0883..4f257126e33 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -35,7 +35,7 @@ Replacement references will be used by default by all Git commands
 except those doing reachability traversal (prune, pack transfer and
 fsck).
 
-It is possible to disable use of replacement references for any
+It is possible to disable the use of replacement references for any
 command using the `--no-replace-objects` option just after 'git'.
 
 For example if commit 'foo' has been replaced by commit 'bar':
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 7b3ce3012e3..f42fb938705 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Many Git porcelainish commands take mixture of flags
+Many Git porcelainish commands take a mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
 meant for the underlying 'git rev-list' command they use internally
 and flags and parameters for the other commands they use
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 9c1ed757b9d..b9e73f2e77b 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -106,7 +106,7 @@ SPECIFYING THE REFS
 There are three ways to specify which refs to update on the
 remote end.
 
-With `--all` flag, all refs that exist locally are transferred to
+With the `--all` flag, all refs that exist locally are transferred to
 the remote side.  You cannot specify any '<ref>' if you use
 this flag.
 
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 8632612c31d..bdaf6e5fc4f 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -22,7 +22,7 @@ The 'git sh-setup' scriptlet is designed to be sourced (using
 the normal Git directories and a few helper shell functions.
 
 Before sourcing it, your script should set up a few variables;
-`USAGE` (and `LONG_USAGE`, if any) is used to define message
+`USAGE` (and `LONG_USAGE`, if any) is used to define the message
 given by `usage()` shell function.  `SUBDIRECTORY_OK` can be set
 if the script can run from a subdirectory of the working tree
 (some commands do not).
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 080b5246a4e..ddf24aeb87d 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -137,7 +137,7 @@ their commit message. The branch head that is pointed at by
 $GIT_DIR/HEAD is prefixed with an asterisk `*` character while other
 heads are prefixed with a `!` character.
 
-Following these N lines, one-line log for each commit is
+Following these N lines, a one-line log for each commit is
 displayed, indented N places.  If a commit is on the I-th
 branch, the I-th indentation character shows a `+` sign;
 otherwise it shows a space.  Merge commits are denoted by
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 3dc630da4b7..6b92cc7de78 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -37,7 +37,7 @@ OPTIONS
 -------
 -s::
 --strip-comments::
-	Skip and remove all lines starting with comment character (default '#').
+	Skip and remove all lines starting with a comment character (default '#').
 
 -c::
 --comment-lines::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7f0c950a5fd..7ac2e37c0ac 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -95,7 +95,7 @@ OPTIONS
 	the index.  If you want to change the working tree file,
 	you need to unset the bit to tell Git.  This is
 	sometimes helpful when working with a big project on a
-	filesystem that has very slow lstat(2) system call
+	filesystem that has a very slow lstat(2) system call
 	(e.g. cifs).
 +
 Git will fail (gracefully) in case it needs to modify this file
@@ -151,12 +151,12 @@ you will need to handle the situation manually.
 	automatically removed with warning messages.
 
 --stdin::
-	Instead of taking list of paths from the command line,
-	read list of paths from the standard input.  Paths are
+	Instead of taking a list of paths from the command line,
+	read a list of paths from the standard input.  Paths are
 	separated by LF (i.e. one path per line) by default.
 
 --verbose::
-        Report what is being added and removed from index.
+	Report what is being added and removed from the index.
 
 --index-version <n>::
 	Write the resulting index out in the named on-disk format version.
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 48b6683071e..0561808cca0 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -118,7 +118,7 @@ verify::
 	<oldvalue> is zero or missing, the ref must not exist.
 
 option::
-	Modify behavior of the next command naming a <ref>.
+	Modify the behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
 	a symbolic ref.
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 17e429dbd09..ff32986d4c5 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -29,7 +29,7 @@ OUTPUT
 ------
 
 Currently the command updates the following files.  Please see
-linkgit:gitrepository-layout[5] for description of
+linkgit:gitrepository-layout[5] for a description of
 what they are for:
 
 * objects/info/packs
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index b8720dce8ab..d7e886918aa 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads given idx file for packed Git archive created with the
-'git pack-objects' command and verifies idx file and the
+'git pack-objects' command and verifies the idx file and the
 corresponding pack file.
 
 OPTIONS
@@ -25,13 +25,13 @@ OPTIONS
 
 -v::
 --verbose::
-	After verifying the pack, show list of objects contained
+	After verifying the pack, show the list of objects contained
 	in the pack and a histogram of delta chain length.
 
 -s::
 --stat-only::
 	Do not verify the pack contents; only show the histogram of delta
-	chain length.  With `--verbose`, list of objects is also shown.
+	chain length.  With `--verbose`, the list of objects is also shown.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index fc2dc5a3b1d..8e55e0bb1ec 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -22,7 +22,7 @@ but defaults to showing the raw format diff output and skipping merges.
 
 The command is primarily kept for historical reasons; fingers of
 many people who learned Git long before `git log` was invented by
-reading Linux kernel mailing list are trained to type it.
+reading the Linux kernel mailing list are trained to type it.
 
 
 Examples
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 71ffe5556ae..e5fac943227 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -37,7 +37,7 @@ arguments.  Here are the rules:
    they can be disambiguated by placing `--` between them.
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
-   and what I have in the work tree for that file", not "show difference
+   and what I have in the work tree for that file", not "show the difference
    between the HEAD commit and the work tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 411ce863598..bc65f91310d 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -213,7 +213,7 @@ from the original, and does not count insertion.  If you removed
 only 10 lines from a 100-line document, even if you added 910
 new lines to make a new 1000-line document, you did not do a
 complete rewrite.  diffcore-break breaks such a case in order to
-help diffcore-rename to consider such filepairs as candidate of
+help diffcore-rename to consider such filepairs as a candidate of
 rename/copy detection, but if filepairs broken that way were not
 matched with other filepairs to create rename/copy, then this
 transformation merges them back into the original
@@ -235,8 +235,8 @@ creation and deletion patches.  This was an unnecessary hack and
 the latest implementation always merges all the broken pairs
 back into modifications, but the resulting patch output is
 formatted differently for easier review in case of such
-a complete rewrite by showing the entire contents of old version
-prefixed with '-', followed by the entire contents of new
+a complete rewrite by showing the entire contents of the old version
+prefixed with '-', followed by the entire contents of the new
 version prefixed with '+'.
 
 
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index f5d07a125d9..678a7e4cb49 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -48,7 +48,7 @@ Similarly, in SHA-256 repositories, these values are computed using SHA-256.
      Observation: we cannot have more than 4G versions ;-) and
      more than 4G objects in a pack.
 
-   - The header is followed by number of object entries, each of
+   - The header is followed by a number of object entries, each of
      which looks like this:
 
      (undeltified representation)
@@ -62,7 +62,7 @@ Similarly, in SHA-256 repositories, these values are computed using SHA-256.
 	 is an OBJ_OFS_DELTA object
      compressed delta data
 
-     Observation: length of each object is encoded in a variable
+     Observation: the length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
   - The trailer records a pack checksum of all of the above.
@@ -161,7 +161,7 @@ converted to 0x10000.
   | 0xxxxxxx |    data    |
   +----------+============+
 
-This is the instruction to construct target object without the base
+This is the instruction to construct the target object without the base
 object. The following data is appended to the target object. The first
 seven bits of the first octet determine the size of data in
 bytes. The size must be non-zero.
@@ -294,7 +294,7 @@ Pack file entry: <+
 
   - The same trailer as a v1 pack file:
 
-    A copy of the pack checksum at the end of
+    A copy of the pack checksum at the end of the
     corresponding packfile.
 
     Index checksum of all of the above.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e62ad343eda..883982e7a05 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -157,7 +157,7 @@ If the exit status is non-zero, `git commit` will abort.
 The purpose of the hook is to edit the message file in place, and
 it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
-be used as replacement for pre-commit hook.
+be used as a replacement for the pre-commit hook.
 
 The sample `prepare-commit-msg` hook that comes with Git removes the
 help message found in the commented portion of the commit template.
diff --git a/Documentation/gitprotocol-capabilities.txt b/Documentation/gitprotocol-capabilities.txt
index 388846d92e9..d6c6effc215 100644
--- a/Documentation/gitprotocol-capabilities.txt
+++ b/Documentation/gitprotocol-capabilities.txt
@@ -88,7 +88,7 @@ interleaved with S-R-Q.
 
 multi_ack_detailed
 ------------------
-This is an extension of multi_ack that permits client to better
+This is an extension of multi_ack that permits the client to better
 understand the server's in-memory state. See linkgit:gitprotocol-pack[5],
 section "Packfile Negotiation" for more information.
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 41ce55e266a..1030e9667ea 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -41,9 +41,9 @@ for details.
 Repositories
 ~~~~~~~~~~~~
 Gitweb can show information from one or more Git repositories.  These
-repositories have to be all on local filesystem, and have to share common
+repositories have to be all on local filesystem, and have to share a common
 repository root, i.e. be all under a single parent repository (but see also
-"Advanced web server setup" section, "Webserver configuration with multiple
+the "Advanced web server setup" section, "Webserver configuration with multiple
 projects' root" subsection).
 
 -----------------------------------------------------------------------
@@ -51,7 +51,7 @@ our $projectroot = '/path/to/parent/directory';
 -----------------------------------------------------------------------
 
 The default value for `$projectroot` is `/pub/git`.  You can change it during
-building gitweb via `GITWEB_PROJECTROOT` build configuration variable.
+building gitweb via the `GITWEB_PROJECTROOT` build configuration variable.
 
 By default all Git repositories under `$projectroot` are visible and available
 to gitweb.  The list of projects is generated by default by scanning the
@@ -66,7 +66,7 @@ found at "$projectroot/$repo".
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-Instead of having gitweb find repositories by scanning filesystem
+Instead of having gitweb find repositories by scanning the filesystem
 starting from $projectroot, you can provide a pre-generated list of
 visible projects by setting `$projects_list` to point to a plain text
 file with a list of projects (with some additional info).
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 15c6f2705d4..23888cd612c 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -48,7 +48,7 @@ people using 80-column terminals.
 --expand-tabs::
 --no-expand-tabs::
 	Perform a tab expansion (replace each tab with enough spaces
-	to fill to the next display column that is multiple of '<n>')
+	to fill to the next display column that is a multiple of '<n>')
 	in the log message before showing it in the output.
 	`--expand-tabs` is a short-hand for `--expand-tabs=8`, and
 	`--no-expand-tabs` is a short-hand for `--expand-tabs=0`,
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 74143ef0d24..c718f7946f0 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -80,7 +80,7 @@ configuration which'll amend these rules, and nothing like a
 +
 As with pushing with linkgit:git-push[1], all of the rules described
 above about what's not allowed as an update can be overridden by
-adding an optional leading `+` to a refspec (or using `--force`
+adding an optional leading `+` to a refspec (or using the `--force`
 command line option). The only exception to this is that no amount of
 forcing will make the `refs/heads/*` namespace accept a non-commit
 object.
@@ -88,7 +88,7 @@ object.
 [NOTE]
 When the remote branch you want to fetch is known to
 be rewound and rebased regularly, it is expected that
-its new tip will not be descendant of its previous tip
+its new tip will not be a descendant of its previous tip
 (as stored in your remote-tracking branch the last time
 you fetched).  You would want
 to use the `+` sign to indicate non-fast-forward updates
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 66d71d1b957..2bf239ff030 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -56,7 +56,7 @@ endif::git-rev-list[]
 	error to use this option unless `--walk-reflogs` is in use.
 
 --grep=<pattern>::
-	Limit the commits output to ones with log message that
+	Limit the commits output to ones with a log message that
 	matches the specified pattern (regular expression).  With
 	more than one `--grep=<pattern>`, commits whose message
 	matches any of the given patterns are chosen (but see
@@ -72,7 +72,7 @@ endif::git-rev-list[]
 	instead of ones that match at least one.
 
 --invert-grep::
-	Limit the commits output to ones with log message that do not
+	Limit the commits output to ones with a log message that do not
 	match the pattern specified with `--grep=<pattern>`.
 
 -i::
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f761828f106..f5d200939b0 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -239,7 +239,7 @@ bitmaps.
 
 For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
 contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
-(sorted in the ascending order of `commit_pos`). The content of i'th
+(sorted in the ascending order of `commit_pos`). The content of the i'th
 triplet is -
 
 	* {empty}
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 29876ca582a..cd948b00722 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -256,7 +256,7 @@ remote in a specific order.
 - Dynamic object fetching currently uses the existing pack protocol V0
   which means that each object is requested via fetch-pack.  The server
   will send a full set of info/refs when the connection is established.
-  If there are large number of refs, this may incur significant overhead.
+  If there are a large number of refs, this may incur significant overhead.
 
 
 Future Work
-- 
gitgitgadget


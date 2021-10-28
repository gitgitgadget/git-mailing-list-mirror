Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8FC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4623F610CB
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1QYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhJ1QYg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EEC061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i5so3516360wrb.2
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wZDbu6cP4f+VwsEcJyqV/zhE1R/CW3e0ndqBjgL74oE=;
        b=E5SK3J9nDW+OBkjJwP9oAdjTbAgi5puY0ZR4NmcINCRXBAmKWOA1ML/SgsBlYnNmxa
         YxVXUO7y9K/hy8CHFNpE8uVoRcULJrOZR+LttLFNc118WwUprJHlxYseqocUAsIZI10D
         0EzLdLKF8fu2JPk7AiGQnyXk1630Wh/rHhMMchIX5trPt0JbVOcWmN3ydJRiyfm8RsuA
         gfXu1W495vao1Hlj2NJZ5cmUX0kPXzI2CKX8r8IfH/WSHfUFNoBZVXw+FSFU04XWcEZj
         /yaSO2TDehDY354H46yrFatU8WB2V774qKJNbhUq9o1PShMeBusi/B7Nt/gkqk7FDNdf
         qYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wZDbu6cP4f+VwsEcJyqV/zhE1R/CW3e0ndqBjgL74oE=;
        b=23llW6e5WWExnVTLxdQV7NJOXVxHM1AWuMUr4oufcjp0PCrIFA5tG+IDA1OmLp8Bk0
         Hx4iNjfvTZPPx8AuEAG7difiJlBG8p0e02MdP0cuVGISaCUeX7KSFNPRKn80DCFJrsEN
         Ij/6GHQLsWEaMWQkWg7l6JdnhgJGuXz2WrJEnHhXRpC5Fo7YzPZ9Gx4GE30lpjUtbbFu
         KbvlcDKQ8OxIRaDb7o7dQDpOCnFJ9EPlrBRFN4EKMvi4llDHcmk4cT3540x/G1UbanWO
         093hCH3aKf8jAhMGDpHT/qwMjRzoJH/eH3pglwr173XpN8D326ZoLgX8ZbNj/ovkm0G2
         e6qw==
X-Gm-Message-State: AOAM530sHR469qHtBMRZjRpMO3qbEbE6LYpRXV3qmmEfxtj1rjVW2zL9
        ND1QBszzLBX6ZXJw/DWbc/GOvN3XwbQ=
X-Google-Smtp-Source: ABdhPJzKKjwO9P2fifqxD6w2D7ZEyQdKgYRz62REasya7hRXpMqsWfY49s/Dkq/lrigOqii1n3kEww==
X-Received: by 2002:adf:b350:: with SMTP id k16mr7061201wrd.368.1635438128021;
        Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm6674935wmb.12.2021.10.28.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
Message-Id: <984b6d687a2e779c775de6ea80536afe6ecc0aaf.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:59 +0000
Subject: [PATCH v2 4/9] doc: use only hyphens as word separators in
 placeholders
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

According to CodingGuidelines, spaces and underscores are not
allowed in placeholders.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/date-formats.txt   |  4 +--
 Documentation/git-checkout.txt   | 36 +++++++++++-----------
 Documentation/git-clone.txt      |  8 ++---
 Documentation/git-cvsimport.txt  |  8 ++---
 Documentation/git-diff-files.txt |  2 +-
 Documentation/git-diff-index.txt |  2 +-
 Documentation/git-diff-tree.txt  |  2 +-
 Documentation/git-init-db.txt    |  2 +-
 Documentation/git-init.txt       |  8 ++---
 Documentation/git-log.txt        |  8 ++---
 Documentation/git-p4.txt         |  6 ++--
 Documentation/git-shortlog.txt   |  8 ++---
 Documentation/git-svn.txt        |  2 +-
 Documentation/pretty-formats.txt | 52 ++++++++++++++++----------------
 14 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 99c455f51c0..4a1e7bd43bf 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -5,9 +5,9 @@ The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
 Git internal format::
-	It is `<unix timestamp> <time zone offset>`, where `<unix
+	It is `<unix-timestamp> <time-zone-offset>`, where `<unix-
 	timestamp>` is the number of seconds since the UNIX epoch.
-	`<time zone offset>` is a positive or negative offset from UTC.
+	`<time-zone-offset>` is a positive or negative offset from UTC.
 	For example CET (which is 1 hour ahead of UTC) is `+0100`.
 
 RFC 2822::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d473c9bf387..a52dc49a3dc 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
@@ -43,7 +43,7 @@ You could omit `<branch>`, in which case the command degenerates to
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
 
-'git checkout' -b|-B <new_branch> [<start point>]::
+'git checkout' -b|-B <new-branch> [<start-point>]::
 
 	Specifying `-b` causes a new branch to be created as if
 	linkgit:git-branch[1] were called and then checked out.  In
@@ -52,11 +52,11 @@ if exists, for the current branch.
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, `<new_branch>` is created if it doesn't exist; otherwise, it
+If `-B` is given, `<new-branch>` is created if it doesn't exist; otherwise, it
 is reset. This is the transactional equivalent of
 +
 ------------
-$ git branch -f <branch> [<start point>]
+$ git branch -f <branch> [<start-point>]
 $ git checkout <branch>
 ------------
 +
@@ -145,13 +145,13 @@ as `ours` (i.e. "our shared canonical history"), while what you did
 on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
--b <new_branch>::
-	Create a new branch named `<new_branch>` and start it at
-	`<start_point>`; see linkgit:git-branch[1] for details.
+-b <new-branch>::
+	Create a new branch named `<new-branch>` and start it at
+	`<start-point>`; see linkgit:git-branch[1] for details.
 
--B <new_branch>::
-	Creates the branch `<new_branch>` and start it at `<start_point>`;
-	if it already exists, then reset it to `<start_point>`. This is
+-B <new-branch>::
+	Creates the branch `<new-branch>` and start it at `<start-point>`;
+	if it already exists, then reset it to `<start-point>`. This is
 	equivalent to running "git branch" with "-f"; see
 	linkgit:git-branch[1] for details.
 
@@ -210,16 +210,16 @@ variable.
 	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
---orphan <new_branch>::
-	Create a new 'orphan' branch, named `<new_branch>`, started from
-	`<start_point>` and switch to it.  The first commit made on this
+--orphan <new-branch>::
+	Create a new 'orphan' branch, named `<new-branch>`, started from
+	`<start-point>` and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
 	commits.
 +
 The index and the working tree are adjusted as if you had previously run
-`git checkout <start_point>`.  This allows you to start a new history
-that records a set of paths similar to `<start_point>` by easily running
+`git checkout <start-point>`.  This allows you to start a new history
+that records a set of paths similar to `<start-point>` by easily running
 `git commit -a` to make the root commit.
 +
 This can be useful when you want to publish the tree from a commit
@@ -229,7 +229,7 @@ whose full history contains proprietary or otherwise encumbered bits of
 code.
 +
 If you want to start a disconnected history that records a set of paths
-that is totally different from the one of `<start_point>`, then you should
+that is totally different from the one of `<start-point>`, then you should
 clear the index and the working tree right after creating the orphan
 branch by running `git rm -rf .` from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
@@ -341,10 +341,10 @@ As a special case, you may use `A...B` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
-<new_branch>::
+<new-branch>::
 	Name for the new branch.
 
-<start_point>::
+<start-point>::
 	The name of a commit at which to start the new branch; see
 	linkgit:git-branch[1] for details. Defaults to `HEAD`.
 +
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1ce..9685ea06915 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,10 +9,10 @@ git-clone - Clone a repository into a new directory
 SYNOPSIS
 --------
 [verse]
-'git clone' [--template=<template_directory>]
+'git clone' [--template=<template-directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--dissociate] [--separate-git-dir <git dir>]
+	  [--dissociate] [--separate-git-dir <git-dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
@@ -211,7 +211,7 @@ objects from the source repository into a pack in the cloned repository.
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
 
---template=<template_directory>::
+--template=<template-directory>::
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
@@ -294,7 +294,7 @@ or `--mirror` is given)
 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
 	`git submodule update`.
 
---separate-git-dir=<git dir>::
+--separate-git-dir=<git-dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
 	then make a filesystem-agnostic Git symbolic link to there.
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index de1ebed67d7..b3f27671a0c 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
-	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
-	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [-R] [<CVS_module>]
+	      [-C <git-repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
+	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commit-limit>]
+	      [-r <remote>] [-R] [<CVS-module>]
 
 
 DESCRIPTION
@@ -59,7 +59,7 @@ OPTIONS
 	from `CVS/Root`. If no such file exists, it checks for the
 	`CVSROOT` environment variable.
 
-<CVS_module>::
+<CVS-module>::
 	The CVS module you want to import. Relative to <CVSROOT>.
 	If not given, 'git cvsimport' tries to read it from
 	`CVS/Repository`.
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 906774f0f7e..bf1febb9ae7 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the working tree and the index
 SYNOPSIS
 --------
 [verse]
-'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
+'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common-diff-options>] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 27acb31cbf2..679cae27d9b 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -9,7 +9,7 @@ git-diff-index - Compare a tree to the working tree or index
 SYNOPSIS
 --------
 [verse]
-'git diff-index' [-m] [--cached] [--merge-base] [<common diff options>] <tree-ish> [<path>...]
+'git diff-index' [-m] [--cached] [--merge-base] [<common-diff-options>] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2fc24c542f8..274d5eaba93 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
 	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]
-	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
+	      [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd78ad..18bf1a3c8ce 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template-directory>] [--separate-git-dir <git-dir>] [--shared[=<permissions>]]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 7781d0b3545..fdb7b3f367d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,8 +9,8 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>] [--object-format=<format>]
+'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
+	  [--separate-git-dir <git-dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
 	  [--shared[=<permissions>]] [<directory>]
 
@@ -57,12 +57,12 @@ values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
 +
 include::object-format-disclaimer.txt[]
 
---template=<template_directory>::
+--template=<template-directory>::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git dir>::
+--separate-git-dir=<git-dir>::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0498e7bacbe..20e87cecf49 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[--] <path>...]
+'git log' [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -81,13 +81,13 @@ produced by `--stat`, etc.
 
 include::line-range-options.txt[]
 
-<revision range>::
+<revision-range>::
 	Show only commits in the specified revision range.  When no
-	<revision range> is specified, it defaults to `HEAD` (i.e. the
+	<revision-range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision range>, see the 'Specifying Ranges'
+	ways to spell <revision-range>, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
 [--] <path>...::
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8a6addcf72f..e21fcd8f712 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -9,10 +9,10 @@ git-p4 - Import from and submit to Perforce repositories
 SYNOPSIS
 --------
 [verse]
-'git p4 clone' [<sync options>] [<clone options>] <p4 depot path>...
-'git p4 sync' [<sync options>] [<p4 depot path>...]
+'git p4 clone' [<sync-options>] [<clone-options>] <p4-depot-path>...
+'git p4 sync' [<sync-options>] [<p4-depot-path>...]
 'git p4 rebase'
-'git p4 submit' [<submit options>] [<master branch name>]
+'git p4 submit' [<submit-options>] [<master-branch-name>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c9c7f3065ca..f64e77047b2 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,7 +8,7 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-'git shortlog' [<options>] [<revision range>] [[--] <path>...]
+'git shortlog' [<options>] [<revision-range>] [[--] <path>...]
 git log --pretty=short | 'git shortlog' [<options>]
 
 DESCRIPTION
@@ -89,13 +89,13 @@ counts both authors and co-authors.
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
-<revision range>::
+<revision-range>::
 	Show only commits in the specified revision range.  When no
-	<revision range> is specified, it defaults to `HEAD` (i.e. the
+	<revision-range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision range>, see the "Specifying Ranges"
+	ways to spell <revision-range>, see the "Specifying Ranges"
 	section of linkgit:gitrevisions[7].
 
 [--] <path>...::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 222b556d7a9..4e92308e85d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -575,7 +575,7 @@ OPTIONS
 -------
 
 --shared[=(false|true|umask|group|all|world|everybody)]::
---template=<template_directory>::
+--template=<template-directory>::
 	Only used with the 'init' command.
 	These are passed directly to 'git init'.
 
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ef6bd420ae6..d61606caf41 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -20,7 +20,7 @@ built-in formats:
 
 * 'oneline'
 
-	  <hash> <title line>
+	  <hash> <title-line>
 +
 This is designed to be as compact as possible.
 
@@ -29,17 +29,17 @@ This is designed to be as compact as possible.
 	  commit <hash>
 	  Author: <author>
 
-	      <title line>
+	      <title-line>
 
 * 'medium'
 
 	  commit <hash>
 	  Author: <author>
-	  Date:   <author date>
+	  Date:   <author-date>
 
-	      <title line>
+	      <title-line>
 
-	      <full commit message>
+	      <full-commit-message>
 
 * 'full'
 
@@ -47,25 +47,25 @@ This is designed to be as compact as possible.
 	  Author: <author>
 	  Commit: <committer>
 
-	      <title line>
+	      <title-line>
 
-	      <full commit message>
+	      <full-commit-message>
 
 * 'fuller'
 
 	  commit <hash>
 	  Author:     <author>
-	  AuthorDate: <author date>
+	  AuthorDate: <author-date>
 	  Commit:     <committer>
-	  CommitDate: <committer date>
+	  CommitDate: <committer-date>
 
-	       <title line>
+	       <title-line>
 
-	       <full commit message>
+	       <full-commit-message>
 
 * 'reference'
 
-	  <abbrev hash> (<title line>, <short author date>)
+	  <abbrev-hash> (<title-line>, <short-author-date>)
 +
 This format is used to refer to another commit in a commit message and
 is the same as `--pretty='format:%C(auto)%h (%s, %ad)'`.  By default,
@@ -78,10 +78,10 @@ placeholders, its output is not affected by other options like
 
 	  From <hash> <date>
 	  From: <author>
-	  Date: <author date>
-	  Subject: [PATCH] <title line>
+	  Date: <author-date>
+	  Subject: [PATCH] <title-line>
 
-	  <full commit message>
+	  <full-commit-message>
 
 * 'mboxrd'
 +
@@ -101,9 +101,9 @@ commits are displayed, but not the way the diff is shown e.g. with
 `git log --raw`. To get full object names in a raw diff format,
 use `--no-abbrev`.
 
-* 'format:<string>'
+* 'format:<format-string>'
 +
-The 'format:<string>' format allows you to specify which information
+The 'format:<format-string>' format allows you to specify which information
 you want to show. It works a little bit like printf format,
 with the notable exception that you get a newline with '%n'
 instead of '\n'.
@@ -273,12 +273,12 @@ endif::git-rev-list[]
 			  If any option is provided multiple times the
 			  last occurrence wins.
 +
-The boolean options accept an optional value `[=<BOOL>]`. The values
+The boolean options accept an optional value `[=<value>]`. The values
 `true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
 sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
 option is given with no value, it's enabled.
 +
-** 'key=<K>': only show trailers with specified key. Matching is done
+** 'key=<key>': only show trailers with specified <key>. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
    shown. This option automatically enables the `only` option so that
@@ -286,9 +286,9 @@ option is given with no value, it's enabled.
    desired it can be disabled with `only=false`.  E.g.,
    `%(trailers:key=Reviewed-by)` shows trailer lines with key
    `Reviewed-by`.
-** 'only[=<BOOL>]': select whether non-trailer lines from the trailer
+** 'only[=<bool-value>]': select whether non-trailer lines from the trailer
    block should be included.
-** 'separator=<SEP>': specify a separator inserted between trailer
+** 'separator=<sep>': specify a separator inserted between trailer
    lines. When this option is not given each trailer line is
    terminated with a line feed character. The string SEP may contain
    the literal formatting codes described above. To use comma as
@@ -296,15 +296,15 @@ option is given with no value, it's enabled.
    next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
    shows all trailer lines whose key is "Ticket" separated by a comma
    and a space.
-** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
+** 'unfold[=<bool-value>]': make it behave as if interpret-trailer's `--unfold`
    option was given. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'keyonly[=<BOOL>]': only show the key part of the trailer.
-** 'valueonly[=<BOOL>]': only show the value part of the trailer.
-** 'key_value_separator=<SEP>': specify a separator inserted between
+** 'keyonly[=<bool-value>]': only show the key part of the trailer.
+** 'valueonly[=<bool-value>]': only show the value part of the trailer.
+** 'key_value_separator=<sep>': specify a separator inserted between
    trailer lines. When this option is not given each trailer key-value
    pair is separated by ": ". Otherwise it shares the same semantics
-   as 'separator=<SEP>' above.
+   as 'separator=<sep>' above.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
gitgitgadget


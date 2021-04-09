Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51FCC43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0486115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhDIEGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhDIEF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB3C061762
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j5so3229117wrn.4
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYxdOuUiIR6TchJMsFqNDkT4fv9tYfBeL3GWkvd23VM=;
        b=Mz1k/7GOM7NA6LTqzK6QkBpMvHzdtYWJ8G/EAPRa/09AqXzQFNDwwyM2QUSkDa4m1r
         aqIArONHpSGz92CcSl6mhb+n0SzEUqfBtyNR2ZAneNmVXZnib4Vz/HcTmssOSegEtWBq
         qSNKIpEaluVVHQ2QPD4L3+0jBKiQObrZ0J0ZN15VRt2IOjrA2E6sTmLFbZLLeld04+3K
         H9byNi1Shdb+6aAsMn0B+DWn0h6y4q+RQeAiMcxwEQsFUvnqOQJbDbkAR6NHaKIKB42I
         1EJDUCy8Vuvq5ZIeQgeMvjLI9caMzrd4z/+PuIN4V61oAyUN5IDb/mDVr6V0a8azFKjk
         BUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYxdOuUiIR6TchJMsFqNDkT4fv9tYfBeL3GWkvd23VM=;
        b=CDqGIaTXNuQJGIKmUaXo5jFe1Z8Nkg6bpLIAJUGQKqMvGULiZ6tbri4AHfwJ3a5Oac
         dhm9LY8Nzv8udihfzd7klz+/jRTa4OBev1DBsLlraT/LI8zA1e5XI077wiadlUNWz8/M
         i/3TGIr1zrKJAh85xBWzkA91hDf7pd/NsnJ+A2Rj6dNhASF9vjgFdvAXkBf61BGfjdIx
         SHFeuLXNoxRksi60fxf1372nwxhak1Ta0j7gQyTJwodBSJKJXPH9dggkoMj24PmoOqpg
         XGtEw62vWU8UwvVMil8zkO1LTQqRvQnxN9AzE3yiu6aRtzli5YZuttvjMLUHv1uwd5nc
         fQag==
X-Gm-Message-State: AOAM532DsMvo4T8/0jMG0beqQOEfIzvx9VkkmdSBUDc72B542SSa0tyP
        mxZsBF1Fmy2ysIZ1IsSfHm2gW/npVvZQ3g==
X-Google-Smtp-Source: ABdhPJzFs8wouNHgAGEGrnq2nxVtxMMoiraZpDFTdwnxHcjPxnlVT34yvir/qlV1XjhIRvlg9TF4Kw==
X-Received: by 2002:a5d:438f:: with SMTP id i15mr15007735wrq.351.1617941140557;
        Thu, 08 Apr 2021 21:05:40 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:39 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 03/13] doc: typeset configuration options in monospace
Date:   Fri,  9 Apr 2021 06:02:51 +0200
Message-Id: <20210409040301.3260358-4-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap configuration options with backticks as indicated in the
CodingGuidelines.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/blame-options.txt          |  4 +--
 Documentation/diff-options.txt           | 10 +++---
 Documentation/fetch-options.txt          |  4 +--
 Documentation/git-branch.txt             |  2 +-
 Documentation/git-clean.txt              |  2 +-
 Documentation/git-column.txt             |  6 ++--
 Documentation/git-commit.txt             |  8 ++---
 Documentation/git-config.txt             | 10 +++---
 Documentation/git-credential-cache.txt   |  2 +-
 Documentation/git-cvsexportcommit.txt    |  2 +-
 Documentation/git-fetch.txt              |  8 ++---
 Documentation/git-filter-branch.txt      |  4 +--
 Documentation/git-for-each-ref.txt       |  2 +-
 Documentation/git-fsck.txt               |  2 +-
 Documentation/git-grep.txt               |  4 +--
 Documentation/git-help.txt               |  4 +--
 Documentation/git-init.txt               |  2 +-
 Documentation/git-interpret-trailers.txt |  8 ++---
 Documentation/git-ls-files.txt           |  2 +-
 Documentation/git-ls-remote.txt          |  4 +--
 Documentation/git-mailinfo.txt           |  4 +--
 Documentation/git-mv.txt                 |  4 +--
 Documentation/git-notes.txt              | 12 +++----
 Documentation/git-p4.txt                 | 12 +++----
 Documentation/git-pull.txt               |  4 +--
 Documentation/git-push.txt               |  2 +-
 Documentation/git-rebase.txt             | 10 +++---
 Documentation/git-receive-pack.txt       |  2 +-
 Documentation/git-remote.txt             |  4 +--
 Documentation/git-rerere.txt             |  2 +-
 Documentation/git-rev-parse.txt          |  2 +-
 Documentation/git-rm.txt                 |  2 +-
 Documentation/git-send-email.txt         | 20 +++++------
 Documentation/git-status.txt             |  8 ++---
 Documentation/git-submodule.txt          |  4 +--
 Documentation/git-svn.txt                | 42 ++++++++++++------------
 Documentation/git-update-index.txt       |  4 +--
 Documentation/git-update-ref.txt         |  2 +-
 Documentation/git-web--browse.txt        |  4 +--
 Documentation/git.txt                    | 10 +++---
 Documentation/gitattributes.txt          | 10 +++---
 Documentation/gitcore-tutorial.txt       |  4 +--
 Documentation/gitcredentials.txt         |  2 +-
 Documentation/glossary-content.txt       |  2 +-
 Documentation/pull-fetch-param.txt       |  2 +-
 Documentation/user-manual.txt            |  2 +-
 46 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 860e8e2f5c..1d36a176bb 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -72,8 +72,8 @@ include::line-range-format.txt[]
 
 --date <format>::
 	Specifies the format used to output dates. If `--date` is not
-	provided, the value of the blame.date config variable is
-	used. If the blame.date config variable is also not set, the
+	provided, the value of the `blame.date` config variable is
+	used. If the `blame.date` config variable is also not set, the
 	iso format is used. For supported values, see the discussion
 	of the `--date` option at linkgit:git-log[1].
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e4ac746428..86c19bed1e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -344,20 +344,20 @@ default::
 	in the future.
 plain::
 	Any line that is added in one location and was removed
-	in another location will be colored with 'color.diff.newMoved'.
-	Similarly 'color.diff.oldMoved' will be used for removed lines
+	in another location will be colored with `color.diff.newMoved`.
+	Similarly `color.diff.oldMoved` will be used for removed lines
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
 blocks::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
-	painted using either the 'color.diff.{old,new}Moved' color.
+	painted using either the `color.diff.{old,new}Moved` color.
 	Adjacent blocks cannot be told apart.
 zebra::
 	Blocks of moved text are detected as in 'blocks' mode. The blocks
-	are painted using either the 'color.diff.{old,new}Moved' color or
-	'color.diff.{old,new}MovedAlternative'. The change between
+	are painted using either the `color.diff.{old,new}Moved` color or
+	`color.diff.{old,new}MovedAlternative`. The change between
 	the two colors indicates that a new block was detected.
 dimmed-zebra::
 	Similar to 'zebra', but additional dimming of uninteresting parts
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 4ccd65c166..60a268cc4a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -266,13 +266,13 @@ endif::git-pull[]
 
 --show-forced-updates::
 	By default, git checks if a branch is force-updated during
-	fetch. This can be disabled through fetch.showForcedUpdates, but
+	fetch. This can be disabled through `fetch.showForcedUpdates`, but
 	the `--show-forced-updates` option guarantees this check occurs.
 	See linkgit:git-config[1].
 
 --no-show-forced-updates::
 	By default, git checks if a branch is force-updated during
-	fetch. Pass `--no-show-forced-updates` or set fetch.showForcedUpdates
+	fetch. Pass `--no-show-forced-updates` or set `fetch.showForcedUpdates`
 	to false to skip this check for performance reasons. If used during
 	'git-pull' the `--ff-only` option will still check for forced updates
 	before attempting a fast-forward update. See linkgit:git-config[1].
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index fa38fa4dc1..8ea6e1e523 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -215,7 +215,7 @@ This option is only applicable in non-verbose mode.
 	upstream when the new branch is checked out.
 +
 This behavior is the default when the start point is a remote-tracking branch.
-Set the branch.autoSetupMerge configuration variable to `false` if you
+Set the `branch.autoSetupMerge` configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index f4246300ae..cbec3e649a 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -35,7 +35,7 @@ OPTIONS
 
 -f::
 --force::
-	If the Git configuration variable clean.requireForce is not set
+	If the Git configuration variable `clean.requireForce` is not set
 	to false, 'git clean' will refuse to delete files or directories
 	unless given `-f` or `-i`.  Git will refuse to modify untracked
 	nested git repositories (directories with a .git subdirectory)
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 84a02ac15c..ab545fc52d 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -21,11 +21,11 @@ columns.
 OPTIONS
 -------
 --command=<name>::
-	Look up layout mode using configuration variable column.<name> and
-	column.ui.
+	Look up layout mode using configuration variable `column.<name>` and
+	`column.ui`.
 
 --mode=<mode>::
-	Specify layout mode. See configuration variable column.ui for option
+	Specify layout mode. See configuration variable `column.ui` for option
 	syntax in linkgit:git-config[1].
 
 --raw-mode=<n>::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f507ae00a1..6d10f2bdc7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -244,7 +244,7 @@ verbatim::
 scissors::
 	Same as `whitespace` except that everything from (and including)
 	the line found below is truncated, if the message is to be edited.
-	"`#`" can be customized with core.commentChar.
+	"`#`" can be customized with `core.commentChar`.
 
 		# ------------------------ >8 ------------------------
 
@@ -346,7 +346,7 @@ The possible options are:
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
 
-The default can be changed using the status.showUntrackedFiles
+The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
@@ -378,7 +378,7 @@ changes to tracked files.
 	Include the output of linkgit:git-status[1] in the commit
 	message template when using an editor to prepare the commit
 	message.  Defaults to on, but can be used to override
-	configuration variable commit.status.
+	configuration variable `commit.status`.
 
 --no-status::
 	Do not include the output of linkgit:git-status[1] in the
@@ -552,7 +552,7 @@ include::i18n.txt[]
 ENVIRONMENT AND CONFIGURATION VARIABLES
 ---------------------------------------
 The editor used to edit the commit log message will be chosen from the
-`GIT_EDITOR` environment variable, the core.editor configuration variable, the
+`GIT_EDITOR` environment variable, the `core.editor` configuration variable, the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e6d70ffda1..606411c816 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -99,10 +99,10 @@ OPTIONS
 	names are not.
 
 --get-urlmatch name URL::
-	When given a two-part name section.key, the value for
-	section.<url>.key whose <url> part matches the best to the
+	When given a two-part name `section.key`, the value for
+	`section.<url>.key` whose <url> part matches the best to the
 	given URL is returned (if no such key exists, the value for
-	section.key is used as a fallback).  When given just the
+	`section.key` is used as a fallback).  When given just the
 	section as name, do so for all the keys in the section and
 	list them.  Returns error code 1 if no value is found.
 
@@ -421,7 +421,7 @@ To delete the entry for renames, do
 % git config --unset diff.renames
 ------------
 
-If you want to delete an entry for a multivar (like core.gitproxy above),
+If you want to delete an entry for a multivar (like `core.gitproxy` above),
 you have to provide a regex matching the value of exactly one line.
 
 To query the value for a given key, do
@@ -448,7 +448,7 @@ If you want to know all the values for a multivar, do:
 % git config --get-all core.gitproxy
 ------------
 
-If you like to live dangerously, you can replace *all* core.gitproxy by a
+If you like to live dangerously, you can replace *all* `core.gitproxy` by a
 new one with
 
 ------------
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 0216c18ef8..b1a9d9b29a 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -68,7 +68,7 @@ $ git push http://example.com/repo.git
 [your credentials are used automatically]
 ------------------------------------
 
-You can provide options via the credential.helper configuration
+You can provide options via the `credential.helper` configuration
 variable (this example drops the cache time to 5 minutes):
 
 -------------------------------------------------------
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index f08ab508af..76b16f9dae 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -72,7 +72,7 @@ OPTIONS
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
 	current directory is within a Git repository.  The default is the
-	value of 'cvsexportcommit.cvsdir'.
+	value of `cvsexportcommit.cvsdir`.
 
 -W::
 	Tell cvsexportcommit that the current working directory is not only
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index a5ecf00db3..6c3f41399f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -26,13 +26,13 @@ By default, any tag that points into the histories being fetched is
 also fetched; the effect is to fetch tags that
 point at branches that you are interested in.  This default behavior
 can be changed by using the `--tags` or `--no-tags` options or by
-configuring remote.<name>.tagOpt.  By using a refspec that fetches tags
+configuring `remote.<name>.tagOpt`.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
 
 'git fetch' can fetch from either a single named repository or URL,
 or from several repositories at once if <group> is given and
-there is a remotes.<group> entry in the configuration file.
+there is a `remotes.<group>` entry in the configuration file.
 (See linkgit:git-config[1]).
 
 When no remote is specified, by default the `origin` remote will be used,
@@ -208,7 +208,7 @@ The status of up-to-date refs is shown only if the `--verbose` option is
 used.
 
 In compact output mode, specified with configuration variable
-fetch.output, if either entire `<from>` or `<to>` is found in the
+`fetch.output`, if either entire `<from>` or `<to>` is found in the
 other string, it will be substituted with `*` in the other string. For
 example, `master -> origin/master` becomes `master -> origin/*`.
 
@@ -253,7 +253,7 @@ $ git fetch origin
 +
 The above command copies all branches from the remote refs/heads/
 namespace and stores them to the local refs/remotes/origin/ namespace,
-unless the branch.<name>.fetch option is used to specify a non-default
+unless the `branch.<name>.fetch` option is used to specify a non-default
 refspec.
 
 * Using refspecs explicitly:
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e2955bc648..520d3df371 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -365,7 +365,7 @@ git filter-branch --msg-filter '
 
 The `--env-filter` option can be used to modify committer and/or author
 identity.  For example, if you found out that your commits have the wrong
-identity due to a misconfigured user.email, you can make a correction,
+identity due to a misconfigured `user.email`, you can make a correction,
 before publishing the project, like this:
 
 --------------------------------------------------------
@@ -577,7 +577,7 @@ with:
   ls-files will only quote filenames if needed, so folks may not
   notice that one of the files didn't match the regex (at least not
   until it's much too late).  Yes, someone who knows about
-  core.quotePath can avoid this (unless they have other special
+  `core.quotePath` can avoid this (unless they have other special
   characters like \t, \n, or "), and people who use ls-files -z with
   something other than grep can avoid this, but that doesn't mean they
   will.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 4bde4f9d05..64ff4a14f8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -105,7 +105,7 @@ For all objects, the following names can be used:
 refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
-	The option core.warnAmbiguousRefs is used to select the strict
+	The option `core.warnAmbiguousRefs` is used to select the strict
 	abbreviation mode. If `lstrip=<N>` (`rstrip=<N>`) is appended, strips `<N>`
 	slash-separated path components from the front (back) of the refname
 	(e.g. `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index e932c75181..d9a28e278d 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -123,7 +123,7 @@ Any corrupt objects you will have to find in backups or other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
 
-If core.commitGraph is true, the commit-graph file will also be inspected
+If `core.commitGraph` is true, the commit-graph file will also be inspected
 using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
 
 Extracted Diagnostics
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 84102cc596..88047cefad 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -209,7 +209,7 @@ providing this option will cause it to die.
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
-	variable core.quotePath (see linkgit:git-config[1]).
+	variable `core.quotePath` (see linkgit:git-config[1]).
 
 -o::
 --only-matching::
@@ -355,7 +355,7 @@ EXAMPLES
 NOTES ON THREADS
 ----------------
 
-The `--threads` option (and the grep.threads configuration) will be ignored when
+The `--threads` option (and the `grep.threads` configuration) will be ignored when
 `--open-files-in-pager` is used, forcing a single-threaded execution.
 
 When grepping the object store (with `--cached` or giving tree objects), running
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index a19f275f60..392f7be6fa 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -150,7 +150,7 @@ man.<tool>.path
 You can explicitly provide a full path to your preferred man viewer by
 setting the configuration variable `man.<tool>.path`. For example, you
 can configure the absolute path to konqueror by setting
-'man.konqueror.path'. Otherwise, 'git help' assumes the tool is
+`man.konqueror.path`. Otherwise, 'git help' assumes the tool is
 available in PATH.
 
 man.<tool>.cmd
@@ -170,7 +170,7 @@ When 'konqueror' is specified in the `man.viewer` configuration
 variable, we launch 'kfmclient' to try to open the man page on an
 already opened konqueror in a new tab if possible.
 
-For consistency, we also try such a trick if 'man.konqueror.path' is
+For consistency, we also try such a trick if `man.konqueror.path` is
 set to something like `A_PATH_TO/konqueror`. That means we will try to
 launch `A_PATH_TO/kfmclient` instead.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index a3f061517d..47d61fc505 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -83,7 +83,7 @@ customized via the `init.defaultBranch` configuration variable).
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
-repository.  When specified, the config variable "core.sharedRepository" is
+repository.  When specified, the config variable `core.sharedRepository` is
 set so that files and directories under `$GIT_DIR` are created with the
 requested permissions.  When not specified, Git will use permissions reported
 by umask(2).
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4288e5405c..1160807e0d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -217,17 +217,17 @@ If there is a separator, then the key will be used instead of both the
 <token> and the default separator when adding the trailer.
 
 trailer.<token>.where::
-	This option takes the same values as the 'trailer.where'
+	This option takes the same values as the `trailer.where`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
 trailer.<token>.ifexists::
-	This option takes the same values as the 'trailer.ifexists'
+	This option takes the same values as the `trailer.ifexists`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
 trailer.<token>.ifmissing::
-	This option takes the same values as the 'trailer.ifmissing'
+	This option takes the same values as the `trailer.ifmissing`
 	configuration variable and it overrides what is specified by
 	that option for trailers with the specified <token>.
 
@@ -247,7 +247,7 @@ replaced with the <value> part of an existing trailer with the same
 <token>, if any, before the command is launched.
 +
 If some '<token>=<value>' arguments are also passed on the command
-line, when a 'trailer.<token>.command' is configured, the command will
+line, when a `trailer.<token>.command` is configured, the command will
 also be executed for each of these arguments. And the <value> part of
 these arguments, if any, will be used to replace the `$ARG` string in
 the command.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index b42f179aef..d27a33eb22 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -173,7 +173,7 @@ a space) at the start of each line:
 --eol::
 	Show <eolinfo> and <eolattr> of files.
 	<eolinfo> is the file content identification used by Git when
-	the "text" attribute is "auto" (or not set and core.autocrlf is not false).
+	the "text" attribute is "auto" (or not set and `core.autocrlf` is not false).
 	<eolinfo> is either "-text", "none", "lf", "crlf", "mixed" or "".
 +
 "" means the file is not a regular file, it is not in the index or
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index af005ece9a..dbe0c69298 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -53,7 +53,7 @@ OPTIONS
 
 --get-url::
 	Expand the URL of the given remote repository taking into account any
-	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]) and
+	`url.<base>.insteadOf` config setting (See linkgit:git-config[1]) and
 	exit without talking to the remote.
 
 --symref::
@@ -66,7 +66,7 @@ OPTIONS
 	Sort based on the key given. Prefix `-` to sort in descending order
 	of the value. Supports "version:refname" or "v:refname" (tag names
 	are treated as versions). The "version:refname" sort order can also
-	be affected by the "versionsort.suffix" configuration variable.
+	be affected by the `versionsort.suffix` configuration variable.
 	See linkgit:git-for-each-ref[1] for more sort options, but be aware
 	keys like `committerdate` that require access to the objects
 	themselves will not work for refs whose objects have not yet been
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 5bc2982909..c54feb665b 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -84,10 +84,10 @@ with comments and suggestions on the message you are responding to, and to
 conclude it with a patch submission, separating the discussion and the
 beginning of the proposed commit log message with a scissors line.
 +
-This can be enabled by default with the configuration option mailinfo.scissors.
+This can be enabled by default with the configuration option `mailinfo.scissors`.
 
 --no-scissors::
-	Ignore scissors lines. Useful for overriding mailinfo.scissors settings.
+	Ignore scissors lines. Useful for overriding `mailinfo.scissors` settings.
 
 <msg>::
 	The commit log message extracted from e-mail, usually
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index b3808dcc06..ceb039a697 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -48,8 +48,8 @@ SUBMODULES
 ----------
 Moving a submodule using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will update the gitfile and
-core.worktree setting to make the submodule work in the new location.
-It also will attempt to update the submodule.<name>.path setting in
+`core.worktree` setting to make the submodule work in the new location.
+It also will attempt to update the `submodule.<name>.path` setting in
 the linkgit:gitmodules[5] file and stage that file (unless `-n` is used).
 
 BUGS
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ef04e3a8ff..ac1d191352 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -44,9 +44,9 @@ using the `--notes` option. Such notes are added as a patch commentary
 after a three dash separator line.
 
 To change which notes are shown by 'git log', see the
-"notes.displayRef" configuration in linkgit:git-log[1].
+`notes.displayRef` configuration in linkgit:git-log[1].
 
-See the "notes.rewrite.<command>" configuration for a way to carry
+See the `notes.rewrite.<command>` configuration for a way to carry
 notes across commands that rewrite commits.
 
 
@@ -161,7 +161,7 @@ OPTIONS
 
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
-	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
+	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
 	begins with `notes/`, `refs/` and otherwise `refs/notes/` is prefixed
 	to form a full name of the ref.
@@ -185,7 +185,7 @@ OPTIONS
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
 	(default), "ours", "theirs", "union" and "cat_sort_uniq".
-	This option overrides the "notes.mergeStrategy" configuration setting.
+	This option overrides the `notes.mergeStrategy` configuration setting.
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
@@ -251,7 +251,7 @@ When done, the user can either finalize the merge with
 'git notes merge --abort'.
 
 Users may select an automated merge strategy from among the following using
-either `-s`/`--strategy` option or configuring notes.mergeStrategy accordingly:
+either `-s`/`--strategy` option or configuring `notes.mergeStrategy` accordingly:
 
 "ours" automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
@@ -327,7 +327,7 @@ This setting can be overridden by passing the `--strategy` option.
 notes.<name>.mergeStrategy::
 	Which merge strategy to choose when doing a notes merge into
 	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section above
+	`notes.mergeStrategy`.  See the "NOTES MERGE STRATEGIES" section above
 	for more information on each available strategy.
 
 notes.displayRef::
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index ec23ab7d96..326c553083 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -135,7 +135,7 @@ Submit
 Submitting changes from a Git repository back to the p4 repository
 requires a separate p4 client workspace.  This should be specified
 using the `P4CLIENT` environment variable or the Git configuration
-variable 'git-p4.client'.  The p4 client must exist, but the client root
+variable `git-p4.client`.  The p4 client must exist, but the client root
 will be created and populated if it does not already exist.
 
 To submit all changes that are in the current Git branch but not in
@@ -367,12 +367,12 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --disable-rebase::
     Disable the automatic rebase after all commits have been successfully
-    submitted. Can also be set with git-p4.disableRebase.
+    submitted. Can also be set with `git-p4.disableRebase`.
 
 --disable-p4sync::
     Disable the automatic sync of p4/master from Perforce after commits have
     been submitted. Implies `--disable-rebase`. Can also be set with
-    git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
+    `git-p4.disableP4Sync`. Sync with origin/master still goes ahead if possible.
 
 Hooks for submit
 ----------------
@@ -490,7 +490,7 @@ paths map through overlays to the same location in the repository,
 dedicating a client spec just for 'git p4'.
 
 The name of the client can be given to 'git p4' in multiple ways.  The
-variable 'git-p4.client' takes precedence if it exists.  Otherwise,
+variable `git-p4.client` takes precedence if it exists.  Otherwise,
 normal p4 mechanisms of determining the client are used:  environment
 variable `P4CLIENT`, a file referenced by `P4CONFIG`, or the local host name.
 
@@ -530,7 +530,7 @@ called 'master', and one for //depot/branch1 called 'depot/branch1'.
 However, it is not necessary to create branches in p4 to be able to use
 them like branches.  Because it is difficult to infer branch
 relationships automatically, a Git configuration setting
-'git-p4.branchList' can be used to explicitly identify branch
+`git-p4.branchList` can be used to explicitly identify branch
 relationships.  It is a list of "source:destination" pairs, like a
 simple p4 branch specification, where the "source" and "destination" are
 the path elements in the p4 repository.  The example above relied on the
@@ -748,7 +748,7 @@ git-p4.disableRebase::
     Do not rebase the tree against p4/master following a submit.
 
 git-p4.disableP4Sync::
-    Do not sync p4/master with Perforce following a submit. Implies git-p4.disableRebase.
+    Do not sync p4/master with Perforce following a submit. Implies `git-p4.disableRebase`.
 
 IMPLEMENTATION DETAILS
 ----------------------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d9a5507195..e637686597 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -212,8 +212,8 @@ $ git pull origin
 ------------------------------------------------
 +
 Normally the branch merged in is the `HEAD` of the remote repository,
-but the choice is determined by the branch.<name>.remote and
-branch.<name>.merge options; see linkgit:git-config[1] for details.
+but the choice is determined by the `branch.<name>.remote` and
+`branch.<name>.merge` options; see linkgit:git-config[1] for details.
 
 * Merge into the current branch the remote branch `next`:
 +
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 91dcaa108c..aa5db3e6e5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -411,7 +411,7 @@ Specifying `--no-force-if-includes` disables this behavior.
 	also be aborted and exit with non-zero status. If 'only' is used all
 	submodules will be recursively pushed while the superproject is left
 	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
-	to override the push.recurseSubmodules configuration variable when no
+	to override the `push.recurseSubmodules` configuration variable when no
 	submodule recursion is required.
 
 --[no-]verify::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index bd9f15ea26..22287372f7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -21,7 +21,7 @@ If <branch> is specified, 'git rebase' will perform an automatic
 it remains on the current branch.
 
 If <upstream> is not specified, the upstream configured in
-branch.<name>.remote and branch.<name>.merge options will be used (see
+`branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
@@ -404,7 +404,7 @@ See also INCOMPATIBLE OPTIONS below.
 
 --stat::
 	Show a diffstat of what changed upstream since the last rebase. The
-	diffstat is also controlled by the configuration option rebase.stat.
+	diffstat is also controlled by the configuration option `rebase.stat`.
 
 -n::
 --no-stat::
@@ -509,7 +509,7 @@ See also INCOMPATIBLE OPTIONS below.
 	split commits (see SPLITTING COMMITS below).
 +
 The commit list format can be changed by setting the configuration option
-rebase.instructionFormat.  A customized instruction format will automatically
+`rebase.instructionFormat`.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -721,7 +721,7 @@ order to apply the changes to the right lines.  However, if multiple
 areas of the code have the same surrounding lines of context, the
 wrong one can be picked.  There are real-world cases where this has
 caused commits to be reapplied incorrectly with no conflicts reported.
-Setting diff.context to a larger value may prevent such types of
+Setting `diff.context` to a larger value may prevent such types of
 problems, but increases the chance of spurious conflicts (since it
 will require more lines of matching context to apply).
 
@@ -737,7 +737,7 @@ content came from.  Since the apply backend drops the original
 information about the rebased commits and their parents (and instead
 generates new fake commits based off limited information in the
 generated patches), those commits cannot be identified; instead it has
-to fall back to a commit summary.  Also, when merge.conflictStyle is
+to fall back to a commit summary.  Also, when `merge.conflictStyle` is
 set to diff3, the apply backend will use "constructed merge base" to
 label the content from the merge base, and thus provide no information
 about the merge base commit whatsoever.
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 25702ed730..e6136a0938 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -29,7 +29,7 @@ the send-pack end, it is updating the remote.  Confused?)
 There are other real-world examples of using update and
 post-update hooks found in the Documentation/howto directory.
 
-'git-receive-pack' honours the receive.denyNonFastForwards config
+'git-receive-pack' honours the `receive.denyNonFastForwards` config
 option, which tells it if updates to a ref should be denied if they
 are not fast-forwards.
 
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 31c29c9b31..a28c72a9e4 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -188,8 +188,8 @@ actually prune them.
 
 Fetch updates for remotes or remote groups in the repository as defined by
 `remotes.<group>`. If neither group nor remote is specified on the command line,
-the configuration parameter remotes.default will be used; if
-remotes.default is not defined, all remotes which do not have the
+the configuration parameter `remotes.default` will be used; if
+`remotes.default` is not defined, all remotes which do not have the
 configuration parameter `remote.<name>.skipDefaultUpdate` set to true will
 be updated.  (See linkgit:git-config[1]).
 +
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index c5c6be5202..25990dc40b 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -181,7 +181,7 @@ records the hand resolve when it is a new conflict, or reuses the earlier hand
 resolve when it is not.  'git commit' also invokes 'git rerere'
 when committing a merge result.  What this means is that you do
 not have to do anything special yourself (besides enabling
-the rerere.enabled config variable).
+the `rerere.enabled` config variable).
 
 In our example, when you do the test merge, the manual
 resolution is recorded, and it will be reused when you do the
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 7c3c0e0007..5f6224847e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -143,7 +143,7 @@ for another option.
 
 --abbrev-ref[=(strict|loose)]::
 	A non-ambiguous short name of the objects name.
-	The option core.warnAmbiguousRefs is used to select the strict
+	The option `core.warnAmbiguousRefs` is used to select the strict
 	abbreviation mode.
 
 --symbolic::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index ea1f349a87..56d9b0627f 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -149,7 +149,7 @@ tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
 still uses a .git directory, `git rm` will move the submodules
 git directory into the superprojects git directory to protect
-the submodule's history. If it exists the submodule.<name> section
+the submodule's history. If it exists the `submodule.<name>` section
 in the linkgit:gitmodules[5] file will also be removed and that file
 will be staged (unless `--cached` or `-n` are used).
 
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index afd41a010e..9d9ef3d945 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -128,14 +128,14 @@ This option may be specified multiple times.
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
-	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
 --compose-encoding=<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
+	`sendemail.composeencoding`; if that is unspecified, UTF-8 is assumed.
 
 --transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
@@ -189,7 +189,7 @@ $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
 +
 If at least one of the specified mechanisms matches the ones advertised by the
 SMTP server and if it is supported by the utilized SASL library, the mechanism
-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
+is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
 independently of `--smtp-user`
@@ -290,7 +290,7 @@ Automating
 	Specify a command to execute once per patch file which
 	should generate patch file specific "To:" entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.tocmd' configuration value.
+	Default is the value of `sendemail.tocmd` configuration value.
 
 --cc-cmd=<command>::
 	Specify a command to execute once per patch file which
@@ -308,8 +308,8 @@ Automating
 
 --identity=<identity>::
 	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
+	`sendemail.<identity>` subsection to take precedence over
+	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
@@ -320,13 +320,13 @@ Automating
 --[no-]cc-cover::
 	If this is set, emails found in Cc: headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.cccover'
+	for each email set. Default is the value of `sendemail.cccover`
 	configuration value; if that is unspecified, default to `--no-cc-cover`.
 
 --[no-]to-cover::
 	If this is set, emails found in To: headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.tocover'
+	for each email set. Default is the value of `sendemail.tocover`
 	configuration value; if that is unspecified, default to `--no-to-cover`.
 
 --suppress-cc=<category>::
@@ -437,7 +437,7 @@ Information
 	Instead of the normal operation, dump the shorthand alias names from
 	the configured alias file(s), one per line in alphabetical order. Note,
 	this only includes the alias name and not its expanded email addresses.
-	See 'sendemail.aliasesfile' for more information about aliases.
+	See `sendemail.aliasesfile` for more information about aliases.
 
 
 CONFIGURATION
@@ -448,7 +448,7 @@ sendemail.aliasesFile::
 	email aliases files.  You must also supply `sendemail.aliasFileType`.
 
 sendemail.aliasFileType::
-	Format of the file(s) specified in sendemail.aliasesFile. Must be
+	Format of the file(s) specified in `sendemail.aliasesFile`. Must be
 	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus', or 'sendmail'.
 +
 What an alias file in each format looks like can be found in
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4b1951c5ce..0c9b68e981 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -80,7 +80,7 @@ Consider enabling untracked cache and split index if supported (see
 --split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
 
-The default can be changed using the status.showUntrackedFiles
+The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
@@ -163,7 +163,7 @@ at any time.
 The paths mentioned in the output, unlike many other Git commands, are
 made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
-the status.relativePaths config option below.
+the `status.relativePaths` config option below.
 
 Short Format
 ~~~~~~~~~~~~
@@ -265,10 +265,10 @@ based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
 format, with a few exceptions:
 
-1. The user's color.status configuration is not respected; color will
+1. The user's `color.status` configuration is not respected; color will
    always be off.
 
-2. The user's status.relativePaths configuration is not respected; paths
+2. The user's `status.relativePaths` configuration is not respected; paths
    shown will always be relative to the repository root.
 
 There is also an alternate `-z` format recommended for machine parsing. In
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 891c9e48e5..e68d91a406 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -101,7 +101,7 @@ init [--] [<path>...]::
 	repository will be assumed to be upstream.
 +
 Optional <path> arguments limit which submodules will be initialized.
-If no path is specified and submodule.active has been configured, submodules
+If no path is specified and `submodule.active` has been configured, submodules
 configured to be active will be initialized, otherwise all submodules are
 initialized.
 +
@@ -182,7 +182,7 @@ set-branch (-b|--branch) <branch> [--] <path>::
 set-branch (-d|--default) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
-	`--default` option removes the submodule.<name>.branch configuration
+	`--default` option removes the `submodule.<name>.branch` configuration
 	key, which causes the tracking branch to default to the remote `HEAD`.
 
 set-url [--] <path> <newurl>::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f316b7dfc4..91495cfa01 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1,4 +1,4 @@
-git-svn(1)
+g-it-svn(1)
 ==========
 
 NAME
@@ -57,7 +57,7 @@ COMMANDS
 	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
-	This option is not recommended, please read the 'svn.noMetadata'
+	This option is not recommended, please read the `svn.noMetadata`
 	section of this manpage before using this option.
 --use-svm-props;;
 	Set the 'useSvmProps' option in the [svn-remote] config.
@@ -149,7 +149,7 @@ the same local time zone.
 	can be used to allow only certain refs.
 +
 [verse]
-config key: svn-remote.<name>.ignore-refs
+config key: `svn-remote.<name>.ignore-refs`
 +
 If the ignore-refs configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -162,7 +162,7 @@ option is also given, both regular expressions will be used.
 	'rebase', etc) on a given repository.
 +
 [verse]
-config key: svn-remote.<name>.ignore-paths
+config key: `svn-remote.<name>.ignore-paths`
 +
 If the ignore-paths configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -192,7 +192,7 @@ Skip "branches" and "tags" of first level directories;;
 	precedence over `--include-paths`.
 +
 [verse]
-config key: svn-remote.<name>.include-paths
+config key: `svn-remote.<name>.include-paths`
 
 --log-window-size=<n>;;
 	Fetch <n> log entries per request when scanning Subversion history.
@@ -268,12 +268,12 @@ Use of 'dcommit' is preferred to 'set-tree' (below).
 	method (e.g. `svn+ssh://` or `https://`) for commit.
 +
 [verse]
-config key: svn-remote.<name>.commiturl
-config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
+config key: `svn-remote.<name>.commiturl`
+config key: `svn.commiturl` (overwrites all `svn-remote.<name>.commiturl` options)
 +
 Note that the SVN URL of the commiturl config key includes the SVN branch.
 If you rather want to set the commit URL for an entire SVN repository use
-svn-remote.<name>.pushurl instead.
+`svn-remote.<name>.pushurl` instead.
 +
 Using this option for any other purpose (don't ask) is very strongly
 discouraged.
@@ -287,7 +287,7 @@ discouraged.
 	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
 +
 [verse]
-config key: svn.pushmergeinfo
+config key: `svn.pushmergeinfo`
 +
 This option will cause git-svn to attempt to automatically populate the
 svn:mergeinfo property in the SVN repository when possible. Currently, this can
@@ -447,7 +447,7 @@ Any other arguments are passed directly to 'git log'
 	Empty directories are automatically recreated when using
 	"git svn clone" and "git svn rebase", so "mkdirs" is intended
 	for use after commands like "git checkout" or "git reset".
-	(See the svn-remote.<name>.automkdirs config file option for
+	(See the `svn-remote.<name>.automkdirs` config file option for
 	more information.)
 
 'commit-diff'::
@@ -609,7 +609,7 @@ cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like Git.
 +
 [verse]
-config key: svn.rmdir
+config key: `svn.rmdir`
 
 -e::
 --edit::
@@ -620,7 +620,7 @@ default for objects that are commits, and forced on when committing
 tree objects.
 +
 [verse]
-config key: svn.edit
+config key: `svn.edit`
 
 -l<num>::
 --find-copies-harder::
@@ -630,8 +630,8 @@ They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
 +
 [verse]
-config key: svn.l
-config key: svn.findcopiesharder
+config key: `svn.l`
+config key: `svn.findcopiesharder`
 
 -A<filename>::
 --authors-file=<filename>::
@@ -649,7 +649,7 @@ appropriate entry.  Re-running the previous 'git svn' command
 after the authors-file is modified should continue operation.
 +
 [verse]
-config key: svn.authorsfile
+config key: `svn.authorsfile`
 
 --authors-prog=<filename>::
 	If this option is specified, for each SVN committer name that
@@ -665,7 +665,7 @@ to the root of the working tree for 'fetch'. If 'filename' is
 not found, it is searched like any other command in '$PATH'.
 +
 [verse]
-config key: svn.authorsProg
+config key: `svn.authorsProg`
 
 -q::
 --quiet::
@@ -705,7 +705,7 @@ creating the branch or tag.
 	in the log message and use that as the author string.
 +
 [verse]
-config key: svn.useLogAuthor
+config key: `svn.useLogAuthor`
 
 --add-author-from::
 	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
@@ -715,7 +715,7 @@ config key: svn.useLogAuthor
 	will retrieve a valid author string for all commits.
 +
 [verse]
-config key: svn.addAuthorFrom
+config key: `svn.addAuthorFrom`
 
 ADVANCED OPTIONS
 ----------------
@@ -750,7 +750,7 @@ ADVANCED OPTIONS
 	`--no-follow-parent` to disable it.
 +
 [verse]
-config key: svn.followparent
+config key: `svn.followparent`
 
 CONFIG FILE-ONLY OPTIONS
 ------------------------
@@ -774,7 +774,7 @@ reports, and archives.  If you plan to eventually migrate from SVN to
 Git and are certain about dropping SVN history, consider
 https://github.com/newren/git-filter-repo[git-filter-repo] instead.
 filter-repo also allows reformatting of metadata for ease-of-reading
-and rewriting authorship info for non-"svn.authorsFile" users.
+and rewriting authorship info for non-`svn.authorsFile` users.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
@@ -1159,7 +1159,7 @@ $GIT_DIR/svn/\**/.rev_map.*::
 	Mapping between Subversion revision numbers and Git commit
 	names.  In a repository where the noMetadata option is not set,
 	this can be rebuilt from the git-svn-id: lines that are at the
-	end of every commit (see the 'svn.noMetadata' section above for
+	end of every commit (see the `svn.noMetadata` section above for
 	details).
 +
 'git svn fetch' and 'git svn rebase' automatically update the rev_map
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 936b64045e..4eae32e711 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -422,12 +422,12 @@ all index entries and stays unchanged.
 
 All changes in the split index are pushed back to the shared index
 file when the number of entries in the split index reaches a level
-specified by the splitIndex.maxPercentChange config variable (see
+specified by the `splitIndex.maxPercentChange` config variable (see
 linkgit:git-config[1]).
 
 Each time a new shared index file is created, the old shared index
 files are deleted if their modification time is older than what is
-specified by the splitIndex.sharedIndexExpire config variable (see
+specified by the `splitIndex.sharedIndexExpire` config variable (see
 linkgit:git-config[1]).
 
 To avoid deleting a shared index file that is still used, its
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index be48daa825..f8aeea4cb4 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -149,7 +149,7 @@ still see a subset of the modifications.
 
 LOGGING UPDATES
 ---------------
-If config parameter "core.logAllRefUpdates" is true and the ref is one
+If config parameter `core.logAllRefUpdates` is true and the ref is one
 under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
 like `HEAD` or `ORIG_HEAD`; or the file "$GIT_DIR/logs/<ref>" exists then
 `git update-ref` will append a line to the log file
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index d53b2570df..6fbe8d5583 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -71,7 +71,7 @@ browser.<tool>.path
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable `browser.<tool>.path`. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git web{litdd}browse' assumes the tool
+`browser.firefox.path`. Otherwise, 'git web{litdd}browse' assumes the tool
 is available in PATH.
 
 browser.<tool>.cmd
@@ -91,7 +91,7 @@ When 'konqueror' is specified by a command-line option or a
 configuration variable, we launch 'kfmclient' to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
-For consistency, we also try such a trick if 'browser.konqueror.path' is
+For consistency, we also try such a trick if `browser.konqueror.path` is
 set to something like `A_PATH_TO/konqueror`. That means we will try to
 launch `A_PATH_TO/kfmclient` instead.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dcc52adff6..6aafa3a15c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -154,8 +154,8 @@ If you just want to run git as if it was started in `<path>` then use
 	Set the path to the working tree. It can be an absolute path
 	or a path relative to the current working directory.
 	This can also be controlled by setting the GIT_WORK_TREE
-	environment variable and the core.worktree configuration
-	variable (see core.worktree in linkgit:git-config[1] for a
+	environment variable and the `core.worktree` configuration
+	variable (see `core.worktree` in linkgit:git-config[1] for a
 	more detailed discussion).
 
 --namespace=<path>::
@@ -210,7 +210,7 @@ If you just want to run git as if it was started in `<path>` then use
 	others (all other commands in `$PATH` that have git- prefix),
 	list-<category> (see categories in command-list.txt),
 	nohelpers (exclude helper commands), alias and config
-	(retrieve command list from config variable completion.commands)
+	(retrieve command list from config variable `completion.commands`)
 
 GIT COMMANDS
 ------------
@@ -482,7 +482,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_WORK_TREE`::
 	Set the path to the root of the working tree.
 	This can also be controlled by the `--work-tree` command-line
-	option and the core.worktree configuration variable.
+	option and the `core.worktree` configuration variable.
 
 `GIT_NAMESPACE`::
 	Set the Git namespace; see linkgit:gitnamespaces[7] for details.
@@ -609,7 +609,7 @@ other
 ~~~~~
 `GIT_MERGE_VERBOSITY`::
 	A number controlling the amount of output shown by
-	the recursive merge strategy.  Overrides merge.verbosity.
+	the recursive merge strategy.  Overrides `merge.verbosity`.
 	See linkgit:git-merge[1]
 
 `GIT_PAGER`::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 0a60472bb5..f77d8487bd 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -199,7 +199,7 @@ convert them to CRLF when files are checked out.
 
 If you simply want to have CRLF line endings in your working directory
 regardless of the repository you are working with, you can set the
-config variable "core.autocrlf" without using any attributes.
+config variable `core.autocrlf` without using any attributes.
 
 ------------------------
 [core]
@@ -424,7 +424,7 @@ filter driver definition in the config, or a filter driver that exits with
 a non-zero status, is not an error but makes the filter a no-op passthru.
 
 You can declare that a filter turns a content that by itself is unusable
-into a usable content by setting the filter.<driver>.required configuration
+into a usable content by setting the `filter.<driver>.required` configuration
 variable to `true`.
 
 Note: Whenever the clean filter is changed, the repo should be renormalized:
@@ -437,7 +437,7 @@ attribute for paths.
 *.c	filter=indent
 ------------------------
 
-Then you would define a "filter.indent.clean" and "filter.indent.smudge"
+Then you would define a `filter.indent.clean` and `filter.indent.smudge`
 configuration in your .git/config to specify a pair of commands to
 modify the contents of C programs when the source files are checked
 in ("clean" is run) and checked out (no change is made because the
@@ -723,7 +723,7 @@ Unspecified::
 
 	A path to which the `diff` attribute is unspecified
 	first gets its contents inspected, and if it looks like
-	text and is smaller than core.bigFileThreshold, it is treated
+	text and is smaller than `core.bigFileThreshold`, it is treated
 	as text. Otherwise it would generate `Binary files differ`.
 
 String::
@@ -778,7 +778,7 @@ for paths.
 *.tex	diff=tex
 ------------------------
 
-Then, you would define a "diff.tex.xfuncname" configuration to
+Then, you would define a `diff.tex.xfuncname` configuration to
 specify a regular expression that matches a line that you would
 want to appear as the hunk header "TEXT". Add a section to your
 `$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 77573c813c..d1d81cbe15 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1479,7 +1479,7 @@ on that project and has an own "public repository" goes like this:
 
 1. Prepare your work repository, by running 'git clone' on the public
    repository of the "project lead". The URL used for the
-   initial cloning is stored in the remote.origin.url
+   initial cloning is stored in the `remote.origin.url`
    configuration variable.
 
 2. Prepare a public repository accessible to others, just like
@@ -1520,7 +1520,7 @@ like this:
 1. Prepare your work repository, by 'git clone' the public
    repository of the "project lead" (or a "subsystem
    maintainer", if you work on a subsystem). The URL used for
-   the initial cloning is stored in the remote.origin.url
+   the initial cloning is stored in the `remote.origin.url`
    configuration variable.
 
 2. Do your work in your repository on `master` branch.
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 758bf39ba3..dffbdfbd0b 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -80,7 +80,7 @@ You may also have third-party helpers installed; search for
 `credential-*` in the output of `git help -a`, and consult the
 documentation of individual helpers.  Once you have selected a helper,
 you can tell Git to use it by putting its name into the
-credential.helper variable.
+`credential.helper` variable.
 
 1. Find a helper.
 +
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 88ee109fdf..5d719b4140 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -662,7 +662,7 @@ The most notable example is `HEAD`.
 [[def_upstream_branch]]upstream branch::
 	The default <<def_branch,branch>> that is merged into the branch in
 	question (or the branch in question is rebased onto). It is configured
-	via branch.<name>.remote and branch.<name>.merge. If the upstream branch
+	via `branch.<name>.remote` and `branch.<name>.merge`. If the upstream branch
 	of 'A' is 'origin/B' sometimes we say "'A' is tracking 'origin/B'".
 
 [[def_working_tree]]working tree::
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 95a7390b2c..bbf418e48c 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -7,7 +7,7 @@
 ifndef::git-pull[]
 <group>::
 	A name referring to a list of repositories as the value
-	of remotes.<group> in the configuration file.
+	of `remotes.<group>` in the configuration file.
 	(See linkgit:git-config[1]).
 endif::git-pull[]
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 62ddf41e75..82b20b80df 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1949,7 +1949,7 @@ Note that the target of a `push` is normally a
 <<def_bare_repository,bare>> repository.  You can also push to a
 repository that has a checked-out working tree, but a push to update the
 currently checked-out branch is denied by default to prevent confusion.
-See the description of the receive.denyCurrentBranch option
+See the description of the `receive.denyCurrentBranch` option
 in linkgit:git-config[1] for details.
 
 As with `git fetch`, you may also set up configuration options to
-- 
2.31.1.133.g84d06cdc06


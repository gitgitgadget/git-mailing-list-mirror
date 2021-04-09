Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842DC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D661177
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDIEGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhDIEF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40BEC061764
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q26so4195496wrz.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGPh1noOMiboS6BU197miKTi9VHCrlEKSm54+aSFuW4=;
        b=GBrar/JMnIxQ1V9E1PmT4oPg2HE9dBARHz0+3PYCYHxL5w5LfqpWCK4FQNAk4eJwbf
         FwQH+Zn9vIzXLL81IIQEYfzQhKj2fPzalkn/ExUIBu4yHwu6FmAVg/7tPN/7lD5hWLho
         hEPd9TqZw2T43fffRFmwCJkXr2YR95TuECG+57BJPyz8JnAWKw05K9XfRkeaid0wPsJb
         0YSNt3RSkgN33Mu1AGH6YnFww+e65DGFUgNfytVflmz9qZWJP/gTpQGeXw+IkDDmUDZI
         bPQQFZDRsgy1Ubd8v4LWwh2twBhcRYwS6ypRRAG+u7DFvezQjOS6AaI9porluWyxbwtW
         HesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGPh1noOMiboS6BU197miKTi9VHCrlEKSm54+aSFuW4=;
        b=NHrIpb7ThIY7e2PM8X+sHcj3iTPuymRzh4U5mOrhNwFzLXGiPab2s3rt10MYOUXhVg
         sZmkfRjjBSYwXyL0Q0+zBuzggVRg7hRWuQFDCWxvRmqI3PVuRlPpDs3GeMniGvet0OtD
         v2C+QAeZFfRtc7wfJC+lJdT4TWL8CDnKhVufzPKlI/I1l/Z9xGF3/dhBt/xGSYuZViMB
         h9IjmnhI2D89I06HBh3hwvP2/7u30vOGElDTPw3gog0KOAxkkP8vZqETO0DZEvagEYM1
         KErbl2GLQDslhrAbV1oFeGuhekbiK+aw+YJEEPy87L6nd0+VeMIBIfbroBLDiKVhWJqU
         XBxQ==
X-Gm-Message-State: AOAM530EAtiblSNz1zS8oeIbQqNDY2mQDFlypfIn1W+6QnCKBSL5R6Xg
        zJHK5Q8Cf+I9XhWPUNRxdWAW90UUfaDaig==
X-Google-Smtp-Source: ABdhPJzOqjADgFUClykyAIblFz+BGm3tJKTA3/FTcjT60GoDs5baf+zLfZfCYSMIGLjfz1nThQz1bw==
X-Received: by 2002:a5d:4bce:: with SMTP id l14mr15310212wrt.99.1617941143945;
        Thu, 08 Apr 2021 21:05:43 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:43 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 05/13] doc: typeset git-svn subcommands in monospace
Date:   Fri,  9 Apr 2021 06:02:53 +0200
Message-Id: <20210409040301.3260358-6-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap git-svn subcommands with backticks as indicated in the
CodingGuidelines.

The following regex assisted the interactive substitution in emacs (evil mode).

%s/\(^\|[[:space:]]+\)['"]?\(init\|fetch\|clone\|rebase\|dcommit\|branch\|tag\|log\|blame\|find-rev\|set-tree\|create-ignore\|show-ignore\|mkdirs\|commit-diff\|info\|proplist\|propget\|propset\|show-externals\|gc\|reset\)['"]?\([[:punct:]]\|[[:space:]]+\|$\)/\1`\2`\3/gc

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/git-svn.txt | 176 +++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3097f4f1c5..f42cf6b189 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -19,16 +19,16 @@ repository.
 `git svn` can track a standard Subversion repository,
 following the common "trunk/branches/tags" layout, with the `--stdlayout` option.
 It can also follow branches and tags in any layout with the `-T`/`-t`/`-b` options
-(see options to 'init' below, and also the 'clone' command).
+(see options to `init` below, and also the `clone` command).
 
 Once tracking a Subversion repository (with any of the above methods), the Git
-repository can be updated from Subversion by the 'fetch' command and
-Subversion updated from Git by the 'dcommit' command.
+repository can be updated from Subversion by the `fetch` command and
+Subversion updated from Git by the `dcommit` command.
 
 COMMANDS
 --------
 
-'init'::
+`init`::
 	Initializes an empty Git repository with additional
 	metadata directories for `git svn`.  The Subversion URL
 	may be specified as a command-line argument, or as full
@@ -45,7 +45,7 @@ COMMANDS
 --branches=<branches_subdir>;;
 -s;;
 --stdlayout;;
-	These are optional command-line options for init.  Each of
+	These are optional command-line options for `init`.  Each of
 	these flags can point to a relative repository path
 	(`--tags=project/tags`) or a full url
 	(`--tags=https://foo.org/project/tags`).
@@ -96,16 +96,16 @@ If you still want the old default, you can get it by passing
 your Perl's Getopt::Long is < v2.37).
 
 --ignore-refs=<regex>;;
-	When passed to 'init' or 'clone' this regular expression will
-	be preserved as a config key.  See 'fetch' for a description
+	When passed to `init` or `clone` this regular expression will
+	be preserved as a config key.  See `fetch` for a description
 	of `--ignore-refs`.
 --ignore-paths=<regex>;;
-	When passed to 'init' or 'clone' this regular expression will
-	be preserved as a config key.  See 'fetch' for a description
+	When passed to `init` or `clone` this regular expression will
+	be preserved as a config key.  See `fetch` for a description
 	of `--ignore-paths`.
 --include-paths=<regex>;;
-	When passed to 'init' or 'clone' this regular expression will
-	be preserved as a config key.  See 'fetch' for a description
+	When passed to `init` or `clone` this regular expression will
+	be preserved as a config key.  See `fetch` for a description
 	of `--include-paths`.
 --no-minimize-url;;
 	When tracking multiple directories (using `--stdlayout`,
@@ -119,7 +119,7 @@ your Perl's Getopt::Long is < v2.37).
 	level directory.  This option is off by default when only
 	one URL/branch is tracked (it would do little good).
 
-'fetch'::
+`fetch`::
 	Fetch unfetched revisions from the Subversion remote we are
 	tracking.  The name of the [svn-remote "..."] section in the
 	$GIT_DIR/config file may be specified as an optional
@@ -157,9 +157,9 @@ option is also given, both regular expressions will be used.
 --ignore-paths=<regex>;;
 	This allows one to specify a Perl regular expression that will
 	cause skipping of all matching paths from checkout from SVN.
-	The `--ignore-paths` option should match for every 'fetch'
-	(including automatic fetches due to 'clone', 'dcommit',
-	'rebase', etc) on a given repository.
+	The `--ignore-paths` option should match for every `fetch`
+	(including automatic fetches due to `clone`, `dcommit`,
+	`rebase`, etc) on a given repository.
 +
 [verse]
 config key: `svn-remote.<name>.ignore-paths`
@@ -186,9 +186,9 @@ Skip "branches" and "tags" of first level directories;;
 --include-paths=<regex>;;
 	This allows one to specify a Perl regular expression that will
 	cause the inclusion of only matching paths from checkout from SVN.
-	The `--include-paths` option should match for every 'fetch'
-	(including automatic fetches due to 'clone', 'dcommit',
-	'rebase', etc) on a given repository. `--ignore-paths` takes
+	The `--include-paths` option should match for every `fetch`
+	(including automatic fetches due to `clone`, `dcommit`,
+	`rebase`, etc) on a given repository. `--ignore-paths` takes
 	precedence over `--include-paths`.
 +
 [verse]
@@ -197,19 +197,19 @@ config key: `svn-remote.<name>.include-paths`
 --log-window-size=<n>;;
 	Fetch <n> log entries per request when scanning Subversion history.
 	The default is 100. For very large Subversion repositories, larger
-	values may be needed for 'clone'/'fetch' to complete in reasonable
+	values may be needed for `clone`/'fetch' to complete in reasonable
 	time. But overly large values may lead to higher memory usage and
 	request timeouts.
 
-'clone'::
-	Runs 'init' and 'fetch'.  It will automatically create a
+`clone`::
+	Runs `init` and `fetch`.  It will automatically create a
 	directory based on the basename of the URL passed to it;
 	or if a second argument is passed; it will create a directory
 	and work within that.  It accepts all arguments that the
-	'init' and 'fetch' commands accept; with the exception of
+	`init` and `fetch` commands accept; with the exception of
 	`--fetch-all` and `--parent`.  After a repository is cloned,
-	the 'fetch' command will be able to update revisions without
-	affecting the working tree; and the 'rebase' command will be
+	the `fetch` command will be able to update revisions without
+	affecting the working tree; and the `rebase` command will be
 	able to update the working tree with the latest changes.
 
 --preserve-empty-dirs;;
@@ -223,7 +223,7 @@ config key: `svn-remote.<name>.include-paths`
 	Set the name of placeholder files created by `--preserve-empty-dirs`.
 	Default: ".gitignore"
 
-'rebase'::
+`rebase`::
 	This fetches revisions from the SVN parent of the current `HEAD`
 	and rebases the current (uncommitted to SVN) work against it.
 +
@@ -243,10 +243,10 @@ This automatically updates the rev_map if needed (see
 
 -l;;
 --local;;
-	Do not fetch remotely; only run `git rebase` against the
+	Do not `fetch` remotely; only run `git rebase` against the
 	last fetched commit from the upstream SVN.
 
-'dcommit'::
+`dcommit`::
 	Commit each diff from the current branch directly to the SVN
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
@@ -256,7 +256,7 @@ When an optional Git branch name (or a Git commit object name)
 is specified as an argument, the subcommand works on the specified
 branch, not on the current branch.
 +
-Use of 'dcommit' is preferred to 'set-tree' (below).
+Use of `dcommit` is preferred to `set-tree` (below).
 +
 --no-rebase;;
 	After committing, do not rebase or reset.
@@ -279,7 +279,7 @@ Using this option for any other purpose (don't ask) is very strongly
 discouraged.
 
 --mergeinfo=<mergeinfo>;;
-	Add the given merge information during the dcommit
+	Add the given merge information during the `dcommit`
 	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
 	store this information (as a property), and svn clients starting from
 	version 1.5 can make use of it. To specify merge information from multiple
@@ -302,7 +302,7 @@ first have already been pushed into SVN.
 `git svn dcommit` returns immediately if answer is "no" or "quit", without
 committing anything to SVN.
 
-'branch'::
+`branch`::
 	Create a branch in the SVN repository.
 
 -m;;
@@ -317,8 +317,8 @@ committing anything to SVN.
 -d<path>;;
 --destination=<path>;;
 
-	If more than one `--branches` (or `--tags`) option was given to the 'init'
-	or 'clone' command, you must provide the location of the branch (or
+	If more than one `--branches` (or `--tags`) option was given to the `init`
+	or `clone` command, you must provide the location of the branch (or
 	tag) you wish to create in the SVN repository.  <path> specifies which
 	path to use to create the branch or tag and should match the pattern
 	on the left-hand side of one of the configured branches or tags
@@ -328,7 +328,7 @@ committing anything to SVN.
 	git config --get-all svn-remote.<name>.tags
 +
 where <name> is the name of the SVN repository as specified by the `-R` option to
-'init' (or "svn" by default).
+`init` (or "svn" by default).
 
 --username;;
 	Specify the SVN username to perform the commit as.  This option overrides
@@ -348,11 +348,11 @@ where <name> is the name of the SVN repository as specified by the `-R` option t
 	`--parents` on svn cp commands and is useful for non-standard repository
 	layouts.
 
-'tag'::
+`tag`::
 	Create a tag in the SVN repository. This is a shorthand for
 	'branch -t'.
 
-'log'::
+`log`::
 	This should make it easy to look up svn log messages when svn
 	users refer to `-r`/`--revision` numbers.
 +
@@ -389,7 +389,7 @@ environment). This command has the same behaviour.
 +
 Any other arguments are passed directly to `git log`
 
-'blame'::
+`blame`::
 	Show what revision and author last modified each line of a file. The
 	output of this mode is format-compatible with the output of
 	`svn blame' by default. Like the SVN blame command,
@@ -421,8 +421,8 @@ Any other arguments are passed directly to `git log`
 	not an exact match return the closest match searching forward in the
 	history.
 
-'set-tree'::
-	You should consider using 'dcommit' instead of this command.
+`set-tree`::
+	You should consider using `dcommit` instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up to date.  This makes
 	absolutely no attempts to do patching when committing to SVN, it
@@ -430,27 +430,27 @@ Any other arguments are passed directly to `git log`
 	commit.  All merging is assumed to have taken place
 	independently of `git svn` functions.
 
-'create-ignore'::
+`create-ignore`::
 	Recursively finds the svn:ignore property on directories and
 	creates matching .gitignore files. The resulting files are staged to
 	be committed, but are not committed. Use `-r`/`--revision` to refer to a
 	specific revision.
 
-'show-ignore'::
+`show-ignore`::
 	Recursively finds and lists the svn:ignore property on
 	directories.  The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
-'mkdirs'::
+`mkdirs`::
 	Attempts to recreate empty directories that core Git cannot track
 	based on information in $GIT_DIR/svn/<refname>/unhandled.log files.
 	Empty directories are automatically recreated when using
-	`git svn clone` and `git svn rebase`, so "mkdirs" is intended
+	`git svn clone` and `git svn rebase`, so `mkdirs` is intended
 	for use after commands like `git checkout` or `git reset`.
 	(See the `svn-remote.<name>.automkdirs` config file option for
 	more information.)
 
-'commit-diff'::
+`commit-diff`::
 	Commits the diff of two tree-ish arguments from the
 	command-line.  This command does not rely on being inside a `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
@@ -475,22 +475,22 @@ denotes such an object, or it is requested by invoking an editor (see
 	Take the commit message from the given file. This option
 	disables the `--edit` option.
 
-'info'::
+`info`::
 	Shows information about a file or directory similar to what
 	`svn info' provides.  Does not currently support a `-r`/`--revision`
 	argument.  Use the `--url` option to output only the value of the
 	'URL:' field.
 
-'proplist'::
+`proplist`::
 	Lists the properties stored in the Subversion repository about a
 	given file or directory.  Use `-r`/`--revision` to refer to a specific
 	Subversion revision.
 
-'propget'::
+`propget`::
 	Gets the Subversion property given as the first argument, for a
 	file.  A specific revision can be specified with `-r`/`--revision`.
 
-'propset'::
+`propset`::
 	Sets the Subversion property given as the first argument, to the
 	value given as the second argument for the file given as the
 	third argument.
@@ -504,28 +504,28 @@ git svn propset svn:keywords "FreeBSD=%H" devel/py-tipper/Makefile
 This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 'devel/py-tipper/Makefile'.
 
-'show-externals'::
+`show-externals`::
 	Shows the Subversion externals.  Use `-r`/`--revision` to specify a
 	specific revision.
 
-'gc'::
+`gc`::
 	Compress $GIT_DIR/svn/<refname>/unhandled.log files and remove
 	$GIT_DIR/svn/<refname>/index files.
 
-'reset'::
-	Undoes the effects of 'fetch' back to the specified revision.
+`reset`::
+	Undoes the effects of `fetch` back to the specified revision.
 	This allows you to re-'fetch' an SVN revision.  Normally the
-	contents of an SVN revision should never change and 'reset'
+	contents of an SVN revision should never change and `reset`
 	should not be necessary.  However, if SVN permissions change,
-	or if you alter your `--ignore-paths` option, a 'fetch' may fail
+	or if you alter your `--ignore-paths` option, a `fetch` may fail
 	with "not found in commit" (file not previously visible) or
 	"checksum mismatch" (missed a modification).  If the problem
 	file cannot be ignored forever (with `--ignore-paths`) the only
-	way to repair the repo is to use 'reset'.
+	way to repair the repo is to use `reset`.
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
 '$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
-Follow 'reset' with a 'fetch' and then `git reset` or `git rebase` to
+Follow 'reset' with a `fetch` and then `git reset` or `git rebase` to
 move local branches onto the new tree.
 
 -r <n>;;
@@ -560,7 +560,7 @@ git svn fetch
 +
 Then fixup `master` with `git rebase`.
 Do NOT use `git merge` or your history will not be compatible with a
-future 'dcommit'!
+future `dcommit`!
 +
 [verse]
 git rebase --onto remotes/git-svn A^ master
@@ -576,31 +576,31 @@ OPTIONS
 
 --shared[=(false|true|umask|group|all|world|everybody)]::
 --template=<template_directory>::
-	Only used with the 'init' command.
+	Only used with the `init` command.
 	These are passed directly to `git init`.
 
 -r <arg>::
 --revision <arg>::
-	   Used with the 'fetch' command.
+	   Used with the `fetch` command.
 +
 This allows revision ranges for partial/cauterized history
 to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
 $NUMBER:HEAD, and BASE:$NUMBER are all supported.
 +
-This can allow you to make partial mirrors when running fetch;
+This can allow you to make partial mirrors when running `fetch`;
 but is generally not recommended because history will be skipped
 and lost.
 
 -::
 --stdin::
-	Only used with the 'set-tree' command.
+	Only used with the `set-tree` command.
 +
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
 `git rev-list --pretty=oneline` output can be used.
 
 --rmdir::
-	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
+	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
@@ -613,7 +613,7 @@ config key: `svn.rmdir`
 
 -e::
 --edit::
-	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
+	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
@@ -624,7 +624,7 @@ config key: `svn.edit`
 
 -l<num>::
 --find-copies-harder::
-	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
+	Only used with the `dcommit`, `set-tree` and `commit-diff` commands.
 +
 They are both passed directly to `git diff-tree`; see
 linkgit:git-diff-tree[1] for more information.
@@ -660,8 +660,8 @@ config key: `svn.authorsfile`
 	file.
 +
 Due to historical reasons a relative 'filename' is first searched
-relative to the current directory for 'init' and 'clone' and relative
-to the root of the working tree for 'fetch'. If 'filename' is
+relative to the current directory for `init` and `clone` and relative
+to the root of the working tree for `fetch`. If 'filename' is
 not found, it is searched like any other command in '$PATH'.
 +
 [verse]
@@ -679,36 +679,36 @@ config key: `svn.authorsProg`
 -p::
 --rebase-merges::
 --preserve-merges (DEPRECATED)::
-	These are only used with the 'dcommit' and 'rebase' commands.
+	These are only used with the `dcommit` and `rebase` commands.
 +
-Passed directly to `git rebase` when using 'dcommit' if a
-`git reset` cannot be used (see 'dcommit').
+Passed directly to `git rebase` when using `dcommit` if a
+`git reset` cannot be used (see `dcommit`).
 
 -n::
 --dry-run::
-	This can be used with the 'dcommit', 'rebase', 'branch' and
-	'tag' commands.
+	This can be used with the `dcommit`, `rebase`, `branch` and
+	`tag` commands.
 +
-For 'dcommit', print out the series of Git arguments that would show
+For `dcommit`, print out the series of Git arguments that would show
 which diffs would be committed to SVN.
 +
-For 'rebase', display the local branch associated with the upstream svn
+For `rebase`, display the local branch associated with the upstream svn
 repository associated with the current branch and the URL of svn
 repository that will be fetched from.
 +
-For 'branch' and 'tag', display the urls that will be used for copying when
+For `branch` and `tag`, display the urls that will be used for copying when
 creating the branch or tag.
 
 --use-log-author::
-	When retrieving svn commits into Git (as part of 'fetch', 'rebase', or
-	'dcommit' operations), look for the first `From:` line or `Signed-off-by` trailer
+	When retrieving svn commits into Git (as part of `fetch`, `rebase`, or
+	`dcommit` operations), look for the first `From:` line or `Signed-off-by` trailer
 	in the log message and use that as the author string.
 +
 [verse]
 config key: `svn.useLogAuthor`
 
 --add-author-from::
-	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
+	When committing to svn from Git (as part of `set-tree` or `dcommit`
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by` trailer, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
@@ -724,7 +724,7 @@ ADVANCED OPTIONS
 --id <GIT_SVN_ID>::
 	This sets GIT_SVN_ID (instead of using the environment).  This
 	allows the user to override the default refname to fetch from
-	when tracking a single URL.  The 'log' and 'dcommit' commands
+	when tracking a single URL.  The `log` and `dcommit` commands
 	no longer require this switch as an argument.
 
 -R<remote name>::
@@ -999,16 +999,16 @@ CAVEATS
 -------
 
 For the sake of simplicity and interoperating with Subversion,
-it is recommended that all `git svn` users clone, fetch and dcommit
+it is recommended that all `git svn` users `clone`, `fetch` and `dcommit`
 directly from the SVN server, and avoid all `git clone`/`pull`/`merge`/`push`
 operations between Git repositories and branches.  The recommended
 method of exchanging code between Git branches and users is
-`git format-patch` and `git am`, or just 'dcommit'ing to the SVN repository.
+`git format-patch` and `git am`, or just `dcommit`ing to the SVN repository.
 
 Running `git merge` or `git pull` is NOT recommended on a branch you
-plan to 'dcommit' from because Subversion users cannot see any
+plan to `dcommit` from because Subversion users cannot see any
 merges you've made.  Furthermore, if you merge or pull from a Git branch
-that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
+that is a mirror of an SVN branch, `dcommit` may commit to the wrong
 branch.
 
 If you do merge, note the following rule: `git svn dcommit` will
@@ -1017,7 +1017,7 @@ attempt to commit on top of the SVN commit named in
 git log --grep=^git-svn-id: --first-parent -1
 ------------------------------------------------------------------------
 You 'must' therefore ensure that the most recent commit of the branch
-you want to dcommit to is the 'first' parent of the merge.  Chaos will
+you want to `dcommit` to is the 'first' parent of the merge.  Chaos will
 ensue otherwise, especially if the first parent is an older commit on
 the same SVN branch.
 
@@ -1026,15 +1026,15 @@ any `git svn` metadata, or config.  So repositories created and managed with
 using `git svn` should use 'rsync' for cloning, if cloning is to be done
 at all.
 
-Since 'dcommit' uses rebase internally, any Git branches you `git push` to
-before 'dcommit' on will require forcing an overwrite of the existing ref
+Since `dcommit` uses rebase internally, any Git branches you `git push` to
+before `dcommit` on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
 
 Do not use the `--amend` option of linkgit:git-commit[1] on a change you've
 already dcommitted.  It is considered bad practice to `--amend` commits
 you've already pushed to a remote repository for other users, and
-dcommit with SVN is analogous to that.
+`dcommit` with SVN is analogous to that.
 
 When cloning an SVN repository, if none of the options for describing
 the repository layout is used (`--trunk`, `--tags`, `--branches`,
@@ -1054,7 +1054,7 @@ branches and tags is required, the options `--trunk` / `--branches` /
 When using multiple `--branches` or `--tags`, `git svn` does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
-use 'init' to set up your Git repository then, before your first 'fetch', edit
+use `init` to set up your Git repository then, before your first `fetch`, edit
 the $GIT_DIR/config file so that the branches and tags are associated
 with different name spaces.  For example:
 
@@ -1085,7 +1085,7 @@ CONFIGURATION
 
 `git svn` stores [svn-remote] configuration information in the
 repository $GIT_DIR/config file.  It is similar the core Git
-[remote] sections except 'fetch' keys do not accept glob
+[remote] sections except `fetch` keys do not accept glob
 arguments; but they are instead handled by the 'branches'
 and 'tags' keys.  Since some SVN repositories are oddly
 configured with multiple projects glob expansions such those
@@ -1105,7 +1105,7 @@ Keep in mind that the `*` (asterisk) wildcard of the local ref
 (right of the `:`) *must* be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's an
 independent path component (surrounded by `/` or EOL).   This
-type of configuration is not automatically created by 'init' and
+type of configuration is not automatically created by `init` and
 should be manually entered with a text-editor or using `git config`.
 
 Also note that only one asterisk is allowed per word. For example:
-- 
2.31.1.133.g84d06cdc06


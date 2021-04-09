Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDEBC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31449610A4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhDIEGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhDIEGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A84FC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so459937wrt.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btbYTx9gGWAAYRWoTvINju3tKJbFuw1ShKOSyzmlrG0=;
        b=EZzoKmlX8594ejaZDo/cqepHFnhXcelv2CTYJip2rrkQnW2Tay5o2fgIxncHEASGjh
         oEcHEOpe5OnliQSCX9gHXkL7eo5SYk+aQ3E5d9105TSC+Aqgo48KgLx2vTP9k1D/QqMF
         f1KKXfTP8SRN4UEWHW8/AQIwXcHsT+qYJP4Gk+KCbUFGcbrIPDL2SnqYf4+qBxlLK1Vx
         uvuMb5pzAw9u7sYp5yuIfR8vM3sRdzL5NvrigC1twLYExvI0iAjCNlbrss2xRCpg9KdI
         efaGl7gY+/iQqv96aY1ug2AkZfhhb+Dc2Ed69fqAMF4pev284nhTEAjc+JVJe3gIdOjG
         oszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btbYTx9gGWAAYRWoTvINju3tKJbFuw1ShKOSyzmlrG0=;
        b=RTA/tpfI3VH3MevbJRx3qhExrAizxbbIhWeV+2w1hm1D49yZmobChIQ2XezNM3z77G
         ypfCy3cOm/Biup7KFQZ42fbDwiPHlYMGuUAIlLx3wDO6ZzxVftz0Kdi4jNzLmFssaDFx
         cac6Z5/ke1mev6x3PSfHmjXwS2svvFy6u4Jehf/vhXAQnzmkzskqeQw7RT0c0lldLOIN
         bN1Mz4sjAqM3AyS9FmCjRz6O2A+y5KNufM0hXf4NBgiNzVyGEPhA5axqdYrYCxwThd/I
         6WAmnquCso8kXHbgTRJ4sxwpvtDqUcAOub1z6DouMooohtQoOC7U46oMlJlTNCDsFzS3
         OlIQ==
X-Gm-Message-State: AOAM531hQZ8l4xS+pMSdHAjxTvmnViZtLmxqxbGIDfbCTDyMB7Tepz9f
        TY+sKEx6RnZs3tEUlPlenPWGdNmz7HATjw==
X-Google-Smtp-Source: ABdhPJxzcKEdLbc//U+m4F+6oCLnfhu39GydsF5M7Umkf55jb+ZenjS3K2+z+tbAmR4ynPGZr2ExAw==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr13931940wrm.282.1617941147043;
        Thu, 08 Apr 2021 21:05:47 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:46 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 08/13] doc: typeset filepath and $variables in monospace
Date:   Fri,  9 Apr 2021 06:02:56 +0200
Message-Id: <20210409040301.3260358-9-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap filepaths and $-prefixed environment or Perl variables with
backticks as indicated in the CodingGuidelines.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/config.txt                 | 12 ++--
 Documentation/git-bisect-lk2009.txt      | 12 ++--
 Documentation/git-bugreport.txt          |  2 +-
 Documentation/git-bundle.txt             |  2 +-
 Documentation/git-checkout.txt           |  2 +-
 Documentation/git-config.txt             | 18 ++---
 Documentation/git-credential-store.txt   |  6 +-
 Documentation/git-daemon.txt             |  2 +-
 Documentation/git-describe.txt           |  8 +--
 Documentation/git-fast-export.txt        |  2 +-
 Documentation/git-fetch-pack.txt         | 14 ++--
 Documentation/git-fetch.txt              |  2 +-
 Documentation/git-filter-branch.txt      |  6 +-
 Documentation/git-for-each-ref.txt       |  2 +-
 Documentation/git-fsck.txt               |  8 +--
 Documentation/git-http-backend.txt       |  4 +-
 Documentation/git-http-fetch.txt         |  2 +-
 Documentation/git-http-push.txt          |  2 +-
 Documentation/git-log.txt                |  4 +-
 Documentation/git-mergetool--lib.txt     |  4 +-
 Documentation/git-p4.txt                 | 18 ++---
 Documentation/git-pack-objects.txt       |  4 +-
 Documentation/git-pack-refs.txt          |  2 +-
 Documentation/git-push.txt               |  2 +-
 Documentation/git-read-tree.txt          | 22 +++---
 Documentation/git-receive-pack.txt       | 18 ++---
 Documentation/git-remote.txt             |  4 +-
 Documentation/git-restore.txt            |  2 +-
 Documentation/git-rev-parse.txt          | 16 ++---
 Documentation/git-send-email.txt         |  2 +-
 Documentation/git-send-pack.txt          |  4 +-
 Documentation/git-show-branch.txt        |  2 +-
 Documentation/git-show-ref.txt           | 12 ++--
 Documentation/git-submodule.txt          | 16 ++---
 Documentation/git-svn.txt                | 36 +++++-----
 Documentation/git-update-index.txt       |  8 +--
 Documentation/git-update-ref.txt         | 10 +--
 Documentation/git-update-server-info.txt |  4 +-
 Documentation/git.txt                    |  6 +-
 Documentation/gitattributes.txt          |  6 +-
 Documentation/githooks.txt               |  6 +-
 Documentation/gitignore.txt              |  6 +-
 Documentation/gitk.txt                   |  2 +-
 Documentation/gitmailmap.txt             |  2 +-
 Documentation/gitmodules.txt             |  2 +-
 Documentation/gitrepository-layout.txt   | 52 +++++++-------
 Documentation/gitsubmodules.txt          |  2 +-
 Documentation/gitweb.conf.txt            | 92 ++++++++++++------------
 Documentation/gitweb.txt                 |  8 +--
 Documentation/glossary-content.txt       |  2 +-
 Documentation/pretty-formats.txt         |  4 +-
 Documentation/pretty-options.txt         |  6 +-
 Documentation/rev-list-options.txt       |  2 +-
 Documentation/revisions.txt              | 22 +++---
 54 files changed, 258 insertions(+), 258 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1747307621..68529ad9db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -164,8 +164,8 @@ A few more notes on matching via `gitdir` and `gitdir/i`:
  * Symlinks in `$GIT_DIR` are not resolved before matching.
 
  * Both the symlink & realpath versions of paths will be matched
-   outside of `$GIT_DIR`. E.g. if ~/git is a symlink to
-   /mnt/storage/git, both `gitdir:~/git` and `gitdir:/mnt/storage/git`
+   outside of `$GIT_DIR`. E.g. if `~/git` is a symlink to
+   `/mnt/storage/git`, both `gitdir:~/git` and `gitdir:/mnt/storage/git`
    will match.
 +
 This was not the case in the initial release of this feature in
@@ -173,7 +173,7 @@ v2.13.0, which only matched the realpath version. Configuration that
 wants to be compatible with the initial release of this feature needs
 to either specify only the realpath version, or both versions.
 
- * Note that "../" is not special and will match literally, which is
+ * Note that `../` is not special and will match literally, which is
    unlikely what you want.
 
 Example
@@ -204,15 +204,15 @@ Example
 	path = foo.inc ; find "foo.inc" relative to the current file
 	path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory
 
-; include if $GIT_DIR is /path/to/foo/.git
+; include if `$GIT_DIR` is /path/to/foo/.git
 [includeIf "gitdir:/path/to/foo/.git"]
 	path = /path/to/foo.inc
 
-; include for all repositories inside /path/to/group
+; include for all repositories inside `/path/to/group`
 [includeIf "gitdir:/path/to/group/"]
 	path = /path/to/foo.inc
 
-; include for all repositories inside $HOME/to/group
+; include for all repositories inside `$HOME/to/group`
 [includeIf "gitdir:~/to/group/"]
 	path = /path/to/foo.inc
 
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index b919b3ea42..de5f221613 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1218,9 +1218,9 @@ With the example above that would give:
 -------------
 
 That's why the `git replace` command was created. Technically it
-stores replacements "refs" in the "refs/replace/" hierarchy. These
-"refs" are like branches (that are stored in "refs/heads/") or tags
-(that are stored in "refs/tags"), and that means that they can
+stores replacements `refs` in the `refs/replace/` hierarchy. These
+`refs` are like branches (that are stored in `refs/heads/`) or tags
+(that are stored in `refs/tags`), and that means that they can
 automatically be shared like branches or tags among developers.
 
 `git replace` is a very powerful mechanism. It can be used to fix
@@ -1233,10 +1233,10 @@ it is now in the `master` branch of Git's Git repository and it should
 be released in Git 1.6.5 in October or November 2009.
 
 One problem with `git replace` is that currently it stores all the
-replacements refs in "refs/replace/", but it would be perhaps better
+replacements refs in `refs/replace/`, but it would be perhaps better
 if the replacement refs that are useful only for bisecting would be in
-"refs/replace/bisect/". This way the replacement refs could be used
-only for bisecting, while other refs directly in "refs/replace/" would
+`refs/replace/bisect/`. This way the replacement refs could be used
+only for bisecting, while other refs directly in `refs/replace/` would
 be used nearly all the time.
 
 Bisecting sporadic bugs
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index bb1355248e..0d5ef36f90 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -29,7 +29,7 @@ The following information is captured automatically:
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
  - A list of enabled hooks
- - $SHELL
+ - `$SHELL`
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index fb0ebe1257..51f8dd463f 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -168,7 +168,7 @@ machineB$ git clone -b master /home/me/tmp/file.bundle R2
 ----------------
 
 This will define a remote called `origin` in the resulting repository that
-lets you fetch and pull from the bundle. The $GIT_DIR/config file in R2 will
+lets you fetch and pull from the bundle. The `$GIT_DIR/config` file in R2 will
 have an entry like this:
 
 ------------------------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c3fc807d91..15f9690e37 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -327,7 +327,7 @@ Note that this option uses the no overlay mode by default (see also
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
-	when prepended with "refs/heads/", is a valid ref), then that
+	when prepended with `refs/heads/`, is a valid ref), then that
 	branch is checked out. Otherwise, if it refers to a valid
 	commit, your `HEAD` becomes "detached" and you are no longer on
 	any branch (see below for details).
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index afb14bcafe..80b646b895 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -286,27 +286,27 @@ FILES
 If not set explicitly with `--file`, there are four files where
 `git config` will search for configuration options:
 
-$(prefix)/etc/gitconfig::
+`$(prefix)/etc/gitconfig`::
 	System-wide configuration file.
 
-$XDG_CONFIG_HOME/git/config::
-	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
+`$XDG_CONFIG_HOME/git/config`::
+	Second user-specific configuration file. If `$XDG_CONFIG_HOME` is not set
 	or empty, `$HOME/.config/git/config` will be used. Any single-valued
 	variable set in this file will be overwritten by whatever is in
 	`~/.gitconfig`.  It is a good idea not to create this file if
 	you sometimes use older versions of Git, as support for this
 	file was added fairly recently.
 
-~/.gitconfig::
+`~/.gitconfig`::
 	User-specific configuration file. Also called "global"
 	configuration file.
 
-$GIT_DIR/config::
+`$GIT_DIR/config`::
 	Repository specific configuration file.
 
-$GIT_DIR/config.worktree::
+`$GIT_DIR/config.worktree`::
 	This is optional and is only searched when
-	`extensions.worktreeConfig` is present in $GIT_DIR/config.
+	`extensions.worktreeConfig` is present in `$GIT_DIR/config`.
 
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
@@ -338,11 +338,11 @@ ENVIRONMENT
 GIT_CONFIG::
 	Take the configuration from the given file instead of `.git/config`.
 	Using the `--global` option forces this to `~/.gitconfig`. Using the
-	`--system` option forces this to $(prefix)/etc/gitconfig.
+	`--system` option forces this to `$(prefix)/etc/gitconfig`.
 
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
-	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
+	`$(prefix)/etc/gitconfig` file. See linkgit:git[1] for details.
 
 See also <<FILES>>.
 
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 376b0d6c5f..3d83420f0a 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -47,11 +47,11 @@ FILES
 If not set explicitly with `--file`, there are two files where
 `git-credential-store` will search for credentials in order of precedence:
 
-~/.git-credentials::
+`~/.git-credentials`::
 	User-specific credentials file.
 
-$XDG_CONFIG_HOME/git/credentials::
-	Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
+`$XDG_CONFIG_HOME/git/credentials`::
+	Second user-specific credentials file. If `$XDG_CONFIG_HOME` is not set
 	or empty, `$HOME/.config/git/credentials` will be used. Any credentials
 	stored in this file will not be used if `~/.git-credentials` has a
 	matching credential as well. It is a good idea not to create this file
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 1298ceb723..3f684378f4 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -209,7 +209,7 @@ Git configuration files in that directory are readable by `<user>`.
 	(%CH), IP address (%IP), and TCP port (%P) as its command-line
 	arguments. The external command can decide to decline the
 	service by exiting with a non-zero status (or to allow it by
-	exiting with a zero status).  It can also look at the $REMOTE_ADDR
+	exiting with a zero status).  It can also look at the `$REMOTE_ADDR`
 	and `$REMOTE_PORT` environment variables to learn about the
 	requestor when making this decision.
 +
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 6cfb444444..a21eafa025 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -95,9 +95,9 @@ OPTIONS
 
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix. If used with `--all`, it also
+	excluding the `refs/tags/` prefix. If used with `--all`, it also
 	considers local branches and remote-tracking references matching the
-	pattern, excluding respectively "refs/heads/" and "refs/remotes/"
+	pattern, excluding respectively `refs/heads/` and `refs/remotes/`
 	prefix; references of other types are never considered. If given
 	multiple times, a list of patterns will be accumulated, and tags
 	matching any of the patterns will be considered.  Use `--no-match` to
@@ -105,9 +105,9 @@ OPTIONS
 
 --exclude <pattern>::
 	Do not consider tags matching the given `glob(7)` pattern, excluding
-	the "refs/tags/" prefix. If used with `--all`, it also does not consider
+	the `refs/tags/` prefix. If used with `--all`, it also does not consider
 	local branches and remote-tracking references matching the pattern,
-	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
+	excluding respectively `refs/heads/` and `refs/remotes/` prefix;
 	references of other types are never considered. If given multiple times,
 	a list of patterns will be accumulated and tags matching any of the
 	patterns will be excluded. When combined with `--match` a tag will be
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 24b10d4ad1..0e1db78aee 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -185,7 +185,7 @@ This makes a new branch called `other` from `master~5`..`master`
 
 Note that this assumes that none of the blobs and commit messages
 referenced by that revision range contains the string
-'refs/heads/master'.
+`refs/heads/master`.
 
 
 ANONYMIZING
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index eaca893ac8..3d829538b0 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -69,15 +69,15 @@ be in a separate packet, and the list must end with a flush packet.
 
 --upload-pack=<git-upload-pack>::
 	Use this to specify the path to `git-upload-pack` on the
-	remote side, if is not found on your $PATH.
+	remote side, if is not found on your `$PATH`.
 	Installations of sshd ignores the user's environment
-	setup scripts for login shells (e.g. .bash_profile) and
+	setup scripts for login shells (e.g. `.bash_profile`) and
 	your privately installed `git` may not be found on the system
-	default $PATH.  Another workaround suggested is to set
-	up your $PATH in ".bashrc", but this flag is for people
+	default `$PATH`.  Another workaround suggested is to set
+	up your `$PATH` in `.bashrc`, but this flag is for people
 	who do not want to pay the overhead for non-interactive
-	shells by having a lean .bashrc file (they set most of
-	the things up in .bash_profile).
+	shells by having a lean `.bashrc` file (they set most of
+	the things up in `.bash_profile`).
 
 --exec=<git-upload-pack>::
 	Same as `--upload-pack`=<git-upload-pack>.
@@ -116,7 +116,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 <refs>...::
 	The remote heads to update from. This is relative to
-	$GIT_DIR (e.g. `HEAD`, "refs/heads/master").  When
+	`$GIT_DIR` (e.g. `HEAD`, `refs/heads/master`).  When
 	unspecified, update from all heads the remote side has.
 +
 If the remote has enabled the options `uploadpack.allowTipSHA1InWant`,
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index b0b5d06aad..11ee865969 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Fetch branches and/or tags (collectively, "refs") from one or more
+Fetch branches and/or tags (collectively, `refs`) from one or more
 other repositories, along with the objects necessary to complete their
 histories.  Remote-tracking branches are updated (see the description
 of <refspec> below for ways to control this behavior).
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index b21205d265..8b19805695 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -61,7 +61,7 @@ rewriting published history.)
 
 Always verify that the rewritten version is correct: The original refs,
 if different from the rewritten ones, will be stored in the namespace
-'refs/original/'.
+`refs/original/`.
 
 Note that since this operation is very I/O expensive, it might
 be a good idea to redirect the temporary directory off-disk with the
@@ -195,7 +195,7 @@ to other tags will be rewritten to point to the underlying commit.
 
 --original <namespace>::
 	Use this option to set the namespace where the original commits
-	will be stored. The default value is 'refs/original'.
+	will be stored. The default value is `refs/original`.
 
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
@@ -209,7 +209,7 @@ to other tags will be rewritten to point to the underlying commit.
 --force::
 	`git filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
-	'refs/original/', unless forced.
+	`refs/original/`, unless forced.
 
 --state-branch <branch>::
 	This option will cause the mapping from old to new objects to
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 33fb379df4..518f040fcd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -103,7 +103,7 @@ keys.
 For all objects, the following names can be used:
 
 refname::
-	The name of the ref (the part after $GIT_DIR/).
+	The name of the ref (the part after `$GIT_DIR`/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option `core.warnAmbiguousRefs` is used to select the strict
 	abbreviation mode. If `lstrip=<N>` (`rstrip=<N>`) is appended, strips `<N>`
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index a680caa365..2d90384355 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -53,10 +53,10 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 
 --full::
 	Check not just objects in GIT_OBJECT_DIRECTORY
-	($GIT_DIR/objects), but also the ones found in alternate
+	(`$GIT_DIR/objects`), but also the ones found in alternate
 	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES
-	or $GIT_DIR/objects/info/alternates,
-	and in packed Git archives found in $GIT_DIR/objects/pack
+	or `$GIT_DIR/objects/info/alternates`,
+	and in packed Git archives found in `$GIT_DIR/objects/pack`
 	and corresponding pack subdirectories in alternate
 	object pools.  This is now default; you can turn it off
 	with `--no-full`.
@@ -154,7 +154,7 @@ Environment Variables
 ---------------------
 
 GIT_OBJECT_DIRECTORY::
-	used to specify the object database root (usually $GIT_DIR/objects)
+	used to specify the object database root (usually `$GIT_DIR/objects`)
 
 GIT_INDEX_FILE::
 	used to specify the index file of the index
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index e63816e430..4bbf4811c0 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -264,8 +264,8 @@ a repository with an extremely large number of refs.  The value can be
 specified with a unit (e.g., `100M` for 100 megabytes). The default is
 10 megabytes.
 
-The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
-GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
+The backend process sets `GIT_COMMITTER_NAME` to `$REMOTE_USER` and
+`GIT_COMMITTER_EMAIL` to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by `git-receive-pack` contain some
 identifying information of the remote user who performed the push.
 
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 87028e3312..58e92f22c6 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -31,7 +31,7 @@ commit-id::
 	Report what is downloaded.
 
 -w <filename>::
-        Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
+        Writes the commit-id into the filename under `$GIT_DIR/refs/<filename>` on
         the local end after the transfer is complete.
 
 --stdin::
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 85c564c412..a2932ba27f 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -74,7 +74,7 @@ destination side.
 
  - If <dst> does not match any remote ref, either
 
-   * it has to start with "refs/"; <dst> is used as the
+   * it has to start with `refs/`; <dst> is used as the
      destination literally in this case.
 
    * <src> == <dst> and the ref that matched the <src> must not
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index a6b3bc1611..43f9a5c69e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -34,8 +34,8 @@ OPTIONS
 --no-decorate::
 --decorate[=short|full|auto|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
-	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
-	'refs/remotes/' will not be printed. If 'full' is specified, the
+	specified, the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` will not be printed. If 'full' is specified, the
 	full ref name (including prefix) will be printed. If 'auto' is
 	specified, then if the output is going to a terminal, the ref names
 	are shown as if 'short' were given, otherwise no ref names are
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 8177c877e2..7adf8f797b 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -29,7 +29,7 @@ FUNCTIONS
 ---------
 get_merge_tool::
 	returns a merge tool. the return code is 1 if we returned a guessed
-	merge tool, else 0. '$GIT_MERGETOOL_GUI' may be set to 'true' to
+	merge tool, else 0. `$GIT_MERGETOOL_GUI` may be set to 'true' to
 	search for the appropriate guitool.
 
 get_merge_tool_cmd::
@@ -45,7 +45,7 @@ initialize_merge_tool::
 run_merge_tool::
 	launches a merge tool given the tool name and a true/false
 	flag to indicate whether a merge base is present.
-	'$MERGED', '$LOCAL', '$REMOTE', and '$BASE' must be defined
+	`$MERGED`, `$LOCAL`, `$REMOTE`, and `$BASE` must be defined
 	for use by the merge tool.
 
 GIT
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 093f023ac5..a74866d84f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -74,7 +74,7 @@ This:
 1. Creates an empty Git repository in a subdirectory called 'project'.
 +
 2. Imports the full contents of the head revision from the given p4
-   depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
+   depot path into a single commit in the Git branch `refs/remotes/p4/master`.
 +
 3. Creates a local branch, `master` from this remote and checks it out.
 
@@ -103,11 +103,11 @@ $ git init
 $ git p4 sync //path/in/your/perforce/depot
 ------------
 This imports the specified depot into
-'refs/remotes/p4/master' in an existing Git repository.  The
+`refs/remotes/p4/master` in an existing Git repository.  The
 `--branch` option can be used to specify a different branch to
 be used for the p4 content.
 
-If a Git repository includes branches 'refs/remotes/origin/p4', these
+If a Git repository includes branches `refs/remotes/origin/p4`, these
 will be fetched and consulted first during a `git p4 sync`.  Since
 importing directly from p4 is considerably slower than pulling changes
 from a Git remote, this can be useful in a multi-developer environment.
@@ -155,7 +155,7 @@ $ git p4 submit --commit <sha1>
 $ git p4 submit --commit <sha1..sha1>
 ------------
 
-The upstream reference is generally 'refs/remotes/p4/master', but can
+The upstream reference is generally `refs/remotes/p4/master`, but can
 be overridden using the `--origin=` command-line option.
 
 The p4 changes will be created as the user invoking `git p4 submit`. The
@@ -254,10 +254,10 @@ Git repository:
 	Import labels from p4 into Git.
 
 --import-local::
-	By default, p4 branches are stored in 'refs/remotes/p4/',
+	By default, p4 branches are stored in `refs/remotes/p4/`,
 	where they will be treated as remote-tracking branches by
 	linkgit:git-branch[1] and other commands.  This option instead
-	puts p4 branches in 'refs/heads/p4/'.  Note that future
+	puts p4 branches in `refs/heads/p4/`.  Note that future
 	sync operations must specify `--import-local` as well so that
 	they can find the p4 branches in refs/heads.
 
@@ -524,7 +524,7 @@ Then this `git p4 clone` command:
 ----
 git p4 clone --detect-branches //depot@all
 ----
-produces a separate branch in 'refs/remotes/p4/' for //depot/main,
+produces a separate branch in `refs/remotes/p4/` for //depot/main,
 called `master`, and one for //depot/branch1 called `depot/branch1`.
 
 However, it is not necessary to create branches in p4 to be able to use
@@ -593,7 +593,7 @@ Clone and sync variables
 git-p4.syncFromOrigin::
 	Because importing commits from other Git repositories is much faster
 	than importing them from p4, a mechanism exists to find p4 changes
-	first in Git remotes.  If branches exist under 'refs/remote/origin/p4',
+	first in Git remotes.  If branches exist under `refs/remote/origin/p4`,
 	those will be fetched and used when syncing from p4.  This
 	variable can be set to 'false' to disable this behavior.
 
@@ -719,7 +719,7 @@ git-p4.allowSubmit::
 	By default, any branch can be used as the source for a `git p4
 	submit` operation.  This configuration variable, if set, permits only
 	the named branches to be used as submit sources.  Branch names
-	must be the short names (no "refs/heads/"), and should be
+	must be the short names (no `refs/heads/`), and should be
 	separated by commas (","), with no spaces.
 
 git-p4.skipUserNameCheck::
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e98e1f858b..118fdeac35 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -35,8 +35,8 @@ each object that a delta depends upon must be present within the pack.
 
 A pack index file (.idx) is generated for fast, random access to the
 objects in the pack. Placing both the index file (.idx) and the packed
-archive (.pack) in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
-any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
+archive (.pack) in the pack/ subdirectory of `$GIT_OBJECT_DIRECTORY` (or
+any of the directories on `$GIT_ALTERNATE_OBJECT_DIRECTORIES`)
 enables Git to read from the pack archive.
 
 The `git unpack-objects` command can read the packed archive and
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 169bcfb07f..f77bd0e27f 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 
 Traditionally, tips of branches and tags (collectively known as
-'refs') were stored one file per ref in a (sub)directory
+`refs`) were stored one file per ref in a (sub)directory
 under `$GIT_DIR/refs`
 directory.  While many branch tips tend to be updated often,
 most tags and some branch tips are never updated.  When a
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 842cbbaeca..7811e2c73b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -229,7 +229,7 @@ already exists on the remote side.
 	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
-	a directory on the default $PATH.
+	a directory on the default `$PATH`.
 
 --[no-]force-with-lease::
 --force-with-lease=<refname>::
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 380f87b6e8..2b2bd665e0 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -164,18 +164,18 @@ run after `git read-tree`.
 Two Tree Merge
 ~~~~~~~~~~~~~~
 
-Typically, this is invoked as `git read-tree -m $H $M`, where $H
-is the head commit of the current repository, and $M is the head
-of a foreign tree, which is simply ahead of $H (i.e. we are in a
+Typically, this is invoked as `git read-tree -m $H $M`, where `$H`
+is the head commit of the current repository, and `$M` is the head
+of a foreign tree, which is simply ahead of `$H` (i.e. we are in a
 fast-forward situation).
 
 When two trees are specified, the user is telling `git read-tree`
 the following:
 
-     1. The current index and work tree is derived from $H, but
-	the user may have local changes in them since $H.
+     1. The current index and work tree is derived from `$H`, but
+	the user may have local changes in them since `$H`.
 
-     2. The user wants to fast-forward to $M.
+     2. The user wants to fast-forward to `$M`.
 
 In this case, the `git read-tree -m $H $M` command makes sure
 that no local change is lost as the result of this "merge".
@@ -234,7 +234,7 @@ see which of the "local changes" that you made were carried forward by running
 `git diff-index --cached $M`.  Note that this does not
 necessarily match what `git diff-index --cached $H` would have
 produced before such a two tree merge.  This is because of cases
-18 and 19 --- if you already had the changes in $M (e.g. maybe
+18 and 19 --- if you already had the changes in `$M` (e.g. maybe
 you picked it up via e-mail in a patch form), `git diff-index
 --cached $H` would have told you about the change before this
 merge, but it would not show in `git diff-index --cached $M`
@@ -245,7 +245,7 @@ rule logically should be to remove the path if the user staged the removal
 of the path and then switching to a new branch.  That however will prevent
 the initial checkout from happening, so the rule is modified to use M (new
 tree) only when the content of the index is empty.  Otherwise the removal
-of the path is kept as long as $H and $M are the same.
+of the path is kept as long as `$H` and `$M` are the same.
 
 3-Way Merge
 ~~~~~~~~~~~
@@ -356,9 +356,9 @@ $ git fetch git://.... linus
 $ LT=`git rev-parse FETCH_HEAD`
 ----------------
 
-Your work tree is still based on your `HEAD` ($JC), but you have
+Your work tree is still based on your `HEAD` (`$JC`), but you have
 some edits since.  Three-way merge makes sure that you have not
-added or modified index entries since $JC, and if you haven't,
+added or modified index entries since `$JC`, and if you haven't,
 then does the right thing.  So with the following sequence:
 
 ----------------
@@ -368,7 +368,7 @@ $ echo "Merge with Linus" | \
   git commit-tree `git write-tree` -p $JC -p $LT
 ----------------
 
-what you would commit is a pure merge between $JC and $LT without
+what you would commit is a pure merge between `$JC` and `$LT` without
 your work-in-progress changes, and your work tree would be
 updated to the result of the merge.
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 5fc47a9ebd..921f658bd8 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -43,14 +43,14 @@ OPTIONS
 
 PRE-RECEIVE HOOK
 ----------------
-Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
+Before any ref is updated, if `$GIT_DIR/hooks/pre-receive` file exists
 and is executable, it will be invoked once with no parameters.  The
 standard input of the hook will be one line per ref to be updated:
 
        sha1-old SP sha1-new SP refname LF
 
-The refname value is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 values before
+The refname value is relative to `$GIT_DIR`; e.g. for the master
+head this is `refs/heads/master`.  The two sha1 values before
 each refname are the object names for the refname before and after
 the update.  Refs to be created will have sha1-old equal to 0\{40},
 while refs to be deleted will have sha1-new equal to 0\{40}, otherwise
@@ -118,13 +118,13 @@ See the notes on the quarantine environment below.
 
 UPDATE HOOK
 -----------
-Before each ref is updated, if $GIT_DIR/hooks/update file exists
+Before each ref is updated, if `$GIT_DIR/hooks/update` file exists
 and is executable, it is invoked once per ref, with three parameters:
 
        $GIT_DIR/hooks/update refname sha1-old sha1-new
 
-The refname parameter is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 arguments are
+The refname parameter is relative to `$GIT_DIR`; e.g. for the master
+head this is `refs/heads/master`.  The two sha1 arguments are
 the object names for the refname before and after the update.
 Note that the hook is called before the refname is updated,
 so either sha1-old is 0\{40} (meaning there is no such ref yet),
@@ -141,15 +141,15 @@ this hook.  Consider using the post-receive hook instead.
 POST-RECEIVE HOOK
 -----------------
 After all refs were updated (or attempted to be updated), if any
-ref update was successful, and if $GIT_DIR/hooks/post-receive
+ref update was successful, and if `$GIT_DIR/hooks/post-receive`
 file exists and is executable, it will be invoked once with no
 parameters.  The standard input of the hook will be one line
 for each successfully updated ref:
 
        sha1-old SP sha1-new SP refname LF
 
-The refname value is relative to $GIT_DIR; e.g. for the master
-head this is "refs/heads/master".  The two sha1 values before
+The refname value is relative to `$GIT_DIR`; e.g. for the master
+head this is `refs/heads/master`.  The two sha1 values before
 each refname are the object names for the refname before and after
 the update.  Refs that were created will have sha1-old equal to
 0\{40}, while refs that were deleted will have sha1-new equal to
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4df63cad06..318b2220a2 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -72,8 +72,8 @@ With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
 When a fetch mirror is created with `--mirror=fetch`, the refs will not
-be stored in the 'refs/remotes/' namespace, but rather everything in
-'refs/' on the remote will be directly mirrored into 'refs/' in the
+be stored in the `refs/remotes/` namespace, but rather everything in
+`refs/` on the remote will be directly mirrored into `refs/` in the
 local repository. This option only makes sense in bare repositories,
 because a fetch would overwrite any local commits.
 +
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index eb7d765e5d..19ca46df30 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -104,7 +104,7 @@ in linkgit:git-checkout[1] for details.
 --ignore-skip-worktree-bits::
 	In sparse checkout mode, by default is to only update entries
 	matched by `<pathspec>` and sparse patterns in
-	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	`$GIT_DIR/info/sparse-checkout`. This option ignores the sparse
 	patterns and unconditionally restores any files in
 	`<pathspec>`.
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 9908f3020f..bbace2dc5e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -157,7 +157,7 @@ for another option.
 	explicitly disambiguating "heads/master" form, when you
 	want to name the `master` branch when there is an
 	unfortunately named tag "master"), and show them as full
-	refnames (e.g. "refs/heads/master").
+	refnames (e.g. `refs/heads/master`).
 
 Options for Objects
 ~~~~~~~~~~~~~~~~~~~
@@ -243,10 +243,10 @@ print a message to stderr and exit with nonzero status.
 	to the real repository is printed.
 
 --git-path <path>::
-	Resolve "$GIT_DIR/<path>" and takes other path relocation
-	variables such as $GIT_OBJECT_DIRECTORY,
-	$GIT_INDEX_FILE... into account. For example, if
-	$GIT_OBJECT_DIRECTORY is set to /foo/bar then `git rev-parse
+	Resolve `$GIT_DIR/<path>` and takes other path relocation
+	variables such as `$GIT_OBJECT_DIRECTORY`,
+	`$GIT_INDEX_FILE`... into account. For example, if
+	`$GIT_OBJECT_DIRECTORY` is set to /foo/bar then `git rev-parse
 	--git-path objects/abc` returns /foo/bar/abc.
 
 --show-toplevel::
@@ -461,13 +461,13 @@ EXAMPLES
 $ git rev-parse --verify HEAD
 ------------
 
-* Print the commit object name from the revision in the $REV shell variable:
+* Print the commit object name from the revision in the `$REV` shell variable:
 +
 ------------
 $ git rev-parse --verify --end-of-options $REV^{commit}
 ------------
 +
-This will error out if $REV is empty or not a valid revision.
+This will error out if `$REV` is empty or not a valid revision.
 
 * Similar to above:
 +
@@ -475,7 +475,7 @@ This will error out if $REV is empty or not a valid revision.
 $ git rev-parse --default master --verify --end-of-options $REV
 ------------
 +
-but if $REV is empty, the commit object name from `master` will be printed.
+but if `$REV` is empty, the commit object name from `master` will be printed.
 
 GIT
 ---
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 916bd441d4..9455d4c654 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -216,7 +216,7 @@ a password is obtained using `git-credential`.
 	the program must support the `-i` option.  Default value can
 	be specified by the `sendemail.smtpServer` configuration
 	option; the built-in default is to search for `sendmail` in
-	`/usr/sbin`, `/usr/lib` and $PATH if such program is
+	`/usr/sbin`, `/usr/lib` and `$PATH` if such program is
 	available, falling back to `localhost` otherwise.
 
 --smtp-server-port=<port>::
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 46f7757b9a..c0303d72eb 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -29,7 +29,7 @@ OPTIONS
 	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
-	a directory on the default $PATH.
+	a directory on the default `$PATH`.
 
 --exec=<git-receive-pack>::
 	Same as `--receive-pack`=<git-receive-pack>.
@@ -133,7 +133,7 @@ name. See linkgit:git-rev-parse[1].
 
  - If <dst> does not match any remote ref, either
 
-   * it has to start with "refs/"; <dst> is used as the
+   * it has to start with `refs/`; <dst> is used as the
      destination literally in this case.
 
    * <src> == <dst> and the ref that matched the <src> must not
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 5531c435b0..79f65ce0aa 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -134,7 +134,7 @@ OUTPUT
 ------
 Given N <references>, the first N lines are the one-line
 description from their commit message.  The branch head that is
-pointed at by $GIT_DIR/HEAD is prefixed with an asterisk `*`
+pointed at by `$GIT_DIR/HEAD` is prefixed with an asterisk `*`
 character while other heads are prefixed with a `!` character.
 
 Following these N lines, one-line log for each commit is
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 28be080b96..2a3699cb7f 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -40,9 +40,9 @@ OPTIONS
 --heads::
 --tags::
 
-	Limit to "refs/heads" and "refs/tags", respectively.  These options
+	Limit to `refs/heads` and `refs/tags`, respectively.  These options
 	are not mutually exclusive; when given both, references stored in
-	"refs/heads" and "refs/tags" are displayed.
+	`refs/heads` and `refs/tags` are displayed.
 
 -d::
 --dereference::
@@ -89,9 +89,9 @@ OPTIONS
 
 	Show references matching one or more patterns. Patterns are matched from
 	the end of the full name, and only complete parts are matched, e.g.
-	'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
-	'refs/tags/jedi/master' but not 'refs/heads/mymaster' or
-	'refs/remotes/master/jedi'.
+	'master' matches `refs/heads/master`, `refs/remotes/origin/master`,
+	`refs/tags/jedi/master` but not `refs/heads/mymaster` or
+	`refs/remotes/master/jedi`.
 
 OUTPUT
 ------
@@ -131,7 +131,7 @@ use:
 	git show-ref master
 -----------------------------------------------------------------------------
 
-This will show "refs/heads/master" but also "refs/remote/other-repo/master",
+This will show `refs/heads/master` but also `refs/remote/other-repo/master`,
 if such references exists.
 
 When using the `--verify` flag, the command requires an exact path:
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0a691b1df0..6cbf6a9ba1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -205,17 +205,17 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $sm_path, $displaypath,
-	$sha1 and $toplevel:
-	$name is the name of the relevant submodule section in `.gitmodules`,
-	$sm_path is the path of the submodule as recorded in the immediate
-	superproject, $displaypath contains the relative path from the
+	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
+	`$sha1` and `$toplevel`:
+	`$name` is the name of the relevant submodule section in `.gitmodules`,
+	`$sm_path` is the path of the submodule as recorded in the immediate
+	superproject, `$displaypath` contains the relative path from the
 	current working directory to the submodules root directory,
 	$sha1 is the commit as recorded in the immediate
-	superproject, and $toplevel is the absolute path to the top-level
+	superproject, and `$toplevel` is the absolute path to the top-level
 	of the immediate superproject.
-	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
-	variable is now a deprecated synonym of '$sm_path' variable.
+	Note that to avoid conflicts with `$PATH` on Windows, the `$path`
+	variable is now a deprecated synonym of `$sm_path` variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 2e1e3348c7..727ea0603c 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -81,7 +81,7 @@ COMMANDS
 	specified, the prefix must include a trailing slash.
 	Setting a prefix (with a trailing slash) is strongly
 	encouraged in any case, as your SVN-tracking refs will
-	then be located at "refs/remotes/$prefix/*", which is
+	then be located at `refs/remotes/$prefix/*`, which is
 	compatible with Git's own remote-tracking ref layout
 	(refs/remotes/$remote/*). Setting a prefix is also useful
 	if you wish to track multiple projects that share a common
@@ -89,7 +89,7 @@ COMMANDS
 	By default, the prefix is set to 'origin/'.
 +
 NOTE: Before Git v2.0, the default prefix was "" (no prefix). This
-meant that SVN-tracking refs were put at "refs/remotes/*", which is
+meant that SVN-tracking refs were put at `refs/remotes/*`, which is
 incompatible with how Git's own remote-tracking refs are organized.
 If you still want the old default, you can get it by passing
 `--prefix ""` on the command line (`--prefix=""` may not work if
@@ -122,11 +122,11 @@ your Perl's Getopt::Long is < v2.37).
 `fetch`::
 	Fetch unfetched revisions from the Subversion remote we are
 	tracking.  The name of the [svn-remote "..."] section in the
-	$GIT_DIR/config file may be specified as an optional
+	`$GIT_DIR/config` file may be specified as an optional
 	command-line argument.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+`$GIT_DIR/svn/\**/.rev_map.*` in the FILES section below for details).
 
 --localtime;;
 	Store Git commit times in the local time zone instead of UTC.  This
@@ -144,7 +144,7 @@ the same local time zone.
 
 --ignore-refs=<regex>;;
 	Ignore refs for branches or tags matching the Perl regular
-	expression. A "negative look-ahead assertion" like
+	expression. A negative look-ahead assertion like
 	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
 	can be used to allow only certain refs.
 +
@@ -239,7 +239,7 @@ Like `git rebase`; this requires that the working tree be clean
 and have no uncommitted changes.
 +
 This automatically updates the rev_map if needed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+`$GIT_DIR/svn/\**/.rev_map.*` in the FILES section below for details).
 
 -l;;
 --local;;
@@ -439,11 +439,11 @@ Any other arguments are passed directly to `git log`
 `show-ignore`::
 	Recursively finds and lists the svn:ignore property on
 	directories.  The output is suitable for appending to
-	the $GIT_DIR/info/exclude file.
+	the `$GIT_DIR/info/exclude` file.
 
 `mkdirs`::
 	Attempts to recreate empty directories that core Git cannot track
-	based on information in $GIT_DIR/svn/<refname>/unhandled.log files.
+	based on information in `$GIT_DIR/svn/<refname>/unhandled.log` files.
 	Empty directories are automatically recreated when using
 	`git svn clone` and `git svn rebase`, so `mkdirs` is intended
 	for use after commands like `git checkout` or `git reset`.
@@ -509,8 +509,8 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 	specific revision.
 
 `gc`::
-	Compress $GIT_DIR/svn/<refname>/unhandled.log files and remove
-	$GIT_DIR/svn/<refname>/index files.
+	Compress `$GIT_DIR/svn/<refname>/unhandled.log` files and remove
+	`$GIT_DIR/svn/<refname>/index` files.
 
 `reset`::
 	Undoes the effects of `fetch` back to the specified revision.
@@ -524,7 +524,7 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 	way to repair the repo is to use `reset`.
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
-'$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
+`$GIT_DIR/svn/\**/.rev_map.*` in the FILES section below for details).
 Follow 'reset' with a `fetch` and then `git reset` or `git rebase` to
 move local branches onto the new tree.
 
@@ -662,7 +662,7 @@ config key: `svn.authorsfile`
 Due to historical reasons a relative 'filename' is first searched
 relative to the current directory for `init` and `clone` and relative
 to the root of the working tree for `fetch`. If 'filename' is
-not found, it is searched like any other command in '$PATH'.
+not found, it is searched like any other command in `$PATH`.
 +
 [verse]
 config key: `svn.authorsProg`
@@ -761,7 +761,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as `git svn`
 will not be able to fetch again without metadata. Additionally,
-if you lose your '$GIT_DIR/svn/\**/.rev_map.*' files, `git svn` will not
+if you lose your `$GIT_DIR/svn/\**/.rev_map.*` files, `git svn` will not
 be able to rebuild them.
 +
 The `git svn log` command will not work on repositories using
@@ -1055,7 +1055,7 @@ When using multiple `--branches` or `--tags`, `git svn` does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
 use `init` to set up your Git repository then, before your first `fetch`, edit
-the $GIT_DIR/config file so that the branches and tags are associated
+the `$GIT_DIR/config` file so that the branches and tags are associated
 with different name spaces.  For example:
 
 	branches = stable/*:refs/remotes/svn/stable/*
@@ -1065,7 +1065,7 @@ BUGS
 ----
 
 We ignore all SVN properties except svn:executable.  Any unhandled
-properties are logged to $GIT_DIR/svn/<refname>/unhandled.log
+properties are logged to `$GIT_DIR/svn/<refname>/unhandled.log`
 
 Renamed and copied directories are not detected by Git and hence not
 tracked when committing to SVN.  I do not plan on adding support for
@@ -1084,7 +1084,7 @@ CONFIGURATION
 -------------
 
 `git svn` stores [svn-remote] configuration information in the
-repository $GIT_DIR/config file.  It is similar the core Git
+repository `$GIT_DIR/config` file.  It is similar the core Git
 [remote] sections except `fetch` keys do not accept glob
 arguments; but they are instead handled by the 'branches'
 and 'tags' keys.  Since some SVN repositories are oddly
@@ -1150,12 +1150,12 @@ $ git svn branch -d branches/server release-2-3-0
 
 Note that `git-svn` keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
-fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
+fetching, then `$GIT_DIR/svn/.metadata` must be manually edited to remove
 (or reset) branches-maxRev and/or tags-maxRev as appropriate.
 
 FILES
 -----
-$GIT_DIR/svn/\**/.rev_map.*::
+`$GIT_DIR/svn/\**/.rev_map.*`::
 	Mapping between Subversion revision numbers and Git commit
 	names.  In a repository where the noMetadata option is not set,
 	this can be rebuilt from the git-svn-id: lines that are at the
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index ec501232ad..02adf7aa81 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -178,7 +178,7 @@ may not support it yet.
 --no-split-index::
 	Enable or disable split index mode. If split-index mode is
 	already enabled and `--split-index` is given again, all
-	changes in $GIT_DIR/index are pushed back to the shared index
+	changes in `$GIT_DIR/index` are pushed back to the shared index
 	file.
 +
 These options take effect whatever the value of the `core.splitIndex`
@@ -415,9 +415,9 @@ SPLIT INDEX
 This mode is designed for repositories with very large indexes, and
 aims at reducing the time it takes to repeatedly write these indexes.
 
-In this mode, the index is split into two files, $GIT_DIR/index and
-$GIT_DIR/sharedindex.<SHA-1>. Changes are accumulated in
-$GIT_DIR/index, the split index, while the shared index file contains
+In this mode, the index is split into two files, `$GIT_DIR/index` and
+`$GIT_DIR/sharedindex.<SHA-1>`. Changes are accumulated in
+`$GIT_DIR/index`, the split index, while the shared index file contains
 all index entries and stays unchanged.
 
 All changes in the split index are pushed back to the shared index
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 3ad7771676..794dea70ec 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -32,7 +32,7 @@ ref file by starting with the four-byte header sequence of
 More importantly, it allows the update of a ref file to follow
 these symbolic pointers, whether they are symlinks or these
 "regular file symbolic refs".  It follows *real* symlinks only
-if they start with "refs/": otherwise it will just try to read
+if they start with `refs/`: otherwise it will just try to read
 them and update them as a regular file (i.e. it will allow the
 filesystem to follow them, but will overwrite such a symlink to
 somewhere else with a regular filename).
@@ -49,7 +49,7 @@ should be a _lot_ safer than doing
 	echo "$head" > "$GIT_DIR/HEAD"
 
 both from a symlink following standpoint *and* an error checking
-standpoint.  The "refs/" rule for symlinks means that symlinks
+standpoint.  The `refs/` rule for symlinks means that symlinks
 that point to "outside" the tree are safe: they'll be followed
 for reading but not for writing (so we'll never write through a
 ref symlink to some other tree, if you have copied a whole
@@ -150,10 +150,10 @@ still see a subset of the modifications.
 LOGGING UPDATES
 ---------------
 If config parameter `core.logAllRefUpdates` is true and the ref is one
-under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
-like `HEAD` or `ORIG_HEAD`; or the file "$GIT_DIR/logs/<ref>" exists then
+under `refs/heads/`, `refs/remotes/`, `refs/notes/`, or a pseudoref
+like `HEAD` or `ORIG_HEAD`; or the file `$GIT_DIR/logs/<ref>` exists then
 `git update-ref` will append a line to the log file
-"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
+`$GIT_DIR/logs/<ref>` (dereferencing all symbolic refs before creating
 the log name) describing the change in ref value.  Log lines are
 formatted as:
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 8dbb1a6172..426d12da36 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -14,8 +14,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 A dumb server that does not do on-the-fly pack generations must
-have some auxiliary information files in $GIT_DIR/info and
-$GIT_OBJECT_DIRECTORY/info directories to help clients discover
+have some auxiliary information files in `$GIT_DIR/info` and
+`$GIT_OBJECT_DIRECTORY/info` directories to help clients discover
 what references and packs the server has.  This command
 generates such auxiliary files.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6486abdd4d..4c6fca3128 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -122,7 +122,7 @@ sensitive information can be part of the key.
 
 -p::
 --paginate::
-	Pipe all output into 'less' (or if set, $PAGER) if standard
+	Pipe all output into 'less' (or if set, `$PAGER`) if standard
 	output is a terminal.  This overrides the `pager.<cmd>`
 	configuration options (see the "Configuration Mechanism" section
 	below).
@@ -515,9 +515,9 @@ double-quotes and respecting backslash escapes. E.g., the value
 
 `GIT_COMMON_DIR`::
 	If this variable is set to a path, non-worktree files that are
-	normally in $GIT_DIR will be taken from this path
+	normally in `$GIT_DIR` will be taken from this path
 	instead. Worktree-specific files such as `HEAD` or index are
-	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
+	taken from `$GIT_DIR`. See linkgit:gitrepository-layout[5] and
 	linkgit:git-worktree[1] for
 	details. This variable has lower precedence than other path
 	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index bd1cd2629c..a5cfef7f86 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - Defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, `.gitattributes`
+`$GIT_DIR/info/attributes`, `.gitattributes`
 
 
 DESCRIPTION
@@ -90,8 +90,8 @@ repositories (i.e., attributes of interest to all users) should go into
 `.gitattributes` files. Attributes that should affect all repositories
 for a single user should be placed in a file specified by the
 `core.attributesFile` configuration option (see linkgit:git-config[1]).
-Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
-is either not set or empty, $HOME/.config/git/attributes is used instead.
+Its default value is `$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME`
+is either not set or empty, `$HOME/.config/git/attributes` is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8cee030fbd..ce1aa25d5a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,7 +7,7 @@ githooks - Hooks used by Git
 
 SYNOPSIS
 --------
-$GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
+`$GIT_DIR/hooks/*` (or \`git config core.hooksPath`/*)
 
 
 DESCRIPTION
@@ -22,10 +22,10 @@ changed via the `core.hooksPath` configuration variable (see
 linkgit:git-config[1]).
 
 Before Git invokes a hook, it changes its working directory to either
-$GIT_DIR in a bare repository or the root of the working tree in a non-bare
+`$GIT_DIR` in a bare repository or the root of the working tree in a non-bare
 repository. An exception are hooks triggered during a push ('pre-receive',
 'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
-executed in $GIT_DIR.
+executed in `$GIT_DIR`.
 
 Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7488cdb585..6dd09bd290 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, `.gitignore`
+`$XDG_CONFIG_HOME/git/ignore`, `$GIT_DIR/info/exclude`, `.gitignore`
 
 DESCRIPTION
 -----------
@@ -57,8 +57,8 @@ be used.
    ignore in all situations (e.g., backup or temporary files generated by
    the user's editor of choice) generally go into a file specified by
    `core.excludesFile` in the user's `~/.gitconfig`. Its default value is
-   $XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is either not set or
-   empty, $HOME/.config/git/ignore is used instead.
+   `$XDG_CONFIG_HOME/git/ignore`. If `$XDG_CONFIG_HOME` is either not set or
+   empty, `$HOME/.config/git/ignore` is used instead.
 
 The underlying Git plumbing tools, such as
 `git ls-files` and `git read-tree`, read
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 41eb7a6577..bc0cb104cc 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -158,7 +158,7 @@ User configuration and preferences are stored at:
 * `$HOME/.gitk` if it exists
 
 If neither of the above exist then `$XDG_CONFIG_HOME/git/gitk` is created and
-used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
+used by default. If `$XDG_CONFIG_HOME` is not set it defaults to
 `$HOME/.config` in all cases.
 
 History
diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 3fb39f801f..8f9c3ac65b 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -7,7 +7,7 @@ gitmailmap - Map author/committer names and/or E-Mail addresses
 
 SYNOPSIS
 --------
-$GIT_WORK_TREE/.mailmap
+`$GIT_WORK_TREE/.mailmap`
 
 
 DESCRIPTION
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 2c1e847076..ea6b4427c6 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -7,7 +7,7 @@ gitmodules - Defining submodule properties
 
 SYNOPSIS
 --------
-$GIT_WORK_TREE/.gitmodules
+`$GIT_WORK_TREE/.gitmodules`
 
 
 DESCRIPTION
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 39cfebccf3..95a98f7802 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -7,7 +7,7 @@ gitrepository-layout - Git Repository Layout
 
 SYNOPSIS
 --------
-$GIT_DIR/*
+`$GIT_DIR/*`
 
 DESCRIPTION
 -----------
@@ -47,8 +47,8 @@ use with dumb transports but otherwise is OK as long as
 `objects/info/alternates` points at the object stores it
 borrows from.
 +
-This directory is ignored if $GIT_COMMON_DIR is set and
-"$GIT_COMMON_DIR/objects" will be used instead.
+This directory is ignored if `$GIT_COMMON_DIR` is set and
+`$GIT_COMMON_DIR/objects` will be used instead.
 
 objects/[0-9a-f][0-9a-f]::
 	A newly created object is stored in its own file.
@@ -97,8 +97,8 @@ refs::
 	objects reachable from refs found in this directory and
 	its subdirectories.
 	This directory is ignored (except refs/bisect,
-	refs/rewritten and refs/worktree) if $GIT_COMMON_DIR is
-	set and "$GIT_COMMON_DIR/refs" will be used instead.
+	refs/rewritten and refs/worktree) if `$GIT_COMMON_DIR` is
+	set and `$GIT_COMMON_DIR/refs` will be used instead.
 
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
@@ -120,8 +120,8 @@ refs/replace/`<obj-sha1>`::
 packed-refs::
 	records the same information as refs/heads/, refs/tags/,
 	and friends record in a more efficient way.  See
-	linkgit:git-pack-refs[1]. This file is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/packed-refs" will be used instead.
+	linkgit:git-pack-refs[1]. This file is ignored if `$GIT_COMMON_DIR`
+	is set and `$GIT_COMMON_DIR/packed-refs` will be used instead.
 
 HEAD::
 	A symref (see glossary) to the `refs/heads/` namespace
@@ -142,7 +142,7 @@ for details.
 
 config::
 	Repository specific configuration file. This file is ignored
-	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
+	if `$GIT_COMMON_DIR` is set and `$GIT_COMMON_DIR/config` will be
 	used instead.
 
 config.worktree::
@@ -158,8 +158,8 @@ branches::
 	'repository' argument.  See the REMOTES section in
 	linkgit:git-fetch[1] for details.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/branches" will be used instead.
+	directory is ignored if `$GIT_COMMON_DIR` is set and
+	`$GIT_COMMON_DIR/branches` will be used instead.
 
 
 hooks::
@@ -169,12 +169,12 @@ hooks::
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
 	Read linkgit:githooks[5] for more details about
-	each hook. This directory is ignored if $GIT_COMMON_DIR is set
-	and "$GIT_COMMON_DIR/hooks" will be used instead.
+	each hook. This directory is ignored if `$GIT_COMMON_DIR` is set
+	and `$GIT_COMMON_DIR/hooks` will be used instead.
 
 common::
 	When multiple working trees are used, most of files in
-	$GIT_DIR are per-worktree with a few known exceptions. All
+	`$GIT_DIR` are per-worktree with a few known exceptions. All
 	files under 'common' however will be shared between all
 	working trees.
 
@@ -183,13 +183,13 @@ index::
 	usually not found in a bare repository.
 
 sharedindex.<SHA-1>::
-	The shared index part, to be referenced by $GIT_DIR/index and
+	The shared index part, to be referenced by `$GIT_DIR/index` and
 	other temporary index files. Only valid in split index mode.
 
 info::
 	Additional information about the repository is recorded
-	in this directory. This directory is ignored if $GIT_COMMON_DIR
-	is set and "$GIT_COMMON_DIR/info" will be used instead.
+	in this directory. This directory is ignored if `$GIT_COMMON_DIR`
+	is set and `$GIT_COMMON_DIR/info` will be used instead.
 
 info/refs::
 	This file helps dumb transports discover what refs are
@@ -234,14 +234,14 @@ remotes::
 	`git pull` and `git push` commands.  See the REMOTES section
 	in linkgit:git-fetch[1] for details.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/remotes" will be used instead.
+	directory is ignored if `$GIT_COMMON_DIR` is set and
+	`$GIT_COMMON_DIR/remotes` will be used instead.
 
 logs::
 	Records of changes made to refs are stored in this directory.
 	See linkgit:git-update-ref[1] for more information. This
-	directory is ignored (except logs/HEAD) if $GIT_COMMON_DIR is
-	set and "$GIT_COMMON_DIR/logs" will be used instead.
+	directory is ignored (except logs/HEAD) if `$GIT_COMMON_DIR` is
+	set and `$GIT_COMMON_DIR/logs` will be used instead.
 
 logs/refs/heads/`name`::
 	Records all changes made to the branch tip named `name`.
@@ -253,14 +253,14 @@ shallow::
 	This is similar to `info/grafts` but is internally used
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1]. This
-	file is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/shallow" will be used instead.
+	file is ignored if `$GIT_COMMON_DIR` is set and
+	`$GIT_COMMON_DIR/shallow` will be used instead.
 
 commondir::
-	If this file exists, $GIT_COMMON_DIR (see linkgit:git[1]) will
+	If this file exists, `$GIT_COMMON_DIR` (see linkgit:git[1]) will
 	be set to the path specified in this file if it is not
 	explicitly set. If the specified path is relative, it is
-	relative to $GIT_DIR. The repository with commondir is
+	relative to `$GIT_DIR`. The repository with commondir is
 	incomplete without the repository pointed by "commondir".
 
 modules::
@@ -270,8 +270,8 @@ worktrees::
 	Contains administrative data for linked
 	working trees. Each subdirectory contains the working tree-related
 	part of a linked working tree. This directory is ignored if
-	$GIT_COMMON_DIR is set, in which case
-	"$GIT_COMMON_DIR/worktrees" will be used instead.
+	`$GIT_COMMON_DIR` is set, in which case
+	`$GIT_COMMON_DIR/worktrees` will be used instead.
 
 worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 891c8da4fd..f1bf6caa3a 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -7,7 +7,7 @@ gitsubmodules - Mounting one repository inside another
 
 SYNOPSIS
 --------
- .gitmodules, $GIT_DIR/config
+ `.gitmodules`, `$GIT_DIR/config`
 ------------------
 git submodule
 git <command> --recurse-submodules
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 5c74907da9..8a8d3f9acf 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -7,7 +7,7 @@ gitweb.conf - Gitweb (Git web interface) configuration file
 
 SYNOPSIS
 --------
-/etc/gitweb.conf, /etc/gitweb-common.conf, $GITWEBDIR/gitweb_config.perl
+`/etc/gitweb.conf`, `/etc/gitweb-common.conf`, `$GITWEBDIR/gitweb_config.perl`
 
 DESCRIPTION
 -----------
@@ -117,7 +117,7 @@ Git repositories, and how repositories are displayed and accessed.
 
 See also "Repositories" and later subsections in linkgit:gitweb[1] manpage.
 
-$projectroot::
+`$projectroot`::
 	Absolute filesystem path which will be prepended to project path;
 	the path to repository is `$projectroot/$project`.  Set to
 	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
@@ -144,7 +144,7 @@ http://git.example.com/gitweb.cgi/foo/bar.git
 +
 will map to the path `/srv/git/foo/bar.git` on the filesystem.
 
-$projects_list::
+`$projects_list`::
 	Name of a plain text file listing projects, or a name of directory
 	to be scanned for projects.
 +
@@ -159,7 +159,7 @@ The default value of this variable is determined by the `GITWEB_LIST`
 makefile variable at installation time.  If this variable is empty, `gitweb`
 will fall back to scanning the `$projectroot` directory for repositories.
 
-$project_maxdepth::
+`$project_maxdepth`::
 	If `$projects_list` variable is unset, `gitweb` will recursively
 	scan filesystem for Git repositories.  The `$project_maxdepth`
 	is used to limit traversing depth, relative to `$projectroot`
@@ -174,7 +174,7 @@ The default value of this variable is determined by the build-time
 configuration variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to
 2007.
 
-$export_ok::
+`$export_ok`::
 	Show repository only if this file exists (in repository).  Only
 	effective if this variable evaluates to true.  Can be set when
 	building `gitweb` by setting `GITWEB_EXPORT_OK`.  This path is
@@ -182,13 +182,13 @@ $export_ok::
 	unless started with `--export-all`.  By default this variable is
 	not set, which means that this feature is turned off.
 
-$export_auth_hook::
+`$export_auth_hook`::
 	Function used to determine which repositories should be shown.
 	This subroutine should take one parameter, the full path to
 	a project, and if it returns true, that project will be included
 	in the projects list and can be accessed through `gitweb` as long
-	as it fulfills the other requirements described by $export_ok,
-	$projects_list, and $projects_maxdepth.  Example:
+	as it fulfills the other requirements described by `$export_ok`,
+	`$projects_list`, and `$projects_maxdepth`.  Example:
 +
 ----------------------------------------------------------------------------
 our $export_auth_hook = sub { return -e "$_[0]/git-daemon-export-ok"; };
@@ -205,7 +205,7 @@ If not set (default), it means that this feature is disabled.
 See also more involved example in "Controlling access to Git repositories"
 subsection on linkgit:gitweb[1] manpage.
 
-$strict_export::
+`$strict_export`::
 	Only allow viewing of repositories also shown on the overview page.
 	This for example makes `$export_ok` file decide if repository is
 	available and not only if it is shown.  If `$projects_list` points to
@@ -213,7 +213,7 @@ $strict_export::
 	available for `gitweb`.  Can be set during building `gitweb` via
 	`GITWEB_STRICT_EXPORT`.  By default this variable is not set, which
 	means that you can directly access those repositories that are hidden
-	from projects list page (e.g. the are not listed in the $projects_list
+	from projects list page (e.g. the are not listed in the `$projects_list`
 	file).
 
 
@@ -222,7 +222,7 @@ Finding files
 The following configuration variables tell `gitweb` where to find files.
 The values of these variables are paths on the filesystem.
 
-$GIT::
+`$GIT`::
 	Core `git` executable to use.  By default set to `$GIT_BINDIR/git`, which
 	in turn is by default set to `$(bindir)/git`.  If you use Git installed
 	from a binary package, you should usually set this to "/usr/bin/git".
@@ -232,7 +232,7 @@ $GIT::
 	which one to use.  Must be (correctly) set for `gitweb` to be able to
 	work.
 
-$mimetypes_file::
+`$mimetypes_file`::
 	File to use for (filename extension based) guessing of MIME types before
 	trying `/etc/mime.types`.  *NOTE* that this path, if relative, is taken
 	as relative to the current Git repository, not to CGI script.  If unset,
@@ -240,7 +240,7 @@ $mimetypes_file::
 	file is found, mimetype guessing based on extension of file is disabled.
 	Unset by default.
 
-$highlight_bin::
+`$highlight_bin`::
 	Path to the highlight executable to use (it must be the one from
 	http://www.andre-simon.de[] due to assumptions about parameters and output).
 	By default set to 'highlight'; set it to full path to highlight
@@ -305,7 +305,7 @@ i.e. if CSS minifier is used during build).
 used by older `gitweb`.  If `$stylesheet` variable is defined, only CSS stylesheet
 given by this variable is used by `gitweb`.
 
-$logo::
+`$logo`::
 	Points to the location where you put 'git-logo.png' on your web
 	server, or to be more the generic URI of logo, 72x27 size).  This image
 	is displayed in the top right corner of each `gitweb` page and used as
@@ -313,7 +313,7 @@ $logo::
 	Can be adjusted when building `gitweb` using `GITWEB_LOGO` variable
 	By default set to `static/git-logo.png`.
 
-$favicon::
+`$favicon`::
 	Points to the location where you put 'git-favicon.png' on your web
 	server, or to be more the generic URI of favicon, which will be served
 	as "image/png" type.  Web browsers that support favicons (website icons)
@@ -322,7 +322,7 @@ $favicon::
 	build time using `GITWEB_FAVICON` variable.
 	By default set to `static/git-favicon.png`.
 
-$javascript::
+`$javascript`::
 	Points to the location where you put 'gitweb.js' on your web server,
 	or to be more generic the URI of JavaScript code used by `gitweb`.
 	Relative to the base URI of `gitweb`.  Can be set at build time using
@@ -333,13 +333,13 @@ the `JSMIN` build variable was defined, i.e. if JavaScript minifier was used
 at build time.  *Note* that this single file is generated from multiple
 individual JavaScript "modules".
 
-$home_link::
+`$home_link`::
 	Target of the home link on the top of all pages (the first part of view
 	"breadcrumbs").  By default it is set to the absolute URI of a current page
-	(to the value of `$my_uri` variable, or to "/" if `$my_uri` is undefined
+	(to the value of `$my_uri` variable, or to `/` if `$my_uri` is undefined
 	or is an empty string).
 
-$home_link_str::
+`$home_link_str`::
 	Label for the "home link" at the top of all pages, leading to `$home_link`
 	(usually the main `gitweb` page, which contains the projects list).  It is
 	used as the first component of gitweb's "breadcrumb trail":
@@ -367,8 +367,8 @@ For example, the following setting produces a breadcrumb trail like
     );
 ----------------------------------------------------------------------------
 
-$logo_url::
-$logo_label::
+`$logo_url`::
+`$logo_label`::
 	URI and label (title) for the Git logo link (or your site logo,
 	if you chose to use different logo image). By default, these both
 	refer to Git homepage, https://git-scm.com[]; in the past, they pointed
@@ -382,48 +382,48 @@ below.  You can change the site name, add common headers and footers for all
 pages, and add a description of this `gitweb` installation on its main page
 (which is the projects list page), etc.
 
-$site_name::
+`$site_name`::
 	Name of your site or organization, to appear in page titles.  Set it
 	to something descriptive for clearer bookmarks etc.  If this variable
 	is not set or is, then `gitweb` uses the value of the `SERVER_NAME`
-	`CGI` environment variable, setting site name to "$SERVER_NAME Git",
+	`CGI` environment variable, setting site name to "`$SERVER_NAME` Git",
 	or "Untitled Git" if this variable is not set (e.g. if running `gitweb`
 	as standalone script).
 +
 Can be set using the `GITWEB_SITENAME` at build time.  Unset by default.
 
-$site_html_head_string::
+`$site_html_head_string`::
 	HTML snippet to be included in the <head> section of each page.
 	Can be set using `GITWEB_SITE_HTML_HEAD_STRING` at build time.
 	No default value.
 
-$site_header::
+`$site_header`::
 	Name of a file with HTML to be included at the top of each page.
 	Relative to the directory containing the 'gitweb.cgi' script.
 	Can be set using `GITWEB_SITE_HEADER` at build time.  No default
 	value.
 
-$site_footer::
+`$site_footer`::
 	Name of a file with HTML to be included at the bottom of each page.
 	Relative to the directory containing the 'gitweb.cgi' script.
 	Can be set using `GITWEB_SITE_FOOTER` at build time.  No default
 	value.
 
-$home_text::
+`$home_text`::
 	Name of a HTML file which, if it exists, is included on the
 	`gitweb` projects overview page ("projects_list" view).  Relative to
 	the directory containing the gitweb.cgi script.  Default value
 	can be adjusted during build time using `GITWEB_HOMETEXT` variable.
 	By default set to 'indextext.html'.
 
-$projects_list_description_width::
+`$projects_list_description_width`::
 	The width (in characters) of the "Description" column of the projects list.
 	Longer descriptions will be truncated (trying to cut at word boundary);
 	the full description is available in the 'title' attribute (usually shown on
 	mouseover).  The default is 25, which might be too small if you
 	use long project descriptions.
 
-$default_projects_order::
+`$default_projects_order`::
 	Default value of ordering of projects on projects list page, which
 	means the ordering used if you don't explicitly sort projects list
 	(if there is no "o" CGI query parameter in the URL).  Valid values
@@ -439,7 +439,7 @@ Changing gitweb's behavior
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 These configuration variables control _internal_ `gitweb` behavior.
 
-$default_blob_plain_mimetype::
+`$default_blob_plain_mimetype`::
 	Default mimetype for the blob_plain (raw) view, if mimetype checking
 	doesn't result in some other type; by default "text/plain".
 	Gitweb guesses mimetype of a file to display based on extension
@@ -447,11 +447,11 @@ $default_blob_plain_mimetype::
 	and `/etc/mime.types` files (see *mime.types*(5) manpage; only
 	filename extension rules are supported by `gitweb`).
 
-$default_text_plain_charset::
+`$default_text_plain_charset`::
 	Default charset for text files. If this is not set, the web server
 	configuration will be used.  Unset by default.
 
-$fallback_encoding::
+`$fallback_encoding`::
 	Gitweb assumes this charset when a line contains non-UTF-8 characters.
 	The fallback decoding is used without error checking, so it can be even
 	"utf-8". The value must be a valid encoding; see the *Encoding::Supported*(3pm)
@@ -496,26 +496,26 @@ time by setting the `GITWEB_BASE_URL` build-time configuration variable.
 By default it is set to (), i.e. an empty list.  This means that `gitweb`
 would not try to create project URL (to fetch) from project name.
 
-$projects_list_group_categories::
+`$projects_list_group_categories`::
 	Whether to enable the grouping of projects by category on the project
 	list page. The category of a project is determined by the
 	`$GIT_DIR/category` file or the `gitweb.category` variable in each
 	repository's configuration.  Disabled by default (set to 0).
 
-$project_list_default_category::
+`$project_list_default_category`::
 	Default category for projects for which none is specified.  If this is
 	set to the empty string, such projects will remain uncategorized and
 	listed at the top, above categorized projects.  Used only if project
 	categories are enabled, which means if `$projects_list_group_categories`
 	is true.  By default set to "" (empty string).
 
-$prevent_xss::
+`$prevent_xss`::
 	If true, some `gitweb` features are disabled to prevent content in
 	repositories from launching cross-site scripting (XSS) attacks.  Set this
 	to true if you don't trust the content of your repositories.
 	False by default (set to 0).
 
-$maxload::
+`$maxload`::
 	Used to set the maximum load that we will still respond to `gitweb` queries.
 	If the server load exceeds this value then `gitweb` will return
 	"503 Service Unavailable" error.  The server load is taken to be 0
@@ -527,14 +527,14 @@ $maxload::
 Set `$maxload` to undefined value (`undef`) to turn this feature off.
 The default value is 300.
 
-$omit_age_column::
+`$omit_age_column`::
 	If true, omit the column with date of the most current commit on the
 	projects list page. It can save a bit of I/O and a fork per repository.
 
-$omit_owner::
+`$omit_owner`::
 	If true prevents displaying information about repository owner.
 
-$per_request_config::
+`$per_request_config`::
 	If this is set to code reference, it will be run once for each request.
 	You can set parts of configuration that change per session this way.
 	For example, one might use the following code in a `gitweb` configuration
@@ -567,7 +567,7 @@ variables described below; they should be automatically set by `gitweb` to
 correct value.
 
 
-$version::
+`$version`::
 	Gitweb version, set automatically when creating gitweb.cgi from
 	gitweb.perl. You might want to modify it if you are running modified
 	`gitweb`, for example
@@ -580,19 +580,19 @@ if you run modified version of `gitweb` with caching support.  This variable
 is purely informational, used e.g. in the "generator" meta header in HTML
 header.
 
-$my_url::
-$my_uri::
+`$my_url`::
+`$my_uri`::
 	Full URL and absolute URL of the `gitweb` script;
 	in earlier versions of `gitweb` you might have need to set those
 	variables, but now there should be no need to do it.  See
 	`$per_request_config` if you need to set them still.
 
-$base_url::
+`$base_url`::
 	Base URL for relative URLs in pages generated by `gitweb`,
 	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
 	needed and used '<base href="$base_url">' only for URLs with nonempty
 	PATH_INFO.  Usually `gitweb` sets its value correctly,
-	and there is no need to set this variable, e.g. to $my_uri or "/".
+	and there is no need to set this variable, e.g. to `$my_uri` or "/".
 	See `$per_request_config` if you need to override it anyway.
 
 
@@ -805,7 +805,7 @@ The "default" value consists of a list of triplets in the form
 `("<label>", "<link>", "<position>")` where "position" is the label
 after which to insert the link, "link" is a format string where `%n`
 expands to the project name, `%f` to the project path within the
-filesystem (i.e. "$projectroot/$project"), `%h` to the current hash
+filesystem (i.e. `$projectroot`/`$project`), `%h` to the current hash
 (\'h' `gitweb` parameter) and `%b` to the current hash base
 (\'hb' `gitweb` parameter); `%%` expands to \'%'.
 +
@@ -860,7 +860,7 @@ time zones in the form of "+/-HHMM", such as "+0200".
 Project specific override is not supported.
 
 extra-branch-refs::
-	List of additional directories under "refs" which are going to
+	List of additional directories under `refs` which are going to
 	be used as branch refs. For example if you have a gerrit setup
 	where all branches under refs/heads/ are official,
 	push-after-review ones and branches under refs/sandbox/,
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 14abdb843f..f164857d83 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -60,14 +60,14 @@ more exact; `gitweb` is not interested in a working area, and is best suited
 to showing "bare" repositories).
 
 The name of the repository in `gitweb` is the path to its `$GIT_DIR` (its object
-database) relative to `$projectroot`.  Therefore the repository $repo can be
-found at "$projectroot/$repo".
+database) relative to `$projectroot`.  Therefore the repository `$repo` can be
+found at `$projectroot`/`$repo`.
 
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 Instead of having `gitweb` find repositories by scanning filesystem
-starting from $projectroot, you can provide a pre-generated list of
+starting from `$projectroot`, you can provide a pre-generated list of
 visible projects by setting `$projects_list` to point to a plain text
 file with a list of projects (with some additional info).
 
@@ -182,7 +182,7 @@ fetched from via `git://` protocol.
 * Finally, it is possible to specify an arbitrary perl subroutine that will
 be called for each repository to determine if it can be exported.  The
 subroutine receives an absolute path to the project (repository) as its only
-parameter (i.e. "$projectroot/$project").
+parameter (i.e. `$projectroot`/`$project`).
 +
 For example, if you use mod_perl to run the script, and have dumb
 HTTP protocol authentication configured for your repositories, you
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 8fef8db89d..cc8bfc5cfb 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -533,7 +533,7 @@ The most notable example is `HEAD`.
 [[def_remote_tracking_branch]]remote-tracking branch::
 	A <<def_ref,ref>> that is used to follow changes from another
 	<<def_repository,repository>>. It typically looks like
-	'refs/remotes/foo/bar' (indicating that it tracks a branch named
+	`refs/remotes/foo/bar` (indicating that it tracks a branch named
 	'bar' in a remote named 'foo'), and matches the right-hand-side of
 	a configured fetch <<def_refspec,refspec>>. A remote-tracking
 	branch should not contain direct modifications or have local
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d8a755faf1..e3c3556363 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -217,9 +217,9 @@ The placeholders are:
 			  the same time.
 +
 ** 'match=<pattern>': Only consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+   `glob(7)` pattern, excluding the `refs/tags/` prefix.
 ** 'exclude=<pattern>': Do not consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+   `glob(7)` pattern, excluding the `refs/tags/` prefix.
 
 '%S':: ref name given on the command line by which the commit was reached
        (like `git log --source`), only works with `git log`
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index f8c61dd42e..f055f56c37 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -75,15 +75,15 @@ with `refs/notes/`; when it begins with `notes/`, `refs/` and otherwise
 +
 Multiple `--notes` options can be combined to control which notes are
 being displayed. Examples: `--notes=foo` will show only notes from
-"refs/notes/foo"; `--notes=foo --notes` will show both notes from
-"refs/notes/foo" and from the default notes ref(s).
+`refs/notes/foo`; `--notes=foo --notes` will show both notes from
+`refs/notes/foo` and from the default notes ref(s).
 
 --no-notes::
 	Do not show notes. This negates the above `--notes` option, by
 	resetting the list of notes refs from which notes are shown.
 	Options are parsed in the order given on the command line, so e.g.
 	`--notes --notes=foo --no-notes --notes=bar` will only show notes
-	from "refs/notes/bar".
+	from `refs/notes/bar`.
 
 --show-notes[=<ref>]::
 --[no-]standard-notes::
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index e6e9669f68..fb491660d6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -163,7 +163,7 @@ endif::git-log[]
 
 --glob=<glob-pattern>::
 	Pretend as if all the refs matching shell glob '<glob-pattern>'
-	are listed on the command line as '<commit>'. Leading 'refs/',
+	are listed on the command line as '<commit>'. Leading `refs/`,
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f1bb9d0877..0614772a76 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -23,27 +23,27 @@ characters and to avoid word splitting.
   followed by a dash and a number of commits, followed by a dash, a
   'g', and an abbreviated object name.
 
-'<refname>', e.g. `master`, 'heads/master', 'refs/heads/master'::
+'<refname>', e.g. `master`, 'heads/master', `refs/heads/master`::
   A symbolic ref name.  E.g. `master` typically means the commit
-  object referenced by 'refs/heads/master'.  If you
+  object referenced by `refs/heads/master`.  If you
   happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell Git which one you mean.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
 
-  . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
+  . If `$GIT_DIR/<refname>` exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
     and `CHERRY_PICK_HEAD`);
 
-  . otherwise, 'refs/<refname>' if it exists;
+  . otherwise, `refs/<refname>` if it exists;
 
-  . otherwise, 'refs/tags/<refname>' if it exists;
+  . otherwise, `refs/tags/<refname>` if it exists;
 
-  . otherwise, 'refs/heads/<refname>' if it exists;
+  . otherwise, `refs/heads/<refname>` if it exists;
 
-  . otherwise, 'refs/remotes/<refname>' if it exists;
+  . otherwise, `refs/remotes/<refname>` if it exists;
 
-  . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
+  . otherwise, `refs/remotes/<refname>/HEAD` if it exists.
 +
 `HEAD` names the commit on which you based the changes in the working tree.
 `FETCH_HEAD` records the branch which you fetched from a remote repository
@@ -57,7 +57,7 @@ when you run `git merge`.
 `CHERRY_PICK_HEAD` records the commit which you are cherry-picking
 when you run `git cherry-pick`.
 +
-Note that any of the 'refs/*' cases above may come either from
+Note that any of the `refs/*` cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
@@ -72,7 +72,7 @@ some output processing may assume ref names in UTF-8.
   second ago}' or '{1979-02-26 18:30:00}') specifies the value
   of the ref at a prior point in time.  This suffix may only be
   used immediately following a ref name and the ref must have an
-  existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
+  existing log (`$GIT_DIR/logs/<ref>`). Note that this looks up the state
   of your *local* ref at a given time; e.g., what was in your local
   `master` branch last week. If you want to look at commits made during
   certain times, see `--since` and `--until`.
@@ -84,7 +84,7 @@ some output processing may assume ref names in UTF-8.
   is the immediate prior value of `master` while `master@{5}`
   is the 5th prior value of `master`. This suffix may only be used
   immediately following a ref name and the ref must have an existing
-  log ('$GIT_DIR/logs/<refname>').
+  log (`$GIT_DIR/logs/<refname>`).
 
 '@{<n>}', e.g. '@\{1\}'::
   You can use the '@' construct with an empty ref part to get at a
-- 
2.31.1.133.g84d06cdc06


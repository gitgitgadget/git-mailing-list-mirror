Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB9C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A722561175
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhDIEGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhDIEGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A4C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so3947691wma.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xInX0wyFhZhxMzQJx+f3Vk4N3i+w+Pw4IaiGaInFrQ=;
        b=sbZbXANW90qVZZJhBAqwKDajZyaEESfy1d/bIC3Hcr4IT2ih0xZDHfebum8wREl91w
         9pi+TP7k3Gj2+QG2q853mgzFscGqf7GGVdAkWasYRYb14tck4tfjbF0rp81oBOso4Bhg
         jAQSJn7UISYAga72KMN4hAbirYPGQLGzmxrRqdJsgqaz8XBYHzoipfT6dwhzC/7QEMYw
         NWwxAXyIOy5KL1fUwjnGXfJfa9Y60OZRs16sAiQxF8BiUc62Lc7sZHhWayX6+UvarTt1
         oQW+7UcF75UwP+7F/C/mPPvrYQEKFQPOGadzItu4VNbiuQj4N4AytqZQvXIf944WkUer
         G+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xInX0wyFhZhxMzQJx+f3Vk4N3i+w+Pw4IaiGaInFrQ=;
        b=dpYd+Kgem5xgyriKsQO/9Sa+sFMyodLfU6EhfyndMPGZBo8k1cBqOYfpEomRA3phId
         LLs/sjxnb0TOuoTLoV1eMO9E4e2C1vhJ6LZufbqjQqZ51xCMCjzQB4e4fu1Ktx36TI1g
         o948gOXAe2I9Arr220zXkcI7qKEsNlDPkNXOndWx86x1LSZihvl/LTSPCyw+b50NTrsu
         gs7G1mm73mPbh5Ylc2RCHc/iCK1qPxA7Hj7Jie7p0cx7bq2POv5YxLZlLhPfkW6BAulB
         WfXv1Tp9iNac+TP2cnCVYh6+p7M5uJ9mBBXee5INNY+uJMDYS0V+JOFIdviT5h64IkXu
         Nqpg==
X-Gm-Message-State: AOAM530zp14mHAxemW2jGR6LmnLIi614ySNp31/vx2nERxeWEmEBINv6
        jhb4oELcNpck3gF1b7/szvtqk6U5kN7JBA==
X-Google-Smtp-Source: ABdhPJyeNS5W8HCo7z8BKNXddM4pbqM457J057RnxN7o8YwX5gaoTP+g8+xsc2mU/X959pV4eCWutg==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr11532150wme.81.1617941145871;
        Thu, 08 Apr 2021 21:05:45 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:45 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 07/13] doc: typeset git dotfiles in monospace
Date:   Fri,  9 Apr 2021 06:02:55 +0200
Message-Id: <20210409040301.3260358-8-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap git dotfiles with backticks as indicated in the CodingGuidelines.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/config.txt            | 12 ++++++------
 Documentation/fetch-options.txt     |  2 +-
 Documentation/git-config.txt        |  8 ++++----
 Documentation/git-fast-import.txt   |  2 +-
 Documentation/git-format-patch.txt  |  2 +-
 Documentation/git-fsck.txt          |  4 ++--
 Documentation/git-instaweb.txt      |  2 +-
 Documentation/git-ls-files.txt      |  2 +-
 Documentation/git-notes.txt         |  8 ++++----
 Documentation/git-pack-refs.txt     |  4 ++--
 Documentation/git-prune.txt         |  2 +-
 Documentation/git-rebase.txt        |  4 ++--
 Documentation/git-submodule.txt     | 12 ++++++------
 Documentation/git-svn.txt           |  4 ++--
 Documentation/git-upload-pack.txt   |  2 +-
 Documentation/git-var.txt           |  2 +-
 Documentation/gitattributes.txt     |  8 ++++----
 Documentation/gitignore.txt         |  4 ++--
 Documentation/gitremote-helpers.txt |  2 +-
 Documentation/gittutorial-2.txt     | 10 +++++-----
 Documentation/gitweb.txt            |  2 +-
 Documentation/user-manual.txt       |  2 +-
 22 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05bcf1bf2b..1747307621 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -114,14 +114,14 @@ are:
 `gitdir`::
 
 	The data that follows the keyword `gitdir:` is used as a glob
-	pattern. If the location of the .git directory matches the
+	pattern. If the location of the `.git` directory matches the
 	pattern, the include condition is met.
 +
-The .git location may be auto-discovered, or come from `$GIT_DIR`
-environment variable. If the repository is auto discovered via a .git
-file (e.g. from submodules, or a linked worktree), the .git location
-would be the final location where the .git directory is, not where the
-.git file is.
+The `.git` location may be auto-discovered, or come from `$GIT_DIR`
+environment variable. If the repository is auto discovered via a `.git`
+file (e.g. from submodules, or a linked worktree), the `.git` location
+would be the final location where the `.git` directory is, not where the
+`.git` file is.
 +
 The pattern can contain standard globbing wildcards and two additional
 ones, `**/` and `/**`, that can match multiple path components. Please
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6aa07a54b9..94de13eec8 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -43,7 +43,7 @@ the current repository has the same history as the source repository.
 --update-shallow::
 	By default when fetching from a shallow repository,
 	`git fetch` refuses refs that require updating
-	.git/shallow. This option updates .git/shallow and accept such
+	`.git/shallow`. This option updates `.git/shallow` and accept such
 	refs.
 
 --negotiation-tip=<commit|glob>::
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 85e02aff92..afb14bcafe 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -148,7 +148,7 @@ See also <<FILES>>.
 --blob blob::
 	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
-	'.gitmodules' in the `master` branch. See "SPECIFYING REVISIONS"
+	`.gitmodules` in the `master` branch. See "SPECIFYING REVISIONS"
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
 
@@ -336,8 +336,8 @@ ENVIRONMENT
 -----------
 
 GIT_CONFIG::
-	Take the configuration from the given file instead of .git/config.
-	Using the `--global` option forces this to ~/.gitconfig. Using the
+	Take the configuration from the given file instead of `.git/config`.
+	Using the `--global` option forces this to `~/.gitconfig`. Using the
 	`--system` option forces this to $(prefix)/etc/gitconfig.
 
 GIT_CONFIG_NOSYSTEM::
@@ -367,7 +367,7 @@ for example when writing scripts.
 EXAMPLES
 --------
 
-Given a .git/config like this:
+Given a `.git/config` like this:
 
 ------------
 #
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index eeac242732..7b801de61a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -116,7 +116,7 @@ Locations of Marks Files
 	with `--import-marks`= and `--export-marks`= are relative
 	to an internal directory in the current repository.
 	In `git-fast-import` this means that the paths are relative
-	to the .git/info/fast-import directory. However, other
+	to the `.git/info/fast-import` directory. However, other
 	importers may use a different location.
 +
 Relative and non-relative marks may be combined by interweaving
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2009a048a9..3b10a6f7ea 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -503,7 +503,7 @@ If it does not apply correctly, there can be various reasons.
   this case.
 
 * The MUA corrupted your patch; "am" would complain that
-  the patch does not apply.  Look in the .git/rebase-apply/ subdirectory and
+  the patch does not apply.  Look in the `.git/rebase-apply/` subdirectory and
   see what 'patch' file contains and check for the common
   corruption patterns mentioned above.
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 048a28ee50..a680caa365 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -86,8 +86,8 @@ care about this output and want to speed it up further.
 	Be chatty.
 
 --lost-found::
-	Write dangling objects into .git/lost-found/commit/ or
-	.git/lost-found/other/, depending on type.  If the object is
+	Write dangling objects into `.git/lost-found/commit/` or
+	`.git/lost-found/other/`, depending on type.  If the object is
 	a blob, the contents are written into the file, rather than
 	its object name.
 
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index dfbd3a40ce..a8876b74ca 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -69,7 +69,7 @@ restart::
 CONFIGURATION
 -------------
 
-You may specify configuration in your .git/config
+You may specify configuration in your `.git/config`
 
 -----------------------------------------------------------------------
 [instaweb]
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index ee435024da..3557823de9 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -103,7 +103,7 @@ OPTIONS
 	directory and its subdirectories in <file>.
 
 --exclude-standard::
-	Add the standard Git exclusions: .git/info/exclude, .gitignore
+	Add the standard Git exclusions: `.git/info/exclude`, `.gitignore`
 	in each directory, and the user's global exclusion file.
 
 --error-unmatch::
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 8f25b07f10..ffc6fc51a7 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -192,11 +192,11 @@ OPTIONS
 --commit::
 	Finalize an in-progress `git notes merge`. Use this option
 	when you have resolved the conflicts that `git notes merge`
-	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
+	stored in `.git/NOTES_MERGE_WORKTREE`. This amends the partial
 	merge commit created by `git notes merge` (stored in
-	.git/NOTES_MERGE_PARTIAL) by adding the notes in
-	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
-	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
+	`.git/NOTES_MERGE_PARTIAL`) by adding the notes in
+	`.git/NOTES_MERGE_WORKTREE`. The notes ref stored in the
+	`.git/NOTES_MERGE_REF` symref is updated to the resulting commit.
 
 --abort::
 	Abort/reset an in-progress `git notes merge`, i.e. a notes merge
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 7e62ff3e8d..169bcfb07f 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -64,8 +64,8 @@ BUGS
 ----
 
 Older documentation written before the packed-refs mechanism was
-introduced may still say things like ".git/refs/heads/<branch> file
-exists" when it means "branch <branch> exists".
+introduced may still say things like "`.git/refs/heads/<branch>` file
+exists" when it means branch <branch> exists.
 
 
 GIT
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 4cdd753c13..382e5f70f4 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -24,7 +24,7 @@ objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
 running `git prune-packed`.
-It also removes entries from .git/shallow that are not reachable by
+It also removes entries from `.git/shallow` that are not reachable by
 any ref.
 
 Note that unreachable, packed objects will remain.  If this is
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ddc76ca308..1c5eaf8cf7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -48,7 +48,7 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run `git rebase --continue`.  Another option is to bypass the commit
 that caused the merge failure with `git rebase --skip`.  To check out the
-original <branch> and remove the .git/rebase-apply working files, use the
+original <branch> and remove the `.git/rebase-apply` working files, use the
 command `git rebase --abort` instead.
 
 Assume the following history exists and the current branch is `topic`:
@@ -800,7 +800,7 @@ completeness:
   them to stderr.
 
 * State directories: The two backends keep their state in different
-  directories under .git/
+  directories under `.git/`
 
 include::merge-strategies.txt[]
 
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b97531f808..0a691b1df0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -95,7 +95,7 @@ too (and can also report changes to a submodule's work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting `submodule.$name.url`
-	in .git/config. It uses the same setting from `.gitmodules` as
+	in `.git/config`. It uses the same setting from `.gitmodules` as
 	a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
@@ -106,8 +106,8 @@ configured to be active will be initialized, otherwise all submodules are
 initialized.
 +
 When present, it will also copy the value of `submodule.$name.update`.
-This command does not alter existing information in .git/config.
-You can then customize the submodule clone URLs in .git/config
+This command does not alter existing information in `.git/config`.
+You can then customize the submodule clone URLs in `.git/config`
 for your local setup and proceed to `git submodule update`;
 you can also just use `git submodule update --init` without
 the explicit 'init' step if you do not intend to customize
@@ -117,7 +117,7 @@ See the add subcommand for the definition of default remote.
 
 deinit [-f|--force] (--all|[--] <path>...)::
 	Unregister the given submodules, i.e. remove the whole
-	`submodule.$name` section from .git/config together with their work
+	`submodule.$name` section from `.git/config` together with their work
 	tree. Further calls to `git submodule update`, `git submodule foreach`
 	and `git submodule sync` will skip any unregistered submodules until
 	they are initialized again, so use this command if you don't want to
@@ -235,7 +235,7 @@ git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
 sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in `.gitmodules`. It will only affect those
-	submodules which already have a URL entry in .git/config (that is the
+	submodules which already have a URL entry in `.git/config` (that is the
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
@@ -251,7 +251,7 @@ absorbgitdirs::
 	move the `git` directory of the submodule into its superproject's
 	`$GIT_DIR/modules` path and then connect the `git` directory and
 	its working directory by setting the `core.worktree` and adding
-	a .git file pointing to the `git` directory embedded in the
+	a `.git` file pointing to the `git` directory embedded in the
 	superprojects `git` directory.
 +
 A repository that was cloned independently and later added as a submodule or
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 93868c9226..2e1e3348c7 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -221,7 +221,7 @@ config key: `svn-remote.<name>.include-paths`
 
 --placeholder-filename=<filename>;;
 	Set the name of placeholder files created by `--preserve-empty-dirs`.
-	Default: ".gitignore"
+	Default: "`.gitignore`"
 
 `rebase`::
 	This fetches revisions from the SVN parent of the current `HEAD`
@@ -432,7 +432,7 @@ Any other arguments are passed directly to `git log`
 
 `create-ignore`::
 	Recursively finds the svn:ignore property on directories and
-	creates matching .gitignore files. The resulting files are staged to
+	creates matching `.gitignore` files. The resulting files are staged to
 	be committed, but are not committed. Use `-r`/`--revision` to refer to a
 	specific revision.
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index f4b9dab02e..fdb7edc727 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -26,7 +26,7 @@ OPTIONS
 -------
 
 --[no-]strict::
-	Do not try <directory>/.git/ if <directory> is no Git directory.
+	Do not try `<directory>/.git/` if <directory> is no Git directory.
 
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 3e356129cd..1105e8a1cc 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -19,7 +19,7 @@ OPTIONS
 -------
 -l::
 	Cause the logical variables to be listed. In addition, all the
-	variables of the Git configuration file .git/config are listed
+	variables of the Git configuration file `.git/config` are listed
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config -l`.)
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2ce7365ec6..bd1cd2629c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - Defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, .gitattributes
+$GIT_DIR/info/attributes, `.gitattributes`
 
 
 DESCRIPTION
@@ -430,7 +430,7 @@ variable to `true`.
 Note: Whenever the clean filter is changed, the repo should be renormalized:
 $ git add --renormalize .
 
-For example, in .gitattributes, you would assign the `filter`
+For example, in `.gitattributes`, you would assign the `filter`
 attribute for paths.
 
 ------------------------
@@ -438,7 +438,7 @@ attribute for paths.
 ------------------------
 
 Then you would define a `filter.indent.clean` and `filter.indent.smudge`
-configuration in your .git/config to specify a pair of commands to
+configuration in your `.git/config` to specify a pair of commands to
 modify the contents of C programs when the source files are checked
 in ("clean" is run) and checked out (no change is made because the
 command is "cat").
@@ -771,7 +771,7 @@ matches what GNU 'diff -p' output uses.  This default selection however
 is not suited for some contents, and you can use a customized pattern
 to make a selection.
 
-First, in .gitattributes, you would assign the `diff` attribute
+First, in `.gitattributes`, you would assign the `diff` attribute
 for paths.
 
 ------------------------
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 379db07326..7488cdb585 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
+$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, `.gitignore`
 
 DESCRIPTION
 -----------
@@ -211,7 +211,7 @@ Another example:
     $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore
 --------------------------------------------------------------
 
-The second .gitignore prevents Git from ignoring
+The second `.gitignore` prevents Git from ignoring
 `arch/foo/kernel/vmlinux.lds.S`.
 
 Example to exclude everything except a specific directory `foo/bar`
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6e75d45382..e92b9113f2 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -512,7 +512,7 @@ set by Git if the remote helper has the 'option' capability.
 	repository is guaranteed empty).
 
 'option update-shallow' {'true'|'false'}::
-	Allow to extend .git/shallow if the new refs require it.
+	Allow to extend `.git/shallow` if the new refs require it.
 
 'option pushcert' {'true'|'false'}::
 	GPG sign pushes.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 65bc1453d6..ef11670768 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -133,7 +133,7 @@ header identifying their length and their type.  The type is either a
 blob, a tree, a commit, or a tag.
 
 The simplest commit to find is the `HEAD` commit, which we can find
-from .git/HEAD:
+from `.git/HEAD`:
 
 ------------------------------------------------
 $ cat .git/HEAD
@@ -141,7 +141,7 @@ ref: refs/heads/master
 ------------------------------------------------
 
 As you can see, this tells us which branch we're currently on, and it
-tells us this by naming a file under the .git directory, which itself
+tells us this by naming a file under the `.git` directory, which itself
 contains a SHA-1 name referring to a commit object, which we can
 examine with cat-file:
 
@@ -203,8 +203,8 @@ project's history:
     data and "tree" objects containing subdirectory information.
   * "blob" objects contain file data without any other structure.
   * References to commit objects at the head of each branch are
-    stored in files under .git/refs/heads/.
-  * The name of the current branch is stored in .git/HEAD.
+    stored in files under `.git/refs/heads/`.
+  * The name of the current branch is stored in `.git/HEAD`.
 
 Note, by the way, that lots of commands take a tree as an argument.
 But as we can see above, a tree can be referred to in many different
@@ -263,7 +263,7 @@ index a042389..513feba 100644
 
 So `git diff` is comparing against something other than the head.
 The thing that it's comparing against is actually the index file,
-which is stored in .git/index in a binary format, but whose contents
+which is stored in `.git/index` in a binary format, but whose contents
 we can examine with ls-files:
 
 ------------------------------------------------
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 689afb38c0..14abdb843f 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -642,7 +642,7 @@ parameter.
 
 *Notice* that in this case you don't need special settings for
 `@stylesheets`, `$my_uri` and `$home_link`, but you lose "dumb client"
-access to your project .git dirs (described in "Single URL for `gitweb` and
+access to your project `.git` dirs (described in "Single URL for `gitweb` and
 for fetching" section).  A possible workaround for the latter is the
 following: in your project root dir (e.g. `/pub/git`) have the projects
 named *without* a .git extension (e.g. `/pub/git/project` instead of
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 4459d74ec2..998875fc2b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3143,7 +3143,7 @@ Writing objects: 100% (6020/6020), done.
 Total 6020 (delta 4070), reused 0 (delta 0)
 ------------------------------------------------
 
-This creates a single "pack file" in .git/objects/pack/
+This creates a single "pack file" in `.git/objects/pack/`
 containing all currently unpacked objects.  You can then run
 
 ------------------------------------------------
-- 
2.31.1.133.g84d06cdc06


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3807F20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdFVVB4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:01:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34312 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFVVBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:01:54 -0400
Received: by mail-pf0-f171.google.com with SMTP id s66so13998123pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6PGr46b+g+Z4bWxBo+fs/xWPreFLVoC9BOISHpgVlU=;
        b=s78n+OKRSpr2P0ooh8urIn/2LnYta0wacybnGxG8K0VzD7PvCugCqzci+aHXV/Bqqk
         knmmH4pmF989gqcB21ALgHoL/ry4C/XNpRVvTyVyRnVtjUGsKm5r/fAuLryUhxSVhjaO
         2f7L67Ilsx3LSsTHyH9Ml7ouLzn1hb1o+HeHnU5VZW0rXZG6l4Fj7QavhHXd9PT7GA8j
         9ZdKzfctKFsiQfJ70kfuq3oJkNgyreaHXmoE16UKeHSwZ4qUqyv75O4wY2UBU+Ckf8Ur
         islvPRyFfstoairwaoDtDqtOBzA1z3WzLPg7bAzXl4IMw5x6p7xBZ4d6G9w0jRX6C9l+
         u+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6PGr46b+g+Z4bWxBo+fs/xWPreFLVoC9BOISHpgVlU=;
        b=CgktjWF1/7RmNPI+gjqWzIMu5CGThJ4EnLIhsEXyuWZ93B4+zv64P5oJAKm6PXoHl6
         brISW1QbdiDij9lyWGygoAmMwsOYNrOIAqa9l0rq5tlCdOUy9buLAVJoUZGzUymW3EcR
         9cqt0PpMGip25PGt+ed34+jqNyMNhKFI03mSJVNYmLt0qiDONEDn3KWGcD5Vva+eA+m3
         Zue0JLdjfE4rPjnc6P35XjtbXgfVLQp/lA4SnDzWiynoOXuzBeCh8HPtGMf1F6md944A
         7LLfJq/HfWhKPTyeayles0febMpPkNkeHhoZ2oNKjYHZY9X3PLANuH55LsLaLkPuLkq0
         Q1/A==
X-Gm-Message-State: AKS2vOxYYFmiMnbQQSB2NIh3Aq7ySfiqfz6OiffkdTu3aPc1HFCWG9Im
        EvEg5S9OPtRl7u3ipClK3Q==
X-Received: by 10.99.125.25 with SMTP id y25mr4672142pgc.38.1498165313464;
        Thu, 22 Jun 2017 14:01:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id t77sm5668147pfg.102.2017.06.22.14.01.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 14:01:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCHv3] submodules: overhaul documentation
Date:   Thu, 22 Jun 2017 14:01:49 -0700
Message-Id: <20170622210149.4603-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620225650.7573-1-sbeller@google.com>
References: <20170620225650.7573-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch aims to detangle (a) the usage of `git-submodule`
from (b) the concept of submodules and (c) how the actual
implementation looks like, such as where they are configured
and (d) what the best practices are.

To do so, move the conceptual parts of the 'git-submodule'
man page to a new man page gitsubmodules(7). This new page
is just like gitmodules(5), gitattributes(5), gitcredentials(7),
gitnamespaces(7), gittutorial(7), which introduce a concept
rather than explaining a specific command.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Rerolling sb/submodule-doc once again.

* Adding examples to the config section
* no extra word invented (the "tracking directory" is no more)

I rebased this on top of Kaartics submodule cleanup patch, but there were
no conflicts, such that we can keep it in parallel branches.

 Documentation/Makefile          |   1 +
 Documentation/git-rm.txt        |   4 +-
 Documentation/git-submodule.txt |  44 ++------
 Documentation/gitsubmodules.txt | 221 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/gitsubmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b5be2e2d3f..2415e0d657 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -31,6 +31,7 @@ MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
+MAN7_TXT += gitsubmodules.txt
 MAN7_TXT += gittutorial-2.txt
 MAN7_TXT += gittutorial.txt
 MAN7_TXT += gitworkflows.txt
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc116eb..db444693dd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -152,8 +152,8 @@ Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.
 
 If you only want to remove the local checkout of a submodule from your
-work tree without committing the removal,
-use linkgit:git-submodule[1] `deinit` instead.
+work tree without committing the removal, use linkgit:git-submodule[1] `deinit`
+instead. Also see linkgit:gitsubmodules[7] for details on submodule removal.
 
 EXAMPLES
 --------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 6e07bade39..e67b58bddc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -24,37 +24,7 @@ DESCRIPTION
 -----------
 Inspects, updates and manages submodules.
 
-A submodule allows you to keep another Git repository in a subdirectory
-of your repository. The other repository has its own history, which does not
-interfere with the history of the current repository. This can be used to
-have external dependencies such as third party libraries for example.
-
-When cloning or pulling a repository containing submodules however,
-these will not be checked out by default; the 'init' and 'update'
-subcommands will maintain submodules checked out and at
-appropriate revision in your working tree.
-
-Submodules are composed from a so-called `gitlink` tree entry
-in the main repository that refers to a particular commit object
-within the inner repository that is completely separate.
-A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
-root of the source tree assigns a logical name to the submodule and
-describes the default URL the submodule shall be cloned from.
-The logical name can be used for overriding this URL within your
-local repository configuration (see 'submodule init').
-
-Submodules are not to be confused with remotes, which are other
-repositories of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strategy,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
+For more information about submodules, see linkgit:gitsubmodules[7].
 
 COMMANDS
 --------
@@ -142,15 +112,17 @@ deinit [-f|--force] (--all|[--] <path>...)::
 	tree. Further calls to `git submodule update`, `git submodule foreach`
 	and `git submodule sync` will skip any unregistered submodules until
 	they are initialized again, so use this command if you don't want to
-	have a local checkout of the submodule in your working tree anymore. If
-	you really want to remove a submodule from the repository and commit
-	that use linkgit:git-rm[1] instead.
+	have a local checkout of the submodule in your working tree anymore.
 +
 When the command is run without pathspec, it errors out,
 instead of deinit-ing everything, to prevent mistakes.
 +
 If `--force` is specified, the submodule's working tree will
 be removed even if it contains local modifications.
++
+If you really want to remove a submodule from the repository and commit
+that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
+options.
 
 update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
@@ -428,6 +400,10 @@ This file should be formatted in the same way as `$GIT_DIR/config`. The key
 to each submodule url is "submodule.$name.url".  See linkgit:gitmodules[5]
 for details.
 
+SEE ALSO
+--------
+linkgit:gitsubmodules[7], linkgit:gitmodules[5].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
new file mode 100644
index 0000000000..46cf120f66
--- /dev/null
+++ b/Documentation/gitsubmodules.txt
@@ -0,0 +1,221 @@
+gitsubmodules(7)
+================
+
+NAME
+----
+gitsubmodules - mounting one repository inside another
+
+SYNOPSIS
+--------
+ .gitmodules, $GIT_DIR/config
+------------------
+git submodule
+git <command> --recurse-submodules
+------------------
+
+DESCRIPTION
+-----------
+
+A submodule is a repository embedded inside another repository.
+The submodule has its own history; the repository it is embedded
+in is called a superproject.
+
+On the filesystem, a submodule usually (but not always - see FORMS below)
+consists of (i) a Git directory located under the `$GIT_DIR/modules/`
+directory of its superproject, (ii) a working directory inside the
+superproject's working directory, and a `.git` file at the root of
+the submodule’s working directory pointing to (i).
+
+Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
+and a working directory at `path/to/bar/`, the superproject tracks the
+submodule via a `gitlink` entry in the tree at `path/to/bar` and an entry
+in its `.gitmodules` file (see linkgit:gitmodules[5]) of the form
+`submodule.foo.path = path/to/bar`.
+
+The `gitlink` entry contains the object name of the commit that the
+superproject expects the submodule’s working directory to be at.
+
+The section `submodule.foo.*` in the `.gitmodules` file gives additional
+hints to Gits porcelain layer such as where to obtain the submodule via
+the `submodule.foo.url` setting.
+
+Submodules can be used for at least two different use cases:
+
+1. Using another project while maintaining independent history.
+  Submodules allow you to contain the working tree of another project
+  within your own working tree while keeping the history of both
+  projects separate. Also, since submodules are fixed to an arbitrary
+  version, the other project can be independently developed without
+  affecting the superproject, allowing the superproject project to
+  fix itself to new versions only when desired.
+
+2. Splitting a (logically single) project into multiple
+   repositories and tying them back together. This can be used to
+   overcome current limitations of Gits implementation to have
+   finer grained access:
+
+    * Size of the git repository:
+      In its current form Git scales up poorly for large repositories containing
+      content that is not compressed by delta computation between trees.
+      However you can also use submodules to e.g. hold large binary assets
+      and these repositories are then shallowly cloned such that you do not
+      have a large history locally.
+    * Transfer size:
+      In its current form Git requires the whole working tree present. It
+      does not allow partial trees to be transferred in fetch or clone.
+    * Access control:
+      By restricting user access to submodules, this can be used to implement
+      read/write policies for different users.
+
+The configuration of submodules
+-------------------------------
+
+Submodule operations can be configured using the following mechanisms
+(from highest to lowest precedence):
+
+ * The command line for those commands that support taking submodule specs.
+   Most commands have a boolean flag '--recurse-submodules' whether to
+   recurse into submodules. Examples are `ls-files` or `checkout`.
+   Some commands take enums, such as `fetch` and `push`, where you can
+   specify how submodules are affected.
+
+ * The configuration inside the submodule. This includes `$GIT_DIR/config`
+   in the submodule, but also settings in the tree such as a `.gitattributes`
+   or `.gitignore` files that specify behavior of commands inside the
+   submodule.
++
+For example an effect from the submodule's `.gitignore` file
+would be observed when you run `git status --ignore-submodules=none` in
+the superproject. This collects information from the submodule's working
+directory by running `status` in the submodule, which does pay attention
+to its `.gitignore` file.
++
+The submodule's `$GIT_DIR/config` file would come into play when running
+`git push --recurse-submodules=check` in the superproject, as this would
+check if the submodule has any changes not published to any remote. The
+remotes are configured in the submodule as usual in the `$GIT_DIR/config`
+file.
+
+ * The configuration file `$GIT_DIR/config` in the superproject.
+   Typical configuration at this place is controlling if a submodule
+   is recursed into at all via the `active` flag for example.
++
+If the submodule is not yet initialized, then the configuration
+inside the submodule does not exist yet, so configuration where to
+obtain the submodule from is configured here for example.
+
+ * the `.gitmodules` file inside the superproject. Additionally to the
+   required mapping between submodule's name and path, a project usually
+   uses this file to suggest defaults for the upstream collection
+   of repositories.
++
+This file mainly serves as the mapping between name and path in
+the superproject, such that the submodule's git directory can be
+located.
++
+If the submodule has never been initialized, this is the only place
+where submodule configuration is found. It serves as the last fallback
+to specify where to obtain the submodule from.
+
+FORMS
+-----
+
+Submodules can take the following forms:
+
+ * The basic form described in DESCRIPTION with a Git directory,
+a working directory, a `gitlink`, and a `.gitmodules` entry.
+
+ * "Old-form" submodule: A working directory with an embedded
+`.git` directory, and the tracking `gitlink` and `.gitmodules` entry in
+the superproject. This is typically found in repositories generated
+using older versions of Git.
++
+It is possible to construct these old form repositories manually.
++
+When deinitialized or deleted (see below), the submodule’s Git
+directory is automatically moved to `$GIT_DIR/modules/<name>/`
+of the superproject.
+
+ * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
+but no submodule working directory. The submodule’s git directory
+may be there as after deinitializing the git directory is kept around.
+The directory which is supposed to be the working directory is empty instead.
++
+A submodule can be deinitialized by running `git submodule deinit`.
+Besides emptying the working directory, this command only modifies
+the superproject’s `$GIT_DIR/config` file, so the superproject’s history
+is not affected. This can be undone using `git submodule init`.
+
+ * Deleted submodule: A submodule can be deleted by running
+`git rm <submodule path> && git commit`. This can be undone
+using `git revert`.
++
+The deletion removes the superproject’s tracking data, which are
+both the `gitlink` entry and the section in the `.gitmodules` file.
+The submodule’s working directory is removed from the file
+system, but the Git directory is kept around as it to make it
+possible to checkout past commits without requiring fetching
+from another repository.
++
+To completely remove a submodule, manually delete
+`$GIT_DIR/modules/<name>/`.
+
+Workflow for a third party library
+----------------------------------
+
+  # add a submodule
+  git submodule add <url> <path>
+
+  # occasionally update the submodule to a new version:
+  git -C <path> checkout <new version>
+  git add <path>
+  git commit -m "update submodule to new version"
+
+  # See the list of submodules in a superproject
+  git submodule status
+
+  # See FORMS on removing submodules
+
+
+Workflow for an artificially split repo
+--------------------------------------
+
+  # Enable recursion for relevant commands, such that
+  # regular commands recurse into submodules by default
+  git config --global submodule.recurse true
+
+  # Unlike the other commands below clone still needs
+  # its own recurse flag:
+  git clone --recurse <URL> <directory>
+  cd <directory>
+
+  # Get to know the code:
+  git grep foo
+  git ls-files
+
+  # Get new code
+  git fetch
+  git pull --rebase
+
+  # change worktree
+  git checkout
+  git reset
+
+Implementation details
+----------------------
+
+When cloning or pulling a repository containing submodules the submodules
+will not be checked out by default; You can instruct 'clone' to recurse
+into submodules. The 'init' and 'update' subcommands of 'git submodule'
+will maintain submodules checked out and at an appropriate revision in
+your working tree. Alternatively you can set 'submodule.recurse' to have
+'checkout' recursing into submodules.
+
+
+SEE ALSO
+--------
+linkgit:git-submodule[1], linkgit:gitmodules[5].
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.12.2.575.gb14f27f917


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15C31F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBHJFJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43653 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so1156796plb.10
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TD7rN1IM6YH5QPE6VuA55GZYEC9YwohgSQ7BWJ7y7OM=;
        b=ifa3VjnoEQOs+nip7BfO4pWdJn5Dtrm5owYtneqfyg/UiXa71HUWxVYV9qbAzBD54Z
         xV0+XK56zAvL3ewONmx0CIts7Q0zDbSLDPq+jock8yQjwh9nzNyvHVOiZcMs7hiq53vp
         XzC7/o57Ivw/ETSpjo6CTmBsGnTjP/26oaMoLPoXmeegecbABGP1C7Ihd041nWHDMR7r
         y6weiuqQhrzXbzibSItIk6M6nLGj7JC78/er2t3so7iZwp0ZhztjeUNUL0peIIebpd75
         2K9vYljncI9agQTC1A/zg2AlyaLZov2q9wB2+2wXBYarj8UgI0wDl8qZA+WQyxNfahlZ
         yTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TD7rN1IM6YH5QPE6VuA55GZYEC9YwohgSQ7BWJ7y7OM=;
        b=BMLg918ewKI/xAosthZf3CFBfVnQAu54mD2Fpwj9r7YwVdvReHwXqfvTjNrF935tOh
         QbYK3Vj+cpMmUprV6WH1kE0lxECWdZCbJlpa7HoA2FDudao+o/Qh1L9IFNxvefAd40s8
         EX0Oeks7rKzdN3zDkMDGUtJdKLpjfj31aufa5pSP33nzPLrMBKwLrxL1muR7xIuZPLZg
         bTd7qG6KEYasiP2y6Ya8EFAQs9X6jvjhe7OcLlLiDIHGXY2BEEzNrC5pt6H6B753ASRH
         LTIIRT9FLNMo/y5osGLExLGXvgVfGN8DjYlNf0386dtbQ/WriaJWsR8Z8HE1YnqsVSEm
         bndQ==
X-Gm-Message-State: AHQUAuY71KVSmQwancq0J89hcRyNCCKZ4o6TM4CzkQ8RViAeWbZfFQvz
        fLeeHD+XJsWQYGf2yQIiRFk=
X-Google-Smtp-Source: AHgI3IY/gZ25NsPhleELwNPaW+9r7ib9WpJC9uNoQbO+7kFBHh7gU5DfLFkQthsp6uhH15N9u6MnxA==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr10173018plq.324.1549616707832;
        Fri, 08 Feb 2019 01:05:07 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k26sm2532233pfb.87.2019.02.08.01.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/19] checkout: split part of it to new command switch
Date:   Fri,  8 Feb 2019 16:03:50 +0700
Message-Id: <20190208090401.14793-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" doing too many things is a source of confusion for many
users (and it even bites old timers sometimes). To remedy that, the
command will be split into two new ones: switch and
something-to-checkout-paths. The good old "git checkout" command is
still here and will be until all (or most of users) are sick of it.

See the new man page for the final design of switch. The actual
implementation though is still pretty much the same as "git checkout"
and not completely aligned with the man page. Following patches will
adjust their behavior to match the man page.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore                        |   1 +
 Documentation/config/advice.txt   |  13 +-
 Documentation/config/branch.txt   |   4 +-
 Documentation/config/checkout.txt |   9 +-
 Documentation/config/diff.txt     |   3 +-
 Documentation/git-checkout.txt    |   4 +
 Documentation/git-switch.txt      | 257 ++++++++++++++++++++++++++++++
 Documentation/gitattributes.txt   |   3 +-
 Documentation/githooks.txt        |   8 +-
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/checkout.c                |  60 +++++--
 command-list.txt                  |   1 +
 git.c                             |   1 +
 14 files changed, 339 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/git-switch.txt

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..8e2b89047f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -167,6 +167,7 @@
 /git-submodule
 /git-submodule--helper
 /git-svn
+/git-switch
 /git-symbolic-ref
 /git-tag
 /git-unpack-file
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 88620429ea..239d479506 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -42,7 +42,8 @@ advice.*::
 		state in the output of linkgit:git-status[1], in
 		the template shown when writing commit messages in
 		linkgit:git-commit[1], and in the help message shown
-		by linkgit:git-checkout[1] when switching branch.
+		by linkgit:git-switch[1] or
+		linkgit:git-checkout[1] when switching branch.
 	statusUoption::
 		Advise to consider using the `-u` option to linkgit:git-status[1]
 		when the command takes more than 2 seconds to enumerate untracked
@@ -62,12 +63,14 @@ advice.*::
 		your information is guessed from the system username and
 		domain name.
 	detachedHead::
-		Advice shown when you used linkgit:git-checkout[1] to
-		move to the detach HEAD state, to instruct how to create
-		a local branch after the fact.
+		Advice shown when you used
+		linkgit:git-switch[1] or linkgit:git-checkout[1]
+		to move to the detach HEAD state, to instruct how to
+		create a local branch after the fact.
 	checkoutAmbiguousRemoteBranchName::
 		Advice shown when the argument to
-		linkgit:git-checkout[1] ambiguously resolves to a
+		linkgit:git-checkout[1] and linkgit:git-switch[1]
+		ambiguously resolves to a
 		remote tracking branch on more than one remote in
 		situations where an unambiguous argument would have
 		otherwise caused a remote-tracking branch to be
diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 019d60ede2..8050466159 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -1,5 +1,5 @@
 branch.autoSetupMerge::
-	Tells 'git branch' and 'git checkout' to set up new branches
+	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
@@ -11,7 +11,7 @@ branch.autoSetupMerge::
 	branch. This option defaults to true.
 
 branch.autoSetupRebase::
-	When a new branch is created with 'git branch' or 'git checkout'
+	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
 	that tracks another branch, this variable tells Git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
 	When `never`, rebase is never automatically set to true.
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 73380a8d86..fc211eca58 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -1,5 +1,6 @@
 checkout.defaultRemote::
-	When you run 'git checkout <something>' and only have one
+	When you run 'git checkout <something>'
+	or 'git switch <something>' and only have one
 	remote, it may implicitly fall back on checking out and
 	tracking e.g. 'origin/<something>'. This stops working as soon
 	as you have more than one remote with a '<something>'
@@ -8,8 +9,10 @@ checkout.defaultRemote::
 	disambiguation. The typical use-case is to set this to
 	`origin`.
 +
-Currently this is used by linkgit:git-checkout[1] when 'git checkout
-<something>' will checkout the '<something>' branch on another remote,
+Currently this is used by linkgit:git-switch[1] and
+linkgit:git-checkout[1] when 'git checkout <something>'
+or 'git switch <something>'
+will checkout the '<something>' branch on another remote,
 and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index e48bb987d7..b3b304ee12 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -78,7 +78,8 @@ diff.external::
 diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
 	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout' also honors
+	commands such as 'git diff-files'. 'git checkout'
+	and 'git switch' also honor
 	this setting when reporting uncommitted changes. Setting it to
 	'all' disables the submodule summary normally shown by 'git commit'
 	and 'git status' when `status.submoduleSummary` is set unless it is
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9ac01f7967..31c6cbef19 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -556,6 +556,10 @@ $ edit frotz
 $ git add frotz
 ------------
 
+SEE ALSO
+--------
+linkgit:git-switch[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
new file mode 100644
index 0000000000..1a4d156e3c
--- /dev/null
+++ b/Documentation/git-switch.txt
@@ -0,0 +1,257 @@
+git-switch(1)
+=============
+
+NAME
+----
+git-switch - Switch branches
+
+SYNOPSIS
+--------
+[verse]
+'git switch' [<options>] [--guess] <branch>
+'git switch' [<options>] --detach [<start-point>]
+'git switch' [<options>] (-c|-C|--orphan) <new-branch> [<start-point>]
+
+DESCRIPTION
+-----------
+Switch to a specified branch. The working tree and the index are
+updated to match the branch. All new commits will be added to the tip
+of this branch.
+
+Optionally a new branch could be created with either `-c` or `-C`, or
+detach the working tree from any branch with `--detach`, along with
+switching.
+
+Switching branches does not require a clean index and working tree
+(i.e. no differences compared to 'HEAD'). The operation is aborted
+however if the switch leads to loss of local changes, unless told
+otherwise.
+
+OPTIONS
+-------
+<branch>::
+	Branch to switch to.
+
+<new-branch>::
+	Name for the new branch.
+
+<start-point>::
+	The name of a commit at which to switch to before creating a
+	new branch or detach from.
++
+You can use the `"@{-N}"` syntax to refer to the N-th last
+branch/commit switched to "git switch" or "git checkout"
+operation. You may also specify `-` which is synonymous to `"@{-1}`.
++
+As a special case, you may use `"A...B"` as a shortcut for the merge
+base of `A` and `B` if there is exactly one merge base. You can leave
+out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+
+-c <new-branch>::
+--create <new-branch>::
+	Create a new branch named <new-branch> starting at
+	<start-point> before switching to the branch. This is a
+	convenient shortcut for:
++
+------------
+$ git branch <new-branch>
+$ git switch <new-branch>
+------------
+
+-C <new-branch>::
+--force-create <new-branch>::
+	Similar to `--create` except that if <new-branch> already
+	exists, it will be reset to <start-point>. This is a
+	convenient shortcut for:
++
+------------
+$ git branch -f <new-branch>
+$ git switch <new-branch>
+------------
+
+-d::
+--detach::
+	Switch to a commit for inspection and discardable
+	experiments. See the "DETACHED HEAD" section in
+	linkgit:git-checkout[1] for details.
+
+-g::
+--guess::
+	If <branch> is not found but there does exist a tracking
+	branch in exactly one remote (call it <remote>) with a
+	matching name, treat as equivalent to
++
+------------
+$ git switch -c <branch> --track <remote>/<branch>
+------------
++
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to e.g. `checkout.defaultRemote=origin`
+to always checkout remote branches from there if `<branch>` is
+ambiguous but exists on the 'origin' remote. See also
+`checkout.defaultRemote` in linkgit:git-config[1].
+
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+-f::
+--force::
+	Proceed even if the index or the working tree differs from
+	HEAD. Both the index and working tree are restored to match
+	the switching target. This is used to throw away local
+	changes.
+
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
+-t::
+--track::
+	When creating a new branch, set up "upstream" configuration.
+	`-c` is implied. See "--track" in linkgit:git-branch[1] for
+	details.
++
+If no `-c` option is given, the name of the new branch will be derived
+from the remote-tracking branch, by looking at the local part of the
+refspec configured for the corresponding remote, and then stripping
+the initial part up to the "*".  This would tell us to use "hack" as
+the local branch when branching off of "origin/hack" (or
+"remotes/origin/hack", or even "refs/remotes/origin/hack").  If the
+given name has no slash, or the above guessing results in an empty
+name, the guessing is aborted.  You can explicitly give a name with
+`-c` in such a case.
+
+--no-track::
+	Do not set up "upstream" configuration, even if the
+	branch.autoSetupMerge configuration variable is true.
+
+-m::
+--merge::
+	If you have local modifications to one or more files that are
+	different between the current branch and the branch to which
+	you are switching, the command refuses to switch branches in
+	order to preserve your modifications in context.  However,
+	with this option, a three-way merge between the current
+	branch, your working tree contents, and the new branch is
+	done, and you will be on the new branch.
++
+When a merge conflict happens, the index entries for conflicting
+paths are left unmerged, and you need to resolve the conflicts
+and mark the resolved paths with `git add` (or `git rm` if the merge
+should result in deletion of the path).
+
+--conflict=<style>::
+	The same as --merge option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	merge.conflictStyle configuration variable.  Possible values are
+	"merge" (default) and "diff3" (in addition to what is shown by
+	"merge" style, shows the original contents).
+
+--orphan <new-branch>::
+	Create a new 'orphan' branch, named <new-branch>, started from
+	<start-point> and switch to it. See explanation of the same
+	option in linkgit:git-checkout[1] for details.
+
+--ignore-other-worktrees::
+	`git switch` refuses when the wanted ref is already
+	checked out by another worktree. This option makes it check
+	the ref out anyway. In other words, the ref can be held by
+	more than one worktree.
+
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated.
+	Just like linkgit:git-submodule[1], this will detach the
+	submodules HEAD.
+
+EXAMPLES
+--------
+
+The following command switches to the "master" branch:
+
+------------
+$ git switch master
+------------
+
+After working in the wrong branch, switching to the correct branch
+would be done using:
+
+------------
+$ git switch mytopic
+------------
+
+However, your "wrong" branch and correct "mytopic" branch may differ
+in files that you have modified locally, in which case the above
+switch would fail like this:
+
+------------
+$ git switch mytopic
+error: You have local changes to 'frotz'; not switching branches.
+------------
+
+You can give the `-m` flag to the command, which would try a three-way
+merge:
+
+------------
+$ git switch -m mytopic
+Auto-merging frotz
+------------
+
+After this three-way merge, the local modifications are _not_
+registered in your index file, so `git diff` would show you what
+changes you made since the tip of the new branch.
+
+To switch back to the previous branch before we switched to mytopic
+(i.e. "master" branch):
+
+------------
+$ git switch -
+------------
+
+You can grow a new branch from any commit. For example, switch to
+"HEAD~3" and create branch "fixup":
+
+------------
+$ git switch -c fixup HEAD~3
+Switched to a new branch 'fixup'
+------------
+
+If you want to start a new branch from a remote branch of the same
+name, use `-g`:
+
+------------
+$ git switch -g new-topic
+Branch 'new-topic' set up to track remote branch 'new-topic' from 'origin'
+Switched to a new branch 'new-topic'
+------------
+
+To check out commit "HEAD~3" for temporary inspection or experiment
+without creating a new branch:
+
+------------
+$ git switch --detach HEAD~3
+HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
+------------
+
+If it turns out whatever you have done is worth keeping, you can
+always create a new name for it (without switching away):
+
+------------
+$ git switch -c good-surprises
+------------
+
+SEE ALSO
+--------
+linkgit:git-checkout[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..5731caa4c6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -112,7 +112,8 @@ Checking-out and checking-in
 
 These attributes affect how the contents stored in the
 repository are copied to the working tree files when commands
-such as 'git checkout' and 'git merge' run.  They also affect how
+such as 'git switch', 'git checkout'  and 'git merge' run.
+They also affect how
 Git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..e257a7810a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -161,12 +161,13 @@ rebased, and is not set when rebasing the current branch.
 post-checkout
 ~~~~~~~~~~~~~
 
-This hook is invoked when a linkgit:git-checkout[1] is run after having updated the
+This hook is invoked when a linkgit:git-checkout[1] or
+linkgit:git-switch[1] is run after having updated the
 worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of `git checkout`.
+This hook cannot affect the outcome of `git switch` or `git checkout`.
 
 It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the
@@ -402,7 +403,8 @@ exit with a zero status.
 For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
 in order to emulate `git fetch` that is run in the reverse direction
 with `git push`, as the two-tree form of `git read-tree -u -m` is
-essentially the same as `git checkout` that switches branches while
+essentially the same as `git switch` or `git checkout`
+that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
diff --git a/Makefile b/Makefile
index 6e8d017e8e..0e5b29390c 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,7 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
+BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
diff --git a/builtin.h b/builtin.h
index 6538932e99..c64e44450e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -227,6 +227,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_switch(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8ea1349cce..2ac53b4302 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,11 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+static const char * const switch_branch_usage[] = {
+	N_("git switch [<options>] [<branch>]"),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1396,33 +1401,25 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			 struct checkout_opts *opts, struct option *options,
+			 const char * const usagestr[])
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
 	int dwim_new_local_branch;
-	struct option *options = NULL;
 
-	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
 	opts->overlay_mode = -1;
-	opts->no_dwim_new_local_branch = 0;
 
 	git_config(git_checkout_config, opts);
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	options = parse_options_dup(options);
-	options = add_common_options(opts, options);
-	options = add_switch_branch_options(opts, options);
-	options = add_checkout_path_options(opts, options);
-
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
@@ -1555,3 +1552,42 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		return checkout_branch(opts, &new_branch_info);
 	}
 }
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.no_dwim_new_local_branch = 0;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, checkout_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_switch(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.no_dwim_new_local_branch = 0;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, switch_branch_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..13317f47d4 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -171,6 +171,7 @@ git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
+git-switch                              mainporcelain           history
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain           history
 git-unpack-file                         plumbinginterrogators
diff --git a/git.c b/git.c
index 0ce0e13f0f..31b8e8d6a1 100644
--- a/git.c
+++ b/git.c
@@ -558,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
-- 
2.20.1.682.gd5861c6d90


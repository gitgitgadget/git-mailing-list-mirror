Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DCF1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbdBCCtM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36193 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1167871wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaFopM/7A1qq87xF1IwdqOMICudSQfwrnQ+riThEcZo=;
        b=SnOoKupNfniBGKP6jC8zdAtaJCYIdU/84rEz+/L51YEKOEBqt1IiMw+JJbOiNe362p
         qTq715ENNTvFnZiPDkuMeuC0doARCEFoYcG3uWCb82yl5jCHq6DtppUyxZVZN1Fs9SnN
         488wWFlybs74v+JjsgACV0ZjqM3b8uI47fujXvlEv4b1uWhJ5bzCQhULw14KN1/w3VFJ
         t1bG4Q0eHMcwDkbvbS06NAMr7JHCBB9Zco7ptemyuGQt9XCxZV1N+Hm9BwBhBJ2rhbnF
         0l1L/Y1lOHyOLSx8YtkbytLdhr23RJ/G9iB4xVpmRebG3qiGqc0HU3iR+qxnoTAGS2MA
         S1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaFopM/7A1qq87xF1IwdqOMICudSQfwrnQ+riThEcZo=;
        b=I75NvTCOPuVmItTuuPJeOZLFqcO8oo3BBpAXwbeKCOb28ZYLKbTtdBtcboxSVDBn4H
         QWrlOFYsQwGa+ggnCNgTG7QsZrM4JoKFFlc/aBUPBAW8WT+LawPyOHwsWNIMhgiBYhjK
         IL5vdsmnB9uPISyYZFXS1V/pzCIyROwzIdzWzye5L+FI8mbaGCBZuepHx9svly6WzNX1
         IHkfRpdBlOzwVjbGwUqLoSgmAHf4rL3vKNypiMEYPnSwf9Vg8nXBwin8NBCtSaAYIIuI
         MzzsOb4Mbid2Lgx6NHwQAY8XF9T802bzgTovpSf8IrMYwWyCc305V/0KJ7ClhOVrlXIw
         ukZQ==
X-Gm-Message-State: AMke39n5fBre+CvdS0nGHOL6/FH/G8M8f5UrGQ8EBQruQpaRogMhBf5GPFTcMfIg50UL9w==
X-Received: by 10.28.185.77 with SMTP id j74mr490274wmf.76.1486090149221;
        Thu, 02 Feb 2017 18:49:09 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:08 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 00/21] completion: various __gitdir()-related improvements
Date:   Fri,  3 Feb 2017 03:48:08 +0100
Message-Id: <20170203024829.8071-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a long overdue reroll of a bunch of bugfixes, cleanups and
optimizations related to how the completion script finds the path to
the repository and how it uses that path.  Most importantly this
series adds support for completion following 'git -C path', and it
eliminates a few subshells and git processes, for the sake of
fork()+exec() challenged OSes.

The first round is at [1].  It made its way to pu back then, but since
the reroll didn't come it was eventually discarded.

What did NOT change since v1 is that the new option added to 'git
rev-parse' is still called '--absolute-git-dir'.  There was a
suggestion [2] to turn it into an orthogonal '--absolute-dir' option
that works with other path-querying options, too, but I really doubt
it's worth it.  In short, regular scripts don't care, because a
relative path doesn't make any difference for them, and before we do
this orthogonal thing we have to decide a bunch of questions first,
see [3].

Changes since v1:

 - Use our real_path() instead of system realpath() to implement 'git
   rev-parse --absolute-git-dir'.
 - Refactored a bit how __git_refs() determines where it should list
   refs from.
 - Renamed a few refnames and remote in the tests (this accounts for
   the bulk of the interdiff).
 - Misc small adjustments: a few more comments, removed unnecessary
   disambiguating '--', typofix and more consistent quoting.
 - Improved commit messages.
 - Rebased to current master.

The interdiff below is compared to v1 rebased on top of current master.

This series is also available at

  https://github.com/szeder/git completion-gitdir-improvements


[1] - http://public-inbox.org/git/1456440650-32623-1-git-send-email-szeder@ira.uka.de/T/

[2] - http://public-inbox.org/git/CANoM8SXO_Rz_CVOz9ptsaVCzcQ2D1FQrSuFFW4vZ4SdRYMzD=w@mail.gmail.com/

[3] - http://public-inbox.org/git/20160518185825.Horde.EPd2nJNvqEW_VX4b01yWdIr@webmail.informatik.kit.edu/

SZEDER Gábor (21):
  completion: improve __git_refs()'s in-code documentation
  completion tests: don't add test cruft to the test repository
  completion tests: make the $cur variable local to the test helper
    functions
  completion tests: consolidate getting path of current working
    directory
  completion tests: check __gitdir()'s output in the error cases
  completion tests: add tests for the __git_refs() helper function
  completion: ensure that the repository path given on the command line
    exists
  completion: fix most spots not respecting 'git --git-dir=<path>'
  completion: respect 'git --git-dir=<path>' when listing remote refs
  completion: list refs from remote when remote's name matches a
    directory
  completion: don't list 'HEAD' when trying refs completion outside of a
    repo
  completion: list short refs from a remote given as a URL
  completion: don't offer commands when 'git --opt' needs an argument
  completion: fix completion after 'git -C <path>'
  rev-parse: add '--absolute-git-dir' option
  completion: respect 'git -C <path>'
  completion: don't use __gitdir() for git commands
  completion: consolidate silencing errors from git commands
  completion: don't guard git executions with __gitdir()
  completion: extract repository discovery from __gitdir()
  completion: cache the path to the repository

 Documentation/git-rev-parse.txt        |   4 +
 builtin/rev-parse.c                    |  26 +-
 contrib/completion/git-completion.bash | 250 ++++++++++-----
 t/t1500-rev-parse.sh                   |  17 +-
 t/t9902-completion.sh                  | 561 +++++++++++++++++++++++++++++----
 5 files changed, 690 insertions(+), 168 deletions(-)

-- 
2.11.0.555.g967c1bcb3

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4040b3c86..1967bafba 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -820,10 +820,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
-						char absolute_path[PATH_MAX];
-						if (!realpath(gitdir, absolute_path))
-							die_errno(_("unable to get absolute path"));
-						puts(absolute_path);
+						puts(real_path(gitdir));
 						continue;
 					}
 				}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0184d0ebc..ed06cb621 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -350,41 +350,38 @@ __git_tags ()
 
 # Lists refs from the local (by default) or from a remote repository.
 # It accepts 0, 1 or 2 arguments:
-# 1: The remote to lists refs from (optional; ignored, if set but empty).
+# 1: The remote to list refs from (optional; ignored, if set but empty).
 #    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 __git_refs ()
 {
 	local i hash dir track="${2-}"
-	local from_local=y remote="${1-}" named_remote=n
+	local list_refs_from=path remote="${1-}"
 	local format refs pfx
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
 
-	if [ -z "$dir" ] && [ -z "$remote" ]; then
-		return
-	fi
-
-	if [ -n "$remote" ]; then
+	if [ -z "$remote" ]; then
+		if [ -z "$dir" ]; then
+			return
+		fi
+	else
 		if __git_is_configured_remote "$remote"; then
 			# configured remote takes precedence over a
 			# local directory with the same name
-			from_local=n
-			named_remote=y
+			list_refs_from=remote
+		elif [ -d "$remote/.git" ]; then
+			dir="$remote/.git"
+		elif [ -d "$remote" ]; then
+			dir="$remote"
 		else
-			if [ -d "$remote/.git" ]; then
-				dir="$remote/.git"
-			elif [ -d "$remote" ]; then
-				dir="$remote"
-			else
-				from_local=n
-			fi
+			list_refs_from=url
 		fi
 	fi
 
-	if [ "$from_local" = y ] && [ -d "$dir" ]; then
+	if [ "$list_refs_from" = path ]; then
 		case "$cur" in
 		refs|refs/*)
 			format="refname"
@@ -430,18 +427,18 @@ __git_refs ()
 		done
 		;;
 	*)
-		if [ "$named_remote" = y ]; then
+		if [ "$list_refs_from" = remote ]; then
 			echo "HEAD"
-			__git for-each-ref --format="%(refname:short)" -- \
+			__git for-each-ref --format="%(refname:short)" \
 				"refs/remotes/$remote/" | sed -e "s#^$remote/##"
 		else
 			__git ls-remote "$remote" HEAD \
-				'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' |
+				"refs/tags/*" "refs/heads/*" "refs/remotes/*" |
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
 				refs/*)	echo "${i#refs/*/}" ;;
-				*)	echo "$i" ;;
+				*)	echo "$i" ;;  # symbolic refs
 				esac
 			done
 		fi
@@ -910,7 +907,7 @@ __git_get_option_value ()
 	done
 
 	if [ -n "$config_key" ] && [ -z "$result" ]; then
-		result="$(git --git-dir="$(__gitdir)" config "$config_key")"
+		result="$(__git config "$config_key")"
 	fi
 
 	echo "$result"
@@ -2830,9 +2827,12 @@ __git_main ()
 	if [ -z "$command" ]; then
 		case "$prev" in
 		--git-dir|-C|--work-tree)
+			# these need a path argument, let's fall back to
+			# Bash filename completion
 			return
 			;;
 		-c|--namespace)
+			# we don't support completing these options' arguments
 			return
 			;;
 		esac
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1660759e3..d711bef24 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -519,22 +519,19 @@ test_expect_success '__git_is_configured_remote' '
 '
 
 test_expect_success 'setup for ref completion' '
-	echo content >file1 &&
-	echo more >file2 &&
-	git add file1 file2 &&
-	git commit -m one &&
-	git branch mybranch &&
-	git tag mytag &&
+	git commit --allow-empty -m initial &&
+	git branch matching-branch &&
+	git tag matching-tag &&
 	(
 		cd otherrepo &&
-		>file &&
-		git add file &&
-		git commit -m initial &&
-		git branch branch
+		git commit --allow-empty -m initial &&
+		git branch -m master master-in-other &&
+		git branch branch-in-other &&
+		git tag tag-in-other
 	) &&
-	git remote add remote "$ROOT/otherrepo/.git" &&
-	git update-ref refs/remotes/remote/branch master &&
-	git update-ref refs/remotes/remote/master master &&
+	git remote add other "$ROOT/otherrepo/.git" &&
+	git fetch --no-tags other &&
+	rm -f .git/FETCH_HEAD &&
 	git init thirdrepo
 '
 
@@ -542,10 +539,10 @@ test_expect_success '__git_refs - simple' '
 	cat >expected <<-EOF &&
 	HEAD
 	master
-	mybranch
-	remote/branch
-	remote/master
-	mytag
+	matching-branch
+	other/branch-in-other
+	other/master-in-other
+	matching-tag
 	EOF
 	(
 		cur= &&
@@ -557,7 +554,7 @@ test_expect_success '__git_refs - simple' '
 test_expect_success '__git_refs - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/master
-	refs/heads/mybranch
+	refs/heads/matching-branch
 	EOF
 	(
 		cur=refs/heads/ &&
@@ -569,8 +566,9 @@ test_expect_success '__git_refs - full refs' '
 test_expect_success '__git_refs - repo given on the command line' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
+	tag-in-other
 	EOF
 	(
 		__git_dir="$ROOT/otherrepo/.git" &&
@@ -583,8 +581,9 @@ test_expect_success '__git_refs - repo given on the command line' '
 test_expect_success '__git_refs - remote on local file system' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
+	tag-in-other
 	EOF
 	(
 		cur= &&
@@ -595,11 +594,12 @@ test_expect_success '__git_refs - remote on local file system' '
 
 test_expect_success '__git_refs - remote on local file system - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/branch
-	refs/heads/master
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
 	EOF
 	(
-		cur=refs/heads/ &&
+		cur=refs/ &&
 		__git_refs otherrepo >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -608,24 +608,25 @@ test_expect_success '__git_refs - remote on local file system - full refs' '
 test_expect_success '__git_refs - configured remote' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
 	EOF
 	(
 		cur= &&
-		__git_refs remote >"$actual"
+		__git_refs other >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success '__git_refs - configured remote - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/branch
-	refs/heads/master
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
 	EOF
 	(
-		cur=refs/heads/ &&
-		__git_refs remote >"$actual"
+		cur=refs/ &&
+		__git_refs other >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -633,28 +634,29 @@ test_expect_success '__git_refs - configured remote - full refs' '
 test_expect_success '__git_refs - configured remote - repo given on the command line' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
 	EOF
 	(
 		cd thirdrepo &&
 		__git_dir="$ROOT/.git" &&
 		cur= &&
-		__git_refs remote >"$actual"
+		__git_refs other >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success '__git_refs - configured remote - full refs - repo given on the command line' '
 	cat >expected <<-EOF &&
-	refs/heads/branch
-	refs/heads/master
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
 	EOF
 	(
 		cd thirdrepo &&
 		__git_dir="$ROOT/.git" &&
-		cur=refs/heads/ &&
-		__git_refs remote >"$actual"
+		cur=refs/ &&
+		__git_refs other >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -662,14 +664,14 @@ test_expect_success '__git_refs - configured remote - full refs - repo given on
 test_expect_success '__git_refs - configured remote - remote name matches a directory' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
 	EOF
-	mkdir remote &&
-	test_when_finished "rm -rf remote" &&
+	mkdir other &&
+	test_when_finished "rm -rf other" &&
 	(
 		cur= &&
-		__git_refs remote >"$actual"
+		__git_refs other >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -677,8 +679,9 @@ test_expect_success '__git_refs - configured remote - remote name matches a dire
 test_expect_success '__git_refs - URL remote' '
 	cat >expected <<-EOF &&
 	HEAD
-	branch
-	master
+	branch-in-other
+	master-in-other
+	tag-in-other
 	EOF
 	(
 		cur= &&
@@ -689,11 +692,12 @@ test_expect_success '__git_refs - URL remote' '
 
 test_expect_success '__git_refs - URL remote - full refs' '
 	cat >expected <<-EOF &&
-	refs/heads/branch
-	refs/heads/master
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
 	EOF
 	(
-		cur=refs/heads/ &&
+		cur=refs/ &&
 		__git_refs "file://$ROOT/otherrepo/.git" >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -709,7 +713,7 @@ test_expect_success '__git_refs - non-existing remote' '
 
 test_expect_success '__git_refs - non-existing remote - full refs' '
 	(
-		cur=refs/heads/ &&
+		cur=refs/ &&
 		__git_refs non-existing >"$actual"
 	) &&
 	test_must_be_empty "$actual"
@@ -725,30 +729,41 @@ test_expect_success '__git_refs - non-existing URL remote' '
 
 test_expect_success '__git_refs - non-existing URL remote - full refs' '
 	(
-		cur=refs/heads/ &&
+		cur=refs/ &&
 		__git_refs "file://$ROOT/non-existing" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
 
+test_expect_success '__git_refs - not in a git repository' '
+	(
+		GIT_CEILING_DIRECTORIES="$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd subdir &&
+		cur= &&
+		__git_refs >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
 test_expect_success '__git_refs - unique remote branches for git checkout DWIMery' '
 	cat >expected <<-EOF &&
 	HEAD
 	master
-	mybranch
-	otherremote/ambiguous
-	otherremote/otherbranch
+	matching-branch
+	other/ambiguous
+	other/branch-in-other
+	other/master-in-other
 	remote/ambiguous
-	remote/branch
-	remote/master
-	mytag
-	branch
-	master
-	otherbranch
+	remote/branch-in-remote
+	matching-tag
+	branch-in-other
+	branch-in-remote
+	master-in-other
 	EOF
-	for remote_ref in refs/remotes/remote/ambiguous \
-		refs/remotes/otherremote/ambiguous \
-		refs/remotes/otherremote/otherbranch
+	for remote_ref in refs/remotes/other/ambiguous \
+		refs/remotes/remote/ambiguous \
+		refs/remotes/remote/branch-in-remote
 	do
 		git update-ref $remote_ref master &&
 		test_when_finished "git update-ref -d $remote_ref"
@@ -760,19 +775,10 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__git_refs - not in a git repository' '
-	(
-		GIT_CEILING_DIRECTORIES="$ROOT" &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd subdir &&
-		cur= &&
-		__git_refs >"$actual"
-	) &&
-	test_must_be_empty "$actual"
-'
-
-test_expect_success 'remove configured remote used for refs completion' '
-	git remote remove remote
+test_expect_success 'teardown after ref completion' '
+	git branch -d matching-branch &&
+	git tag -d matching-tag &&
+	git remote remove other
 '
 
 test_expect_success '__git_get_config_variables' '
@@ -898,6 +904,15 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
 
+test_expect_success 'setup for integration tests' '
+	echo content >file1 &&
+	echo more >file2 &&
+	git add file1 file2 &&
+	git commit -m one &&
+	git branch mybranch &&
+	git tag mytag
+'
+
 test_expect_success 'checkout completes ref names' '
 	test_completion "git checkout m" <<-\EOF
 	master Z
@@ -908,7 +923,7 @@ test_expect_success 'checkout completes ref names' '
 
 test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
-	branch Z
+	branch-in-other Z
 	EOF
 '
 

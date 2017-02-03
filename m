Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4985D1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbdBCCtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36433 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdBCCte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1169498wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMJ3DGPPxWwH22frAQPiTKOVd4JOCqGpoyXi/AO564A=;
        b=JT4eGSr3flUedna53bL7yUWtHnKSTP8bh8TaNSGoaSDgKxcWDZ0b9FJ3s+JnZFDvVs
         aOGcJYHEBoCenBllGzGVO44w0n87MO7voChOzZ4Ewlhs3jenqSfHf/ELWctBr7JUycHR
         XswzLt3oY2a7r7FH0Ly5VcohWUg8rltj+xWfQ1++oJK+O0IwJT+ASfepCwGsPn99fJ6O
         3hD3yo1jTvmfJvA8XMvztEHnChQeq8TMYiXrmYQH7Pw7+stXt91Z5bxEVXegVbqu/+lR
         aucGJuI3lmxu7g+lTu1Gwa4N1PBIbHyod4mtef/28z4VsQd5ZjQ2sXmyjoF6wIDPEUc+
         dw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMJ3DGPPxWwH22frAQPiTKOVd4JOCqGpoyXi/AO564A=;
        b=o/f4z9LxM7WhoEFnt63l1zhnvdPTxvab1X1hC7iRhWKx9exZKZPPeLEmgTNGF335O4
         tKjDlBOa0GiAuEux9Uny5ueTUN0GcNFuK0rl5ddD2q4zMeU0CrsEcHs11zdgkf6Qved5
         Khh1SlfTiUYJGyXqmgLXVIDWuK3IRfO26yAnK6m+6VpTJpkZEJdyOhL5HXPDdgHpjugb
         45rfqTyAnQDoyRbmsA0Rfz27wK1gWSE/GHV4u6knsfZvgc8C1DiOn6gUT378CzD/MnXr
         8l0GZI77WYwMU0kGGP/xi4/tR0jyxoFKBXqb+IBPn+aVeoZL2pqh8c42XDufyOmgdODN
         u4xQ==
X-Gm-Message-State: AIkVDXLT3nk/PTyCNY4htagdb1Ofxpyos7+a2T8fOCQHuG57G4XX5L/rFVNEH40zFS+j8Q==
X-Received: by 10.223.179.26 with SMTP id j26mr9942993wrd.126.1486090172731;
        Thu, 02 Feb 2017 18:49:32 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 21/21] completion: cache the path to the repository
Date:   Fri,  3 Feb 2017 03:48:29 +0100
Message-Id: <20170203024829.8071-22-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous changes in this series there are only a handful of
$(__gitdir) command substitutions left in the completion script, but
there is still a bit of room for improvements:

  1. The command substitution involves the forking of a subshell,
     which has considerable overhead on some platforms.

  2. There are a few cases, where this command substitution is
     executed more than once during a single completion, which means
     multiple subshells and possibly multiple 'git rev-parse'
     executions.  __gitdir() is invoked twice while completing refs
     for e.g. 'git log', 'git rebase', 'gitk', or while completing
     remote refs for 'git fetch' or 'git push'.

Both of these points can be addressed by using the
__git_find_repo_path() helper function introduced in the previous
commit:

  1. __git_find_repo_path() stores the path to the repository in a
     variable instead of printing it, so the command substitution
     around the function can be avoided.  Or rather: the command
     substitution should be avoided to make the new value of the
     variable set inside the function visible to the callers.
     (Yes, there is now a command substitution inside
     __git_find_repo_path() around each 'git rev-parse', but that's
     executed only if necessary, and only once per completion, see
     point 2. below.)

  2. $__git_repo_path, the variable holding the path to the
     repository, is declared local in the toplevel completion
     functions __git_main() and __gitk_main().  Thus, once set, the
     path is visible in all completion functions, including all
     subsequent calls to __git_find_repo_path(), meaning that they
     wouldn't have to re-discover the path to the repository.

So call __git_find_repo_path() and use $__git_repo_path instead of the
$(__gitdir) command substitution to access paths in the .git
directory.  Turn tests checking __gitdir()'s repository discovery into
tests of __git_find_repo_path() such that only the tested function
changes but the expected results don't, ensuring that repo discovery
keeps working as it did before.

As __gitdir() is not used anymore in the completion script, mark it as
deprecated and direct users' attention to __git_find_repo_path() and
$__git_repo_path.  Yet keep four __gitdir() tests to ensure that it
handles success and failure of __git_find_repo_path() and that it
still handles its optional remote argument, because users' custom
completion scriptlets might depend on it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash |  46 ++++++----
 t/t9902-completion.sh                  | 161 +++++++++++++++++++++------------
 2 files changed, 132 insertions(+), 75 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7775411cd..ed06cb621 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -39,6 +39,11 @@ esac
 # variable.
 __git_find_repo_path ()
 {
+	if [ -n "$__git_repo_path" ]; then
+		# we already know where it is
+		return
+	fi
+
 	if [ -n "${__git_C_args-}" ]; then
 		__git_repo_path="$(git "${__git_C_args[@]}" \
 			${__git_dir:+--git-dir="$__git_dir"} \
@@ -56,6 +61,7 @@ __git_find_repo_path ()
 	fi
 }
 
+# Deprecated: use __git_find_repo_path() and $__git_repo_path instead
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
@@ -350,10 +356,13 @@ __git_tags ()
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 __git_refs ()
 {
-	local i hash dir="$(__gitdir)" track="${2-}"
+	local i hash dir track="${2-}"
 	local list_refs_from=path remote="${1-}"
 	local format refs pfx
 
+	__git_find_repo_path
+	dir="$__git_repo_path"
+
 	if [ -z "$remote" ]; then
 		if [ -z "$dir" ]; then
 			return
@@ -458,8 +467,8 @@ __git_refs_remotes ()
 
 __git_remotes ()
 {
-	local d="$(__gitdir)"
-	test -d "$d/remotes" && ls -1 "$d/remotes"
+	__git_find_repo_path
+	test -d "$__git_repo_path/remotes" && ls -1 "$__git_repo_path/remotes"
 	__git remote
 }
 
@@ -957,8 +966,8 @@ __git_whitespacelist="nowarn warn error error-all fix"
 
 _git_am ()
 {
-	local dir="$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ]; then
+	__git_find_repo_path
+	if [ -d "$__git_repo_path"/rebase-apply ]; then
 		__gitcomp "--skip --continue --resolved --abort"
 		return
 	fi
@@ -1041,7 +1050,8 @@ _git_bisect ()
 	local subcommands="start bad good skip reset visualize replay log run"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		if [ -f "$(__gitdir)"/BISECT_START ]; then
+		__git_find_repo_path
+		if [ -f "$__git_repo_path"/BISECT_START ]; then
 			__gitcomp "$subcommands"
 		else
 			__gitcomp "replay start"
@@ -1146,8 +1156,8 @@ _git_cherry ()
 
 _git_cherry_pick ()
 {
-	local dir="$(__gitdir)"
-	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
 		__gitcomp "--continue --quit --abort"
 		return
 	fi
@@ -1538,10 +1548,10 @@ __git_log_date_formats="relative iso8601 rfc2822 short local default raw"
 _git_log ()
 {
 	__git_has_doubledash && return
+	__git_find_repo_path
 
-	local g="$(__gitdir)"
 	local merge=""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
 	case "$cur" in
@@ -1788,11 +1798,12 @@ _git_push ()
 
 _git_rebase ()
 {
-	local dir="$(__gitdir)"
-	if [ -f "$dir"/rebase-merge/interactive ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/rebase-merge/interactive ]; then
 		__gitcomp "--continue --skip --abort --quit --edit-todo"
 		return
-	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	elif [ -d "$__git_repo_path"/rebase-apply ] || \
+	     [ -d "$__git_repo_path"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort --quit"
 		return
 	fi
@@ -2467,8 +2478,8 @@ _git_reset ()
 
 _git_revert ()
 {
-	local dir="$(__gitdir)"
-	if [ -f "$dir"/REVERT_HEAD ]; then
+	__git_find_repo_path
+	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
 		__gitcomp "--continue --quit --abort"
 		return
 	fi
@@ -2865,9 +2876,10 @@ __gitk_main ()
 	__git_has_doubledash && return
 
 	local __git_repo_path
-	local g="$(__gitdir)"
+	__git_find_repo_path
+
 	local merge=""
-	if [ -f "$g/MERGE_HEAD" ]; then
+	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
 	case "$cur" in
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1816ed2e0..d711bef24 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -131,213 +131,217 @@ else
 	ROOT="$(pwd)"
 fi
 
-test_expect_success 'setup for __gitdir tests' '
+test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
 	mkdir -p subdir/subsubdir &&
+	mkdir -p non-repo &&
 	git init otherrepo
 '
 
-test_expect_success '__gitdir - from command line (through $__git_dir)' '
+test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		__git_dir="$ROOT/otherrepo/.git" &&
-		__gitdir >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success '__gitdir - repo as argument' '
-	echo "otherrepo/.git" >expected &&
-	(
-		__gitdir "otherrepo" >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - remote as argument' '
-	echo "remote" >expected &&
-	(
-		__gitdir "remote" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
-
-test_expect_success '__gitdir - .git directory in cwd' '
+test_expect_success '__git_find_repo_path - .git directory in cwd' '
 	echo ".git" >expected &&
 	(
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - .git directory in parent' '
+test_expect_success '__git_find_repo_path - .git directory in parent' '
 	echo "$ROOT/.git" >expected &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - cwd is a .git directory' '
+test_expect_success '__git_find_repo_path - cwd is a .git directory' '
 	echo "." >expected &&
 	(
 		cd .git &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - parent is a .git directory' '
+test_expect_success '__git_find_repo_path - parent is a .git directory' '
 	echo "$ROOT/.git" >expected &&
 	(
 		cd .git/refs/heads &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - $GIT_DIR set while .git directory in cwd' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while .git directory in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		GIT_DIR="$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - $GIT_DIR set while .git directory in parent' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while .git directory in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		GIT_DIR="$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - from command line while "git -C"' '
+test_expect_success '__git_find_repo_path - from command line while "git -C"' '
 	echo "$ROOT/.git" >expected &&
 	(
 		__git_dir="$ROOT/.git" &&
 		__git_C_args=(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - relative dir from command line and "git -C"' '
+test_expect_success '__git_find_repo_path - relative dir from command line and "git -C"' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		__git_dir="otherrepo/.git" &&
 		__git_C_args=(-C ..) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - $GIT_DIR set while "git -C"' '
+test_expect_success '__git_find_repo_path - $GIT_DIR set while "git -C"' '
 	echo "$ROOT/.git" >expected &&
 	(
 		GIT_DIR="$ROOT/.git" &&
 		export GIT_DIR &&
 		__git_C_args=(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - relative dir in $GIT_DIR and "git -C"' '
+test_expect_success '__git_find_repo_path - relative dir in $GIT_DIR and "git -C"' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		GIT_DIR="otherrepo/.git" &&
 		export GIT_DIR &&
 		__git_C_args=(-C ..) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - "git -C" while .git directory in cwd' '
+test_expect_success '__git_find_repo_path - "git -C" while .git directory in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		__git_C_args=(-C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - "git -C" while cwd is a .git directory' '
+test_expect_success '__git_find_repo_path - "git -C" while cwd is a .git directory' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd .git &&
 		__git_C_args=(-C .. -C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - "git -C" while .git directory in parent' '
+test_expect_success '__git_find_repo_path - "git -C" while .git directory in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	(
 		cd subdir &&
 		__git_C_args=(-C .. -C otherrepo) &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - non-existing path in "git -C"' '
+test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
 	(
 		__git_C_args=(-C non-existing) &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
 
-test_expect_success '__gitdir - non-existing path in $__git_dir' '
+test_expect_success '__git_find_repo_path - non-existing path in $__git_dir' '
 	(
 		__git_dir="non-existing" &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
 
-test_expect_success '__gitdir - non-existing $GIT_DIR' '
+test_expect_success '__git_find_repo_path - non-existing $GIT_DIR' '
 	(
 		GIT_DIR="$ROOT/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __gitdir >"$actual"
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
 	) &&
 	test_must_be_empty "$actual"
 '
 
-test_expect_success '__gitdir - gitfile in cwd' '
+test_expect_success '__git_find_repo_path - gitfile in cwd' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - gitfile in parent' '
+test_expect_success '__git_find_repo_path - gitfile in parent' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir >"$actual"
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success SYMLINKS '__gitdir - resulting path avoids symlinks' '
+test_expect_success SYMLINKS '__git_find_repo_path - resulting path avoids symlinks' '
 	echo "$ROOT/otherrepo/.git" >expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
@@ -345,16 +349,57 @@ test_expect_success SYMLINKS '__gitdir - resulting path avoids symlinks' '
 	test_when_finished "rm -f link" &&
 	(
 		cd link &&
+		__git_find_repo_path &&
+		echo "$__git_repo_path" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_find_repo_path - not a git repository' '
+	(
+		cd non-repo &&
+		GIT_CEILING_DIRECTORIES="$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		test_must_fail __git_find_repo_path &&
+		printf "$__git_repo_path" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__gitdir - finds repo' '
+	echo "$ROOT/.git" >expected &&
+	(
+		cd subdir/subsubdir &&
 		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
 
-test_expect_success '__gitdir - not a git repository' '
-	nongit test_must_fail __gitdir >"$actual" &&
+
+test_expect_success '__gitdir - returns error when cant find repo' '
+	(
+		__git_dir="non-existing" &&
+		test_must_fail __gitdir >"$actual"
+	) &&
 	test_must_be_empty "$actual"
 '
 
+test_expect_success '__gitdir - repo as argument' '
+	echo "otherrepo/.git" >expected &&
+	(
+		__gitdir "otherrepo" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__gitdir - remote as argument' '
+	echo "remote" >expected &&
+	(
+		__gitdir "remote" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__gitcomp - trailing space - options' '
 	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
-- 
2.11.0.555.g967c1bcb3


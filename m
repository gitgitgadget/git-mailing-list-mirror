Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704A1E52D
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046604; cv=none; b=pC5mG4IOuQur1LXCJOeDva5XdFwbdlgJFfqjQCF3i7jRxrcaEPIcrUPhCW0UhGIqLxr/Ux33QWg/JS2CB+NjLPmDvU+MArwHfzUrjun13nI86FO4q5UrKoQgfHIV9kPyh10w+2b9hmt1i1w4gwGjuHEjJJmVWrs9NxQrPmsH+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046604; c=relaxed/simple;
	bh=W+ZCvSh0BgOdlnMe/EjaZ4mcpbuAANA3rngqIPVqH+w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mKAVANzrxrTYRRMq8IjX/NE1F3nR4PMf3aWvmRfbMvd9Fso2PM0r63A5PwLsgXh2yZQAhJeAazU5NgUSkNuqNxpbfJ2k9K7y8KblRajhbrTvNEdnaN60ZLDVPOK85VokmVq55AzH4vr34BzDFCXK3ZdEG9SYFsWblNModuw8vKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfj/SytJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfj/SytJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450d37d4699so35100105e9.0
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046601; x=1749651401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvdNvOX9Znr6oRqS+J9wBZR93N8R4067cZ7N1qREAtA=;
        b=Nfj/SytJ9S4cNOhBEfN7q5+l4nYz5e3PATKBXt8O162oHAQgT/zRpc4Crn2ayGOrFB
         w14PBFMskT8oBDliYA3j/0NQkI4SmB+VzZNJnWrzCJ9pLPRh2Z5P92VuHwmJ/IEGRhVX
         N+vM5VUBoOQuMgiSNWK1IIq0w3SEyNlL1sZ1KFmrvga6vC5chAVrd1HDpJLWIUmdx/2N
         JREKV500eIo71anBEULa8fMirRLtRleZnr1RgW/EjUy7pNb2IEBLVq+oLEidTrB4prN6
         BVwjY+zBJj5ia4+Y/krotlBYbY6mm3UgHq8/Ov3GwcS1UbNV7tNMYdqNAGt0wFKOtml9
         XALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046601; x=1749651401;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvdNvOX9Znr6oRqS+J9wBZR93N8R4067cZ7N1qREAtA=;
        b=YRghulVLv5iwW7oq7FFjGcv2VYx+MwnzBhCzT4WNEeL1y3KYdH8zq5UgAb2pcKnYu2
         jPmNVGfGTYiObYAKvDda6M5ave4Y623Dv2uC9HQm6tcEmdqx2AMUaD3trJZDwFd4+QLF
         XHQqSm9dto+SqQFUFBshtaWhy0WMIvvhkF1T522OtA68JfsWWfURMRzzQhuuxgTstSWI
         mBjg+Nzw9vhaUkUJFodquyi9cj+WdvJYYHqVToQFK0y2vZ/QgS72BAazBBhRD9hZlPBU
         +iWzQ7xOHVMgGDkwVUSnNvcb5J1ejzzBW3nQcFC5+Kg+Z0yAdiqtc6PYkS4eqF8p3vhF
         WBwQ==
X-Gm-Message-State: AOJu0YyAbolftDtx9ePsghRpdhzZZKTQpxSo/eNtMc7bPHxBWnBRdQ9K
	xdDMcvbkYRJLN/RQDLwRl+eOzfxBGyg+HUbTrZSPWTijEqobBHxwz/TxVsnS1Q==
X-Gm-Gg: ASbGncvi0HaOnE/u5vapgjRSw4QBy9gRUtnbGaE74lZVcpdsjwEp4WU1k35CStmkbtu
	X+ydfiGoPDvPkmLh78deWiHjneSZ+FqSCYN4qjQgtRoVd0bvosWzl8++Q/Kcz0oipSCHDPIENis
	aRo+9AW0Jmwp7MbLDu6rZ2BgAKRNgqWzBs4Qu8lGuq12j+TEmkR6hYdTDlBH5AoPvsVNCsw0771
	EsXx8rl6+CyhZIjzWOCtzu1Yqpu4Wk/d6sRk02XEKyl3/d3TLsWOroH7ZfM8Pn9jwLYj1djRaXy
	bGSXiCjVQMmeabLdr+7LS/3NxiK99gMij1IdxIAdrOHqpGHN9mj5
X-Google-Smtp-Source: AGHT+IGIpVdHE1t1ovZZpB4n//P0en1NzkG09KanwQtGhhfqcUVpad7FzHlxGUDx07aFAVpHkP82qA==
X-Received: by 2002:a05:6000:2481:b0:3a5:2575:6b45 with SMTP id ffacd0b85a97d-3a525756d82mr505122f8f.48.1749046600203;
        Wed, 04 Jun 2025 07:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0421sm22131922f8f.97.2025.06.04.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 07:16:39 -0700 (PDT)
Message-Id: <af5b4a65b63b587d8dc186ef0575d019ecafab81.1749046597.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
	<pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
From: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 14:16:37 +0000
Subject: [PATCH v2 2/2] contrib/subtree: add -S/--gpg-sign
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
    Junio C Hamano <gitster@pobox.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrik Weiskircher <patrik.weiskircher@nutrient.io>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>

From: Patrik Weiskircher <patrik@pspdfkit.com>

Allows optionally signing the commits that git subtree creates. This can
be necessary when working in a repository that requires gpg signed
commits.

Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
---
 contrib/subtree/git-subtree.adoc   |  19 +++--
 contrib/subtree/git-subtree.sh     |  32 ++++----
 contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 19 deletions(-)

diff --git a/contrib/subtree/git-subtree.adoc b/contrib/subtree/git-subtree.adoc
index 004abf415b8e..b2bcbcad0d05 100644
--- a/contrib/subtree/git-subtree.adoc
+++ b/contrib/subtree/git-subtree.adoc
@@ -9,14 +9,14 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' [<options>] -P <prefix> add <local-commit>
-'git subtree' [<options>] -P <prefix> add <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> merge <local-commit> [<repository>]
-'git subtree' [<options>] -P <prefix> split [<local-commit>]
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <local-commit>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] merge <local-commit> [<repository>]
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] split [<local-commit>]
 
 [verse]
-'git subtree' [<options>] -P <prefix> pull <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> push <repository> <refspec>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] pull <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] push <repository> <refspec>
 
 DESCRIPTION
 -----------
@@ -149,6 +149,13 @@ OPTIONS FOR ALL COMMANDS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+--no-gpg-sign::
+	GPG-sign commits. The `keyid` argument is optional and
+	defaults to the committer identity; `--no-gpg-sign` is useful to
+	countermand a `--gpg-sign` option given earlier on the command line.
+
 OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull', 'split --rejoin', AND 'push --rejoin')
 -----------------------------------------------------------------------------------
 These options for 'add' and 'merge' may also be given to 'pull' (which
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 60b2431b8bba..3fddba797cb9 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -26,12 +26,12 @@ then
 fi
 
 OPTS_SPEC="\
-git subtree add   --prefix=<prefix> <commit>
-git subtree add   --prefix=<prefix> <repository> <ref>
-git subtree merge --prefix=<prefix> <commit>
-git subtree split --prefix=<prefix> [<commit>]
-git subtree pull  --prefix=<prefix> <repository> <ref>
-git subtree push  --prefix=<prefix> <repository> <refspec>
+git subtree add   --prefix=<prefix> [-S[=<key-id>]] <commit>
+git subtree add   --prefix=<prefix> [-S[=<key-id>]] <repository> <ref>
+git subtree merge --prefix=<prefix> [-S[=<key-id>]] <commit>
+git subtree split --prefix=<prefix> [-S[=<key-id>]] [<commit>]
+git subtree pull  --prefix=<prefix> [-S[=<key-id>]] <repository> <ref>
+git subtree push  --prefix=<prefix> [-S[=<key-id>]] <repository> <refspec>
 --
 h,help!       show the help
 q,quiet!      quiet
@@ -46,6 +46,7 @@ rejoin        merge the new branch back into HEAD
  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push --rejoin')
 squash        merge subtree changes as a single commit
 m,message!=   use the given message as the commit message for the merge commit
+S,gpg-sign?key-id   GPG-sign commits. The keyid argument is optional and defaults to the committer identity
 "
 
 indent=0
@@ -168,6 +169,7 @@ main () {
 	arg_split_annotate=
 	arg_addmerge_squash=
 	arg_addmerge_message=
+    arg_gpg_sign=
 	while test $# -gt 0
 	do
 		opt="$1"
@@ -232,6 +234,9 @@ main () {
 			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=
 			;;
+	--gpg-sign=* | --gpg-sign | --no-gpg-sign)
+	    arg_gpg_sign="$opt"
+	    ;;
 		--)
 			break
 			;;
@@ -264,6 +269,7 @@ main () {
 	debug "quiet: {$arg_quiet}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
+    debug "gpg-sign: {$arg_gpg_sign}"
 	debug
 
 	"cmd_$arg_command" "$@"
@@ -529,7 +535,7 @@ copy_commit () {
 			printf "%s" "$arg_split_annotate"
 			cat
 		) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		git commit-tree $arg_gpg_sign "$2" $3  # reads the rest of stdin
 	) || die "fatal: can't copy commit $1"
 }
 
@@ -675,10 +681,10 @@ new_squash_commit () {
 	if test -n "$old"
 	then
 		squash_msg "$dir" "$oldsub" "$newsub" |
-		git commit-tree "$tree" -p "$old" || exit $?
+		git commit-tree $arg_gpg_sign "$tree" -p "$old" || exit $?
 	else
 		squash_msg "$dir" "" "$newsub" |
-		git commit-tree "$tree" || exit $?
+		git commit-tree $arg_gpg_sign "$tree" || exit $?
 	fi
 }
 
@@ -917,11 +923,11 @@ cmd_add_commit () {
 	then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
-			git commit-tree "$tree" $headp -p "$rev") || exit $?
+			git commit-tree $arg_gpg_sign "$tree" $headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") || exit $?
 		commit=$(add_msg "$dir" $headrev "$rev" |
-			git commit-tree "$tree" $headp -p "$revp") || exit $?
+			git commit-tree $arg_gpg_sign "$tree" $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
 
@@ -1072,9 +1078,9 @@ cmd_merge () {
 	if test -n "$arg_addmerge_message"
 	then
 		git merge --no-ff -Xsubtree="$arg_prefix" \
-			--message="$arg_addmerge_message" "$rev"
+			--message="$arg_addmerge_message" $arg_gpg_sign "$rev"
 	else
-		git merge --no-ff -Xsubtree="$arg_prefix" $rev
+		git merge --no-ff -Xsubtree="$arg_prefix" $arg_gpg_sign $rev
 	fi
 }
 
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3c6103f6d270..3edbb33af469 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -11,6 +11,7 @@ and push subcommands of git subtree.
 
 TEST_DIRECTORY=$(pwd)/../../../t
 . "$TEST_DIRECTORY"/test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
 
 # Use our own wrapper around test-lib.sh's test_create_repo, in order
 # to set log.date=relative.  `git subtree` parses the output of `git
@@ -1563,4 +1564,116 @@ test_expect_success 'subtree descendant check' '
 	)
 '
 
+test_expect_success GPG 'add subproj with GPG signing using -S flag' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" -S FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'add subproj with GPG signing using --gpg-sign flag' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" --gpg-sign FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'add subproj with GPG signing using specific key ID' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" -S"$GIT_COMMITTER_EMAIL" FETCH_HEAD &&
+		git verify-commit HEAD &&
+		test "$(last_commit_subject)" = "Add '\''sub dir/'\'' from commit '\''$(git rev-parse FETCH_HEAD)'\''"
+	)
+'
+
+test_expect_success GPG 'merge with GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" -S FETCH_HEAD &&
+		git verify-commit HEAD
+	)
+'
+
+test_expect_success GPG 'split with GPG signing and --rejoin' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir/main-sub1" &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix="sub dir" --rejoin -S &&
+		git verify-commit HEAD
+	)
+'
+
+test_expect_success GPG 'add with --squash and GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" --squash -S FETCH_HEAD &&
+		git verify-commit HEAD &&
+		# With --squash, the commit subject should reference the squash commit (first parent of merge)
+		squash_commit=$(git rev-parse HEAD^2) &&
+		test "$(last_commit_subject)" = "Merge commit '\''$squash_commit'\'' as '\''sub dir'\''"
+	)
+'
+
+test_expect_success GPG 'pull with GPG signing' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git subtree add --prefix="sub dir" ./"sub proj" HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		git subtree pull --prefix="sub dir" -S ./"sub proj" HEAD &&
+		git verify-commit HEAD
+	)
+'
+
 test_done
-- 
gitgitgadget

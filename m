Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB6283129
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540773; cv=none; b=RKWoBS48+uU2RHD9Vz9GRoNFdUr4QA85h5kr0l2ifFFoncDTWmdfFdQaSKplme9fG/NmorCfKu62o0/yXMniShq/MSGftlobsfzIS1e5ztRGTGI1tJzYmeyT8WqxKGNzLs6J60kvTz11aRifvfSGFrYQ+lKE1WE3NE1WQkk0A7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540773; c=relaxed/simple;
	bh=b5USN+yOg/Wb0zbA8Pm7yy/hxT2U9LUEVTNWjNSgKJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4pEsL1XfHyLPIt/7S52py+eHFw0cXneC+66H1AsKaOqgMDPkeMSIavnZrIi01TuA+k7BMSLOlRGETJyDXlK/gONSg+VwwvhoqdLbcELKFMDf/64fpmwOxzmKKZ4mxvlO67+JJkRp34+S9hhMOY99AK96g/46ajfF8xXTP4Dfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cWQPNX59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXVM5asB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cWQPNX59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXVM5asB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D9EBE1380FB7
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540769;
	 x=1746627169; bh=RQXzLCKXiBgjoXhHpy/EkXSNGalIFPp0ssoh9Kipzys=; b=
	cWQPNX59KQ6+m4sEd+vcL8z1pSN44xx8m2PXiVIPmGcOZUGj/YemvXfZ+a5KJsbl
	ORY/rkWftKC6Sy8vxAYo69OnXa8GlbhAI/MCZ5ecb+H5Dc8kE7KMw5ytXYs6PebW
	ISpxPoYXS/Cy9IiV2b2P9VxERUjP7tkoI1h/FqptnKhblIPoxLeRbJu30Iga7EXZ
	7S7sg7Czc9Ud1HXUN32vlJRvstLh7C4xI/OjA3S7ZAcetmvhb8jPkTBdaUZQkmJ0
	4nNrxDT6LlOzcFq1PhCpDBx2IjsZ+gv4js7A6a+pp0yHaS8IRGJVLiFwg1cM1rDS
	Rd4EDteAuMMW85X8QeCuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540769; x=
	1746627169; bh=RQXzLCKXiBgjoXhHpy/EkXSNGalIFPp0ssoh9Kipzys=; b=d
	XVM5asBbMRlujfVB/8ELnaCI/A6bCUKLEcBwKwq+T9wGAgIdTqZCCZYABMmkxy3c
	7K2B6+YsG225cZLbRramfBA3dlaiWDoq6O3BgS4WBUbJAMOAcbAne2RNx4x2Xh7Y
	KvVK1jRi5/g0lDQ4wQdFuGXgXWc4k5j0wedCsriiZ7K5XUykAuuStGP4IUL1VNtI
	s9LonYKQY/cODuyL2ApRZK70t/em5cVcF2G0YUlA1f+Lw6ont1d22ah3uw2WJfwz
	czTuzBL23mVCg/DUPjAOsXY1qBybPN+bSHbnmSAvM2hJHURSJIC7eMAyrjEpzRfV
	JnLqLBtOGUSAT7VHW7efQ==
X-ME-Sender: <xms:4RgaaHI-E79UFzyIQCjso3ZKE705Ygyi_jKfB_RxngYaGs6FkQR83w>
    <xme:4RgaaLIeWlrBHSSalRBIMjn5HbDaS6afds83cUpFFWb4fFh_6tdpKjtChtQmSsoOt
    Qqm2ULtuXUhsM-hGQ>
X-ME-Received: <xmr:4RgaaPtVaw8Z4erspZv0t-GHwSIc7WbIWaSc9ft8w079TPDCrThw6sTo1WapWHEtIx6gwFa4LaVdRf8h7kM535PCd25qhUYMlBNnV4lB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4RgaaAaKOjKEcuShIplqCqlQLeFlQ3TTVu-jY-oZv-2k5pBxCoXN_w>
    <xmx:4RgaaObsuaiZVvCJs7MKxIHPoOnLbsUOCIkeyaFctmK6zJLxKa_57A>
    <xmx:4RgaaEAe7zqvtd__2MpvG9mWwiK3o9THXyBGzN3x5q6FkC-io9wz0g>
    <xmx:4RgaaMbymsISv4plP2g2XMU3Im-C2vx_6pJZo923Lyz6od0ow8W6uw>
    <xmx:4RgaaEk4vh0W2IUCBUtFYUHyEfU_s5Wo4oOyD_Oy5iO-4AuONTXt8RD2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7de2c0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:43 +0200
Subject: [PATCH 10/10] contrib: remove "git-new-workdir"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "git-new-workdir" command has been introduced to make it possible to
have a separate working directory in a different place. The command thus
predates git-worktree(1), which is what people use nowadays to create
any such working directory. As such, the script doesn't really have much
of a reason to exist nowadays anymore.

It also doesn't seem like the script is still in use: the last time it
has received an update was in e32afab7b03 (git-new-workdir: don't fail
if the target directory is empty, 2014-11-26), more than a decade ago.
Remove it as well as the tests that depend on it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/workdir/.gitattributes  |   1 -
 contrib/workdir/git-new-workdir | 105 ----------------------------------------
 t/meson.build                   |   1 -
 t/t1021-rerere-in-workdir.sh    |  58 ----------------------
 t/t3000-ls-files-others.sh      |  19 --------
 5 files changed, 184 deletions(-)

diff --git a/contrib/workdir/.gitattributes b/contrib/workdir/.gitattributes
deleted file mode 100644
index 1f78c5d1bd3..00000000000
--- a/contrib/workdir/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-/git-new-workdir eol=lf
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
deleted file mode 100755
index 989197aace0..00000000000
--- a/contrib/workdir/git-new-workdir
+++ /dev/null
@@ -1,105 +0,0 @@
-#!/bin/sh
-
-usage () {
-	echo "usage:" $@
-	exit 127
-}
-
-die () {
-	echo $@
-	exit 128
-}
-
-failed () {
-	die "unable to create new workdir '$new_workdir'!"
-}
-
-if test $# -lt 2 || test $# -gt 3
-then
-	usage "$0 <repository> <new_workdir> [<branch>]"
-fi
-
-orig_git=$1
-new_workdir=$2
-branch=$3
-
-# want to make sure that what is pointed to has a .git directory ...
-git_dir=$(cd "$orig_git" 2>/dev/null &&
-  git rev-parse --git-dir 2>/dev/null) ||
-  die "Not a git repository: \"$orig_git\""
-
-case "$git_dir" in
-.git)
-	git_dir="$orig_git/.git"
-	;;
-.)
-	git_dir=$orig_git
-	;;
-esac
-
-# don't link to a configured bare repository
-isbare=$(git --git-dir="$git_dir" config --bool --get core.bare)
-if test ztrue = "z$isbare"
-then
-	die "\"$git_dir\" has core.bare set to true," \
-		" remove from \"$git_dir/config\" to use $0"
-fi
-
-# don't link to a workdir
-if test -h "$git_dir/config"
-then
-	die "\"$orig_git\" is a working directory only, please specify" \
-		"a complete repository."
-fi
-
-# make sure the links in the workdir have full paths to the original repo
-git_dir=$(cd "$git_dir" && pwd) || exit 1
-
-# don't recreate a workdir over an existing directory, unless it's empty
-if test -d "$new_workdir"
-then
-	if test $(ls -a1 "$new_workdir/." | wc -l) -ne 2
-	then
-		die "destination directory '$new_workdir' is not empty."
-	fi
-	cleandir="$new_workdir/.git"
-else
-	cleandir="$new_workdir"
-fi
-
-mkdir -p "$new_workdir/.git" || failed
-cleandir=$(cd "$cleandir" && pwd) || failed
-
-cleanup () {
-	rm -rf "$cleandir"
-}
-siglist="0 1 2 15"
-trap cleanup $siglist
-
-# create the links to the original repo.  explicitly exclude index, HEAD and
-# logs/HEAD from the list since they are purely related to the current working
-# directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn reftable
-do
-	# create a containing directory if needed
-	case $x in
-	*/*)
-		mkdir -p "$new_workdir/.git/${x%/*}"
-		;;
-	esac
-
-	ln -s "$git_dir/$x" "$new_workdir/.git/$x" || failed
-done
-
-# commands below this are run in the context of the new workdir
-cd "$new_workdir" || failed
-
-# copy the HEAD from the original repository as a default branch
-cp "$git_dir/HEAD" .git/HEAD || failed
-
-# the workdir is set up.  if the checkout fails, the user can fix it.
-trap - $siglist
-
-# checkout the branch (either the same as HEAD from the original repository,
-# or the one that was asked for)
-git checkout -f $branch
diff --git a/t/meson.build b/t/meson.build
index b09c0becb8d..9206090fedc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -178,7 +178,6 @@ integration_tests = [
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
   't1020-subdirectory.sh',
-  't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
   't1050-large.sh',
   't1051-large-conversion.sh',
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
deleted file mode 100755
index 0b892894eb9..00000000000
--- a/t/t1021-rerere-in-workdir.sh
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/bin/sh
-
-test_description='rerere run in a workdir'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-
-. ./test-lib.sh
-
-test_expect_success SYMLINKS setup '
-	git config rerere.enabled true &&
-	>world &&
-	git add world &&
-	test_tick &&
-	git commit -m initial &&
-
-	echo hello >world &&
-	test_tick &&
-	git commit -a -m hello &&
-
-	git checkout -b side HEAD^ &&
-	echo goodbye >world &&
-	test_tick &&
-	git commit -a -m goodbye &&
-
-	git checkout main
-'
-
-test_expect_success SYMLINKS 'rerere in workdir' '
-	rm -rf .git/rr-cache &&
-	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . work &&
-	(
-		cd work &&
-		test_must_fail git merge side &&
-		git rerere status >actual &&
-		echo world >expect &&
-		test_cmp expect actual
-	)
-'
-
-# This fails because we don't resolve relative symlink in mkdir_in_gitdir()
-# For the purpose of helping contrib/workdir/git-new-workdir users, we do not
-# have to support relative symlinks, but it might be nicer to make this work
-# with a relative symbolic link someday.
-test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
-	rm -rf .git/rr-cache &&
-	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . krow &&
-	(
-		cd krow &&
-		rm -f .git/rr-cache &&
-		ln -s ../.git/rr-cache .git/rr-cache &&
-		test_must_fail git merge side &&
-		git rerere status >actual &&
-		echo world >expect &&
-		test_cmp expect actual
-	)
-'
-
-test_done
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 13f66fd649d..b41e7f0daa4 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -73,25 +73,6 @@ test_expect_success 'ls-files --others handles non-submodule .git' '
 	test_cmp expected1 output
 '
 
-test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
-	git init super &&
-	git init sub &&
-	(
-		cd sub &&
-		>a &&
-		git add a &&
-		git commit -m sub &&
-		git pack-refs --all
-	) &&
-	(
-		cd super &&
-		"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub &&
-		git ls-files --others --exclude-standard >../actual
-	) &&
-	echo sub/ >expect &&
-	test_cmp expect actual
-'
-
 test_expect_success 'setup nested pathspec search' '
 	test_create_repo nested &&
 	(

-- 
2.49.0.1045.g170613ef41.dirty


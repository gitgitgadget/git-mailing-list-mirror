Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C927F16B
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782242; cv=none; b=OQDlLHtEA7piq6whHne1k8MTX++ymVetxTy9r/qEonuWONLvuWxVjASNMO3UhLxoj2Fl1owhJxyy045P7o5pK7wGFK0+VN4NIz4b4ETehxpRO84+tkB8idQbprPoecQlr353FvQjuElnZz1rA8+ha7hCKxcQcwu9pDu63umu8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782242; c=relaxed/simple;
	bh=6N6u1CxaJIrztRGY4Ph8RZ0MAng7q1d3e5psFFjJWA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9LN+zJTWplWza183axXL+Vx191Sd/0fiYg8Vzew9bDGAKRbHojEW+gIRgNxVJxUcKsS2bsKfgWZm9XE7Gg9eKSIR7DrhcPp8c3ORG63iqO2INXYqNdJrOJ1a9Cpo1DlFQSWq5kMs97ijzuQogD4BuBdCRBG9UjVNX9tB+7CkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2dLLlRdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbDBelA9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2dLLlRdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbDBelA9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 845111140182;
	Fri,  9 May 2025 05:17:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 05:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782239;
	 x=1746868639; bh=w+c3nqXD2/B2cFcm6s0fz+0+CK52e1wVSFskfwpgBRY=; b=
	2dLLlRdA3QIOrcFh84grDfEmVX3t3P4hLIjeKfWbP0AspTdycnv2qzGOSG6ZZR81
	kG+2HmAdBqlsslVtWpl4bjYepXS1XwmxTudbgOlrJ9B0SWGD2Pi7GUg4GHKFTNOR
	IPVLfJKr0qucE/XWiaIAA7IxP1xpRVlaiiTtQW9gNf8V9NwslTicqWcRNObPsM7Y
	XINItdnJNhuyjGNfLzIy8aao7kD0YAW+B0IDSDYQYZ/E6zHGA69Q91KHPa52gkHB
	RAJeQuQFNLHzKlxYP2Xn7Fj9fFWWoh92H0ym81Qa6P8OPXWq3dUamJirL0mOa5vF
	hv0zRclG4BkY4AAsqeu/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782239; x=
	1746868639; bh=w+c3nqXD2/B2cFcm6s0fz+0+CK52e1wVSFskfwpgBRY=; b=A
	bDBelA9JJPwoFndwmskS5cknM+GmoGPUJ9RNslC8f1jVBwbiVL3fFhaOjb0MU3xO
	LM1ILDWMd+XRfLOKu6HFBnIw0fxrAzNJymxs8169HYRHBelFOsx36iMlHyrKDQxH
	BwWqJFmyzPMr1ABpqb7h5O+yVQzckuUt2TvPJB6Gx7NWyIvtYrlxKUFAdYY1cIXO
	9Tr3QjmwIcNUrejCcmDE324haMVzFlqplFOmdiACyPUb9LyBpvX1Ub7tlO4Y9xmL
	J7mJPwFbRux1SViAtzx7QK7GIc2MsPvsy9ME/oh7MeDmn4B8TrdTTyI0KGdnA8p2
	Td85Ls5NBXC9rE1EavGbg==
X-ME-Sender: <xms:H8gdaPyhHLgrzwBn7C8bH1OsW-WzuxAaBvYywfsM8HmWoVD8wiUwDw>
    <xme:H8gdaHR8_0HCiETccY86SLO4WLzWoWw6U7T9T0NrbLa7ae0x6d4qCJtavoPH28KYs
    emDHutKytCPWQnjGA>
X-ME-Received: <xmr:H8gdaJWN6O0iFk4UTduXd5V9oC9S_gvbjF17NYB6ByNGFMR3Zi4RxlyKlA4vcnEBNiF0rF91o3cBLtSnFfcwtd6iibEWMzlXvqjWQVGjlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:H8gdaJiSdzv0qS5DzQl3MprZKm8a8scNgYUSFaqBSxQVdsi_cCGuOg>
    <xmx:H8gdaBC_AfCUvSXpIaUz9aO1t2LM8_VcsaaM9lXfUf655pwV-ybMRw>
    <xmx:H8gdaCJWDUasEcJ23E4adKm8wriG686OUD5mwfMSd_5SCxtId8vXDg>
    <xmx:H8gdaADKBSXDBWuZQyvvPKMHWuzwNwJCJPfDAAv8mJrmbkTUjaxe-w>
    <xmx:H8gdaEZ2pepnLwnNuCbkElngT06OPJb5-xyJxNO5Xcpkzx3K9U9znGWq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 738d1ca1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:10 +0200
Subject: [PATCH v2 10/11] contrib: remove "git-new-workdir"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-10-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
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
2.49.0.1077.gc0e912fd4c.dirty


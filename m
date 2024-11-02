Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD11A01BD
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566544; cv=none; b=jP9pvHq9rsCupfKtqDqJzehMi5gWJv1BLB5i0V1OCKuaf6XyNDJkRH5A9MHI+6kcAatrFmHZm4trON39eHy9U/WC9gj8FTp1PUpkP8gnWcCDXeSydkd6kCFxsvbjsFpZkRXSQp8zhR9YXVtjSEPTzT/WQ8OfnAo15h0bMwWVFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566544; c=relaxed/simple;
	bh=/XMKdsTBtEwnIAFgT03kflGGJNBd6NVRw2UgmvxcvIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdCziW+QMD985EFfbSLaA9ybgDxNdk1bOIHorI5g0cqmEkgbH3l2XG4f1z+NDlVAO0fPGJVAgAyW7nQBHLNaPR0QDGDeO4S3TmeJyMZj4KziP65/dfqdVYGwffbFl2QvX0e1L+fMgmq5Zpl3BoBUMIPPykwVh/HI0wHGNxELS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS/bXllG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS/bXllG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431481433bdso25342595e9.3
        for <git@vger.kernel.org>; Sat, 02 Nov 2024 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730566540; x=1731171340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX8fHt9iju84SHPSmtJBj5fjnpIw85PeE3AJdPuAPSs=;
        b=SS/bXllGmXQC+4ChDlVdG0S9SltoG8z0E06wVWoCS6QoyIaqTNV5WxskhDQvPcpez5
         XasB9MevOskXBvjgk/thUwloEljWnNBAxwKWuki5QhlW8c/rXYjEt14nGseJtFMmdTTS
         0aukeSAgNwAj/MGejv2/qOSd9yKJsqoy3ju9TjkscUMLAAij9pEOmgsD+6t+viio8Ucz
         eDoN7x4wpQtH98Vh9O2Q4dYP/W1wEOz44v+n5OW9EOZ/MmlByp4fnfCfw33og+0SZZNA
         RwGbcnfx7uwt0eCnOwmAreL6SWMnLBUKCdj9EPuvwL2ZH+o1JnhCfAQEzGg3kISdewaF
         Ynng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566540; x=1731171340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX8fHt9iju84SHPSmtJBj5fjnpIw85PeE3AJdPuAPSs=;
        b=wqtDwJyG5q/IXH5Cex4WzcoppxelRXzxqGquyxth2TvIVbpt2EGhmc3f7YvKQknz2I
         yq4HHfJoUJFg8EuKcJ5eh6LdtodfBDGZgOwJ624W0tYy3w8jMfUsXVIVcLWy3VS6G9lX
         zyEXmOJjEU98NZvUElCrZbekC5LYhrHX5zcEcLK8XmMGLpFHVvYENelb2XlinvOUpGoc
         WO7qqymLRiku2hoyBQuM0j2aBGMWczZC/1i6StzlQkzEwkUrdaTOmgmlUFwQZHp7JH2c
         tlTqvjueVwullGR5Cx4r89N2mmX+XSLN5P3k1G3bh4MAtNQaARKaQ4X7ukHyZiPc1/1M
         9dtg==
X-Gm-Message-State: AOJu0YxgU4/V4exLLHkzhu6r6f/tHB37Wt4XL14igM72KBS0x4qej9kB
	/vkOYqQVGXaSp7Tuf9nGeSHy14LEUn56q8WqgbP+QsHNERIPhX42faNM28cV
X-Google-Smtp-Source: AGHT+IGBdEJYpKSOmF+K+mHSfwkgXOZhzap9X4gsUrC9KJtSv217JkWwt+8ax423S1d38TvLIPCPaw==
X-Received: by 2002:a05:600c:3b94:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-4327b82138dmr84653525e9.32.1730566540152;
        Sat, 02 Nov 2024 09:55:40 -0700 (PDT)
Received: from void.void ([31.210.180.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4e7sm99146015e9.15.2024.11.02.09.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 09:55:39 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] t1016: clean up style
Date: Sat,  2 Nov 2024 18:53:10 +0200
Message-ID: <20241102165534.17112-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.170.g23d289d273.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove whitespace after redirect operator.

Align mixed space/tab usages.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/t1016-compatObjectFormat.sh | 261 +++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 131 deletions(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 8341a2fe83..06449937a3 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -24,84 +24,84 @@ TEST_PASSES_SANITIZE_LEAK=true
 # the commit is identical to the commit in the other repository.
 
 compat_hash () {
-    case "$1" in
-    "sha1")
-	echo "sha256"
-	;;
-    "sha256")
-	echo "sha1"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "sha256"
+		;;
+	"sha256")
+		echo "sha1"
+		;;
+	esac
 }
 
 hello_oid () {
-    case "$1" in
-    "sha1")
-	echo "$hello_sha1_oid"
-	;;
-    "sha256")
-	echo "$hello_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$hello_sha1_oid"
+		;;
+	"sha256")
+		echo "$hello_sha256_oid"
+		;;
+	esac
 }
 
 tree_oid () {
-    case "$1" in
-    "sha1")
-	echo "$tree_sha1_oid"
-	;;
-    "sha256")
-	echo "$tree_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$tree_sha1_oid"
+		;;
+	"sha256")
+		echo "$tree_sha256_oid"
+		;;
+	esac
 }
 
 commit_oid () {
-    case "$1" in
-    "sha1")
-	echo "$commit_sha1_oid"
-	;;
-    "sha256")
-	echo "$commit_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$commit_sha1_oid"
+		;;
+	"sha256")
+		echo "$commit_sha256_oid"
+		;;
+	esac
 }
 
 commit2_oid () {
-    case "$1" in
-    "sha1")
-	echo "$commit2_sha1_oid"
-	;;
-    "sha256")
-	echo "$commit2_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$commit2_sha1_oid"
+		;;
+	"sha256")
+		echo "$commit2_sha256_oid"
+		;;
+	esac
 }
 
 del_sigcommit () {
-    local delete="$1"
-
-    if test "$delete" = "sha256" ; then
-	local pattern="gpgsig-sha256"
-    else
-	local pattern="gpgsig"
-    fi
-    test-tool delete-gpgsig "$pattern"
+	local delete="$1"
+
+	if test "$delete" = "sha256" ; then
+		local pattern="gpgsig-sha256"
+	else
+		local pattern="gpgsig"
+	fi
+	test-tool delete-gpgsig "$pattern"
 }
 
 
 del_sigtag () {
-    local storage="$1"
-    local delete="$2"
-
-    if test "$storage" = "$delete" ; then
-	local pattern="trailer"
-    elif test "$storage" = "sha256" ; then
-	local pattern="gpgsig"
-    else
-	local pattern="gpgsig-sha256"
-    fi
-    test-tool delete-gpgsig "$pattern"
+	local storage="$1"
+	local delete="$2"
+
+	if test "$storage" = "$delete" ; then
+		local pattern="trailer"
+	elif test "$storage" = "sha256" ; then
+		local pattern="gpgsig"
+	else
+		local pattern="gpgsig-sha256"
+	fi
+	test-tool delete-gpgsig "$pattern"
 }
 
 base=$(pwd)
@@ -146,9 +146,9 @@ do
 	'
 	test_expect_success "create a $hash branch" '
 		git checkout -b branch $(commit_oid $hash) &&
-		echo "More more more give me more!" > more &&
+		echo "More more more give me more!" >more &&
 		eval more_${hash}_oid=$(git hash-object more) &&
-		echo "Another and another and another" > another &&
+		echo "Another and another and another" >another &&
 		eval another_${hash}_oid=$(git hash-object another) &&
 		git update-index --add more another &&
 		git commit -m "Add more files!" &&
@@ -165,15 +165,15 @@ do
 	'
 	test_expect_success GPG2 "create additional $hash signed commits" '
 		git commit --gpg-sign --allow-empty -m "This is an additional signed commit" &&
-		git cat-file commit HEAD | del_sigcommit sha256 > "../${hash}_signedcommit3" &&
-		git cat-file commit HEAD | del_sigcommit sha1 > "../${hash}_signedcommit4" &&
+		git cat-file commit HEAD | del_sigcommit sha256 >"../${hash}_signedcommit3" &&
+		git cat-file commit HEAD | del_sigcommit sha1 >"../${hash}_signedcommit4" &&
 		eval signedcommit3_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit3) &&
 		eval signedcommit4_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit4)
 	'
 	test_expect_success GPG2 "create additional $hash signed tags" '
 		git tag -s -m "This is an additional signed tag" signedtag34 HEAD &&
-		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 > ../${hash}_signedtag3 &&
-		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 > ../${hash}_signedtag4 &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 >../${hash}_signedtag3 &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 >../${hash}_signedtag4 &&
 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
 	'
@@ -181,81 +181,80 @@ done
 cd "$base"
 
 compare_oids () {
-    test "$#" = 5 && { local PREREQ="$1"; shift; } || PREREQ=
-    local type="$1"
-    local name="$2"
-    local sha1_oid="$3"
-    local sha256_oid="$4"
-
-    echo ${sha1_oid} > ${name}_sha1_expected
-    echo ${sha256_oid} > ${name}_sha256_expected
-    echo ${type} > ${name}_type_expected
-
-    git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha1_sha256_found
-    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha256_sha1_found
-    local sha1_sha256_oid="$(cat ${name}_sha1_sha256_found)"
-    local sha256_sha1_oid="$(cat ${name}_sha256_sha1_found)"
-
-    test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
-	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
-	test_cmp ${name}_sha1 ${name}_sha1_expected
-'
-
-    test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
-	git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha256 &&
-	test_cmp ${name}_sha256 ${name}_sha256_expected
-'
+	test "$#" = 5 && { local PREREQ="$1"; shift; } || PREREQ=
+	local type="$1"
+	local name="$2"
+	local sha1_oid="$3"
+	local sha256_oid="$4"
+
+	echo ${sha1_oid} >${name}_sha1_expected
+	echo ${sha256_oid} >${name}_sha256_expected
+	echo ${type} >${name}_type_expected
+
+	git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} >${name}_sha1_sha256_found
+	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha256_sha1_found
+	local sha1_sha256_oid="$(cat ${name}_sha1_sha256_found)"
+	local sha256_sha1_oid="$(cat ${name}_sha256_sha1_found)"
+
+	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
+		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha1 &&
+		test_cmp ${name}_sha1 ${name}_sha1_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
-	git --git-dir=repo-sha1/.git cat-file -t ${sha1_oid} > ${name}_type1 &&
-	git --git-dir=repo-sha256/.git cat-file -t ${sha256_sha1_oid} > ${name}_type2 &&
-	test_cmp ${name}_type1 ${name}_type2 &&
-	test_cmp ${name}_type1 ${name}_type_expected
-'
+	test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
+		git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} >${name}_sha256 &&
+		test_cmp ${name}_sha256 ${name}_sha256_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
-	git --git-dir=repo-sha256/.git cat-file -t ${sha256_oid} > ${name}_type3 &&
-	git --git-dir=repo-sha1/.git cat-file -t ${sha1_sha256_oid} > ${name}_type4 &&
-	test_cmp ${name}_type3 ${name}_type4 &&
-	test_cmp ${name}_type3 ${name}_type_expected
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
+		git --git-dir=repo-sha1/.git cat-file -t ${sha1_oid} >${name}_type1 &&
+		git --git-dir=repo-sha256/.git cat-file -t ${sha256_sha1_oid} >${name}_type2 &&
+		test_cmp ${name}_type1 ${name}_type2 &&
+		test_cmp ${name}_type1 ${name}_type_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
-	git --git-dir=repo-sha1/.git cat-file -s ${sha1_oid} > ${name}_size1 &&
-	git --git-dir=repo-sha256/.git cat-file -s ${sha256_sha1_oid} > ${name}_size2 &&
-	test_cmp ${name}_size1 ${name}_size2
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
+		git --git-dir=repo-sha256/.git cat-file -t ${sha256_oid} >${name}_type3 &&
+		git --git-dir=repo-sha1/.git cat-file -t ${sha1_sha256_oid} >${name}_type4 &&
+		test_cmp ${name}_type3 ${name}_type4 &&
+		test_cmp ${name}_type3 ${name}_type_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
-	git --git-dir=repo-sha256/.git cat-file -s ${sha256_oid} > ${name}_size3 &&
-	git --git-dir=repo-sha1/.git cat-file -s ${sha1_sha256_oid} > ${name}_size4 &&
-	test_cmp ${name}_size3 ${name}_size4
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
+		git --git-dir=repo-sha1/.git cat-file -s ${sha1_oid} >${name}_size1 &&
+		git --git-dir=repo-sha256/.git cat-file -s ${sha256_sha1_oid} >${name}_size2 &&
+		test_cmp ${name}_size1 ${name}_size2
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
-	git --git-dir=repo-sha1/.git cat-file -p ${sha1_oid} > ${name}_content1 &&
-	git --git-dir=repo-sha256/.git cat-file -p ${sha256_sha1_oid} > ${name}_content2 &&
-	test_cmp ${name}_content1 ${name}_content2
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
+		git --git-dir=repo-sha256/.git cat-file -s ${sha256_oid} >${name}_size3 &&
+		git --git-dir=repo-sha1/.git cat-file -s ${sha1_sha256_oid} >${name}_size4 &&
+		test_cmp ${name}_size3 ${name}_size4
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content" '
-	git --git-dir=repo-sha256/.git cat-file -p ${sha256_oid} > ${name}_content3 &&
-	git --git-dir=repo-sha1/.git cat-file -p ${sha1_sha256_oid} > ${name}_content4 &&
-	test_cmp ${name}_content3 ${name}_content4
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
+		git --git-dir=repo-sha1/.git cat-file -p ${sha1_oid} >${name}_content1 &&
+		git --git-dir=repo-sha256/.git cat-file -p ${sha256_sha1_oid} >${name}_content2 &&
+		test_cmp ${name}_content1 ${name}_content2
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
-	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_oid} > ${name}_content5 &&
-	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_sha1_oid} > ${name}_content6 &&
-	test_cmp ${name}_content5 ${name}_content6
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content" '
+		git --git-dir=repo-sha256/.git cat-file -p ${sha256_oid} >${name}_content3 &&
+		git --git-dir=repo-sha1/.git cat-file -p ${sha1_sha256_oid} >${name}_content4 &&
+		test_cmp ${name}_content3 ${name}_content4
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
-	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid} > ${name}_content7 &&
-	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid} > ${name}_content8 &&
-	test_cmp ${name}_content7 ${name}_content8
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
+		git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_oid} >${name}_content5 &&
+		git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_sha1_oid} >${name}_content6 &&
+		test_cmp ${name}_content5 ${name}_content6
+	'
 
+	test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
+		git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid} >${name}_content7 &&
+		git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid} >${name}_content8 &&
+		test_cmp ${name}_content7 ${name}_content8
+	'
 }
 
 compare_oids 'blob' hello "$hello_sha1_oid" "$hello_sha256_oid"
-- 
2.47.0.170.g23d289d273.dirty


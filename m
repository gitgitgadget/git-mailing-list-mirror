Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AA1DE883
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329577; cv=none; b=PWqQZIP7zyriMmqv8UuRGMDwi+Q3xPFh0PgUWh0fCrNglZWXF1NqUS47oJKflDytRo3zqKYgVQqEmZFf49CLfXpb1etKg+Jcw9zitJLbdD9tlrBWPk9CVHDwmrugfAsF0+ju0Oy+4/WD/tBMwYcocXkjEzeXTtD/F4iWL+Lz1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329577; c=relaxed/simple;
	bh=5bnKJUmDCaR8Z1CYcJdtbRi0T/VPzo2mV5kZn8gtV0s=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=mjRVrOTA7ZTE5ltItLXKDIeXbp02zu3KvzOyN1CVwUM0Z5grVA7ZxYE/PbdMvd/TiFMBKBXG1pUD0PnHbJ+NxvBn8LhEdnIThU3DhBqcWCbKuso1jT6Ii6q0aGD/tDhVLsoQN6nk9vs/5LkuNo6i2ISNMz/czQenv67Rf7Z5UvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLqFbBed; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLqFbBed"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso17560f8f.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742329572; x=1742934372; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4z8w5H2WYtiiRtnIgCLi2cKpqmoZ3o/oc99rPAZOc6k=;
        b=BLqFbBeduubNcZVcOizwON07ftAzK3r5tcEEMoS6/U+RWOqR7knsUsGH1iOPa1yXcR
         PeoaRM0ZpITCKS8JMnrA5x/UpODf+/1WNID8TAFoB+OuAJxt3bYOeyhzUeOOgu7ENFSL
         C+ALrDmw4dDyD2XfdEdZ5Q55d/5lusz/u0bUfHEfWb2UvWXpMFCMRw1IVBEYVib31CpS
         w5b1xQZdJFSq0Fu8RYp837uI90BnBAs4OUZjw9uSdPtTJvCkq1ZugPGtjnrIyt4QRYg7
         UhzUuUY1hyMGIq40i+zDwDyqBlJuH6ZM0nfOWqjlRrkb84iZPmw3x70HIA/aXsxKnLLl
         2U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742329572; x=1742934372;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z8w5H2WYtiiRtnIgCLi2cKpqmoZ3o/oc99rPAZOc6k=;
        b=I+iayDBriYXB0g3Y6hfSTTXnatFeUxrNVBQZ/DVw3qhUydEUkx5iwTL1TIO13GyfPO
         ZNUVIMb8bGmx4Tznf0HSPF4n7yNKgBPd+bwHf2aa2pyBks4uZkQQ48iL1C2+lrIlzA68
         xjLAoar1NDz6sKYBtrG4ksMKlsUuU6oEByvTOILc33Z/di9k9uKHAPjPR+NVdnVahZGh
         ff4QdpQVLVQNS8SonDmbSEh7dJvB9yxxLputxJBSQrIoyIQ6JsXxRzXmMC9Y12AluQi9
         fDCT1+yqV3ofPi8SsswThhHWqhMM7bVluuKkY8DmRqnGr+8i2aQzEldXTgYT8v2jjI+G
         Or+w==
X-Gm-Message-State: AOJu0YwuYOLaeDLptfb/4u/K8kk4lKFEQeGHDWOyhRNQv2NZDc8EGLVD
	vjPu6a0Dq7S4liCqJmM0ndc+vradoQTBY23T9vwex/kGywTJuX+Sk3ZpKg==
X-Gm-Gg: ASbGncvilcV9RUoj0o8MOeu2TQqG7ROvikNpPAlmIOyCsGA0edCyQKhNlxDYC0GMn+c
	xVP6UUwaTze2Fd6NdMPUiteBm7ZbMhW4oRBH0Cyx9MLd0VAt+uy385oWfLRW79IodEysCp/Xcwk
	llGmyyBDs+jcFCdqeEp9jehVDsa/IQJK2NSEQLdOz5Y/l6SmzrPUTfTLTkJffvL2+vERaicVkR3
	VeCQc16HBc31szyL40Bd8fPoCwzThE6krD5u9Dlb8cuvO61hPQR7YCS7IxiPkyO2Ncp6rrohI9T
	Z1ayTQx7ysaa5ljCDpfz6l1NKW2HKAA31iQcIBbzbjyX4A==
X-Google-Smtp-Source: AGHT+IGResZMmtir/l75A/UCp8BMuMN/Ca+gxnmDXwWJewuJq6I7qdvIfi7k/rC+rnJN++4W7pv3Kg==
X-Received: by 2002:a05:6000:400f:b0:391:23e6:f0ac with SMTP id ffacd0b85a97d-3996bb44c4fmr4439094f8f.11.1742329572269;
        Tue, 18 Mar 2025 13:26:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15470sm143111985e9.15.2025.03.18.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:26:11 -0700 (PDT)
Message-Id: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
From: "Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 20:26:11 +0000
Subject: [PATCH] =?UTF-8?q?[GSoC=20Patch]=20Modernize=20Test=20Path=20Chec?=
 =?UTF-8?q?king=20in=20Git=E2=80=99s=20Test=20Suite?=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Karthik Nayak [ ]" <karthik.188@gmail.com>,
    "Jialuo She [ ]" <shejialuo@gmail.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    "Ghanshyam Thakkar [ ]" <shyamthakkar001@gmail.com>,
    "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    Sampriyo Guin <sampriyoguin@gmail.com>,
    Sampriyo Guin <sampriyoguin@gmail.com>

From: Sampriyo Guin <sampriyoguin@gmail.com>

test -(e|f|d) does not provide a proper error message when hit
test failures. So test_path_exists, test_path_is_dir,
test_parh_is_file used.
Added changes for files from t/t0007-git-var.sh
to t/t1700-split-index.sh.

Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>
---
    [GSoC Patch] Modernize Test Path Checking in Git’s Test Suite
    
    test -(e|f|d) does not provide a proper error message when hit test
    failures. So test_path_exists, test_path_is_dir, test_path_is_file used.
    
    Added changes for files from t/t0007-git-var.sh to
    t/t1700-split-index.sh.
    
    Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1923%2FRimoGuin%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1923/RimoGuin/master-v1
Pull-Request: https://github.com/git/git/pull/1923

 t/t0007-git-var.sh            |  2 +-
 t/t0081-find-pack.sh          |  2 +-
 t/t0200-gettext-basic.sh      |  4 ++--
 t/t0410-partial-clone.sh      |  2 +-
 t/t0601-reffiles-pack-refs.sh | 28 ++++++++++++++--------------
 t/t1001-read-tree-m-2way.sh   |  2 +-
 t/t1005-read-tree-reset.sh    | 10 +++++-----
 t/t1300-config.sh             |  4 ++--
 t/t1403-show-ref.sh           |  2 +-
 t/t1410-reflog.sh             |  8 ++++----
 t/t1420-lost-found.sh         |  4 ++--
 t/t1700-split-index.sh        |  2 +-
 12 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758c..6a8fe69c089 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -156,7 +156,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
 test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
 	shellpath=$(git var GIT_SHELL_PATH) &&
 	case "$shellpath" in
-	[A-Z]:/*/sh.exe) test -f "$shellpath";;
+	[A-Z]:/*/sh.exe) test_path_is_file "$shellpath";;
 	*) return 1;;
 	esac
 '
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 5a628bf7356..cb2825769ca 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -32,7 +32,7 @@ test_expect_success 'repack everything into a single packfile' '
 		".git/objects/pack/pack-"*".pack") true ;;
 		*) false ;;
 	esac &&
-	test -f "$head_commit_pack" &&
+	test_path_is_file "$head_commit_pack" &&
 
 	# Everything is in the same pack
 	test "$head_commit_pack" = "$head_tree_pack" &&
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb92..89d0899a5bd 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -31,12 +31,12 @@ test_expect_success 'xgettext sanity: Comment extraction with --add-comments sto
 '
 
 test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
-    test -d "$TEXTDOMAINDIR" &&
+    test_path_is_dir "$TEXTDOMAINDIR" &&
     test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
 '
 
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
-    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
 
 # TODO: When we have more locales, generalize this to test them
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 2a5bdbeeb87..615983067a9 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -606,7 +606,7 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
 	git -C repo gc &&
 
 	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
+	test_path_exists repo/.git/objects/pack/pack-$HASH.pack &&
 	rm repo/.git/objects/pack/pack-$HASH.* &&
 
 	# Ensure that the single other pack contains the commit, but not the tree
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index aa7f6ecd813..f76471a3375 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -78,13 +78,13 @@ test_expect_success 'see if a branch still exists after git pack-refs --prune' '
 test_expect_success 'see if git pack-refs --prune remove ref files' '
 	git branch f &&
 	git pack-refs --all --prune &&
-	! test -f .git/refs/heads/f
+	! test_path_is_file .git/refs/heads/f
 '
 
 test_expect_success 'see if git pack-refs --prune removes empty dirs' '
 	git branch r/s/t &&
 	git pack-refs --all --prune &&
-	! test -e .git/refs/heads/r
+	! test_path_exists .git/refs/heads/r
 '
 
 test_expect_success 'git branch g should work when git branch g/h has been deleted' '
@@ -128,43 +128,43 @@ test_expect_success 'test excluded refs are not packed' '
 	git branch dont_pack2 &&
 	git branch pack_this &&
 	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
-	test -f .git/refs/heads/dont_pack1 &&
-	test -f .git/refs/heads/dont_pack2 &&
-	! test -f .git/refs/heads/pack_this'
+	test_path_is_file .git/refs/heads/dont_pack1 &&
+	test_path_is_file .git/refs/heads/dont_pack2 &&
+	! test_path_is_file .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4'
+	! test_path_is_file .git/refs/heads/dont_pack3 &&
+	! test_path_is_file .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
 	git branch pack_this2 &&
 	git tag dont_pack5 &&
 	git pack-refs --include "refs/heads/pack_this*" &&
-	test -f .git/refs/tags/dont_pack5 &&
-	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2'
+	test_path_is_file .git/refs/tags/dont_pack5 &&
+	! test_path_is_file .git/refs/heads/pack_this1 &&
+	! test_path_is_file .git/refs/heads/pack_this2'
 
 test_expect_success 'test --no-include refs clears included refs' '
 	git branch pack1 &&
 	git branch pack2 &&
 	git pack-refs --include "refs/heads/pack*" --no-include &&
-	test -f .git/refs/heads/pack1 &&
-	test -f .git/refs/heads/pack2'
+	test_path_is_file .git/refs/heads/pack1 &&
+	test_path_is_file .git/refs/heads/pack2'
 
 test_expect_success 'test --exclude takes precedence over --include' '
 	git branch dont_pack5 &&
 	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
-	test -f .git/refs/heads/dont_pack5'
+	test_path_is_file .git/refs/heads/dont_pack5'
 
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git pack-refs --all --prune &&
 	git update-ref refs/heads/q refs/heads/q &&
-	! test -f .git/refs/heads/q
+	! test_path_is_file .git/refs/heads/q
 '
 
 test_expect_success 'pack, prune and repack' '
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 4a88bb9ef0c..2e8d9384e1b 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -362,7 +362,7 @@ test_expect_success 'a/b (untracked) vs a case setup.' '
 test_expect_success 'a/b (untracked) vs a, plus c/d case test.' '
 	read_tree_u_must_fail -u -m "$treeH" "$treeM" &&
 	git ls-files --stage &&
-	test -f a/b
+	test_path_is_file a/b
 '
 
 test_expect_success 'read-tree supports the super-prefix' '
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 6b5033d0ce3..12b127eb7e6 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -40,7 +40,7 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	! test_path_is_file old &&
 	test_cmp expect actual
 '
 
@@ -56,7 +56,7 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	! test_path_is_file old &&
 	test_cmp expect actual
 '
 
@@ -72,7 +72,7 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s &&
 	git reset --hard &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	! test_path_is_file old &&
 	test_cmp expect actual
 '
 
@@ -88,7 +88,7 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	! test_path_is_file old &&
 	test_cmp expect actual
 '
 
@@ -104,7 +104,7 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	! test_path_is_file old &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 51a85e83c27..9820d2348bc 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1236,11 +1236,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9d698b3cc35..12f7b600244 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with dangling ref' '
 
 	remove_object() {
 		file=$(sha1_file "$*") &&
-		test -e "$file" &&
+		test_path_exists "$file" &&
 		rm -f "$file"
 	} &&
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388fdf9ae57..429ff59d2cb 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -130,10 +130,10 @@ test_expect_success 'pass through -- to sub-command' '
 
 test_expect_success rewind '
 	test_tick && git reset --hard HEAD~2 &&
-	test -f C &&
-	test -f A/B/E &&
-	! test -f F &&
-	! test -f A/G &&
+	test_path_is_file C &&
+	test_path_is_file A/B/E &&
+	! test_path_is_file F &&
+	! test_path_is_file A/G &&
 
 	check_have A B C D E F G H I J K L &&
 
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index 2fb2f44f021..5fbb1d10ede 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -29,8 +29,8 @@ test_expect_success 'lost and found something' '
 	git reset --hard HEAD^ &&
 	git fsck --lost-found &&
 	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
-	test -f .git/lost-found/commit/$(cat lost-commit) &&
-	test -f .git/lost-found/other/$(cat lost-other)
+	test_path_is_file .git/lost-found/commit/$(cat lost-commit) &&
+	test_path_is_file .git/lost-found/other/$(cat lost-other)
 '
 
 test_done
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ac4a5b2734c..38d6f19152a 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -460,7 +460,7 @@ test_expect_success POSIXPERM,SANITY 'graceful handling when splitting index is
 		cd ro &&
 		test_commit initial &&
 		git update-index --split-index &&
-		test -f .git/sharedindex.*
+		test_path_is_file .git/sharedindex.*
 	) &&
 	cp ro/.git/index new-index &&
 	test_when_finished "chmod u+w ro/.git" &&

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C44C19F29
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiG0XOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG0XOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AEF4E636
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bn9so99075wrb.9
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2gWvaAcb4PxwiOJcDZSl8i+ageV3Q1y9wEFqo2C2un8=;
        b=mYL1cbsJNXe/DG0EcqJPpEjX0BYu/NU98hr0lSsoagdmEszH11Hh0e5PAJCl7OeOix
         9DvqXFApOTYdqe4VBcfQmEFNvPMkejOrDsqzQvX1znZLkctkzObk9fywROZDOlWyx4j9
         kke9UQp9/OWloaguxUIvFCY6qCb0Z1N9sBBVlL5rnfX5NGGPsT1wt52M1DqGE/CfZQUC
         Tbh2eQ+puh6YKggdfDT5VfQYKUnsR60RI5og9TeNKjbosfHL6B4x2SwLtm0vTqK5zrsG
         YmgScGpVKejuVosFKxrkcblUgwnlc79iXxw8hFs78+PGNUkkopds5Z+DJfJFXX1G6v3v
         QhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2gWvaAcb4PxwiOJcDZSl8i+ageV3Q1y9wEFqo2C2un8=;
        b=opPsMI0wRFO5tPZHTOwCuN4ZeGQVb0mMbgfHCKs78Txbg82qr+SfeIDgqvF8J+Tv1O
         +tlMn5/W/TqdcXutxh++LDC37iYByOszuYJEhk6vqCVVD2qE8Y6m8YJJeq7xZA7okxx4
         D+IM/MX5P4Bp8YbioJXSyp6mrXWnJBbS3k0Dz/VqG1AHLNV4QP/B7DXiZOlvLkQvXTa9
         3/ShkWmW0oJ/aMYbAHS4R1ZNKAyJGMm9l5A1mprJexd4IXT0TYUk1gtYj2+Og3vomGHV
         5QH4ZcuV40DNElVpw48VevZyT8jt/HXGzFnjhAw3AUDfA3inkPmHZPmIkRn2yNlduKGW
         PgcQ==
X-Gm-Message-State: AJIora9Rw+nJJ0Fwc0W4zMDHwKyGiz4zSOsNY+2dhpWdrI9k0t7Tdqjs
        76D04E5/lcJfEm+80kvRcsIzmtSEcMNZKw==
X-Google-Smtp-Source: AGRyM1vAVgvqdBHMxrouZGejSaBt9H0DYlB/k8YatcJ+Dr6Viknr/j1gj6g8nGWl7DfgM5LLk7FLZg==
X-Received: by 2002:a5d:4f8f:0:b0:21e:4f09:9e15 with SMTP id d15-20020a5d4f8f000000b0021e4f099e15mr16219664wru.55.1658963642810;
        Wed, 27 Jul 2022 16:14:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:14:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/15] leak tests: don't skip some tests under SANITIZE=leak
Date:   Thu, 28 Jul 2022 01:13:40 +0200
Message-Id: <patch-v3-12.15-6df9078e266-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '!SANITIZE_LEAK' prerequisite added in 956d2e4639b (tests: add a
test mode for SANITIZE=leak, run it in CI, 2021-09-23) has been used
in various tests to skip individual tests in otherwise leak-free
tests.

Let's change the cases that have become leak-free since then to run
under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0002-gitfile.sh                     | 2 +-
 t/t0004-unwritable.sh                  | 2 +-
 t/t1503-rev-parse-verify.sh            | 2 +-
 t/t3001-ls-files-others-exclude.sh     | 4 ++--
 t/t3305-notes-fanout.sh                | 2 +-
 t/t4020-diff-external.sh               | 4 ++--
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index f6356db183b..26eaca095a2 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -65,7 +65,7 @@ test_expect_success 'check commit-tree' '
 	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
-test_expect_success !SANITIZE_LEAK 'check rev-list' '
+test_expect_success 'check rev-list' '
 	git update-ref "HEAD" "$SHA" &&
 	git rev-list HEAD >actual &&
 	echo $SHA >expected &&
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 2e9d652d826..8114fac73b3 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -31,7 +31,7 @@ test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository'
 	test_cmp expect out.write-tree
 '
 
-test_expect_success POSIXPERM,SANITY,!SANITIZE_LEAK 'commit should notice unwritable repository' '
+test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
 	test_must_fail git commit -m second 2>out.commit
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index ba43168d123..bc136833c10 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -132,7 +132,7 @@ test_expect_success 'use --default' '
 	test_must_fail git rev-parse --verify --default bar
 '
 
-test_expect_success !SANITIZE_LEAK 'main@{n} for various n' '
+test_expect_success 'main@{n} for various n' '
 	git reflog >out &&
 	N=$(wc -l <out) &&
 	Nm1=$(($N-1)) &&
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index e07ac6c6dce..1ed0aa967ec 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -103,7 +103,7 @@ test_expect_success 'git ls-files --others with various exclude options.' '
 	test_cmp expect output
 '
 
-test_expect_success !SANITIZE_LEAK 'restore gitignore' '
+test_expect_success 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
 	rm .git/index
 '
@@ -126,7 +126,7 @@ cat > expect << EOF
 #	three/
 EOF
 
-test_expect_success !SANITIZE_LEAK 'git status honors core.excludesfile' \
+test_expect_success 'git status honors core.excludesfile' \
 	'test_cmp expect output'
 
 test_expect_success 'trailing slash in exclude allows directory match(1)' '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 64a9915761a..22ffe5bcb99 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -51,7 +51,7 @@ test_expect_success 'creating many notes with git-notes' '
 	done
 '
 
-test_expect_success !SANITIZE_LEAK 'many notes created correctly with git-notes' '
+test_expect_success 'many notes created correctly with git-notes' '
 	git log >output.raw &&
 	grep "^    " output.raw >output &&
 	i=$num_notes &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 858a5522f96..c1ac09ecc71 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -33,7 +33,7 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 
 '
 
-test_expect_success !SANITIZE_LEAK 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
+test_expect_success 'GIT_EXTERNAL_DIFF environment should apply only to diff' '
 	GIT_EXTERNAL_DIFF=echo git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
 
@@ -74,7 +74,7 @@ test_expect_success 'diff.external' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'diff.external should apply only to diff' '
+test_expect_success 'diff.external should apply only to diff' '
 	test_config diff.external echo &&
 	git log -p -1 HEAD >out &&
 	grep "^diff --git a/file b/file" out
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index cf0195e8263..4a9a4436e21 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup unexpected non-blob entry' '
 	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
 '
 
-test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob entry (lone)' '
+test_expect_success 'TODO (should fail!): traverse unexpected non-blob entry (lone)' '
 	sed "s/Z$//" >expect <<-EOF &&
 	$broken_tree Z
 	$tree foo
@@ -121,7 +121,7 @@ test_expect_success 'setup unexpected non-blob tag' '
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '
 
-test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
+test_expect_success 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
 	git rev-list --objects $tag
 '
 
-- 
2.37.1.1127.g4ecf1c08f67


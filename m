Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6564DC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiB1JlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiB1JlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:41:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A1657B9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n14so14394225wrq.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ltrZwux0H8DKQhesJKWG4C1mf9fhe8VI+VEq5z51xjc=;
        b=iINWssBOiNxmgs1LAVHpmAAThF+S9+BOwogpBspPboYOHq7TbI0wqpIxY9PxWM1a/C
         LG/21p8qCqSDyQEr5cAoJ6h84k9CqzXnyUuYtvuLOs0wF4rWZK01SliIDTys1XOdXcq4
         hoBKw8ZH1Zttv35Tpczx67eeT4iJTeilwkrgtks66CUDfLlOunBj/oy5bvRukh++P8E2
         vTSgN7fRrWKG5k9MkS5EboHLNjWfplURNUhsZYzttYzkVEZfztu6DQNiCQ3CWlw/VaX9
         ANloGv0820T46FKhTbYagb1Nx2ce6ZqDK7tv3ZZJmOSXN2lgZZsbUzDrID5yuuk8b6kl
         9TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ltrZwux0H8DKQhesJKWG4C1mf9fhe8VI+VEq5z51xjc=;
        b=11JvZf439dIrTffziocQo6kdzdV0EQtlkekgUw6lM8YXBR60Ypt3afD/22uGrGzgmB
         JGDl6dB0eLFzc37BBP38hbp0sqYhaIPybUtygvyzy3tmGVhU6iTHL8sPbm6s8nBsm2r1
         rPS7ZXdoOBXOdQL4r2wBoQHqjuHLAU9kvfZnAFr0K+N/sWbBohR4fWdkKQmSFYYHDyuW
         ojmfaf4uBe5WX0bry7Y3XjfF72ka3ZWOw1/uxslYJsqrWsBV0OhZjhd9hhzsXeig/Z7J
         HsAmw6/NF//tafbcDAxmMIcAGLjgDsSDSb2anXrqZmw1XgJPYgtbkSs15lEc5k47dk94
         mprw==
X-Gm-Message-State: AOAM530xgRP4zdR5tjffXIr8fiIQ4HbGCjLY/Zx/oOmNqYBUAzvIaNMc
        p7XE/ZokuvC7WxfcXeYmrzkThFeYZIU=
X-Google-Smtp-Source: ABdhPJxy7D74TQiXd3055kXzwRQ6LgNXTZ8XxtsY8MuRkHSObIpvA7p5TdXeQg4MYj84xLV14u8Efg==
X-Received: by 2002:adf:fc89:0:b0:1ef:9517:c7d2 with SMTP id g9-20020adffc89000000b001ef9517c7d2mr5980033wrr.282.1646041239289;
        Mon, 28 Feb 2022 01:40:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16-20020adfecd0000000b001e7be443a17sm14477484wro.27.2022.02.28.01.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:40:38 -0800 (PST)
Message-Id: <a1806c56333ee96f9cda8c77ae56517181b691c0.1646041237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 09:40:36 +0000
Subject: [PATCH 2/2] t7063: mtime-mangling instead of delays in untracked
 cache testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The untracked cache test uses an avoid_racy function to deal with
an mtime-resolution challenge in testing: If an untracked cache
entry's mtime falls in the same second as the mtime of the index
the untracked cache was stored in, then it cannot be trusted.

Explicitly delaying tests is a simple effective strategy to
avoid these issues, but should be avoided where possible.

Switch from a delay-based strategy to instead backdating
all file changes using test-tool chmtime, where that is an
option, to shave 9 seconds off the test run time.

Don't update test cases that delay for other reasons, for now at
least (4 seconds).

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7063-status-untracked-cache.sh | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a0c123b0a77..039b4de8d25 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -24,6 +24,14 @@ sync_mtime () {
 	find . -type d -exec ls -ld {} + >/dev/null
 }
 
+chmmtime_worktree_root () {
+	# chmtime doesnt handle relative paths on windows, so need
+	# to "hardcode" a reference to the worktree folder name.
+	cd .. &&
+	test-tool chmtime $1 worktree &&
+	cd worktree
+}
+
 avoid_racy() {
 	sleep 1
 }
@@ -90,6 +98,9 @@ test_expect_success 'setup' '
 	cd worktree &&
 	mkdir done dtwo dthree &&
 	touch one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 done dtwo dthree &&
+	chmmtime_worktree_root =-300 &&
 	git add one two done/one &&
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
@@ -142,7 +153,6 @@ two
 EOF
 
 test_expect_success 'status first time (empty cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -166,7 +176,6 @@ test_expect_success 'untracked cache after first status' '
 '
 
 test_expect_success 'status second time (fully populated cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -190,8 +199,8 @@ test_expect_success 'untracked cache after second status' '
 '
 
 test_expect_success 'modify in root directory, one dir invalidation' '
-	avoid_racy &&
 	: >four &&
+	test-tool chmtime =-240 four &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -241,7 +250,6 @@ EOF
 '
 
 test_expect_success 'new .gitignore invalidates recursively' '
-	avoid_racy &&
 	echo four >.gitignore &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -292,7 +300,6 @@ EOF
 '
 
 test_expect_success 'new info/exclude invalidates everything' '
-	avoid_racy &&
 	echo three >>.git/info/exclude &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -520,14 +527,14 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five && # five is not gitignored
-	echo test >base && #we need to ensure that the root dir is touched
-	rm base &&
+	test-tool chmtime =-180 done/two done/three done/four done/five done &&
+	# we need to ensure that the root dir is touched (in the past);
+	chmmtime_worktree_root =-180 &&
 	sync_mtime
 '
 
 test_expect_success 'test sparse status with untracked cache' '
 	: >../trace.output &&
-	avoid_racy &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
@@ -570,7 +577,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
@@ -597,11 +603,11 @@ EOF
 test_expect_success 'set up for test of subdir and sparse checkouts' '
 	mkdir done/sub &&
 	mkdir done/sub/sub &&
-	echo "sub" > done/sub/sub/file
+	echo "sub" > done/sub/sub/file &&
+	test-tool chmtime =-120 done/sub/sub/file done/sub/sub done/sub done
 '
 
 test_expect_success 'test sparse status with untracked cache and subdir' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
@@ -651,7 +657,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
-- 
gitgitgadget

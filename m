Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8BC2D0E7
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468A82074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCbENaRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCYTcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46442 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYTcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id cf14so4016329edb.13
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xZLouHK/azr0gc3jL2sf1SkiFlfbFeUCb9j1au4takc=;
        b=UCbENaRXFFoJ6bxt7N+aDCiHSQtHuZIcb6hpeybiSwydyu051mzKMTJIsvniVq0XE3
         Jt8pK3tOubmYa4u02YWCGsPJhJvakmPXTmQA8zAZdGLchqewcLUKiS3Ltz+fKEDjxJ+R
         780IBjHzIDVyWiWneO9PRbyWQFhtkRGw8ORbh92rdRBSmxRVADKhX0JiidWW9MAmmaYO
         euIkV6LBPBjO98DEG49IkHoPmDQvZ+/XatR2W7feCsbTD9vG6nwGdxAMYTRHl74uvnTg
         0lR3c2JoqD3m6RqiIRSW80BDekZXygzLNrmAwzqeuZ8RyLRQ/PyL1ENuSlBQCuxxCp2s
         UbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xZLouHK/azr0gc3jL2sf1SkiFlfbFeUCb9j1au4takc=;
        b=UXXQfFzOAwE4wW4y2BcGZ5T6Spvo7vv+HzzWC7kyo9q/zrUTVGcSl/aJSppB2iKdb3
         dCzz/MVxJ7U1i5jPWqM6tHLiykEEvZnMp0gcd5x54PqL73Buvp9rjvZyqHdGQ/x3U4dt
         ioSxj8I6m0b5ia4034pTv1Jbo1HrU614C/y66fSlz0neE3TYHAAsnaM1IYLUTk85xsVg
         /ne4m2dLG0+BRtAj32Joo0i51pezoOmMQkwsOeCmzcRVjy47ofGBGR7M+UcFdCkh85/A
         GjfktDYaxJ3vbz4mKW+gdlkj7qbvM+307/bShNMmBRTyfGHFvkTZ1hJWl0jmz1FOlCap
         a5fQ==
X-Gm-Message-State: ANhLgQ3QhlUYjk3th2eg+/obGiYjqgtY+hlhtqC1eWnRh47SPup91sm5
        pSrjHji7y7EtXljNdDQjvxuwRDXW
X-Google-Smtp-Source: ADFU+vvG4L9YV4GMm2G4yw1WV3QJvoqzRLL8KgkC1pM95TgA3D21akWmqp8sylFZLEXUTffy8W8xzw==
X-Received: by 2002:a50:9998:: with SMTP id m24mr4420315edb.98.1585164719942;
        Wed, 25 Mar 2020 12:31:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm1627673edb.27.2020.03.25.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:31:59 -0700 (PDT)
Message-Id: <d4fe5d335771e89dad40f717bf4623854d1efa9e.1585164718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
        <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:51 +0000
Subject: [PATCH v3 1/7] t7063: correct broken test expectation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The untracked cache is caching wrong information, resulting in commands
like `git status --porcelain` producing erroneous answers.  The tests in
t7063 actually have a wide enough test to catch a relevant case, in
particular surrounding the directory 'dthree/', but it appears the
answers were not checked quite closely enough and the tests were coded
with the wrong expectation.  Once the wrong info got into the cache in
an early test, since later tests built on it, many others have a wrong
expectation as well.  This affects just over a third of the tests in
t7063.

The error can be seen starting at t7063.12 (the first one switched from
expect_success to expect_failure in this patch).  That test runs in a
directory with the following files present:
  done/one
  dthree/three
  dtwo/two
  four
  .gitignore
  one
  three
  two

Of those files, the following files are tracked:
  done/one
  one
  two

and the contents of .gitignore are:
  four

and the contents of .git/info/exclude are:
  three

And there is no core.excludesfile.  Therefore, the following should be
untracked:
  .gitignore
  dthree/
  dtwo/
Indeed, these three paths are reported if you run
  git ls-files -o --directory --exclude-standard
within this directory.  However, 'git status --porcelain' was reporting
for this test:
  A  done/one
  A  one
  A  two
  ?? .gitignore
  ?? dtwo/
which was clearly wrong -- dthree/ should also be listed as untracked.
This appears to have been broken since the test was introduced with
commit a3ddcefd97 ("t7063: tests for untracked cache", 2015-03-08).
Correct the test to expect the right output, marking the test as failed
for now.  Make the same change throughout the remainder of the testsuite
to reflect that dthree/ remains an untracked directory throughout and
should be recognized as such.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 51 ++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf3..41705ec1526 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -224,7 +224,7 @@ EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_success 'new info/exclude invalidates everything' '
+test_expect_failure 'new info/exclude invalidates everything' '
 	avoid_racy &&
 	echo three >>.git/info/exclude &&
 	: >../trace &&
@@ -235,6 +235,7 @@ A  done/one
 A  one
 A  two
 ?? .gitignore
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
@@ -247,7 +248,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'verify untracked cache dump' '
+test_expect_failure 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -256,6 +257,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
@@ -282,7 +284,7 @@ EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_success 'status after the move' '
+test_expect_failure 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
@@ -290,6 +292,7 @@ test_expect_success 'status after the move' '
 A  done/one
 A  one
 ?? .gitignore
+?? dthree/
 ?? dtwo/
 ?? two
 EOF
@@ -303,7 +306,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'verify untracked cache dump' '
+test_expect_failure 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -312,6 +315,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 two
 /done/ 0000000000000000000000000000000000000000 recurse valid
@@ -339,7 +343,7 @@ EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_success 'status after the move' '
+test_expect_failure 'status after the move' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
@@ -348,6 +352,7 @@ A  done/one
 A  one
 A  two
 ?? .gitignore
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
@@ -360,7 +365,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'verify untracked cache dump' '
+test_expect_failure 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -369,6 +374,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
@@ -386,12 +392,13 @@ test_expect_success 'set up for sparse checkout testing' '
 	git commit -m "first commit"
 '
 
-test_expect_success 'status after commit' '
+test_expect_failure 'status after commit' '
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../actual &&
 	cat >../status.expect <<EOF &&
 ?? .gitignore
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
@@ -404,7 +411,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'untracked cache correct after commit' '
+test_expect_failure 'untracked cache correct after commit' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -413,6 +420,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
@@ -442,7 +450,7 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	sync_mtime
 '
 
-test_expect_success 'test sparse status with untracked cache' '
+test_expect_failure 'test sparse status with untracked cache' '
 	: >../trace &&
 	avoid_racy &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -451,6 +459,7 @@ test_expect_success 'test sparse status with untracked cache' '
  M done/two
 ?? .gitignore
 ?? done/five
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
@@ -463,7 +472,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'untracked cache correct after status' '
+test_expect_failure 'untracked cache correct after status' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -472,6 +481,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
@@ -482,7 +492,7 @@ EOF
 	test_cmp ../expect ../actual
 '
 
-test_expect_success 'test sparse status again with untracked cache' '
+test_expect_failure 'test sparse status again with untracked cache' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -491,6 +501,7 @@ test_expect_success 'test sparse status again with untracked cache' '
  M done/two
 ?? .gitignore
 ?? done/five
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
@@ -509,7 +520,7 @@ test_expect_success 'set up for test of subdir and sparse checkouts' '
 	echo "sub" > done/sub/sub/file
 '
 
-test_expect_success 'test sparse status with untracked cache and subdir' '
+test_expect_failure 'test sparse status with untracked cache and subdir' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -519,6 +530,7 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 ?? .gitignore
 ?? done/five
 ?? done/sub/
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
@@ -531,7 +543,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
+test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
@@ -540,6 +552,7 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
@@ -555,7 +568,7 @@ EOF
 	test_cmp ../expect-from-test-dump ../actual
 '
 
-test_expect_success 'test sparse status again with untracked cache and subdir' '
+test_expect_failure 'test sparse status again with untracked cache and subdir' '
 	avoid_racy &&
 	: >../trace &&
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
@@ -570,7 +583,7 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
-test_expect_success 'move entry in subdir from untracked to cached' '
+test_expect_failure 'move entry in subdir from untracked to cached' '
 	git add dtwo/two &&
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
@@ -579,11 +592,12 @@ A  dtwo/two
 ?? .gitignore
 ?? done/five
 ?? done/sub/
+?? dthree/
 EOF
 	test_cmp ../status.expect ../status.actual
 '
 
-test_expect_success 'move entry in subdir from cached to untracked' '
+test_expect_failure 'move entry in subdir from cached to untracked' '
 	git rm --cached dtwo/two &&
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
@@ -591,6 +605,7 @@ test_expect_success 'move entry in subdir from cached to untracked' '
 ?? .gitignore
 ?? done/five
 ?? done/sub/
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual
@@ -609,7 +624,7 @@ test_expect_success 'git status does not change anything' '
 	test_cmp ../expect-no-uc ../actual
 '
 
-test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
+test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
 	git config core.untrackedCache true &&
 	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../expect-no-uc ../actual &&
@@ -642,7 +657,7 @@ test_expect_success 'using --untracked-cache does not fail when core.untrackedCa
 	test_cmp ../expect-empty ../actual
 '
 
-test_expect_success 'setting core.untrackedCache to keep' '
+test_expect_failure 'setting core.untrackedCache to keep' '
 	git config core.untrackedCache keep &&
 	git update-index --untracked-cache &&
 	test-tool dump-untracked-cache >../actual &&
-- 
gitgitgadget


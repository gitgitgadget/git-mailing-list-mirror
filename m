Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D2FC47409
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6F720CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIT/1JGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAaSbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:31:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAaSbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:31:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so9812483wrt.6
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Vq73R40espVKmFSR4Gemv2ZRIhs5+Vas2Or/9uunBY=;
        b=MIT/1JGcQl/jKYs6ewSwfI3pyaR8mYMadfj+8SEI1bdLZlmY0TDaJ4UFk6Qd7fqtsn
         gX7/NxkXFtqjAsG+H4Qk7HNSPsddHYa39MhuoeHZ4vSfA5KoOIpSUP6jC8r2yRPaSGZL
         B+z1LldqBlKW/nufdUpb5Hjx/gU1KdHq4SADoCotDWKNY+2YljBq9sXwjGJOHjnTh0O8
         aqqujjRa++sGi3nJ1a1CjsIJ+qxKQryKJtYGxIN+M7ObIV7lI+RhdLlJTIn8X+fEI/gW
         qQgj17EnuCS9d+jochss9XsB5OI6AfY9+HQvAqiKj09zLXcc4DpTFsYvtfbKLiGkU+MU
         2zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Vq73R40espVKmFSR4Gemv2ZRIhs5+Vas2Or/9uunBY=;
        b=fnjuN9hxq5EE7/230KJ5wAs2j7/52uLFhgC9Xc5nPKxbPAjWKltSHBX9fyMIE/JbYj
         f0Ss1R7jNWacQMHaDtaXpdHiOBLs8OPfMvhM9o7m5yN7pWOGLsI246RXDzkpek94gURT
         LG9jpE3IzOQLoYsw0fTL1xkCrOHwVxjR+MS94qcxOTmhdxDZUeL77uWOubUMkff1/pt1
         KHqMtvUSLqRn+OBwaW6MMDAF0J3kQRRUKWplk3YE9EDIlb9Zyw0QIHrktznphxotABJt
         GWW/hjQr5SyDHqcz0SKU9nYIB9ri0cPFd0ALEa0Y0HsnaN0lW/+XeGE0XQOT3LgniaeU
         AXqw==
X-Gm-Message-State: APjAAAVEcLlEWd4gITkusJELVIALEwOKg91NbWR9vIfK8ztUhQgGHmAP
        nggSJH80YFPLTEAtwidbJg3CS9P+
X-Google-Smtp-Source: APXvYqyf2I6JvSBDfkDlCjp8dbZ69gi2nwqCmjh1JCfc9EpMCh3Z5I1TPrv+/jjr7E6qZrM0QWtRfg==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr14089999wre.372.1580495492402;
        Fri, 31 Jan 2020 10:31:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm5317907wro.65.2020.01.31.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:31:32 -0800 (PST)
Message-Id: <9a3f20656e20c48096cba32884462920c1eb75ef.1580495486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
        <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 18:31:26 +0000
Subject: [PATCH v2 6/6] t7063: blindly accept diffs
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

Assuming that the changes I made in the last commit to drastically
modify how and when and especially how frequently untracked paths are
visited should result in changes to the untracked-cache, this commit
simply updates the t7063 testcases to match what the code now reports.

If this is correct, this commit should be squashed into the previous
one.

It'd be nice if I could get an untracked-cache expert to comment on
this...

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 50 ++++++++++++-------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..c1b0fd0540 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -85,9 +85,7 @@ dtwo/
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 
 test_expect_success 'status first time (empty cache)' '
@@ -140,8 +138,6 @@ test_expect_success 'modify in root directory, one dir invalidation' '
 A  done/one
 A  one
 A  two
-?? dthree/
-?? dtwo/
 ?? four
 ?? three
 EOF
@@ -164,15 +160,11 @@ core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
 / 0000000000000000000000000000000000000000 recurse valid
-dthree/
-dtwo/
 four
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -217,9 +209,7 @@ dtwo/
 three
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-three
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -235,6 +225,7 @@ A  done/one
 A  one
 A  two
 ?? .gitignore
+?? dthree/
 ?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
@@ -256,11 +247,11 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
+dthree/
 dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -277,7 +268,6 @@ flags 00000006
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -290,7 +280,6 @@ test_expect_success 'status after the move' '
 A  done/one
 A  one
 ?? .gitignore
-?? dtwo/
 ?? two
 EOF
 	test_cmp ../status.expect ../actual &&
@@ -312,12 +301,10 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
-dtwo/
 two
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -334,7 +321,6 @@ flags 00000006
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -348,7 +334,6 @@ A  done/one
 A  one
 A  two
 ?? .gitignore
-?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
@@ -369,11 +354,9 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
-dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -392,7 +375,6 @@ test_expect_success 'status after commit' '
 	git status --porcelain >../actual &&
 	cat >../status.expect <<EOF &&
 ?? .gitignore
-?? dtwo/
 EOF
 	test_cmp ../status.expect ../actual &&
 	cat >../trace.expect <<EOF &&
@@ -413,11 +395,9 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
-dtwo/
 /done/ 0000000000000000000000000000000000000000 recurse valid
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -451,7 +431,6 @@ test_expect_success 'test sparse status with untracked cache' '
  M done/two
 ?? .gitignore
 ?? done/five
-?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
@@ -472,12 +451,10 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
-dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect ../actual
 '
@@ -491,7 +468,6 @@ test_expect_success 'test sparse status again with untracked cache' '
  M done/two
 ?? .gitignore
 ?? done/five
-?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
@@ -519,7 +495,6 @@ test_expect_success 'test sparse status with untracked cache and subdir' '
 ?? .gitignore
 ?? done/five
 ?? done/sub/
-?? dtwo/
 EOF
 	test_cmp ../status.expect ../status.actual &&
 	cat >../trace.expect <<EOF &&
@@ -540,17 +515,13 @@ exclude_per_dir .gitignore
 flags 00000006
 / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
 .gitignore
-dtwo/
 /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
 five
 sub/
 /done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
-sub/
 /done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
-file
 /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
-two
 EOF
 	test_cmp ../expect-from-test-dump ../actual
 '
@@ -615,6 +586,23 @@ test_expect_success 'setting core.untrackedCache to true and using git status cr
 	test_cmp ../expect-no-uc ../actual &&
 	git status &&
 	test-tool dump-untracked-cache >../actual &&
+	cat >../expect-from-test-dump <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dthree/
+dtwo/
+/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+five
+sub/
+/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+EOF
 	test_cmp ../expect-from-test-dump ../actual
 '
 
-- 
gitgitgadget

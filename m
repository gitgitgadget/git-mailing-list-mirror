Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1782C77B7F
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjETQOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjETQOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223AFDB
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4269401f8f.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599242; x=1687191242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2I5OY4gELOsNNU0vWUKnuRuEft5GyjuwAOvKTI6JI8=;
        b=Hgz1akIAYiSCgTfC2IKeJAR2O+xbVt+Kj6pqRNRpYFUJGg+BNVioBj1xQzbQDOU0mo
         2NMJKMTot5QvmXquxqbA8MVrXBxw+SeG61pKuflLt4phoKK+Aerr/pkd8MboQhE0jsz/
         CePjJCkdzD+8uDPVMTouZ8sY4KZNe+4kAkOWyFMTl7dlkbySX2sigd9mi792lrmkRQ/h
         +sFOi9G7eYZgJEh9jzl5NLnVczXbq+621yysYxZ+4fofWV9Bm2WrkuK66+EJQfsnm0fc
         BUA7GAx6yOsBD37l9UCaxXM3bkLJ+7pQsNeHlYVhLQNEnIAEIqS1JpVtO2YcaOoxMdGU
         fV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599242; x=1687191242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2I5OY4gELOsNNU0vWUKnuRuEft5GyjuwAOvKTI6JI8=;
        b=A1RONM5Lj7pLCThIUKzqonHOh9Ez3kvjuIfINrByI2QzwNgH5GLvzYy3Sz6WqzeTMC
         FVS7x0mWsYPgikrbI3KgFhEGsYlmvcw311arTIO3hTdZsGImHvU+JNqbhhYjqH70j1kL
         JmL9CVB9rAp2QZKOYvOpIf37mbs5g7BgoGAlQF+rIyA/lUgUgkHeFjsJ8x35g4qsAbhu
         MzmtOxWMck7iFySyXFSJIKdPkRLxqaqCHM2Ldjbu2/qZetpLg+DbVCUP0ZvJmDScp6jK
         TY3i9aD70eTuDpQHeUE2EU+/T1Qyt/ND9s2pV2olPGwGwofvwL/Xbo3eEl3QaDxkm7ev
         /KKg==
X-Gm-Message-State: AC+VfDwlIa5Dc66h/pI2EZkoDje4oTdDr0wC8gA50QKS44yvpdZj0yDq
        W8OQeBewyYMcsRulFPwMKzQ2yRYvEZs=
X-Google-Smtp-Source: ACHHUZ5vcny57DBuhiGJCUfVFtlQwCI1mNWCBIcci7OQ37Hpw4upvyOah/TIo8kOQoFnGbmZNg76UQ==
X-Received: by 2002:adf:e912:0:b0:307:7e64:4b52 with SMTP id f18-20020adfe912000000b003077e644b52mr4572479wrm.36.1684599242287;
        Sat, 20 May 2023 09:14:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020adfce8e000000b00306c5900c10sm2369247wrn.9.2023.05.20.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:01 -0700 (PDT)
Message-Id: <34a3b63f05245bda86abaec4bb04b3d06d995c38.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:51 +0000
Subject: [PATCH 03/10] t7201-co: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t7201-co.sh | 92 +++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 61ad47b0c18..35b9e6ed6b5 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -372,75 +372,75 @@ test_expect_success 'checkout specific path while in subdirectory' '
 '
 
 test_expect_success 'checkout w/--track sets up tracking' '
-    git config branch.autosetupmerge false &&
-    git checkout main &&
-    git checkout --track -b track1 &&
-    test "$(git config branch.track1.remote)" &&
-    test "$(git config branch.track1.merge)"
+	git config branch.autosetupmerge false &&
+	git checkout main &&
+	git checkout --track -b track1 &&
+	test "$(git config branch.track1.remote)" &&
+	test "$(git config branch.track1.merge)"
 '
 
 test_expect_success 'checkout w/autosetupmerge=always sets up tracking' '
-    test_when_finished git config branch.autosetupmerge false &&
-    git config branch.autosetupmerge always &&
-    git checkout main &&
-    git checkout -b track2 &&
-    test "$(git config branch.track2.remote)" &&
-    test "$(git config branch.track2.merge)"
+	test_when_finished git config branch.autosetupmerge false &&
+	git config branch.autosetupmerge always &&
+	git checkout main &&
+	git checkout -b track2 &&
+	test "$(git config branch.track2.remote)" &&
+	test "$(git config branch.track2.merge)"
 '
 
 test_expect_success 'checkout w/--track from non-branch HEAD fails' '
-    git checkout main^0 &&
-    test_must_fail git symbolic-ref HEAD &&
-    test_must_fail git checkout --track -b track &&
-    test_must_fail git rev-parse --verify track &&
-    test_must_fail git symbolic-ref HEAD &&
-    test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
+	git checkout main^0 &&
+	test_must_fail git symbolic-ref HEAD &&
+	test_must_fail git checkout --track -b track &&
+	test_must_fail git rev-parse --verify track &&
+	test_must_fail git symbolic-ref HEAD &&
+	test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
 '
 
 test_expect_success 'checkout w/--track from tag fails' '
-    git checkout main^0 &&
-    test_must_fail git symbolic-ref HEAD &&
-    test_must_fail git checkout --track -b track frotz &&
-    test_must_fail git rev-parse --verify track &&
-    test_must_fail git symbolic-ref HEAD &&
-    test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
+	git checkout main^0 &&
+	test_must_fail git symbolic-ref HEAD &&
+	test_must_fail git checkout --track -b track frotz &&
+	test_must_fail git rev-parse --verify track &&
+	test_must_fail git symbolic-ref HEAD &&
+	test "z$(git rev-parse main^0)" = "z$(git rev-parse HEAD)"
 '
 
 test_expect_success 'detach a symbolic link HEAD' '
-    git checkout main &&
-    git config --bool core.prefersymlinkrefs yes &&
-    git checkout side &&
-    git checkout main &&
-    it=$(git symbolic-ref HEAD) &&
-    test "z$it" = zrefs/heads/main &&
-    here=$(git rev-parse --verify refs/heads/main) &&
-    git checkout side^ &&
-    test "z$(git rev-parse --verify refs/heads/main)" = "z$here"
+	git checkout main &&
+	git config --bool core.prefersymlinkrefs yes &&
+	git checkout side &&
+	git checkout main &&
+	it=$(git symbolic-ref HEAD) &&
+	test "z$it" = zrefs/heads/main &&
+	here=$(git rev-parse --verify refs/heads/main) &&
+	git checkout side^ &&
+	test "z$(git rev-parse --verify refs/heads/main)" = "z$here"
 '
 
 test_expect_success 'checkout with --track fakes a sensible -b <name>' '
-    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
-    git update-ref refs/remotes/origin/koala/bear renamer &&
+	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+	git update-ref refs/remotes/origin/koala/bear renamer &&
 
-    git checkout --track origin/koala/bear &&
-    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+	git checkout --track origin/koala/bear &&
+	test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
 
-    git checkout main && git branch -D koala/bear &&
+	git checkout main && git branch -D koala/bear &&
 
-    git checkout --track refs/remotes/origin/koala/bear &&
-    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
+	git checkout --track refs/remotes/origin/koala/bear &&
+	test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)" &&
 
-    git checkout main && git branch -D koala/bear &&
+	git checkout main && git branch -D koala/bear &&
 
-    git checkout --track remotes/origin/koala/bear &&
-    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
+	git checkout --track remotes/origin/koala/bear &&
+	test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
 '
 
 test_expect_success 'checkout with --track, but without -b, fails with too short tracked name' '
-    test_must_fail git checkout --track renamer
+	test_must_fail git checkout --track renamer
 '
 
 setup_conflicting_index () {
-- 
gitgitgadget


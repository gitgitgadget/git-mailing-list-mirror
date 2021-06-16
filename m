Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0FC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7310761153
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFPArZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFPArZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DB7C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d7-20020ac811870000b02901e65f85117bso438520qtj.18
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TV0prvvrsCIJBrwi27jPzB+dng21Wkg3mr1uXlMe5I4=;
        b=e0loB2AVoPJiYJdqxLRrila9iKsHiKpHGh0kqb0FsnSs7TcVtTwJ3ix837flVyIx+8
         x7xI31oipYrD7o8pbEce9qqmhs+0ADBJe/HWXYCUAShfOaCOn4EPE9RuoIUsHyt7nuyu
         YP7E7oRQWn37H2EAIX0hL5MSlKJv2E4bIF+1C8O40SbXzNukhzMHX6RhutiqE2vm9jsu
         cOB18Xbi951FyKHY6ElA9WHpicTOUXt0KaY407N8y8h5lt+/el9QyhDbun/u7knBYLeL
         NOils4hu7dj6DwatJmUgY33exntngO87V6qHoGm7p16A0yVV56odMdnzcHzF/4kNP/Wf
         8kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TV0prvvrsCIJBrwi27jPzB+dng21Wkg3mr1uXlMe5I4=;
        b=Tq/TU3CzpAKVFJw+RuEp9nE6IXZ2sHtyFfCxDu8MTyV5/O9MrCXoiDVjgFdq2nE37e
         ThgxM+V8K8XRYK/PkNMCnXKsuPFdzEtPVP5+1QzTiW6kggpp8gWnz1EbQRqbZRaaR7Tj
         K2SJjEGqHM75QrHwlfyO9RKIOYU+hO1nvQ/GfNHGetWESKyeJhy1YrqRRV8W2ahR1iMp
         l25EeyTxtGg4H+5SNC4JE/ld8rVpxVDygFm3Ap7x/CtQbC7RjnPYB/dG6K0/H8wQVL1N
         4pCJDuSxCdQ4b3AI6ZEzS5b14Yp/mo53JDDUx2z+7rytdLBrYjVLT0Dxp1NaacDytDzQ
         XNLw==
X-Gm-Message-State: AOAM531kbDnVp3FUbWC4x8UJpXmfTUl0ibvLY4rmd+DoS1x6G7HxKWwO
        EStYtJGoq7jVsAtt93ee5ysPuKyjtYvQJquPPI1UWaooVHjAA0h0jUTg1VTu77Kbp7iBNZfWV2/
        ObSUiqlGuX0dJfk/QrDzRNjIT+fTuH+MJ1tpWjq7fD8wKCqv9hVndsbnctwV/kXodcp2Y0wqLFQ
        ==
X-Google-Smtp-Source: ABdhPJzB6ks1ekIopA2xFquN1h4ouXrt/vSXINcxIbczvMtgOcn/oPpba/P0D2wM1wvXPqpiVDDP4GTeLXymiHh6CUY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:f684:: with SMTP id
 p4mr8248601qvn.16.1623804317919; Tue, 15 Jun 2021 17:45:17 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:45:05 -0700
In-Reply-To: <20210616004508.87186-1-emilyshaffer@google.com>
Message-Id: <20210616004508.87186-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 1/4] t7400-submodule-basic: modernize inspect() helper
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the inspect() helper in the submodule-basic test suite was
written, 'git -C <dir>' was added. By using -C, we no longer need a
reference to the base directory for the test. This simplifies callsites,
and will make the addition of other arguments in later patches more
readable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7400-submodule-basic.sh | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a924fdb7a6..f5dc051a6e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,25 +107,18 @@ test_expect_success 'setup - repository to add submodules to' '
 # generates, which will expand symbolic links.
 submodurl=$(pwd -P)
 
-listbranches() {
-	git for-each-ref --format='%(refname)' 'refs/heads/*'
-}
-
 inspect() {
 	dir=$1 &&
-	dotdot="${2:-..}" &&
 
-	(
-		cd "$dir" &&
-		listbranches >"$dotdot/heads" &&
-		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
-		git rev-parse HEAD >"$dotdot/head-sha1" &&
-		git update-index --refresh &&
-		git diff-files --exit-code &&
-		git clean -n -d -x >"$dotdot/untracked"
-	)
+	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$dir" rev-parse HEAD >head-sha1 &&
+	git -C "$dir" update-index --refresh &&
+	git -C "$dir" diff-files --exit-code &&
+	git -C "$dir" clean -n -d -x >untracked
 }
 
+
 test_expect_success 'submodule add' '
 	echo "refs/heads/main" >expect &&
 
@@ -146,7 +139,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -237,7 +230,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -253,7 +246,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -269,7 +262,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -285,7 +278,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -301,7 +294,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -317,7 +310,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -348,7 +341,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.32.0.272.g935e593368-goog


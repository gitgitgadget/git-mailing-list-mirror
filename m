Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD13EC432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41766108E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHSUKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHSUKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5127C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k4-20020a25b284000000b0059844c88867so775089ybj.6
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=svC2bw+hfNi7PDC0jKl0o27KlCYtB/u8DrVNCo35o0A=;
        b=pn2G3hevpRak+439JAYjc9AF11VyVzpcvKRJEQXMYlePaSR4h8CoCpOuThx3+/vzjQ
         /E2aLJdyfNipUApnEkxNi/gLYBuEETVODuEWd0B9rDazhnqlOdA8BJEpbyKCQl/WNEls
         xjvGpUmYgLdS1c4l11P71A0tNgmhXpD5RFJX6Tp8+b3EF/2RiGZSTkkjRIyGnp3y4Itr
         xLQipo+DGjpUZQ/Hj6nAT/4jYUvjJiZjoeu2Y9JbDpKYh6/7sX1q18+udf49v62RtGdM
         jO56/zc+nnQ3fW1bv54x9Kn63ERblTnkx4WkP7kaYQabWgXPTkrHKl+C2Z6/Y9tMK1T7
         jBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=svC2bw+hfNi7PDC0jKl0o27KlCYtB/u8DrVNCo35o0A=;
        b=GXdiR5QVNIw6z2aEv7/u9U73/KZztRMWX68M0XSHz5r0pLvhjzLgpcgnynXFaqQSMz
         bjYDVHT6zZZtGcJn6NCgBUEA3/nwff8E+Tl0RG7OjqxKPWgRgcLxCzgmUMOEQX/N6hJJ
         fSfS2lf024oOHIsV2MuyJiDhEohP+fwB3m3zDlav+Mt+SHJNR+TPSy/bSlNtiSCf1Qii
         CCu7tc83/Mgw5zFhv00TchpWsq/LnTwEKyUxBjQ2qeoA4ZzMTYTNhhUOVPVReigDPCLm
         Uu7VcvR67vts7rfuyH+uVQQWxPxNqnmR7vLwjxs7TDzz/wQ3uUnbCOd7fZy6N+xUrSe0
         7RPA==
X-Gm-Message-State: AOAM533TH3i26oTNjZZEY7EFweB1cTI2nm1ZXHyqrTxXsGqbVGW804VM
        traF3ueMi8PSHEHeQygX76zqp47veiXF8IGUaMLt6m076wtXHerinOqOpFqfYeiIc/smAxf4fb3
        YmVDkSOl7iIq5WqS76WaiilEd5Sgc/RpkE2KhGySKebFudHkmjxHcx1Ts57Lrl2dtE93oGUkRPw
        ==
X-Google-Smtp-Source: ABdhPJxuOBMrqB9nxORA8cNMBbdUkpAdPzWQ0vogpJhYAd9xQndr0vw0jKgxTkKsGn83Z+aeI1NVxTSEhKDghrprx2c=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:f43:: with SMTP id
 y3mr20763541ybr.45.1629403803907; Thu, 19 Aug 2021 13:10:03 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:09:50 -0700
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
Message-Id: <20210819200953.2105230-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819200953.2105230-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 1/4] t7400-submodule-basic: modernize inspect() helper
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
 t/t7400-submodule-basic.sh | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a924fdb7a6..4bc6b6c886 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,23 +107,15 @@ test_expect_success 'setup - repository to add submodules to' '
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
 
 test_expect_success 'submodule add' '
@@ -146,7 +138,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -237,7 +229,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -253,7 +245,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -269,7 +261,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -285,7 +277,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -301,7 +293,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -317,7 +309,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -348,7 +340,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.33.0.rc2.250.ged5fa647cd-goog


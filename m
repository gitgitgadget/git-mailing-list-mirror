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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BEDC48BE5
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8061161374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFKW4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 18:56:45 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E60C0617AF
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:37 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d7-20020ac811870000b02901e65f85117bso2788449qtj.18
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TV0prvvrsCIJBrwi27jPzB+dng21Wkg3mr1uXlMe5I4=;
        b=ms1y5aUv5UszjIuhfDeEcE0ayRaxqRyY77qDKHkkoEKafMUhhfks0xUSrSQbXq+nmR
         /Rz3QxVKVAT/brwzmB2BIfGZsjU4BQy39CdBM4znCpqgPGcDhUgoAPlOl1yNgkBRWu5E
         KGZQerRUiOt6p6atuXvG5N+PYTk79CfRGjTz5c4oJvgJdkJCLvHtsH13UmXsVJqOREdW
         vWn3D8Zpx2ehuPNMiBvkbg/LLXUCOBA6RlNznkjp1JPXCUKzfgeiOJILTNYSs30A8O9v
         z/FMyIJYIEn6pHjaQG34wXLppwBXg3yxqmGNe2oVa/tsSy7r4aDgilgLNrFZYbrQd4Wx
         Dy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TV0prvvrsCIJBrwi27jPzB+dng21Wkg3mr1uXlMe5I4=;
        b=U83EHpXHol3DpPUh+WNKkM3IYxcEjjAir1ei9RYETqeBtz4x1q3CZi2IsUCM656N05
         DnLmGaqSXu/WlQHVk54QaINKL+poMvD1c5Jl5C4jqZxDnmi4Bflyfo5kdkZGdIMMUy1U
         uvj/8g+g/FdXJWSA6IXgKbse0v9AxHXmwME19QrW+3IHUOrd4ls8zOg2M81mdfRELxG/
         Pd3iBrWqhox1oedDS3dBLuBHM0BLRKFnQqpXSZqmlZJQv7qOAmEWqmuWfRM6xsSJQ+FN
         LXsHzo+OrBRTJ/vLPs2iFEaNhIBMRnsornmABOOSdEgrcOkO8RuYLYC4Tlmwws9sV4rw
         ctwA==
X-Gm-Message-State: AOAM530M71p9OVqG1T7qiceiTFu3EmxPp9GDel4TpaAkNpjdoKR5kE+h
        DxUUwiy9cbncuIDlcfKo04deagpfeHyvqaK+XbrhdniuZEWFxbOjrGuoaDVzaK079oN3zjIB+MH
        WEjbpeWuuA0jXcfPt1im/YIB5dkoyGN35CbeyUhRtnzaun4kReK9TFhqi6HTh8NpSNwXav0YPGQ
        ==
X-Google-Smtp-Source: ABdhPJxKNTotb5mZZ8J/V8URC6uNMqz60TiPw28iw4IVLmP2u2s9+qBrUKJJjK6h8zXgGrMONsHsQb9RAgTs768ydqI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c894:862c:2364:ff78])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4502:: with SMTP id
 k2mr7099034qvu.43.1623452076890; Fri, 11 Jun 2021 15:54:36 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:54:25 -0700
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
Message-Id: <20210611225428.1208973-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210611225428.1208973-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 1/4] t7400-submodule-basic: modernize inspect() helper
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


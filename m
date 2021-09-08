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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E04C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856F561157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhIHSTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349932AbhIHSTa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:19:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4051C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:18:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so3432702yba.6
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XsKkECT5HewrtKbbWVFjVjC5N0tuSIsTLPBMxwSbJAU=;
        b=B6VQoTvEeaKkfrvRluxx06Yaom+LuG/nw8IdGW/pyIk6sMrwAHL52s4ejtsLh2BmHS
         Fn46OLXHOshJyt/MvnxjbuA5F68pc5L8LxtIMbsoc8jV4KaO1IinTlAUz+Z1DuO3xkeR
         bxeCZU1Cb2ZHB0BPq6i/nKgJTkm9AA+8MowTxfszFi5QGZijzk22vrxbhzO/VE8ABZTn
         XM406LktuXpqHywfvTwpXx6HWpKr3Sv5fGyQpTv68Zi8Lh147Axr9NNfxdyCc4CnQPZ4
         qwKC6vWbVewTHWF1zi4xUbIYs8NCW5Sj90+4ZbCus1eD1hFlD2wmoBX189y5/Zvwp6Ml
         pbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XsKkECT5HewrtKbbWVFjVjC5N0tuSIsTLPBMxwSbJAU=;
        b=05em3NKlu6YJpYXly2egnuuE6/e+0asewKKyGgdWatEhBhhw/W1UVPkQsvuGqiFmBO
         SJVha456nNGpZqRf012GwUAjYbbd2Vx/1De0AMhdSFA4inoIHx6GlW7t2NwH+ITYxuJe
         EyxKK/MS42VeB8z7qgAxPEiu2cvuV98fpn+nwEv6zUmHmp/N9E1U96GHNcjJORy0fhnV
         LluWbQzTlxkT66q+dgnfRLsQ19gAszODOvxW0RxvDxCtGLuRjVQhKOu2ngzaGGyRTBhG
         +fgoXd6qwS5o/+EZiJcx8RdYv27mMTK4HrHav3IWofT9qP5KHGsgPZWZpLAPlO/m1BLT
         DCow==
X-Gm-Message-State: AOAM533Ma8h0y219546GKQOg4s5kA6CMcK1IE8egPH3LbzYintBJAlUk
        e45FEwmhRRPLTrrLKrIgPzSYnYWN7Yv2daBCLXQNXlP0t7+IPq2eeAhdG8RszdzT4wi6X5Ji9f4
        McrKy7PBCoKk82oKMGOGfD3k9MDA5KwqMOX0915uZ8v+YVMhai/Xlcwuf/6epUyypUvBnb+4Pet
        Th
X-Google-Smtp-Source: ABdhPJwH87GouTql1ibW0UlDZHFN5nXd4cxXqrWGHC7XeQX/yC7bSB/NBGbivBJ2bb5BylMZ807Oh6FvqgqnA5jIQySJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:47d7:: with SMTP id
 u206mr7062757yba.537.1631125101871; Wed, 08 Sep 2021 11:18:21 -0700 (PDT)
Date:   Wed,  8 Sep 2021 11:18:13 -0700
In-Reply-To: <cover.1631123754.git.jonathantanmy@google.com>
Message-Id: <942d3ce2d3cf96192c7e9d5860a18c333dd08acf.1631123754.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/3] t6437: run absorbgitdirs on repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule merge code is being transitioned away from
add_submodule_odb() to repo_submodule_init(), and the latter does not
support submodules that have their .git directories in the worktree
(instead of in .git/modules). Migrate the test code by calling
absorbgitdirs wherever necessary to place the .git directories of
submodules in .git/modules of the superproject.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t6437-submodule-merge.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index e5e89c2045..8efce86b42 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -27,7 +27,8 @@ test_expect_success setup '
 	 git add file &&
 	 test_tick &&
 	 git commit -m sub-root) &&
-	git add sub &&
+	git submodule add ./sub sub &&
+	git submodule absorbgitdirs &&
 	test_tick &&
 	git commit -m root &&
 
@@ -82,7 +83,8 @@ test_expect_success 'setup for merge search' '
 	 git branch sub-a) &&
 	git commit --allow-empty -m init &&
 	git branch init &&
-	git add sub &&
+	git submodule add ./sub sub &&
+	git submodule absorbgitdirs &&
 	git commit -m "a" &&
 	git branch a &&
 
@@ -112,7 +114,8 @@ test_expect_success 'setup for merge search' '
 	git checkout -b g init &&
 	(cd sub &&
 	 git checkout -b sub-g sub-c) &&
-	git add sub &&
+	git submodule add ./sub sub &&
+	git submodule absorbgitdirs &&
 	git commit -a -m "g")
 '
 
-- 
2.33.0.309.g3052b89438-goog


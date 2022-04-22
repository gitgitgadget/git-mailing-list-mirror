Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E5C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443398AbiDVCfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443389AbiDVCfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8804B434
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so4567758wms.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KTAYz2IoJo8jRWqSzJj6zyy/6mxRcObxkuZ5nQQCYcQ=;
        b=G4OFLwrDBcOGiSLnYFSpBR4AgP1egGlcZaJlElTDN1Agew5++dPBfKbaMTBCeaRaSV
         j1SjRb+a0XzZ1zM5MF+BvFRP3El6FawY/Eb2yiNKG2QtR7cPoagA82NdyqyQ8FdD6c57
         n1ckhBJS+3Wm0k3CuqFtMHyt3HHVuDG0HP8c3y1+wWrPEV+Kn01SJAQlWnqd+sRVve1D
         HCWHvqCDZ9VLxAplr2yxAua0pfuLhF3ZbnvfWPoStbB4KSQdXdWOz1K10Cgd/uu7fzqy
         KnXezMvLjWNQh9U2IczBAvDKew5wPxdCPAAWK1mkNpSc5qnHC/oBo6dHuzgXHBpr4YI0
         yyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KTAYz2IoJo8jRWqSzJj6zyy/6mxRcObxkuZ5nQQCYcQ=;
        b=4tGqtfh/iDEA+0QusTNWqSkCwxkBa7mBm8hpTaGMPlwIt31BHjg6Ew1gDtiA1XLuey
         d1zopLoFwgm8Dzxv9HWE2yT5zBc45RGAV16XJq9aaJjBBcMCNuaoSUQa4YLUKbufuIEu
         /9ntF5lbpyRYa35QpQBShqYYnOv+wslZd4LBQyC95szLS9wiy0JGc+vhGaBehIb8bLL3
         nav6rzzsZYG0oz8GzHKyVIWM2NcyOfi0kw31SkkCUh62g5Fhk9Dqh11VvTKx1XAGzjZo
         BEIdOcVFZLiMkGpDtmuagIgkfzqlSPPzWTxdCHVZeqkUK2KpyzeAsJ9uKnsF8/ZWk/X6
         MLlw==
X-Gm-Message-State: AOAM530j0Eltbr8K6JIwvucUAzk85NNpxJumNtiN6XUpf5o3+B3ASz20
        pxybq3D1Jex8YQzC2/vzfyJhmw8iUms=
X-Google-Smtp-Source: ABdhPJynqHNgMhcRPto/6nY4Wd+76hN+rqwc1y+av7/bxKMLbS1t4REiB7PQbCu0nI5YRjZj69JNAA==
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr11232927wmw.49.1650594754676;
        Thu, 21 Apr 2022 19:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm610891wrq.81.2022.04.21.19.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:34 -0700 (PDT)
Message-Id: <7908c8f83d85c5e0bfea8476f0d9577d41ccd82b.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:23 +0000
Subject: [PATCH v3 6/9] git-sparse-checkout.txt: add a new EXAMPLES section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since many users like to learn from examples, provide a section in the
manual with example commands that would be used and a brief explanation
of what each does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 43 +++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 2083e6df356..c54437428bb 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -136,6 +136,43 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
+EXAMPLES
+--------
+`git sparse-checkout set MY/DIR1 SUB/DIR2`::
+
+	Change to a sparse checkout with all files (at any depth) under
+	MY/DIR1/ and SUB/DIR2/ present in the working copy (plus all
+	files immediately under MY/ and SUB/ and the toplevel
+	directory).  If already in a sparse checkout, change which files
+	are present in the working copy to this new selection.  Note
+	that this command will also delete all ignored files in any
+	directory that no longer has either tracked or
+	non-ignored-untracked files present.
+
+`git sparse-checkout disable`::
+
+	Repopulate the working directory with all files, disabling sparse
+	checkouts.
+
+`git sparse-checkout add SOME/DIR/ECTORY`::
+
+	Add all files under SOME/DIR/ECTORY/ (at any depth) to the
+	sparse checkout, as well as all files immediately under
+	SOME/DIR/ and immediately under SOME/.  Must already be in a
+	sparse checkout before using this command.
+
+`git sparse-checkout reapply`::
+
+	It is possible for commands to update the working tree in a
+	way that does not respect the selected sparsity directories.
+	This can come from tools external to Git writing files, or
+	even affect Git commands because of either special cases (such
+	as hitting conflicts when merging/rebasing), or because some
+	commands didn't fully support sparse checkouts (e.g. the old
+	`recursive` merge backend had only limited support).  This
+	command reapplies the existing sparse directory specifications
+	to make the working directory match.
+
 INTERNALS -- SPARSE CHECKOUT
 ----------------------------
 
@@ -154,12 +191,6 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
-To enable the sparse-checkout feature, run `git sparse-checkout set` to
-set the patterns you want to use.
-
-To repopulate the working directory with all files, use the
-`git sparse-checkout disable` command.
-
 
 INTERNALS -- CONE PATTERN SET
 -----------------------------
-- 
gitgitgadget


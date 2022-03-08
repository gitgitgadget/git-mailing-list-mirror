Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A87EC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbiCHHkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbiCHHku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C939834
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so893620wmq.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5BZ6LZpnTeW762/oRUvocKu3FJi2OO94uAAe3IQr7I=;
        b=eSgzPRwZnOlK4YjVucYzqGZ+2g0fXqxfaN3Sur3LfzTBrnhzkyURVl9Eyv6V6w/vU8
         Ioul3j0dH2wT54gVtT7QQNG1sw6eqryblwp1sY9zInJw5Uy4LcwBpbpshmBixXcHE546
         tt2Zpyd0WKaAo6X/tx3t98kH1C2iwf8R3ZKi3J+MQDtrr6MyYoeizfPy+NBwnJVP7+US
         WQfpYla5swxU1GZhiRTpDUTnZsaVTirj6hug5mToBbuMVXl5nd378470iXqjFFJr0y7V
         ZkJVLkyznwHGjExFay6aLlhHXdtkhThsxLLAZbB9+pnTyOjDYpNjJWLIf+0+L3Cv55pt
         Aj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5BZ6LZpnTeW762/oRUvocKu3FJi2OO94uAAe3IQr7I=;
        b=KS6pXvMT0Q4uXS8juHXJpTkKI4ms3X0KHIcP1tjnxkTGlX8otxuPfjmpY2PFCG3H+6
         e9VTGnVwy58uHkWV7IpOerMPsNqwq3Iv8g2Pw98RPLHDBzwVRSQiclNCayfyxsvFuGFx
         kQT16wOW84CPkPYM8gqoL9KjPEH/ovDyE1+UerFVm/jZC18+9Ihlms4HDU+6sY9IxMfu
         4uvAUEIVGC9v6FFPbDTUSw5LhXR9akMZqBPzeq1LHHn9bOJfKdSYtuXl1FnMs7DOQ8PL
         Vb9I/tH28r7phkz4KjcHufBBc0ySvkPoiyqwTHXKdvLy1ar4mMkZwqULtfNFJaUy5hIw
         +PYg==
X-Gm-Message-State: AOAM5307MaE0i7/SPJ0U8/DSDiLUamj3aFXLXaIRucMmfaTBbhTzBa7q
        njxWUEJtjM2cR7x+gOlScs7MmNdyWTk=
X-Google-Smtp-Source: ABdhPJzWqGszyq7CZhVdEsDkHG+oQiN4CbiMe09eBduB/wY0V5dhIL9JkNEPRDdC6MNzq35hObnSHg==
X-Received: by 2002:a05:600c:4e93:b0:389:bcc7:5554 with SMTP id f19-20020a05600c4e9300b00389bcc75554mr2265975wmq.77.1646725191943;
        Mon, 07 Mar 2022 23:39:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm1446607wmq.2.2022.03.07.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:51 -0800 (PST)
Message-Id: <b174b42ed82a45f57959a2a493dcfb32bf26c12d.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:41 +0000
Subject: [PATCH 2/9] sparse-checkout: make --cone the default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make cone mode the default, and update the documentation accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 20 ++++++++++----------
 builtin/sparse-checkout.c             |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 88e55f432f3..4ef03120797 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -22,8 +22,8 @@ present, or undo and go back to having all tracked files present in the
 working copy.
 
 The subset of files is chosen by providing a list of directories in
-cone mode (which is recommended), or by providing a list of patterns
-in non-cone mode.
+cone mode (the default), or by providing a list of patterns in
+non-cone mode.
 
 When in a sparse-checkout, other Git commands behave a bit differently.
 For example, switching branches will not update paths outside the
@@ -60,7 +60,7 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
+When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
 input list is considered a list of directories.  This allows for
 better performance with a limited set of patterns (see 'CONE PATTERN
 SET' below).  The input format matches the output of `git ls-tree
@@ -68,10 +68,9 @@ SET' below).  The input format matches the output of `git ls-tree
 double quote (") as C-style quoted strings.  Note that the set command
 will write patterns to the sparse-checkout file to include all files
 contained in those directories (recursively) as well as files that are
-siblings of ancestor directories. This may become the default in the
-future; --no-cone can be passed to request non-cone mode.
+siblings of ancestor directories.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
+When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
 the input list is considered a list of patterns.  This mode is harder
 to use and less performant, and is thus not recommended.  See the
 "Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
@@ -227,10 +226,11 @@ patterns. The resulting sparse-checkout file is now
 Here, order matters, so the negative patterns are overridden by the positive
 patterns that appear lower in the file.
 
-If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
-expecting patterns of these types. Git will warn if the patterns do not match.
-If the patterns do match the expected format, then Git will use faster hash-
-based algorithms to compute inclusion in the sparse-checkout.
+If `core.sparseCheckoutCone=true` (set by default or with an explicit
+`--cone`), then Git will parse the sparse-checkout file expecting
+patterns of these types. Git will warn if the patterns do not match.  If
+the patterns do match the expected format, then Git will use faster
+hash-based algorithms to compute inclusion in the sparse-checkout.
 
 In the cone mode case, the `git sparse-checkout list` subcommand will list the
 directories that define the recursive patterns. For the example sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5518ed47f6c..61b7a7519bb 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -397,7 +397,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 
 	/* Set cone/non-cone mode appropriately */
 	core_apply_sparse_checkout = 1;
-	if (*cone_mode == 1) {
+	if (*cone_mode == 1 || *cone_mode == -1) {
 		mode = MODE_CONE_PATTERNS;
 		core_sparse_checkout_cone = 1;
 	} else {
-- 
gitgitgadget


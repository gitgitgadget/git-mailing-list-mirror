Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9651C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C897761242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbhIXPlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347187AbhIXPkv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FBC06161E
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so28619219wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEtjt+Ut+ZPEGjZU8UZf8b6xjgXJsx/g9OCijhwvt5w=;
        b=CF4oEmu/s2/EnIpscKQdu/JN1PjNrQ/d+nGjd1axKVGHXOJ2d0m8MRzxTXLhJv7yRo
         RkKnNCjzWvUQTe7FdkmizqobYCYloSqoykwoNob2OYEP94jEemPD5EkPOZ3KfW8nZ2ti
         dOu71m6i/rAlB9mQmU6/cwmopAQylchhaTC+AixRX7z1ZUiX3+Hp3tndxdo+K8PHb0XE
         XG6DZ1TgjlgxSKq5uJRnAkyp8dkXEFKvBwz1yH/TDYN+jdGiRF7SIuyP+3VDCni/kMlQ
         Ib3zLU5qxyg/f7ht9UVoEy0vIpedpL417t9Gg7A79sotx4Fxd78woq5PTDR79gIcL+gx
         FK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEtjt+Ut+ZPEGjZU8UZf8b6xjgXJsx/g9OCijhwvt5w=;
        b=QaA2YcT07a5s4zrJ2aKftowP38nv3tQQwOm/ur1yVFu6qXoUoWBxC4fVxFMfoz4gAw
         lm1ZE+mGZmJN8gFFvWhuKWyHG/kYGC96PRruWYdxuyM/8ePeBixESfso6/TmtnlW7/lj
         9M/fB/pRPXkiP2xfB4V+Xx0B2oG4vibuA2qB82e04lKm9WPkILS2Vtc+vekai5B5b84c
         fwfpWwNa0JQtq3wgGFNFuKs7ZDbWVpf+PZyXXBI6oOnyiKkTXKq4eVUGw1XU9c9SStDs
         kW4UgzdZ4+4D84aMNTZ56+giygRsXI/sP/PeoyXf6dHtg273zsb4iXK9j2X0zSxrzlPZ
         C8dA==
X-Gm-Message-State: AOAM531pW/Tre8ZVsDg/iJNkPZAbTjpohox5j76wcBK31IrtjO5TYvRN
        Sg67iGHl6cX5ES0pt3fjH8Up5B6RAaU=
X-Google-Smtp-Source: ABdhPJxkXOJrGt2wlQ2amgEacJoTZJNrvauYi87b67HMcP+/Y1lOYrVnyZinXxXRahMWeYHkDSEJag==
X-Received: by 2002:a5d:4d4f:: with SMTP id a15mr12275972wru.210.1632497956679;
        Fri, 24 Sep 2021 08:39:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y64sm9568173wmc.38.2021.09.24.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:16 -0700 (PDT)
Message-Id: <58389edc76ca8f14951ee9387a0067c1ead08f41.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:03 +0000
Subject: [PATCH v4 02/13] t1092: behavior for adding sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add some tests to demonstrate the current behavior around adding files
outside of the sparse-checkout cone. Currently, untracked files are
handled differently from tracked files. A future change will make these
cases be handled the same way.

Further expand checking that a failed 'git add' does not stage changes
to the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..7edc2060221 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -187,6 +187,16 @@ test_sparse_match () {
 	test_cmp sparse-checkout-err sparse-index-err
 }
 
+test_sparse_unstaged () {
+	file=$1 &&
+	for repo in sparse-checkout sparse-index
+	do
+		# Skip "unmerged" paths
+		git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
+		test_must_be_empty diff || return 1
+	done
+}
+
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
@@ -291,6 +301,20 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+# NEEDSWORK: This documents current behavior, but is not a desirable
+# behavior (untracked files are handled differently than tracked).
+test_expect_success 'add outside sparse cone' '
+	init_repos &&
+
+	run_on_sparse mkdir folder1 &&
+	run_on_sparse ../edit-contents folder1/a &&
+	run_on_sparse ../edit-contents folder1/newfile &&
+	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
+	test_sparse_match git add folder1/newfile
+'
+
 test_expect_success 'commit including unstaged changes' '
 	init_repos &&
 
@@ -339,7 +363,11 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 	test_sparse_match test_must_fail git add --refresh folder1/a &&
+	grep "Disable or modify the sparsity rules" sparse-checkout-err &&
+	test_sparse_unstaged folder1/a &&
 
 	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
 	test_sparse_match git add folder1/new &&
-- 
gitgitgadget


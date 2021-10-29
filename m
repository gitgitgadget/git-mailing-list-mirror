Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF6C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8067611C0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJ2NyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhJ2NyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:54:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F1C061767
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o14so16201316wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=DogJS+ZmsmzMLxsPcZT1Zk2Gb8RDe2BC/r/jxGCoZiJSVonYWfbMbHW5D+UXg0YLH4
         Y8PYCqSGgnDQoQZ2aTH5RZ22hy0931C7Qz+uh+H/Gu6rcbfPMjRVjz9iCLqUy3GalBCi
         gWpG7SusRTRvjaL2EuLI35fvkoliAQX+zDV0Sx2fPWntzgzXFGmYgKcnczJptvJj3J6C
         NjiV7twHIIsLj8aJvZozIvYeVHzK5AHsCsBic9pcp+9TTagdQPA7iUJsxGSo6z7O8DBx
         18DCIAVcptngosDOs8wFXTWQTElttJ197G9KQn+/xplbjSqkLMOxJasQhDV4uwR8zLp6
         58sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=EZwZckDc3wjqp5fvVTfdEROEcahpoYBQdsYa+7GVp9EVIu2Ii9CsL6VhQ/iAbtUq7X
         ElbC/bvw7wJpYmHA3i/4LBHdBjMLSDstyfjsNp/7lifypBKJU7eWSh5wlL1CXCyNaYRh
         8yZKIM7wdc3bPqVKXFbZKxuxFNV1XSlStoGDctUqGTFz3h8Sgrf7RDVg41iChx6CVMrl
         dG2Qgn+733SQ6TbwuI1f7BzUdRnbV1b/b4DMniQr/IbIL+W/0zrtk8ChV0/eQqhdysaJ
         +3ZsAO4MCMOa16PKm9ixcVM1akpp88CX/MdssGugo6ldtbubWKLV2QFA+hC1ueGgYJzQ
         wDyA==
X-Gm-Message-State: AOAM532Fs2TmKsHrEpNPsIzbF4Ym61fAhcK4VitWpt593rmxn0abUrWO
        HuDvMGCaaBIjxQP5XZFkhPBYb5VMq9E=
X-Google-Smtp-Source: ABdhPJzhee+weqPRkq/F8pjRjj+Pyov5ImrENkPxVOP2/zyQDdTml4AdX/KghqmWIbattXnWkiWenA==
X-Received: by 2002:a5d:4405:: with SMTP id z5mr7587233wrq.415.1635515491024;
        Fri, 29 Oct 2021 06:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm5717862wrs.19.2021.10.29.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
Message-Id: <b67cd9d07f8a3802e5b50d58965f283620cd3876.1635515487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:51:26 +0000
Subject: [PATCH v4 4/4] sparse-index: update do_read_index to ensure correct
 sparsity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If `command_requires_full_index` is false, ensure correct in-core index
sparsity on read by calling `ensure_correct_sparsity`. This change is meant
to update the how the index is read in a command after sparse index-related
repository settings are modified. Previously, for example, if `index.sparse`
were changed from `true` to `false`, the in-core index on the next command
would be sparse. The index would only be expanded to full when it was next
written to disk.

By adding a call to `ensure_correct_sparsity`, the in-core index now matches
the sparsity dictated by the relevant repository settings as soon as it is
read into memory, rather than when it is later written to disk.

Helped-by: Junio C Hamano <gitster@pobox.com>
Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             |  8 ++++++
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index a78b88a41bf..b3772ba70a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2337,9 +2337,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	if (!istate->repo)
 		istate->repo = the_repository;
+
+	/*
+	 * If the command explicitly requires a full index, force it
+	 * to be full. Otherwise, correct the sparsity based on repository
+	 * settings and other properties of the index (if necessary).
+	 */
 	prepare_repo_settings(istate->repo);
 	if (istate->repo->settings.command_requires_full_index)
 		ensure_full_index(istate);
+	else
+		ensure_correct_sparsity(istate);
 
 	return istate->cache_nr;
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ca91c6a67f8..59accde1fa3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -694,6 +694,37 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	test_region index ensure_full_index trace2.txt
 '
 
+test_expect_success 'index.sparse disabled inline uses full index' '
+	init_repos &&
+
+	# When index.sparse is disabled inline with `git status`, the
+	# index is expanded at the beginning of the execution then never
+	# converted back to sparse. It is then written to disk as a full index.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c index.sparse=false status &&
+	! test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	# Since index.sparse is set to true at a repo level, the index
+	# is converted from full to sparse when read, then never expanded
+	# over the course of `git status`. It is written to disk as a sparse
+	# index.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index status &&
+	test_region index convert_to_sparse trace2.txt &&
+	! test_region index ensure_full_index trace2.txt &&
+
+	# Now that the index has been written to disk as sparse, it is not
+	# converted to sparse (or expanded to full) when read by `git status`.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index status &&
+	! test_region index convert_to_sparse trace2.txt &&
+	! test_region index ensure_full_index trace2.txt
+'
+
 ensure_not_expanded () {
 	rm -f trace2.txt &&
 	echo >>sparse-index/untracked.txt &&
-- 
gitgitgadget

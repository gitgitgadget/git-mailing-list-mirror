Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B4C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E27610A4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbhJ0SWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbhJ0SWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:22:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836FC061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b82-20020a1c8055000000b0032ccc728d63so3091172wmd.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=hm4wVJqpMGr8bbBAatl5LFOlqR5HKxgjSyLVL69fIrxAszaK+pSRUiFzzNudblVYVs
         9GtFQkvtOOlMpC/5wwoXZb+ydBTT1QE1Ny1ri+1C8m+GOfh5CR5vQZaypaRkCLcpXf/D
         jJoNmO0MD7lkxHJL/Kc12KjyTPaG9zxTo1nipI0QpzSbSmezNPJY3wUGxDeF2Zy9tZ81
         zkzDCG9CR2E19tu0cayqfmcSeWKUAg+0VbwumfPccmxDOUbbCYuobB1NOLq2fcPvA37N
         XB/+D0EDuJayo40bj2c3dARLjuCgzYQC1Voijj5VlaTffFFO2efnLEVaTo1jx8DpxSUz
         lcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=n5KMFBd5UstVy9vL31FpKFWTy4MD4mC+IfbSZ+hMs7C8lPcc96BnlXKYJfn3MukBBv
         003Q7sc4C9c4tvEwptIcQSbaTstv3V+R7iHt0k7OYV1g26SIcNN0b4pXbvak8Dt9Un0S
         IQ6vge4163ar2x3p7H1op1bi1nncNHabcs5dfHVxy0cVRVAkTohXuaDE5B76Y0ZUyVZ6
         cD/qQV7O7os019dLr5HXfZW53Yv2MUA6jU9WnlUlqKH33lyj1vPsRV/oZ6ZbSTes98lF
         Ea/kefEePGDZ+Ue5QHjJI28L7eNHg4hyPYQTF14gixB2CN1GyZFRrFzIJGsPnGDALNgH
         zhRg==
X-Gm-Message-State: AOAM5310A0MIKY3Nd/yO9sRlQCGWrkO73gTeK43pLQ/rBGsfaVLCOWgh
        MV/Sa1QDsu7JJwExHo/iFFk7fY3bcOM=
X-Google-Smtp-Source: ABdhPJzD1Vl8oV7Kq5MNfWCUnQea/Orf12vKzDkr06cQ1W9AyzT2NuUjrLvjjuCYQvgunbNcKtIgGA==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr7140149wmq.123.1635358814770;
        Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm620459wrg.1.2021.10.27.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
Message-Id: <d6c3c694e1e96774d12979ad3b7948bdba1dcc24.1635358812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
        <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 18:20:11 +0000
Subject: [PATCH v3 3/3] sparse-index: update do_read_index to ensure correct
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

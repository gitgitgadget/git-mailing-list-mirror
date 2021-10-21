Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80891C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6632760FD9
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhJUUuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhJUUus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:50:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72EAC061348
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z14so469652wrg.6
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=qkFUaF988fEqusSfFWTCDxqIZB/xUQ8nfkp2mz/4amt5nVGy2U1MM0f4hupSTMPwLp
         IUqHlLQdKa/rpCRoov8cgJeSyZ4RonfMcBygTOFoikKThnwkqIbSwmD0F8YTzpAwAdpA
         OXKurhuWT9zfbeWlrZSM/qjSpX+64NxT4Z/lG58lGuNT/oV7GFPUDMxbSSTcj9Cu5Y8u
         3zrR/8bSeZ4jBmsiTQzBby8lRskT8gxOTdV3c6koACFhV1IXzIlR3vx32U+0jJrAxKd2
         bqh/+1OK63vygrdaLDqvhNvyNa+ihH+R3g4572gr1MNovPhsqu7Xg7ZUkVrSbyQ1gSNx
         N3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qkq4mQztxITq/GOSkhCIwELaNOZlIiv3dFjIv3bSuQU=;
        b=rV0ZjndlPS+4RY+qR62hEF4cZlFkzvo/FpEkO6qWBTX8oiarfTzLEib1FVGHXdV11h
         ztyv2UPz9SR912yFMJy8oAinikNsyb5nVlI7W+ntmbKXxRYPp1PASG+lt576i8q593d2
         6RZ6WqNAgyp6fr1J/YTjqLKwyE3JLh8LAmN7jw30HTi1U/XsZB7+I/Cc5/8Q9rNr4GpS
         GmYjqRu/we9bDGUxqBDf8/0fcETwF3TrQJ2V//j2LeqBYW1x/8JcYYpDDFAWmezkDglo
         W9HGBSG3h7Ziq0eyzFG/SsyN+8D5luZMsy4k1APyU7CGmOq+k4FVXgZHQN+v49rTcHGl
         6EOg==
X-Gm-Message-State: AOAM530R7uc+H7QsNXasx7z+aKW6GUfoTsi+jWnQvqgVZGu34Sve6jma
        oiOdEYbzd8E10bfQHvesHh0U7tJxoLo=
X-Google-Smtp-Source: ABdhPJzn9om2VS4dCZkP1myktTXJOyY5kp6fshXV0GRPgSpwTj15LCfg9yFcQ6Uyw2ndQJGCyOSnoA==
X-Received: by 2002:adf:9b8a:: with SMTP id d10mr9752143wrc.151.1634849310291;
        Thu, 21 Oct 2021 13:48:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm6151194wrg.57.2021.10.21.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:48:29 -0700 (PDT)
Message-Id: <437cf398256049b10365af8a21961bd3c30710ba.1634849307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 20:48:26 +0000
Subject: [PATCH v2 3/3] sparse-index: update do_read_index to ensure correct
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

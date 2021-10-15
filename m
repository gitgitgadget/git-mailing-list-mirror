Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B9C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E30611C1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhJOT5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbhJOT5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:57:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80584C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r18so28307324wrg.6
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k/jp3SuGts+LuSXjdsh8RPPFK1O2JubIE2/yNZzThEs=;
        b=I9446mF7OaftVq76+ZXEEDLfmRThgFnd1+k18DlWe2NxoE0I1vxWtFwDIyRnDmzrcN
         iWJIfb1WwK6rcUriVIJ+oOB9Y90e/1G3OxiS/ODIEN1lHM0+Gg9Lws8k7qKaRHBQA5Jl
         vMIDmVceAmn58uda1uhDFEPpNkMg+3pEnODlGaNptRKE8Eh3Jr4Y6xQ82xzm2lPIgnWM
         dxhg3M6DqpOCmud7ji2g4jROBbeiRJx9bBUkRKROTlTMOVSohElFHZxQdBYWUBfvpfvX
         GqtFigG6+R2XDhkyroeyFD5O7aH7EcYNKpwyE7VXSnmrfZM4SsAf0T3JIr2DQ3+GHsg9
         muOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k/jp3SuGts+LuSXjdsh8RPPFK1O2JubIE2/yNZzThEs=;
        b=QaD8obz5QTFgLPGNvfBIILNJIcPzMrM0JdeK2vg/lwoRWNRQYmZ33Az7W3B32k42e/
         Rb6qGN/3/xReLT/csW9LOtG2epsNnoyJl9oKhxXQTSco73OpV/kevxryfjuNhgGqzc8D
         tkNpRmgHt7wO4ejW0u516z0UQ6n+yOJWva/iuNTjsMYgpL95IOyhRC90tDG3tyxzZGU2
         EDZTluOXb+Ynnq7AiX1fV2gYO64BVeXUxNm4IJB1fky/21Jm7ENbkkxHfrMkJC6hlRUJ
         hvw8RoVsxJL9z5uf8dTc2EPThoaPvyfHrLl6qy8Lj93oNvp2jZXAzQthLYjaQBsjC/sj
         zTNg==
X-Gm-Message-State: AOAM5310VfZ8Pezs3pgFwqRGunJ8K2CaGk6qFRKStAUzlzPzmX7LcjQa
        qtb8er9cXR+Q3POo8NkH0YRt+gzwJBY=
X-Google-Smtp-Source: ABdhPJxAJYSlHIeNJGTBH+hakxG80WDjoP3G3cJ8yWtKRkhvqgwXvMT05zkzPyBdAKRkEkwHqb4juw==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr16555896wrg.134.1634327700187;
        Fri, 15 Oct 2021 12:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm6033721wri.29.2021.10.15.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:54:59 -0700 (PDT)
Message-Id: <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 19:54:57 +0000
Subject: [PATCH 2/2] sparse-index: update index read to consider index.sparse
 config
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

Use the index.sparse config setting to expand or collapse the index when
read. Previously, index.sparse would determine how the index would be
written to disk, but would not enforce whether the index is read into memory
as full or sparse. Now, the index is expanded when a sparse index is read
with `index.sparse=false` and is collapsed to sparse when a full index is
read with `index.sparse=true` (and the command does not require a full
index).

This makes the behavior of `index.sparse` more intuitive, as it now clearly
enables/disables usage of a sparse index. It also provides users with a way
to disable the sparse index per-command (e.g., for troubleshooting purposes)
without needing to re-initialize the sparse-checkout.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             |  5 +++-
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index a78b88a41bf..c3f31718b19 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2338,8 +2338,11 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (!istate->repo)
 		istate->repo = the_repository;
 	prepare_repo_settings(istate->repo);
-	if (istate->repo->settings.command_requires_full_index)
+	if (!istate->repo->settings.sparse_index ||
+	    istate->repo->settings.command_requires_full_index)
 		ensure_full_index(istate);
+	else if (!istate->sparse_index)
+		convert_to_sparse(istate, 0);
 
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

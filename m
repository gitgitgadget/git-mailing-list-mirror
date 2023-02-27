Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C375CC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjB0P3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0P3C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:29:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936CD33F
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l1so3596921wry.12
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gumFfoHYTikPuKuMLA7FCNGHGsKUNE8MRz/fbK1UzHE=;
        b=cU8UHjy8yuNfw+Gh9GX5XIrIX4wQCvwIM19LFEiimgCS1skRkqS5MIPEdKivWfMUcY
         ySUZH8usIUJNT2M+OgjAPkQq5Js3k8eQ8VxjWsyrBjufKCtLvYKdJjaBTx86bUzD1HVY
         HqE3YvaLDexTJM7+gtAd/Bnx/SBBFoCFZy3FyCCnw/d53RabCHnCsuiZsKa9+EI7FwWl
         dviOM6VJmopQ/SycL8PXvJgSh2P3QATD5zSoJLCwAjqXvwp+L6mBEzmJOcDYWDU4i978
         6YCmOGiLJ4baMZDsV6r7H3SxwmVjJjM3Z96ou4qIKwMY7vx3rVXr1gr8IqA0UzHlSF9g
         wYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gumFfoHYTikPuKuMLA7FCNGHGsKUNE8MRz/fbK1UzHE=;
        b=OHUhd73HFeQkOblzJO9uKdZcywebXeTqC5B6P9PwX7UWaOfZYy01lk8DWQBTJ2R55s
         t8mEmgDtyCNot3OTIr+d3af8fmJ7e9EGsl9IXxglqdmZVCHbLS+sYdIpqmGcFKw3p6zF
         GNDrXRYz23RNjZPw55fa0M7DyrtrxhOxMLH9A1xXI0SejWT7B+3hWch/jOWcaklP1JY0
         WzFzdyyibRwL7yxrrKLysBfmPmRH6iRc6apKECYJInSfLJmPEUEi50ai5mbLoHIVxcvw
         E3QKkRit6L6aPKp6+GvrMHIC4JkosoLqcbEPrQUIYIFHPthY0AaRqdLuupiFQB3w2Uci
         RNKA==
X-Gm-Message-State: AO0yUKWzZfhuZGX74MR1kQ8jA7+QHqjOUdOFa5tuxlbZmlOSYeNV88I2
        2k98DTxopOZr6nheHVe0HmlF1l6PmBk=
X-Google-Smtp-Source: AK7set9rB6oOCi5ErJZD7rlGVHQwpei52waGUbJYKM2YOVA6QjQQbZpnV3fupQ2zG0AtkDCOgMDnpw==
X-Received: by 2002:adf:ea88:0:b0:2c5:5a65:79a0 with SMTP id s8-20020adfea88000000b002c55a6579a0mr17781982wrm.53.1677511710544;
        Mon, 27 Feb 2023 07:28:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d4b86000000b002c5691f13eesm7325631wrt.50.2023.02.27.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:30 -0800 (PST)
Message-Id: <76f4a544e4bcf1207d2db68e26a2b12221c84abd.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:18 +0000
Subject: [PATCH v3 11/13] unpack-trees: rewrap a few overlong lines from
 previous patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous patch made many lines a little longer, resulting in four
becoming a bit too long.  They were left as-is for the previous patch
to facilitate reviewers verifying that we were just adding "internal."
in a bunch of places, but rewrap them now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index dd4b55ef49e..cac5dd0da37 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1213,8 +1213,8 @@ static int unpack_single_entry(int n, unsigned long mask,
 		 * cache entry from the index aware logic.
 		 */
 		src[i + o->merge] = create_ce_entry(info, names + i, stage,
-						    &o->internal.result, o->merge,
-						    bit & dirmask);
+						    &o->internal.result,
+						    o->merge, bit & dirmask);
 	}
 
 	if (o->merge) {
@@ -1918,14 +1918,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	} else if (o->src_index == o->dst_index) {
 		/*
 		 * o->dst_index (and thus o->src_index) will be discarded
-		 * and overwritten with o->internal.result at the end of this function,
-		 * so just use src_index's split_index to avoid having to
-		 * create a new one.
+		 * and overwritten with o->internal.result at the end of
+		 * this function, so just use src_index's split_index to
+		 * avoid having to create a new one.
 		 */
 		o->internal.result.split_index = o->src_index->split_index;
 		o->internal.result.split_index->refcount++;
 	} else {
-		o->internal.result.split_index = init_split_index(&o->internal.result);
+		o->internal.result.split_index =
+			init_split_index(&o->internal.result);
 	}
 	oidcpy(&o->internal.result.oid, &o->src_index->oid);
 	o->merge_size = len;
@@ -2049,7 +2050,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(the_repository, &o->internal.result);
+				cache_tree_verify(the_repository,
+						  &o->internal.result);
 			if (!o->skip_cache_tree_update &&
 			    !cache_tree_fully_valid(o->internal.result.cache_tree))
 				cache_tree_update(&o->internal.result,
-- 
gitgitgadget


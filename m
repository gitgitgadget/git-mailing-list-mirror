Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03BDC64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBYC03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBYC0L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44141094
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h14so1055442wru.4
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcWN0y3xpOfOqMBy6AjaImaPeMb1HRl0zQd1eTyjsNA=;
        b=nlBMafh5jCYpuDneTBnbxkEriME8o752GmPJYxxT3wOsxUqw8tmPtbTuDB6h23ubIK
         Px79TQO3QED0+iB50B4YZ7SdYI98+SgfH5raz4Tkhf4wNLgkeSA3qFJ9gKO3mZEhUbgr
         CiUjgd/Hy+tc9bFzlFSOGN01thoGVqYohIJzyH8iuec9nT7bSbEA270zcabHFYX2u7Jx
         sWy7Wo1SK5Tqy2y6+nhqg9H26K2y7GQrKKFEV9Alf/rAuL84m8Tanzmo3qM0CTVnTw3X
         7E8jfIbjhByd939/KfGWTcP6jCGQBUVUMlP3M6VEWX6B5+zZIhMd4FpamK5vq8z1MbQ0
         8XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcWN0y3xpOfOqMBy6AjaImaPeMb1HRl0zQd1eTyjsNA=;
        b=w1azbZ5SHSu3DbCUyk99pV0ciaoMtnhNuf9k9qLJmA65Wq51qnPYaGAFkLpILeruT2
         HdF3z/oQsgqjIEcCboNBbR2AJG1AOdGQBugSvAgwNCAdOJjEOfLpyh4zMyjQELhcNd1z
         Q+RPtEd0akOKA3T9qCAXIj4TqXOU1uQQiQU2R3RI8TbPvXAkuNWgHBnhwLZHLZlorzaI
         9lLBot+lHsFosaN8pH5+BJ2bZTGrPyrFBV9Vv6b9kEVRbroBTfCniWF+2fd/J3N2LdBu
         Evd6qzRccc19/GCaI6XMang+/RuMXjIMfS44OwGf5iUQTf9FFq9LVNEoqOMwoJZL2trd
         LuDA==
X-Gm-Message-State: AO0yUKULfRSnU62p7K89NjnzGWqzVB7YulOPr+bbi9XjrPHFZXI+4L8f
        HgxgeXXuXrzptzFCAbGbSk43K5I0JhQ=
X-Google-Smtp-Source: AK7set9XYdrL5W+zcqWIZrKCKUblIZrputfNirpDio3HQLFg9VR+EqHoItxjjfhClpGhyqTLvQv9Xg==
X-Received: by 2002:adf:ffc7:0:b0:2c8:6fea:21b1 with SMTP id x7-20020adfffc7000000b002c86fea21b1mr1647037wrs.62.1677291969943;
        Fri, 24 Feb 2023 18:26:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13-20020a056000100d00b002c6e84cadcbsm387873wrx.72.2023.02.24.18.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:09 -0800 (PST)
Message-Id: <36ca49c36242384a74c288389c27e5690fc73565.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:58 +0000
Subject: [PATCH v2 09/11] unpack-trees: rewrap a few overlong lines from
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
index f5294194aa1..985896d6af6 100644
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


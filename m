Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EAC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjBWJPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjBWJP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BD497D1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v3so9992541wrp.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDo59bBPiRzBnM6vJCvYq4gUWR3UC2XRfjdGAdghZ0E=;
        b=GSwqfxNsWCzpX3jV+D0HJDBknw5n9ELGx7rS9dr8rkNHdV5f7LIOdPsb7/Oq2+Y0wy
         wkZhMBHBwrb6GoFKUvrnVkXK2BuCAQipjx4yf3TywGX7y+9nLZohQVNADhpQxSP7DDiu
         zBd96WMMgPyl5CqEFutizIQoJFEOADgK8PhMIFiDCuWz0cUZnQrPQ84F2MWtkXCZR5kY
         HbHx1pSzgtI4KGuh5omQKgK+oN8X6XGxaQXj786DWDXLJHf2h2v8ajA4k1EpxDGf8Qb5
         SCVHXvWq24UP6zn39k7FJzv+Q4C4e0uLLGLauOW0KIsA82iCZ+UXrn2VjJCiLSSSwN8Q
         96/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDo59bBPiRzBnM6vJCvYq4gUWR3UC2XRfjdGAdghZ0E=;
        b=bWOnP5ZxNRE0tZJUnrl3pbfhnlo+3XGNduHblAcoSWkv/J70ZKhyxUY50hT4aIB0CY
         sHuBu7MAEIoVTNHX44vBQ3oVANH4YCet60sHYtZkeB7E7pFUjPsIcd9CPkwMdW/0ZWMm
         cE9WyF5Bl0k4tbCIprPNWywunNiKwb3zKm24f82mozGVT7XdHmEH1HfZq6wNsA2VVYJO
         ckqnrwlEdSt77AnjQ2rajifq2f6ebAWsrrghUq7bra++ehdY4eErDoI1EXVCdn5moTgo
         0mN1PDQCwVjOvCA4A5v/BVnFRm4ZTBMOjnRsPxhRL8edZtgpoo0CGpuheeqjWVwf07aa
         a7ZA==
X-Gm-Message-State: AO0yUKVi8WfKwjOJOQq9xOEYOp6GoWeFVArtJnaiueXZ2EWM+0BsDa5/
        4pC3oyhGw4yVKFoZz8dG3d/Hx56mMOA=
X-Google-Smtp-Source: AK7set/TowFBAi0avoDvQHTxou0OyH1d63hMtxi+TrLXzIXAcMOLdeskBfwysmVZd8+z6jSSfPlYlQ==
X-Received: by 2002:a5d:68c8:0:b0:2c5:a742:572f with SMTP id p8-20020a5d68c8000000b002c5a742572fmr7857937wrw.49.1677143709846;
        Thu, 23 Feb 2023 01:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b002c57384dfe0sm11735591wrt.113.2023.02.23.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:09 -0800 (PST)
Message-Id: <efec74c8b497998d6a4866b6ed4de4fbe22680c4.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:15:00 +0000
Subject: [PATCH 11/11] unpack-trees: add usage notices around
 df_conflict_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Avoid making users believe they need to initialize df_conflict_entry
to something (as happened with other output only fields before) with
a quick comment and a small sanity check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 2 ++
 unpack-trees.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 60b6e38fd69..583132f1510 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1876,6 +1876,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		BUG("o->internal.dir is for internal use only");
 	if (o->internal.pl)
 		BUG("o->internal.pl is for internal use only");
+	if (o->df_conflict_entry)
+		BUG("o->df_conflict_entry is an output only field");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
diff --git a/unpack-trees.h b/unpack-trees.h
index e8737adfeda..61c06eb7c50 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -78,7 +78,7 @@ struct unpack_trees_options {
 
 	int head_idx;
 
-	struct cache_entry *df_conflict_entry;
+	struct cache_entry *df_conflict_entry; /* output only */
 	void *unpack_data;
 
 	struct index_state *dst_index;
-- 
gitgitgadget

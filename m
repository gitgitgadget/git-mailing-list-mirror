Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226CC6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBYC0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC6765CDC
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso117925wmb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIyk4EcpxCfWVZ94yemBZYXo/BPVimx3khZEZfuK7HI=;
        b=cWXjN/s09CMM5hztAbzpEtBa79sBTNSzaJyDI+hleW7g1kEBbFchEEaeK2qifD78G0
         ItuSKL1nyUFYA2ZshzunulJaHmSVLvgGrVjZ37J58Ah8+mCeU5eubnaGAsv6Ov7qTOle
         tvKBeK+ceUF3xhd8SWKh/4vXoes689HkULU2hL68S6hfdap9QtxJpN1/Otu04rAepNi2
         yZY+EWIB9E5VMU506yQCfhSEr842ItVhtnmCfAevlkY+rMPPLWsB6LP0m/SQCmnkdNsG
         LcHf0oUflq9nyZeewh9QmTwOx44yT5DGTTHLnmji1Nk0MVhCYMf538WjnW63xwiUwB7a
         yt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIyk4EcpxCfWVZ94yemBZYXo/BPVimx3khZEZfuK7HI=;
        b=Lg4mpwX90MsvozIzIACUEK6/0VY9oVGfg2f14pHpbSPLMELX2CV57Un26xEnDMq7Sw
         CotqBF8IDnE4GgRPUoz5zER70XfLyOmHiLZ7BQrGYjiowLto0yMjnm0PoNQnk0rvnBzr
         8QbbsY2q+oWBLa1Ez9x8UYblZwjytTOG4G7K/VameeRIblC13TvybR/rqna/y+ijzxoc
         +/7EdCDeKO0c1N88clF62uG8xCvDpEDPTsQE/DXe9bFtASP14EWijmj0mz1BY/5+kxXV
         M9EVO+a9ja8MWjzL3CU1nX5WWvvmJgSwokZlP6b988exZcLcE2gNa2BWI2zE0kVrKFix
         hyVQ==
X-Gm-Message-State: AO0yUKU+t/NjRGDocuUuKoop1VtCTnT2gCOaaolE2mVudyN0iPWtCzON
        m/FlJ6Ra/GpYhrGQ0dYXkRB0ztRBaXY=
X-Google-Smtp-Source: AK7set/jT5hj21FiLrw3N21zu8VfKU5lLXIhRwYcrP71kktH7Gwz8ynJ1Mk7w8BNt7QhYyxpLpx18w==
X-Received: by 2002:a05:600c:a293:b0:3eb:29fe:7baa with SMTP id hu19-20020a05600ca29300b003eb29fe7baamr2795179wmb.34.1677291971470;
        Fri, 24 Feb 2023 18:26:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c510600b003e20a6fd604sm1044164wms.4.2023.02.24.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:11 -0800 (PST)
Message-Id: <c4f31237634023f872ea4e68e53b6c54cdd5ca7a.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:26:00 +0000
Subject: [PATCH v2 11/11] unpack-trees: add usage notices around
 df_conflict_entry
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

Avoid making users believe they need to initialize df_conflict_entry
to something (as happened with other output only fields before) with
a quick comment and a small sanity check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 2 ++
 unpack-trees.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e58f0f6a867..aafc5eca791 100644
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

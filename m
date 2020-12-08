Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82431C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F5523A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgLHAGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:12 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93546C06138C
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:26 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h18so10331374otq.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WoZWPxmAj0x1vYLK6v7ZELgMGpSwPf3gkePQcJB85eg=;
        b=Ul/q6hcyDBq/04VPQ0miufuF0f834SOUJSRrziAnr+BAYvY0P+LPs3NsHrSpXY5riF
         KtJRXGjpcNA/8iPgQy2nGSLWNsNt7MoePiWkBr0goDTzBFBuGaQawrU0lpNREyZPEv7n
         a1PRIDJpylnoZR5KRSbzGAsvT7sX83Pw0AjQUM1k6suRwZhfNR1l8KyMo+TWbGMeOIL1
         RaT2t3hZZbEW+UHk+rQaWo/Tgu3ldbgSt6Uz+hcr4rkZEtoP5f4Jz2K7jH4U8O0+WG9m
         tc1HGsfn17aO2YfGso3Jz5rkoecnYOz5Duve+Sb/LoAoO6141shMWZvG02/E438QtrSB
         EWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoZWPxmAj0x1vYLK6v7ZELgMGpSwPf3gkePQcJB85eg=;
        b=kj1f2IkiQgKAORSceYz3jGCsT149uKgtLj56Q8FG/wMOzPbAZM8TUaEBpJD5gXUMdw
         iyozhEj/egQJvUEINlOmZNyq5MiNDwzVvvNCjRR4BlBfeH1FwaVgj8+yTidogeqievVx
         0eZN0je7kckJTmJ56ZUyDvBtz43HGO8rTAMe5KC5VFjX/Bi2PcgGGs3ttW0PlsY0KG8K
         qRhB9B+MSRAVWmR97Z81H8mO4PRt7DgVUQEGvPPSyoK0OCGK8+BWB5iRvD8niFk46wht
         ds/et1/rlp9e/u/sEolWrHgDiXbUpAok3ntxtqMTIz5vTFhJX5MS4VnzDePYK/QZvgtM
         PODA==
X-Gm-Message-State: AOAM530jpzYffaN9tn9piRh2+wCvIk9E38aTadABDUm8cfNtthDsPEYF
        Zt5rbuwpjsMZLsueal9/Z5yrYaSAutRBiekw
X-Google-Smtp-Source: ABdhPJyBs1hsp0LEHSnOK8P1F+JQ8XO1m0xRiXzeqwV5K8WVbB+oXeHfbWpT6Lxw3Sue24LiLZT/Uw==
X-Received: by 2002:a9d:590c:: with SMTP id t12mr14696415oth.308.1607385925762;
        Mon, 07 Dec 2020 16:05:25 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h2sm3028319otn.15.2020.12.07.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:25 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 16/24] pack-bitmap-write: rename children to reverse_edges
Message-ID: <c0e2b6f5d9eaa4c20047287637a1f6f0e3000ab9.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_builder_init() method walks the reachable commits in
topological order and constructs a "reverse graph" along the way. At the
moment, this reverse graph contains an edge from commit A to commit B if
and only if A is a parent of B. Thus, the name "children" is appropriate
for for this reverse graph.

In the next change, we will repurpose the reverse graph to not be
directly-adjacent commits in the commit-graph, but instead a more
abstract relationship. The previous changes have already incorporated
the necessary updates to fill_bitmap_commit() that allow these edges to
not be immediate children.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 957639241e..7e218d02a6 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -179,7 +179,7 @@ static void compute_xor_offsets(void)
 }
 
 struct bb_commit {
-	struct commit_list *children;
+	struct commit_list *reverse_edges;
 	struct bitmap *bitmap;
 	unsigned selected:1;
 	unsigned idx; /* within selected array */
@@ -228,7 +228,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		for (p = commit->parents; p; p = p->next) {
 			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
-			commit_list_insert(commit, &ent->children);
+			commit_list_insert(commit, &ent->reverse_edges);
 		}
 	}
 }
@@ -358,7 +358,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			display_progress(writer.progress, nr_stored);
 		}
 
-		while ((child = pop_commit(&ent->children))) {
+		while ((child = pop_commit(&ent->reverse_edges))) {
 			struct bb_commit *child_ent =
 				bb_data_at(&bb.data, child);
 
-- 
2.29.2.533.g07db1f5344


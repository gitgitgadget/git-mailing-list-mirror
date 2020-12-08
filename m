Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD7C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6151D23A04
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgLHAGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLHAGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:13 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B0C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:05:52 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so14285448otl.11
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8jjZe/eZNNaHHg17+lxlVYaOvNcp9G5BR/nfwQZ4yI=;
        b=tTwv5usyX1pfDBiWgFg8niTWEnnEQeWW4Cw5Og6rtQH5JE+m+auiwl1gq1E8lWG5Hb
         S9IrsMiH8vnHanxbtN6rJm2a0tcOIGlLtxqXFYZFQQW3A7lipV6s4xR9MuCPWkU11Efz
         mk05F969rcqCUwLszwYEEYcUB5WEfv7ekv3l25kR6ywbuXDX2bmZE7WZlLmxhUzi96RV
         Uy4flrfp5mKVcNk/45mvwLFchMmI78Mo1ferzd+1qD0XgTAO2tiG2HE/B6lOmJWpJ3BY
         38VapbkvlvuCR1bHB+J56PyGsgmb6BeI6R7YeXm8MJ1s127CRsnNmylVyRhV8z7rpd5S
         MPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8jjZe/eZNNaHHg17+lxlVYaOvNcp9G5BR/nfwQZ4yI=;
        b=QfK2+7LpDj5o0MqveFx3K1pzHjYnbZGGrdB0de6q0bPY7U3QZ9Q4rCMp4xaX/tPfY8
         nzI3Ygk+bLQuV004YQhjoKJbYHUBie5EKX8uEKbVO+C6ex6VpfhX/AmtZnKboCLe8K39
         bqXsCHAgJ4y32qlClZtFh2NTHhYCfbSGkotLCybtfPvnkAY7wocPOqWOHp6zopUmZFne
         1Nn0skf7nXRHY2XfAlCNbW6A+hF+2McT6U696zy5tKKCTvqlf3i+nQxNFL0Xvs5ESLbu
         +UlqGtBMVUX1B0BqVUwl+xJp+26Y1PzBWU+i5InCndv5z9BIo11wpNgfUFM/0H8Z2png
         CWIw==
X-Gm-Message-State: AOAM532WH5HuP7I0lGzFyjud8qYP9QWWOY4TYtvUgC0HcsJ/d5jrS9iX
        tRzaem918EHUpn3rq4ezFkZ+yxFpr9q6VAvo
X-Google-Smtp-Source: ABdhPJywnavjtJpfJYpherdLJOYaNwZiQ34N2ZE+TgZfIOEsiRueOMs12+js9aArafQulMWKP8UEog==
X-Received: by 2002:a9d:1725:: with SMTP id i37mr14869746ota.258.1607385951588;
        Mon, 07 Dec 2020 16:05:51 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k3sm1709878oor.19.2020.12.07.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:05:51 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 22/24] pack-bitmap-write: use existing bitmaps
Message-ID: <c6fde2b0c4d47b5f460b5b8d8ca84e155da37414.1607385833.git.me@ttaylorr.com>
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

When constructing new bitmaps, we perform a commit and tree walk in
fill_bitmap_commit() and fill_bitmap_tree(). This walk would benefit
from using existing bitmaps when available. We must track the existing
bitmaps and translate them into the new object order, but this is
generally faster than parsing trees.

In fill_bitmap_commit(), we must reorder thing somewhat. The priority
queue walks commits from newest-to-oldest, which means we correctly stop
walking when reaching a commit with a bitmap. However, if we walk trees
interleaved with the commits, then we might be parsing trees that are
actually part of a re-used bitmap. To avoid over-walking trees, add them
to a LIFO queue and walk them after exploring commits completely.

On git.git, this reduces a second immediate bitmap computation from 2.0s
to 1.0s. On linux.git, we go from 32s to 22s. On chromium's fork
network, we go from 227s to 198s.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 333058854d..76c8236f94 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -340,20 +340,37 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 
 static void fill_bitmap_commit(struct bb_commit *ent,
 			       struct commit *commit,
-			       struct prio_queue *queue)
+			       struct prio_queue *queue,
+			       struct prio_queue *tree_queue,
+			       struct bitmap_index *old_bitmap,
+			       const uint32_t *mapping)
 {
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
-	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
 	prio_queue_put(queue, commit);
 
 	while (queue->nr) {
 		struct commit_list *p;
 		struct commit *c = prio_queue_get(queue);
 
+		if (old_bitmap && mapping) {
+			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
+			/*
+			 * If this commit has an old bitmap, then translate that
+			 * bitmap and add its bits to this one. No need to walk
+			 * parents or the tree for this commit.
+			 */
+			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
+				continue;
+		}
+
+		/*
+		 * Mark ourselves and queue our tree. The commit
+		 * walk ensures we cover all parents.
+		 */
 		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
-		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
+		prio_queue_put(tree_queue, get_commit_tree(c));
 
 		for (p = c->parents; p; p = p->next) {
 			int pos = find_object_pos(&p->item->object.oid);
@@ -363,6 +380,9 @@ static void fill_bitmap_commit(struct bb_commit *ent,
 			}
 		}
 	}
+
+	while (tree_queue->nr)
+		fill_bitmap_tree(ent->bitmap, prio_queue_get(tree_queue));
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -386,6 +406,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	size_t i;
 	int nr_stored = 0; /* for progress */
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+	struct prio_queue tree_queue = { NULL };
+	struct bitmap_index *old_bitmap;
+	uint32_t *mapping;
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -395,6 +418,12 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
 
+	old_bitmap = prepare_bitmap_git(to_pack->repo);
+	if (old_bitmap)
+		mapping = create_bitmap_mapping(old_bitmap, to_pack);
+	else
+		mapping = NULL;
+
 	bitmap_builder_init(&bb, &writer);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
@@ -402,7 +431,8 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit, &queue);
+		fill_bitmap_commit(ent, commit, &queue, &tree_queue,
+				   old_bitmap, mapping);
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -428,7 +458,9 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		ent->bitmap = NULL;
 	}
 	clear_prio_queue(&queue);
+	clear_prio_queue(&tree_queue);
 	bitmap_builder_clear(&bb);
+	free(mapping);
 
 	trace2_region_leave("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
-- 
2.29.2.533.g07db1f5344


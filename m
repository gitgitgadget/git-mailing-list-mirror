Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF73FC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ED62087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zfqJgWRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgKKTn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:43:29 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3844C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:27 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so1530192qvy.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eA8mts39wLjLDb5MEYgDHjwZHfJ1yYnd4tkZbI/5PSE=;
        b=zfqJgWRpoDrira+jtFKdmeZn6VJ1XdJUhCqYh5TSYb/93VNctvM3T8BAPwD1zStJsR
         T6Ysi85BcbB1YQsofjCRZ99AIQ8EQ2hJDlMKmZhNGEiYeJwBTWavp0G8Ab9vGWHWkO2b
         gjtNPGMmHXW8ammhqlavUfDxD+bhlkl5AlqnDpRtx0+0YxMeaDJHs2jxAh6tMTI4bLqW
         c4plBzN1i9I8Jd5pLolhYgzSWrVcLB7M+TqRHgG6ydIj/qsl2zEtuaPVkIEz7VMq7n4B
         Wl4nQRNwZ96bcDSPDM6YYORgrWfVwwfk+6FoZMU/GrVUMkg/JE5X7rmUbsOh8T7vD1w8
         3uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eA8mts39wLjLDb5MEYgDHjwZHfJ1yYnd4tkZbI/5PSE=;
        b=aQ4Oyj2+IXFqhYVd9c/AiuZj38YtnmfSmsCd+UJfWzjF2GZzmaGVBmNnjnU4BjadMo
         JlWD4hDF/t8759ZvhpuUikf689ufYBkaGAO9O5GqSYhpJJdEiGg5dQB9GkD2wP1bQZmv
         ILB85pXZfK9EJGroqDAd90EObDmbs/SCXsETlRWgjckr3QZF+2BO0MwpUAlkHiRrASN4
         s1rlhjkqNLacivHTjqbA2cevZGnJhc1aNRJGLnRGL/ADBj0AcGaLH8T10zhVXT0NB8/O
         wgburE7CGoC9qPNHSxz3mqmqwoWAYH9pLVdvlcWjmy8fk/OboOiIPIEcCk9O4W+TYdzr
         5AzQ==
X-Gm-Message-State: AOAM533wMqrIqyc1+nVSWaGjG3SSBytfkWR76ONmpkAAiuK+EIxCE/rC
        +Jqh5D4K2EB54g94FTC7LrKQ6BzwxrMTyWKR
X-Google-Smtp-Source: ABdhPJyNO2W2j/EGYWSbptwBPLbNoXqvlNOr7dAqCigXYztGdgLeIxdEIGVGdHnrtdbpAdisUG96Ag==
X-Received: by 2002:ad4:470d:: with SMTP id k13mr25141849qvz.40.1605123806964;
        Wed, 11 Nov 2020 11:43:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id 82sm3038643qke.76.2020.11.11.11.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:43:26 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:43:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 12/23] pack-bitmap-write: fill bitmap with commit history
Message-ID: <88e7988751fca329a8e453727c614fdfbbba426a.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fill_bitmap_commit() method assumes that every parent of the given
commit is already part of the current bitmap. Instead of making that
assumption, let's walk parents until we reach commits already part of
the bitmap. Set the value for that parent immediately after querying to
save time doing double calls to find_object_pos() and to avoid inserting
the parent into the queue multiple times.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d2d46ff5f4..361f3305a2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -12,6 +12,7 @@
 #include "sha1-lookup.h"
 #include "pack-objects.h"
 #include "commit-reach.h"
+#include "prio-queue.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -279,17 +280,30 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
 }
 
 static void fill_bitmap_commit(struct bb_commit *ent,
-			       struct commit *commit)
+			       struct commit *commit,
+			       struct prio_queue *queue)
 {
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
-	/*
-	 * mark ourselves, but do not bother with parents; their values
-	 * will already have been propagated to us
-	 */
 	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
-	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
+	prio_queue_put(queue, commit);
+
+	while (queue->nr) {
+		struct commit_list *p;
+		struct commit *c = prio_queue_get(queue);
+
+		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
+		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
+
+		for (p = c->parents; p; p = p->next) {
+			int pos = find_object_pos(&p->item->object.oid);
+			if (!bitmap_get(ent->bitmap, pos)) {
+				bitmap_set(ent->bitmap, pos);
+				prio_queue_put(queue, p->item);
+			}
+		}
+	}
 }
 
 static void store_selected(struct bb_commit *ent, struct commit *commit)
@@ -319,6 +333,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	struct bitmap_builder bb;
 	size_t i;
 	int nr_stored = 0; /* for progress */
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
@@ -335,7 +350,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 		struct commit *child;
 		int reused = 0;
 
-		fill_bitmap_commit(ent, commit);
+		fill_bitmap_commit(ent, commit, &queue);
 
 		if (ent->selected) {
 			store_selected(ent, commit);
@@ -360,6 +375,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			bitmap_free(ent->bitmap);
 		ent->bitmap = NULL;
 	}
+	clear_prio_queue(&queue);
 	bitmap_builder_clear(&bb);
 
 	stop_progress(&writer.progress);
-- 
2.29.2.156.gc03786897f


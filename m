Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD147C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8179B241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZJ7d2AcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgKQVra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKQVra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:30 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8725C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so22347127qkk.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JsFhLQbh5EuSVPg83T6V+6+RMKHaLo4hNx2UNqp8ct4=;
        b=ZJ7d2AcGZ0Wlhv4hdlpsUliHRuJVkxB/bnwdlslqNDezoeksda7XVVwbPcPO+rmHY7
         hlXfWxPPTJykYnCuYfZtlomdjxWeKOR1TLs/QgqCoc/iK9qPsu4/ZdCE/nKVksL+332J
         BPl6lccz3xsUD7RXRI1o5HP+atkvbAvAuQp/A7hoLMccQFxYoorvQ/GYOp0Wv6eFNNxD
         RtEe/7ON2/wPkUHnIYFkJbSya40sgTkELaFUZxNwnZCgRbd41vz2iyGOB+BsQnL5ruWZ
         IAQvzY6/JdNRGISEXSElgbHUPS1fJ6ByjQwdKXxRnw0611TIQ8y5xB33fF2cEX6h82Vn
         XBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JsFhLQbh5EuSVPg83T6V+6+RMKHaLo4hNx2UNqp8ct4=;
        b=uBL0oQbuR5WcJ2c9sviejAytMAqWbyS7aTjCaQE+XzoFEzNZh31fWkKIVdofT7JOvI
         S9Jl472TDoUmjn4N5J2LDizfHhjpYpCuWuO6O5S+f0J1uGYGzdXmTZa/t9HksoKMVqdl
         SKTtF0WH+ptAIiPg3T4gnYYzfp8diVpMMgqGrtDHcvQL2BBsgfwfi9hGsmSQzgWt4u4q
         Psz+iafaCY45LmiLMWe0V41/IEY+IXGFKkGCNT14dfJOz5kXXB76ciYXc80UUIbMe+Gf
         sZLa5kVCqXGgHHo7nwAJuNdjoWMdD1Hcpo7/ohf1+2mjc7/k/7hT0btEgleXl89DD4Wl
         B35g==
X-Gm-Message-State: AOAM530Ev//YsnnwowGzVW7MOAOVxe5dQitG98VDZFg4c7rEFsNwllg7
        +yXIHQWWrTJXIsfe/zcYzuJoLX03VTUxcjpm
X-Google-Smtp-Source: ABdhPJxBvcG73kKw4OVaxiQ26sxTIXYZcuH2dZ7k7jrJbKJ7lSKbFJuR5JvyUKlNu0tgKijDC/WeyA==
X-Received: by 2002:a05:620a:1087:: with SMTP id g7mr1702402qkk.457.1605649647528;
        Tue, 17 Nov 2020 13:47:27 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id i4sm3563999qti.78.2020.11.17.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit history
Message-ID: <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
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
2.29.2.312.gabc4d358d8


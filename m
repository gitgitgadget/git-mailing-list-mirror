Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8354C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D95B241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fXBns2uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgKQVsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgKQVsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:48:37 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE4C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:36 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so17108990qtp.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+oflGXLl8xWYLzNnpWt2kvd3xic8KRtedehKZGIHmA=;
        b=fXBns2ukmUVEECWBVda5xJLCvUYcwKlqZ8iF7scXQaVevKVSp37KlI8qOg/Ruks3IJ
         f/sn5R6KwlEsxts5JB49popu2Gly4UwfsNNyhRjwp2ZCY3PsbmYGnegjAce0M1u1ROzs
         vtMG6Y/CCx8fQUEMFLbU85vR3wEvY3UVTDmoa3VLiMHSanrCXTJOKWoC3we6wFa9RtFE
         T+RidtUUhmm5A2XPqs1THxxXSvzh+FmQkmLvfwNyIcBoSLDk9iARUD2InXzrXo4+fgn7
         5luIK65GJNnamvm3gl+PK/AoLFPpNdEhs1UUgpO4KjGFms7SeBkf6YXvxfvaRNW3wO8E
         jdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+oflGXLl8xWYLzNnpWt2kvd3xic8KRtedehKZGIHmA=;
        b=r3XkpI2aloOyE85aNcDQwamLW1dHWToUO3cx5wIb9kPOE9WdLUte9Ti2jMbpxmmN94
         OSROY95ZcOXgp6t9qovwuW+NyzU55OcQykb9WPWfuqbiso37kkCxPP48mVJgI+HG2Ppt
         R/pZzjhTdm6DkDqQzkUF8spVCNO7SP/KfcwHfJLZ974och9RL4Ente3BKALw+JDiG6gE
         kNCc+BM0i5DP5zp15J9PvXIRwraBF2l8UpjlzMU9rSVmHB90Ng5KH7Ox1bkuCUkV5RTN
         77pjSjLzAK7HYiJ0pDg9Msq3jRG6DXdx/Y8vnAv6tQTitm+NPM7hJeLYOSjQ6AWBPj/e
         0Dhw==
X-Gm-Message-State: AOAM533+Oc8zapaoCkNnpZnl2khLK5bFP9raGOU8MCT6w/hH6jePqAoL
        5HRkNZDdAKdpGiWiCuaam0MO7D50NrwToHyI
X-Google-Smtp-Source: ABdhPJxlz+1xpkDXwJHNlfi1rF9KEXe88XjeF782jkjNHq/4ybXy7kD3FKP1AR+OtA2v+uMJPDqRhw==
X-Received: by 2002:ac8:4250:: with SMTP id r16mr1891647qtm.225.1605649715034;
        Tue, 17 Nov 2020 13:48:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id v32sm4943673qtb.42.2020.11.17.13.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:48:34 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:48:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
Message-ID: <1da4fa0fb85fe848aa86987e767b33d296f8f878.1605649533.git.me@ttaylorr.com>
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

The previous commits improved the bitmap computation process for very
long, linear histories with many refs by removing quadratic growth in
how many objects were walked. The strategy of computing "intermediate
commits" using bitmasks for which refs can reach those commits
partitioned the poset of reachable objects so each part could be walked
exactly once. This was effective for linear histories.

However, there was a (significant) drawback: wide histories with many
refs had an explosion of memory costs to compute the commit bitmasks
during the exploration that discovers these intermediate commits. Since
these wide histories are unlikely to repeat walking objects, the benefit
of walking objects multiple times was not expensive before. But now, the
commit walk *before computing bitmaps* is incredibly expensive.

In an effort to discover a happy medium, this change reduces the walk
for intermediate commits to only the first-parent history. This focuses
the walk on how the histories converge, which still has significant
reduction in repeat object walks. It is still possible to create
quadratic behavior in this version, but it is probably less likely in
realistic data shapes.

Here is some data taken on a fresh clone of the kernel:

             |   runtime (sec)    |   peak heap (GB)   |
             |                    |                    |
             |   from  |   with   |   from  |   with   |
             | scratch | existing | scratch | existing |
  -----------+---------+----------+---------+-----------
    original |  64.044 |   83.241 |   2.088 |    2.194 |
  last patch |  44.811 |   27.828 |   2.289 |    2.358 |
  this patch | 100.641 |   35.560 |   2.152 |    2.224 |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c     | 14 +++++---------
 t/t5310-pack-bitmaps.sh | 27 ++++++++++++++-------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 37204b691c..b0493d971d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -199,7 +199,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 {
 	struct rev_info revs;
 	struct commit *commit;
-	unsigned int i, num_maximal;
+	unsigned int i, num_maximal = 0;
 
 	memset(bb, 0, sizeof(*bb));
 	init_bb_data(&bb->data);
@@ -207,6 +207,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	reset_revision_walk();
 	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
 	revs.topo_order = 1;
+	revs.first_parent_only = 1;
 
 	for (i = 0; i < writer->selected_nr; i++) {
 		struct commit *c = writer->selected[i].commit;
@@ -221,13 +222,12 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		add_pending_object(&revs, &c->object, "");
 	}
-	num_maximal = writer->selected_nr;
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&revs))) {
-		struct commit_list *p;
+		struct commit_list *p = commit->parents;
 		struct bb_commit *c_ent;
 
 		parse_commit_or_die(commit);
@@ -235,16 +235,12 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 		c_ent = bb_data_at(&bb->data, commit);
 
 		if (c_ent->maximal) {
-			if (!c_ent->selected) {
-				bitmap_set(c_ent->commit_mask, num_maximal);
-				num_maximal++;
-			}
-
+			num_maximal++;
 			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
 			bb->commits[bb->commits_nr++] = commit;
 		}
 
-		for (p = commit->parents; p; p = p->next) {
+		if (p) {
 			struct bb_commit *p_ent = bb_data_at(&bb->data, p->item);
 			int c_not_p, p_not_c;
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 1691710ec1..a83e7a93fb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -43,23 +43,24 @@ has_any () {
 #                                   \|
 #                                    * (base)
 #
+# We only push bits down the first-parent history, which
+# makes some of these commits unimportant!
+#
 # The important part for the maximal commit algorithm is how
 # the bitmasks are extended. Assuming starting bit positions
-# for master (bit 0) and other (bit 1), and some flexibility
-# in the order that merge bases are visited, the bitmasks at
-# the end should be:
+# for master (bit 0) and other (bit 1), the bitmasks at the
+# end should be:
 #
 #      master: 1       (maximal, selected)
 #       other: 01      (maximal, selected)
-# octo-master: 1
-#  octo-other: 01
-# merge-right: 111     (maximal)
-#        (l1): 111
-#        (r1): 111
-#  merge-left: 1101    (maximal)
-#        (l2): 11111   (maximal)
-#        (r2): 111101  (maximal)
-#      (base): 1111111 (maximal)
+#      (base): 11 (maximal)
+#
+# This complicated history was important for a previous
+# version of the walk that guarantees never walking a
+# commit multiple times. That goal might be important
+# again, so preserve this complicated case. For now, this
+# test will guarantee that the bitmaps are computed
+# correctly, even with the repeat calculations.
 
 test_expect_success 'setup repo with moderate-sized history' '
 	test_commit_bulk --id=file 10 &&
@@ -113,7 +114,7 @@ test_expect_success 'full repack creates bitmaps' '
 	ls .git/objects/pack/ | grep bitmap >output &&
 	test_line_count = 1 output &&
 	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
-	grep "\"key\":\"num_maximal_commits\",\"value\":\"111\"" trace
+	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
 '
 
 test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
-- 
2.29.2.312.gabc4d358d8


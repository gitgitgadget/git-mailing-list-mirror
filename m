Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB0DC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635E4241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="JeonMeUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgKQVsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgKQVsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:48:43 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A67C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:41 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id u23so4175824qvf.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h62hnBTQj+3iLx4T5aRYU4yZUSJ3pyFT8cbw1VivSPY=;
        b=JeonMeUJsvOEUFeaRN3eNDVeV7J4sNR4elorMpofkQUYYFSXD+pFj0yuUY2tU2DlDm
         FYTUsLQoiPrD5ZnhOFoeNTA4wcqPmbeCW4UoIwzlv0up6XycpA7qNkvLgCHLEqsqvXJi
         qf312I907HfGT2iZRF4GYkCYL9zN+RfxksfDMuaRpJlnZ6nU6a8QUQQ9F9st58Wa1u9F
         mwGnOKd0Xp69JFxaiJ7nZEHX0h4HIAeZGnjoLtDmBPK5W7XlO2zxwFX5G+XMkz/Hq0ci
         OM3W7U1XzrdImBu/w/M/nn45Bw3jR44SWWUn0gSJXYhl64kY0UMvZV9aY/GkZWBY6Svh
         izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h62hnBTQj+3iLx4T5aRYU4yZUSJ3pyFT8cbw1VivSPY=;
        b=Pfd1ZcJQ6nFxx6pPyBVGCLIbjuxw8FQUrYj1luppk87auEdaTwuwyj1wRkGzurE7DG
         M+kKuZLL7tcDAvucje6OMZBj9jDz7G1aVGrQIsfHDfXcMPfvxFl64P5t1Gn3mrkuEDZr
         BR4jfYzrB1lozQbTkEMFt+tzzg1dhvhOQENiy5OZ6ytgsmCSDko3/84bxxeucAAR9aX8
         ywXcNddyYE5+gD7pexeieL1WJ0BiWgf+ZOdy4HEDjo6ZfPxLB8W0Swe5qea/4ins4OJz
         55EwkXlSdggXIsqrnJMLoQLzx7aY8+sM7oQwDhmyu/9O0PhqvEoLq/9e7sGp4gGih4Jg
         8hcw==
X-Gm-Message-State: AOAM532kbrBuZPlXsJyjDtTfnCF341Xb6WSYtgG7M9qMA0Tg29KpNwr6
        0Cjt154J2fOm+WnwtrEqiaKGx7WfwWfTB29P
X-Google-Smtp-Source: ABdhPJxxXfTgjjMsq+KVwGCRIZw/yqhv6bzwAE+jB7gXU0O/asKOTkeurG7ZJt3NYGDMJIEhGniQPg==
X-Received: by 2002:ad4:4745:: with SMTP id c5mr1535151qvx.2.1605649720915;
        Tue, 17 Nov 2020 13:48:40 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id 205sm15270396qki.50.2020.11.17.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:48:40 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:48:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
Message-ID: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
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

If the old bitmap file contains a bitmap for a given commit, then that
commit does not need help from intermediate commits in its history to
compute its final bitmap. Eject that commit from the walk and insert it
as a maximal commit in the list of commits for computing bitmaps.

This helps the repeat bitmap computation task, even if the selected
commits shift drastically. This helps when a previously-bitmapped commit
exists in the first-parent history of a newly-selected commit. Since we
stop the walk at these commits and we use a first-parent walk, it is
harder to walk "around" these bitmapped commits. It's not impossible,
but we can greatly reduce the computation time for many selected
commits.

             |   runtime (sec)    |   peak heap (GB)   |
             |                    |                    |
             |   from  |   with   |   from  |   with   |
             | scratch | existing | scratch | existing |
  -----------+---------+----------+---------+-----------
  last patch | 100.641 |   35.560 |   2.152 |    2.224 |
  this patch |  99.720 |   11.696 |   2.152 |    2.217 |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index b0493d971d..3ac90ae410 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -195,7 +195,8 @@ struct bitmap_builder {
 };
 
 static void bitmap_builder_init(struct bitmap_builder *bb,
-				struct bitmap_writer *writer)
+				struct bitmap_writer *writer,
+				struct bitmap_index *old_bitmap)
 {
 	struct rev_info revs;
 	struct commit *commit;
@@ -234,12 +235,26 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		c_ent = bb_data_at(&bb->data, commit);
 
+		if (old_bitmap && bitmap_for_commit(old_bitmap, commit)) {
+			/*
+			 * This commit has an existing bitmap, so we can
+			 * get its bits immediately without an object
+			 * walk. There is no need to continue walking
+			 * beyond this commit.
+			 */
+			c_ent->maximal = 1;
+			p = NULL;
+		}
+
 		if (c_ent->maximal) {
 			num_maximal++;
 			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
 			bb->commits[bb->commits_nr++] = commit;
 		}
 
+		if (!c_ent->commit_mask)
+			continue;
+
 		if (p) {
 			struct bb_commit *p_ent = bb_data_at(&bb->data, p->item);
 			int c_not_p, p_not_c;
@@ -422,7 +437,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	else
 		mapping = NULL;
 
-	bitmap_builder_init(&bb, &writer);
+	bitmap_builder_init(&bb, &writer, old_bitmap);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
-- 
2.29.2.312.gabc4d358d8

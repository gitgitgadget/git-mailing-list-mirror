Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7175DC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399B623A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLHAGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgLHAGm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:06:42 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBFC0617B0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:06:02 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id f132so3077617oib.12
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QL9l0cHKGO73C4wCfiM9Q7odgpoKI5hiF7YgL6COI5Y=;
        b=cMpmnObVKIJ5aFxX9S7oC7iG7UyeYj1Rhq/kjQfqmrczV24W/b3Z3csrKlwXAOPw3V
         cfzUuGLp18LQvG0i1RdU5dImsHblyIEPZSnKAWFK3MqNO0yyt6OJ93vaKywMtG3TthEb
         heg5um8d2tNPh43JLDquM7itHpHjX9mrrGB2bdomNtUPnG6+3MJp62PbPZKgM6Clonm6
         deT0MmycZ6hFq55+Kzbf2nxYKiVUC7QrPbOdu8JK3XBK/ysoVortczJrRJbpXMHaAMMu
         FxfvSzDhYS1Hv2+aGVx/xhofsZpsBddm6HSH15zHuyyAw1JkI0alvSlipkGiQLsph2V9
         UscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QL9l0cHKGO73C4wCfiM9Q7odgpoKI5hiF7YgL6COI5Y=;
        b=Kcc4hDQuNigs50qc1jReBuTFkKIFRId2NtVxSlDRKT5ybpOW/VHZnB87lzrgpRCR0r
         cKDid1lMzXQ0UCJqEYgHh6Bn729pivKg1CEtpv2jMZPb5C36WHW7Yaztpf6V61qy3eaq
         qRq9/BYgkbWtOL4sooiHMGsupwrXYm3GiP0ZREqReHcIHT76lq1sFWVud5viz2b1Tqar
         gBt/RIaAyt0Y41TbuCN6YfiuPHqKyOoG6SxXeeXiNO6Rvi1dzwHuliaTXvnYcVFkCthz
         6/GUNE7ygWvQ9/WsAFDNr5r9kx2yWj6Y84/fa/sCd8T7Ub6LxIeTCH/9WwpDY9wzI+4h
         9yrw==
X-Gm-Message-State: AOAM531n5fjw47F+vvpHhksuVmjXZb7OF2ut+XIz80+d1up1j3cVjHJf
        ZtM1vyFHkycwR85VedIVWAdzFaY3vAN3cCnI
X-Google-Smtp-Source: ABdhPJxhBLT0Mp7SzN6bbhxuriiwosv0/rxSVN6rWLLjPilzQFj7sp03CtcbJDZhJ4dPlQPtem3pFQ==
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr911954oij.153.1607385961388;
        Mon, 07 Dec 2020 16:06:01 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j46sm3108071oof.36.2020.12.07.16.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:06:00 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:05:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 24/24] pack-bitmap-write: better reuse bitmaps
Message-ID: <6b9950771e57bd89dadcddaee7f27269e6ded535.1607385833.git.me@ttaylorr.com>
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

If the old bitmap file contains a bitmap for a given commit, then that
commit does not need help from intermediate commits in its history to
compute its final bitmap. Eject that commit from the walk and insert it
into a separate list of reusable commits that are eventually stored in
the list of commits for computing bitmaps.

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
  last patch |  88.478 |   53.218 |   2.157 |    2.224 |
  this patch |  86.681 |   16.164 |   2.157 |    2.222 |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d2af4a974f..cc5ead9990 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -195,10 +195,13 @@ struct bitmap_builder {
 };
 
 static void bitmap_builder_init(struct bitmap_builder *bb,
-				struct bitmap_writer *writer)
+				struct bitmap_writer *writer,
+				struct bitmap_index *old_bitmap)
 {
 	struct rev_info revs;
 	struct commit *commit;
+	struct commit_list *reusable = NULL;
+	struct commit_list *r;
 	unsigned int i, num_maximal = 0;
 
 	memset(bb, 0, sizeof(*bb));
@@ -234,6 +237,31 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		c_ent = bb_data_at(&bb->data, commit);
 
+		/*
+		 * If there is no commit_mask, there is no reason to iterate
+		 * over this commit; it is not selected (if it were, it would
+		 * not have a blank commit mask) and all its children have
+		 * existing bitmaps (see the comment starting with "This commit
+		 * has an existing bitmap" below), so it does not contribute
+		 * anything to the final bitmap file or its descendants.
+		 */
+		if (!c_ent->commit_mask)
+			continue;
+
+		if (old_bitmap && bitmap_for_commit(old_bitmap, commit)) {
+			/*
+			 * This commit has an existing bitmap, so we can
+			 * get its bits immediately without an object
+			 * walk. That is, it is reusable as-is and there is no
+			 * need to continue walking beyond it.
+			 *
+			 * Mark it as such and add it to bb->commits separately
+			 * to avoid allocating a position in the commit mask.
+			 */
+			commit_list_insert(commit, &reusable);
+			goto next;
+		}
+
 		if (c_ent->maximal) {
 			num_maximal++;
 			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
@@ -278,14 +306,22 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 			}
 		}
 
+next:
 		bitmap_free(c_ent->commit_mask);
 		c_ent->commit_mask = NULL;
 	}
 
+	for (r = reusable; r; r = r->next) {
+		ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
+		bb->commits[bb->commits_nr++] = r->item;
+	}
+
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "num_selected_commits", writer->selected_nr);
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "num_maximal_commits", num_maximal);
+
+	free_commit_list(reusable);
 }
 
 static void bitmap_builder_clear(struct bitmap_builder *bb)
@@ -420,7 +456,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	else
 		mapping = NULL;
 
-	bitmap_builder_init(&bb, &writer);
+	bitmap_builder_init(&bb, &writer, old_bitmap);
 	for (i = bb.commits_nr; i > 0; i--) {
 		struct commit *commit = bb.commits[i-1];
 		struct bb_commit *ent = bb_data_at(&bb.data, commit);
-- 
2.29.2.533.g07db1f5344

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D621F404
	for <e@80x24.org>; Sun, 12 Aug 2018 05:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeHLHs4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 03:48:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeHLHs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 03:48:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so11489980wrt.1
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTAdx6zkeEChPubOWVhDOUx7JMIJax7tbgHokqu5/v0=;
        b=QoQ/qdJZ7YUygWBCxzCT4JCeRDZlPInEwUqXTlninJYXwIspUCNdhd95jeonYZeduj
         2W1+1UAkXgU45lGAUD/v3w8SxS6aCJOj1iwTwc8cXWVy6i8Ux5oiIM0MgIRwP+2JW1bp
         G7ZLxKon4hDu4eB1krCrPyRlBbF2e/4UM4Utry7yd0Os1xkNPDl79YeB7wFJkKjT8bC9
         R39JCeS7RvFUO6nzJdYR/wWHlAWUffe34jpVQa/P22qjrL+AR9p204hJCXhY4MDDGvJ2
         OxkjaH1lAE7g2v4fZaTiyAUwi8gyGGOTsCFgcsGZfov9rTpv4bCYX4p2x0g4B3fIYp0/
         5Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTAdx6zkeEChPubOWVhDOUx7JMIJax7tbgHokqu5/v0=;
        b=hiPuZQzjnZ+p9IhD7yaWOcttouZ57cjRgPxKVxh1vQaCn3zQwyZc4KlqqWZUCNO1MG
         2n5iGm8994zFxTK18EOk5r12+TZTsisEsDb/DW4apZvCIRG7zigGd0FUeNv3+js6McWX
         X24oeBBy4xPFyRssy+JfBFGkbyy5LPjvLeYYIHEYTtSDwmK+w8OSNsd+ASziE8sCXbJ9
         wpuX8z2z3yZrHWzHc+joi3++TjsAvr1dX5w3LvfU7hxe7H1nzVigyrBcIVzRvfoR7xX9
         HsiIOLXKSxfxIQlmp6IEIUQe37CUZu6M6vqa0EIdim2k1lE2OZA+smoaToSdAcjMQjx9
         ifog==
X-Gm-Message-State: AOUpUlHBgWrEn3F/sLyUSpBzvsyC1aD7/V1BpiDQX+j0Jd8A7E5xLE40
        qV7znJ3WMmgay8ciGVWQUYL1Xl9u
X-Google-Smtp-Source: AA+uWPwCtK/Wf1YbJBdkoleDjcetIT9BVA9iV6lWl7v5nZmhZJec+6cuKbqXGJpDfXImG0aAUcZf1g==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr8055352wrf.68.1534050733716;
        Sat, 11 Aug 2018 22:12:13 -0700 (PDT)
Received: from localhost.localdomain (228.14.112.78.rev.sfr.net. [78.112.14.228])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13281205wrv.90.2018.08.11.22.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 22:12:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER Gabor <szeder.dev@gmail.com>
Subject: [PATCH v4 2/7] pack-objects: refactor code into compute_layer_order()
Date:   Sun, 12 Aug 2018 07:11:46 +0200
Message-Id: <20180812051151.6425-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.554.gdb07901040.dirty
In-Reply-To: <20180812051151.6425-1-chriscool@tuxfamily.org>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following commit, as we will use delta islands, we will
have to compute the write order for different layers, not just
for one.

Let's prepare for that by refactoring the code that will be
used to compute the write order for a given layer into a new
compute_layer_order() function.

This will make it easier to see and understand what the
following changes are doing.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 90 +++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4391504a91..99b6329399 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -667,48 +667,15 @@ static void add_family_to_write_order(struct object_entry **wo,
 	add_descendants_to_write_order(wo, endp, root);
 }
 
-static struct object_entry **compute_write_order(void)
+static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 {
-	unsigned int i, wo_end, last_untagged;
-
-	struct object_entry **wo;
+	unsigned int i, last_untagged;
 	struct object_entry *objects = to_pack.objects;
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
-		objects[i].tagged = 0;
-		objects[i].filled = 0;
-		SET_DELTA_CHILD(&objects[i], NULL);
-		SET_DELTA_SIBLING(&objects[i], NULL);
-	}
-
-	/*
-	 * Fully connect delta_child/delta_sibling network.
-	 * Make sure delta_sibling is sorted in the original
-	 * recency order.
-	 */
-	for (i = to_pack.nr_objects; i > 0;) {
-		struct object_entry *e = &objects[--i];
-		if (!DELTA(e))
-			continue;
-		/* Mark me as the first child */
-		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
-		SET_DELTA_CHILD(DELTA(e), e);
-	}
-
-	/*
-	 * Mark objects that are at the tip of tags.
-	 */
-	for_each_tag_ref(mark_tagged, NULL);
-
-	/*
-	 * Give the objects in the original recency order until
-	 * we see a tagged tip.
-	 */
-	ALLOC_ARRAY(wo, to_pack.nr_objects);
-	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 	last_untagged = i;
 
@@ -717,7 +684,7 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
+			add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -727,7 +694,7 @@ static struct object_entry **compute_write_order(void)
 		if (oe_type(&objects[i]) != OBJ_COMMIT &&
 		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -736,7 +703,7 @@ static struct object_entry **compute_write_order(void)
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -744,8 +711,51 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (!objects[i].filled)
-			add_family_to_write_order(wo, &wo_end, &objects[i]);
+			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
+}
+
+static struct object_entry **compute_write_order(void)
+{
+	unsigned int i, wo_end;
+
+	struct object_entry **wo;
+	struct object_entry *objects = to_pack.objects;
+
+	for (i = 0; i < to_pack.nr_objects; i++) {
+		objects[i].tagged = 0;
+		objects[i].filled = 0;
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
+	}
+
+	/*
+	 * Fully connect delta_child/delta_sibling network.
+	 * Make sure delta_sibling is sorted in the original
+	 * recency order.
+	 */
+	for (i = to_pack.nr_objects; i > 0;) {
+		struct object_entry *e = &objects[--i];
+		if (!DELTA(e))
+			continue;
+		/* Mark me as the first child */
+		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
+		SET_DELTA_CHILD(DELTA(e), e);
+	}
+
+	/*
+	 * Mark objects that are at the tip of tags.
+	 */
+	for_each_tag_ref(mark_tagged, NULL);
+
+	/*
+	 * Give the objects in the original recency order until
+	 * we see a tagged tip.
+	 */
+	ALLOC_ARRAY(wo, to_pack.nr_objects);
+	wo_end = 0;
+
+	compute_layer_order(wo, &wo_end);
 
 	if (wo_end != to_pack.nr_objects)
 		die("ordered %u objects, expected %"PRIu32, wo_end, to_pack.nr_objects);
-- 
2.18.0.554.gdb07901040.dirty


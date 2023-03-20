Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A33C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCTL1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCTL1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729E659B
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j2so9967650wrh.9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxNPHIbuE6ximt61ltxINwr0w2o4l2tgeAo3kZNTTR0=;
        b=BtygJc8g9ts46UXbqILoyFgKgweILsfi/P/qaTKDc+aF/wV6FWfTpf55DoMF1DYkhQ
         Q+GaZmAlwx6xWrp/5lWJq/MGjcn+WwAPeQuMLyMUUzDKWIaa1Ut/71R+TKVz/WP2mjUC
         IhAkF5TxNth6Rqt/8UBDmA/aFuFl0jTPn8xGtFXJunrUEoF04VvsJLZJJ0NX2aQL1cgs
         pN5T5As5zPQKwiMDKqoM5+i3x7FrM7T0g7aSMMneWKhHXsj9hSkK4E8akj97CEL1oiS4
         fcEfM4rEFpvNpTLQxsM9+rjqCvu+toOFZajdTyVDTvZtLmNeFysmBpvp2RIKvO+vGIE3
         xKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxNPHIbuE6ximt61ltxINwr0w2o4l2tgeAo3kZNTTR0=;
        b=3Hnm7DABE6mSrl/FDecpGKdmmsr0BzZA4I5xTSpXkIXS7dCh+fJ9f1shCUrl46sy5l
         xolIrGzBE0zfsbZhZfw993sGC3xc4gpgp3AUIu0N5/nl+frOPdw54vaU0GXuz8Sdxku0
         lhQWh1q9JXvpkKKSPRdCCa/JfllJC1JRu/cFiWbE9tFgd9gX0upHZ/GMxIefAka3964W
         Azqy9GMiNqH+5gD1J91OINE0HNfpDowh/ep/syq+MEN4VZo3+6DTVdM5qRvRYgNWf4ab
         Zkm2jIVOBZrP5/jRWxGvPZN78yUT/R5P8tknT6NjLbSVWjdHp8SB2HFXFnjUY2AcCyM1
         9Elg==
X-Gm-Message-State: AO0yUKW4QrcKPLFd3MlCJpVtamnrKLXgcQpNONjroYr7EfAY7A+MqELE
        I7Ry1lDB6CsubLA8WX4zoigkYlUnlt0=
X-Google-Smtp-Source: AK7set+heD96jspSaF6ZdZ5UvTqLEHNKh9SGTGQZFowyjRAVAVr1CTnGxPo/kDi1HcmWszEukj/auQ==
X-Received: by 2002:adf:f1ce:0:b0:2d7:3cd3:85b2 with SMTP id z14-20020adff1ce000000b002d73cd385b2mr2046598wro.23.1679311620416;
        Mon, 20 Mar 2023 04:27:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b002c54e26bca5sm8700053wrs.49.2023.03.20.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:27:00 -0700 (PDT)
Message-Id: <3fd6c75812924e90075dba4f5eadba44f1eb03cb.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:50 +0000
Subject: [PATCH v4 4/9] commit-graph: simplify compute_generation_numbers()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the generic algorithm
compute_reachable_generation_numbers() and used it as the core
functionality of compute_topological_levels(). Now, use it as the core
functionality of compute_generation_numbers().

The main difference here is that we use generation version 2, which is
used in to toggle the logic in compute_generation_from_max() for
computing the corrected commit date based on the corrected commit dates
of the parent commits (and the commit date of the current commit). It
also uses different methods for (get|set)_generation in the vtable in
order to store and access the value in the correct places.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c | 64 +++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4356c8c1f4b..d1c98681e88 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1559,13 +1559,31 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static timestamp_t get_generation_from_graph_data(struct commit *c, void *data)
+{
+	return commit_graph_data_at(c)->generation;
+}
+
+static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
+{
+	struct commit_graph_data *g = commit_graph_data_at(c);
+	g->generation = (uint32_t)t;
+}
+
 static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
 	int i;
-	struct commit_list *list = NULL;
+	struct compute_generation_info info = {
+		.r = ctx->r,
+		.commits = &ctx->commits,
+		.get_generation = get_generation_from_graph_data,
+		.set_generation = set_generation_v2,
+		.data = ctx,
+	};
 
 	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
+		info.progress = ctx->progress
+			      = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 
@@ -1577,47 +1595,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		}
 	}
 
-	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
-		timestamp_t corrected_commit_date;
-
-		repo_parse_commit(ctx->r, c);
-		corrected_commit_date = commit_graph_data_at(c)->generation;
-
-		display_progress(ctx->progress, i + 1);
-		if (corrected_commit_date != GENERATION_NUMBER_ZERO)
-			continue;
-
-		commit_list_insert(c, &list);
-		while (list) {
-			struct commit *current = list->item;
-			struct commit_list *parent;
-			int all_parents_computed = 1;
-			timestamp_t max_corrected_commit_date = 0;
-
-			for (parent = current->parents; parent; parent = parent->next) {
-				repo_parse_commit(ctx->r, parent->item);
-				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
-
-				if (corrected_commit_date == GENERATION_NUMBER_ZERO) {
-					all_parents_computed = 0;
-					commit_list_insert(parent->item, &list);
-					break;
-				}
-
-				if (corrected_commit_date > max_corrected_commit_date)
-					max_corrected_commit_date = corrected_commit_date;
-			}
-
-			if (all_parents_computed) {
-				pop_commit(&list);
-
-				if (current->date && current->date > max_corrected_commit_date)
-					max_corrected_commit_date = current->date - 1;
-				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
-			}
-		}
-	}
+	compute_reachable_generation_numbers(&info, 2);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
-- 
gitgitgadget


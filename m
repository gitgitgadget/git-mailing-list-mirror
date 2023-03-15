Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE123C74A5B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjCORqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCORqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:46:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC684F54
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so2377719wms.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofjKpPkVz1iVkizfG/EM1C0RNrO41vW8RqRU6hvCL/A=;
        b=ejc5w76BByLAvWh5zE4KIKko6u/B7hNkqdwngoIBiCKQqiiLLRPg9GFJdK/bxC54+7
         hkcrMCOiWDFaAhYT4UAhst5j923jIW/SoHVxhFbrvVgFRySrHOZ1FF95f4yPL3rEpknt
         u8LYxfXUKWAmWRyA7wA1KtJx+Hutl4zsG4Vzxx49riPN2Ql+TAhrgNZQvYg3yoQHYkSj
         YPlWqLJpNi2XadpzVq8Bv9UmtaMkI45AXvku9cV7+oItb+Q6iOsQJMfRkWF0yaTxbOIP
         m6Gkxs7Owqyyaaj4Gu9Tip3u3fA5lt39Nl0wlkA+HqLDX2Ti12wXq3nzMiOLGzic+S++
         15Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofjKpPkVz1iVkizfG/EM1C0RNrO41vW8RqRU6hvCL/A=;
        b=iXsk0DHJCXo5cZCj+F8VwEc4BHAiiY091KryExrgHq64X4JxZVbL3JnuOfSQU8qbaf
         MddZ0ITuDYahyRy70cw4PIpksbKw6ISiYDpRzGTvULYv06zKjE1ACFjGhwi7foCHKmkY
         eLdkzgoVejpfwk1VnvVrj3DXd0NoPN11pq+zOBh0e9O+RkTrirHTEJoclvWpSn77u2ao
         g5Ea0hXo0eX/EqkM6urDHidPRcuko1JDA1uYYRPehu/PEqQnSRhlIfjI7RNLwFHyfZcc
         z/cYt9IRvxA7S/WbSX/kB4aMuIZHRuQ5t6iKU8XT6DtUxMbTu0VtrWyIHHEuA/G118WM
         CEbw==
X-Gm-Message-State: AO0yUKW8acmD7bY3LOfMXJ/YYe5w1jEujsJLubKx3UAwP08C3dawCxT6
        nQzq5On9AxrmYVJgGKLkpXKNLisUFOs=
X-Google-Smtp-Source: AK7set8PeVCsrW6JA+A/eVU23/kMMPE7LVsQLXRywhVjPW2YnmGzqsfSWlQpVJUubGYX/lnXQ4w7mQ==
X-Received: by 2002:a05:600c:3b87:b0:3e2:66b:e90e with SMTP id n7-20020a05600c3b8700b003e2066be90emr18330619wms.10.1678902348004;
        Wed, 15 Mar 2023 10:45:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020adff744000000b002c55de1c72bsm5289413wrp.62.2023.03.15.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:45:47 -0700 (PDT)
Message-Id: <e197bddcace3fc4ca980d1a459d13c0f85c2de7c.1678902343.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
References: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 17:45:40 +0000
Subject: [PATCH v3 5/8] commit-graph: introduce `ensure_generations_valid()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Use the just-introduced compute_reachable_generation_numbers_1() to
implement a function which dynamically computes topological levels (or
corrected commit dates) for out-of-graph commits.

This will be useful for the ahead-behind algorithm we are about to
introduce, which needs accurate topological levels on _all_ commits
reachable from the tips in order to avoid over-counting.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c | 29 +++++++++++++++++++++++++++++
 commit-graph.h |  8 ++++++++
 2 files changed, 37 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index b4da4e05067..0df8d27afc8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1609,6 +1609,35 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void set_generation_in_graph_data(struct commit *c, timestamp_t t,
+					 void *data)
+{
+	commit_graph_data_at(c)->generation = t;
+}
+
+/*
+ * After this method, all commits reachable from those in the given
+ * list will have non-zero, non-infinite generation numbers.
+ */
+void ensure_generations_valid(struct repository *r,
+			      struct commit **commits, size_t nr)
+{
+	int generation_version = get_configured_generation_version(r);
+	struct packed_commit_list list = {
+		.list = commits,
+		.alloc = nr,
+		.nr = nr,
+	};
+	struct compute_generation_info info = {
+		.r = r,
+		.commits = &list,
+		.get_generation = get_generation_from_graph_data,
+		.set_generation = set_generation_in_graph_data,
+	};
+
+	compute_reachable_generation_numbers_1(&info, generation_version);
+}
+
 static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
 {
 	trace2_data_intmax("commit-graph", ctx->r, "filter-computed",
diff --git a/commit-graph.h b/commit-graph.h
index 37faee6b66d..73e182ab2d0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -190,4 +190,12 @@ struct commit_graph_data {
  */
 timestamp_t commit_graph_generation(const struct commit *);
 uint32_t commit_graph_position(const struct commit *);
+
+/*
+ * After this method, all commits reachable from those in the given
+ * list will have non-zero, non-infinite generation numbers.
+ */
+void ensure_generations_valid(struct repository *r,
+			      struct commit **commits, size_t nr);
+
 #endif
-- 
gitgitgadget


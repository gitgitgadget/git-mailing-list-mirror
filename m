Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC214C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCFOH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCFOHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9724CB9
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h11so8938942wrm.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111603;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjZ+UNNJhOaqWykL3y2WkKBUiPW6gztml3WzTDYve8k=;
        b=Xm3ll84Y0jdvim3HLpr/u71KuDWzZ2+ArdRsa7Rapo2mm4t5i3p9Spv+eMtltGCzSW
         47HdzN11KDSnZpDTvRR2nWNXzS09zLOUTdXm+EaRWfOWlSCBAaJXfFAXdoZJv2QlUhjB
         koLTo1nB/OJ3sSnPUgw7W+a8jeyFPGtGdLM4D6/ToN+hHnUNbu9hX9qRmchvBxduj8wS
         VZ5quFzWVjQMlOs+fVOjAnXsfvUWq3FFnLWNu2DC6Uz5ZOUSnNho4kG6bo5omFqPtI4L
         gk8l++2ChrqvSD3DvgKHy5eEyvaeNNXu2x7gJkRtQP1Yr8IZCSmW56UAIzn7a4ttjXB1
         gMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111603;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjZ+UNNJhOaqWykL3y2WkKBUiPW6gztml3WzTDYve8k=;
        b=z6PBbrqd89DgflJOkF8MSfDyU6Q+HYsCLHm04/tFMZeNaseCU5pVvoEVS8xhBzP2SN
         bRBh/ta+5GjiNRYUoU5XdwRhluukjLoPoa7Z3nVuUhtLbGfop4QBc/s97Eqh+eDyfkly
         GLUIdUScZW6IMmzrrKFVF7iWnhNUFSEuaU1FY9xr01dXzEJD4i2CWFPCoRVQceOzzxUG
         +sCxn5LupviTZ9915ERY/zLL00SD/tBDdAr3tnmLLL3Pcz5Htg1lDHAwyRsiM9S1kKL5
         ui/olFURNgRTcnUdHp/2m8qR+AMYy1j2OM7Q/i+K0QeWSL9OiK+oMJLevnktGrdXjIZi
         Kr0Q==
X-Gm-Message-State: AO0yUKUE6fT+HxuSdiD+Tz75JEHqss7dcYIFmdNWAWCaINKawYfm1A/t
        w3AuhdKVaVKwrx/gjbeYBBV/KHgo+kE=
X-Google-Smtp-Source: AK7set+mhJbigqhKQSF1Krm4/o++h0pY3cw8GSB4P0wWaSmQOqIsjd1o/pgGxF34aUHgiJegx17ikg==
X-Received: by 2002:adf:f14a:0:b0:2c9:97f8:2604 with SMTP id y10-20020adff14a000000b002c997f82604mr6563424wro.14.1678111603693;
        Mon, 06 Mar 2023 06:06:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003e6dcd562a6sm10053590wmn.28.2023.03.06.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:43 -0800 (PST)
Message-Id: <f31994ac78aa7aff11d923a77be6b0652f3af70d.1678111599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:36 +0000
Subject: [PATCH 6/8] commit-graph: introduce `ensure_generations_valid()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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
 commit-graph.h |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index f04b02be1bb..a573d1b89ff 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1610,6 +1610,35 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
+void ensure_generations_valid(struct commit **commits, size_t nr)
+{
+	struct repository *r = the_repository;
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
index 37faee6b66d..a529c62b518 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -190,4 +190,11 @@ struct commit_graph_data {
  */
 timestamp_t commit_graph_generation(const struct commit *);
 uint32_t commit_graph_position(const struct commit *);
+
+/*
+ * After this method, all commits reachable from those in the given
+ * list will have non-zero, non-infinite generation numbers.
+ */
+void ensure_generations_valid(struct commit **commits, size_t nr);
+
 #endif
-- 
gitgitgadget


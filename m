Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E02C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCJRV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCJRVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795D116B89
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c18so3877450wmr.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678468869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZkfvLFEJwh7up1eEA47fYKyO/Y43htW5USVg4bs6dY=;
        b=Fccf6zuOi11SU4VjNF7jz+wcKU4hLZr1w2qVmUtw+WN24XNh4Xgm9jnPRNLNIy5TTF
         V0TvtrSqtBRaezmJFuyvPsFLnTl/krZLpibtF+yHvxfBzDdWjoCgbddC5kRmtDNTcEmh
         wDPpwVFFXQXVYDuOcq7Q0JPGjGIWG0cq/VwZVNV34ntgTWgoyAHLNyCslqEWalamhoB8
         f+Y18Xa02yKTlJznhpQsPcNf4wervrd663Mb0QoLQMMfwSoy491BGLDfurSAl8US5w0K
         FJ7LPc2WYMDCbevJwsEqZj6khwD5K8kK7IUo1TQ3WdIANseKx4M/teKZU/bJbi4SdshR
         yb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678468869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZkfvLFEJwh7up1eEA47fYKyO/Y43htW5USVg4bs6dY=;
        b=v/Zcq5/la2uTZJTirhm0A8tJuCZnMdIX50tGnoyI0Lc3ASp/sGeRt0UdESwZeY0fk7
         pZToEFA6RgN5bpPWuT9JiFhA1Z/y2ZyPw/r6RMuEv4oWsQGzPF3P8tr3op8KXf5bU/iE
         /+KO9nig67nCWKfREsAlg8I1ZV93MvOMhN7ECWLCArzFbKCQWFxLdXTf7mB2HkRefZeV
         brqnnfuYy09JSec6t2tkPiiG8JswiSlr7yjNmPzxrm+lLG5f3DJW18iwOymItEWH3yX8
         FCDIY0IeLJM5XKGsuG9N+feJoO5KlKFZFvtafxX5alcio3o5pab3yui2sFR5x1Wxipjr
         fX8A==
X-Gm-Message-State: AO0yUKVo8Le15SXP+8Gip7M65Hl+q/0hV1VTdJjDm3dVx5RTswoJipaX
        7Upn7bPgdPMJi5UamrO2ZOglhywnKTs=
X-Google-Smtp-Source: AK7set9vrwLRHaOP/jY5qCt/hVRTbeerc7nOStVIw+a8jEBfKv/xLegqeTwejSgKoetapTIryeQpUA==
X-Received: by 2002:a1c:4c15:0:b0:3df:9858:c032 with SMTP id z21-20020a1c4c15000000b003df9858c032mr1899156wmf.7.1678468869206;
        Fri, 10 Mar 2023 09:21:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003dec22de1b1sm476002wmk.10.2023.03.10.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:21:08 -0800 (PST)
Message-Id: <34dffd836b1475967593e68e5f8697b260c03d16.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Mar 2023 17:21:00 +0000
Subject: [PATCH v2 5/8] commit-graph: introduce `ensure_generations_valid()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
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
index b4da4e05067..7311d62a110 100644
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C3C7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCTL1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCTL12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2354215
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so2172972wmq.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43PItVhDxJ3mQhLHon2EEHxJOGOuB59by0/UPK28OWc=;
        b=SzclkQSm9mv0OHnIQTxz7xW54Rfg/3WCOCRNB4reznMT5oLSv5+cGqyNxLJklJRVyH
         XOmMluht8mi9CwJrHTK5hnSurXeLWeV/pokW1s4LrNfDWmrjy6/Lh9qPNEhdym/VeVar
         TsQ5f9oZC5x45adhMWIfqajon+MwSPoi6JBs2FVAd3nOctNr0OA2jJu6/emFCc5OVIQR
         aKc0VF8qZhLDQ+NpqzDoQCnfwgXh8A2+uWW3gFVS7iZ2nVu++nQyACbXiasZSKkhV1AP
         up5zX3GLZUNpZX+UzyOJIO/1dqGZZvpJeuJvqSDS+fqpTWGU4+0clHFxKSaG+y3H1ioy
         bong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43PItVhDxJ3mQhLHon2EEHxJOGOuB59by0/UPK28OWc=;
        b=A7CbaO/zSBQFrKQe5lMb0rZHfDyFN52+uPceGTNYj4qNimdJqAQ2ezkyvyOJOVmLRo
         mmCLm1781D5poCYGPIrsBqMtbUfvv9+xEt32IXIEbDaUICkL1Fd0D9DARFli6ec/si/U
         QvBkg4xM268RYiZvmuC1u5+pM9mG45SljhS3/+kb/S/9/eFzug/fssIgI6Fd6J+xrayu
         D9otWTtHQJTxMoQ/VCQSomLwdg4ZVlk+c2M5pkLteNPxaIOvk9YldBdOvSxq+2r8s3wb
         z7y5brMKzBjbdrSif/N+7uu5fq5YNo1ZX4KPMHnadbPHKWbJ/g4IYWDzO8P/5T3s+oCc
         1+8w==
X-Gm-Message-State: AO0yUKUjYtXYLzSEsTxtvXGAVmtMbJvXJf4I9WqrwtllHf9HlsncSSff
        DYlW7N9z9lBbuCNOGUFweAevmmjRaxE=
X-Google-Smtp-Source: AK7set9sl9L91TPfj00KV5bPP/+dRbAKXGcKwVV6JWMvydppG/UZEywipxZF0uiPB+4aing9wVnFQw==
X-Received: by 2002:a7b:c5c8:0:b0:3ed:8079:27d7 with SMTP id n8-20020a7bc5c8000000b003ed807927d7mr9148922wmk.40.1679311621742;
        Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b003ee1acdb036sm75568wma.17.2023.03.20.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:27:01 -0700 (PDT)
Message-Id: <17a1fc9b15e27dab71c123876fb6ced535d7d4d8.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:52 +0000
Subject: [PATCH v4 6/9] commit-graph: introduce `ensure_generations_valid()`
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
index 63a56483cf6..172e679db19 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1604,6 +1604,35 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
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
+	compute_reachable_generation_numbers(&info, generation_version);
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


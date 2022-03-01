Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA99C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiCATuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiCATuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E66D94C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:49:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2044507wmb.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D/L9C6JWe72f9TjEtYZgbN/FMUA9CuRmpC7e95qlm4o=;
        b=lkgUG4ewOuOaTvnpfSt/lKyPzprCeCpbwKF8/fW3J5OOfm9H0WuOLTisohuNolFkrF
         EX7GOvCRtEXs2JfOV87z/OnY+FU4l8eB5cuR0x0LEDYCFUczf/SzUAR3oSq4mZhYRKmX
         gSSsQbkZwgXN3w1sDTFe47OOPdBRtEyPcbMxZeMz1m5qjvXR6Z1vb1/F0m8Knw04mPoV
         jUIIoddmpOotb9ZyKQTzEkZk1sS0SzJMgR15hekIVC8MixXBW01N++379pyIb2O2fBiL
         L499NR5W9+kNfwP8l/JUhS4bDXqimaBhM0/gbMFXLiukuSg7lLwDU9D3On0J7ii+dGZ9
         hqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D/L9C6JWe72f9TjEtYZgbN/FMUA9CuRmpC7e95qlm4o=;
        b=Sovbo/S6grkdmnBc10J2hUas4CE7MGoXWaJd8QFfXTkDeg4Ysyn3wFUfDZJJm5YQeg
         3C+DhxFNb5BiS+wQ/gAkkBHShjZOQibsQm3//hr+LKd9+pDqEOSqY/YnPeYoU2Df6xzC
         7SLptelzxeGypwmmAHxp1k/NQk/kXPor7+swBazwMP2HlCPbdEDKjk74WhLtE/k6/4gQ
         4xMChz7q3v53I4USh6Db8OU4957Ke5ylTNfiqk1XefGn8zXV5kYpmLASMtgIKPbaFiHY
         msJegbo2VcEO4IAWqaFxIdFzTxAh+E2E3JrSuDf9e0o8gb4iL7cpEZHv4sNebeRXS9eh
         gKcQ==
X-Gm-Message-State: AOAM532XufMKWb+5DH28pa7j5bFcPgOtgklVsXxYgK5yKnISAsEJAZC/
        dUVu/jMNzwpQUw0zTCBxE+d+7nlCPNE=
X-Google-Smtp-Source: ABdhPJzgIvRY8hQXdyudxLdGD9g8Uh22CW0Xy7ncJw+C2kw9Dd+/DOPx0w44g3SM207dfWO3sasU+Q==
X-Received: by 2002:a05:600c:3217:b0:380:e2a3:18cf with SMTP id r23-20020a05600c321700b00380e2a318cfmr17925144wmp.129.1646164114511;
        Tue, 01 Mar 2022 11:48:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b001e58c8de11bsm14690159wrl.39.2022.03.01.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:33 -0800 (PST)
Message-Id: <4eca8028c971e32fdf34720de4674daf7004a294.1646164112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:28 +0000
Subject: [PATCH v3 1/5] test-read-graph: include extra post-parse info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to verify that the 'struct commit_graph' that results
from parsing a commit-graph is correctly structured. The existence of
different chunks is not enough to verify that all of the optional
features are correctly enabled.

Update 'test-tool read-graph' to output an "options:" line that includes
information for different parts of the struct commit_graph.

In particular, this change demonstrates that the read_generation_data
option is never being enabled, which will be fixed in a later change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/helper/test-read-graph.c    | 13 +++++++++++++
 t/t4216-log-bloom.sh          |  1 +
 t/t5318-commit-graph.sh       |  1 +
 t/t5324-split-commit-graph.sh |  5 +++++
 4 files changed, 20 insertions(+)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 75927b2c81d..98b73bb8f25 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -3,6 +3,7 @@
 #include "commit-graph.h"
 #include "repository.h"
 #include "object-store.h"
+#include "bloom.h"
 
 int cmd__read_graph(int argc, const char **argv)
 {
@@ -45,6 +46,18 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" bloom_data");
 	printf("\n");
 
+	printf("options:");
+	if (graph->bloom_filter_settings)
+		printf(" bloom(%"PRIu32",%"PRIu32",%"PRIu32")",
+		       graph->bloom_filter_settings->hash_version,
+		       graph->bloom_filter_settings->bits_per_entry,
+		       graph->bloom_filter_settings->num_hashes);
+	if (graph->read_generation_data)
+		printf(" read_generation_data");
+	if (graph->topo_levels)
+		printf(" topo_levels");
+	printf("\n");
+
 	UNLEAK(graph);
 
 	return 0;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index cc3cebf6722..5ed6d2a21c1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -48,6 +48,7 @@ graph_read_expect () {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
+	options: bloom(1,10,7)
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index edb728f77c3..2b05026cf6d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -104,6 +104,7 @@ graph_read_expect() {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	options:
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 847b8097109..778fa418de2 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -34,6 +34,7 @@ graph_read_expect() {
 	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data
+	options:
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -508,6 +509,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
 		header: 43475048 1 $(test_oid oid_version) 4 1
 		num_commits: $NUM_SECOND_LAYER_COMMITS
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify &&
@@ -540,6 +542,7 @@ test_expect_success 'do not write generation data chunk if not present on existi
 		header: 43475048 1 $(test_oid oid_version) 4 2
 		num_commits: $NUM_THIRD_LAYER_COMMITS
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify
@@ -581,6 +584,7 @@ test_expect_success 'do not write generation data chunk if the topmost remaining
 		header: 43475048 1 $(test_oid oid_version) 4 2
 		num_commits: $(($NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata
+		options:
 		EOF
 		test_cmp expect output &&
 		git commit-graph verify
@@ -620,6 +624,7 @@ test_expect_success 'write generation data chunk if topmost remaining layer has
 		header: 43475048 1 $(test_oid oid_version) 5 1
 		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata generation_data
+		options:
 		EOF
 		test_cmp expect output
 	)
-- 
gitgitgadget


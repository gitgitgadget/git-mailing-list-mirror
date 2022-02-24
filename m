Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1144C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiBXUjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiBXUjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CC179A0E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so1413302wrg.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7Z5V7sOeHr0ggnLaIE0MmZnuQTZSihaETgiBRpj/V28=;
        b=f/5Eracbgv15yYYL0KDQfzMEVJ2/C1DtOkP+5dgb5yMbhcJlWEQ47QojtPvRgTuIni
         5EhVxQzfPi2IpIKmZV4Rz+oxrD9uLY0GCCWp5uE5dSnYb7XSQvmNC6KTYpwyOvyUHjDJ
         v4gvuFbb70eMyMlRK9YKJVPo8+vuZOMt3SIczcwoYXbKn967POHK1lX5Ss6/NQCX0s6H
         wgKl2ZodFHEo6YqgXiw21J2MXVxJQzY79qTW+PdGiFO4w88wyMM3VUP6jzkPH0OW9Pis
         zuns0oIOhwcCRAAo4QzWfNNA44SrG8Z1f2LhfIJt17NmZk8qe3F2jdJkyQRK0GLDwRJ3
         xA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7Z5V7sOeHr0ggnLaIE0MmZnuQTZSihaETgiBRpj/V28=;
        b=yocyRCOGqRFclPGpnIoC5Xnd69Bt39fJ/m5BM3npuRvWvlkoyw3Znmle8ArjCx4iGd
         HUYN0KSc0pLecAOiPkrM7aj8EEe8Bde1kEaG5s5D17X4ITRBjyyNeFVmkYvBD3lnXF/Y
         bsBQ5T1CqPrDJWORwkSWnLVelmjycUCuw+5ozKQJShkSvh/4lOSToe6wgigKOcI79MmO
         J7bbv4IZrVhp7pPlcWDBwEYuVzfV7tyhkQ5bSrNLCDWqmY+a457dB+ByASoHY/GhRYOZ
         vU5rhku37ULFAvm5ecFXq6w6Wps2HLtXJ2xjC1J/xBd20IrdK7aSpZIFaugWwWht4vFe
         sKdQ==
X-Gm-Message-State: AOAM532nKUqgE1klF9qqmRAeDvhLPp11Ozr41LXa833NnKFgpkN8o7ut
        dHSS2aHURy3nJQjMFLr4mm1PIsjH8gM=
X-Google-Smtp-Source: ABdhPJxYN1Y5IvhxLQvpZ5D6xEF4sHtxSyFNmgjLGdtIpX49BImgru0bavvssL1RzJX6AwFeOONUCQ==
X-Received: by 2002:a5d:5709:0:b0:1ea:95eb:9e09 with SMTP id a9-20020a5d5709000000b001ea95eb9e09mr3686829wrv.188.1645735120499;
        Thu, 24 Feb 2022 12:38:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d27-20020adfa35b000000b001ede1137d2bsm319750wrb.116.2022.02.24.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:40 -0800 (PST)
Message-Id: <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:32 +0000
Subject: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'read_generation_data' member of 'struct commit_graph' was
introduced by 1fdc383c5 (commit-graph: use generation v2 only if entire
chain does, 2021-01-16). The intention was to avoid using corrected
commit dates if not all layers of a commit-graph had that data stored.
The logic in validate_mixed_generation_chain() at that point incorrectly
initialized read_generation_data to 1 if and only if the tip
commit-graph contained the Corrected Commit Date chunk.

This was "fixed" in 448a39e65 (commit-graph: validate layers for
generation data, 2021-02-02) to validate that read_generation_data was
either non-zero for all layers, or it would set read_generation_data to
zero for all layers.

The problem here is that read_generation_data is not initialized to be
non-zero anywhere!

This change initializes read_generation_data immediately after the chunk
is parsed, so each layer will have its value present as soon as
possible.

The read_generation_data member is used in fill_commit_graph_info() to
determine if we should use the corrected commit date or the topological
levels stored in the Commit Data chunk. Due to this bug, all previous
versions of Git were defaulting to topological levels in all cases!

This can be measured with some performance tests. Using the Linux kernel
as a testbed, I generated a complete commit-graph containing corrected
commit dates and tested the 'new' version against the previous, 'old'
version.

First, rev-list with --topo-order demonstrates a 26% improvement using
corrected commit dates:

hyperfine \
	-n "old" "$OLD_GIT rev-list --topo-order -1000 v3.6" \
	-n "new" "$NEW_GIT rev-list --topo-order -1000 v3.6" \
	--warmup=10

Benchmark 1: old
  Time (mean ± σ):      57.1 ms ±   3.1 ms
  Range (min … max):    52.9 ms …  62.0 ms    55 runs

Benchmark 2: new
  Time (mean ± σ):      45.5 ms ±   3.3 ms
  Range (min … max):    39.9 ms …  51.7 ms    59 runs

Summary
  'new' ran
    1.26 ± 0.11 times faster than 'old'

These performance improvements are due to the algorithmic improvements
given by walking fewer commits due to the higher cutoffs from corrected
commit dates.

However, this comes at a cost. The additional I/O cost of parsing the
corrected commit dates is visible in case of merge-base commands that do
not reduce the overall number of walked commits.

hyperfine \
        -n "old" "$OLD_GIT merge-base v4.8 v4.9" \
        -n "new" "$NEW_GIT merge-base v4.8 v4.9" \
        --warmup=10

Benchmark 1: old
  Time (mean ± σ):     110.4 ms ±   6.4 ms
  Range (min … max):    96.0 ms … 118.3 ms    25 runs

Benchmark 2: new
  Time (mean ± σ):     150.7 ms ±   1.1 ms
  Range (min … max):   149.3 ms … 153.4 ms    19 runs

Summary
  'old' ran
    1.36 ± 0.08 times faster than 'new'

Performance issues like this are what motivated 702110aac (commit-graph:
use config to specify generation type, 2021-02-25).

In the future, we could fix this performance problem by inserting the
corrected commit date offsets into the Commit Date chunk instead of
having that data in an extra chunk.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c                |  3 +++
 t/t4216-log-bloom.sh          |  2 +-
 t/t5318-commit-graph.sh       | 14 ++++++++++++--
 t/t5324-split-commit-graph.sh |  9 +++++++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a19bd96c2ee..8e52bb09552 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -407,6 +407,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 			&graph->chunk_generation_data);
 		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
 			&graph->chunk_generation_data_overflow);
+
+		if (graph->chunk_generation_data)
+			graph->read_generation_data = 1;
 	}
 
 	if (r->settings.commit_graph_read_changed_paths) {
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 5ed6d2a21c1..fa9d32facfb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -48,7 +48,7 @@ graph_read_expect () {
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
-	options: bloom(1,10,7)
+	options: bloom(1,10,7) read_generation_data
 	EOF
 	test-tool read-graph >actual &&
 	test_cmp expect actual
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f9bffe38013..1afee1c2705 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -100,11 +100,21 @@ graph_read_expect() {
 		OPTIONAL=" $2"
 		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
 	fi
+	GENERATION_VERSION=2
+	if test ! -z "$3"
+	then
+		GENERATION_VERSION=$3
+	fi
+	OPTIONS=
+	if test $GENERATION_VERSION -gt 1
+	then
+		OPTIONS=" read_generation_data"
+	fi
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
-	options:
+	options:$OPTIONS
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -498,7 +508,7 @@ test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git rev-parse commits/8 | git -c commitGraph.generationVersion=1 commit-graph write --stdin-commits &&
 	git commit-graph verify >output &&
-	graph_read_expect 9 extra_edges
+	graph_read_expect 9 extra_edges 1
 '
 
 NUM_COMMITS=9
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 778fa418de2..669ddc645fa 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -30,11 +30,16 @@ graph_read_expect() {
 	then
 		NUM_BASE=$2
 	fi
+	OPTIONS=
+	if test -z "$3"
+	then
+		OPTIONS=" read_generation_data"
+	fi
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata generation_data
-	options:
+	options:$OPTIONS
 	EOF
 	test-tool read-graph >output &&
 	test_cmp expect output
@@ -624,7 +629,7 @@ test_expect_success 'write generation data chunk if topmost remaining layer has
 		header: 43475048 1 $(test_oid oid_version) 5 1
 		num_commits: $(($NUM_SECOND_LAYER_COMMITS + $NUM_THIRD_LAYER_COMMITS + $NUM_FOURTH_LAYER_COMMITS + $NUM_FIFTH_LAYER_COMMITS))
 		chunks: oid_fanout oid_lookup commit_metadata generation_data
-		options:
+		options: read_generation_data
 		EOF
 		test_cmp expect output
 	)
-- 
gitgitgadget


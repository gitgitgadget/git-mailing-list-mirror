Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A0C2D0D4
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE052146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/pcDop3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfLTWFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37758 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so9853334edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9hkApjfOp2Gt6TekmUQkVxOm6TDztfxvSwVC+YHKR44=;
        b=N/pcDop3Mq1skxBgczMcWE0zCSCa2RZ7yQrqK3ja748pMZDn0waeNeiHlvfo/v+bhb
         PzlqNA0yjB7z7eI4g9Y9LZWl6wBzJzYtaWST5Sk3YLAS+QURKI0oM8j9LLLtmJQhRtJv
         TZLoNOE9pMCra9wd6TnQhpKyoVqL1wwn/4IvcZzxHLHieTCcFr0SLqPY1bxe4+o9JSkE
         JErEWwQQYiILOUM5LfHYFs3Ajnj+txiVnsIX6Or2Nue9Pvpt7scxYzn7RjiVlble+bMk
         jetJyZijO9erzAw2vuInp1I99eYvLMT6HGbeBihnsnnZ1Lr5b6fpM6zQOTDaJEHxKeTL
         AM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9hkApjfOp2Gt6TekmUQkVxOm6TDztfxvSwVC+YHKR44=;
        b=cYJVXNVQVgvOdT+M9pVsKCSnNGOtPR5gBmuRWYDmBEthqQAHPmRk7Ploz3p3WWRRyE
         2LBdCj7N48GIiDtgnVAzn95OAUZogdOHUHe5hfoKL1uMplsOl/iyxca/rpb02CFIcXkZ
         NN7k9SCmYu2G1edp72vvLQPSgTXccg5FDVtAuWUMxPBMNMQwlo6d3O2jizzjEVPmp8be
         RjRwulb2scjaV1mzRQkKmBQUuO8oJ3MZ1vx2CCiP3u5kjH7Pv3ggtnVoBLmRYNOcxW6G
         PhsgExb8ZodAqoPAeC8gUg/iynu8edicE2piTznlh0WOiRzqJVx2qpKeuwKrOPteh8Ks
         grDA==
X-Gm-Message-State: APjAAAXesNvYksOziFKM0HZBh69rKVc2BTv7J8IDZnnMFkC1AsS0WJEh
        KC16qEFoPQW93dI0Ifw7bZA6bjxB
X-Google-Smtp-Source: APXvYqzsfM0wF1deS3rJABnQyQ7WHMJHJBWdEZy3ptNIffkOS1AEasCzlbtoraRpHdJKZ1Me3j2+SA==
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr18740632edv.82.1576879527350;
        Fri, 20 Dec 2019 14:05:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm1132673edr.55.2019.12.20.14.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:26 -0800 (PST)
Message-Id: <85bfdfa59c48891343e3eeb740a4b3554405909a.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:17 +0000
Subject: [PATCH 6/9] commit-graph: test commit-graph write --changed-paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add tests for the --changed-paths feature when writing
commit-graphs.

RFC Notes:
I plan to split this test across some of the earlier commits
as appropriate.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 t/helper/test-read-graph.c    |   4 +
 t/t5325-commit-graph-bloom.sh | 255 ++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+)
 create mode 100755 t/t5325-commit-graph-bloom.sh

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index d2884efe0a..aff597c7a3 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -45,6 +45,10 @@ int cmd__read_graph(int argc, const char **argv)
 		printf(" commit_metadata");
 	if (graph->chunk_extra_edges)
 		printf(" extra_edges");
+	if (graph->chunk_bloom_indexes)
+		printf(" bloom_indexes");
+	if (graph->chunk_bloom_data)
+		printf(" bloom_data");
 	printf("\n");
 
 	UNLEAK(graph);
diff --git a/t/t5325-commit-graph-bloom.sh b/t/t5325-commit-graph-bloom.sh
new file mode 100755
index 0000000000..d7ef0e7fb3
--- /dev/null
+++ b/t/t5325-commit-graph-bloom.sh
@@ -0,0 +1,255 @@
+#!/bin/sh
+
+test_description='commit graph with bloom filters'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	git init &&
+	git config core.commitGraph true &&
+	git config gc.writeCommitGraph false &&
+	infodir=".git/objects/info" &&
+	graphdir="$infodir/commit-graphs" &&
+	test_oid_init
+'
+
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=5
+	if test ! -z $2
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((NUM_CHUNKS + $(echo "$2" | wc -w)))
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 1 $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
+	EOF
+	test-tool read-graph >output &&
+	test_cmp expect output
+}
+
+test_expect_success 'create commits and write commit-graph' '
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git commit-graph write --reachable --changed-paths &&
+	test_path_is_file $infodir/commit-graph &&
+	graph_read_expect 3
+'
+
+graph_git_two_modes() {
+	git -c core.commitGraph=true $1 >output
+	git -c core.commitGraph=false $1 >expect
+	test_cmp expect output
+}
+
+graph_git_behavior() {
+	MSG=$1
+	BRANCH=$2
+	COMPARE=$3
+	test_expect_success "check normal git operations: $MSG" '
+		graph_git_two_modes "log --oneline $BRANCH" &&
+		graph_git_two_modes "log --topo-order $BRANCH" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "branch -vv" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+	'
+}
+
+graph_git_behavior 'graph exists' commits/3 commits/1
+
+verify_chain_files_exist() {
+	for hash in $(cat $1/commit-graph-chain)
+	do
+		test_path_is_file $1/graph-$hash.graph || return 1
+	done
+}
+
+test_expect_success 'add more commits, and write a new base graph' '
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 10)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	git commit-graph write --reachable --changed-paths &&
+	graph_read_expect 12
+'
+
+test_expect_success 'fork and fail to base a chain on a commit-graph file' '
+	test_when_finished rm -rf fork &&
+	git clone . fork &&
+	(
+		cd fork &&
+		rm .git/objects/info/commit-graph &&
+		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
+		test_commit new-commit &&
+		git commit-graph write --reachable --split --changed-paths &&
+		test_path_is_file $graphdir/commit-graph-chain &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		verify_chain_files_exist $graphdir
+	)
+'
+
+test_expect_success 'add three more commits, write a tip graph' '
+	git reset --hard commits/3 &&
+	git merge merge/1 &&
+	git merge commits/5 &&
+	git merge merge/2 &&
+	git branch merge/3 &&
+	git commit-graph write --reachable --split --changed-paths &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 2 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
+
+test_expect_success 'add one commit, write a tip graph' '
+	test_commit 11 &&
+	git branch commits/11 &&
+	git commit-graph write --reachable --split --changed-paths &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 3 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
+
+test_expect_success 'add one commit, write a merged graph' '
+	test_commit 12 &&
+	git branch commits/12 &&
+	git commit-graph write --reachable --split --changed-paths &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 2 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
+graph_git_behavior 'merged commit-graph: commit 12 vs 6' commits/12 commits/6
+
+test_expect_success 'create fork and chain across alternate' '
+	git clone . fork &&
+	(
+		cd fork &&
+		git config core.commitGraph true &&
+		rm -rf $graphdir &&
+		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
+		test_commit 13 &&
+		git branch commits/13 &&
+		git commit-graph write --reachable --split --changed-paths &&
+		test_path_is_file $graphdir/commit-graph-chain &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files &&
+		git -c core.commitGraph=true  rev-list HEAD >expect &&
+		git -c core.commitGraph=false rev-list HEAD >actual &&
+		test_cmp expect actual &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --changed-paths --object-dir=.git/objects/ &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files
+	)
+'
+
+graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
+
+test_expect_success 'test merge stragety constants' '
+	git clone . merge-2 &&
+	(
+		cd merge-2 &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --changed-paths --size-multiple=2 &&
+		test_line_count = 3 $graphdir/commit-graph-chain
+
+	) &&
+	git clone . merge-10 &&
+	(
+		cd merge-10 &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --changed-paths --size-multiple=10 &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files
+	) &&
+	git clone . merge-10-expire &&
+	(
+		cd merge-10-expire &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 15 &&
+		git commit-graph write --reachable --split --changed-paths --size-multiple=10 --expire-time=1980-01-01 &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 3 graph-files
+	) &&
+	git clone --no-hardlinks . max-commits &&
+	(
+		cd max-commits &&
+		git config core.commitGraph true &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		test_commit 16 &&
+		test_commit 17 &&
+		git commit-graph write --reachable --split --changed-paths --max-commits=1 &&
+		test_line_count = 1 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files
+	)
+'
+
+test_expect_success 'remove commit-graph-chain file after flattening' '
+	git clone . flatten &&
+	(
+		cd flatten &&
+		test_line_count = 2 $graphdir/commit-graph-chain &&
+		git commit-graph write --reachable &&
+		test_path_is_missing $graphdir/commit-graph-chain &&
+		ls $graphdir >graph-files &&
+		test_must_be_empty graph-files
+	)
+'
+
+graph_git_behavior 'graph exists' merge/octopus commits/12
+
+test_expect_success 'split across alternate where alternate is not split' '
+	git commit-graph write --reachable &&
+	test_path_is_file .git/objects/info/commit-graph &&
+	cp .git/objects/info/commit-graph . &&
+	git clone --no-hardlinks . alt-split &&
+	(
+		cd alt-split &&
+		rm -f .git/objects/info/commit-graph &&
+		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
+		test_commit 18 &&
+		git commit-graph write --reachable --split --changed-paths &&
+		test_line_count = 1 $graphdir/commit-graph-chain
+	) &&
+	test_cmp commit-graph .git/objects/info/commit-graph
+'
+
+test_done
-- 
gitgitgadget


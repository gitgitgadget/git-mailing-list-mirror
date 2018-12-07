Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FA620A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLGW13 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:27:29 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:42998 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:27:29 -0500
Received: by mail-io1-f74.google.com with SMTP id r13so5094787ioj.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wT5mtxGX9NarPNjapmHlABJg8fevvqlfVm2EvnNWh+g=;
        b=pysDasViCu4T4R6B2avXUgcxD1J0CThGu19LaZzTMfRRbqsURvqFDnyfN8caxQnnhY
         kziNsDM9Y+bQ2+8RO5Mspu/JXCMZf/D3waaAcWelZ7v3F52Df+gbngT2Ze38CiO/PsTp
         lLEVlo6ThmkFN47TVnNWGGecPPri/zqJQZHxWDwWQQ++B/qlg05/f13OfZeoSvxfI1qi
         J9iHKXbrDR716MNQ3bkCeW8v9VHvnTIAoXL8kyOgpm65AeYht9oRm4WEOMD+qAtdlS1v
         FKEV4wF5AkuuevTNUUiz2MDiS1Ex96uNiehuVzrVS5TZXEDonnsHGfewsV4poO9oE0bi
         XjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wT5mtxGX9NarPNjapmHlABJg8fevvqlfVm2EvnNWh+g=;
        b=gN72BIqqkWM3zSWlZ5NCvtNnGn3xwpBG/3kcRYLMtfPS4jp73hkWFs2tanErEvfKaZ
         Q/jnI6rq95UjHBfd/zGgUA5Rq+pooXDJM26NUqJvD0sWxh7iNjgIg4Qr7JuoSYJiEj6U
         9/X3R/PS/WMwrpadN482Ey8bPYQmFczD9XQntLa0/angviEnAVUHZBnfzST2J2CMfrdU
         AMmR7Z4iHYNcPl260Idm2HW1HveAzjuqTmJ1NOuYx5DlEvfJQ/danwCXbMq1aYeiPM38
         H+4ZReL5xT7GmMtqiQih52Mxh4ewCTYgCXtnEJGV78tlcPTdN7hObN4kJQ/QgcPaJcWa
         Gy8w==
X-Gm-Message-State: AA+aEWZS/bOOwzp2YxtMsYetd42HXjKhC+vcaqvF5nvrhWxh5Q/1QtqP
        PG3wP2WmG6g1yMcaEFvmxXkJ1YHGEWHLjUDHDojPEOb6x+K6xrk25GbAaRMqjDmVKAZUb0SENVw
        HfOpcW+RN0cJFhSnRobRu+uX4pqDKMpx6mGNyFHYDmjcRELLKOwdCXkJrp5YmvA8=
X-Google-Smtp-Source: AFSGD/XEMhrm4G2pUZGkexn5Nv6oN4Wqkdv1BIsSQDZTk/PTQSEWDWX3qqBfccsf4dy5oK1jKxGwyWsyOO7M8Q==
X-Received: by 2002:a24:5f93:: with SMTP id r141mr3179618itb.4.1544221647637;
 Fri, 07 Dec 2018 14:27:27 -0800 (PST)
Date:   Fri,  7 Dec 2018 14:27:21 -0800
In-Reply-To: <cover.1544127439.git.steadmon@google.com>
Message-Id: <cover.1544221121.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544127439.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 0/3] Add commit-graph fuzzer and fix buffer overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ad a new fuzz test for the commit graph and fix a buffer read-overflow
that it discovered. Additionally, fix the Makefile instructions for
building fuzzers.

Changes since V2:
  * Avoid pointer arithmetic overflow when checking the graph's chunk
    count.
  * Merge the corrupt_graph_and_verify and
    corrupt_and_zero_graph_then_verify test functions.

Josh Steadmon (3):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow
  Makefile: correct example fuzz build

 .gitignore              |  1 +
 Makefile                |  3 +-
 commit-graph.c          | 67 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 ++
 fuzz-commit-graph.c     | 16 ++++++++++
 t/t5318-commit-graph.sh | 15 +++++++--
 6 files changed, 83 insertions(+), 22 deletions(-)
 create mode 100644 fuzz-commit-graph.c

Range-diff against v2:
1:  af45c2337f ! 1:  675d58ecea commit-graph: fix buffer read-overflow
    @@ -22,8 +22,8 @@
     +		uint64_t chunk_offset;
      		int chunk_repeated = 0;
      
    -+		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH >
    -+		    data + graph_size) {
    ++		if (data + graph_size - chunk_lookup <
    ++		    GRAPH_CHUNKLOOKUP_WIDTH) {
     +			error(_("chunk lookup table entry missing; graph file may be incomplete"));
     +			free(graph);
     +			return NULL;
    @@ -40,31 +40,34 @@
      --- a/t/t5318-commit-graph.sh
      +++ b/t/t5318-commit-graph.sh
     @@
    - 	test_i18ngrep "$grepstr" err
    - }
    + GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
    + GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
      
    -+
    -+# usage: corrupt_and_zero_graph_then_verify <corrupt_position> <data> <zero_position> <string>
    -+# Manipulates the commit-graph file at <corrupt_position> by inserting the data,
    -+# then zeros the file starting at <zero_position>. Finally, runs
    -+# 'git commit-graph verify' and places the output in the file 'err'. Tests 'err'
    -+# for the given string.
    -+corrupt_and_zero_graph_then_verify() {
    -+	corrupt_pos=$1
    -+	data="${2:-\0}"
    -+	zero_pos=$3
    -+	grepstr=$4
    +-# usage: corrupt_graph_and_verify <position> <data> <string>
    ++# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
    + # Manipulates the commit-graph file at the position
    +-# by inserting the data, then runs 'git commit-graph verify'
    ++# by inserting the data, optionally zeroing the file
    ++# starting at <zero_pos>, then runs 'git commit-graph verify'
    + # and places the output in the file 'err'. Test 'err' for
    + # the given string.
    + corrupt_graph_and_verify() {
    + 	pos=$1
    + 	data="${2:-\0}"
    + 	grepstr=$3
     +	orig_size=$(stat --format=%s $objdir/info/commit-graph)
    -+	cd "$TRASH_DIRECTORY/full" &&
    -+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
    -+	cp $objdir/info/commit-graph commit-graph-backup &&
    -+	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$corrupt_pos" conv=notrunc &&
    ++	zero_pos=${4:-${orig_size}}
    + 	cd "$TRASH_DIRECTORY/full" &&
    + 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
    + 	cp $objdir/info/commit-graph commit-graph-backup &&
    + 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
     +	truncate --size=$zero_pos $objdir/info/commit-graph &&
     +	truncate --size=$orig_size $objdir/info/commit-graph &&
    -+	test_must_fail git commit-graph verify 2>test_err &&
    -+	grep -v "^+" test_err >err &&
    -+	test_i18ngrep "$grepstr" err
    -+}
    + 	test_must_fail git commit-graph verify 2>test_err &&
    + 	grep -v "^+" test_err >err
    + 	test_i18ngrep "$grepstr" err
    + }
    + 
     +
      test_expect_success 'detect bad signature' '
      	corrupt_graph_and_verify 0 "\0" \
    @@ -73,9 +76,9 @@
      		"incorrect checksum"
      '
      
    -+test_expect_success 'detect truncated graph' '
    -+	corrupt_and_zero_graph_then_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
    -+		$GRAPH_CHUNK_LOOKUP_OFFSET "chunk lookup table entry missing"
    ++test_expect_success 'detect incorrect chunk count' '
    ++	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
    ++		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
     +'
     +
      test_expect_success 'git fsck (checks commit-graph)' '
2:  7519fc76df = 2:  06a32bfe8b Makefile: correct example fuzz build
-- 
2.20.0.rc2.12.g4c11c11dec


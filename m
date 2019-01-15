Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A703F1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbfAOUAB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:00:01 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36917 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfAOUAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:00:00 -0500
Received: by mail-pf1-f201.google.com with SMTP id i3so2771467pfj.4
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/KMK3R6pMbP1dHLHOZGrRPdK7bT8SE9Mejfon5rUKjY=;
        b=nVLuqAqan+bBpfq12y3cSj039rYTZaX8PzjuFDdEzPGjiB/pwqfSYJiJMg+vYkqvvi
         fGZRV6lXY8+GdUajLn+2E5GY68Z2UM3dWw1tfAGNjWygbUNM6yVvIuQ8y5KoxmjGup77
         R0gY1VoY8pLC0eYObUW/soTRTBihakur94vstAt9yx1FXao91VAIupn2uQ97x39LxDrQ
         YHO3yhRNV4HD8XEHTPHC02YT5NsYBzJ+6hbiXiK8fOziZnZA/biQKOBLUvhnFb3mcMWe
         4j9BbCyaJj37CdPrjzr25uBU5kmDP55n8/+Tq9dUWr0s9mIbTzOw5zqZ9aLHlU6sYQAQ
         MksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/KMK3R6pMbP1dHLHOZGrRPdK7bT8SE9Mejfon5rUKjY=;
        b=ndcj7Wn1Kt2BYKhKvtMuZvoI5ny/B3xdsjroF5cD+UwprxOvOVsbTCkwCvXfvvnvOG
         t64kjxD529W8mR3OvG9m80ebZAj5m0klT5J3Mng6IqUAr9PZMjf9pE9SEseALaM8psUm
         ONqFNdbdZ/L5fKYGd0HDgUPCJNEkdymQdNF+5mRHTp23kjc2MmGe+C9BrX0y1nytbB6V
         SSgdC88KCMQeqN9l1Jgfrgal64w8pQnimqvAaZHW8UU620XSHJw5Xb7JGHR2KdUjpzlr
         E8PG/MY3wGW1pyff83gWnd2BS6yLcr3NMMrYMW5QyrJu+ssqNHVpR1PHr6SwFFk7KjFV
         Q0vw==
X-Gm-Message-State: AJcUukd6K76QorzoHLtfTnO+DvMqvGBo4Q+qqSxERYAu4xYaKyPTejzO
        Hvx0+b1pRfj2pRrA0R4aUQhFRZjrgtl89KWIB2KjKkl7e6ViSiIJhLSDJbLwVxDzTK+ks6n/mrA
        tRnuVU+LhTycWOmbWAlRsyhaRs8/UgMvuKsYgcdzbweugVbBT1LQr3mSOaqsYIio=
X-Google-Smtp-Source: ALg8bN6QbsHw6ivj01ZRWG14B6gSfvXBwYCmn6X1YHQCDFJvuuiK5HILr+Gc2QiW8yM5ealjHmAnSyFRw0B2rg==
X-Received: by 2002:a63:a05a:: with SMTP id u26mr2023655pgn.25.1547582399349;
 Tue, 15 Jan 2019 11:59:59 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:59:52 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <cover.1547582104.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v5 0/3] Add commit-graph fuzzer and fix buffer overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new fuzz test for the commit graph and fix a buffer read-overflow
that it discovered. Additionally, fix the Makefile instructions for
building fuzzers.

Changes since V4:
  * Ensure that corrupt_graph_and_verify() in t5318 changes to the
    proper directory before accessing any files.

Changes since V3:
  * Improve portability of the new test functionality.
  * Fix broken &&-chains in tests.

Changes since V2:
  * Avoid pointer arithmetic overflow when checking the graph's chunk
    count.
  * Merge the corrupt_graph_and_verify and
    corrupt_and_zero_graph_then_verify test functions.

Josh Steadmon (3):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow
  Makefile: correct example fuzz build

Josh Steadmon (3):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow
  Makefile: correct example fuzz build

 .gitignore              |  1 +
 Makefile                |  3 +-
 commit-graph.c          | 67 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 ++
 fuzz-commit-graph.c     | 16 ++++++++++
 t/t5318-commit-graph.sh | 16 ++++++++--
 6 files changed, 83 insertions(+), 23 deletions(-)
 create mode 100644 fuzz-commit-graph.c

Range-diff against v4:
1:  80b5662f30 ! 1:  a3b5d33c4b commit-graph: fix buffer read-overflow
    @@ -52,12 +52,12 @@
      # and places the output in the file 'err'. Test 'err' for
      # the given string.
      corrupt_graph_and_verify() {
    - 	pos=$1
    +@@
      	data="${2:-\0}"
      	grepstr=$3
    + 	cd "$TRASH_DIRECTORY/full" &&
     +	orig_size=$(wc -c < $objdir/info/commit-graph) &&
     +	zero_pos=${4:-${orig_size}} &&
    - 	cd "$TRASH_DIRECTORY/full" &&
      	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
      	cp $objdir/info/commit-graph commit-graph-backup &&
      	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
2:  21101b961a = 2:  350ea5f7c9 Makefile: correct example fuzz build
-- 
2.20.1.97.g81188d93c3-goog


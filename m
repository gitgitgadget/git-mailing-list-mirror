Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197FF1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbfAOWZ5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:25:57 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:57029 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfAOWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:25:56 -0500
Received: by mail-qt1-f202.google.com with SMTP id q33so3790059qte.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oVcifA7ak2GaobH9r0S7YIT6enGvh38u5o/xLDejKfY=;
        b=kHCqTO8UAooUN3z4mAWQeNBUdPd2pbzXiFXvc8UkIF3t6avp9/3onUFh1phWnEfUd2
         ZnBPaZ8H8LAMdKqwhW2/p+XI9Uy+gprHKLjK33ARsxS4UNdsff4PkjWfDJEaXHjuAQI5
         rBZKXPPgI+jQxy1tSOCqqxX/OnQgqEzBxXpPEZ4CNnXGyWw6osjs6nYMh5MUDLQXOxO9
         cYe/yNm6cqBhz3LDu37HCAIQckywPpSe76ZnDqnG8f4BZuMgdbrIyZKNUM+qKMDayqBo
         Jh4yr010zGaVk8PCvf+Z2BOvbV3RAYNj7vQPEV7chxQvsoT88syJn0eKCi+Lk9t9Au7O
         5Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oVcifA7ak2GaobH9r0S7YIT6enGvh38u5o/xLDejKfY=;
        b=JDp6zbEHETEdjLksDQIhrb4sjFFPwuJm+gx30UNBGSrqDsdS7W/HD1heXVDiDpN/n2
         nCNMa7WJKcO0fOXSthne9ipT3xQ2BwoFUPti4/8uGKSTxcQnw1Lign8i+GsejZjNetu/
         btiyefwNy4xwclYf64Heo8p7Q89fc2ELEH5dkibCG590i0qnhHZhlNLh6ker+af4Tvb3
         faaveXQrls8SOv1kVDawLMirdBuh2Nh9Ju7hBJub5ydvf9560JG1nekpcUKqqT6jPXhn
         uBagclm5jvSXt6nYFNstnRr8ggPcifvBu8fAVtdDLsodCMs0Yy3nGs9/knKw4q44Ptug
         S/0g==
X-Gm-Message-State: AJcUuke7rkvA1cU9aX1mW+Sc8ypUZQigXdZg4C7pgt8LHiJLbRZ1uupg
        X28HEOV8CCzPHjlKB8pRlcHFw5d0g4THb1ahq/wqkIk+bJgwW0DCfnYrM4Y87xFyKFKUySO2krN
        udeP46Y3hDoJcXgTxtu7gdRYLayzuCcqpn98/vEBoD4dDAuz3tKG3ovQxL93O0FU=
X-Google-Smtp-Source: ALg8bN5Xw40yLW2y0eSKQ8NXEBXE2Qpa8RQQn6hb64kmtsJDgJJiTdF1wIHNEP9afzuDB7kMgB+COe97VoBUaA==
X-Received: by 2002:a0c:ae41:: with SMTP id z1mr3487634qvc.11.1547591155411;
 Tue, 15 Jan 2019 14:25:55 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:25:49 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <cover.1547590928.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v6 0/3] Add commit-graph fuzzer and fix buffer overflow
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

Changes since V5:
  * Conform to commit message standards for the 1st patch in the series.
  * Clarify commit message for the 3rd patch in the series.

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

 .gitignore              |  1 +
 Makefile                |  3 +-
 commit-graph.c          | 67 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 ++
 fuzz-commit-graph.c     | 16 ++++++++++
 t/t5318-commit-graph.sh | 16 ++++++++--
 6 files changed, 83 insertions(+), 23 deletions(-)
 create mode 100644 fuzz-commit-graph.c

Range-diff against v5:
1:  0b57ecbe1b ! 1:  c4ec3fc3fc commit-graph, fuzz: Add fuzzer for commit-graph
    @@ -2,11 +2,11 @@
     
         commit-graph, fuzz: Add fuzzer for commit-graph
     
    -    Breaks load_commit_graph_one() into a new function,
    -    parse_commit_graph(). The latter function operates on arbitrary buffers,
    -    which makes it suitable as a fuzzing target. Since parse_commit_graph()
    -    is only called by load_commit_graph_one() (and the fuzzer described
    -    below), we omit error messages that would be duplicated by the caller.
    +    Break load_commit_graph_one() into a new function, parse_commit_graph().
    +    The latter function operates on arbitrary buffers, which makes it
    +    suitable as a fuzzing target. Since parse_commit_graph() is only called
    +    by load_commit_graph_one() (and the fuzzer described below), we omit
    +    error messages that would be duplicated by the caller.
     
         Adds fuzz-commit-graph.c, which provides a fuzzing entry point
         compatible with libFuzzer (and possibly other fuzzing engines).
2:  a3b5d33c4b = 2:  d7b137650f commit-graph: fix buffer read-overflow
3:  350ea5f7c9 ! 3:  c06e0667fa Makefile: correct example fuzz build
    @@ -2,6 +2,15 @@
     
         Makefile: correct example fuzz build
     
    +    The comment explaining how to build the fuzzers was broken in
    +    927c77e7d4d ("Makefile: use FUZZ_CXXFLAGS for linking fuzzers",
    +    2018-11-14).
    +
    +    When building fuzzers, all .c files must be compiled with coverage
    +    tracing enabled. This is not possible when using only FUZZ_CXXFLAGS, as
    +    that flag is only applied to the fuzzers themselves. Switching back to
    +    CFLAGS fixes the issue.
    +
     
      diff --git a/Makefile b/Makefile
-- 
2.20.1.97.g81188d93c3-goog


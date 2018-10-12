Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506871F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJMDgH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 23:36:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40099 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJMDgH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id y23-v6so13072356qtc.7
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=54tIqIgvTW1Kd9BLpUg579M2bkjORoMy/vmp7uZ019U=;
        b=DZsoAL/+GIzEYJBpQ2SW8hqROMyfDXVk9cHQdllayuBQpCtJwa0HtR+fgF8esjOtg6
         ouDYxuofUF2OwyhTB3j8UNxa65nxyvCZDc6/dFDzgp95d2iKeSRICE0AzA6KGSGjyFdk
         UCdPPElTy+2DN9GAhayuz1RlxvCrRuOP5zUjayXNwSg9OSuL7zl6pDDf25L7OGxOM0Hg
         zVh6+5EdOihMzb/uK148+vn48DwcZFLubs0EKJODj6qtSu5Llsb9Z1Fj9gG4/cudYCHL
         Fx8D8/Y/I//PsTsygBi2spLMdEM4DdtRHCrj3UlCg/jTQXGHwAn85f8XCr4kZKCFTiQD
         yWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=54tIqIgvTW1Kd9BLpUg579M2bkjORoMy/vmp7uZ019U=;
        b=W+dE3zPawyz4Xrv/yzYL5IalTH7Dx4evifgAvC9M7z79pkxB4sY6NkhWTvrEuYKPtL
         t44G5f8E/c34q+Gb2c1fAnaARMukGitSQfl0hvhBwemPNcNoM9PAsP6t6TEsJImsxqiM
         1RyqYpL++1I1YRrfIhw2+n/1gUpNUERKuD62/Q3ACsn2pLITDyZQOqearf1vLCw2wASs
         Q0e2U3AgRBmMiMjL0bij5+RN4Z95xaCBGnAheuFnqcQYUo6WMov4pPrkqS7SKfZHFBuP
         +OEHYWVwbxx1PbEFeWCgBCN09hm2xF5nNstBwCsH6GplAkVFcSITuDWzlY819ABDrW1c
         cRaQ==
X-Gm-Message-State: ABuFfohb/+U68sX9l/04bDsQwBPBLcecU0YVfz8Bp1rHeD3ZdrfCKgO+
        VtysWtaz9durkU0ODbgeGX+zOC2b/by2yRZe7apUEXogwNtRjQB6xBfr1RpR7EaQdqhUkiae8Cu
        UuNWHkdgpT4xWgaMN9kARTAJT/qLfB/VzUE8DbTpDSTldF9Cv+08nyvvj6m0=
X-Google-Smtp-Source: ACcGV61BC1ZXQoYKYOc+K2K0b4mZ5BP7inEUcBhG2ZVH414P91ttG1XFlpWLqsla2agAzY1FVW0u2lA2btbT
X-Received: by 2002:a0c:88b2:: with SMTP id 47mr6052060qvn.58.1539374519524;
 Fri, 12 Oct 2018 13:01:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:01:41 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1539373969.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v12 0/8] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a re-roll-up since I haven't received any additional corrections for
almost a week. The changes are very slight and just for clean-up so it is ready
to be promoted to master.

This is the interdiff from last time:

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 510d3537f..d9dccf4d4 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -69,7 +69,7 @@ test_expect_success 'get an error for missing tree object' '
         test_must_fail git -C r5 pack-objects --rev --stdout 2>bad_tree <<-EOF &&
         HEAD
         EOF
-        grep -q "bad tree object" bad_tree
+        grep "bad tree object" bad_tree
 '
 
 test_expect_success 'setup for tests of tree:0' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 53fbf7db8..392caa08f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -192,7 +192,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
         xargs -n1 git -C dst cat-file -t >fetched_types &&
 
         sort -u fetched_types >unique_types.observed &&
-        printf "blob\ncommit\ntree\n" >unique_types.expected &&
+        test_write_lines blob commit tree >unique_types.expected &&
         test_cmp unique_types.expected unique_types.observed
 '
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index c8e3d87c4..08e0c7db6 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -38,8 +38,8 @@ test_expect_success 'specify blob explicitly prevents filtering' '
                  awk -f print_2.awk) &&
 
         git -C r1 rev-list --objects --filter=blob:none HEAD $file_3 >observed &&
-        grep -q "$file_3" observed &&
-        test_must_fail grep -q "$file_4" observed
+        grep "$file_3" observed &&
+        ! grep "$file_4" observed
 '
 
 test_expect_success 'verify emitted+omitted == all' '
@@ -240,7 +240,7 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
         xargs -n1 git -C r3 cat-file -t >unsorted_filtered_types &&
 
         sort -u unsorted_filtered_types >filtered_types &&
-        printf "blob\ntree\n" >expected &&
+        test_write_lines blob tree >expected &&
         test_cmp expected filtered_types
 '
 

Thanks,

Matthew DeVore (8):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: use BUG rather than die
  list-objects-filter-options: do not over-strbuf_init
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |  19 +-
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  60 ++++++-
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  26 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  42 +++++
 t/t6112-rev-list-filters-objects.sh    |  49 ++++++
 12 files changed, 404 insertions(+), 128 deletions(-)

-- 
2.19.1.331.ge82ca0e54c-goog


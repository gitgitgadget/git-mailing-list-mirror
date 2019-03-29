Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49A120248
	for <e@80x24.org>; Fri, 29 Mar 2019 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfC2Vjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 17:39:33 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44683 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2Vjd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 17:39:33 -0400
Received: by mail-qk1-f201.google.com with SMTP id o135so3044315qke.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3UsjalQbROejcv+/Yb4bPfz4V5Ol6C9kgnRRtkTlvq8=;
        b=QQfBPSaBar2K1RN8b45QIZcJAY6aCLLsTcwstKeneuDEeHnXr7lCoyjNMNvSW1wHVB
         2KhvykuHjVknjZUmsUOFyg5KvsuoBHu3TYvAi38x8ZAk4vfUmGaVUm/ZFJO9ocw6/MUG
         Nx9hztwLYTKJZ25Rve0yBuYaNZDqlyFsxtsXi10V9UGGPX+44Y0H6y+CpRrHcQ4zC5Ri
         vOvt8KPYfYLAA7QxjTd77oVpfY2QnL5VW4faddU3ITw/iq49r0wSVHNM3ZX9HtKhmVM6
         5NOdjnWFi4BXYFyvROpY5bMV6vSfy3tA4BvAT4YJMjLZ0y2aTWF9gRCLCsXl8joep4YF
         ruDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UsjalQbROejcv+/Yb4bPfz4V5Ol6C9kgnRRtkTlvq8=;
        b=Iso7gZ0xpXbs+/PR0aVLHE9MoO6o6jH43SBS0+a/nfKdtHv6G0Oky831mCoF2Fbnjy
         zAntnrai1xht1qw0WnlD4vGlUrJEketXhBiOCEl1oRTR7RL0mdaqgDRB7A3rAOAw1r6O
         rTCQRMEb4lGD7+j+kUvrWa9cfN2hvQTi0Qy7C6xDIzujmhdSxK+Tre8eG6QsR+mf1qXH
         IQUNisDKD7yz15e9uER4GDfE/29sDffrYKoIGyxwDOtzutCy6W5VROVRz7L194oDTfyt
         UmlK+5lWlZAIGeunbN7BFCvPCY8pRoKA8E17Z3y79tRZCCsMudmW9W+/4PitHLtkvjIT
         7KBw==
X-Gm-Message-State: APjAAAUxO93zjByfK9UTPO4hH5E+vTxh0AhdXbTRFHL+osdZw2cUaJph
        q84/dMM5n1slpOMyMI3kwkHQK1zHyqI0OnG+5xj+PialZUZgpmC7iPxkpg5+I8SFwhSFiISSr/9
        V8buwBRhTnZzHBgPwV5fxHpS92dOa1m1SMSIWFKxNUKhY9Feuz++JC9viQBs7ZgJTIA9TPpwTQU
        vE
X-Google-Smtp-Source: APXvYqzYoPTITykdB3HrMngziZs6MRxf9tH3HHvqUlwGbxj95HwanGu60FSh1bP9yPNWMeXbpaCovDy3Z0nmPRTuEeVe
X-Received: by 2002:a0c:98c6:: with SMTP id g6mr4081942qvd.6.1553895572490;
 Fri, 29 Mar 2019 14:39:32 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:39:26 -0700
In-Reply-To: <20190326220906.111879-1-jonathantanmy@google.com>
Message-Id: <cover.1553895166.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: [PATCH v2 0/2] Batch fetching of missing blobs in diff and show
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, everyone for the review.

Changes from v1:
 - used test_when_finished (Szeder)
 - used flag to inhibit fetching of missing objects (Dscho)
 - moved the prefetch so that it also works if we request rename
   detection, and included a test demonstrating that (not sure if that
   was what Peff meant)
 - used QUICK flag (I agree that the rescan is probably not that
   valuable here)

Peff also suggested that I use an oidset instead of an oidarray in order
to eliminate duplicates, but that makes it difficult to interface with
fetch_objects(), which takes a pointer and a length (which is
convenient, because if we want to fetch a single object, we can just
point to it and use a length of 1). Maybe the best idea is to have
oidset maintain its own OID array, and have each hash entry store an
index instead of an OID. For now I added a NEEDSWORK.

Jonathan Tan (2):
  sha1-file: support OBJECT_INFO_FOR_PREFETCH
  diff: batch fetching of missing blobs

 diff.c                        |  32 +++++++++++
 object-store.h                |   6 ++
 sha1-file.c                   |   3 +-
 t/t4067-diff-partial-clone.sh | 103 ++++++++++++++++++++++++++++++++++
 unpack-trees.c                |  17 +++---
 5 files changed, 152 insertions(+), 9 deletions(-)
 create mode 100755 t/t4067-diff-partial-clone.sh

Range-diff against v1:
-:  ---------- > 1:  068861632b sha1-file: support OBJECT_INFO_FOR_PREFETCH
1:  d1e604239b ! 2:  44de02e584 diff: batch fetching of missing blobs
    @@ -9,12 +9,6 @@
         blobs", 2017-12-08), but for another command.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
    -    ---
    -    Here's an improvement for those having partial clones.
    -
    -    I couldn't find a good place to place the test (a place that checks how
    -    diff interfaces with the object store would be ideal), so I created a
    -    new one. Let me know if there's a better place to put it.
     
      diff --git a/diff.c b/diff.c
      --- a/diff.c
    @@ -28,38 +22,45 @@
      #ifdef NO_FAST_WORKING_DIRECTORY
      #define FAST_WORKING_DIRECTORY 0
     @@
    - 	if (o->color_moved)
    - 		o->emitted_symbols = &esm;
    + 	QSORT(q->queue, q->nr, diffnamecmp);
    + }
      
    ++static void add_if_missing(struct oid_array *to_fetch,
    ++			   const struct diff_filespec *filespec)
    ++{
    ++	if (filespec && filespec->oid_valid &&
    ++	    oid_object_info_extended(the_repository, &filespec->oid, NULL,
    ++				     OBJECT_INFO_FOR_PREFETCH))
    ++		oid_array_append(to_fetch, &filespec->oid);
    ++}
    ++
    + void diffcore_std(struct diff_options *options)
    + {
     +	if (repository_format_partial_clone) {
     +		/*
     +		 * Prefetch the diff pairs that are about to be flushed.
     +		 */
    ++		int i;
    ++		struct diff_queue_struct *q = &diff_queued_diff;
     +		struct oid_array to_fetch = OID_ARRAY_INIT;
    -+		int fetch_if_missing_store = fetch_if_missing;
     +
    -+		fetch_if_missing = 0;
     +		for (i = 0; i < q->nr; i++) {
     +			struct diff_filepair *p = q->queue[i];
    -+			if (!check_pair_status(p))
    -+				continue;
    -+			if (p->one && p->one->oid_valid &&
    -+			    !has_object_file(&p->one->oid))
    -+				oid_array_append(&to_fetch, &p->one->oid);
    -+			if (p->two && p->two->oid_valid &&
    -+			    !has_object_file(&p->two->oid))
    -+				oid_array_append(&to_fetch, &p->two->oid);
    ++			add_if_missing(&to_fetch, p->one);
    ++			add_if_missing(&to_fetch, p->two);
     +		}
     +		if (to_fetch.nr)
    ++			/*
    ++			 * NEEDSWORK: Consider deduplicating the OIDs sent.
    ++			 */
     +			fetch_objects(repository_format_partial_clone,
     +				      to_fetch.oid, to_fetch.nr);
    -+		fetch_if_missing = fetch_if_missing_store;
     +		oid_array_clear(&to_fetch);
     +	}
     +
    - 	for (i = 0; i < q->nr; i++) {
    - 		struct diff_filepair *p = q->queue[i];
    - 		if (check_pair_status(p))
    + 	/* NOTE please keep the following in sync with diff_tree_combined() */
    + 	if (options->skip_stat_unmatch)
    + 		diffcore_skip_stat_unmatch(options);
     
      diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
      new file mode 100755
    @@ -73,6 +74,8 @@
     +. ./test-lib.sh
     +
     +test_expect_success 'git show batches blobs' '
    ++	test_when_finished "rm -rf server client trace" &&
    ++	
     +	test_create_repo server &&
     +	echo a >server/a &&
     +	echo b >server/b &&
    @@ -91,7 +94,7 @@
     +'
     +
     +test_expect_success 'diff batches blobs' '
    -+	rm -rf server client trace &&
    ++	test_when_finished "rm -rf server client trace" &&
     +
     +	test_create_repo server &&
     +	echo a >server/a &&
    @@ -115,7 +118,7 @@
     +'
     +
     +test_expect_success 'diff skips same-OID blobs' '
    -+	rm -rf server client trace &&
    ++	test_when_finished "rm -rf server client trace" &&
     +
     +	test_create_repo server &&
     +	echo a >server/a &&
    @@ -141,4 +144,29 @@
     +	! grep "want $(cat hash-b)" trace
     +'
     +
    ++test_expect_success 'diff with rename detection batches blobs' '
    ++	test_when_finished "rm -rf server client trace" &&
    ++
    ++	test_create_repo server &&
    ++	echo a >server/a &&
    ++	printf "b\nb\nb\nb\nb\n" >server/b &&
    ++	git -C server add a b &&
    ++	git -C server commit -m x &&
    ++	rm server/b &&
    ++	printf "b\nb\nb\nb\nbX\n" >server/c &&
    ++	git -C server add c &&
    ++	git -C server commit -a -m x &&
    ++
    ++	test_config -C server uploadpack.allowfilter 1 &&
    ++	test_config -C server uploadpack.allowanysha1inwant 1 &&
    ++	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
    ++
    ++	# Ensure that there is exactly 1 negotiation by checking that there is
    ++	# only 1 "done" line sent. ("done" marks the end of negotiation.)
    ++	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
    ++	grep "similarity index" out &&
    ++	grep "git> done" trace >done_lines &&
    ++	test_line_count = 1 done_lines
    ++'
    ++
     +test_done
-- 
2.21.0.197.gd478713db0


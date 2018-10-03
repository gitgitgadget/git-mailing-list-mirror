Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7491F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJDCmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:42:25 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:53310 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:42:25 -0400
Received: by mail-vs1-f73.google.com with SMTP id g184-v6so2295351vsd.20
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KBfixe8iN8u+s8M6xMIoN92tLFDfit9wjnqNEdiLN7E=;
        b=A1bwu1tUNVRaZwRmQRHsp2ufOzi22ZGvpDbF2FA7dCbss9s2u/V4eTMlbqeq/1yuhC
         oY6Y1BVZcpsk5KmZZ8wYW1fuq6leWctz1Mg6AseS7J7UF3uHUTtMhFmDjmPKswCeye08
         nAptD/C2YuGN7CmeasEh9bLZRKywRcwXgfLmHy8gN0bm7RE5L+Rp2bNcuGnBuSOoXHzO
         MnZBkVJWMfderqKJEDBJPv9c6X/TbAVUNbWt5iY+lVKMiH7E4zfU0qKU0aUFG5DHnswY
         jvJfCfsyCwRdPTpjPr4dIuoSVjdLldZLCFmBClK3Qt1Z8Sri6a528Dbtt4FYMSGRFYrs
         uf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KBfixe8iN8u+s8M6xMIoN92tLFDfit9wjnqNEdiLN7E=;
        b=l/UuI/9ESkkVBtR17t+y+0uDeQpt3jCDCxL8tboOErW45e2YVrZ/A/n0yWv/tyiqQs
         ClOfHQUIxirhoQxdH4oqZ4sZLcbNNbQfqfzq7RG16Uc6lTgBxLi5U/Bn+4AD1oFgHM04
         ubFkGSdxmFrUShBFHA9QO6c4EpZ2THOz/5X9beO7+KiS01nzRsXwqzEnTXW+Wu2cp2fG
         OwNduIVYzN0K5Ab0QP6Yk7rPPpiZ49X7+tlnoOPKiOe954VN6fzDQVD5FAuDTw8SuPP4
         x29MIr+TyCBfB/KkA1Whp08BTHamHyFfM2zHETg6t1HaF387wGiIY1dNhOSJOQbqwdV+
         O2mA==
X-Gm-Message-State: ABuFfoiiTmvOeVItO8IE1bnQdtgXc+54f+EVP44OdaegWaQptvZ/92on
        zFpEGW/Q/ZyvSarx6dE3m5nD96HrxgSzwT3uw+kD6hTrcajwGzX8uvQMBM4rWGCRAPagVeyTuS+
        yfDD5MC2bXzhVxNbesFrM5txCpfPH8M08LrClT8ZzJKUnw8end+8GedAcZes=
X-Google-Smtp-Source: ACcGV63OgAM0GTK4o9pRK2d5/9QWq2Y5n7kCrEVity2wot7obNhK//87eZTsPJnheENM4g+Me4FqtkcLtFWZ
X-Received: by 2002:a9f:2724:: with SMTP id a33-v6mr2683458uaa.10.1538596355010;
 Wed, 03 Oct 2018 12:52:35 -0700 (PDT)
Date:   Wed,  3 Oct 2018 12:52:11 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1538592829.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v10 0/8] filter: support for excluding all trees and blobs
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

This is a minor change to the previous rollup. It moves positional
arguments to the end of git-rev-list invocations. Here is an interdiff
from v9:

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 7b6294ca5..53fbf7db8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -168,7 +168,8 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Make sure we only have commits, and all trees and blobs are missing.
-	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
+	git -C dst rev-list --missing=allow-any --objects master \
+		>fetched_objects &&
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
 
@@ -184,7 +185,7 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	git -C dst fsck &&
 
 	# Auto-fetch all remaining trees and blobs with --missing=error
-	git -C dst rev-list master --missing=error --objects >fetched_objects &&
+	git -C dst rev-list --missing=error --objects master >fetched_objects &&
 	test_line_count = 70 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 6e5c41a68..5a61614b1 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -227,7 +227,8 @@ test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for tre
 # Test tree:0 filter.
 
 test_expect_success 'verify tree:0 includes trees in "filtered" output' '
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=tree:0 |
+	git -C r3 rev-list --quiet --objects --filter-print-omitted \
+		--filter=tree:0 HEAD |
 	awk -f print_1.awk |
 	sed s/~// |
 	xargs -n1 git -C r3 cat-file -t |

Thank you,

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
 t/t6112-rev-list-filters-objects.sh    |  43 +++++
 12 files changed, 398 insertions(+), 128 deletions(-)

-- 
2.19.0.605.g01d371f741-goog


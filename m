Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB645C4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7282522CAE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLDStR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:49:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLDStQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:49:16 -0500
Received: (qmail 31717 invoked by uid 109); 4 Dec 2020 18:48:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 18:48:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13928 invoked by uid 111); 4 Dec 2020 18:48:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 13:48:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 13:48:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/9] misc commit-graph and oid-array cleanups
Message-ID: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series came out of an off-list discussion about using oid-array in
commit-graph.c to replace a similar data structure. But I found a couple
of things to clean up along the way.

Surprisingly, this doesn't conflict with Stolee's "chunk-format API"
series from yesterday. Nor any of the other commit-graph work in "seen".

  [1/9]: oid-array.h: drop sha1 mention from header guard
  [2/9]: t0064: drop sha1 mention from filename
  [3/9]: t0064: make duplicate tests more robust
  [4/9]: cache.h: move hash/oid functions to hash.h
  [5/9]: oid-array: make sort function public
  [6/9]: oid-array: provide a for-loop iterator
  [7/9]: commit-graph: drop count_distinct_commits() function
  [8/9]: commit-graph: replace packed_oid_list with oid_array
  [9/9]: commit-graph: use size_t for array allocation and indexing

 cache.h                                       |  94 ---------------
 commit-graph.c                                | 107 +++---------------
 hash.h                                        |  95 ++++++++++++++++
 oid-array.c                                   |  17 ++-
 oid-array.h                                   |  33 +++++-
 t/{t0064-sha1-array.sh => t0064-oid-array.sh} |   9 +-
 6 files changed, 156 insertions(+), 199 deletions(-)
 rename t/{t0064-sha1-array.sh => t0064-oid-array.sh} (90%)

-Peff

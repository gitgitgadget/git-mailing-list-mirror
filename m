Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022EE1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 04:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfBNEba (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 23:31:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:43610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727974AbfBNEba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 23:31:30 -0500
Received: (qmail 29974 invoked by uid 109); 14 Feb 2019 04:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 04:31:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6262 invoked by uid 111); 14 Feb 2019 04:31:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 23:31:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 23:31:28 -0500
Date:   Wed, 13 Feb 2019 23:31:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] some prune optimizations
Message-ID: <20190214043127.GA19019@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are two optimizations for git-prune that we've been running at
GitHub for ages. No particular reason to share them now; they just
finally floated to the top of my todo pile. Do note that I rebased and
polished them (and the third one is brand new), so the concepts are
proven, but it's possible I introduced a new bug. ;)

  [1/3]: prune: lazily perform reachability traversal
  [2/3]: prune: use bitmaps for reachability traversal
  [3/3]: prune: check SEEN flag for reachability

 builtin/prune.c       | 44 +++++++++++++++++++++++++++++++------------
 reachable.c           | 42 +++++++++++++++++++++++++++++++++++++++++
 t/perf/p5304-prune.sh | 35 ++++++++++++++++++++++++++++++++++
 t/t5304-prune.sh      | 12 ++++++++++++
 4 files changed, 121 insertions(+), 12 deletions(-)
 create mode 100755 t/perf/p5304-prune.sh

-Peff

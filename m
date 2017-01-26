Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119AF1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 04:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbdAZEK2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 23:10:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:45100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdAZEK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 23:10:28 -0500
Received: (qmail 31066 invoked by uid 109); 26 Jan 2017 04:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 04:10:28 +0000
Received: (qmail 20060 invoked by uid 111); 26 Jan 2017 04:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:10:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 23:10:25 -0500
Date:   Wed, 25 Jan 2017 23:10:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] (re-)optimizing fsck --connectivity-only
Message-ID: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been playing around with the newly-fixed `fsck --connectivity-only`.
While it's much faster than it was, I was sad to find a case that is
still much slower than "git rev-list --objects --all".

This goes on top of my origin/jk/fsck-connectivity-check-fix, and gives
a noticeable speedup. IMHO it's worth considering as part of the same
topic (which is currently in 'next').

  [1/2]: fsck: move typename() printing to its own function
  [2/2]: fsck: lazily load types under --connectivity-only

 builtin/fsck.c | 87 ++++++++++++++++++----------------------------------------
 fsck.c         |  4 +++
 2 files changed, 31 insertions(+), 60 deletions(-)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDFD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbeAYAyv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:54:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:56546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYAyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:54:50 -0500
Received: (qmail 19503 invoked by uid 109); 25 Jan 2018 00:54:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:54:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31540 invoked by uid 111); 25 Jan 2018 00:55:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:55:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:54:48 -0500
Date:   Wed, 24 Jan 2018 19:54:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] off-by-one errors in git-daemon
Message-ID: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes two off-by-one errors in git-daemon noticed by Michael
(who then nerd-sniped me into fixing them). It also improves
git-daemon's verbose logging of extended attributes, and beefs up the
tests a bit.

Before anyone gets excited, no, these aren't security-interesting
errors. The only effect you could have is for git-daemon to reject your
request as nonsense. ;)

  [1/6]: t5570: use ls-remote instead of clone for interp tests
  [2/6]: t/lib-git-daemon: record daemon log
  [3/6]: daemon: fix off-by-one in logging extended attributes
  [4/6]: daemon: handle NULs in extended attribute string
  [5/6]: t/lib-git-daemon: add network-protocol helpers
  [6/6]: daemon: fix length computation in newline stripping

 daemon.c                | 15 ++++++---------
 t/lib-git-daemon.sh     | 37 ++++++++++++++++++++++++++++++++++---
 t/t5570-git-daemon.sh   | 37 +++++++++++++++++++++++++++++++------
 t/test-lib-functions.sh | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 18 deletions(-)

-Peff

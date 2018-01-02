Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109F01F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbeABVH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:07:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:51002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750865AbeABVH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:07:56 -0500
Received: (qmail 11081 invoked by uid 109); 2 Jan 2018 21:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 21:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19361 invoked by uid 111); 2 Jan 2018 21:08:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 16:08:25 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 16:07:53 -0500
Date:   Tue, 2 Jan 2018 16:07:53 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 0/4] Git removes existing folder when cancelling clone
Message-ID: <20180102210753.GA10430@sigill.intra.peff.net>
References: <FE0E0877-B77D-4BD6-A513-435C251D920A@you-get.com>
 <alpine.LFD.2.21.1801020610400.14363@localhost.localdomain>
 <20180102200443.GA1703@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180102200443.GA1703@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 03:04:43PM -0500, Jeff King wrote:

> So I don't think there's an urgent data-loss bug here; we will only ever
> destroy an empty directory. However, the original intent was to leave
> the filesystem as we found it on a failed or aborted clone, and we
> obviously don't do that in this case. So it might be nice if we could
> restore it to an empty directory.

Here's a patch series to do that. The first three are just preparatory
cleanups; the last one is the interesting bit.

  [1/4]: t5600: fix outdated comment about unborn HEAD
  [2/4]: t5600: modernize style
  [3/4]: clone: factor out dir_exists() helper
  [4/4]: clone: do not clean up directories we didn't create

 builtin/clone.c               |  31 ++++++++++---
 t/t5600-clone-fail-cleanup.sh | 100 +++++++++++++++++++++++++++++++-----------
 2 files changed, 98 insertions(+), 33 deletions(-)

-Peff

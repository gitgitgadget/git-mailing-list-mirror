Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADA320C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbdLHKq4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:46:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:51952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753403AbdLHKqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:46:49 -0500
Received: (qmail 1703 invoked by uid 109); 8 Dec 2017 10:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:46:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30908 invoked by uid 111); 8 Dec 2017 10:47:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:47:11 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:46:47 -0500
Date:   Fri, 8 Dec 2017 05:46:47 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/4] making test-suite tracing more useful
Message-ID: <20171208104647.GA4016@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some rough edges in the "-x" feature of the test
suite. With it, it should be possible to turn on tracing for CI runs.

This is mostly a repost of v1 at:

  https://public-inbox.org/git/20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net

which had some discussion, but wasn't picked up.

I fixed a few typos pointed out by reviewers, and I tried to summarize
the discussion around "magic descriptor 4" in the commit message of
patch 2.  My conclusion there was that none of the options is
particularly good.  The only thing thing that might make sense is making
"7" the magical descriptor. But given that "4" only had one troubling
call, I'm inclined to just leave it as-is and see if this ever comes up
again (especially if we start using "-x" in the Travis builds, then we'd
catch any problems).

  [1/4]: test-lib: silence "-x" cleanup under bash
  [2/4]: t5615: avoid re-using descriptor 4
  [3/4]: test-lib: make "-x" work with "--verbose-log"
  [4/4]: t/Makefile: introduce TEST_SHELL_PATH

 Makefile                 |  8 ++++++++
 t/Makefile               |  6 ++++--
 t/t5615-alternate-env.sh |  6 +++---
 t/test-lib.sh            | 46 +++++++++++++++++++++++++++++++++-------------
 4 files changed, 48 insertions(+), 18 deletions(-)

-Peff

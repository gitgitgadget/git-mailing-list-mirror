Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8D81F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 15:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHLP6F (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 11:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:40758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725648AbfHLP6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 11:58:05 -0400
Received: (qmail 25989 invoked by uid 109); 12 Aug 2019 15:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 15:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23692 invoked by uid 111); 12 Aug 2019 16:00:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 12:00:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 11:58:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] t/perf: rename duplicate-numbered test script
Message-ID: <20190812155803.GA25161@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two perf scripts numbered p5600, but with otherwise different
names ("clone-reference" versus "partial-clone"). We store timing
results in files named after the whole script, so internally we don't
get confused between the two. But "aggregate.perl" just prints the test
number for each result, giving multiple entries for "5600.3". It also
makes it impossible to skip one test but not the other with
GIT_SKIP_TESTS.

Let's renumber the one that appeared later (by date -- the source of the
problem is that the two were developed on independent branches). For the
non-perf test suite, our test-lint rule would have complained about this
when the two were merged, but t/perf never learned that trick.

Signed-off-by: Jeff King <peff@peff.net>
---
This is meant for 2.23, but obviously it's not hurting anything if it
doesn't make the cut. I double-checked that there is no conflict with
anything on pu, either. :)

In other news, I ran the whole perf suite on v2.23.0-rc2, and there was
nothing interesting aside from the expected improvement from 39b44ba771
(check_everything_connected: assume alternate ref tips are valid,
2019-07-01).

 t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} (100%)

diff --git a/t/perf/p5600-clone-reference.sh b/t/perf/p5601-clone-reference.sh
similarity index 100%
rename from t/perf/p5600-clone-reference.sh
rename to t/perf/p5601-clone-reference.sh
-- 
2.23.0.rc2.466.gd4688353c7

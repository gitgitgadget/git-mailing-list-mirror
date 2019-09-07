Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC671F461
	for <e@80x24.org>; Sat,  7 Sep 2019 04:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394333AbfIGE6u (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 00:58:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:42732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394264AbfIGE6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 00:58:49 -0400
Received: (qmail 28029 invoked by uid 109); 7 Sep 2019 04:58:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 04:58:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9493 invoked by uid 111); 7 Sep 2019 05:00:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 01:00:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 00:58:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/2] a few commit-graph improvements
Message-ID: <20190907045848.GA24515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've been playing with commit graphs at GitHub and found a few bits of
low-hanging fruit (one liners -- it doesn't get any lower than that).

The first one is actually a resurrection of a patch from March:

  https://public-inbox.org/git/20190322102817.19708-1-szeder.dev@gmail.com/

where the progress bar sometimes prints nonsense. There's some
discussion in that thread about how we could sometimes show a real
percentage instead of a counting-up progress meter. But given the number
of corner cases discussed, and the fact that nothing has happened for 6
months, I think we should first make sure we're always doing the
_correct_ thing, and then people can build a nicer meter on top if they
want to.

The second is a fix for a small memory "leak", but it makes a big
difference.

  [1/2]: commit-graph: don't show progress percentages while expanding reachable commits
  [2/2]: commit-graph: turn off save_commit_buffer

 builtin/commit-graph.c | 2 ++
 commit-graph.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668E81F428
	for <e@80x24.org>; Tue, 14 Aug 2018 22:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeHOB05 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:26:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:55512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728162AbeHOB05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:26:57 -0400
Received: (qmail 9627 invoked by uid 109); 14 Aug 2018 22:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 22:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27080 invoked by uid 111); 14 Aug 2018 22:37:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 18:37:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 18:37:37 -0400
Date:   Tue, 14 Aug 2018 18:37:37 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@aon.at>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
Message-ID: <20180814223737.GA9241@sigill.intra.peff.net>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
 <20180814223246.GA2379@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814223246.GA2379@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 06:32:47PM -0400, Jeff King wrote:

> I suspect the (largely untested) patch below would make your test
> problems go away. Or instead, we could simply add sigpipe=ok to the
> test_must_fail invocation, but I agree with you that the current
> behavior on OS X is not ideal (the user sees no error message).

Whoops, that patch of course misses adding "sigchain_push(SIGPIPE,
SIG_IGN)" during the fetch-pack operation. I'll leave that as an
exercise to the reader. ;)

-Peff

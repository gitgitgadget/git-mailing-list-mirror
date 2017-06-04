Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44805209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 05:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbdFDFRo (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 01:17:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:34451 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdFDFRn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 01:17:43 -0400
Received: (qmail 2149 invoked by uid 109); 4 Jun 2017 05:17:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 05:17:43 +0000
Received: (qmail 6730 invoked by uid 111); 4 Jun 2017 05:18:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 01:18:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jun 2017 01:17:40 -0400
Date:   Sun, 4 Jun 2017 01:17:40 -0400
From:   Jeff King <peff@peff.net>
To:     Dun Peal <dunpealer@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: How do I regularly clean up .git/objects/pack/tmp_* files?
Message-ID: <20170604051740.gnkrjv35udgipg42@sigill.intra.peff.net>
References: <CAD03jn5CEwZ0H+UKO4yW3PoL+XPXcwUGnehhv-KyBYQCYzAXGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD03jn5CEwZ0H+UKO4yW3PoL+XPXcwUGnehhv-KyBYQCYzAXGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2017 at 04:53:20PM -0400, Dun Peal wrote:

> I try to follow the best practice of regular repo maintenance, which
> afaik consists of running `git gc` every week or so.
> 
> So I thought I had a well-maintained repository, and was quite
> surprised to discover some very large .git/objects/pack/tmp_* files,
> which apparently are entirely needless and should be cleaned up, but
> `git gc` doesn't clean them.
> 
> Is there another command I should regularly run, instead or in
> addition to `git gc`, to keep my repo well-maintained, and
> specifically, to remove such unnecessary files from my .git directory?

They're kept with the same time-based grace period that is used for
unreachable objects, which defaults to the rather conservative "2
weeks". Try "git gc --prune=1.hour.ago".

-Peff

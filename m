Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C6C5320E
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354766AbjHQTvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354783AbjHQTvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:51:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5463535B8
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:51:09 -0700 (PDT)
Received: (qmail 29443 invoked by uid 109); 17 Aug 2023 19:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Aug 2023 19:51:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 597 invoked by uid 111); 17 Aug 2023 19:51:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Aug 2023 15:51:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Aug 2023 15:51:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] commit-graph: fsck zero/non-zero generation
 number fixes
Message-ID: <20230817195108.GC3032779@coredump.intra.peff.net>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
 <20230811175854.GA2816191@coredump.intra.peff.net>
 <xmqqr0o9s7im.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0o9s7im.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 12:28:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This applies on top of yours, but probably would replace patches 2, 4,
> > and 5 (the flip-flop case isn't even really worth testing after this,
> > since the message can obviously only be shown once).
> >
> >  commit-graph.c          | 42 +++++++++--------------------------
> >  t/t5318-commit-graph.sh | 18 ++-------------
> >  2 files changed, 13 insertions(+), 47 deletions(-)
> 
> Quite an impressive amount of code reduction.  I obviously like it.
> 
> One very minor thing is that how much value are we getting by
> reporting the object names of one example from each camp, instead of
> just reporting a single bit "we have commits not counted and also
> counted their generations, which is an anomaly".
> 
> Obviously it does not matter.  Even if we stopped doing so, the code
> would not become much simpler.  We'd just use a word with two bits
> instead of two pointers to existing in-core objects, which does not
> have meaningful performance implications either way.

Yeah, I wasn't sure if the commit names were valuable or not. Two bits
would definitely work (though I have a slight preference for two
boolean variables, just because I find the syntax easier to read).

I don't think we've heard from Taylor, but I saw his original patches
were in 'next'. I'm happy to clean up what I posted, but I'm also happy
if we just merge what's in next and move on.

-Peff

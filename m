Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41231F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHaA4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:56:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727088AbeHaA4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:56:10 -0400
Received: (qmail 10778 invoked by uid 109); 30 Aug 2018 20:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 20:52:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31710 invoked by uid 111); 30 Aug 2018 20:52:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 16:52:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 16:52:08 -0400
Date:   Thu, 30 Aug 2018 16:52:08 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc/Makefile: remove tmp-doc-diff on "make clean"
Message-ID: <20180830205208.GB27399@sigill.intra.peff.net>
References: <20180830081202.GA10224@sigill.intra.peff.net>
 <20180830195546.GA22407@sigill.intra.peff.net>
 <CAPig+cRXEegGwm3QiyEZqkVN1NYv5xAAYRuAKHUE8n-g9m6jqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRXEegGwm3QiyEZqkVN1NYv5xAAYRuAKHUE8n-g9m6jqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 04:34:43PM -0400, Eric Sunshine wrote:

> On Thu, Aug 30, 2018 at 3:55 PM Jeff King <peff@peff.net> wrote:
> > The tmp-doc-diff directory isn't strictly a build product of
> > the Makefile, since it's only present if you manually run
> > the doc-diff script.  But anybody running "make clean" would
> > probably want it to go away.
> >
> > Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > @@ -332,6 +332,7 @@ clean:
> >         $(RM) manpage-base-url.xsl
> > +       $(RM) -r tmp-doc-diff
> 
> Taking into consideration that people might be surprised and alarmed
> to find "git worktree list" showing a worktree they didn't explicitly
> create, would it make sense to do something like this?
> 
> clean:
>     ...
>     -git worktree remove -f tmp-doc-diff 2>/dev/null
>     $(RM) -r tmp-doc-diff

Seems reasonable. Again, I don't have a strong feeling. It's a little
strange to me for the Makefile to be touching bits outside of the actual
working tree. But then, creating a separate worktree in the first place
is perhaps a little weird.

I dunno. Maybe you are right that worktrees are a bad fit here.

-Peff

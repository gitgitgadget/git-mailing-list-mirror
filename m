Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E541211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 06:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAFGTi (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 01:19:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:55728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726258AbfAFGTi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 01:19:38 -0500
Received: (qmail 1447 invoked by uid 109); 6 Jan 2019 06:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 06 Jan 2019 06:19:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27089 invoked by uid 111); 6 Jan 2019 06:19:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 06 Jan 2019 01:19:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2019 01:19:36 -0500
Date:   Sun, 6 Jan 2019 01:19:36 -0500
From:   Jeff King <peff@peff.net>
To:     Stephen P Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] Add 'human' date format
Message-ID: <20190106061935.GA4207@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <2637944.PqRbksyA0G@thunderbird>
 <20190104075034.GA26014@sigill.intra.peff.net>
 <4462659.Bys67ThUBR@thunderbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4462659.Bys67ThUBR@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 04, 2019 at 06:03:18AM -0700, Stephen P Smith wrote:

> On Friday, January 4, 2019 12:50:35 AM MST Jeff King wrote:
> > On Thu, Jan 03, 2019 at 06:19:56AM -0700, Stephen P. Smith wrote:
> > > 
> > > I didn't see anything in the code which would prohibit setting something
> > > like that.
> > 
> > Yeah, I don't think supporting that is too hard. I was thinking
> > something like this:
> 
> I take it that if I update Linus's patch, I still keep Junio's and Linus' 
> sign-off line for the purpose of the chain of custody?  Of should I use a 
> second patch?

I think the most interesting question is the actual authorship (i.e.,
the "From:" field).  I think people are generally OK with having their
patches polished a bit to fix obvious bugs or short-comings. But at some
point if you make too many changes they or may not want to have the
result attributed to them. ;)

For the particular change I suggested, it's borderline to me on whether
it hits that case, so I'd probably err on the side of caution. And I'd
either expect Linus to say "yeah, that sounds like a good direction", or
I'd do it as a separate patch. And if a separate patch, I'd probably
tease Linus's patch out into two separate ones: one to add "human", and
one to implement "auto". And then drop the "auto" one in favor of your
new patch (with you as the author).

And I think that makes the signoff questions go away for this instance
(keep the signoffs for Linus's, and just signoff the new patch
yourself). But here's some general pontificating in that direction:

    Normally you can just drop Junio's signoff. The chain of custody is
    usually "author, then maintainer" and he'll re-add his maintainer
    signoff when he picks up your patch. In this case of this patch it's
    "author, then polisher, then maintainer", but Junio is still at the
    end.

    Now one can argue that Junio picked up Linus's patch, which you then
    picked up from Junio's repository and fed back to Junio. But you
    could just as well have picked Linus's patch up from the mailing
    list and then polished it. So I don't know that having Junio twice
    in the chain is really that interesting.

    Generally, yes, I'd keep Linus's signoff in a situation like this.
    He is asserting that the original work done meets the DCO
    requirements. You polishing the patch does not change that (of
    course you could introduce a bunch of new code that doesn't meet the
    DCO and sign it off anyway, but that's why there's ordering in the
    chain of custody. Somebody investigating would probably walk
    backwards up the chain).

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EAB1F406
	for <e@80x24.org>; Thu, 11 Jan 2018 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754777AbeAKJjq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 04:39:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:40986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753600AbeAKJjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 04:39:46 -0500
Received: (qmail 25764 invoked by uid 109); 11 Jan 2018 09:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 09:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21760 invoked by uid 111); 11 Jan 2018 09:40:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 04:40:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 04:39:43 -0500
Date:   Thu, 11 Jan 2018 04:39:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
Message-ID: <20180111093943.GC9190@sigill.intra.peff.net>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
 <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
 <20180109072044.GD32257@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1801091407480.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c19f6469-190a-33e7-20a2-fcb17b8e45d9@gmail.com>
 <20180110074701.GB16315@sigill.intra.peff.net>
 <xmqqfu7d1n2l.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfu7d1n2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 12:22:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > To be clear, which approach are we talking about? I think there are
> > three options:
> >
> >   1. The user tells us not to bother computing real ahead/behind values.
> >      We always say "same" or "not the same".
> >
> >   2. The user tells us not to bother computing ahead/behind values
> >      with more effort than N. After traversing N commits without getting
> >      an answer, we say "same" or "not the same". But we may sometimes
> >      give a real answer if we found it within N.
> >
> >   3. The user tells us not to spend more effort than N. After traversing
> >      N commits we try to make some partial statement based on
> >      generations (or commit timestamps as a proxy for them).
> >
> > I agree that (3) is probably not going to be useful enough in the
> > general case to merit the implementation effort and confusion. But is
> > there anything wrong with (2)?
> 
> I agree (3) would not be all that interesting.  Offhand I do not see
> a problem with (2).  I think with "real" in your "sometimes give a
> real answer" you meant to say that we limit our answers to just one
> three ("same", "not the same", "ahead/behind by exactly N/M") and I
> think it is a good choice that is easy to explain.

Yes, exactly. That's a better way of saying it.

-Peff

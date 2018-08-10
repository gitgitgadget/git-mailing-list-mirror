Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51381F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHKCFu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 22:05:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:50776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726747AbeHKCFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 22:05:49 -0400
Received: (qmail 28929 invoked by uid 109); 10 Aug 2018 23:33:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:33:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25193 invoked by uid 111); 10 Aug 2018 23:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:33:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:33:47 -0400
Date:   Fri, 10 Aug 2018 19:33:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/7] for_each_*_object: store flag definitions in a
 single location
Message-ID: <20180810233347.GA30479@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
 <20180810230906.GA19875@sigill.intra.peff.net>
 <CAGZ79kYStPNCodJBqZ-ELh2oEhEyQFFjr0SVn0Bn+gtAspbZiA@mail.gmail.com>
 <20180810233133.GA30076@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810233133.GA30076@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 07:31:33PM -0400, Jeff King wrote:

> On Fri, Aug 10, 2018 at 04:27:25PM -0700, Stefan Beller wrote:
> 
> > >  cache.h    | 13 ++++++++++++-
> > >  packfile.h |  8 ++------
> > >  2 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > rubs me the wrong way. ;-)
> > 
> > cache.h is such a misnomer of a name, and a kitchen sink
> > of a file in the Git project that in an ideal world it would
> > be way smaller and contain only things related to some
> > caching related code.
> > 
> > I would suggest object.h or object-store.h instead.
> > Probably the object-store as that will be the only external
> > exposure and hopefully we'd get the objects in a similar
> > shape as the refs subsystem eventually?
> 
> Yes, for_each_loose_object() ought to be in loose.h to match packfile.h,
> or the whole thing should go into object-store.h.

Heh, I thought you were making up a hypothetical object-store.h, but I
see it has already come to pass.

IMHO the whole for_each_*_object() interface should go in there (it even
has packed_git defined there already!). I think I'd still just as soon
do it on top of this series, but it might not be too bad to do as part
of a re-roll.

-Peff

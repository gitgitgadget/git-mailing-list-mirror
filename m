Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058D1202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdJBFFK (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:05:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:57000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBFFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:05:09 -0400
Received: (qmail 5519 invoked by uid 109); 2 Oct 2017 05:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:05:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25017 invoked by uid 111); 2 Oct 2017 05:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:05:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:05:07 -0400
Date:   Mon, 2 Oct 2017 01:05:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
Message-ID: <20171002050507.i27l2iulfbskmnpx@sigill.intra.peff.net>
References: <20170930062238.87077-1-me@ttaylorr.com>
 <20170930062238.87077-5-me@ttaylorr.com>
 <xmqqbmlrutsm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmlrutsm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 06:00:25PM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index 2a9fcf713..2bd0c5da7 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -597,6 +597,9 @@ Acked-by: A U Thor
> >    <author@example.com>
> >  EOF
> >  
> > +unfold () {
> > +	perl -0pe 's/\n\s+/ /'
> > +}
> 
> For the purpose of the current shape of the test, the above might be
> sufficient, but the lack of "/g" at the end means that the script
> will happily stop after unfolding just one line, which probably is
> not what you intended.

This is indirectly my fault, since this was copied from my t4205
version. It might be worth fixing while we're thinking about it, as it's
a potential trap for future changes.

-Peff

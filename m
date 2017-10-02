Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711C4202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdJBFOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:14:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:57052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750983AbdJBFOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:14:20 -0400
Received: (qmail 5951 invoked by uid 109); 2 Oct 2017 05:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:14:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25247 invoked by uid 111); 2 Oct 2017 05:15:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:15:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:14:17 -0400
Date:   Mon, 2 Oct 2017 01:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002051417.hrdbxowk7eoczpcd@sigill.intra.peff.net>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
 <20171002003304.77514-6-me@ttaylorr.com>
 <20171002050351.imuntcy3xnq4wxux@sigill.intra.peff.net>
 <20171002051216.GB5566@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002051216.GB5566@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 10:12:16PM -0700, Taylor Blau wrote:

> > Doh, that string_list behavior is what I was missing in my earlier
> > comments. I agree this is probably the best way of doing it. I'm tempted
> > to say that parse_ref_filter_atom() should do a similar thing. Right now
> > we've got:
> >
> >   $ git for-each-ref --format='%(refname)' | wc
> >      2206    2206   79929
> >   $ git for-each-ref --format='%(refname:short)' | wc
> >      2206    2206   53622
> >   $ git for-each-ref --format='%(refname:)' | wc
> >   fatal: unrecognized %(refname:) argument:
> >       0       0       0
> >
> > which seems a bit unfriendly. As we're on v6 here, I don't want to
> > suggest it as part of this series. But maybe a #leftoverbits candidate,
> > if others agree it's a good direction.
> 
> I think #leftoverbits is fine here, but I think addressing this before
> 2.15 is reasonable. I can take a look at this in a future patch series.

I think it would be to just do it as a standalone patch immediately. I
just didn't want to hold your series hostage to a potential
disagreement.

-Peff

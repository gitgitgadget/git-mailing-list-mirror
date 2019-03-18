Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCEF20248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCRVwg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:52:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727137AbfCRVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:52:35 -0400
Received: (qmail 11552 invoked by uid 109); 18 Mar 2019 21:52:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:52:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24073 invoked by uid 111); 18 Mar 2019 21:52:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:52:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:52:33 -0400
Date:   Mon, 18 Mar 2019 17:52:33 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190318215233.GI29661@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
 <20190313193909.GB3400@sigill.intra.peff.net>
 <20190313201854.GA5530@sigill.intra.peff.net>
 <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
 <20190318211215.GB29661@sigill.intra.peff.net>
 <20190318214842.GA32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318214842.GA32487@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 09:48:42PM +0000, Thomas Gummerer wrote:

> > It looks like GitGitGadget just uses normal SMTP to submit the messages.
> > I wonder if normal people using gmail as their SMTP server for
> > send-email also suffer from this. I've not ever noticed it, but I
> > don't know how common that setup is.
> 
> I am using gmail as my SMTP server with 'git send-email', and it
> doesn't look like gmail is rewriting anything there, see [*1*] for
> example.  The date header looks like this:
> 
>     Date: Mon, 25 Feb 2019 23:16:04 +0000
> 
> Note the +0000 there, compared to the GMT that GitGitGadget uses.
> Looking at RFC2822, that's the new version of specifying the timezone,
> while GMT is only defined in the obsolete time and date section.  I
> guess gmail might just not like that anymore and rewrite it.
> 
> So fixing this might not be that hard, and might not involve sleeping
> while sending the patch series at all.  Changing how the date is
> calculated in [*2*] might be all that's needed.

Yes, if it really is as simple as just "gmail doesn't like our date
format, so it rewrites the header", that would be wonderful. Thanks for
an extra data point.

-Peff

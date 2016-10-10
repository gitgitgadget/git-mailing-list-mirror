Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ED720986
	for <e@80x24.org>; Mon, 10 Oct 2016 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbcJJO2j (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 10:28:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbcJJO2i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 10:28:38 -0400
Received: (qmail 25682 invoked by uid 109); 10 Oct 2016 14:28:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 14:28:20 +0000
Received: (qmail 30928 invoked by uid 111); 10 Oct 2016 14:28:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 10:28:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 10:28:18 -0400
Date:   Mon, 10 Oct 2016 10:28:18 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: %C(auto) not working as expected
Message-ID: <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 04:26:18PM +0700, Duy Nguyen wrote:

> > If we do a revamp of the pretty-formats to bring them more in line with
> > ref-filter (e.g., something like "%(color:red)") maybe that would be an
> > opportunity to make minor adjustments. Though, hmm, it looks like
> > for-each-ref already knows "%(color:red)", and it's unconditional.
> > <sigh> So perhaps we would need to go through some deprecation period or
> > other transition.
> 
> We could add some new tag to change the behavior of all following %C
> tags. Something like %C(tty) maybe (probably a bad name), then
> discourage the use if "%C(auto" for terminal detection?

Yeah, adding a "%C(enable-auto-color)" or something would be backwards
compatible and less painful than using "%C(auto)" everywhere. I do
wonder if anybody actually _wants_ the "always show color, even if
--no-color" behavior. I'm having trouble thinking of a good use for it.

IOW, I'm wondering if anyone would disagree that the current behavior is
simply buggy. Reading the thread at:

  http://public-inbox.org/git/7v4njkmq07.fsf@alter.siamese.dyndns.org/

I don't really see any compelling reason against it (there was some
question of which config to use, but we already answered that with
"%C(auto)", and use the value from the pretty_ctx).

-Peff

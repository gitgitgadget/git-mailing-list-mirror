Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1441C1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbcLFNvP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:51:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:52395 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752957AbcLFNvP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:51:15 -0500
Received: (qmail 17917 invoked by uid 109); 6 Dec 2016 13:51:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:51:14 +0000
Received: (qmail 13432 invoked by uid 111); 6 Dec 2016 13:51:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 08:51:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 08:51:13 -0500
Date:   Tue, 6 Dec 2016 08:51:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 12:04:52PM -0800, Junio C Hamano wrote:

> > I'm sending out another reroll of this series so that in Jeff's he can
> > just call 'get_curl_allowed_protocols(-1)' for the non-redirection curl
> > option, which should make this test stop barfing.
> 
> I was hoping to eventually merge Peff's series to older maintenance
> tracks.  How bad would it be if we rebased the v8 of this series
> together with Peff's series to say v2.9 (or even older if it does
> not look too bad)?

My series actually fixes existing security problems, so I'd consider it
a bug-fix. I _think_ Brandon's series is purely about allowing more
expressiveness in the whitelist policy, and so could be considered more
of a feature.

So one option is to apply my series for older 'maint', and then just
rebase Brandon's on top of that for 'master'.

I don't know if that makes things any easier. I feel funny saying "no,
no, mine preempts yours because it is more maint-worthy", but I think
that order does make sense.

I think it would be OK to put Brandon's on maint, too, though. It is a
refactor of an existing security feature to make it more featureful, but
the way it is implemented could not cause security regressions unless
you use the new feature (IOW, we still respect the whitelist environment
exactly as before).

-Peff

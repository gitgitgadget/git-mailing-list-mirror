Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401801F856
	for <e@80x24.org>; Thu,  8 Sep 2016 20:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbcIHUDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 16:03:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752115AbcIHUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 16:03:10 -0400
Received: (qmail 14390 invoked by uid 109); 8 Sep 2016 20:03:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 20:03:08 +0000
Received: (qmail 17888 invoked by uid 111); 8 Sep 2016 20:03:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 16:03:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 16:03:05 -0400
Date:   Thu, 8 Sep 2016 16:03:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
Message-ID: <20160908200305.okeeh35xmrvcveyg@sigill.intra.peff.net>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
 <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
 <alpine.DEB.2.20.1609061827290.129229@virtualbox>
 <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox>
 <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
 <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
 <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 11:20:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Sep 07, 2016 at 10:27:34AM +0200, Michael J Gruber wrote:
> >
> >> Now, I can't reproduce C on Linux[*], so there is more involved. It
> >> could be that my patch just exposes a problem in our start_command()
> >> etc.: run-command.c contains a lot of ifdefing, so possibly quite
> >> different code is run on different platforms.
> >
> > Maybe, though my blind guess is that it is simply that on Linux we can
> > open /dev/tty directly, and console-IO on Windows is a bit more
> > complicated.
> 
> True.
> 
> Even though this patch is fixing only one of the two issues, I am
> tempted to say that we should queue it for now, as it does so
> without breaking a bigger gain made by the original, i.e. we learn
> the status of verification in a way the authors of GPG wants us to,
> while somebody figuires out what the best way is to show the prompt
> to the console on Windows.

That's OK by me, but I don't know if we can put off the "best way to
show the prompt" fix. It seems like a pretty serious regression for
people on Windows.

-Peff

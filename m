Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF6C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54EC60527
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhIVCdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:33:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:52330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhIVCdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:33:31 -0400
Received: (qmail 7500 invoked by uid 109); 22 Sep 2021 02:32:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 02:32:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8661 invoked by uid 111); 22 Sep 2021 02:32:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 22:32:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 22:32:01 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUqVoVgt47E80HhV@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
 <nycvar.QRO.7.76.2109212351440.26668@fvyyl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.2109212351440.26668@fvyyl>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:00:03AM +0200, Daniel Stenberg wrote:

> > At any rate, I wonder if it would be friendlier for curl to hand strings
> > to the debug function with the usual capitalization.
> 
> Maybe that could've been a good idea if we had done it when we introduced
> HTTP/2 support. Now, I think that ship has sailed already as libcurl has
> supported HTTP/2 since late 2013 and changing anything like that now will
> just risk introducing the reverse surprise in applications. Better not rock
> that boat now methinks.

Oof, that's much older than I realized. I agree the ship has long
sailed, and we are better off leaving things as-is.

> > PS This nit aside, it is totally cool that I have been seamlessly using
> >   HTTP/2 to talk to github.com without even realizing it. I wonder for
> >   how long!
> 
> I don't know when github.com started supporting h2, but since libcurl 7.62.0
> (released Oct 31, 2018) it has negotiated h2 by default over HTTPS.

I dug a bit. Looks like it was enabled at the load-balancing layer of
github.com around January of this year.

-Peff

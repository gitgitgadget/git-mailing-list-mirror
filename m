Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 928CB2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764148AbcHEUUx (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:20:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:55541 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S942718AbcHEUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:20:50 -0400
Received: (qmail 9487 invoked by uid 102); 5 Aug 2016 20:20:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 16:20:50 -0400
Received: (qmail 29997 invoked by uid 107); 5 Aug 2016 20:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 16:21:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 16:20:47 -0400
Date:	Fri, 5 Aug 2016 16:20:47 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160805202046.pd42xl76c2sbf272@sigill.intra.peff.net>
References: <20160710004813.GA20210@dcvr.yhbt.net>
 <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
 <CACsJy8DkNUD_dKwnx9nZsgvSxgdA8MH=2+rEWzMFdkigmhpJ5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DkNUD_dKwnx9nZsgvSxgdA8MH=2+rEWzMFdkigmhpJ5g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 05:04:27PM +0200, Duy Nguyen wrote:

> On Fri, Aug 5, 2016 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> > There was discussion a long time ago about storing a common zlib
> > dictionary in the packfile and using it for all of the objects. I don't
> > recall whether there were any patches, though. It does create some
> > complications with serving clones/fetches, as they may ask for a subset
> > of the objects (so you have to send them the whole dictionary, which may
> > be a lot of overhead if you're only fetching a few objects).
> 
> I'm nit picking since it's not actually "all objects". But pack v4
> patches have two dictionaries (or more? i don't remember) for commits
> and trees :)

I couldn't remember if that zlib stuff was part of packv4 or not. I like
many of the ideas in pack v4, but I do worry a lot about the
compatibility issues, as packv2 is the on-the-wire format.

Being able to send bytes directly off disk with minimal processing is a
key thing that makes running a large git hosting site practical. One of
the things that makes nervous is having to do on-the-fly conversion when
serving fetches and clones (but to be clear that is just gut
nervousness; I haven't done any actual testing with the proto-packv4
patches).

-Peff

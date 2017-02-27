Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E191F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdB0VMo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:12:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:35144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdB0VMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:12:42 -0500
Received: (qmail 27834 invoked by uid 109); 27 Feb 2017 20:45:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 20:45:52 +0000
Received: (qmail 19556 invoked by uid 111); 27 Feb 2017 20:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 15:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 15:45:49 -0500
Date:   Mon, 27 Feb 2017 15:45:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        "G. Sylvie Davies" <sylvie@bit-booster.com>,
        Michael Spiegel <michael.m.spiegel@gmail.com>,
        git@vger.kernel.org
Subject: Re: show all merge conflicts
Message-ID: <20170227204549.75aajp3rpsgl6fhz@sigill.intra.peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
 <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
 <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
 <20170128142808.hefnv7r3h6zidobw@sigill.intra.peff.net>
 <CAAj3zPx5fKHUTLLEuuZjmq+H5somp980j0hqWjmLyvLuk709GQ@mail.gmail.com>
 <6ff25254-720e-5b85-ba6d-22b16e91b354@drmicha.warpmail.net>
 <xmqqr32jwh7o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr32jwh7o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:45:31AM -0800, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > If you're curious, I kept rebasing Thomas' remerge-diff (on top of our
> > next) so far. You can find it at
> >
> > https://github.com/mjg/git/tree/remerge-diff
> 
> ;-).
> Yes, this was a good one.

FWIW, I have also been carrying it forward. It's not a tool I reach for
often, but a couple of times it has come in very handy (mostly helping
somebody to track down a mistake that somebody made in a merge, like
accidentally using "checkout --ours" on top of a conflict).

> > if you're interested. I don't know what problems were found back then,
> > or what it would take to get this in-tree now.
> 
> If I recall correctly, everybody was in favor of what it does (or at
> least attempted to do), but was leaky and not ready for "log -p" to
> be used on a long stretch of history or something?

The last round was at:

  http://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/

I think. I think the leakiness was dealt with by rebasing onto the
name_hash refactoring. But it looks like there are a lot of little
issues, and maybe one bigger one: it turns "log" from a read-only
operation into that writes into the object database.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF27E1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 14:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbcLFODJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 09:03:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:52413 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbcLFODG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 09:03:06 -0500
Received: (qmail 18627 invoked by uid 109); 6 Dec 2016 14:03:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 14:03:01 +0000
Received: (qmail 13550 invoked by uid 111); 6 Dec 2016 14:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 09:03:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 09:03:00 -0500
Date:   Tue, 6 Dec 2016 09:03:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
Message-ID: <20161206140259.lly76xkvsj7su3om@sigill.intra.peff.net>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
 <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2016 at 10:01:19AM -0800, Junio C Hamano wrote:

> > That said, I think the right patch may be to just drop --abbrev
> > entirely.
> > ...
> > I think at that point it was a noop, as 7 should have been the default.
> > And now we probably ought to drop it, so that we can use the
> > auto-scaling default.
> 
> Yeah, I agree.
> 
> It does mean that snapshot binaries built out of the same commit in
> the same repository before and after a repack have higher chances of
> getting named differently, which may surprise people, but that
> already is possible with a fixed length if the repacking involves
> pruning (albeit with lower probabilities), and I do not think it is
> a problem.

I think that the number is already unstable, even with --abbrev, as it
just specifies a minimum. So any operation that creates objects has a
possibility of increasing the length. Or more likely, two people
describing the same version may end up with different strings because
they have different objects in their repositories (e.g., I used to
carry's trast's git-notes archive of the mailing list which added quite
a few objects).

I agree that having it change over the course of a repack is slightly
_more_ surprising than those cases, but ultimately the value just isn't
stable.

-Peff

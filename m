Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5E420969
	for <e@80x24.org>; Sat,  1 Apr 2017 08:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdDAIvF (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:51:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:55338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbdDAIvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:51:02 -0400
Received: (qmail 32030 invoked by uid 109); 1 Apr 2017 08:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:51:00 +0000
Received: (qmail 16420 invoked by uid 111); 1 Apr 2017 08:51:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:51:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:50:58 -0400
Date:   Sat, 1 Apr 2017 04:50:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] completion: offer ctags symbol names for 'git log
 -S', '-G' and '-L:'
Message-ID: <20170401085058.y7u73x6beqgnhrcb@sigill.intra.peff.net>
References: <20170324005256.ji2wijhyqnwbpp5t@sigill.intra.peff.net>
 <20170330100656.18766-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170330100656.18766-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 12:06:56PM +0200, SZEDER Gábor wrote:

> >   1. You still have to come up with the filename yourself for "-L".
> 
> I was already quite satisfied that both the symbol name and the 
> filename can be TAB completed...  but right, in most cases the
> function name uniquely determines the filename, and even when it
> doesn't, it still significantly limits the possibilities.  Hmhm.

I find that I often forget which file a function is defined in,
especially in Git's code base (where it sometimes feels somewhat
random :) ).

> OTOH, the proof-of-concept patch at the bottom shows how we could
> start doing filename completion based on the ctags file, and I think
> it's really convenient to use.  Alas, it doesn't work when the
> funcname is not on its own, e.g. ends with that disambiguating '\(:'
> from above, and then Bash falls back to its own filename completion.
> However, if I may extrapolate from my ~/.bash_history, this would
> still help the great majority of the cases.

Yeah, I think that would go a long way to solving my problem.

> > I have a script (below) which makes this easier (and I complete its
> > argument using the tags file).  It's probably too gross to even go into
> > contrib, but I thought I'd share.
> 
> Perhaps 'git log -L' could be enhanced to just DWIM when it gets only
> '-L:func:', and show the log of that function, wherever it is defined.
> So instead of complaining about the missing filename, it could run
> 'grep <func>' with a bit of magic to find the filename where the
> matching function is declared, and search in the history of that file.
> 
> But then again, 'git log -L' could be enhanced in so many ways...

Yes, that sounds even nicer.

-Peff

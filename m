Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36561FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbcHWVsr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:48:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60013 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753294AbcHWVsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:48:46 -0400
Received: (qmail 17736 invoked by uid 109); 23 Aug 2016 21:41:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Aug 2016 21:41:23 +0000
Received: (qmail 28690 invoked by uid 111); 23 Aug 2016 21:41:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Aug 2016 17:41:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Aug 2016 17:41:20 -0400
Date:   Tue, 23 Aug 2016 17:41:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
Subject: Re: git-config(1) should mention `git -c`
Message-ID: <20160823214120.ekaq4mul3pamweej@sigill.intra.peff.net>
References: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
 <20160822185709.izdfbkbsmeip5u7c@sigill.intra.peff.net>
 <xmqqpoozwgm5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoozwgm5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:16:18AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That seems like the most sensible place, as that is where we should
> > cover the order of reading and precedence. Perhaps FILES should be
> > renamed to SOURCES or something (though I do not recall if we are
> > restricted to "usual" manpage section names or not).
> >
> > Arguably this is not about git-config the program at all, but the
> > general concept of "configuration for git", because the precedence rules
> > apply equally to all of the git programs that read config.
> 
> True, but that argument leads us to say git(1) is the best place ;-)

Sort of. I agree it is a good place to mention the precedence, but...

> If the user wants to know "how does the configuration values get
> read?", and wishes not having to go around fishing for the
> information in multiple places (and I think that is a reasonable
> thing to wish for), I think adding it to the FILES section of
> git-config(1) is a better option than inventing a separate
> gitconfig(7), which would still require the user to consult two
> places.

The flip side of "fishing for the information in multiple places" is "I
know it is somewhere in git-config(1), but I have to wade through a
bunch of cruft about git-config command-line options to find it".

So I'd argue that the concept of config (overview, precedence, file
syntax, list of options) could be separate from both git-config(1) and
from git(1), and that both of those places could point to it. That
introduces a level of indirection which is annoying the first time ("I
am reading git-config(1), but now I have to jump to another manpage")
but helpful the other times ("I know I want config concepts, not the
config tool; I can immediately jump to the right place").

Anyway. Just my two cents on the matter. I think we can improve David's
complaint without anything so drastic.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE1D20986
	for <e@80x24.org>; Tue,  4 Oct 2016 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbcJDMHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:07:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbcJDMHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:07:39 -0400
Received: (qmail 15096 invoked by uid 109); 4 Oct 2016 12:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 12:07:38 +0000
Received: (qmail 3702 invoked by uid 111); 4 Oct 2016 12:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 08:07:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 08:07:35 -0400
Date:   Tue, 4 Oct 2016 08:07:35 -0400
From:   Jeff King <peff@peff.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re: Slow pushes on 'pu' - even when up-to-date..
Message-ID: <20161004120735.pbhejoqpwiccemga@sigill.intra.peff.net>
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
 <20161004111845.GA20309@book.hvoigt.net>
 <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
 <20161004120421.GA20701@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004120421.GA20701@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:04:21PM +0200, Heiko Voigt wrote:

> > I think the only sane default is going to be some kind of heuristic that
> > says "submodules are probably in use". Something like "is there a
> > .gitmodules file" is not perfect (you can have gitlink entries without
> > it), but it's a really cheap constant-time check.
> 
> I agree. We are adding convenience for submodules, so we can also say a
> checked out ".gitmodules" file is a must to have convenience.
> 
> I am not sure if I agree on another layer of options for this as
> suggested in your post. More options mean more implementation
> complexity and more confusion on the users side.
> 
> How about we choose our defaults based on the existence of a checked out
> .gitmodules file? So the default would only be --recurse-submodules=check
> if there is a .gitmodules file in the worktree. All other users need to
> either pass or explicitly configure it.

That's OK with me. Though you may end up in the long run wanting some
name for the default behavior (e.g., if people configure something else
and then want to override back to "auto" in some instances), but that
can probably come later.

-Peff

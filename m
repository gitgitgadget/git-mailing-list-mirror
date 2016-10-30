Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7288020193
	for <e@80x24.org>; Sun, 30 Oct 2016 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbcJ3VMb (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 17:12:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:36262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbcJ3VMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 17:12:30 -0400
Received: (qmail 1035 invoked by uid 109); 30 Oct 2016 21:12:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 21:12:30 +0000
Received: (qmail 12628 invoked by uid 111); 30 Oct 2016 21:12:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Oct 2016 17:12:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Oct 2016 17:12:27 -0400
Date:   Sun, 30 Oct 2016 17:12:27 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Anders Kaseorg <andersk@mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
Message-ID: <20161030211227.4gqovv7mt7mtnpy7@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
 <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
 <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu>
 <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2016 at 08:09:21PM -0000, Philip Oakley wrote:

> > It is documented (Documentation/git-sh-setup.txt), and this is not the
> > internal Documentation/technical section of the documentation, so my
> > default assumption would be that everything shown there is intended as
> > public.  I only bring this up as a question because it was apparently
> > allowed to break.  If I’m wrong and it isn’t public, other patches are
> > needed (to the documentation and to its users in contrib).
> > 
> But the Documenation does say ::
> 
> - This is not a command the end user would want to run. Ever.
> 
> - This documentation is meant for people who are studying the Porcelain-ish
> scripts and/or are writing new ones.
> --

Historically speaking, porcelain-ish scripts were carried both in and
out of git.git. These days what we consider porcelain is usually carried
in-tree, but I don't think it's unreasonable for people building their
own scripts to want to make use of git-sh-setup. And we've generally
tried to retain backwards compatibility in the functions it provides,
even to out-of-tree scripts.

So I think it is worth applying the fix at the start of this thread to
keep that working.

As for a documentation change for "do not use this for out-of-tree
scripts", I am mildly negative, as I don't think that matches historical
practice.

-Peff

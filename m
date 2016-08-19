Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB38C1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755125AbcHSPGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:06:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58161 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754047AbcHSPGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:06:35 -0400
Received: (qmail 3774 invoked by uid 109); 19 Aug 2016 15:06:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 15:06:34 +0000
Received: (qmail 26289 invoked by uid 111); 19 Aug 2016 15:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 11:06:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 11:06:32 -0400
Date:   Fri, 19 Aug 2016 11:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
Message-ID: <20160819150632.wa4wvidzqmrrkcfs@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
 <20160818154213.GA17141@tb-raspi>
 <alpine.DEB.2.20.1608191423440.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608191423440.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 02:25:51PM +0200, Johannes Schindelin wrote:

> > On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:
> > > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > > index 5ff58b3..5f91cf4 100644
> > > --- a/builtin/cat-file.c
> > > +++ b/builtin/cat-file.c
> > > @@ -17,6 +17,7 @@ struct batch_options {
> > >  	int print_contents;
> > >  	int buffer_output;
> > >  	int all_objects;
> > > +	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> > How do I read 'w' and 'c' ?
> > wilter and cextconv ? Does it make sense to use an enum here ?
> > Or a #define ?
> 
> Sorry, Torsten, this is not my doing. So I cannot explain why it is not an
> enum.
> 
> I *guess* the rationale for 'c' being the cmdmode of --textconv is "c for
> convert". That is why I chose "w as in worktree" as new cmdmode.

I think it started as a 'char' because it was representing the
single-letter options of "cat-file -e", "cat-file -s", etc. And then the
textconv patches started the monstrosity of "c".

I don't think cleaning it up needs to be part of your series, but it
might be nice low-hanging fruit for somebody to clean up on top.

-Peff

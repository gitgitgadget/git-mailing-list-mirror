Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9F720195
	for <e@80x24.org>; Sat, 16 Jul 2016 01:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbcGPBXI (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 21:23:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:45781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbcGPBXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 21:23:08 -0400
Received: (qmail 23629 invoked by uid 102); 16 Jul 2016 01:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:23:08 -0400
Received: (qmail 20902 invoked by uid 107); 16 Jul 2016 01:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:23:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 21:23:04 -0400
Date:	Fri, 15 Jul 2016 21:23:04 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 02/12] rev-list: add optional progress reporting
Message-ID: <20160716012303.GA30820@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
 <20160715102806.GB19271@sigill.intra.peff.net>
 <xmqqk2gmn5m3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2gmn5m3.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 11:00:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index b82bcc3..88d95a7 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -9,6 +9,7 @@
> >  #include "log-tree.h"
> >  #include "graph.h"
> >  #include "bisect.h"
> > +#include "progress.h"
> >  
> >  static const char rev_list_usage[] =
> >  "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
> > @@ -49,12 +50,17 @@ static const char rev_list_usage[] =
> >  "    --bisect-all"
> >  ;
> >  
> > +struct progress *progress;
> > +unsigned progress_counter;
> 
> Are these supposed to be file-scope static?

Yep, they should be (I had originally made them part of the rev_info,
but then forgot to give them "static" when I pulled them out).

-Peff

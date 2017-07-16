Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80B420357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdGPLId (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:08:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:42024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751087AbdGPLId (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:08:33 -0400
Received: (qmail 26954 invoked by uid 109); 16 Jul 2017 11:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 11:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25094 invoked by uid 111); 16 Jul 2017 11:08:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 07:08:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 07:08:31 -0400
Date:   Sun, 16 Jul 2017 07:08:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
Message-ID: <20170716110831.c442ihan6tzf7gmn@sigill.intra.peff.net>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
 <20170716104114.7tfcuilsy3ab74n6@sigill.intra.peff.net>
 <e91c204d-0bcb-9614-b62d-cd87c03b92e1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e91c204d-0bcb-9614-b62d-cd87c03b92e1@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 01:06:45PM +0200, René Scharfe wrote:

> > > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > > index b8514a0029..adf572da68 100644
> > > --- a/builtin/ls-files.c
> > > +++ b/builtin/ls-files.c
> > > @@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
> > >   	int pos;
> > >   	unsigned int first, last;
> > > 
> > > -	if (!prefix)
> > > +	if (!prefix || !istate->cache_nr)
> > >   		return;
> > >   	pos = index_name_pos(istate, prefix, prefixlen);
> > >   	if (pos < 0)
> > 
> > "git am" complained that this does not apply to its blobs. Did you
> > hand-edit?
> 
> I didn't, but perhaps I messed up the order of patches?  MOVE_ARRAY
> patch 2 touches the same file, but I wouldn't expect the two changes to
> conflict.  So not sure what's going on.

For some reason there's an extra space before the tab on each of the
context lines. MUA issue or cut-and-paste, maybe?

-Peff

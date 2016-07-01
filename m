Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3322018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcGASIc (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:08:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:39228 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbcGASIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:08:32 -0400
Received: (qmail 22328 invoked by uid 102); 1 Jul 2016 18:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 14:01:46 -0400
Received: (qmail 20294 invoked by uid 107); 1 Jul 2016 18:02:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 14:02:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 14:01:43 -0400
Date:	Fri, 1 Jul 2016 14:01:43 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 1/5] t9300: factor out portable "head -c" replacement
Message-ID: <20160701180142.GC16235@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090753.GA17463@sigill.intra.peff.net>
 <xmqqd1mxz30m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1mxz30m.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 10:23:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In shell scripts it is sometimes useful to be able to read
> > exactly N bytes from a pipe. Doing this portably turns out
> > to be surprisingly difficult.
> 
> I'd rotate the above by three words ;-).
> 
>     It is sometimes useful to be able to read
>     exactly N bytes from a pipe. Doing this portably turns out
>     to be surprisingly difficult
>     in shell scripts.

Yeah, I'd very much agree with that (feel free to mark it up as you
apply).

> >   - "dd bs=1 count=$n" fixes the partial read problem (all
> >     reads are 1-byte, so there can be no partial response).
> >     It does make a lot of write() calls, but for our tests
> >     that's unlikely to matter.
> 
> It makes me wonder if it helps to use different ibs and obs if many
> writes bother you, but because this patch moves us away from dd,
> that is a moot point.

Actually, I just mis-spoke (mis-wrote?). I meant to say that it makes a
lot of read() calls. (It probably also makes a lot of write() calls, but
that is beside the point).

-Peff

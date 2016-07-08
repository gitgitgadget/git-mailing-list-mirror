Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B241F2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbcGHVlO (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 17:41:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:42131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754606AbcGHVlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 17:41:13 -0400
Received: (qmail 4681 invoked by uid 102); 8 Jul 2016 21:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:41:13 -0400
Received: (qmail 15856 invoked by uid 107); 8 Jul 2016 21:41:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 17:41:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 17:41:09 -0400
Date:	Fri, 8 Jul 2016 17:41:09 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] avoid using sha1_to_hex output as printf format
Message-ID: <20160708214109.GA9820@sigill.intra.peff.net>
References: <20160708092510.GB17072@sigill.intra.peff.net>
 <20160708092526.GB18263@sigill.intra.peff.net>
 <20160708103515.GA19705@sigill.intra.peff.net>
 <xmqqinwgm5aa.fsf@gitster.mtv.corp.google.com>
 <xmqqeg74m4zb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeg74m4zb.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 10:09:28AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As to the hunk to commit.c that was dropped in this round, the only
> > caller of print_commit_list() is bisect.c, and it passes "%s\n" to
> > format_cur and format_last, it seems, so that suggests a more
> > obvious direction for cleaning things up, I would say.
> 
> And the result is a pleasing diffstat.
> 
> -- >8 --
> Subject: commit.c: remove print_commit_list()

Yeah, I agree this is a nice diffstat.

As for the "walker" thing, I also agree that we don't really care much
about it these days.

I really wish we could just kill it off; it would simplify the http code
significantly (e.g., the entire reason we have the whole async
multi-fetch setup is to support it). But every time I think that,
somebody mentions on the list that they are still using it. :-/

I do suspect we could kill off the http push-over-dav, though. It's less
likely to be useful than the fetch code.

-Peff

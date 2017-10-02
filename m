Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B66202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdJBFAI (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:00:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:56976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750737AbdJBFAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:00:07 -0400
Received: (qmail 5289 invoked by uid 109); 2 Oct 2017 05:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24968 invoked by uid 111); 2 Oct 2017 05:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:00:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:00:05 -0400
Date:   Mon, 2 Oct 2017 01:00:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pretty.c: delimit "%(trailers)" arguments with ","
Message-ID: <20171002050005.6hwzky3p3rmrdmgc@sigill.intra.peff.net>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
 <xmqqbmlqtnll.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmlqtnll.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 09:11:50AM +0900, Junio C Hamano wrote:

> > diff --git a/pretty.c b/pretty.c
> > index 94eab5c89..eec128bc1 100644
> > --- a/pretty.c
> > +++ b/pretty.c
> > @@ -1056,6 +1056,25 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
> >  	return 0;
> >  }
> >  
> > +static int match_placeholder_arg(const char *to_parse,
> > +				const char *candidate,
> > +				const char **end)
> 
> "make style" wants to format this like so:
> 
> static int match_placeholder_arg(const char *to_parse, const char *candidate,
> 				 const char **end)
> 
> I think I can live with either versions ;-)

I can live with either, too, though I do prefer the 3-line form (which
is unsurprising since it comes from what I wrote in an earlier thread).
I don't think it conveys a huge amount of meaning here, but there are
definitely times when I would tweak the wrapping of long argument lists
to convey meaning. E.g.:

  void some_function(struct foo *foo,
                     const char *buf, size_t len,
		     unsigned flags);

rather than

  void some_function(struct foo *foo, const char *buf,
                     size_t len, unsigned flags);

It's a little sad to be beholden to a tool that would mindlessly drop
that grouping. But at the same time, that tool may be the lesser evil if
it saves time adjusting (and reviewing) style. I'll continue to observe
before forming more inclusions. Thanks for reporting on your "make
style" experiments.

-Peff

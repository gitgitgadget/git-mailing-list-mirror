Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5AD201A7
	for <e@80x24.org>; Sat, 13 May 2017 02:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758224AbdEMCEN (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 22:04:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50613 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbdEMCEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 22:04:12 -0400
Received: (qmail 1584 invoked by uid 109); 13 May 2017 02:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 02:04:12 +0000
Received: (qmail 28798 invoked by uid 111); 13 May 2017 02:04:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 22:04:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 22:04:10 -0400
Date:   Fri, 12 May 2017 22:04:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config: complain about --local outside of a git repo
Message-ID: <20170513020409.kyqglojregge44mt@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
 <20170513000442.GH27400@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170513000442.GH27400@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 05:04:42PM -0700, Jonathan Nieder wrote:

> > diff --git a/builtin/config.c b/builtin/config.c
> > index 3a554ad50..ad7c6a19c 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -496,6 +496,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  		usage_with_options(builtin_config_usage, builtin_config_options);
> >  	}
> > 
> > +	if (use_local_config && nongit)
> > +		die(_("--local only be used inside a git repository"));
> > +
> 
> The output would be
> 
> 	fatal: --local only be used inside a git repository
> 
> Is that missing a "should" before "only"?

Urgh, I meant "can" (I had originally written "only makes sense" but
changed it at the list minute).

I'll re-roll after thinking about the test issues raised in the other
part of the thread.

-Peff

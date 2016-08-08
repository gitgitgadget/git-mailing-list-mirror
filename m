Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064CA1FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 05:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbcHHFGR (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 01:06:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:50988 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750795AbcHHFGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 01:06:17 -0400
Received: (qmail 5948 invoked by uid 109); 8 Aug 2016 05:06:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 05:06:15 +0000
Received: (qmail 27068 invoked by uid 111); 8 Aug 2016 05:06:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 01:06:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 01:06:14 -0400
Date:	Mon, 8 Aug 2016 01:06:14 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160808050614.pirm3qnizrbzbsh4@sigill.intra.peff.net>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
 <20160808044206.ubvaftex3mwbmwdh@x>
 <20160808045441.duy7ztgdrz7wpvzj@sigill.intra.peff.net>
 <20160808050217.u2pmbu7b7yww4viv@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160808050217.u2pmbu7b7yww4viv@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 07, 2016 at 07:02:18PM -1000, Josh Triplett wrote:

> > Portability; some compilers choke on it. C89 allows trailing commas in
> > array initialization but _not_ in enums. Most compilers allow it anyway
> > (though gcc complains with -Wpedantic).
> > 
> > This definitely broke the build on real systems early in Git's history
> > (I think the AIX compiler was one culprit),
> 
> Thanks for the explanation.  I assume such compilers also don't accept
> C99?

Correct. We don't allow other C99 features like variadic macros, either
(there are some in the code base, but you'll note they can all be
conditionally disabled).

> Perhaps the next Git user survey could ask "what compiler (including
> version) do you use to compile Git", and perhaps "does it accept the
> following code:"?

Maybe. I'm not sure I would consider a lack of responses there to be a
definite sign. It seems that once every few years people on bizarre
systems come out of the woodwork and do a round of portability fixes,
and then problems accrue, and so on. So I'm not sure that the survey
would hit the right people in a timely manner.

I think the breaking point will be just declaring "look, C99 is N years
old; if your compiler can't handle it, that's now your problem". When
Git started, N was only 6. It's now 17.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65571FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 04:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbcHHE7y (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 00:59:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50980 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750766AbcHHE7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 00:59:54 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Aug 2016 00:59:54 EDT
Received: (qmail 4950 invoked by uid 109); 8 Aug 2016 04:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 04:54:43 +0000
Received: (qmail 26893 invoked by uid 111); 8 Aug 2016 04:54:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 00:54:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 00:54:41 -0400
Date:	Mon, 8 Aug 2016 00:54:41 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160808045441.duy7ztgdrz7wpvzj@sigill.intra.peff.net>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
 <20160808044206.ubvaftex3mwbmwdh@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160808044206.ubvaftex3mwbmwdh@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 07, 2016 at 06:42:07PM -1000, Josh Triplett wrote:

> > Drop trailing comma after the last enum definition (trailing comma
> > after the last element in an array is OK, though).
> 
> I realize this code didn't get included in the final version, but for
> future reference, what's the rationale for this?  I tend to include a
> final comma in cases like these (and likewise for initializers) to avoid
> needing to change the last line when introducing a new element, reducing
> noise in diffs.  I hadn't seen anything in any of the coding style
> documentation talking about trailing commas (either pro or con).

Portability; some compilers choke on it. C89 allows trailing commas in
array initialization but _not_ in enums. Most compilers allow it anyway
(though gcc complains with -Wpedantic).

This definitely broke the build on real systems early in Git's history
(I think the AIX compiler was one culprit), but at this point it's
possible that all of those compilers have died off. It would be nice if
we could start using it (for exactly the reasons you give).
Unfortunately there's not a good way to know except "introduce it and
see if people complain".

-Peff

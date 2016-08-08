Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907331FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 05:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbcHHFC0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 01:02:26 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42450 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcHHFC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 01:02:26 -0400
Received: from mfilter13-d.gandi.net (mfilter13-d.gandi.net [217.70.178.141])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 3A6EFA80C2;
	Mon,  8 Aug 2016 07:02:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter13-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter13-d.gandi.net (mfilter13-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hhlp4EHO-I6v; Mon,  8 Aug 2016 07:02:22 +0200 (CEST)
X-Originating-IP: 98.150.198.107
Received: from x (cpe-98-150-198-107.hawaii.res.rr.com [98.150.198.107])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 24357A80C4;
	Mon,  8 Aug 2016 07:02:20 +0200 (CEST)
Date:	Sun, 7 Aug 2016 19:02:18 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160808050217.u2pmbu7b7yww4viv@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
 <20160808044206.ubvaftex3mwbmwdh@x>
 <20160808045441.duy7ztgdrz7wpvzj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808045441.duy7ztgdrz7wpvzj@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 12:54:41AM -0400, Jeff King wrote:
> On Sun, Aug 07, 2016 at 06:42:07PM -1000, Josh Triplett wrote:
> 
> > > Drop trailing comma after the last enum definition (trailing comma
> > > after the last element in an array is OK, though).
> > 
> > I realize this code didn't get included in the final version, but for
> > future reference, what's the rationale for this?  I tend to include a
> > final comma in cases like these (and likewise for initializers) to avoid
> > needing to change the last line when introducing a new element, reducing
> > noise in diffs.  I hadn't seen anything in any of the coding style
> > documentation talking about trailing commas (either pro or con).
> 
> Portability; some compilers choke on it. C89 allows trailing commas in
> array initialization but _not_ in enums. Most compilers allow it anyway
> (though gcc complains with -Wpedantic).
> 
> This definitely broke the build on real systems early in Git's history
> (I think the AIX compiler was one culprit),

Thanks for the explanation.  I assume such compilers also don't accept
C99?

> but at this point it's
> possible that all of those compilers have died off. It would be nice if
> we could start using it (for exactly the reasons you give).
> Unfortunately there's not a good way to know except "introduce it and
> see if people complain".

Fair enough.  I'll let someone else be the test case for that. :)

Perhaps the next Git user survey could ask "what compiler (including
version) do you use to compile Git", and perhaps "does it accept the
following code:"?

- Josh Triplett

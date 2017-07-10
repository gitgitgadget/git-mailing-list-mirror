Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FA1202AC
	for <e@80x24.org>; Mon, 10 Jul 2017 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdGJHcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 03:32:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:35216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751130AbdGJHcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 03:32:31 -0400
Received: (qmail 4314 invoked by uid 109); 10 Jul 2017 07:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 07:32:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3694 invoked by uid 111); 10 Jul 2017 07:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 03:32:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 03:32:29 -0400
Date:   Mon, 10 Jul 2017 03:32:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     astian <astian@eclipso.at>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Doc/config.txt: explain repeated sections
Message-ID: <20170710073229.mwf7zufx3xmszkde@sigill.intra.peff.net>
References: <20170708203413.16442-1-astian@eclipso.at>
 <20170708203413.16442-2-astian@eclipso.at>
 <xmqqfue6a5va.fsf@gitster.mtv.corp.google.com>
 <xmqq7ezi9h64.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ezi9h64.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 09, 2017 at 12:57:07AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +Multiple occurrences of the same section are all logically merged.  (There's
> >> +no special treatment for variables defined multiple times across physically
> >> +different sections, the variable is simply made multivalued.)
> >> +
> >
> > Looks correct; it's a bit surprising that we didn't already mention
> > multiple occurrences, but I do not find it so this is a good
> > addition. 
> >
> > I do not see a strong reason for () around the second sentence,
> > though.
> 
> After re-reading this, I am wondering if the "made multivalued"
> above need to be made less confusing.  For a variable that is single
> valued, the usual "the last one wins" rule is applied---it's not
> like
> 
>     [user] 
> 	name = astian
> 	name = gitster
> 
> makes user.name "gitster" while
> 
>     [user] 
> 	name = astian
>     [user]
> 	name = gitster
> 
> makes user.name "multivalued".  In either case, the last one wins,
> and it comes not from the syntax but from the semantics assigned to
> the variable in question.  What we want to say is not "multi-valued",
> but the above two forms both mean the same thing.
> 
> But perhaps I am needlessly worried about possible confusion too
> much.  I dunno.

FWIW, the use of "multivalued" here tickled my spider sense, too. I
think when talking on the list we generally reserve "multivalued" for
true "we expect this to be a list" variables. But the only mention of
"multivalued" in the config documentation seems to be:

  Some variables may appear multiple times; we say then that the
  variable is multivalued.

I think the proposed use is consistent with that (and that line is only
2 paragraphs above the proposed paragraph).

-Peff

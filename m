Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2084AC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E735B20716
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgFVVcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:32:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgFVVcm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:32:42 -0400
Received: (qmail 1810 invoked by uid 109); 22 Jun 2020 21:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8437 invoked by uid 111); 22 Jun 2020 21:32:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:32:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:32:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
Message-ID: <20200622213241.GB1376217@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net>
 <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
 <20200619160129.GA1843858@coredump.intra.peff.net>
 <20200619161816.GA9205@flurp.local>
 <xmqqv9jmhng9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9jmhng9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 12:20:38PM -0700, Junio C Hamano wrote:

> >> <shrug> The names were long enough that I thought it was more clear not
> >> to repeat myself. [...]
> >
> > Indeed, it's a minor point and subjective. Certainly not worth a
> > re-roll or even worrying about it.
> 
> It probably is subjective but fwiw I too find yours easier to
> follow.

I ended up doing it this way, since I decided to quote the pathnames
(and thus they needed their own fprintf, at which point there was
really nothing left for the two to share).

> > Hmph, that shouldn't have failed. Did you quote the $(wc -l refs)
> > invocation? Quoting it would cause it to fail.
> 
> > +	git show-ref >refs &&
> > +	nrefs=$(wc -l <refs) &&
> 
> Yup, I've seen that workaround for macs too many times and it should
> work well.

I switched to this style in the re-roll (and ditto for the path output,
which actually turned up a bug).

-Peff

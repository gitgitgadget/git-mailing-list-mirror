Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC7A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeKLW6j (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:58:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:35470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727989AbeKLW6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:58:39 -0500
Received: (qmail 25385 invoked by uid 109); 12 Nov 2018 13:05:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 13:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10436 invoked by uid 111); 12 Nov 2018 13:04:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 08:04:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 08:05:25 -0500
Date:   Mon, 12 Nov 2018 08:05:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
Message-ID: <20181112130525.GK3956@sigill.intra.peff.net>
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
 <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
 <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 02:03:20PM +0900, Junio C Hamano wrote:

> > +		} else if (!strcmp(name, "objectsize")) {
> >  			v->value = oi->size;
> >  			v->s = xstrfmt("%lu", oi->size);
> 
> This is not a suggestion but is a genuine question, but I wonder if
> two years down the road somebody who meets this API for the first
> time find the asymmetry between "objectsize" and "objectsize:disk" a
> tad strange and suggest the former to have "objectsize:real" or some
> synonym.  Or we can consider "objectsize" the primary thing (hence
> needing no colon-plus-modifier to clarify what kind of size we are
> asking) and leave these two deliberatly asymmetric.  I am leaning
> towards the latter myself.

I think to some degree that ship has already sailed (and is my fault!).

The ulterior motive here is to eventually unify the cat-file formatter
with the ref-filter formatter.  So for that we'll have to support
%(objectsize) anyway.

That still leaves the option of having %(objectsize:real) later and
marking a bare %(objectsize) as a deprecated synonym. But I don't think
there's any advantage to trying to deal with it at this stage.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0411F97E
	for <e@80x24.org>; Fri, 17 Aug 2018 17:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeHQUsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 16:48:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727607AbeHQUsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 16:48:23 -0400
Received: (qmail 1477 invoked by uid 109); 17 Aug 2018 17:44:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 17:44:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26222 invoked by uid 111); 17 Aug 2018 17:44:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 13:44:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 13:44:05 -0400
Date:   Fri, 17 Aug 2018 13:44:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just
 FREE_AND_NULL(x)
Message-ID: <20180817174404.GB9474@sigill.intra.peff.net>
References: <1534498806.1262.8.camel@gentoo.org>
 <20180817130250.20354-1-avarab@gmail.com>
 <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
 <20180817151012.GA20262@duynguyen.home>
 <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com>
 <xmqqlg94c46f.fsf@gitster-ct.c.googlers.com>
 <20180817173308.GA9111@sigill.intra.peff.net>
 <20180817173951.GA9474@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817173951.GA9474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 01:39:51PM -0400, Jeff King wrote:

> > I wonder if there is a way to "relax" a pattern where these semantically
> > equivalent cases can all be covered automatically. I don't know enough
> > about the tool to say.
> 
> Hmm. They seem to call these "standard isomorphisms":
> 
>   http://coccinelle.lip6.fr/standard.iso.html
> 
> but I'm not sure of the correct way to use them (e.g., if we want to
> apply them for matching but not actually transform the code, though I am
> not actually opposed to transforming the code, too).

Hmph, I should really pause before hitting 'send'. Last message, I
promise. :)

I do not see an option to include a list an arbitrary set of
isomorphisms, but the standard.iso list should be used by default. I
wonder if you simply need to write your case in the normalized version
they use there (which I think is "X == NULL"), and the others would be
taken care of.

-Peff

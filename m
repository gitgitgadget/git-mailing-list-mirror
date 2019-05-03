Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2A51F453
	for <e@80x24.org>; Fri,  3 May 2019 03:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfECDPd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 23:15:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726121AbfECDPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 23:15:33 -0400
Received: (qmail 25178 invoked by uid 109); 3 May 2019 03:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 May 2019 03:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7355 invoked by uid 111); 3 May 2019 03:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 May 2019 23:16:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2019 23:15:31 -0400
Date:   Thu, 2 May 2019 23:15:31 -0400
From:   Jeff King <peff@peff.net>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Message-ID: <20190503031531.GA19436@sigill.intra.peff.net>
References: <87o94vs9cp.fsf@evledraar.gmail.com>
 <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
 <87mukfrnp3.fsf@evledraar.gmail.com>
 <20190425005448.GA6466@x230>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425005448.GA6466@x230>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 02:54:48AM +0200, Eugeniu Rosca wrote:

> > This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
> > general. See e.g. "git log -U1".
> 
> Oops. Since I use `-U<n>` mostly with `git show`, I missed the
> implication. You are right. Then, my question is how users are
> going to (quote from commit description):
> 
> > >> > [..] search [..] through an arbitrary amount of
> > >> > context lines when combined with -U<n>.
> 
> and achieve a `git log --oneline` report, given that -U<n> unfolds
> the commits?

You can use "-s" to suppress patch output; as long as it comes after -U
on the command-line, it will countermand the patch-format part.

(Of course it doesn't matter until we have a raw-diff grep, since
otherwise the context lines do not matter at all, and you should just
omit -U entirely).

-Peff

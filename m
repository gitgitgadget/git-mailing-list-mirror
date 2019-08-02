Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86AC11F731
	for <e@80x24.org>; Fri,  2 Aug 2019 23:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfHBXVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 19:21:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:32850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726225AbfHBXVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 19:21:31 -0400
Received: (qmail 12897 invoked by uid 109); 2 Aug 2019 23:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Aug 2019 23:21:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10991 invoked by uid 111); 2 Aug 2019 23:23:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Aug 2019 19:23:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Aug 2019 19:21:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?Q?=C3=89tienne?= SERVAIS <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
Message-ID: <20190802232129.GA811@sigill.intra.peff.net>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
 <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
 <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
 <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
 <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 02:20:31PM -0700, Junio C Hamano wrote:

> > This would require that higher level to parse the user format to check
> > if %d or %D is present before formatting the first item.  Hmm.
> 
> Yes.  Don't we pre-scan what kind of formatting primitives are used
> in the end-user supplied string already to optimize loading of notes
> and source information?

I think userformat_find_requirements() is what you're looking for.

I do think it might be tricky to find all of the callers who need to use
it, though. Some of them are not necessarily users of the traversal
machinery, but just have a one-off pretty_print_context.

-Peff

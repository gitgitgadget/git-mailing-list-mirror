Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0957206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbcLLT5I (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:57:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:55334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbcLLT5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:57:07 -0500
Received: (qmail 1969 invoked by uid 109); 12 Dec 2016 19:57:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 19:57:07 +0000
Received: (qmail 8897 invoked by uid 111); 12 Dec 2016 19:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 14:57:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 14:57:03 -0500
Date:   Mon, 12 Dec 2016 14:57:03 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
Message-ID: <20161212195703.nmljhwwmrn56gbyd@sigill.intra.peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
 <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
 <b8aa28b1-e645-4cea-cc91-96f62fee6118@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8aa28b1-e645-4cea-cc91-96f62fee6118@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 08:51:14PM +0100, René Scharfe wrote:

> It's kinda cool to have a bespoke compatibility layer for major platforms,
> but the more I think about it the less I can answer why we would want that.
> Safety, reliability and performance can't be good reasons -- if our fallback
> function lacks in these regards then we have to improve it in any case.

There may be cases that we don't want to support because of portability
issues. E.g., if your libc has an assembly-optimized qsort() we wouldn't
want to replicate that.

I dunno. I am not that opposed to just saying "forget libc qsort, we
always use our internal one which is consistent, performant, and safe".
But when I suggested something similar for our regex library, I seem to
recall there were complaints.

-Peff

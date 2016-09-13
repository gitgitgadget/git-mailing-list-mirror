Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592FD20984
	for <e@80x24.org>; Tue, 13 Sep 2016 18:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758646AbcIMSNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 14:13:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:42721 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755335AbcIMSNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 14:13:31 -0400
Received: (qmail 5368 invoked by uid 109); 13 Sep 2016 18:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 18:13:30 +0000
Received: (qmail 24598 invoked by uid 111); 13 Sep 2016 18:13:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 14:13:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 11:13:26 -0700
Date:   Tue, 13 Sep 2016 11:13:26 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: use llist_mergesort() for sorting packs
Message-ID: <20160913181325.32sdyyaf5dholjy2@sigill.intra.peff.net>
References: <a313343b-173e-4a07-f383-859a6f262651@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a313343b-173e-4a07-f383-859a6f262651@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 07:54:42PM +0200, René Scharfe wrote:

> Sort the linked list of packs directly using llist_mergesort() instead
> of building an array, calling qsort(3) and fixing up the list pointers.
> This is shorter and less complicated.

Makes sense.

> Peff: Or do you have other plans, e.g. to replace packed_git with
> packed_git_mru completely?

Nope. I haven't looked into it, but I think there would be some benefit
to replacing packed_git_mru with the code in list.h. But I don't see any
benefit in replacing packed_git with that, or with the MRU itself (once
list.h is in use, one _could_ shove the MRU into packed_git itself, but
I think we would still retain the original link order for reference).

Thanks for asking.

-Peff

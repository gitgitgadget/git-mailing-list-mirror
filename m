Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DC81F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdFLSVp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:21:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38382 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752773AbdFLSVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:21:45 -0400
Received: (qmail 21292 invoked by uid 109); 12 Jun 2017 18:21:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 18:21:44 +0000
Received: (qmail 14913 invoked by uid 111); 12 Jun 2017 18:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 14:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 14:21:42 -0400
Date:   Mon, 12 Jun 2017 14:21:42 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] lock_packed_refs(): fix cache validity check
Message-ID: <20170612182142.6giu6ovjwx2fjkzp@sigill.intra.peff.net>
References: <cover.1497253685.git.mhagger@alum.mit.edu>
 <18f059555ce0e4f46fba783973947f6a26ac4b65.1497253685.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18f059555ce0e4f46fba783973947f6a26ac4b65.1497253685.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 10:06:13AM +0200, Michael Haggerty wrote:

> So instead:
> 
> * Extract a function `validate_packed_ref_cache()` that does the
>   validity check independent of whether the lock is held.
> 
> * Change `get_packed_ref_cache()` to call the new function, but only
>   if the lock *isn't* held.
> 
> * Change `lock_packed_refs()` to call the new function in any case
>   before calling `get_packed_ref_cache()`.
> 
> * Fix the comment in `lock_packed_refs()`.

Your explanation makes perfect sense, and I agree this should fix the
problem. Sorry to have missed it in review.

-Peff

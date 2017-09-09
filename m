Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5C1202A4
	for <e@80x24.org>; Sat,  9 Sep 2017 11:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757427AbdIILSs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 07:18:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753471AbdIILSr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 07:18:47 -0400
Received: (qmail 32490 invoked by uid 109); 9 Sep 2017 11:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 11:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14278 invoked by uid 111); 9 Sep 2017 11:19:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 07:19:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Sep 2017 07:18:45 -0400
Date:   Sat, 9 Sep 2017 07:18:45 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Implement transactions for the packed ref store
Message-ID: <20170909111845.fzgbgzzgcjwcbilw@sigill.intra.peff.net>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 03:51:42PM +0200, Michael Haggerty wrote:

> This is v2 of a patch series to implement reference transactions for
> the packed refs-store. Thanks to Stefan, Brandon, Junio, and Peff for
> your review of v1 [1]. I believe I have addressed all of your
> comments.
> 
> Changes since v1:
> 
> * Patch [01/11]: justify the change better in the log message. Add a
>   comment explaining why `get_packed_ref_cache()` is being called but
>   the return value discarded.
> 
> * Patch [05/11]: Lock the `packed-refs` file *after* successfully
>   creating the (empty) transaction object. This prevents leaving the
>   file locked if `ref_store_transaction_begin()` fails.
> 
> * Patch [06/11]: New patch, fixing a leak of the `refs_to_prune`
>   linked list.

These all look good to me, including the new patch.

> * Patch [07/11]: Reimplement test "no bogus intermediate values during
>   delete" to work without polling. Also incorporate Junio's change
>   `s/grep/test_i18ngrep/`.

I picked a few nits in the test script. Nothing too serious, but a few
things that might be worth addressing.

-Peff

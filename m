Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2FB820248
	for <e@80x24.org>; Tue, 26 Mar 2019 05:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfCZFwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 01:52:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725535AbfCZFwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 01:52:21 -0400
Received: (qmail 8838 invoked by uid 109); 26 Mar 2019 05:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 05:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15119 invoked by uid 111); 26 Mar 2019 05:52:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 01:52:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 01:52:19 -0400
Date:   Tue, 26 Mar 2019 01:52:19 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/5] Progress display fixes
Message-ID: <20190326055218.GE1933@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 11:38:39AM +0100, SZEDER Gábor wrote:

> This patch series fixes two progress display issues:
> 
>   - When showing throughput, and the both the total and the throughput
>     change units in the same update, than the previously shown
>     progress bar is not cleaned up properly:
> 
>       Receiving objects:  25% (2901/11603), 772.01 KiB | 733.00 KiB/s
>       Receiving objects:  27% (3133/11603), 1.43 MiB | 1.16 MiB/s   s
> 
>   - When the progress bar is longer than the width of the terminal,
>     then we end up with a bunch of truncated progress bar lines
>     scrolling past:
> 
>       $ LANG=es_ES.UTF-8 git commit-graph write
>       Encontrando commits para commit graph entre los objetos empaquetados:   2% (1599
>       Encontrando commits para commit graph entre los objetos empaquetados:   3% (1975
>       Encontrando commits para commit graph entre los objetos empaquetados:   4% (2633
>       Encontrando commits para commit graph entre los objetos empaquetados:   5% (3292
>       [...]
> 
> Patches 4 and 5 fix these two issues, while the first three are
> minor preparatory cleanups and refactorings.

With the exception of the points raised in the thread, these look good
to me. Seeing your later patches, I think it would not be too bad to
just stick the is_foreground_fd() check inside the "if (update)" block
you introduce later.

-Peff

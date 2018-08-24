Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07CAE1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 00:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeHXDsu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 23:48:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:54116 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726156AbeHXDsu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 23:48:50 -0400
Received: (qmail 32119 invoked by uid 109); 24 Aug 2018 00:16:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 00:16:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22407 invoked by uid 111); 24 Aug 2018 00:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 20:16:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 20:16:44 -0400
Date:   Thu, 23 Aug 2018 20:16:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, paul@mad-scientist.net,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180824001643.GA14259@sigill.intra.peff.net>
References: <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
 <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net>
 <20180824000637.GA10847@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824000637.GA10847@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 08:06:37PM -0400, Jeff King wrote:

> This almost works:
> 
>   @@
>   expression a, b;
>   statement s;
>   @@
>   - if (oidcmp(a, b)) s
>   + if (!oideq(a, b)) s
>
> [...]

> So I really do want some way of saying "all of the block, no matter what
> it is". Or of leaving it out as context.

Aha. The magic invocation is:

  @@
  expression a, b;
  statement s;
  @@
  - if (oidcmp(a, b))
  + if (!oideq(a, b))
      s

I would have expected that you could replace "s" with "...", but that
does not seem to work.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B2F1F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 19:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfH3Ts4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:48:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56682 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:48:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 086501F461;
        Fri, 30 Aug 2019 19:48:56 +0000 (UTC)
Date:   Fri, 30 Aug 2019 19:48:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/11] hashmap_entry_init takes "struct hashmap_entry *"
Message-ID: <20190830194855.45jwupvp5uqcg46y@dcvr>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-4-e@80x24.org>
 <557b6f18-c346-f3c8-b623-d97752586670@gmail.com>
 <nycvar.QRO.7.76.6.1908281655190.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908281655190.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Stolee,
> 
> On Tue, 27 Aug 2019, Derrick Stolee wrote:
> 
> > On 8/25/2019 10:43 PM, Eric Wong wrote:
> > > C compilers do type checking to make life easier for us.  So
> > > rely on that and update all hashmap_entry_init callers to take
> > > "struct hashmap_entry *" to avoid future bugs while improving
> > > safety and readability.
> >
> > Overall I like this change. I'll need to keep it in mind with my
> > sparse-checkout work that is adding more hashmap types.
> >
> > One _might_ think that this change is relaxing the condition on
> > where the hashmap_entry appears within the super-struct, but
> > the hashmap internals will still use void* and perform a cast
> > to hashmap_entry for hash comparisons.
> 
> I thought precisely the same.

Yes, that's the goal I'm working towards as mentioned in patches
10 and 11 :)

> Maybe we can get a Coccinelle rule that verifies that `struct
> hashmap_entryh` fields are always the first ones?

At this point, why?  Given the goal is to remove that requirement
entirely.

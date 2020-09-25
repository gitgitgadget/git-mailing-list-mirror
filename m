Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FFC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C6420838
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgIYUg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:36:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgIYUgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:36:19 -0400
Received: (qmail 15935 invoked by uid 109); 25 Sep 2020 19:05:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 19:05:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22899 invoked by uid 111); 25 Sep 2020 19:05:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 15:05:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 15:05:01 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
Message-ID: <20200925190501.GA668512@coredump.intra.peff.net>
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
 <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
 <20200924211725.GA3103003@coredump.intra.peff.net>
 <c759b472-c889-ef85-bcf2-6d9cbc588b51@rtzoeller.com>
 <1c03faa0-011c-39c2-acb6-d09a5fcfc818@gmail.com>
 <20200925184319.GA660343@coredump.intra.peff.net>
 <005de229-ad05-437c-7b83-8f6502b4e27d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <005de229-ad05-437c-7b83-8f6502b4e27d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 08:01:07PM +0100, Phillip Wood wrote:

> > Another possible corner case: tabs vs spaces. If I have:
> > 
> >    <space><space><space><space><space><space><space><space>foo
> >    <tab><tab>bar
> > 
> > which is more indented? Counting isspace(), it is the first one. But
> > visually, it would _usually_ be the second one. But of course it would
> > depend on your tabstops.
> > 
> > The above example is obviously stupid and contrived, but I wonder if
> > there are legitimate confusing cases where people mix tabs and spaces
> > (e.g., mixed tabs and spaces to align function parameters, etc).
> 
> To calculate the indentation for diff
> --color-moved-ws=allow-indentation-change in fill_es_indent_data() we use
> the tabwidth whitespace attribute to calculate the width of a tab in spaces
> [...]

Ah, right, I forgot we already had "tabwidth" config to deal with this.
I agree we could make use of that same technique here.

-Peff

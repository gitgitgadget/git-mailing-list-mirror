Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667391F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGLRGd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726925AbeGLRGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:06:33 -0400
Received: (qmail 3557 invoked by uid 109); 12 Jul 2018 16:56:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 16:56:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24171 invoked by uid 111); 12 Jul 2018 16:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 12:56:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 12:56:08 -0400
Date:   Thu, 12 Jul 2018 12:56:08 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180712165608.GA10515@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com>
 <CAPig+cS+fFZNZMxc0ARu=cZ2RVjHSP0iiLTsAJ_L7iOarwftgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS+fFZNZMxc0ARu=cZ2RVjHSP0iiLTsAJ_L7iOarwftgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 06:50:20AM -0400, Eric Sunshine wrote:

> And, perhaps most important: We're not tied indefinitely to the
> "subset" implemented by the current linter. If it is indeed found to
> be too strict or limiting, it can always be loosened or retired
> altogether.

Yeah, I agree this is the key point.

Like Junio, I'm a little nervous that this is going to end up being a
maintenance burden. People may hit false positives and then be
confronted with this horrible mass of sed to try to figure out what went
wrong (which isn't to bust on your sed in particular; I think you made a
heroic effort in commenting).

But I came around to thinking:

  - this found and fixed real problems in the test suite, with minimal
    false positives across the existing code

  - it's being done by a long-time contributor, not somebody who is
    going to dump sed on us and leave

  - worst case is that relief is only a "git revert" away

So I'm OK with merging it, and even running it by default.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5F21F576
	for <e@80x24.org>; Sat,  3 Mar 2018 07:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeCCHNC (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 02:13:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:45454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750892AbeCCHNB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 02:13:01 -0500
Received: (qmail 13652 invoked by uid 109); 3 Mar 2018 07:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 07:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3943 invoked by uid 111); 3 Mar 2018 07:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 02:13:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 02:12:59 -0500
Date:   Sat, 3 Mar 2018 02:12:59 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Make the test suite pass with '-x' and /bin/sh
Message-ID: <20180303071259.GB17312@sigill.intra.peff.net>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 12:39:40AM +0100, SZEDER Gábor wrote:

> The first patch is the most important: with a couple of well-placed file
> descriptor redirections it ensures that the stderr of the test helper
> functions running git commands only contain the stderr of the tested
> command, thereby resolving over 90% of the failures resulting from
> running the test suite with '-x' and /bin/sh.

I dunno. It seems like this requires a lot of caveats for people using
subshells and shell functions, and I suspect it's going to be an
on-going maintenance burden.

That said, I'm not opposed if you want to do the work to try to get the
whole test-suite clean, and we can see how it goes from there. It
shouldn't be hurting anything, I don't think, aside from some
mysterious-looking redirects (but your commit messages seem to explain
it, so anybody can dig).

Does it make descriptor 7 magical, and something that scripts should
avoid touching? That would mean we have 2 magical descriptors now.

-Peff

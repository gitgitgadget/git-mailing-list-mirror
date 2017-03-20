Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C956320323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdCTEaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:30:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdCTEaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:30:03 -0400
Received: (qmail 25520 invoked by uid 109); 20 Mar 2017 04:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:29:13 +0000
Received: (qmail 29434 invoked by uid 111); 20 Mar 2017 04:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:29:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:29:08 -0400
Date:   Mon, 20 Mar 2017 00:29:08 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] tests: create an interactive gdb session with the
 'debug' helper
Message-ID: <20170320042908.2vwrqnqu2qvlywaf@sigill.intra.peff.net>
References: <20170317144646.9349-1-szeder.dev@gmail.com>
 <20170317145504.utysxd4qqaqetm7t@sigill.intra.peff.net>
 <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 05:10:18PM +0100, SZEDER Gábor wrote:

> > but perhaps this should add:
> >
> >   >&3 2>&4
> >
> > to be on the safe side. That covers running without "-v", as well as
> > cases where the test script is redirecting output
> 
> That wouldn't buy us much.  First, file descriptors 3 and 4 are the
> test's stdout and stderr, i.e. any process started within the test
> would be connected to those fds anyway without those explicit
> redirections.  Second, fds 3 and 4 are redirected to /dev/null in
> non-verbose mode, so it would still not work without '-v'.
> 
> Perhaps you meant '>&5 2>&7' here (and in the bash example in the
> commit message of 781f76b15 (test-lib: redirect stdin of tests,
> 2011-12-15), for that matter)?  Those redirections do in fact make
> 'debug' work even without '-v'.  Furthermore, those redirections do
> make 'test_pause' work without '-v', too.

Yeah, sorry, I got my descriptors mixed up. ">&5 2>&1" is the right
invocation (unless you add a new "7" to save the original stderr).

-Peff

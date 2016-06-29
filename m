Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397322018A
	for <e@80x24.org>; Wed, 29 Jun 2016 01:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbcF2Bnt (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 21:43:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:37382 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752455AbcF2Bnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 21:43:49 -0400
Received: (qmail 15635 invoked by uid 102); 29 Jun 2016 01:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 21:43:48 -0400
Received: (qmail 17644 invoked by uid 107); 29 Jun 2016 01:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 21:44:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2016 21:43:43 -0400
Date:	Tue, 28 Jun 2016 21:43:43 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
Message-ID: <20160629014342.GA28661@sigill.intra.peff.net>
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 04:36:25PM -0700, Junio C Hamano wrote:

> * jk/test-match-signal (2016-06-24) 4 commits
>  - t/lib-git-daemon: use test_match_signal
>  - test_must_fail: use test_match_signal
>  - t0005: use test_match_signal as appropriate
>  - tests: factor portable signal check out of t0005
> 
>  The test framework learned a new helper test_match_signal to check
>  an exit code from getting killed by an expected signal.
> 
>  Will merge to 'next'.

Johannes pointed out that matching "3" for Windows is overly broad (it
only happens due to raise(), not regular signal death).

What do we want to do there?

I _think_ matching "3" just makes us slightly less careful, and will not
cause false positives (it may cause false negatives in very specific
cases, though). So one option is to proceed as-is.

Another is to just put the posix/ksh schemes into the helper function,
and let Windows people sort it out later if they want to.

-Peff

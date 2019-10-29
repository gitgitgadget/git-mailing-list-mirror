Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913111F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfJ2OeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:34:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:32984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388871AbfJ2OeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:34:21 -0400
Received: (qmail 31945 invoked by uid 109); 29 Oct 2019 14:34:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 14:34:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10183 invoked by uid 111); 29 Oct 2019 14:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 10:37:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 10:34:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Luke Dashjr <luke@dashjr.org>, git@vger.kernel.org
Subject: Re: GIT_COMMITTER_* and reflog
Message-ID: <20191029143420.GB3683@sigill.intra.peff.net>
References: <201910252149.23787.luke@dashjr.org>
 <20191026022039.GE39574@google.com>
 <xmqqv9scark1.fsf@gitster-ct.c.googlers.com>
 <20191026173702.GA5522@sigill.intra.peff.net>
 <xmqqr22ybcs7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr22ybcs7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 27, 2019 at 09:20:24PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If somebody wants to pursue a patch, I suspect the solution is probably
> > something like this (totally untested):
> 
> Looks sensible.  It is very much unsatisfying that datestamp(),
> which is used by fmt_ident() when no date string is given, seems to
> totally bypass date.c::get_time(), which means the framework to give
> fake timestamp via GIT_TEST_DATE_NOW cannot be used to write
> reproducible tests.
> 
> Given that datestamp() is only used by the push certificate and
> fast-import codepaths and nowhere else, I suspect that "fixing" it
> retroactively to honor GIT_TEST_DATE_NOW would not have any negative
> fallout, but that's not something I should be contemplating on
> during the -rc period ;-)

Yeah, I agree datestamp() should respect $GIT_TEST_DATE_NOW. This whole
topic is not something for the -rc period, I would think.

-Peff

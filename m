Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62784C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F46261107
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhGSKMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:12:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:53490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236487AbhGSKMw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 06:12:52 -0400
Received: (qmail 30968 invoked by uid 109); 19 Jul 2021 10:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 10:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12192 invoked by uid 111); 19 Jul 2021 10:53:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 06:53:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 06:53:30 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] perf: fix when running with TEST_OUTPUT_DIRECTORY
Message-ID: <YPVZqn0Lm6m6GC2Z@coredump.intra.peff.net>
References: <005cc9a695f7f9b17190293821369763e9bae662.1623834515.git.ps@pks.im>
 <cb9d948646e8181e9c9c8dc35b37d48c692a92fb.1624024532.git.ps@pks.im>
 <YPU2+bG8Nge5FKWv@coredump.intra.peff.net>
 <YPVZZl1FI0D8kK6C@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPVZZl1FI0D8kK6C@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 12:52:22PM +0200, Patrick Steinhardt wrote:

> On Mon, Jul 19, 2021 at 04:25:29AM -0400, Jeff King wrote:
> > On Fri, Jun 18, 2021 at 03:56:08PM +0200, Patrick Steinhardt wrote:
> [snip]
> > > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > > index 601d9f67dd..f5ed092ee5 100644
> > > --- a/t/perf/perf-lib.sh
> > > +++ b/t/perf/perf-lib.sh
> > > @@ -45,7 +45,7 @@ export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
> > >  MODERN_GIT=$GIT_BUILD_DIR/bin-wrappers/git
> > >  export MODERN_GIT
> > >  
> > > -perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
> > > +perf_results_dir=$TEST_RESULTS_DIR
> > 
> > This line puzzled me a bit. Isn't $TEST_RESULTS_DIR already defined to
> > be $TEST_OUTPUT_DIRECTORY/test-results? If the change here is just for
> > clarity / readability that's OK by me. I just want to make sure I'm not
> > missing something.
> 
> Yes it is, and IIRC the change was just for clarity as you assume. The
> logic to derive the results directory was essentially duplicated across
> perf-lib.sh and test-lib.sh without much of a reason, given that we
> always set TEST_RESULTS_DIR in test-lib.sh.

OK, thanks. Then your patch looks great to me. :)

-Peff

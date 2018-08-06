Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A859B208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbeHFSwE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:52:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:44114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732571AbeHFSwE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:52:04 -0400
Received: (qmail 15594 invoked by uid 109); 6 Aug 2018 16:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 16:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27710 invoked by uid 111); 6 Aug 2018 16:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 12:42:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 12:42:08 -0400
Date:   Mon, 6 Aug 2018 12:42:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806164208.GB19053@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180805204930.GA202464@genre.crustytoothpaste.net>
 <20180806133954.GA31282@sigill.intra.peff.net>
 <20180806150100.GC97564@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180806150100.GC97564@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 08:01:00AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   3. Default to number of CPUs, which is what a lot of other threading
> >      in Git does. Unfortunately getting that from the shell is
> >      non-trivial. I'm OK with $(grep -c ^processor /proc/cpuinfo), but
> >      people on non-Linux platforms would have to fill in their own
> >      implementation.
> 
> How about $(getconf _NPROCESSORS_ONLN)?  That's what Linux's
> scripts/coccicheck uses (apropos of a recent discussion :)).

Thanks, that's certainly less gross than grepping /proc/cpuinfo. getconf
is POSIX, but _NPROCESSORS_ONLN is not. According to [1], it works on
Linux and macOS, which is probably a reasonable start, though. This is,
after all, a script aimed at developers, and the worst case is that we
default back to 1.

-Peff

[1] https://stackoverflow.com/questions/42862559/one-liner-for-n-1-cores/42863212#42863212

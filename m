Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD781F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeDFVeB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:34:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:56534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751528AbeDFVeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:34:00 -0400
Received: (qmail 29536 invoked by uid 109); 6 Apr 2018 21:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30079 invoked by uid 111); 6 Apr 2018 21:35:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:35:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:33:58 -0400
Date:   Fri, 6 Apr 2018 17:33:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/15] Assorted fixes for `git config` (including the
 "empty sections" bug)
Message-ID: <20180406213358.GD7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <cover.1522772789.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 06:27:55PM +0200, Johannes Schindelin wrote:

> I am very, very grateful for the time Peff spent on reviewing the previous
> iteration, and hope that he realizes just how much the elegance of the
> event-stream-based version is due to his excellent review.

Unfortunately I ran out of time this week to give this version an
equally careful review, and I'm about to go on vacation for a few weeks.

I did give a cursory look over it, and the new maybe_remove_section() is
much more pleasant. So aside from a few minor nits I pointed out, this
generally looks good.

One thing I'd like to have seen is a few more tests covering exotic
cases that I turned up in my earlier review. Some of the weird multiline
cases I care less about, but we should probably cover at least:

  1. Comment behavior when removing a section that isn't at the
     beginning of the file.

  2. Removing the final key from a section with a subsection.

Those should both be natural fallouts of the new method, but it would be
good to have test coverage.

Thanks for reworking this, and if it's still not merged when I get back,
I promise to review it more carefully then. :)

-Peff

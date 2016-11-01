Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C97F20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbcKAUgl (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:36:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:37174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbcKAUgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:36:40 -0400
Received: (qmail 23297 invoked by uid 109); 1 Nov 2016 20:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 20:36:40 +0000
Received: (qmail 29641 invoked by uid 111); 1 Nov 2016 20:37:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 16:37:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 16:36:37 -0400
Date:   Tue, 1 Nov 2016 16:36:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
Message-ID: <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 02:49:42PM -0700, Junio C Hamano wrote:

>  * Output from "git diff" can be made easier to read by selecting
>    which lines are common and which lines are added/deleted
>    intelligently when the lines before and after the changed section
>    are the same.  A command line option is added to help with the
>    experiment to find a good heuristics.

I'm not sure we ever resolved all the discussion around options and
defaults here.

As of -rc0, we have both --indent-heuristic and --compaction-heuristic
(along with matching config), and they are mutually exclusive.

In [1], Stefan suggested just replacing the compaction heuristic
entirely with the new one (and you seemed to agree). If we're going to
do that, it makes sense to do so before the release, so that we don't
get stuck supporting --indent-heuristic forever.

We also discussed making this the default (e.g., in [2]). Did we want to
do that before the release? If so, it would have been nice to flip it on
during -rc0 to get more exposure, but perhaps -rc1 would not be too
late. That's less critical than resolving the indent/compaction thing,
though it potentially means we could rip out the config entirely and
just leave the command-line option (as an escape hatch and debugging
tool).

-Peff

[1] http://public-inbox.org/git/CAGZ79kaMSkRfkBng_Epq+2T_q--VkKQ6-m=M_jPkzeYcxuDKWA@mail.gmail.com/

[2] http://public-inbox.org/git/CA+P7+xrsz27Hhk12dwDrUEpn0L7R8F5z-XASS2JkoY6sqK7u5A@mail.gmail.com/

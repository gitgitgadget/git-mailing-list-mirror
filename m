Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC22A1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965220AbeBMR0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:26:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:50892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965137AbeBMR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:26:06 -0500
Received: (qmail 14639 invoked by uid 109); 13 Feb 2018 17:26:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Feb 2018 17:26:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20423 invoked by uid 111); 13 Feb 2018 17:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 12:26:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 12:26:04 -0500
Date:   Tue, 13 Feb 2018 12:26:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
Message-ID: <20180213172603.GA10062@sigill.intra.peff.net>
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
 <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
 <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
 <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
 <20180213100437.15685-1-szeder.dev@gmail.com>
 <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 09:08:44AM -0800, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > A third possible fix, which is also in the "we don't care about the
> > order of multiple warning messages" camp and has a nice looking
> > diffstat, would be something like this:
> 
> Hmph, we are running a "git fetch" locally and observing the error
> output from both "fetch" and its counterpart "upload-pack", aren't
> we?  The "fetch" instances that are run with test_must_fail are
> expected to stop talking to "upload-pack" by detecting an error and
> severe the connection abruptly---depending on the relative timing
> between the processes, the other side may try to read and diagnose
> "the remote end hung up unexpectedly", no?  

If I understand Gábor's patch correctly, it is using test_i18ngrep for
the specific lines we care about so that we don't have to worry about
other cruft lines that may or may not appear (including the hangup one).

The downside is that we would not notice if a _new_ error message
(beyond the ones we expect and the one we were explicitly ignoring)
appeared. IMHO that's probably fine.

-Peff

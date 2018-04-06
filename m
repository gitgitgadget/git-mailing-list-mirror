Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829F91F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDFVmj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:42:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:56592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751417AbeDFVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:42:38 -0400
Received: (qmail 29916 invoked by uid 109); 6 Apr 2018 21:42:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:42:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30181 invoked by uid 111); 6 Apr 2018 21:43:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:43:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:42:36 -0400
Date:   Fri, 6 Apr 2018 17:42:36 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
Message-ID: <20180406214236.GF7870@sigill.intra.peff.net>
References: <20180329150322.10722-1-pclouds@gmail.com>
 <20180331164009.2264-1-avarab@gmail.com>
 <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
 <87woxove8d.fsf@evledraar.gmail.com>
 <20180403151700.GA24602@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403151700.GA24602@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 05:17:00PM +0200, Duy Nguyen wrote:

> It's not that complex. With the EAGER_DEVELOPER patch removed, we can
> have something like this where eager devs just need to put
> 
>     DEVOPTS = gentle no-suppression
> 
> and you put
> 
>     DEVOPTS = gentle
> 
> (bad naming, I didn't spend time thinking about names)

It seems to me like we're losing the point of DEVELOPER here. I thought
the idea was to have a turn-key flag you could set to get extra linting
on your commits. But now we're tweaking all kinds of individual options.
At some point are we better off just letting you put "-Wno-foo" in your
CFLAGS yourself?

I don't mind the version-based checks because they're automatic, so the
feature remains turn-key. But this kind of DEVOPTS seems like a step in
the wrong direction.

-Peff

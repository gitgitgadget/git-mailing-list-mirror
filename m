Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF571F453
	for <e@80x24.org>; Fri,  3 May 2019 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfECUxB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 16:53:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:48188 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726022AbfECUxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 16:53:01 -0400
Received: (qmail 6638 invoked by uid 109); 3 May 2019 20:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 May 2019 20:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14388 invoked by uid 111); 3 May 2019 20:53:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 May 2019 16:53:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2019 16:52:59 -0400
Date:   Fri, 3 May 2019 16:52:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
Message-ID: <20190503205259.GB17551@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <20190413221646.GL12419@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1904261051310.45@tvgsbejvaqbjf.bet>
 <87ftpwip5m.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1905031437590.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905031437590.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 10:49:17PM +0200, Johannes Schindelin wrote:

> I am well aware of the way Debian-based systems handle alternatives, and I
> myself also use something similar to write this E-Mail (but it is not a
> symlink, it is a Git alias).
> 
> But that's not the hack that I was talking about.
> 
> The hack I meant was: if you symlink `gzip` to `pigz` in your `PATH` *and
> then expect `git archive --format=tgz` to pick that up*.
> 
> As far as I am concerned, the fact that `git archive --format=tgz` spawns
> `gzip` to perform the compression is an implementation detail, and not
> something that users should feel they can rely on.

I'd agree with you more if we didn't document a user-facing config
variable that claims to run "gzip" from the system.

> > Just commenting on the overall thread: I like René's "new built-in"
> > patch best.
> 
> I guess we now have to diverging votes: yours for the `git archive --gzip`
> "built-in" and Peff's for the async code ;-)

For the record, I am fine with any of the solutions (including just
doing the single-thread bit you already have and letting René do what he
likes on top).

-Peff

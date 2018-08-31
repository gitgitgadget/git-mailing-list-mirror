Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D1F1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeIAA5q (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:57:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726869AbeIAA5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:57:46 -0400
Received: (qmail 32322 invoked by uid 109); 31 Aug 2018 20:48:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 20:48:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8934 invoked by uid 111); 31 Aug 2018 20:48:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 16:48:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 16:48:32 -0400
Date:   Fri, 31 Aug 2018 16:48:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
Message-ID: <20180831204832.GA14869@sigill.intra.peff.net>
References: <pull.23.git.gitgitgadget@gmail.com>
 <pull.23.v2.git.gitgitgadget@gmail.com>
 <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com>
 <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808301259420.71@tvgsbejvaqbjf.bet>
 <20180830200911.GC22407@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808312238250.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808312238250.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 10:38:44PM +0200, Johannes Schindelin wrote:

> > > Is there any reason why you avoid using `git rebase -ir` here? This should
> > > be so much easier via
> > > 
> > > 	git checkout pk/rebase-i-in-c-6-final
> > > 	git rebase -ir js/rebase-in-c-5.5-work-with-rebase-i-in-c^
> > > 
> > > and then inserting this at the appropriate position, followed by the `git
> > > range-diff @{-1}...`:
> > > 
> > > 	git am -s mbox
> > > 	git update-ref js/rebase-in-c-5.5-work-with-rebase-i-in-c HEAD
> > 
> > Related discussion, including a fantasy tangent by me (downthread):
> > 
> >   https://public-inbox.org/git/20180727080807.GA11932@sigill.intra.peff.net/#t
> 
> I have no idea what you meant there...

I thought you were asking why Junio does not just use "git am" from
inside "git rebase". I asked the same thing recently, and the answer is
because he is afraid of how the two interact. I dug a little into it
(the fantasy part is that I laid out a dream for how operations like
this could safely stack).

-Peff

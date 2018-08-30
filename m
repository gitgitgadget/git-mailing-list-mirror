Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743F91F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHaANF (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:13:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:34554 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbeHaANF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:13:05 -0400
Received: (qmail 8962 invoked by uid 109); 30 Aug 2018 20:09:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 20:09:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31056 invoked by uid 111); 30 Aug 2018 20:09:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 16:09:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 16:09:12 -0400
Date:   Thu, 30 Aug 2018 16:09:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] builtin rebase: prepare for builtin rebase -i
Message-ID: <20180830200911.GC22407@sigill.intra.peff.net>
References: <pull.23.git.gitgitgadget@gmail.com>
 <pull.23.v2.git.gitgitgadget@gmail.com>
 <5403014be738425e942a9bc1ca2029dd8d2137bb.1535553074.git.gitgitgadget@gmail.com>
 <xmqq5zzs94qb.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808301259420.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808301259420.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 01:03:41PM +0200, Johannes Schindelin wrote:

> > Will replace by doing:
> > 
> >     $ git checkout js/rebase-in-c-5.5-work-with-rebase-i-in-c
> >     $ git checkout HEAD^
> >     $ git am -s mbox
> >     $ git range-diff @{-1}...
> >     $ git checkout -B @{-1}
> > 
> >     $ git checkout pk/rebase-i-in-c-6-final
> >     $ git rebase --onto js/rebase-in-c-5.5-work-with-rebase-i-in-c \
> >           js/rebase-in-c-5.5-work-with-rebase-i-in-c@{1} HEAD^0
> >     $ git range-diff @{-1}...
> >     $ git checkout -B @{-1}
> > 
> > to update the two topics and then rebuilding the integration
> > branches the usual way.  I also need to replace the "other" topic
> > used in this topic, so the actual procedure would be a bit more
> > involved than the above, though.
> 
> Is there any reason why you avoid using `git rebase -ir` here? This should
> be so much easier via
> 
> 	git checkout pk/rebase-i-in-c-6-final
> 	git rebase -ir js/rebase-in-c-5.5-work-with-rebase-i-in-c^
> 
> and then inserting this at the appropriate position, followed by the `git
> range-diff @{-1}...`:
> 
> 	git am -s mbox
> 	git update-ref js/rebase-in-c-5.5-work-with-rebase-i-in-c HEAD

Related discussion, including a fantasy tangent by me (downthread):

  https://public-inbox.org/git/20180727080807.GA11932@sigill.intra.peff.net/#t

-Peff

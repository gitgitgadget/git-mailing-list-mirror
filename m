Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116C81F404
	for <e@80x24.org>; Thu,  4 Jan 2018 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeADPx3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 10:53:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:53052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753013AbeADPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 10:53:28 -0500
Received: (qmail 2384 invoked by uid 109); 4 Jan 2018 15:53:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 15:53:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5065 invoked by uid 111); 4 Jan 2018 15:53:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 04 Jan 2018 10:53:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jan 2018 10:53:26 -0500
Date:   Thu, 4 Jan 2018 10:53:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env
 variables
Message-ID: <20180104155325.GA18376@sigill.intra.peff.net>
References: <20180103102840.27897-1-avarab@gmail.com>
 <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
 <87bmiacwoz.fsf@evledraar.gmail.com>
 <20180104044230.GA12113@sigill.intra.peff.net>
 <87a7xuc4ty.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7xuc4ty.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 11:10:17AM +0100, Ævar Arnfjörð Bjarmason wrote:

> That's badly explained, sorry, when I say "push" I mean "push and/or
> pull".
> 
> I don't know about Github, but on Gitlab when you provision a deploy key
> and associate it with a repo it must be *globally* rw or ro, there's no
> way to on a per-repo basis say it should be rw ro.
> 
> I have a job that's fetching a bunch of repos to review code in them
> (for auditing purposes). It then commits the results of that review to
> other git repos.
> 
> Thus I want to have a ro key to all those reviewed repos, but rw keys to
> the audit repo itself (and it'll also pull with the rw key).

OK, that part makes sense to me.

But I'm not sure how your patch solves it. When you "git fetch" on the
audit repo, wouldn't your GIT_SSH_RECEIVE_COMMAND kick in and use the
wrong key? What am I missing?

-Peff

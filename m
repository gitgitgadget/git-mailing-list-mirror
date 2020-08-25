Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A6C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472CA2074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHYTzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:55:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:40678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:55:13 -0400
Received: (qmail 2456 invoked by uid 109); 25 Aug 2020 19:55:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 19:55:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1444 invoked by uid 111); 25 Aug 2020 19:55:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 15:55:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 15:55:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Mismatched HEAD default behavior from git log
Message-ID: <20200825195511.GD1419759@coredump.intra.peff.net>
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
 <xmqq8se21pl1.fsf@gitster.c.googlers.com>
 <20200825194619.GB1419759@coredump.intra.peff.net>
 <xmqq4koq1p28.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4koq1p28.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 12:51:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> As the intent for adding the "--stdin" option to any subcommand has
> >> always been "we may need to feed many many things, that may bust the
> >> command line length limit, hence we let you feed these things from
> >> the standard input, but otherwise there should be no change in
> >> behaviour or semantics", when the behaviour of command line and
> >> "--stdin" differ, it is a bug in the latter.
> >
> > Agreed. It also helps in this case that the command-line behavior is
> > sensible and the --stdin one is not. :)
> >
> > I think the solution is probably something like:
> 
> You beat me to it while I was wondering what to do between the local
> got_rev_arg variable and the revs->rev_input_given field.

That makes me wonder why we need got_rev_arg at all if we have
revs->rev_input_given. But I suspect an answer can be found by digging
into git-blame. I probably won't do that immediately, so if you want to,
you can do so without worrying that we're duplicating work. :)

-Peff

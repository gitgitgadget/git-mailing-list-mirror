Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2EC388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C38221D7F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKLUsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:48:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgKLUsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:48:03 -0500
Received: (qmail 22110 invoked by uid 109); 12 Nov 2020 20:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 20:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1499 invoked by uid 111); 12 Nov 2020 20:48:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 15:48:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 15:48:02 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: How do I "git fetch" with a custom <refspec> but a default
 remote?
Message-ID: <20201112204802.GA707750@coredump.intra.peff.net>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
 <20201111151754.31527-1-avarab@gmail.com>
 <877dqqhd3s.fsf@evledraar.gmail.com>
 <20201112185146.GD701197@coredump.intra.peff.net>
 <CAPx1Gvckixj2hj5wL8EPpJbnp4rsV7-qnVUCG1d-UAqVtp-H-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1Gvckixj2hj5wL8EPpJbnp4rsV7-qnVUCG1d-UAqVtp-H-Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 11:26:25AM -0800, Chris Torek wrote:

> On Thu, Nov 12, 2020 at 10:52 AM Jeff King <peff@peff.net> wrote:
> > If we were starting from scratch, then I think that might have been
> > nicer, because --default-remote would be implied if there is no
> > "--remote" option. And then my lazy-to-type:
> >
> >   git fetch topic
> >
> > would just work. But given that we have the positional <remote>
> > parameter already, I don't think adding --remote gives much value. And
> > it raises the question of what "git fetch --remote=foo --remote=bar"
> > means (I think the answer is last-one-wins).
> 
> Since `git fetch` can fetch from more than one remote, it seems to me
> to make more sense to mean "fetch from each".

Ah, right, I forgot that --multiple existed. Without it, specifying
multiple remotes makes no sense at all. But perhaps giving multiple
--remote would implicitly specify "--multiple". That makes sense to me.

> (This isn't necessarily an argument in favor of adding these options,
> just my suggestion for what multiple `--remote=` settings would mean.)

Likewise. "makes sense" above mostly means I would not object to it, but
I am not advocating for it. :)

-Peff

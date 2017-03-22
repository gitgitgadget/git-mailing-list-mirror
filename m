Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DAB2095F
	for <e@80x24.org>; Wed, 22 Mar 2017 22:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdCVWgI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:36:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49841 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbdCVWgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:36:06 -0400
Received: (qmail 31645 invoked by uid 109); 22 Mar 2017 22:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:36:05 +0000
Received: (qmail 870 invoked by uid 111); 22 Mar 2017 22:36:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:36:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:36:00 -0400
Date:   Wed, 22 Mar 2017 18:36:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern>
 documentation
Message-ID: <20170322223600.huyel6j5wl644ddf@sigill.intra.peff.net>
References: <20170321125901.10652-1-avarab@gmail.com>
 <20170321125901.10652-11-avarab@gmail.com>
 <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
 <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
 <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
 <xmqqtw6lgd82.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtw6lgd82.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 03:26:21PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > of things you think we should be putting in the test suite. I.e.
> > should the tests be:
> >
> > a) Only be a collection of invocations of git we'd be comfortable
> > showing to someone as "this works, and this is how you should do it",
> > or things that explicitly fail marked with test_must_fail.
> >
> > b) or a) && also various surprising combinations of things we don't
> > necessarily want to encourage or even support in the future, but which
> > are in there so if we change them, we at least know our change changed
> > something that worked before.
> 
> I am strongly inclined to (a).  If we cannot decide when we designed
> the feature, and we anticipate that we may want to change it later,
> then documenting the choice in a test or two may be a way to remind
> the choice we happened to have made, but in general I do not think
> we want to promise (to ourselves) more than what we are willing to
> commit to.

I've occasionally[1] added tests that are "what we happen to produce
now", but I almost always mark them with a comment either in the test
script or in the commit message.  What I'm _most_ concerned about is a
developer later breaking the test, but being unsure if they were
breaking some real-world case (and not being able to find clues in the
history).

A secondary concern would be people using the test snippets as guidance
on what is normal or encouraged.

So I could live with these patches, but I'd prefer to see a comment
somewhere. And I think I'd have a slight inclination to just stick to
(a) in the first place, unless there is a really good reason to cover
the test (like that we do not care between behaviors X and Y, but we
need to check that it does one of them, and not Z).

-Peff

[1] E.g., see the comment in t3204 from a356e8e2a (t3204: test
    git-branch @-expansion corner cases, 2017-03-02).

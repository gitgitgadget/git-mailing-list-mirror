Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3653C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB4364F0F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhCQUTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:19:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233285AbhCQUSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:18:48 -0400
Received: (qmail 27098 invoked by uid 109); 17 Mar 2021 20:18:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 20:18:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12700 invoked by uid 111); 17 Mar 2021 20:18:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 16:18:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 16:18:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pete Boere <pete@duel.me>, git@vger.kernel.org,
        John Lin <johnlinp@gmail.com>
Subject: Re: Extra blank lines in "git status" output have been reduced
Message-ID: <YFJkJvJdO5XsrvO/@coredump.intra.peff.net>
References: <CAF8W_bFzE8strSWc0_eABdyfCxA+0CA6ph_uXgSyT7YRU-jO6A@mail.gmail.com>
 <xmqqo8fhtvst.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8fhtvst.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 12:38:42PM -0700, Junio C Hamano wrote:

> Pete Boere <pete@duel.me> writes:
> 
> > With the release of v2.23 I have noticed from the commit:
> > 7b098429355bb3271f9ffdf73b97f2ef82794fea
> > ...
> > Is there any chance of adding them back? The changed layout has been
> > throwing me off ever since upgrading.
> 
> Sorry, but it is way too late to complain, generally after a change
> hits a release, and especially after it got buried under 8 new major
> releases.  Unless a change was an unintended side-effect that we did
> not mean to make, in which case we would likely to fix it as a bug.
> 
> And the change in question b2f5171e (status: remove the empty line
> after hints, 2019-06-04) quite deliberately targets at removing
> these extra lines [*], so no, I do not think it is reasonable to
> expect reverting that commit that is more than a year old.
> 
> You may want to join the list discussion and stop whatever UI change
> you find undesirable before it materializes next time.

If we discover later that some portion of users prefer an older
behavior, it may be reasonable to build on top with a config option to
allow selecting the old or the new. The inputs to "may be reasonable"
there are:

  - how big is the code burden to support both behaviors? In this case,
    I don't think it's too bad; it's restoring the old newlines with a
    conditional

  - how many people would actually care enough to set the option? Even
    without a lot of code, each option is _some_ burden to carry, both
    in the code and in the overall complexity of the interface. I'm less
    convinced in this particular case that a lot of people care (given a
    single comment after many releases), but perhaps those interested in
    the change could produce data (note I said "data", not "argue more
    vigorously" ;) ).

    It might help justify such an option if it applied in more places.
    E.g., an option for "I prefer the look of lots of whitespace in
    messages" versus "I prefer a more compact look".

-Peff

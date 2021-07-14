Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213AC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CF7613C1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNRgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:36:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:49670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhGNRgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:36:41 -0400
Received: (qmail 29583 invoked by uid 109); 14 Jul 2021 17:33:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 17:33:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26440 invoked by uid 111); 14 Jul 2021 17:33:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 13:33:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 13:33:48 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] doc: document the special handling of -l0
Message-ID: <YO8f/A8qnTEDlnAr@coredump.intra.peff.net>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
 <YO8Ut9b+6D/wR6uf@coredump.intra.peff.net>
 <CABPp-BFu4-SJrGbeSQTum_JOq4PHAGwGPPLQA+sHZMP4wvqA1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFu4-SJrGbeSQTum_JOq4PHAGwGPPLQA+sHZMP4wvqA1w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:17:21AM -0700, Elijah Newren wrote:

> > > +Note that for backward compatibility reasons, a value of 0 is treated
> > > +the same as if a large value was passed (currently, 32767).
> >
> > Given the confusion around what "32767" even means to users, I wonder if
> > we could just say: a value of 0 removes any artificial limits (but Git
> > still has some internal limits which real-world cases are not likely to
> > hit).
> 
> 32767 is not an internal limit; and as such, it is absolutely an
> artificial limit.  I had to use 48941 just a few years ago, and that
> value (and others larger than 32767) are fully supported.

OK, I thought there was still some 32-bit m*n limits, but I guess not.

> > Removing limits is after all the point of "0". I'm also not sure if it
> > is simply for backwards compatibility. We commonly let "0" or "-1" mean
> > "no limit" for convenience. It seems like something we'd want to
> > support.
> 
> Making 0 mean unlimited could be done, and I think it'd be a one-line
> change, but that's not what commit 89973554b52c (diffcore-rename: make
> diff-tree -l0 mean -l<large>, 2017-11-29) tried to do.
> 
> I'm not opposed to such a change in the meaning of "0", but I am
> opposed to documenting this value as unlimited unless we make it so.

Thanks for clarifying. It does seem silly that "0" means "big, but kind
of arbitrary". But I'm OK to punt on that change for now (and in the
meantime, I have no real opinion on whether or how to document the
current behavior).

-Peff

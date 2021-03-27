Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D76C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFACF619AB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 09:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhC0Juw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 05:50:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:50648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhC0JuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 05:50:21 -0400
Received: (qmail 13371 invoked by uid 109); 27 Mar 2021 09:50:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Mar 2021 09:50:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16241 invoked by uid 111); 27 Mar 2021 09:50:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Mar 2021 05:50:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Mar 2021 05:50:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
Message-ID: <YF7/3GN4H/agNaxH@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
 <YF2/xPMvwhm+OOVz@coredump.intra.peff.net>
 <87pmzmnd5h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmzmnd5h.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 04:32:58PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > This is a definite improvement. Two thoughts come to mind, though:
> >
> >   1. Do we need a separate script for this? Couldn't the existing linter
> >      script check this while it is reading all of the files (it knows
> >      which ones are supposed to be manpages because they are annotated
> >      with the --section option).
> 
> It's not needed, but I think it's better, one is iterating a
> line-at-time, one slurps all lines, they have different sorts of error
> reporting (one quotes the whole line).
> [...]

OK. As the person who looked at all of it much more closely, I'll trust
your judgement there.

> >   2. Instead of linting, could we just be automatically sticking this
> >      boilerplate in as part of the build (either through some asciidoc
> >      magic, or even just a plain old "cat")? Even better than being
> >      reminded that you forgot something is making it impossible to
> >      forget it in the first place.
> 
> Whenever I take an aborted effort at the docs I end up with some aborted
> effort to migrte them to texinfo, so I'm sympathetic to the automatic
> generation part of this.
> 
> But for something trivial like this I think there's more value in having
> a 1=1 match between WYS and WYG, not adding magic blurbs by the build
> system for something so trivial.
> 
> That being said I wouldn't mind it much, just seemed like an obvious
> thing to add a lint for as it stands now...

Yeah, I agree that complicating the build may create its own problems.
If we were already munging the *.txt files it may not be a big deal to
add further munging, but it would be a jump from the current state of
"we feed it directly to asciidoc".

I'm OK to forget about it for now and see if other useful applications
of such munging come up.

-Peff

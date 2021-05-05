Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087DC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3461075
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhEEORt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:17:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:45412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhEEORt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:17:49 -0400
Received: (qmail 18559 invoked by uid 109); 5 May 2021 14:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 14:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10123 invoked by uid 111); 5 May 2021 14:16:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 10:16:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 10:16:51 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Message-ID: <YJKo02fG/riIetpu@coredump.intra.peff.net>
References: <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com>
 <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com>
 <xmqq7dke7jeo.fsf@gitster.g>
 <87a6pawmyu.fsf@evledraar.gmail.com>
 <YJHWJRYOcFEvHoD/@camp.crustytoothpaste.net>
 <6091e1f12ddf9_cc8208b9@natae.notmuch>
 <YJH712E2kT9yJkGT@camp.crustytoothpaste.net>
 <6092180651fdc_105ac2088a@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6092180651fdc_105ac2088a@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 04, 2021 at 10:59:02PM -0500, Felipe Contreras wrote:

> > I believe there's a bash compatibility mode that enables this, but I
> > don't see support for it in the version Debian ships[0], which doesn't
> > enable that mode:
> > 
> >   ksh -c 'function f { local x="foo"; echo $x; }; f'
> >   ksh: f[1]: local: not found [No such file or directory]
> 
> I tried to build ksh myself to make sure, and apparently there's a mess
> of different versions of it. I manually applied some patches and tried
> three times before giving up.
> 
> It's clear the Debian version and the Arch Linux version are completely
> different.
> 
> > Regardless of the specifics, I think we can both agree that it doesn't
> > work in sh-style functions, so for Git's purposes, AT&T ksh does not
> > meet our needs in terms of support for local.
> 
> Indeed. But it also probably doesn't meet many other needs. A quick
> check shows 54 failed tests just on t0000-basic.sh. I don't think it's
> something we should even consider.

Yeah, we have visited this off and on over the years (links below).
There are some modernized ksh variants that work OK (like mksh), but I
think we've declared ksh93 as not worth it.

-Peff

[0] https://lore.kernel.org/git/31108626.20150508231514@gmail.com/
[1] https://lore.kernel.org/git/xmqqinxt3kwq.fsf@gitster.mtv.corp.google.com/

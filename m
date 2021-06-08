Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC27C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3477B60C40
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFHGhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:37:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:48588 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFHGhY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:37:24 -0400
Received: (qmail 27967 invoked by uid 109); 8 Jun 2021 06:35:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:35:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6993 invoked by uid 111); 8 Jun 2021 06:35:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:35:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:35:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] t: use pre-defined utf-8 locale for testing svn
Message-ID: <YL8PsmLaU+MpWv58@coredump.intra.peff.net>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <20210607004838.15235-1-congdanhqx@gmail.com>
 <xmqqk0n6wkrr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0n6wkrr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 10:01:12AM +0900, Junio C Hamano wrote:

> >> I kind of wonder if trying "C.UTF-8" would be a reasonable fallback so
> >> that people don't even have to set this extra Makefile knob. But I'm not
> >> sure if we have a good way of testing if that locale works (if we can't
> >> find the "locale" binary).
> >
> > I also think we should fallback to "C.UTF-8" instead of not testing those
> > tests.  However, I don't know if there're any systems that not have "C.UTF-8"
> > locale.
> 
> I do share the feeling, but have a hunch that systems lacking
> "locale -a" may be either superset of, or has at least large overlap
> with, those lacking "C.UTF-8", and the new mechanism introduced here
> will cover both of them, so I think it is OK to stop here, at least
> for now.

Yeah, I think it is OK to stop here, too. I'd worry that we'd make life
unnecessarily complicated for people testing on platforms that lack
"locale" and C.UTF-8, for little gain.

The v4 patch looks good to me.

-Peff

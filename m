Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F972C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3061A613B8
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhDMIBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:01:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:50908 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237309AbhDMIBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 04:01:18 -0400
Received: (qmail 28820 invoked by uid 109); 13 Apr 2021 08:00:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 08:00:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23618 invoked by uid 111); 13 Apr 2021 08:01:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 04:01:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 04:00:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] C99 support: remove non-HAVE_VARIADIC_MACROS code
Message-ID: <YHVPurTYDUE9XHN7@coredump.intra.peff.net>
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
 <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
 <patch-2.2-f12e3cad57d-20210412T105422Z-avarab@gmail.com>
 <xmqqeeffe669.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqeeffe669.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 10:58:22AM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Remove code that depend on HAVE_VARIADIC_MACROS not being set. Since
> > 765dc168882 (git-compat-util: always enable variadic macros,
> > 2021-01-28) we've unconditionally defined it to be true, and that
> > change went out with v2.31.0. This should have given packagers enough
> > time to discover whether variadic macros were an issue.
> 
> It hasn't even been a month since we did v2.31.0.  Since it was not
> even a maintenance release for security update, I have no reason to
> expect packagers to be all that prompt to react.  And because we
> gave them an escape hatch, they may have used it to update their
> distro packages and haven't had a chance to tell us about it yet.
> 
> So, the above does not sound like a credible excuse to make our
> future work necessary to react to "our toolchain is not ready yet"
> complaints bigger.  At least not yet.

Yeah, the whole idea of the change in v2.31.0 was to change as little as
possible for the weather-balloon. I agree that waiting longer to see the
results of our test makes sense, unless there is a pressing need.

If we had some new use case that was going to have to _add_ workarounds
for platforms without variadic macros, I'd be more inclined to think
about that timetable versus how much work it would be to add those
workarounds. But since there isn't one, it seems there is little cost to
waiting longer.

-Peff

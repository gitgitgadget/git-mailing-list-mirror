Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0FFC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1E42222C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKDNbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:31:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:47162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKDNbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:31:31 -0500
Received: (qmail 9743 invoked by uid 109); 4 Nov 2020 13:31:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:31:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10220 invoked by uid 111); 4 Nov 2020 13:31:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:31:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:31:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201104133129.GA3030480@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net>
 <20201103101553.GH24813@szeder.dev>
 <20201103182102.GA459792@coredump.intra.peff.net>
 <xmqq361qs31a.fsf@gitster.c.googlers.com>
 <20201103185711.GA461461@coredump.intra.peff.net>
 <xmqqimamqjhl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimamqjhl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 12:21:42PM -0800, Junio C Hamano wrote:

> >> So something like this won't harm VS Code more than we currently do,
> >> while telling users what is wrong with their command line?
> >
> > Yeah, I was wondering if we'd want the patch you sent, or if we should
> > turn those die() calls into warning() and disable the flags up front.
> [...]
> >> diff --git c/builtin/log.c w/builtin/log.c

Since we now have identified the caller that was passing in the bogus
options, and it has already been fixed, I'm inclined to say we should go
with your die() patch from earlier (modulo the pathspec.nr fixup) and
call it done.

Do you want to roll that up with a commit message?

-Peff

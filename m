Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4A7EE49A0
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHYUfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjHYUfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 16:35:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B42129
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 13:35:05 -0700 (PDT)
Received: (qmail 26590 invoked by uid 109); 25 Aug 2023 20:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Aug 2023 20:35:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1802 invoked by uid 111); 25 Aug 2023 20:35:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Aug 2023 16:35:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Aug 2023 16:35:02 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
Message-ID: <20230825203502.GB2382334@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <20230824205009.GA1516@coredump.intra.peff.net>
 <ZOj8N4OS8zp7h9Vc@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOj8N4OS8zp7h9Vc@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2023 at 03:08:39PM -0400, Taylor Blau wrote:

> On Thu, Aug 24, 2023 at 04:50:09PM -0400, Jeff King wrote:
> > On Thu, Aug 24, 2023 at 02:40:34PM -0400, Taylor Blau wrote:
> >
> > > While working on another topic that cleared up some leaks, I wanted to
> > > see if any new tests became leak-free, so I ran:
> > >
> > >     $ make SANITIZE=leak
> > >     $ make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test
> >
> > Is that exactly what you ran? Because I'd expect the second "make"
> > invocation to rebuild Git _without_ SANITIZE=leak enabled in that case.
> > (Though I would have then expected most of the scripts to complain
> > loudly about the mismatch; did you "cd t" in between the two?).
> 
> Argh. No, I wrote instead:
> 
>   make SANITIZE=leak
>   make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check ... test

Ah, that makes sense. The sample command in the commit message of the
first patch has the same situation, I think.

(I don't usually run "make test" from "t" myself because I prefer
"prove", and an explicit "make test" skips the DEFAULT_TEST_TARGET
magic).

-Peff

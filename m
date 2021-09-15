Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C237EC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2B610D1
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhIOQgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:36:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIOQgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:36:54 -0400
Received: (qmail 32416 invoked by uid 109); 15 Sep 2021 16:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25166 invoked by uid 111); 15 Sep 2021 16:35:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:35:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 03/11] serve: add "receive" method for v2 capabilities
 table
Message-ID: <YUIg1vCvmwk3J13P@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1fGZc1FuuyUNH@coredump.intra.peff.net>
 <87sfy6mzzg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfy6mzzg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:31:28AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I haven't actually run this yet (and need to zZzZ soon), but AFAICT at
> the end of this series you leave the existing advertise semantics of
> advertise() be (which is fine). I have this unsubmitted patch locally
> which you may or may not want to work into this.
>
> I considered splitting up the advertise() method as well, i.e. we could
> have a new "is_advertised" boolean callback, and then a
> "capability_string" or whatever. "server-option" and "object-info" never
> add anything, so they could leave that as NULL.
> 
> But it's probably not worth it, just food for thought...

Yes, I noticed the advertise() function is really doing double-duty
here. Nothing changes with respect to it in my series, but I agree it's
a bit confusing.

The functions are simple enough that splitting up the two functions of
advertise() might make sense. Likewise, your documentation seems
reasonable. I'd prefer to punt on it for now, though, as my series isn't
otherwise touching this function.

I'm sure there are textual conflicts with what I'm doing here, since
it's nearby, but I'd prefer to just build more cleanups on top later.

-Peff

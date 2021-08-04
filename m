Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42AC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A01860F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbhHDVEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:04:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:39054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240112AbhHDVEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:04:08 -0400
Received: (qmail 7460 invoked by uid 109); 4 Aug 2021 21:03:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Aug 2021 21:03:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28518 invoked by uid 111); 4 Aug 2021 21:03:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Aug 2021 17:03:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Aug 2021 17:03:54 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Message-ID: <YQsAuvPwoSb/J4X3@coredump.intra.peff.net>
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 10:22:41AM -0400, Derrick Stolee wrote:

> > * lh/systemd-timers (2021-07-02) 3 commits
> >  - maintenance: add support for systemd timers on Linux
> >  - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
> >  - cache.h: Introduce a generic "xdg_config_home_for(…)" function
> > 
> >  "git maintenance" scheduler learned to use systemd timers as a
> >  possible backend.
> > 
> >  Waiting for reviews.
> 
> I just took another look at this series and see that there were a few
> items that have yet to be addressed. CC'ing Lénaïc and reviewers to
> see if those items will come in a v8. Here is a quick summary of my
> understanding:
> 
> * There are some non-ASCII characters in a code comment that are a
>   bit non-standard and could be replaced with ASCII representations.
>   (nit, but if re-rolling already this might be worth doing.)
> 
> * There is some discussion about using string_list_split() instead
>   of hand-rolling a string splitter. Discussion decided that we
>   should _not_ use strbuf_split_buf(). It would be nice to later
>   create a version of strvec_split() that takes an arbitrary 
>   delimiter, but isn't necessary for this series.

I think this strvec part was the only thing I had commented on
previously. I agree with your summary here (especially that we can punt
on refactoring strvec_split() for this series).

-Peff

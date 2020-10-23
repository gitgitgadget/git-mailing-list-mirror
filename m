Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DEC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40A220E65
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 19:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlWrcxdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbgJWTR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbgJWTR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 15:17:56 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF9C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:17:55 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n3so3019024oie.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+CoNzPuIhPUBFge8lYLRxyfI7fK14bzIbl48f8ba8s=;
        b=VlWrcxdRh4KnQwzyX/zpluCmmRJ9RsDGY+8kY1E932yxzLhFV2YQhiGY23TBK+ixNf
         As8TqP6f9WycjDIgOAS35yhSYQPQZfoaDvrkzPZnvDM+3Q0I6wJ2WMvzfaF5Rdp92Bck
         I24kooNnBxLboYyNLDN0ouLkuEnb10gY1+wvIdNdaPcf1QFWdNpcenRtKLAl77WYQ5or
         d2ZtXlGcSix6u7gUeWcAcbEdI5yHwPLHaBAK0MRWjvG7+pFMeFBjLYO8UBX5fWGVFeHl
         TxIVY/2G4AvpYkBNFZBk3Nve12biXqp/C8ZXSsmUqSx9UPFjc2tmaLpAM4amSa1aSeYN
         cuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+CoNzPuIhPUBFge8lYLRxyfI7fK14bzIbl48f8ba8s=;
        b=LPUaFlcUtYsAHaLB+OKWp55L+fxqGOcr9hVQzpV/I9Yea32wrIAjVLeLceJ+2+9aLb
         q6kujseshjRYneW3j5gp/Ucg+qfLSONi0b0Wd9g20IBGVRyNtBg+K6Wp4ojTy2Xa1/LX
         BuHlh+w1YlK+W0sQXlA75wiWD0GokwegELsUI9FKpYvHXsoF81PdD1ckU2gsBAm+e1j+
         8OiwLp0MONTL6xxiraHn68kLzwLA5FWAZcC1Sg02gejAiRx0/RIYh8iV9RWXD6aUj8SZ
         fEIStCYrL/E7hMMPqwXnJrp/D31iv1L+pBAOIdHH6jNMMFWxA+UEe749lezUulsmkka5
         5AUw==
X-Gm-Message-State: AOAM531Jv+yDvhBiycJd2/DhL+/ZDEwMf8Ft5QeiUFetuvsBT8+VUcj8
        l1McI14D1cb5SB6VnEX8PbA+3KRjVR9WZXfgg10=
X-Google-Smtp-Source: ABdhPJwiOjb2bKreRTkAu3n92dN5ogVBSe0P29fNJsbOwwRMGpXVwU3KplwR0PjwMnuowDnuyL1lJKcDXtlwz2gyD6Q=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2744439oic.31.1603480674488;
 Fri, 23 Oct 2020 12:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1put77h.fsf@gitster.c.googlers.com> <20201023080202.GA4012156@coredump.intra.peff.net>
In-Reply-To: <20201023080202.GA4012156@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 12:17:43 -0700
Message-ID: <CABPp-BFV8ZAu5vLarG2mX8gT5bfV31oqbd-vjAQF_YDcyNSRiw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2020, #03; Mon, 19)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 1:02 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Oct 19, 2020 at 11:13:22AM -0700, Junio C Hamano wrote:
>
> > * en/strmap (2020-10-13) 10 commits
> >  - strmap: enable allocations to come from a mem_pool
> >  - strmap: add a strset sub-type
> >  - strmap: add functions facilitating use as a string->int map
> >  - strmap: enable faster clearing and reusing of strmaps
> >  - strmap: add more utility functions
> >  - strmap: new utility functions
> >  - hashmap: introduce a new hashmap_partial_clear()
> >  - hashmap: allow re-use after hashmap_free()
> >  - hashmap: adjust spacing to fix argument alignment
> >  - hashmap: add usage documentation explaining hashmap_free[_entries]()
> >
> >  A speciailization of hashmap that uses a string as key has been
> >  introduced.  Hopefully it will see wider use over time.
> >
> >  Will merge to 'next'.
>
> I haven't gotten a chance to look at this carefully yet, but note that
> the strset here sort-of conflicts with the one I added recently in
> builtin/shortlog.c (already in master). I think the compiler won't
> complain because they never show up in the same translation unit, but we
> should avoid having two almost-the-same types in the codebase.

Makes sense.

> I suspect my "check_and_add" function could be folded into Elijah's
> implementation. The other big difference is that mine uses the
> FLEX_ALLOC approach, and his doesn't. I haven't digested the code and
> discussion around that from Elijah's series yet.

From a brief glance, it looks like the code in shortlog would probably
be easy to convert over.  But more important is making sure we have a
strmap/strset/strintmap API that we like.  You provided a lot of good
feedback and pointers on the first round of the series, so if you
could find some time to take a look at the second round, it'd be very
appreciated.  I'm also very interested in your opinion on whether the
changes I made were good enough, or if you'd like me to dig further
into whether going the FLEX_ALLOC route will work.

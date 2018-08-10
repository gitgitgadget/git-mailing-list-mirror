Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618871F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHKB7g (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:59:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43283 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKB7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:59:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so9801595ywb.10
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOBLPlz8+vkdgpry9Bcth5/pr/PJdBzEQFCk+2/GGeY=;
        b=roZr/a3Y/9jYNT2GAQqTL2qXP+044hzK+6VSsqZXIeWHK7E3x5i4vj88v0GYM6JfRt
         sp33itV46MOVNJriAuVGgf8DW9DPUxC5FnA4I8zua/5DjL7FgO1Ta2nc/LK1Yc0jpnbW
         xu035LTZ97Xn8C6WWABZHQzVSLIetq5nu8gEXoISbzw+wl52HDaTLfe4+jV6dAYk8Ugl
         pp1fvZiS86kYejmAlAQU6gdzKoF+jAEw28xbaDYIBDRQ521dQxVlZWxyXWLgbBsDN8pa
         qaZf+KXeC+KJ8WWbJznat9GFAQRRaqU4ymQ2lraOiYExQCFBzT7yliSGb0r+HW1tKzTE
         DuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOBLPlz8+vkdgpry9Bcth5/pr/PJdBzEQFCk+2/GGeY=;
        b=FW+EtBUZkunZaDm3BbwWjE9Ksq1g78MKTzfwBg7EOUHhgeLnnPI2H1cXzK79thaLWp
         38lcuc5xdax+bA/2ch9BBtghw0wvaw/u5mVfhTvRWqDrjefGP65EdoWtElAkguGD2MDa
         QqbEChOEMzHdacSkW0I2glczIGCk1pgNixzbrKDRMZuoRVNjHWJsNAhLcX7KvzSteglA
         4heq5CwJzH9E2jtg0iLCTSekpl9bfKFz0PHLo8EvzWQ84gQPG0WjzzJEktcsLBxzq2c0
         iFkUw7OVDTCbdpwwweSfjZ3lCfaAFHVvzl/L3+kir0eU0f/hs5K300BYmp6i8uBdN1jM
         UphQ==
X-Gm-Message-State: AOUpUlFpvJSOj/iWlypDHe4Mhckj8XBnSeiIvlSaR/mMlRQYgqeefOya
        JElVUIxymKD+2A3Lua/LmSfBBid0qoEsYTQqOVTWQg==
X-Google-Smtp-Source: AA+uWPyrIHv0iO9w+zE+rw555ZROGGM8ByzpxH6YRGGtlj4gs1BKDtCXRkFQpbDET1RZjLrBHqsUZqDGMbOyHDk4pQU=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr4991493ybm.307.1533943656224;
 Fri, 10 Aug 2018 16:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180810230729.GA19090@sigill.intra.peff.net> <20180810230906.GA19875@sigill.intra.peff.net>
In-Reply-To: <20180810230906.GA19875@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Aug 2018 16:27:25 -0700
Message-ID: <CAGZ79kYStPNCodJBqZ-ELh2oEhEyQFFjr0SVn0Bn+gtAspbZiA@mail.gmail.com>
Subject: Re: [PATCH 1/7] for_each_*_object: store flag definitions in a single location
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 4:09 PM Jeff King <peff@peff.net> wrote:
>
> These flags were split between cache.h and packfile.h,
> because some of the flags apply only to packs. However, they
> share a single numeric namespace, since both are respected
> for the packed variant. Let's make sure they're defined
> together so that nobody accidentally adds a new flag in one
> location that duplicates the other.
>
> While we're here, let's also put them in an enum (which
> helps debugger visibility) and use "(1<<n)" rather than
> counting powers of 2 manually.

All good, but ...

>  cache.h    | 13 ++++++++++++-
>  packfile.h |  8 ++------
>  2 files changed, 14 insertions(+), 7 deletions(-)

rubs me the wrong way. ;-)

cache.h is such a misnomer of a name, and a kitchen sink
of a file in the Git project that in an ideal world it would
be way smaller and contain only things related to some
caching related code.

I would suggest object.h or object-store.h instead.
Probably the object-store as that will be the only external
exposure and hopefully we'd get the objects in a similar
shape as the refs subsystem eventually?

I might be biased by commits such as 4f39cd821d1
(pack: move pack name-related functions, 2017-08-18)

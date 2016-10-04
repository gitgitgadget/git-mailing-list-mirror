Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A816207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbcJDGMl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:12:41 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34991 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbcJDGMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:12:40 -0400
Received: by mail-yw0-f193.google.com with SMTP id t193so697165ywc.2
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GbJAMXyI9ZRMXS1NcI3/EP2TwoMvAJcgEKx7wrJHSTs=;
        b=Tv1OAy+qLu7fJfqMpIujwk5fOS7pb0smGNSeQQVZZMVt0cGBYBsw+6tC7Kgqa79cAx
         mw7zshjOh+y3wq0AtgGOndTWZKsIDFb7w7aPQiI39CLaxoyzLexTkFakI03plLRrufUX
         jVvSCvU6vlbj8LS2nuaL/NCSMCSI0tvYOnqpF2wlQGJ06XB01ZcEcru+DVma/pnLLIfr
         XcGcLZu/FS1Vk3NjhWD0Q6PVcn4yD1lyE9NMRUJb7yNntHE3A/7JjOLZeWUpvlmKKDAI
         gNha53zKoZg8Q4+2dUplIygvOCxii7vCwdg1CBtLxPdbe7D5m9ndP6zz4tDNZ9WH0zUe
         xEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GbJAMXyI9ZRMXS1NcI3/EP2TwoMvAJcgEKx7wrJHSTs=;
        b=c63oKI4Qx9ADekcRpwoX9uPXOYLKoldcP6mRHgWxzi3zpRe+Tb5m8TGjI7OVmoONav
         2KUs2Z27XYM8xoDQV3lkVj3Qbw9F/D5Ulf+0YvaSuLv+i0UyFg6onwkY/5+3DMhH2UU5
         3M5hwehYQ4h63p5crREbB/zkQg/AYW9zt5xHgxIjPUYUvDGZUEvLXCpA//Y7kgMUtelk
         uj2eeujIKlpEjElmJOBqXYsiwYoy8HSqEfZcByoQNvflsl6dUwDTNELdlprrs+mxvA0C
         VEo+sHAmkCQZ7IpkHSVzSR2/TLby78QfdQy1SLF6PEa+Um1BvDodvfUcLVTm2kAqmg/f
         94bw==
X-Gm-Message-State: AA6/9Rk13B8buuOPJF3VQeAiqQiRjXpD1psHzmSZuKKcX+0wSHFETDws5xl2S/B9nsfU7diocWcgEw6Ckz3/tA==
X-Received: by 10.129.74.2 with SMTP id x2mr1338372ywa.59.1475561559924; Mon,
 03 Oct 2016 23:12:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:12:19 -0700 (PDT)
In-Reply-To: <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:12:19 -0700
Message-ID: <CA+P7+xqyuHHcMaUPajgEjt3Uzkcx6tEPEykuRaTPdvKSzt3jzg@mail.gmail.com>
Subject: Re: [PATCH 12/18] alternates: use a separate scratch space
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> The alternate_object_database struct uses a single buffer
> both for storing the path to the alternate, and as a scratch
> buffer for forming object names. This is efficient (since
> otherwise we'd end up storing the path twice), but it makes
> life hard for callers who just want to know the path to the
> alternate. They have to remember to stop reading after
> "alt->name - alt->base" bytes, and to subtract one for the
> trailing '/'.
>
> It would be much simpler if they could simply access a
> NUL-terminated path string. We could encapsulate this in a
> function which puts a NUL in the scratch buffer and returns
> the string, but that opens up questions about the lifetime
> of the result. The first time another caller uses the
> alternate, the scratch buffer may get other data tacked onto
> it.
>
> Let's instead just store the root path separately from the
> scratch buffer. There aren't enough alternates being stored
> for the duplicated data to matter for performance, and this
> keeps things simple and safe for the callers.
>

Definitely agree here. The resulting code seems a lot easier to
follow, and making the callers simpler here is a very goo thing.

Thanks,
Jake

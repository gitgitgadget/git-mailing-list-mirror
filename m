Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB87C2BB3F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A68322EBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLESTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgLESJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 13:09:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8567C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 03:47:43 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so9322021wmb.2
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9ViGvM51J00tdfRiHvstd3pyIG6azNnwR+NPTjfBW4=;
        b=ijBdT/6wiIyBvTdemGSSxm2oJT+H5uGIt0AZdF2V3RemdLxKsyp9gwVab4YWpXlcGX
         ueG7o1mGQcOXITi0zKLAbWXUIqQx9ibTgB5Rdv6mevLTx2fNcxT08BgPen8cx2yEljsb
         hBap6TdU9H8CiL8+szFpEuYeY+VyerKJ1VBUHK9ksQrWu7W65jJdKgTnspZ9qWM9Ftyz
         pvbHHQN0LPJ4ideWU2gIgoc3W86f9Sco2ni9grpxkzBPF54tsg9QQPyFCXlk/IVzjWTQ
         G0PPLdz9IabreI0b+tyYc1Od7M99xbs42caSBORwW3p40VlE7VXKczcYCK9QRMVqfm/k
         Nv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9ViGvM51J00tdfRiHvstd3pyIG6azNnwR+NPTjfBW4=;
        b=ktKtjIoSrDsBq7K2Mr8Ada0uom+DZ/jV721PHBoEkLMnTs4gGuVGPcHDyuldH7je07
         N1YcEDqMuosJN/4vLGHsTXeXabHciD894/RP6zrvhEB+sPK8KtUEw3pEJsoScnqoDmV1
         UrnZURptR1RdbE5u3P+2+3cfewyAvcb11XB3AAsu0yj15I7CWhV6bCRffAgnISs9SNBa
         jHkDH1k5vcoIbAoK9a6U9BIfmTPexlzS4Frrmh6t+as7+cD0WB8vo30ty4JDUYKJO0mY
         GVZICuvGMyOFJfDFNevHcfe8VCmChMGIeVWxMDW7ODDYJDjuUqjgZSr+Yz1qXdgSiBiP
         DbRA==
X-Gm-Message-State: AOAM533gtSNPHx8cYGgLJ0g/ortZfGSgLcKefT5dnnvEjarongNOe5ax
        adDTDXqrGNxDrbxTPwLFoQB2pNVslrXn0k1Y184=
X-Google-Smtp-Source: ABdhPJxqNPdLQewqNXy/AJAsV9yiJVePA9qh0HioXIdSMFB2/WQOi7E3yzXLvX6Hy3fj0l88SEZh9Vvw7XbbMvEb4pw=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8843208wmg.37.1607168862512;
 Sat, 05 Dec 2020 03:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com> <CAPx1Gvf2SZdY_huOGieXD0kJaEn38gsaAiXrV==YxL1-x81dPg@mail.gmail.com>
In-Reply-To: <CAPx1Gvf2SZdY_huOGieXD0kJaEn38gsaAiXrV==YxL1-x81dPg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Dec 2020 05:47:31 -0600
Message-ID: <CAMP44s0NzvQzEutWvhAz2ytH+nKK=8GOHnLjEUe-QgZ7vo2Ttg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 3:23 AM Chris Torek <chris.torek@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 5:59 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > But in my mind "fast-forward" is not a noun, it's an adjective, so I
> > still expect a noun: fast-forward $what. And I don't have any other
> > noun to put there but "merge".
>
> It's a "fast-forward operation". :-)

A fast-forward operation that does what?

> It's just been nouned, like "a merge" instead of "a merge commit".

Except there's a difference between telling git: "do a fast-forward
merge", and "do a fast-forward merge commit". The latter doesn't
really make sense.

> > > > Perhaps: a merge, a rebase, or a fast-forward?
> > >
> > > Sure, that works; in fact, that's much better than my suggestion.  I like it.
>
> I like this one too.
>
> In a perfect world, I'd have had `git pull` be the user facing command
> that does one of: fetch only, fetch-and-fast-forward, fetch-and-rebase,
> or fetch-and-merge.  (Obviously one can achieve the fetch-only by
> running `git fetch`, but `git fetch` is a plumbing command.)
>
> In that same perfect world, the default probably would have been
> fetch only, but fetch-and-fast-forward (or fail if not fast-forward-able)
> seems like an OK default as well. But we have to deal with the
> imperfect world we have. This seems like an OK way to do that.

In the slightly more perfect word I'm aiming for those two modes could
be achieved with the pull.mode configuration:

* "pull.mode=none" would be the same as "fetch only"
* "pull.mode=ff-only" would be the same as "fetch-and-fast-forward"

But first this configuration has to actually be introduced. It didn't
happen in 2014, maybe it will happen this time. Who knows.

Cheers.

-- 
Felipe Contreras

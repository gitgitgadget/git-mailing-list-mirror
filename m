Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2CC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 05:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D69222D58
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 05:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgLEFoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 00:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgLEFop (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 00:44:45 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A0FC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 21:44:04 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id u19so8091611edx.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 21:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DQiSmFwWat1g0JW1qJ3B4Wc9AdSFer3UGXa7VXC8smQ=;
        b=afuKiZ4TXCGilv+HNLvYMFIslpeogbpVyxeVAAvLgBpCuF4UJKo9yRcB5dHLDjYIPX
         1cikiaFmMRGsJAgq0ccrUxEYMToMSRk8nHBWX2Y0Qvgu8GiKehdLrwoaP61/a9fuPJJn
         TgEtUUn4NUTF0AOF41JkJiIIHRQzWFGctAsOMmWu/bhvK4aHu/h1WSgkOVmgI8xmGndz
         zoz1YOaFoWKRzyPJ88VT696VZUita33I8QY5Uyz5zEk1YQCOUb1ozir3v8Q8KTHh/ClK
         YBTCnGnVJN7ndMQw4EuWo2Yun6ZVqSdjzSsE7PuF5YgKTdc7emgK1hv8+5JRs+XMPq7e
         +VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DQiSmFwWat1g0JW1qJ3B4Wc9AdSFer3UGXa7VXC8smQ=;
        b=Rhs0VoAOGTfiDyS/JZ4gFdwak9DwgPXYnJWezgO9kJGr4qMXWf7Tx4kSIA5cHlzEyR
         01duipdWGK5XkKYSVNyTYylLk+i8uQfhn/bM7Pvc7rEZpoLScHa2+ocoOqYrfKpAcgCA
         9bVmKpHd7fcFGIusRZFYQNalZzz1E0RJb+dx7RGGbK+AFirXUMlfXiDag+1oOUOBLo04
         F4GZo5NQOlpTfNrgEc5G05cVvaRbbzPjutvQMa/ry4DcXuiXu9AGPcsmPIOQLC9J7FS7
         tY6W0YRlX9qve/e7rIVwKADJmPDiGelY/ZhG0BKQDX9Z87thFouTquz/OaUYO/4OyBme
         AItA==
X-Gm-Message-State: AOAM531cFD0nnCb2+l1Rfrq4vWq0dJdm7IEXWzlRJZ38fRIGGAkXkRVO
        2jwVkgi3T9CitVoFP/NO3GLAnuciBGmwYLbAUek=
X-Google-Smtp-Source: ABdhPJwrFbrTmJxUbc2cSfXn3AWkFstgCgAnIf8oCN2TskEOkltGVCL4GyPtQMxr0LQmnZ7ZE0r/zvXcjiEs5QnL6kY=
X-Received: by 2002:a50:99cb:: with SMTP id n11mr10653955edb.362.1607147043763;
 Fri, 04 Dec 2020 21:44:03 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201205013918.18981-3-avarab@gmail.com>
In-Reply-To: <20201205013918.18981-3-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 06:43:52 +0100
Message-ID: <CAP8UFD2mYqJA5g+y0Q_48VQ7iCe7xVOkCkN77AdV9T6CBv50kA@mail.gmail.com>
Subject: Re: [PATCH 2/5] pretty format %(trailers): avoid needless repetition
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change the documentation for the various %(trailers) options so it
> isn't repeating part of the documentation for "only" about how boolean
> values are handled. Instead let's split the description of that into
> general documentation at the top.

Great!

> It then suffices to refer to it by listing the options as
> "opt[=3Dbool]". I'm also changing it to "[=3Dbool]" from "[=3Dval]".

Nice! I wonder if "[=3D<bool>]" or "[=3D<BOOL>]" might be even better as
we use "=3D<K>" for key and "=3D<SEP>" for separator.

> It took
> me a couple of readings to realize that while to realize that these
> options were referring back to the "only" option's treatment of
> boolean values. Let's try to make this more explicit.

Yeah, it's definitely an improvement.

> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -252,7 +252,14 @@ endif::git-rev-list[]
>                           interpreted by
>                           linkgit:git-interpret-trailers[1]. The
>                           `trailers` string may be followed by a colon
> -                         and zero or more comma-separated options:
> +                         and zero or more comma-separated options.
> ++
> +The boolean options accept an optional value. The values `true`,

Maybe: s/an optional value./an optional value `[=3D<BOOL>]`./

> +`false`, `on`, `off` etc. are all accepted. See the "boolean"
> +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> +option is given with no value it's enabled.

s/value it's enabled/value, it's enabled/

> +If any option is provided multiple times the last occurance wins.

It might be better to have this sentence before the above paragraph
about boolean options, as it's more general.

Thanks,
Christian.

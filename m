Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFBC48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801D261C32
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 21:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhF0Vzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 17:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhF0Vzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 17:55:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FDC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:53:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m14so22511233edp.9
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oknruhC4QQ2vaTA2Sk4qIaioRTISCiTMfzDcQWHHK54=;
        b=OoPy0UEUPHwfBvNJSb1+t0SDZZWf+n8iag0zYs0FMhswDbYYOKI/XswVaIWl5dlcoA
         DlMVISu6XuJvO+JOTwJqB/dEgpPI2K4HFZ/6yR/xJOS2yV98+bPRKwYGaxkEhxv20qqQ
         kJfRv2tUTi4zsBS/1bVmlMMNAq/Umd+pGje8eYofCpdtqOatp7qVY7fKMqYn9A8Wo68U
         CP7SzFkrPTH1mUPdlxzY7dViLXSAwphVH1h9sot9/ivyv14Nf4P+c/zRCOgQmSIG55YN
         Ya1jaWzpP1fEKpXx7CO6v++EXe4dfzJaYyzdPvyV2Sp/Rfh6WgTXMTh0JsMLsp6sTFxU
         mIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oknruhC4QQ2vaTA2Sk4qIaioRTISCiTMfzDcQWHHK54=;
        b=eSzD7KPMFCoSnWONPh36cwY6AAHorCF2G2i3zX48pfnKBd9ckJvsVLmPMnKpqoTvB6
         BXvhkXMA1lnR7TEhk46uwIPGRusgJJpC5yw10LbeVQn7YObhuImlOve7q0yZVV0Ijv/j
         cmhEjDzRCj4G8jkNhhYg8IbSribKNcpp3/+fL/aGATXFWuJwAZKl6eNsjE1d2p/9UdzQ
         YQhUObY5a+mi8vcrOoCs0+gPCQRGSFmmQFNZWV/URiDl3eUqpoF8NLBv+qJFVZF4BFYw
         wGadLS7VoqORsiziJ5VbYvTkbU4ZPSDieQ+m2MZCwqSXrHAwf2omiIxfA0Y/0xsvbiPL
         kcag==
X-Gm-Message-State: AOAM533D5+7/I9ttNtqEfH5/1V2YtmI5pc5o6Qi+KD+ZRgjIdss7nb41
        6REXCya5jj6qjaKyvegWGlWbaWm2bC2/TgA8m4E=
X-Google-Smtp-Source: ABdhPJz1YqpGbPG545htILP7HU52xKlubVjXZaF0k4XVHyxwk1Ji0rK0BW1hwN1p7zepua4qaRto+RqPB1YchRX6doI=
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr28791323edd.387.1624830790784;
 Sun, 27 Jun 2021 14:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TLhL3MNnkB7s1J4hAQmovaUPoeydn8kepzFOT_UL83_Q@mail.gmail.com>
In-Reply-To: <CAOLTT8TLhL3MNnkB7s1J4hAQmovaUPoeydn8kepzFOT_UL83_Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 27 Jun 2021 23:52:59 +0200
Message-ID: <CAP8UFD0dDeL6crqqXPRd+564Z8n_EX3ctzRxKyGZFBp2SjbXEQ@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 6
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 27, 2021 at 2:43 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My sixth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-6/

Great!

[...]

> Now the performance of `cat-file --batch` is almost half of the
> previous performance of it,
> because of the complex logic in `ref-filter`. So I am thinking, how
> can I find the performance
> bottleneck in `ref-filter` and optimize it?
>
> So I try to find and use performance testing tools to analyze the
> time-consuming steps of
> `git cat-file --batch`.

Yeah, that's the right thing to do at this point!

> * Using Google's `gperftools`:

[...]

> Ignore `write`, `inflate` and `000055d9164cdc36`, the execution time of `memcmp`
> and `memmove` is very large.
>
> However, whether it is `git cat-file` before or after re-using the
> `ref-filter` logic,
> the functions they call take up similar proportions of time.

Yeah, it's not clear what is causing performance issues from this. It
may be that the issue is that with the ref-filter code more objects
need to be fully read. I wonder if there is a way to count that.

> * Using `perf`:
> `perf top -p <git-pid>`
>
> ```
> 12.72% libc-2.33.so [.] __memmove_avx_unaligned_erms
> 7.39% libz.so.1.2.11 [.] inflate
> 5.56% libz.so.1.2.11 [.] 0x00000000000088ba
> 5.27% libz.so.1.2.11 [.] adler32_z
> 3.46% git [.] patch_delta
> ```
> We can see that `memmove` is still the part that accounts for the
> largest proportion of time.

Yeah. Do you think that the code is calling memmove directly or
through another function? And anyway which part of the code is
responsible for these calls?

Flame graphs (http://www.brendangregg.com/flamegraphs.html) might help
get a better idea of what happens.

> We can already come to a conclusion: A lot of the time of `cat-file
> --batch` is used for data copy,
> this may be the focus of our later performance optimization.

Thanks!

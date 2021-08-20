Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED7EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6537B61057
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 16:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhHTQXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHTQXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 12:23:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF75C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:22:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gr13so21333680ejb.6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9m1f3NNO+2e07DI6+xy6WMbrFsDI0q1EIvNvFy7eEdU=;
        b=HDu/ogOHMaHFQw7QHr6d4jN9+oe0q2exIA13X/isJdn3qF2O56Yts+eUzLQ8kwZFaB
         KIZ+FSxnk47dbTGd4DXXzr7gopxM/IoWe4792VSYUchsYBqTySbEsF2+vhrH+JjIJkkT
         zjCmQ3K2BQQ72ylSxJFFYAysF+RoLYjJWNRcRUbwuv9fKjwXlyKdLl6/lZwXD7CxMYE1
         SRONVKPjKbH80TOmCfgTlxUrYi1cgdiHMhvRV/yUDS1t6NroDEZIrXmBP5qWnIQwW7Nv
         /VfYa05RuB0uJXi2B8URCu6duW9c559SyETUv3VIk+fGu/jzC++3A1ASniDVa9BGXXCZ
         JY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9m1f3NNO+2e07DI6+xy6WMbrFsDI0q1EIvNvFy7eEdU=;
        b=QZznXmFqinOXhTHPYZJzYVKYJNcnwAQJ03rq6/BL8ZIV/cq+n0vEs1mMZQrExuNOes
         u0vvpDr0zg0Sd/doZu8LrJ4Q5MyVCd0UuU2nPUX9gfUz6dBsgYON9d6BaSy1jXUlGITS
         AWEYdjuhl6PDGw1UV8GAvM9ihOAidzlMCsNSeCUV/cRI18p3od1PjI7/FHoUz2lLuw2c
         An5nsRMivbyqGtBLsPxX2k8ZpEntfzM5rLro0q6X6+NU9zqw8y/2RJ6BBoHyOCRuTIxP
         g5xXvWTrWHrzBZ81AH0zWj4bUTiat85+wPsf6kVFSjH0YVJ7kl0YWQ9R9HDIYp540GVQ
         kXLw==
X-Gm-Message-State: AOAM533T5OvNl944kR+CIaCtomp9vSWxqE2aZ8MHbZA9V3LTgcu4Vex7
        Rdfe5DGzqOUVYuHMTOrzgHfTFv1Ijirom6wyc+w=
X-Google-Smtp-Source: ABdhPJyh4BwGnN9JD3xsTJeTKa6NNKTzlTOAfF8mLxXt8NS4Yi9wAFQ1W2iVm89a87SDor1CViz0J00L6rPV+9u6EAQ=
X-Received: by 2002:a17:906:f8c7:: with SMTP id lh7mr18392474ejb.211.1629476559385;
 Fri, 20 Aug 2021 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
In-Reply-To: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 20 Aug 2021 18:22:27 +0200
Message-ID: <CAP8UFD0sbcJdrXYnumjHwzth150oEvW_uP9jgiR0NM0tn4Eu4A@mail.gmail.com>
Subject: Re: [GSoC] Git Final Blog
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 7:39 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My final week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Final-Blog/

Great, thanks!

> ## Git Final Blog

[...]

> ### Concluding remarks
>
> This summer vacation, I have gained a lot, also made a lot of friends.
>
> Thanks to Google and Git.
>
> Thanks to those people who have helped me!
>
> Thanks to my two mentors Christian and Hariom.

Thanks for all the work you did, and for your enthusiasm, dedication
and involvement with the mailing list!

> Three months ago, at the beginning of GSoC, I cited the example
> of Junio's interview:
> [[GSoC] Hello Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com/).
> As an echo, I will maintain a passion for open source and technology,
> and continue to participate in the development and maintenance of the
> Git community.

Great! We are looking forward to continuing to work with you!

Best,
Christian.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034F7C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72616135F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhHWPnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhHWPnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 11:43:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5470AC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 08:42:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lc21so5529254ejc.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qgjiO1IUFmdlrCvWHUJQSYhzVaRcO/reqhKRBXXqGaw=;
        b=LzDivpGuOPpaoGTFdLfX1BqtSx7+OeEcihfVrfxVs1MV5B7Xtl/b23yHQ/Bpe0Dajh
         OTiptf/QjdSIN6eFuSZfMe51saElY8U2jJMeVqqMq2sH+p14fZDPtMsGBHgDlrsqndXg
         CBewwMGeURu8bjsm3bSTslgpNTBtBF55egmXrE/JBP5MLjS6ybbx3vIAemPHcJkhB0hQ
         E1uA+J2mX2A1biler07WpXJ9xq3Fi6bWCjJ5vVe8wPZ00VDHqOhuZOeKgSqONUQ2cePm
         3JMs0Iza9hxYKuZXp0bKK6WBLHnadIcfa5ooOX3lZZ/H8tqUVd+rWNXBM3tV3V33Hcmr
         O3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qgjiO1IUFmdlrCvWHUJQSYhzVaRcO/reqhKRBXXqGaw=;
        b=oiX9nJIXXr0ZUbK7QLtLnX/w4Uoqb73uryffRhxQ9EZo2681+argpf74onaRXjLn01
         EywygBmjizuvyUUiAylhfgTAf6NjQ3SR7cf4uj+QfIdpLX/1JyFgi8ee+4gBDR0/nllL
         Iy3bECxrP6nfZs+T93Gzo4Ggc8qiuwfTh6xFMBE5yYa8fBUq53hr2fQ7liNxRN43WKP+
         ue1rAnYTfrXmPlKzVH0WfXbjxshP/J68G2dKRr/3BnAatN2NHAx06x4oFc1PJr/kj5jv
         RpWImfQNjIqGDPM1OipZ3p2ydBlUP0tFYXdwkrLft+fg1kqGOYzKALBt8z5vfUXw0a9L
         ltOA==
X-Gm-Message-State: AOAM533BWrYz49n5z7aRiXNI8mRMucStZBVzHX4YcezaeccGioKk9yeV
        5Gr8HTLNrs/jZbleLaKv+6bjgLwjAr8qE0ZW0ZM=
X-Google-Smtp-Source: ABdhPJyomuNYHeksQcqz5jxJPTB1ZXEqjLeQrcwO1r2tfgGbvK6jplXaFw5Dfc6dqa1YYE8HQN6naj1BnssZK/OVBsk=
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr3170208ejc.211.1629733375941;
 Mon, 23 Aug 2021 08:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <m2lf4wys5o.fsf@gmail.com>
In-Reply-To: <m2lf4wys5o.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Aug 2021 17:42:44 +0200
Message-ID: <CAP8UFD3J-ODOAYDX9GLUUF=V81Kz99CdFQuQ9uF0B_sVYCU40w@mail.gmail.com>
Subject: Re: [GSoC] The Final Git Dev Blog(s)
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On Fri, Aug 20, 2021 at 6:53 PM Atharva Raykar <raykar.ath@gmail.com> wrote=
:
>
> Hello Git Developers,
>
> This is my last week with Git under the Google Summer of Code banner.
> This week's update will be different from usual, as I have split it into
> two separate posts.
>
> These are:
>
> 1. The Technical Report: https://atharvaraykar.me/gitnotes/final-report

[...]

> 2. Reflections on Working With the Git Community:
>    https://atharvaraykar.me/gitnotes/final-reflection

[...]

Great posts, thanks!

> This won't be the last time you will see me on the list, of course. I
> still have patches waiting to make it to the list, and other work
> undergoing review=E2=80=94the only difference now is that it won't be und=
er the
> GSoC banner anymore.

We are looking forward to it!

> ### Concluding remarks
>
> This summer vacation, I have gained a lot, also made a lot of friends.
>
> Thanks to Google and Git.
>
> Thanks to those people who have helped me!

Thanks for all the work you did, and for your enthusiasm, dedication
and involvement with the community!

Best,
Christian.

(Sorry for the late answer due to a vacation.)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8BC4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 14:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEB3610A7
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 14:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhHAOAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHAOAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 10:00:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0683C06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 07:00:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so16668017pll.1
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=kcB22H88ouN1Q/2sRBGdeCpIFkbW5s6xeX4vd0dpCfY=;
        b=UZju8B9HL3UXaWv2+ENDOoY/H0r9PzMxrLfTUcqtGBGVxjqv9DtaQRbSdRxaBAN4aP
         gMQw8UYloi0HUUfcWuQ8+12G94TMrL0E9ddnrUMUTCKZR+o7RQAHa7h6QNq96Nf2B1vL
         X3J27mlX2PMsR2HKMa0tSSLAekj81+REc+DKD8UQJp7Gms72imGE+f/kv6unCol1/yeU
         dPA0+RLj7fITmkh93hMxe9QO3DR1Ku2pH/HIl2kzXOK+yxFipsAt2s00FClJwn+dvzxi
         4NnuSDE6OwP9rbTZeyULXp8XV2QUd0Lv+sEYJhtH8AqqlmrmPW8tHprYbNy3wTf2Swog
         DiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=kcB22H88ouN1Q/2sRBGdeCpIFkbW5s6xeX4vd0dpCfY=;
        b=GAfddKqhVrHac7swvL1yDbm5aQkRFOFB3+iooKFkEUlDGT41LvMmLhQ0UGRsrGsHVs
         7vEYB5f/KYPRRow5kR4Yxc5Du1sphqFqtrK9xatEHeBNvgB7N6gFHapYkkRbHXtw9384
         VbaVxq1TZztVr0VUsAusmCRd7j43JE5OkN2pKDsWiZSAqXQT8jIfbyxYMPk2t1b0nTg/
         xFRvU3jBagyHY7SKHis+stU4BgQRIff50GIrUdFvf/b30cfzY47il1H+ScXAWUHYPmwh
         /vaCMmoSp4wagz8NDo1GU6Ix1iMVprVCsaR+6U/gz/8CfwgbSVS1o9cRnJJV67MpsVuR
         1+Wg==
X-Gm-Message-State: AOAM532cItfLe1SML8Sg+I/VhNh4/q4pkFjsGMwTnazold1oD5TT7qmJ
        QNQPXY3KM8gkF/loUaimxr4=
X-Google-Smtp-Source: ABdhPJxSVFX92kHhih8ykdNE7tEkfCcZf911BHQUF6Qj8GbLYD8zj6u3TL4Q/uNXZz7El3nK3P0mpQ==
X-Received: by 2002:a63:f154:: with SMTP id o20mr8611863pgk.172.1627826437401;
        Sun, 01 Aug 2021 07:00:37 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id u19sm8125550pfi.4.2021.08.01.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 07:00:37 -0700 (PDT)
References: <m2lf5lxog6.fsf@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week 11
In-reply-to: <m2lf5lxog6.fsf@gmail.com>
Message-ID: <m2k0l5xo1q.fsf@gmail.com>
Date:   Sun, 01 Aug 2021 19:30:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Welp. I forgot the actual link to the blog.

Here it is:
https://atharvaraykar.me/gitnotes/week11

Atharva Raykar <raykar.ath@gmail.com> writes:

> (Resent this email, because it bounced off the list again. My=20
> new config is
> still a bit janky, so bear with me.)
>
> Hi all,
>
> Here=E2=80=99s my weekly Git Blog.
>
> Preview:
>
> - Project progress: where I discuss a rough plan for making =E2=80=99git=
=20
> submodule=E2=80=99 a
>   true builtin.
>
> - Reflections: A summary of last week=E2=80=99s survey answers [1][2],=20
> and an
>   explanation of my own slightly weird email setup that was=20
>   borne out of the
>   troubles I had in the last week.
>
> [1]=20
> <https://lore.kernel.org/git/90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.c=
om/>
> [2]=20
> <https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-work=
flow>
>
> Have a great week!
> ---
> Atharva Raykar
> =E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
> =E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0

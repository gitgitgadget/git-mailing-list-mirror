Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66794C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444330AbiEFVHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378271AbiEFVHt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:07:49 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB85B6EC75
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:04:04 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id t12so4152699vkt.5
        for <git@vger.kernel.org>; Fri, 06 May 2022 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3SKNH+5ZlngRjA1jHoCn8KK2BFeQSbLagDXg393kwE=;
        b=MaZvHxiz7+m1Ve5Z3oXwEQlpPQtngkclIs2aomg1TCyjw66Gt6YXkdOUXRFzKKVLSF
         91RUYxdV0WAoei6Ec+93rooi00GOu1wbYNencE6qsYaLXcaJRv3D+pSY/o9kyWB6ti3l
         InNrEqDZe5DA6a029BYRlB3cCWdv8D2bH8B7X1iw2kBfBFQZrowgZoe39dD6CjvynEVC
         PrDAL6FEZI2D1ix1RZ+CusC6DEUZd0KSbh1IrE88zGIKl27j1PAoW2CoIaCrnsKAU7Cd
         bHR5zj3zS+d7TAEbaoeLAS4A+Ad81/PkJwP/0jtN9VO6REqx56p+VS/0drFExwcSzFjq
         WBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3SKNH+5ZlngRjA1jHoCn8KK2BFeQSbLagDXg393kwE=;
        b=BcBvG4qwO0F2M/kNcWv92wukfFJBczSyUQZ19RRZXCID/34qWAfBTbTnHzYn7x9ZJ3
         vtoSAjPT+KsAVSR/6DamXUKO97fVNyFivheINvF9Kx2urlqE+FL/iv/pc8S9zj6q1CM2
         NWnaZutqhz+NkmA7IRqLZkeg06LNdIW8dpv9e0ABgzL+d2CAyMnkAEgILkgT4t4rqhq1
         xcYK5dvQkiOhz7wdbSuAPalL0+8WQBQiIh2iHa3s1PHPOl31r12K/r55htGBjEkBTzpL
         WskS1iWrEBjab78BhJPQp72C6M5+ehcppSiAhrCp04Hmet5A+ouNoata3l1X5Y4wSOTI
         GlOw==
X-Gm-Message-State: AOAM532xyBsOKGQf/DAt3H6FV6spvnoMJb5cGhuNUCqrzpCJW1eGEqSB
        iIYy58Qg4A/w6tU7y1fik2NF1+rsLdgSGSycJeE=
X-Google-Smtp-Source: ABdhPJxvSfT69N6LbvBQOpO3JVR16Rb34HS1Kfbkng5aKvbkS7jqBFVQ2SWe4P8NUi7UnuNRHNRtnnQWe9RufMxyMtw=
X-Received: by 2002:ac5:c856:0:b0:34e:d0b4:7a10 with SMTP id
 g22-20020ac5c856000000b0034ed0b47a10mr1925118vkm.39.1651871043782; Fri, 06
 May 2022 14:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
 <xmqqlevfesnu.fsf@gitster.g> <xmqqczgrdb0j.fsf@gitster.g>
In-Reply-To: <xmqqczgrdb0j.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 14:03:49 -0700
Message-ID: <CAPUEspjugusSzuLJkuHdN-TsfVpqcyAGnTaKEGu9qtwUAghwmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 12:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> So I am not so optimistic that we
> can invent a GIT_TEST_* knob as good as ASSUME_DIFFERENT_OWNER for
> that.

the only option I can think of (if the pain point is running git
through sudo is just too cumbersome) AND we don't want to weaken our
implementation by allowing the SUDO_UID escape hatch to non-root would
be to still use sudo to change the ownership of the git binaries we
are testing with to root and SUID them.

but at that point we are likely to deal with similar platform specific
issues for why running git as root is still problematic regardless,
and for whatever reason I feel even more compelled to ever run that
script in my workstation since at least with the current
implementation I know exactly which commands are running as root.  It
also makes this functionality slightly more dangerous since it will be
included as part of the production binaries as you pointed out.

My hope to broaden its visibility was to instead (since this was
mainly meant to be a CI only test as explained[1] originally) was to
add to our CI setup ways to fix the agents sudoers configuration to
fit what we need, but I won't do that now, and will probably wait for
a while until the on the fly CI changes settle.

Carlo

[1] https://lore.kernel.org/git/CAPUEspitAQrEjMpUyw8e2pyT1MT+h_dO5wSU0wWDWTqSye5TwA@mail.gmail.com/

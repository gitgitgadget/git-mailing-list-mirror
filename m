Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24778C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 15:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbiBQPIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:08:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiBQPIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 10:08:14 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08325BD41
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:07:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bn33so8813718ljb.6
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDoiiY2APBvJqcTateHWa/85aXJojXWjdRCIFGw1knY=;
        b=i06gdT2TBVEaSndn2Mn9uyOAHTih/EFehFn4No2/AowTKnPTs/cqeHfRO9bB/OX11y
         n6uuk/BvAkPvkgIolPFBNbLBTaRxqQ3ITUvYuGDH9JKNQkvMCHjnvsfTyRph3vzxImTF
         A5ilTSn4NS/eKEY5uveKOJUFer2YvV7GmE0MQsIDzbq6MPeY3pd4QAclVyl7a0ss5/xt
         2vZxR3xsq9403yCstuMM5ljGHDNtYgCBAjhdSo/aZGo3ZtfYUBEkkNDk3qJLwrcuDTnN
         QZv7K2DXL7Yz1+IJLthS6rKT3SAvmEIqPRqFczsL55cf69Ul1VOvamdIlgR8QtSQOzh+
         +Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDoiiY2APBvJqcTateHWa/85aXJojXWjdRCIFGw1knY=;
        b=ecYfKaOuORBCTis4rGhlm1Cl+zQ/65/SyrCEGfCnMM1WR+huRtxgaoIXU4GvaNIkkq
         CgCDTNBY3ykFERqKaBIAHklUxbpLO2KYIRqtlKcry7pGBNWMfVvZWJ+HoqZIlh2lEh9U
         0S/bfkyVO8ym8aWeqDnYjLAVkhsyk92ONeWmk3Ybua/ytfb/+tV/rjoCPKH20fMgOvXA
         XAFOY4EtWWNVG+ybwKye2GN6sxJ6lH9DcAXz3EoMkak1pGPgCMC/83z3gtqYnMCu6e5E
         5kKKSKJfvH5kGbqB0A1gyRSEgjcRML7f8/ObBy0bxc8mVV0HimwkgFIVofX0z5Nry1/z
         R+ag==
X-Gm-Message-State: AOAM530vvCaXYa0BBpi1+Rw2l6ViJbbVlwWQyANqgEIlJPp4jvoErW1L
        /b7MXfVRzjExkXbaqYZiXyx5+upNkVjFGKHuXeV+7RnL
X-Google-Smtp-Source: ABdhPJyL8Ywf5/CZnjxjiPVwXTCdaZwJPlUbd7xLdyDu3ZlnQziPDAY0ptwvNI5ZSnmztcae4EsA7wdAmFZqP8WvTGw=
X-Received: by 2002:a05:651c:a0f:b0:244:bb80:1302 with SMTP id
 k15-20020a05651c0a0f00b00244bb801302mr2552389ljq.473.1645110477763; Thu, 17
 Feb 2022 07:07:57 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
 <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com> <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com>
In-Reply-To: <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 17 Feb 2022 20:37:45 +0530
Message-ID: <CA+CkUQ-qweJXpR-mAApMd2-w13uiNMZM4_+=NufYaTsOUjGUqQ@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 9:10 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> > > I added the "Unify ref-filter formats with other pretty formats" to
> > > continue Hariom Verma's work during GSoC 2020. I would be happy to
> > > co-mentor it if someone is interested to co-mentor it with me.
> >
> > Since I worked on this for quite some time. I maybe am able to provide
> > some insights. If it's not too late, I would like to co-mentor it with
> > you.
>
> Great! I am happy to co-mentor it with you!
>

Thanks.

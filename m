Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEEC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 02:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiBRCOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:14:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiBRCOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 21:14:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C925B2D2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 18:14:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f37so2633067lfv.8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 18:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFuWKGvyxK2cIygi9PT/o5v6AtSyihqPgKvgrlZtBUc=;
        b=URCbtzGD1ykeLRAYheKb4bVQluQXCBTXJhrrUlUDPHSVWeWE/i3BDAuiLJrcTMvcH0
         KFqb9fnh7eUsY9VH1mSFB9b/QoPlRrSK4jpe7Bs01MAe7geWplSbcYMmj8jw6bZJTYIP
         7nzcDeGAZ8TFzhEN5LO/lmkwhHHm/8WdETe0A2kA7lM0KjUBVwa5EBcyi5i8oGITwjq1
         pxDGw5d2sZGDy+jSsW9CqL7fZSvLZxp3qflTHC+Ypkl1geHF+ngzJBlU5+n55TzhvQ7B
         3HIkFXkOg9S4y7rcuPHLVUq2zTTMst5XbyUpDTIDXG1XoUu/fC9x5XFvkxVv7jLDE+OH
         H48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFuWKGvyxK2cIygi9PT/o5v6AtSyihqPgKvgrlZtBUc=;
        b=DC98AvrHP57p/khIeRCkoIYLep+H+9OMKKm11FW5EjVYPzRZo2P6ai1WpwzB189Esb
         EZ76F+y6dkHYMa1ymGK4skTJ/hK5JIUshcOpeDLcQCkJ9vCMViiQqnzNgOL/EV8qmlIg
         /Kjx4Wl2A+l0a52mc1blpW3vxwt504i0hIfcOlJUcaoyyas8/Jz9YCKK2wQkc6UHMKS6
         9ikQjq3Xp3t8HJSMgeiOyRMFAVM6j3fVMsWxECExpBG5PZQDBvLQNaCGWHTpXkkeqIMd
         p8nbWxY3i2QT9ZYi3g9eLWdqZ9+WBT7jkaJxux77ZCjJT7go4Vt1kUTrWBDBlUFrbt/X
         +wHA==
X-Gm-Message-State: AOAM533dMG7lL9g3z2kCZ91niZ7lypWTE+qvnk3zq2LcqBG/gYM8fpK0
        6dIbIuhtKuxELNd+0Zins1lgpTl7YCTec2iLUI4=
X-Google-Smtp-Source: ABdhPJxezzflzo79JfPm0M+1/Ugca9Q4Prv0eWGwru/R+QZ6s914X+MkipTCt7+ONgTJFkEn1cquIiCkAE8XU3NI1a8=
X-Received: by 2002:ac2:4f8d:0:b0:432:75c6:c8d0 with SMTP id
 z13-20020ac24f8d000000b0043275c6c8d0mr3967358lfs.90.1645150469157; Thu, 17
 Feb 2022 18:14:29 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <YfGpjm8mCkWIPM6V@nand.local> <CAP8UFD1Mqv=MUcdjjhTpOkP0yWpnv9Jr=aB5G+4XmAqWsJBX4g@mail.gmail.com>
 <CAP8UFD2FfJA1ruhxzv3tcxhsssHBeHGCbGFDiz+-fFmpx39Gqg@mail.gmail.com>
 <CA+CkUQ9VTs7n9B+ApH1BYC=Uq4yvrZm0fsG0RJB8PVg_BBSCfw@mail.gmail.com>
 <CAP8UFD0cNLUSbiABnj3UTrAk36DTePNctNWn8U3wrXMGjA6HFg@mail.gmail.com> <0a29bbcf-5c36-3884-96c6-60f9b930ce5f@gmail.com>
In-Reply-To: <0a29bbcf-5c36-3884-96c6-60f9b930ce5f@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 18 Feb 2022 07:44:17 +0530
Message-ID: <CA+CkUQ8=uMbzhJ2-mqss17PakJBuqjqpxCXetdZmd+Nd6F41UQ@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 10:48 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Yeah. That's great! Hariom, would you mind opening a PR to mention yourself
> as a mentor in SoC-2022-Ideas.md [1] ?
>

Yeah, sure. Done.
(https://github.com/git/git.github.io/pull/559)

Thanks
Hariom

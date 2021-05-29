Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5924C47090
	for <git@archiver.kernel.org>; Sat, 29 May 2021 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A708D61163
	for <git@archiver.kernel.org>; Sat, 29 May 2021 18:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhE2SfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 14:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhE2SfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 14:35:07 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D3C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 11:33:29 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f1so4066678uaj.10
        for <git@vger.kernel.org>; Sat, 29 May 2021 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jv2Sy8rkEAtSrwSPn+JJOUL7n3paBoE04T55jTcJaWY=;
        b=V85panosXXsK0pRmpE+xDY6vHD/G5FUXYy98GnFu3vGsZL7793t7yLga7Y7voKNTZF
         xUNq1PyHx4U84cti/G2vOFd8fw9MmpnUebzkiSbczQ9IDi/i8ZkRDFAyAB+lSZ067npg
         At8CotkoajotdEMjPG/cuQyER+wpHBdVJd9ptiUGwFfoCOdAL+irvugVjCwjl2UXiPT5
         oa1NsCexzZCUU6feEgCvqiOlfAdcjhBH22hF49IcBYUV8nZVKbgjobWnNw2N109/YvLU
         VSCz+ZFYHFFvlNdA81kmVQMluyyryP4nQL2nRTMa3dTFQXrIgEAnSwWkihvrcpDNgARl
         SZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jv2Sy8rkEAtSrwSPn+JJOUL7n3paBoE04T55jTcJaWY=;
        b=BVilvyhQ5OLstPOVQ67y3EqdZDqqfZ3q/dVofIKTfpSTKb1ScT9oH0CkmRiqrGy1ml
         dkIY00PJF7lAg5d39hPRpB1hbUofIPyHFv9mPScMWH/ArFs6Vs5pDsCYUUQKOA7RwzSK
         zVDP0oQdrcIeIT5/hPMKMmk8RzjdZih8g2kw7lPTeEXLProdudNdW5BGw6/LgAhjrnvr
         xCQNCdY8e6znNbZYiV18tBNmZ5WaHPQZRVBsNRMatNQx9t4yL2Z41UnsmDR9ld5woMUw
         8EouHuqJs4ccqF9fbudZhSAYUJVZ0+A6XAHfSHV5VHM51Gow4VDi56NeChZgMA+TJ72I
         DuiQ==
X-Gm-Message-State: AOAM532JDDGTCIeU5peqFtEgFqc185YTepJjZV5pnUijxT5LYvMOqzlH
        bCnt6nRtvsJsJWp58NRP38WVC6XP8+myaCPAruA=
X-Google-Smtp-Source: ABdhPJxgkTEOEfaXRzM6TvqL+ZpYYlOHyOR1RALmon7f8RVxgnnIyLNHlVkopQK2Oh6j9hiwfizOiOS9p5lcUenKOk4=
X-Received: by 2002:a9f:2c84:: with SMTP id w4mr7149883uaj.99.1622313207960;
 Sat, 29 May 2021 11:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com> <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
In-Reply-To: <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 30 May 2021 00:03:15 +0530
Message-ID: <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Matt Rogers <mattr94@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 9:55 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> On 29/05/2021 16:49, Matt Rogers wrote:
> > I have some experience at my job with CMake, but some quick testing
> > has found that adding a check like:
> >
> > message("MSVC = ${MSVC} , WIN32 = ${WIN32})
> >
> > shows that the MSVC is uninitialized and WIN322 is initialized.  so the
> > issue is that the MSVC variable isn't being set which is causing
> > vcpkg_install.bat to not run, rather than the WIN32 variable.
>
> Thanks for confirming what I'm seeing. It's good to have.
> >
> > The msvc variable is intended to be set whenever the compiler is a Visual C/C++
> > compiler [1].  And it seems like visual studio should be setting that itself
> > either via a toolchain or some other mechanism.
>

CMake sets this variable.
Please see {CMAKE_INSTALLATION}/share/cmake-<version>/modules/Platform/Windows-MSVC.cmake.
This happens after CMake is required to find a compiler.
This happens in line:93 where we enable the C language.

To fix this I would suggest to change line:53

-  if(MSVC AND NOT EXISTS ${VCPKG_DIR})
+ if(CMAKE_GENERATOR MATCHES "Visual Studio" AND NOT EXISTS ${VCPKG_DIR})

and
add CMakeSettings.json to force Visual Studio to use MSBuild.
Please see https://docs.microsoft.com/en-us/cpp/build/cmakesettings-reference?view=msvc-160



Thank You,
Sibi Siddharthan

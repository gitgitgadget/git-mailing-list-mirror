Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE7FC4346E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE52206B7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evU6kpKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgI2GvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgI2GvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 02:51:21 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D94C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:51:19 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so1759361qvb.12
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDBb6Hib4kOp2q3S6AelPZfWivjUrGCtAD/yJixiMxU=;
        b=evU6kpKXfFxDko279MdQklnLKT3oplgj1OYU9TmlBZ/CyZf2TiYJxQDEsq3Mm4sLYK
         Ad63yzyjE2hhP0iH14CMIC6Z10/QPEjtzG1s4KAH5VQtxGYOx+1NtK2PBNiRFBJHH1QJ
         4Ft80m2c+sPVc+OTVsnXDePOW1yHg+4kYHoqgTuJgKRIHVs5r0KB2ISzifMuAG14poW7
         Jp6q0jz+GO9U4YS8c/aVngoEbGTzDXS0+yXhuvuyhM+7K4b0ubofu9SdLU8AgE7zfKaG
         ATCg9CZI8N7SBzz4ho7tFXLOje3O5XUwpgcqLgf/qd7Y+kbKn3w93OUoZu+eQ2b8m2r0
         L+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDBb6Hib4kOp2q3S6AelPZfWivjUrGCtAD/yJixiMxU=;
        b=tvbNBiQBpushUewcWp5Yqs5ynEAvAdBI8Tv1+oMPUEYGmqMPr6w1+iCkv7pITmrQhR
         8yzQCv0o3cS7Nbq95OIfrs2q+Y5MXwd2omNXq9Zje06CVR5fXNOGobEJOwZpCU3J1ms5
         ynLKWVXfO8UfOSK8ixdwmS6SsKeim/i9n+6q4M7DgxvAMgqMJBWzLZEvFKCIl8O9ZfB8
         piwLUONLF2zIOTu8qK+/SKJs92LJbPPJw2VabQ8FjPRmgbhF+0e5G/SUkwPXI/Ho9Tde
         1IdrRNcXnn4MDw0ydiSWLCCfdtsbvsiCWu6/oBDwU/hOwoIGEa3NTuEog+P9kzbVsRcM
         BCWA==
X-Gm-Message-State: AOAM532jx9UIDCJe1yU8JETVRDgRcxBpHmAIYJ6PSMW1/N/+g8kZ+H+I
        XDbekNBKS0y0UFif6fGrlPkFLdej9Yrdpsi6SwWvfYAl
X-Google-Smtp-Source: ABdhPJx2fXHcJvbSY/3x9u/Iia9roMcIYo1rK5Ym1+2XZJhoCCEQxiroJpjfrf3+9gMG/oIqvlc3yC0KEGoiWQdtw/A=
X-Received: by 2002:a0c:9a4e:: with SMTP id q14mr3145891qvd.22.1601362278944;
 Mon, 28 Sep 2020 23:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
 <pull.738.v3.git.1601327357.gitgitgadget@gmail.com> <7c1601c7e351855fd720df05efc44440374792ce.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <7c1601c7e351855fd720df05efc44440374792ce.1601327357.git.gitgitgadget@gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 29 Sep 2020 12:21:07 +0530
Message-ID: <CAKiG+9U2v+HYXU_xGzbAK11fo0zHSR7xGBWPq0=0e2rU-Z5W0g@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] cmake (Windows): initialize vcpkg/build
 dependencies automatically
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  if(WIN32)
>         set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
> +       if(NOT EXISTS ${VCPKG_DIR})
> +               message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
         I think you meant Initializing. (Nitpicking :) )

Thank You,
Sibi Siddharthan

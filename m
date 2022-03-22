Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C2C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiCVUTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiCVUTn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 16:19:43 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FC1261A
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:18:15 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o67so2822833vsc.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiXyMozZvFgerY38aiuy/nnJzBJrM8MeXGKT1Sae+uY=;
        b=pM2WVzgwm0S7F3lvW8kAJZJ9pB7+IY4DF7rClLuunV0ChocbrrwpI5xKAwpzsNqWYS
         AVuBCeelgQv2Up/xTBtcaSpJSUEm9mKpuquBU6rHIugXg/DCsh42NGEYH4zMIv1M7P6R
         0yJlGJf++FpU/dluxw98axldAsKp8XGZD0uEU16BX0bMJ7gBnBQcEhe1/5Fwd3pZcopi
         lxutn8hNKr4mKQihIlFTM+WT5iUGEPn6KRqgKZtVfencipiBLsEi/uWBzR3roGSl/D+u
         pI6wFNRV+Ju2wwsXBirJKLNezS1E1RgcY58h8pF4F/5DrzlOH2r+OKBkL3D8SdVL7Han
         c2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiXyMozZvFgerY38aiuy/nnJzBJrM8MeXGKT1Sae+uY=;
        b=Tg7663JniabSiARJoC14LhDLm1YJjzgViHU3jjAcBQphjrKXEdnDsMRjA7izypb0lN
         e0JEELPYZvmrbmc7NAHw8zpeX8sek2G+nGR/ZwGQmXmeTgrsQEOdfBUGR4/Jg89C3s4O
         BswrwfA7F5XsaIevOyMw9sK1nL686WRnsXPKoMsm909DC7nSlX6ecLPam06rCRMXa+FD
         giZB/ngUbyNQ3MhlvyTx+VAnKMfh1Afw4ByUwBLqMK5rYR0w8PcRAiwiA2d38kdtn4ZX
         GRVBrlgLY4NHWUQVSUf0s3L3+t+FY8/ky6wX75krpudcBBDCqejGaF5ZKqdKd5adoxnA
         AT5w==
X-Gm-Message-State: AOAM531iLptTbDWXodsZ2MvSGa40fbtLIwRhdSUAKuehEPET9Z1WMvVy
        S0ezn3a9Yz9hp5vRZtxNjENWMqfgb2EtNrFGGGo=
X-Google-Smtp-Source: ABdhPJyCN7Uf6FSDd8P/sNAsXHQDO/lKLbPI3uvpinbwxswa6By7DEtBiuw9ytw6AU0Tl+TMEiXfbKIn1q4dSXAxe4Q=
X-Received: by 2002:a67:fe12:0:b0:31b:9356:40fe with SMTP id
 l18-20020a67fe12000000b0031b935640femr9989770vsr.1.1647980294633; Tue, 22 Mar
 2022 13:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
 <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com> <xmqqv8x5s1w3.fsf@gitster.g>
 <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com>
In-Reply-To: <8d44b509-ff19-0629-30f5-ae785c73c3aa@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 22 Mar 2022 13:18:03 -0700
Message-ID: <CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_Mv2wOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] a couple of read_key_without_echo() fixes
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> That sounds good. I've got a couple more patches based on top of these
> which hopefully fix the remaining problems (notably the macos poll()
> bug). I'll polish and post them next week. Once those are in I hope
> we'll be able to enable the builtin "add -p" by default.

As this topic just hit master noticed (I apologize for not doing it
sooner) the macOS problem (tested in 10.15.7) was gone (suspect fixed
with 1/4) and therefore enabling the builtin by default as proposed
originally by dscho could proceed without the additional series.

Carlo

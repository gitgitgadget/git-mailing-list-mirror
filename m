Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D1C4708F
	for <git@archiver.kernel.org>; Sun, 30 May 2021 00:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7880A61001
	for <git@archiver.kernel.org>; Sun, 30 May 2021 00:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhE3AQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 20:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhE3AQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 20:16:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C585C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 17:14:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 22so6145316pfv.11
        for <git@vger.kernel.org>; Sat, 29 May 2021 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrkTEjZoF9l+c0Py6U95urrIV2HkrwxZtUSm1YBCHeU=;
        b=mlkoCxTq+KeGodtAqlxseg4IOXSA7IuMnK4xMJvoKl0Er3CjBRq6XlY8LGj8388bnV
         3IDQaLvzxkfT+4V80/qED+vlYVC1I+e5K0l5PWTShS+sFCJTs2G3pt2xwHAhGje62bAo
         bdktyZBzPfe83fr3cfLs+//w+uMwPjgcF24GRp1O3F7JcBX1Z/1CKAVM+qw6UWVr5LAL
         XHhCKZvrEESbVq+Ak4rsZnA8E3RheVNT5r+DDtNd+WcQOQ4WOXKqjVvVBuE+NpdJhB3l
         2jCZW+vTfw4sT9m/+qnTcaENqnjIsfguQoLCFbrhrQQI94nW/64BFg514GBPc3tHlJ6o
         Z25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrkTEjZoF9l+c0Py6U95urrIV2HkrwxZtUSm1YBCHeU=;
        b=CEk3AXI88hZy+1Y8+CUHy6E7Y/n+loPOKM6JFGD1YfxjGNFiEdz7sZetB8ei0F2jMG
         Yt5xjlA1+OqgtwPg3hfFInrbFo/HxfRjtGhCick+e/KVhbjydSSFuXWGhdnYuJT5fikG
         EkknXY/p31q9T4C59M6pJTWzpX5YSnIV4vabGSGCHT/pjkLOCkA2WdMUh1ibvkKSpEAK
         t0FLW/5+q8XRYw/Gu4p3L2/Jw4NV5JJUWMO5XVnVtUjZR6tjqALya8IGWFbkQAndjZ6D
         w2d8yBq0gkFh3+Iq9aV1273lOPFxQt2RmytDoxberQn+JQbJp7/mU23kz0YgylSNeCma
         F4Ew==
X-Gm-Message-State: AOAM5322Ya9hcYYxYfXHm4KcIgzBYvN139RMKhpoSvzpCYDSpPRyoULR
        GlD95mSSGt/P/jnV8BZRSd52L/s+TiXp/grq9hc=
X-Google-Smtp-Source: ABdhPJzpRbZlGlz4gVb6e9WC9eSpOH7XfpHk0UHIREfhFSIr6WqUcV4dVf77Ywgw9XksD0x0h54sX5euX4uRqxEQ2mY=
X-Received: by 2002:a63:a54b:: with SMTP id r11mr1977223pgu.76.1622333678905;
 Sat, 29 May 2021 17:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email> <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email> <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
In-Reply-To: <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 29 May 2021 20:14:28 -0400
Message-ID: <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resending because client reconfigured to not use plaintext)

Reading through the documentation, Visual Studio seems to support
CmakePresets.json [1] for handling configuration of cmake options.  It
might be worth it to keep the defaults as is. But provide a variable
for forcing vcpkg and a CMakePresets.json for Visual Studio
(and other such tools) to use.

This is nice since Visual Studio users wouldn't need to rely on the
slower Visual Studio * generators to run their builds, while leaving
non Visual Studio users still able to easily run builds.  So maybe there's
a way for everyone to be happy?

1: https://devblogs.microsoft.com/cppblog/cmake-presets-integration-in-visual-studio-and-visual-studio-code/

-- 
Matthew Rogers

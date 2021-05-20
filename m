Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF5C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD74611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhETCUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:20:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00899C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:19:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so17855083ljr.7
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glGAAgD705cXjNEfqCYhXTwk/O/XCEjBXyUlX4Udht8=;
        b=FIdAhqDyoiUuRMT39wy6rt/q8fjEVyq1dNZol0ebKIgl+cCZw3CPiJUsDtn1SmJ4CQ
         GdDTVmIETMrHMhyIJGlZXkX/zS3VHTorP/KIxIPNWeGpLayAUFJsRZlEPX9Bxre41Yz5
         4kq4ML9KwiiQTbaMdZMpRWb0+vyYj6pxp/GTs21pxasuAJ5GbImO4X8k+ERSRqUvBE4e
         zMSJcAf7lgGAiPRR6sOxGNuRt5ss+3HKf0uTm0JbC01WpFpT0DEXYoH8Pm4ZYnqv78Wd
         Zsa5msU0CACkbXyu+Vpuv/fGR2Bn37Xn7/lEM4t39s6HXVHojQx5/xpYW6dtO+ag86KG
         iOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glGAAgD705cXjNEfqCYhXTwk/O/XCEjBXyUlX4Udht8=;
        b=Nyvr9adw486ngLINgi/RgKQu9HWbFTBl5mU+4p59fhfVrMQyi/WDVLK0GSwbCbCclf
         7hFYb55OaBk7FGwhkGqwK/BkiO7rm1yiEkE4MXYL4D7mRAQp9DzTo3fMp09qtvfTG8CW
         fjD0Ne6chniDHnBmaEXjjXz+F0+XCg0fvlF6dToq3B41DlUpq6tJ+/i+r4YFuhuHQaY4
         4qvSwlOzdbZne0RwBsbApOOLUE5NXuoc2Sry0PIjWJi64gJbm8x5kilTyavdCqPET/PY
         R1/rzWns2RX5CaN5wvAX22szGQA4w+pXqnCECbtl8Yk1mq5Yh3cy3HAPsnOx78E+PHM0
         o2TA==
X-Gm-Message-State: AOAM531M6PlV79mCMpynl1FXnoIlZfxAV0ZZ/kkZ/Oy/c0WiILxxbvBg
        Q6vcDS82l4Jvd2SYe7JIja7eO9BP9dLnSQ3ms7rEDxcB3i0=
X-Google-Smtp-Source: ABdhPJzS527DfBHvyNahEk5Hoe6ZsAHVYa9H0b6/3zOOrLAx0KKjdRUH8k3uisswzCkloMOltHCJptNAHOi/Gm/QkNQ=
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr1415775ljg.227.1621477166236;
 Wed, 19 May 2021 19:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621451532.git.ps@pks.im>
In-Reply-To: <cover.1621451532.git.ps@pks.im>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 19 May 2021 19:19:15 -0700
Message-ID: <CAPx1Gvca8JZOQoUEi_riq_x30VmvNG+uFuq1278cs49V+8+g6g@mail.gmail.com>
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 1:22 PM Patrick Steinhardt <ps@pks.im> wrote:
> Test                                     v2.32.0-rc0             HEAD
> --------------------------------------------------------------------------------------------
> 5400.3: receive-pack clone create        1.27(1.11+0.16)         0.02(0.01+0.01) -98.4%
> 5400.5: receive-pack clone update        1.27(1.13+0.13)         0.02(0.02+0.00) -98.4%
> 5400.7: receive-pack clone reset         0.13(0.11+0.02)         0.02(0.01+0.01) -84.6%
> 5400.9: receive-pack clone delete        0.02(0.01+0.01)         0.03(0.02+0.01) +50.0%
> 5400.11: receive-pack extrarefs create   33.01(18.80+14.43)      9.00(4.30+4.65) -72.7%
> 5400.13: receive-pack extrarefs update   33.13(18.85+14.50)      9.01(4.28+4.67) -72.8%
> 5400.15: receive-pack extrarefs reset    32.90(18.82+14.32)      9.04(4.26+4.77) -72.5%
> 5400.17: receive-pack extrarefs delete   9.13(4.35+4.77)         8.94(4.29+4.64) -2.1%
> 5400.19: receive-pack empty create       223.35(640.63+127.74)   227.55(651.75+130.94) +1.9%
>
> These rather clearly show that the previous rev-walk has been a major
> bottleneck in the implementation.

These are pretty impressive speedups! :-)

I didn't look too closely at the C code for the connectivity scan as I am
not very familiar with the background.  I did look at everything lightly
though, for whatever that's worth.

Chris

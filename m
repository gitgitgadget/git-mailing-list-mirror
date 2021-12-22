Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E14C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhLVS5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345084AbhLVS5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:57:44 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C256C0698D9
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:57:18 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u37-20020a632365000000b0033b4665d66cso1869399pgm.18
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=95kuunagh3WmaU6exPYnCJlowlxR/mpIJQF++RX05Tk=;
        b=qhQGJpUo5wl4qLRu61G+dd3tzH4lWH/8/2B6zaqUUoQfoavByuJnLk5rsqPhOn4tMZ
         sP9P5yqscavrq5xlkQPt+Tnw2aHS08D5dm6//18b051VLJVwj4wOIMx/MVBunvcjK/8R
         xNHCRMGNZ8Xv0ktWI+0sGEXgULbPjO7Vn6vOIOUrKbPHyhjMLu4xy/VQ6651v19Z9tyY
         pGzgLHeyK+ltUnQdE8jC9Fx2/tbK6P2t6y0Mr+FEV/qfNoFi9Pqyz71uUAAuvnBm3mqr
         wgr9rkoeug8S0AYGAxUX+Gry8/rLYtJwcCPpy4nx9nuEWRifdYP3T3gZJgIo9RAkEGrd
         6fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=95kuunagh3WmaU6exPYnCJlowlxR/mpIJQF++RX05Tk=;
        b=6hDKHbTjbi7xfhASsMjSDxEdLVDLfECEmrPgzH9HJyQHjNuZSWLfAmJSLAl6nGsw+P
         ACVAY1z6kjIgY+Oee00Av3OwqMyB67ghiElCWvf6qV6Hy5CECJ+tOt8HULPMhH+A+HFK
         xasbxFIBHweM32SADh2GMvAuH8KpCWqNPiy7BMtTmvA5zKVn8dp1W1hPkg2oeYGFba9f
         5VJ7/547QkEuZQjHq0yUvquO+NBxWSlQbg0PkNiTz1PcHywnzFFiu6vPxT3+LbIhtNqN
         WfLO38cD0imDUzOJoads9lO2tUHoQuNiXJj1GJN3odOJRTcXgnuSZTqfk9bMfygGeOJd
         Zyxw==
X-Gm-Message-State: AOAM530LBgJYv/OQ2zq0Taz334vWnKatHtFYXwhG09Lq2jG0CkNt5+wB
        SIcH4Oxf2TqDp1bmx8c8zJI2GwM/lJNQN6ilHbD8
X-Google-Smtp-Source: ABdhPJz3LOsqENxCB3GlZ2mwv6jVSoYdL3Zh8v1CpncArysqXDcfJ4Wj69E2oOVrgQ1KTkMS7Rgwwu8UzZFJgENGYTHi
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:4c43:: with SMTP id
 l3mr3912757pgr.398.1640199438055; Wed, 22 Dec 2021 10:57:18 -0800 (PST)
Date:   Wed, 22 Dec 2021 10:57:14 -0800
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
Message-Id: <20211222185715.1090524-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: Re: [PATCH v2 0/6] usage API: Add and use die_message()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, sunshine@sunshineco.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A small set of fixes to usage.[ch]'s API use that will go towards
> enabling nicer things down the road. See [1] for the v1 summary
> 
> I believe this should address all the feedback Junio had on the
> v1.
> 
> Aside from the substantially rewritten 6/6 and much simplified 4/6 the
> end-state is almost the same, but things are better split up,
> explained etc. now.
> 
> 1. https://lore.kernel.org/git/cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com/

I haven't looked at this round of patches yet, but for the convenience
of reviewers, it would have been great if you linked to a prior
discussion [1], including an email from me with comments that (as far as
I know) haven't been addressed [2].

[1] https://lore.kernel.org/git/patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com/
[2] https://lore.kernel.org/git/20211027215053.2257548-1-jonathantanmy@google.com/

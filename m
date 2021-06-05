Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E34C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 06:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A93261358
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 06:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFEGiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 02:38:13 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40638 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 02:38:12 -0400
Received: by mail-ej1-f52.google.com with SMTP id my49so1130809ejc.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMbn4iFhDOhB5gimSR5NjtO3jwLVc8PlCqKYIoFc9hc=;
        b=YjG9b+46Z9EnPngM/Qrs4jSqVUKei63CkPhVip2ddUrK5C9pXj4oA53zZS2SkRRY9S
         tLujG8KOLZaWxja4vjbgeY5a5xbq2M6S+p9MirIB+6Z0buzWFMPzvKHl667H1hm7zOSX
         zMJac1P/DtpSGmn5rX8OAE8fb7A1fa6NgKcWAuY+fMAq+uM0x2RV2XZ11PQLQdCfUNYA
         gbwo9DMw34WNTx4o3mGmHRL6AtfHgSb3tKDwWgUPUyGaxS48eT81Sg/Eym6yD0up4zSF
         CPBoFdkBoTBqrA8SVXS691lwJwL7WbUWyInSqA4uVwNha2caHcky9EfzTHw0QkGOHQpd
         BFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMbn4iFhDOhB5gimSR5NjtO3jwLVc8PlCqKYIoFc9hc=;
        b=inJ4rUkNCciXS+P4sfYxzryG1t7k6aH7dXwJkrzKx7t0vxUID3BNaXtWsTsrU/IBtK
         l86D80ADsn3Y6RxDpliKkagpo2JU4bIgx8r/vnL8dh6tXz1waHnUZZhiXxyQyjKFKPZf
         fAZBEFUwwLXTLj//4bxriCezb1GaXemmLrKUlXf0lbnM/CKneIz3y8Ibj433A7MVPJS0
         9tUltKOSSsgSy0l/uM3paCrG8PJVPJOUDjyn0U9POcrJ4SyBzmLRbh4Sag78VeCxgtNM
         oSuxMRavYb5X80yo2GC2bam+KLWbWR8tuIhVUta77O9OkZqw6zGGN0thlRNOnaSLEjJe
         v2Lg==
X-Gm-Message-State: AOAM532oG7aSBgfAz4pRaBDyZaz5hcTR5O5eRCYyBx4vl/2gf8jHTL+6
        7LvWJNo9nMiVpZhVPCnEBgVIM0aagJ+poCk1Igmp0w==
X-Google-Smtp-Source: ABdhPJxYeH8jgboDLPMnCKTVuhDh4msCnQ6NKPNFK8MVfiverirVKnuyJyr/lvFlk3V+M8IYDXAlQTSDq+QFztdds20=
X-Received: by 2002:a17:907:2074:: with SMTP id qp20mr7858575ejb.35.1622874913814;
 Fri, 04 Jun 2021 23:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogCz4o3ZGYHnux_6w+uFyxV-FR0R1hFNeg1COiv0qd_0g@mail.gmail.com>
 <71e60d80-44c1-225d-3cf4-26740de2ac6d@gmail.com> <CAPMMpogSepMk07HVtwO8qKaHx2SHmYVB+vnrnWwVWBNo8U5hAQ@mail.gmail.com>
 <5ce5286c-9390-7cb5-a039-8e26be990b8d@gmail.com>
In-Reply-To: <5ce5286c-9390-7cb5-a039-8e26be990b8d@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 5 Jun 2021 08:35:02 +0200
Message-ID: <CAPMMpojV6McG-mc1xwuC0CEY5_E7=PBGQF-ijhb-EP4T=6Qu7w@mail.gmail.com>
Subject: Re: Partial Clone, and a strange slow rev-list call on fetch
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 3:21 PM Derrick Stolee <stolee@gmail.com> wrote:
> You
> have convinced me that there are deeper things going on than just
> the "unshallow, but with filters this time" situation.
>
> I have created an internal issue for my team to investigate this
> when we have capacity for it.

Awesome, thanks!

One more comment on this: As I was trawling through release notes
looking for the right minimum git client version to target/support, I
discovered that the whole "fetch shallow, then unshallow filtered"
flow, which I might have thought I came up with on my own, was
intended to be supported with a change Xin Li made about a year ago,
and landed in 2.28.0:
https://github.com/git/git/commit/01bbbbd9daaa277a95ae46e5a32f6fba026610ac.

As far as I can tell this implementation/behavior does *not* attempt
to convert existing non-promisor packfiles to promisor packfiles, so
either this behavior should be adjusted to do so, or we should
consider this flow (and the presence of non-promisor packfiles at the
"tip") supported...?

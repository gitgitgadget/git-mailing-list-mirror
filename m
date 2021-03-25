Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679AC433E3
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580C5619F9
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCYXKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhCYXJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 19:09:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEFC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:09:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x17so3609600iog.2
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=SXYGyxVmBgZaECCNeLu0vdtJOktkPvLx3EUIcTgzynI=;
        b=H5g7PAallpE5yb+C0Oj0fU1CMb9i1KLMD4XSi2H9I88uPm8obKMnzWBHEStRa1ZM0E
         EF60TCUNeIiK5sr3c2Nqm7V0U9nS+hgwG2Z12Pgl6aqc9lP6w6KDs02X5ZjwUWVEBVqP
         Wk4vFhaUqj0V0dOIvxgaAO3OmKf885UOjxpIzgJ1e1yKxpVxMuN26la7XwmySyuYGIrj
         BhninLRXIt5jONtsqaERKx6RVYe5wWtww2jwVvsk5G5QFqDdTcnGOT223aCcNxFmB76R
         k1tjl7paGZXvfgWLkr8OZG+GSeMlJ08aNQhs3UtRLDqKXx5EEXIzwiC9F2Lp1+TlWXW8
         YIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=SXYGyxVmBgZaECCNeLu0vdtJOktkPvLx3EUIcTgzynI=;
        b=EHsQMjalnLBo6lcSUnJonZIHHp0XyFTcCZZa/O9QiEWXQ112WnUHwG10Fn82OTpEP2
         cHIUM6ReudGgmkdJVt0G14pHlnGrzZnjc8E6Q3jvKGfOQ/RgMNsLPI8ZZdexsnXymqOE
         pau8okfZMONU9ueEb0xet7TeknQnwufKtibCquXyZXBwL51WwK6Xx0U19QxeEpl+iFjH
         o+4X5MjvspZnxmnzjHOH/5uiLDOQ2F8H4ZdwCyHPriTBV3PgrJg10Kaz1b/b9+DrCdGE
         sePXgmBLqClZYTZq+pHr4VvZ+cErscEK8vk1n/Q3klaBJNEKF6H0e2FDhHe1Ki368m/I
         wJag==
X-Gm-Message-State: AOAM531yvUM2aSNbU1y9mLTpA8+kAFQjlqtyspbu/Cpt+UxVsS6wGlDz
        TGuq+lq4gYpJHu38OH2DOhdNQUWAW98T2jKCc/acGznsZJY=
X-Google-Smtp-Source: ABdhPJw9b4KcU99y3O0X/Xbnu7OVs9U+xr/JGDT7Wa1G2L2JliWBlQlhugRhyvcWsIPOHYHFfhwOserHybHs0ihfUV0=
X-Received: by 2002:a5d:9c50:: with SMTP id 16mr8349524iof.66.1616713784813;
 Thu, 25 Mar 2021 16:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
In-Reply-To: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 25 Mar 2021 19:09:19 -0400
Message-ID: <CAH8yC8nr-zhT-T2UK6q1cvFRzpi0fvyYuh8iydNscEse75X=gA@mail.gmail.com>
Subject: Re: not ok 47 - log.decorate configuration
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 3:57 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> I'm testing 2.31.0 tarball on an Apple M1:
>
> not ok 47 - log.decorate configuration
> #
> #               git log --oneline --no-decorate >expect.none &&
> #               git log --oneline --decorate >expect.short &&
> #               git log --oneline --decorate=full >expect.full &&
> #
> #               echo "[log] decorate" >>.git/config &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #
> #               test_config log.decorate true &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --decorate=no >actual &&
> #               test_cmp expect.none actual &&
> #
> #               test_config log.decorate no &&
> #               git log --oneline >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #
> #               test_config log.decorate 1 &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --decorate=no >actual &&
> #               test_cmp expect.none actual &&
> #
> #               test_config log.decorate short &&
> #               git log --oneline >actual &&
> #               test_cmp expect.short actual &&
> #               git log --oneline --no-decorate >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate=full >actual &&
> #               test_cmp expect.full actual &&
> #
> #               test_config log.decorate full &&
> #               git log --oneline >actual &&
> #               test_cmp expect.full actual &&
> #               git log --oneline --no-decorate >actual &&
> #               test_cmp expect.none actual &&
> #               git log --oneline --decorate >actual &&
> #               test_cmp expect.short actual &&
> #
> #               test_unconfig log.decorate &&
> #               git log --pretty=raw >expect.raw &&
> #               test_config log.decorate full &&
> #               git log --pretty=raw >actual &&
> #               test_cmp expect.raw actual

Cancel this. It just tested OK a second time around.

Jeff

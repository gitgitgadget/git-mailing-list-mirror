Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449DC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE29A60F12
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhHaU32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhHaU31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:29:27 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C75C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:28:32 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id i23so628496vsj.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gwDqZJaCGNB9VPvqhCwdC6AMgul6wOyAJ3DFJ7bybqQ=;
        b=FrMaZeMQ45e16FHrb7iOKjkQw6t8tTn1GX4Pqk3kujc5PjU3mymaUkw/6kZhclxbA2
         rk8eL7y573Bi7+gxISkEzHRAtnXuhe8VZxUZ6A/80UkIBu/5xpa6gIhBgxcyNYEF0+IG
         TBrRcgB3S2e+KvyJKoFXoIA364ZYAiNsgdeg52jnQ2J0ajwQzkS1/3Q+RXyiUlGh7oDd
         jJ3vO4seK5SAemg3Fe4MT1NwIglvutRMD1JqyAZP7D9GdIyort3siP+MmxzoX+v15uNJ
         VUXYI+Nmhi805bSnQwfBSKkYeFxYEiqwSbP+cFBz6MjjHqqDxrVfLtWvN6osTAa0t+w8
         redw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gwDqZJaCGNB9VPvqhCwdC6AMgul6wOyAJ3DFJ7bybqQ=;
        b=es0W1StSwdcjY7YzUzyTEty59eXhw14rwVuJUP790xqGnN7fT0g1qoD2NQQ8tyq4vj
         k5m8fOOCy15S6/fXEw3DtqM7emANbLI4+uN+v0u6j8d1zN8zwsxDWzYikb7dF/ymssxQ
         K6U+HeKVFaJgPKnRnAzxyv0aVGNQBrISN0i3RZT/b9v78APi9CwPq0JQqQBp5rzp+sbP
         5LDK40J24VkP6q1abW3ngm/6Mf+OrTvl/dE3pyXmrq3Wpt8ATm4GumpCaNoE3gz+HtGz
         Uahu4MaGJxFORi6XiG+RqSInAs1spjdRbRcQ2MNJaT1u4GugYtWBQjnd6L1mTM4xFQKT
         E/4w==
X-Gm-Message-State: AOAM531UXWm7BqLnmvYp86XdLaPY+lwD0mrn5Fo9//1tCQRvzOZ1w1p9
        3WqG4Haey9H119pV0iJo63Yot0VePR6ICbvOv6bAdbyP
X-Google-Smtp-Source: ABdhPJwvydcudRyBEwQ/k+qBd2utqGK4Ze+znR70Umj7RFaJB9rxJn/mk7QtZEspRwQWXFHyVkJbl2F2NhCTD5jZfik=
X-Received: by 2002:a05:6102:10c7:: with SMTP id t7mr20325340vsr.44.1630441710634;
 Tue, 31 Aug 2021 13:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com> <87zgszxirn.fsf@evledraar.gmail.com>
In-Reply-To: <87zgszxirn.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 31 Aug 2021 13:28:19 -0700
Message-ID: <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub workflow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 4:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Aug 09 2021, Phillip Wood wrote:
> > On 09/08/2021 02:38, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> >> similar to the recently added sparse task, it is nice to know as early
> >> as possible.
> >> add a dockerized build using fedora (that usually has the latest
> >> gcc)
> >> to be ahead of the curve and avoid older ISO C issues at the same time=
.
> >
> > If we want to be able to compile with -Wpedantic then it might be
> > better just to turn it on unconditionally in config.mak.dev. Then
> > developers will see any errors before they push and the ci builds will
> > all use it rather than having to run an extra job. I had a quick scan
> > of the mail archive threads starting at [1,2] and it's not clear to me
> > why -Wpedaintic was added as an optional extra.
>
> This is from wetware memory, so maybe it's wrong: But I recall that with
> DEVOPTS=3Dpedantic we used to have a giant wall of warnings not too long
> ago (i.e. 1-3 years), and not just that referenced
> USE_PARENS_AROUND_GETTEXT_N issue.

when gcc (and clang) moved to target C99 by default (after version 5)
then that wall of errors went away.  Indeed git can build cleanly in a
strict C99 compiler and until reftable was able to build even with gcc
2.95.3

the nostalgic can get it back with `CC=3Dgcc -std=3Dgnu89`, and indeed I
was considering this might be a good alternative to the defunct
gcc-4.8 job, where the weather balloons breaking with strict C89
compatibility could be explicitly coded.

> So if we turn pedantic on in DEVOPTS by default, wouldn't it make sense
> to at least have a CI job where we test that we compile with
> USE_PARENS_AROUND_GETTEXT_N (which at that point would not be the default
> anymore).

agree, and indeed was thinking it might be worth combining this job
with the SANITIZE one for efficiency.

Carlo

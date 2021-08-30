Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A5C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799A661131
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 11:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhH3Llm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbhH3Lll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 07:41:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7BC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:40:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n11so21079820edv.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=belE30osVpuhclec1p/lE/lyzmBrzuXzTlVeqz6RwnE=;
        b=CDNchm0NZ26bHPtj1l55zZiN4PC7+JlKJir8NLu6XMrmoGKgom779WV6QkH+R44yjT
         nqoBTXCMjOLGQUaju3jZgZsh76m8sh6vkHGVkHl33Fa3n0WoMu1kMJ26MI2akO4kYEjp
         Oik5kQxXpl0UocAr+tTEYHn2e7E9wfAi6rDGEWefuT/34Sj/FnWJwK8X0xO8ucgeCZ84
         3Fk0e1sJx723lTbRZOnOFPZfqwOVooCt9Jxm+q/scwSDzBib9AldP8OVOTl6CMP7XltD
         yi9lG5oOThXfxZF5PN3tO5uf9FcjyTbrxzErOrEtu/YLhuNW5YgVEq5nayGe6/dQ+scl
         roHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=belE30osVpuhclec1p/lE/lyzmBrzuXzTlVeqz6RwnE=;
        b=k5pJYosvStU3p2+HY1DiMYFTG4rwOZhS3RK1Dh4CUAM2hNV5syMMiFT3zCViIt2ufX
         ttSpOBJ5jTK4vm0XKygfPAfkGEYx1XjlWAGql8dEm/aFy/OeV0bKf4PaOpt8vcVvF87V
         pMM9SdG9tjNiiE8VhA0uQ4oQGy2kWozPOh+EJjkdAkUElCXuxhesbRKF4hQwHp1R8jdU
         RTDi3lsBojDkVa7TsPUwSduWQTBM0gBW5W0uBvgcSZAARwe9OcIapfSqwjtIh6nAPnRW
         LNX8lHdW7xFComogLFb80w7c0p0zB5j+o5GpVaCeZuXhw47EG/rrB2nD8kLxYJE3IycZ
         0u5A==
X-Gm-Message-State: AOAM532NkEHebww2T5K2hb3l7S2yF9gXu0TIq2lCTboZSXIsbuwh65gM
        JzpJusxeYdxT/YPW3u15LtM=
X-Google-Smtp-Source: ABdhPJzBqnJejdQhKZeNfK7lBxoTFybzhpHD2o8x7TrI3kdEqdM3inpEXld3Teo7bDBHONDrA+ZWqA==
X-Received: by 2002:a05:6402:3107:: with SMTP id dc7mr23970207edb.341.1630323645980;
        Mon, 30 Aug 2021 04:40:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10sm7510410edt.25.2021.08.30.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 04:40:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
Date:   Mon, 30 Aug 2021 13:36:50 +0200
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
Message-ID: <87zgszxirn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 09 2021, Phillip Wood wrote:

> Hi Carlo
>
> On 09/08/2021 02:38, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>> similar to the recently added sparse task, it is nice to know as early
>> as possible.
>> add a dockerized build using fedora (that usually has the latest
>> gcc)
>> to be ahead of the curve and avoid older ISO C issues at the same time.
>
> If we want to be able to compile with -Wpedantic then it might be
> better just to turn it on unconditionally in config.mak.dev. Then
> developers will see any errors before they push and the ci builds will
> all use it rather than having to run an extra job. I had a quick scan
> of the mail archive threads starting at [1,2] and it's not clear to me
> why -Wpedaintic was added as an optional extra.

This is from wetware memory, so maybe it's wrong: But I recall that with
DEVOPTS=3Dpedantic we used to have a giant wall of warnings not too long
ago (i.e. 1-3 years), and not just that referenced
USE_PARENS_AROUND_GETTEXT_N issue.

So yeah, I take and agree with your point that perhaps we should turn
this on by default for DEVELOPER if that's not the case.

On the other hand we can't combine that with
USE_PARENS_AROUND_GETTEXT_N, and to the extent that we think DEVELOPER
is useful, the entire point of having USE_PARENS_AROUND_GETTEXT_N seems
to be to catch exactly that sort of in-development issue.

So if we turn pedantic on in DEVOPTS by default, wouldn't it make sense
to at least have a CI job where we test that we compile with
USE_PARENS_AROUND_GETTEXT_N (which at that point would no be the default
anymore).

Or maybe the existing CI config matrix would already cover that,
i.e. we've got some entry point to it that doesn't go through
ci/lib.sh's DEVELOPER=3D1 that I've missed, if so nevermind the last two
paragraphs (three, including this one).

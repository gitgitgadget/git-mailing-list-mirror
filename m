Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF0C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiBVKuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiBVKuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:50:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC215C669
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:49:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so41381185ejc.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3/HVSZ1gQyVZQyhE64UcZrjNfzZ/D74XzsADht3jeUA=;
        b=c1MWX/WDK/3sxj/MvopGFrXk5JpW+PLV2Xb1DvlCkYX2laADWFaC9UbjPz8j58IWh0
         Ow0C6ZXY5RJOWiseqxJrwOZD/xMl7gKfzaMlVYag3l5+N8GuHWrUMGpbDVGz+JrlNkTI
         8F2moe4x/Eaa8mgZRfllH/56C6N5zcPO8gByweco4+uPXBcnzR7eUcP9zrrwz4EiRz5g
         17DcVs/CSwrugdC+pCvSxVC5SxDHXMqK2QDqcyRxPTLb/rA6Sed5SovDSEjLelfJhn/I
         1N6a85jbfNZR0AtT4NeEC3Mvf91xKs6WPkqyCyFbSDmNoFddqOTv1+49q11Y0a8r8t6M
         XmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3/HVSZ1gQyVZQyhE64UcZrjNfzZ/D74XzsADht3jeUA=;
        b=mqgaquLJYEpV8p/zfYj8jrvqFAJTQ2VFmdT5XXaLRv5gMZS7VuGXrAhCXXDuBrf+Ju
         m7ptlr8880R4MlMo1gKAicfQxD1LmhqHU14wpptCZOiAqO2Fz4VvQC/QSZBGLy3RmMYD
         3QmLYSyX/QrwCQ9CHir6rQ1pDoX2p/lyW02eUlBb8PDRSw3GpnNGU2jPp7W6m57MAmLw
         cGPkTuLY0VKQ/h2CihvntlulAS3R3jwqqptZi8oytmgTOVRnjTquDHKofJN/5PWWKm+I
         pb3wyXHAL54zUO7HhK+dssVggxwcCdEQmwymU1AyJgMMPVSWJn62o8ifWbbt4pGKEZlY
         0TPg==
X-Gm-Message-State: AOAM531WQKZaGE4jWblkl27PrEZkpRD+tJA3PYeaGq4p148J/p/seVmI
        QMr3XtRnWzf5iuk6xccMEZsvTNy7T47Z/3mn
X-Google-Smtp-Source: ABdhPJwWHztVVzBpBRxd0vBS7uyOeuyOaF86iH4g/v34Ecd3IBbYf3Sbfc0qfZTMcjHGBj+i0XWqfw==
X-Received: by 2002:a17:906:af57:b0:6cf:7f1d:ddd7 with SMTP id ly23-20020a170906af5700b006cf7f1dddd7mr18677545ejb.453.1645526990427;
        Tue, 22 Feb 2022 02:49:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k7sm6043027ejp.182.2022.02.22.02.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:49:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMSjt-005y28-9O;
        Tue, 22 Feb 2022 11:49:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/25] CI: remove unused Azure ci/* code
Date:   Tue, 22 Feb 2022 11:27:38 +0100
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2202221115590.4418@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221115590.4418@tvgsbejvaqbjf.bet>
Message-ID: <220222.86k0dn89bm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi,
>
>
> On Mon, 21 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Remove Azure-specific code that's been unused since 6081d3898fe (ci:
>> retire the Azure Pipelines definition, 2020-04-11). As noted in a
>> larger removal of all of the Azure-supporting code in [1] (although
>> that missed some of this) there is more of it in-tree, but let's focus
>> on only the ci/* code for now.
>>
>> This is needed because in subsequent commits this unused code would
>> either need to be changed to accommodate changes in ci/*, or be
>> removed.
>>
>> As we'll see in those subsequent commits the end-state we're heading
>> towards will actually make it easier to add new CI types in the
>> future, even though the only one we're left with now is the GitHub
>> CI. I.e. the "ci/*" framework will be made to do less, not more. We'll
>> be offloading more of what it does to our generic build and test
>> system.
>>
>> While I'm at it (since the line needs to be touched anyway) change an
>> odd 'if test true =3D=3D "$GITHUB_ACTIONS"' to the more usual style used
>> in other places of 'if test "$GITHUB_ACTIONS" =3D "true"'.
>>
>> 1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-av=
arab@gmail.com/
>
> This has been discussed before, and I already gave my NAK.
>
> It is sad that I have to repeat myself: it is a good thing to have the
> Azure Pipelines definition as a fall-back. In the past, this has served us
> very well especially when we had to run a barrage of security fixes, for a
> slew of backports to previous release trains.
>
> You seem to have fun to just remove this code, under some assumption that
> it is not needed, despite me pointing out that it is needed.

I previously submitted a stand-alone patch to remove it[1] after the
removal of (most of) the Travis CI was merged in f9b889dd67b (Merge
branch 'ab/ci-updates', 2021-12-15).

I submitted that not for "fun", but because I had other CI/test-lib.sh
changes depending on that.

I.e. I needed to either patch code unused in-tree I couldn't test
without reverting your 6081d3898fe (ci: retire the Azure Pipelines
definition, 2020-04-11) (and presumably set up some Azure CI account
etc.), or remove it.

It's still unclear to me how Azure CI is being used as a "fall-back",
can you explain that? I.e. we don't have the azure-pipelines.yml anymore
(and neither does git-for-windows/git). Is this in-tree code being used
by some out-of-tree fork of git.git, or do you mean you'd like to keep
it in case we find a reason to revert your 6081d3898fe?

In this case (and as I think this series makes clear), we can't easily
keep certain Travis + Azure assumptions around *and* simplify how
ci/lib.sh works in the same way. At the tip of this series it's turned
into a very dumb variable setting helper with the CI recipe itself
driving the test.

Whereas Travis and Azure were using a feature where a "job" once running
would attempt to skip the rest of the CI run.

And in your [1] you mentioned the reasons for keeping it around being:
=20=20=20=20
    The reason is that there are still some things that Azure Pipelines can=
 do
    that GitHub workflows cannot, for example:
=20=20=20=20
    - present the logs of failed tests in an intuitive manner,
=20=20=20=20
    - re-run _only_ failed jobs.

It seems to me that in your parallel series you're working on 1/2 of
those, and with/without those changes we could otherwise improve the
presentation of the failed test runs enough with the "grouping"
etc. feature.

And as for 2/2 that any such support would be mostly orthogonal to
keeping Azure code that's currently unused around. I.e. a goal of this
series is also to make the CI less of a special snowflake, because I'm
not only interested in running the CI code on GitHub CI, but also
locally.

Which means that for any future port to Azure, GitLab CI etc. we'd
presumably just have a thin recipe that ran "make" followed by "make
test", and for a re-run of only that job it would just use the CI itself
to do that, without us needing to carry any special-cases in ci/*.

I'm not at all opposed to keeping Azure support in-tree. I specifically
have a problem with unused code holding other improvements
hostage.

I.e. neither I nor anyone else can easily change anything surrounding it
while being assured that we haven't broken that unused code. As noted in
04/25 I think you've also had that issue, i.e. your recent 0e7696c64db
(it seems to me) introduced what would have been a bug if it were
combined with the azure-pipelines.yml code removed in your 6081d3898fe.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112201834050.347@tvgsbejv=
aqbjf.bet/

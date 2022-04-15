Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA09C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350871AbiDOUbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiDOUbf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 16:31:35 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDD5DD96B
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:29:06 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d9so7860933vsh.10
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oOBkL8NXSuYSI58XWPWZpTezFwStZaUdMXkiRh78ABE=;
        b=h4Zbhy9F3qQOjCouUXIV2ZYBEF0QYiX68giXF6siona9UY2rUox8DbI+m+gO3tVA+m
         1MwQAHbP/tZGfLeh2l6l5EkIxN82bOwH6emMlTjL0ozkB1bcWRj74WIzAefZo06kkmJz
         zSpoRyjuVMjo1AssE7+MQ/NeIubFJpqb6ZNuLTS4DjWplHWx3mvBFrCSGJ+MeafBaIgC
         ScD6TRIsVyNJUDZvQUT28h7DQamlJ3bH7Hsnrk0GKBx4ajIhWHULBw2PvLFL1oyyo6gY
         HMtO/zTBIc70H2TaQ5qFy8GFAsu4oD2A23Wpy0+z45SDOihb7KeRLL2pDR3cmhkuQ7lY
         Ar3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oOBkL8NXSuYSI58XWPWZpTezFwStZaUdMXkiRh78ABE=;
        b=0DzkVcTYnH1GnYJZlbHGzG8MssKnIgREcignXVcDdQc8rAaUCGTOKbGP3CWWtQ2DUe
         p9aIVuOH2nU51dyOfSnQCymkhtXhLBykvip/PgNj4DjUjAblsrQZ+xLK+oIAz+x9sMHp
         caF5sf1amvhcDsPRJx0ZfyRRArQs2QzT/iXyr/Gi1eVhrd6ul9gAuy2LWdiqJwWzeYHm
         G41aACY/M8NgmyRAsYR0JjBNJsjheb7mdtL29Y32JNhu924W/FVQKPJd8fMGc+rjU14j
         bqegYXOy7lJZXNN9iyxHQHfCjQppL2VpGwkfDFmlIPLSnWrwDoJimVyse55SEI8phOz8
         MIZw==
X-Gm-Message-State: AOAM530wk177j2HOtKqtBSo6iDGkDFOy+Iyzkx/g0MdcOHPSNgp2k5v1
        q+s0HTLsM7w5V9YuQNtRo6tzP2OES8OAII7ijg4=
X-Google-Smtp-Source: ABdhPJwJ/GuYnTTusGZNz4tNpd7TepguAdyi830qsT24LEwnHDwZ3MUnN7OoLzl4ByX1gp+0rtIsO16TsVrw/LEd3Q4=
X-Received: by 2002:a67:cb11:0:b0:324:fa43:1408 with SMTP id
 b17-20020a67cb11000000b00324fa431408mr197751vsl.5.1650054545270; Fri, 15 Apr
 2022 13:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
 <CAPUEspjT23rqBwkgARf90me1n0dd4pjS4i+ya=Vo=xCBCTjp4g@mail.gmail.com>
 <220415.86k0bqbgin.gmgdl@evledraar.gmail.com> <CAPUEspiE3HBkkBzNgz8Gb6=fc2NPnfbGzzn2SEiGGG+zVo9DLA@mail.gmail.com>
In-Reply-To: <CAPUEspiE3HBkkBzNgz8Gb6=fc2NPnfbGzzn2SEiGGG+zVo9DLA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 15 Apr 2022 13:28:54 -0700
Message-ID: <CAPUEspgWTk0wjmomo2g9TVHZny7stCt=B8D=HA2=gk_SEC5vnQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 12:03 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 6:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > But unless I'm missing something that's already been the case on
> > "master" for a while, i.e. this is the master run showing that we'll
> > invoke "gcc":
> > https://github.com/git/git/runs/6031562726?check_suite_focus=3Dtrue#ste=
p:3:6
>
> That would be unfortunate, considering the code in next (and all other
> not yet affected) branches still have the definition added in
> 176441bfb58 (ci: build Git with GCC 9 in the 'osx-gcc' build job,
> 2019-11-27) and which survived your travis-ci removal series.

Nevermind, my test was flawed, this[1] updated run does show this code
was indeed refactored away and the bug also introduced to next and
beyond.

Carlo

[1] https://github.com/carenas/git/runs/6042506530

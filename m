Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD9C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 07:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D0C61DBC
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 07:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhF2Hjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhF2Hjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 03:39:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE3C061574
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 00:37:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg14so34644820ejb.9
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=joscl59nxRau/Y7LdNb7c+idyhvfJNwmM8FrYBCoYug=;
        b=rQMR4V/0sQ9UiUIbjmoQgXbyydmawBHmG8ZiAbwgJWlVxC6M8UhA0waoyIvPYP68QA
         QZqTJByrqQ6GwRqBg36JgRVkwT5d6BBqemt/n1yqeD3NpSwIQtB+//+Jcz1y6I2qsvD3
         GVNkO+fjSR7VlRXHsgFgQNe42p9vvke1VHuTsqiEOiHGLpaLW1bEB1Dc497Dn16pYBvX
         w+f/recdy6zDwPaYDVYYPsS33Ec9jCC0DvIlwA/6wD6kua2eADtoAXGmA0mhG52lkyAa
         A6jSutGot5VOUvSXciLPT49QmPHUd2fEC9co/8EFisQb42xo92OPe4YI7x8dY4GI64rR
         YQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=joscl59nxRau/Y7LdNb7c+idyhvfJNwmM8FrYBCoYug=;
        b=OoHQNuKnFuiN0YbDvfiONrC78ZOFk/LFXORBtz8UWR2NDoKtgt0tN1xqkiFm79eek0
         kJU6a2i9G2qC2OuGU0Uwl9XHclLOYGyH6ZRJyIWZdzUmGLG7UC6lSu0MagAGOCDduFFS
         pGhHWXjMJr+ntEP0mpnyOKuBr+HlG66k8WP0BH75XuEyXd8OaVc5y/7wTD2uq0y630/0
         igNoctawXqzGqx2qBk2qjNh2jdahtDNNKKt6iGXPR4vXzoaFEPu+m5V3UzYSj6vN7+CL
         0etMPrrLMuk4dpNroXfW/pg9KMkxMi/VS/BSseTBCutQMH6kY/zh19j7DCi4YwlIJUGQ
         LmOA==
X-Gm-Message-State: AOAM530Lhaf0E4lL+I5D0FcTTt+IXG5pv7hHUEutkhRJuq86g63pFzlY
        uBxnGGJl2s+mVmhyah+iIWE=
X-Google-Smtp-Source: ABdhPJxGNwQduqyu4cuHYDnH7pHRP9lIQZvmnlApmeN/lyOL3iNvGT87UcrsN5cwxYa2OvsEbDxNog==
X-Received: by 2002:a17:907:1ca0:: with SMTP id nb32mr28049097ejc.105.1624952242984;
        Tue, 29 Jun 2021 00:37:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bz27sm7939804ejc.15.2021.06.29.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 00:37:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 29 Jun 2021 09:29:41 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <60d384ecd5ad3_4290208c@natae.notmuch>
 <87tulo1hs4.fsf@evledraar.gmail.com>
 <60d39a71299ef_429020815@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60d39a71299ef_429020815@natae.notmuch>
Message-ID: <878s2tglzi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 23 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Jun 23 2021, Felipe Contreras wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >> As in db10fc6c09f this allows us to remove patterns of removing
>> >> leftover $@ files at the start of rules, since previous failing runs
>> >> of the Makefile won't have left those littered around anymore.
>> >>=20
>> >> I'm not as confident that we should be replacing the "mv $@+ $@"
>> >> pattern entirely, since that means that external programs or one of
>> >> our other Makefiles might race and get partial content.
>> >
>> > The reason I did it in db10fc6c09 is because both asciidoctor and
>> > asciidoc should deal with temporary files by themselves (like gcc). If
>> > you interrupt the build nothing gets generated.
>>=20
>> If you interrupt the build default make behavior without
>> .DELETE_ON_ERROR kicks in.
>
> Generally yes, but it's possible the program traps the interrupt signal,
> in which case make never receives it.

Okey, so by "should deal with [it]" you meant that would be ideal, not
that it's something they're doing now. I misunderstood you there.

>> My gcc 8.3.0 just does an unlink()/openat(..., O_RDWR|O_CREAT|O_TRUNC)
>> dance followed by chmod() when I do e.g.:
>>=20
>>     gcc -o main main.c
>>=20
>> So no in-place atomic renaming, does yours do something different?
>
> It doesn't rename the file, but if interrupted the file is unlinked.

Right, and with .DELETE_ON_ERROR that "interrupted" is extended to
"interrupted, or errors", but bringing this discussion around that's why
I was confident in replacing the "rm" pattern at the start (which really
is 100% replaced by .DELETE_ON_ERROR), but not the "mv" at the end
(which isn't, and is an orthagonal feature).

>> > However, other scripts like build-docdep.perl would indeed generate
>> > partial output.
>> >
>> > In my opinion it's the scripts themselves that should be fixed, and not
>> > the Makefile, *if* we care about this at all.
>>=20
>> I don't think default tool/make/*nix semantics are broken, I just think
>> it's neat to do that rename dance yourself, it's a cheap way to
>> guarantee that we always have working tools for use by other concurrent
>> scripts.
>
> It is cheap in the sense that it doesn't cost the computer much, but it
> makes the code less maintenable and harder to read.
>
> To me it's a layering violation. If the tool is already dealing with
> interrupted builds, and on top of that make is doing the same, not only
> for interrupted builds but also failures, then it makes little sense to
> add even more safeties on top of that in the Makefile.

I agree for interrupted builds, but we're talking about
in-place-renaming, which is orthogonal.

> If this was really an important feature, it should be part of make
> itself, or ninja, or whatever.
>
> IMO the whole point of DELETE_ON_ERROR is to avoid everyone doing the
> exact same dance in their Makefiles.

I agree it would be an interesting make feature, but something pretty
far from what it's doing now.

In general "make" has been intentionally sloppy about this sort of
thing. When you make a file "foo" it doesn't enforce that you fsync it
either, or that if it's being created the directory it's inserted into
is fsync'd.

In a POSIXly-strict sense it can't assume that it can operate properly
without those things happening, but in practice modern OS's deal with it
just fine, so "make" leaves that to the rule itself.

It would be nice to have a make feature to e.g. have individual rules
say "I emit on stdout, put it into $@ for me", then it could in-place
rename, fsync, display progress through "pv(1)" or whatever.

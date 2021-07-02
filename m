Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E6C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36B561402
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 11:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhGBLyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGBLyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 07:54:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732EC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 04:52:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l24so15663565ejq.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZF20XKg6I+29JcsT/Idm/2xahWk0Uho0y658s8QHoQg=;
        b=d2YKl/f+giMj8AXoD/uEosP4Tifgqv1qSKsJRfGpHapzfrI1hyGcP3UANT7rt7B8vg
         /yJ/mqicewmOxIT3+xI2xlum51ai4es8qdnKAgpeDoHknqGYUaswD2VPpVH9tdfEVwAm
         4qcqSKCF1iiAkXX8RhI3NXKVlRXe+utN/1vqAej/pe2ZLzS4DTJaCa98P0kUALfcWLoT
         KFnKVjtLoTjQXUdoc+X+E+eO791g0Hz9gCbjCu/o+cyPbQzasGPiGfnIbQBNrAJc0PoQ
         7q2IWJZ5sQ6deAvjmb0fAaNez0DXUhbFlQq1UCsGfg4Qk1ubeaURSho9mMQl0M08ymje
         G+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZF20XKg6I+29JcsT/Idm/2xahWk0Uho0y658s8QHoQg=;
        b=SFC1HWxjEA9J7thvq4LjwiHTHwsd1HB7xqbZL29PFwOhK8beBZasn0g5tddDkp7jHU
         6xKtrvnqVCCVHZpcMKS/n7xHlzjldA4teUYqztckz648DieGJ1zBFPLnlgYCHKaQwNo5
         NqYmPPdYGvIPgRak4/lKZIwchfjQ1k2xkHjjtXv/1XZ/UaSwZ7l2YfEXSFt0bJQlkPQl
         Aor6YFnRmNXcX3GHFR0rSv3qp9SXao8dZ56R1UJkQ8XAxbdpKlIXwq2sD6gUWd1KahBX
         +q981U7QzD+IB55T5eoKRNwKkcyth+vj00yB1d2Z20IZvmhCTyuCoZER8/AZky+sKh44
         ua8Q==
X-Gm-Message-State: AOAM533j5brjS24xW2Eag+dBr6xDiMsVh87VB+lDDiBk0L1C22uZAZv8
        b7cURBNbBzQMSn70knv2O1Q=
X-Google-Smtp-Source: ABdhPJw5UvIprcfi+JYIIKrT5OPsEwA9Ei/5bCIWwl8yEHU8801YFSfcGKyz6OWhZ6fp0dM1GDYLZg==
X-Received: by 2002:a17:907:3e09:: with SMTP id hp9mr4907630ejc.37.1625226737039;
        Fri, 02 Jul 2021 04:52:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b8sm1216243edr.42.2021.07.02.04.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:52:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Fri, 02 Jul 2021 13:43:52 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev> <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLcFU+ORZTzAsyBy@danh.dev> <60b70eb930614_4abd208ad@natae.notmuch>
 <87eedj74dr.fsf@evledraar.gmail.com>
 <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
 <87zgw75dyi.fsf@evledraar.gmail.com>
 <60dee69fb7cc7_2964b208fb@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60dee69fb7cc7_2964b208fb@natae.notmuch>
Message-ID: <87zgv59bm8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jun 03 2021, Felipe Contreras wrote:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> >> We could then just extend the include syntax rather easily to include
>> >> "libraries", which would be like the current include.path, but would
>> >> understand a library:: prefix (better name bikeshedding welcome). We'd
>> >> then just ship these in /usr/share/git-core/config/includes or whatev=
er,
>> >> e.g. /usr/share/git-core/config/includes/aliases/svn-like.cfg
>> >
>> > I wouldn't be against some some suggested defaults, but *in addition* =
to
>> > some hardcoded default aliases that are documented.
>>=20
>> I'm talking about in terms of the flexibility of implementation of
>> on-by-default defaults. We could implement it as I suggested and then
>> just have a core.defaultIncludes, which would by default be set to
>> git::aliases/svn-like.cfg or whatever, i.e. equivalent to:
>>=20
>>     [core]
>>     defaultIncludes =3D "git::default.cfg"
>>=20
>> Which itself would include a
>> /usr/share/git-core/config/includes/default.cfg which would do:
>
> I really gave this a try, but the problem is that git doesn't even have
> a stardard location to install shared files.
>
> I started with $sharedir, but that's not git-specific. Then I added
> $gitsharedir which required a bunch of changes to the Makefile, and
> eventually I decided against it.
>
> We don't have standard location for shared files. Period.
>
>> In a way this is total bikeshedding, I just think it's worth doing it
>> this way up-front.
>
> Yes, maybe so, but git infraestructure is completely unprepared for that
> (at this point).
>
> So I just decied to hard-code them [1]
>
> [1] https://lore.kernel.org/git/20210702100506.1422429-1-felipe.contreras=
@gmail.com/

FWIW I only saw this reply after I replied in that thread
... referencing this one.

I haven't tried, but I'd think it wouldn't be a big change. You're
injecting alias.* config directly, you could just inject an
include.path=3D* in the relevant part of the config machinery instead.

We'd need a new verb like gitdir:* and onbranch:*, maybe system:* or
git:*, we'd then search system:foo.cfg for those relative to our libexec
or /usr/share data, e.g. /usr/lib/git-core/config/foo.cfg

We could then carry those in includes/* in the git.git repo, and to
address the "let's make sure they're there" have a trivial build step
like the command-list.h to build those into a C object. I.e. dog-food on
our own build process and run `git config -f <file> -l -z` for each one,
munge that and spew it into a *.c
file. I.e. include/aliases/svn-like.cfg or whatever.

Then when we can't find a system:* (or whatever it's called)
handle_path_include() we'd consult that list of fallbacks.

I'm not saying it's trivial, just that I think in practice building
consensus for a "one blessed list of hardcoded aliases" is going to be a
very tough sell, and making it optional/configurable/pluggable might
make that sell a lot easier.

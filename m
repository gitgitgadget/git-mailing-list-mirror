Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F6C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7EF613AB
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhGNI3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhGNI3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:29:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2438C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:26:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l26so1963486eda.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GT6PPZZrQiyCgk/TXcHwlmrOUqTtHLmL/X+n4015eAo=;
        b=GuPSoLewDqIKTs1kbTktmFdp7Hbg9F+w5pjpKIlCSnpydMXoMQASG/rnz3bD60uDTA
         r7geRMyLMyQu/emdh1iZ1sDKm9XMTZo0kmq1ViZ0i/ZMD7KEpJ8XqV18AZr7ob5GJ1j8
         MNgrku+9pot8KKH3EeHcSakCACKX7ILWPYQLNUQQaW0hr8utRBMIw+cu1jDvBRewcmpm
         6jjfpc2YxujzzA/HN5xCgmVoxSXpYNmNCTE7qRmszynHoRjOjsIa+qt9QP7VqchJkNDE
         zqK4i4YH/EJ3LoDZRbuTiG2DAst5UcnxJv3Y4XK1/HIOJfmQnwAAdM+ugeseOiaPIDUL
         +JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GT6PPZZrQiyCgk/TXcHwlmrOUqTtHLmL/X+n4015eAo=;
        b=IZ14jEj8gslZNHcwx6VS9NOCxMz8Leoxfcfol7oRbXeYT/55IwZwiJ2z6PaDewPeJC
         lFMlAYOVVANLgwsgvRDJ+HqqcTXNXDZKxJonIqhPzuAhtPkjC4NBZM1sDFFAMX8T6kv6
         /ebUSfOY2e5vUgEmKWRIqajf5rwcJueh6xYZ+cCWP3Ng2HRS1Pw5swM131h2w3R/vdkt
         K/1OP0P4W394oFuRfsWhTSOb9LYMOfQGewx3FZwAeLLLP0fcnz7CHUqYWJ1uQmw3hAAL
         6iS+p/KxC2O0h60gPyQBZBEAKOtF7UJM7j4oAi2H2F1pplULKoaXSWeV/o6cuf2X/QII
         ctkA==
X-Gm-Message-State: AOAM531ZwdT5AlhGqBRgzeIBlscZUuKu/zz5WbrakxMBcrYoBQzPtAbf
        KzurTNNopdORfW3jQZzLK1Y=
X-Google-Smtp-Source: ABdhPJxPerepDRroIZmnbp7P/b+G2Dh3a47Fa79WGo0Gm3EzQ7qKxeJSQ6cjsxI6YfogcgfJmGqDUg==
X-Received: by 2002:a50:fa94:: with SMTP id w20mr6645362edr.275.1626251206500;
        Wed, 14 Jul 2021 01:26:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d13sm616664edt.31.2021.07.14.01.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:26:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
Date:   Wed, 14 Jul 2021 09:54:02 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
 <87bl7i8ou8.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
Message-ID: <87r1g11et1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:
>>
>> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> > index 0f7516c9ef..3b40c677ab 100644
>> > --- a/.github/workflows/main.yml
>> > +++ b/.github/workflows/main.yml
>> > @@ -159,7 +159,7 @@ jobs:
>> >        shell: bash
>> >        run: |
>> >          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pwd`=
/compat/vcbuild/vcpkg/installed/x64-windows \
>> > -        -DMSGFMT_EXE=3DC:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -=
DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
>> > +        -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3D=
OFF -DCURL_NO_CURL_CMAKE=3DON
>> >      - name: MSBuild
>> >        run: msbuild git.sln -property:Configuration=3DRelease -propert=
y:Platform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
>> >      - name: bundle artifact tar
>>
>> To a first approximation isn't the point of CI to test a diversity of
>> setups?
>
> No, the point of CI is to find breakages.
>
> And in this instance, a careful analysis will reveal that the artifacts
> generated via `msgfmt` are not even used, let alone tested.
>
> Even more careful analysis will reveal that Git for Windows does not ship
> with translations. Therefore, it would be pointless to test the
> translations here. Doubly so because Git for Windows is not even built
> using MSVC, and this `vs-build` job is really about verifying that we can
> build with that compiler, and _iff_ we used `msgfmt` here, it would not be
> Visual Studio's (because it doesn't have any `msgfmt`) but the regular one
> from Git for Windows' SDK. [...]

Sure, to clarify my comment to Dennis Ameling were to the effect of
"hrm, this commit message doesn't seem to justify this change", not that
the change wasn't justified.

I.e. it *read* a bit similar to "this CI job already uses clang, let's
change this job that uses gcc to use it too", and seemed to take it as a
given that making them consistent was an improvement.

Which prompted my review to the effect "hang on a minute, by default we
want things different in CI, surely?".

From your explanation here the reason seems closer to (but I'm not sure
I got all the nuances involved) that the lack of -DNO_GETTEXT=3DYesPlease
was always an omission here, and this change really changes nothing.

But then isn't this a change that belongs in config.mak.uname since we
never use this on this platform? Or do you mean by "Git for Windows" the
configuration you build & ship that release in, not "A Git for Windows"
in the sense of what we're building here (which can/does support
gettext, or not?).

(I see reading on that some of that, i.e. the config.mak.uname
suggestion is wrong)....

> [...] Triply so because the regular one from Git for
> Windows' SDK _is actually used_ in the `windows-build` job, therefore we
> _really_ do not need to repeat the same exercise with the same gettext
> version and the same git/git revision in the same GitHub workflow run.

..., okey, So in any case we do test this elsewhere to bring this around
the entirety of this thread I think could be addressed by just changing

    We already build Git for Windows with `NO_GETTEXT` when compiling with
    GCC. Let's do the same with Visual C, too.

To something like:

    In the XYZ job for Windows we don't need to build with GETTEXT
    because any coverage gained there is covered by the ABC job. The IJK
    job on the same platform already builds with -DNO_GETTEXT=3DYesPlease,
    let's do the same here.

> In short: there is no diversity to be gained here. (Actually, that is not
> quite true: by using gentler language on a first-time contributor instead
> of immediately going into full critic mode without any fanfare, we could
> have invited more diversity onto this list. Maybe you could pay more
> attention to that in the future?)

I'll let others judge for themselves but I do think I'm using gentle
language here, particularly since the quoted "To a first approximation
isn't the point[...]" of mine is immediately followed by (which you
elided) a:

    "Perhaps this change makes sense, just commenting on the explanation
    in the commit message."

I.e. I think it's quite clear that I'm commenting on my own confusion,
not asserting something about the change itself.

> Back to the issue you pointed out: could this be described in the commit
> message? Sure. But I think there is no much worth in it, the surrounding
> code and parent commit makes it clear that the `.mo` files aren't used,
> and that it would therefore be a waste of electrons to generate them in
> each and every `vs-build` run.

Yes. If we have NO_GETTEXT=3DY we shouldn't make the *.mo files and bundle
them up in the archive. It's clear from me from this patch & the
following[1] that we unambiguously end up in a state of NO_GETTEXT=3DY.

I was commenting on the "why" of that change in the context of assuming
that the change made sense, but that the commit message wasn't per-es
justifying it to someone unfamiliar with the area.

I think your citing of reasons for the change that aren't at all
mentioned in the commit message supports that.

1. https://lore.kernel.org/git/c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.162=
5347592.git.gitgitgadget@gmail.com/

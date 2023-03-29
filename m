Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0047DC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 11:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC2LTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjC2LTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 07:19:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65580420A
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:19:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so18817080ybu.8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680088778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXV7RvL/WN+CWAREKmla9jQF71X+9UXVlz5pSKcWK5A=;
        b=dAl+q28KweBexNxkRcBNKG/YMleGaGsage2YIb1KavPBEDxK5/X9J4HzsyL4H9ztG9
         hxk/xJlMId2LtC0aJQFuKSGBeAPjN0CaDeVu+4Rzs/Yx+BWkTg0DG9Z9rvp2G7VdaeF8
         NUWv9LnwVSWM0poSAxgSB3zJnyK1iRyjGG9bCX6PAk6oQX6CyiiRyiid9VUyZVYQhQHj
         hiRHYq28Pf9hFHFumSvzCkEWTOq13N3PlAhh7NDyk/cPw3K89Bua4bM2PCfAAVVMslx6
         RvhOaC2UMAIY8w9iDfKfuBgy5zQbQFNL8WRdK4qncgPkYkywKXIN0Tdr7M+nU8Ivi5D1
         KJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXV7RvL/WN+CWAREKmla9jQF71X+9UXVlz5pSKcWK5A=;
        b=ptmvRZ+9GaB8DkrBubFFe7J/LXKAlEN5a5e5V57tPbIeVdZ2DQE4MFSZJIWZTvJ+97
         DkolY/n3S6PD3xJE6RTtmURi4dnHS/UEdNmoUJ1u5J3ERD+p6zGfhTuOs+uaK9wbsBxG
         fNOYRoUPNLfdGipEbHfbfXA77yrJVo13iLGefurNOSWzk8nIKeXiM1mC0vXPxFA481rl
         gaz4savzJStNPDwqWJSliMyqvU05TFGaRJDFNjVmavz2m4TglsCOd0F1H4xjafWBgacA
         cvGeu+dTo7KK4Ks2CMUxyu809e/pvnAJt6Gd/nBE3mujB+MmGMINKi0qmtxbo2oDqK5A
         TRMw==
X-Gm-Message-State: AAQBX9ccFhgBk68Ad3j55zL3f0/U9J/2zaA/LeJDOCNJUL07oDGOUx2Y
        dKCsTKTrAOdhWKTHb1GwOOgmeja3ABreD/iDkPs=
X-Google-Smtp-Source: AKy350Yh4dhB1AEMxj+V2yuGCms0TaHtcsDFHw5bZbqVsINnturFJF+soBX6S3autIex4sLSXOR4ym6zf8Vw8kDB1Dk=
X-Received: by 2002:a05:6902:703:b0:b48:5eaa:a804 with SMTP id
 k3-20020a056902070300b00b485eaaa804mr10033917ybt.0.1680088778611; Wed, 29 Mar
 2023 04:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <ZCONCVC2ITBJWoBA@tapette.crustytoothpaste.net> <CAMP44s07W6SzJZnmpMMejM8cTNvwrKnNiD+1U=JWMBwUX8JbMA@mail.gmail.com>
 <230329.861ql7x4k4.gmgdl@evledraar.gmail.com>
In-Reply-To: <230329.861ql7x4k4.gmgdl@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 29 Mar 2023 05:19:27 -0600
Message-ID: <CAMP44s1z6PBS8whv6+nhbzQr-H2+QYTDw=WHf0AkY2mbJDZfMA@mail.gmail.com>
Subject: Re: [PATCH 0/6] test: make the test suite work with zsh
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 3:58=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> On Tue, Mar 28 2023, Felipe Contreras wrote:
>
> > On Tue, Mar 28, 2023 at 6:57=E2=80=AFPM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >>
> >> On 2023-03-28 at 17:39:26, Felipe Contreras wrote:
> >> > It's not difficult to make the testing library work for zsh, so I di=
d that in
> >> > the first patch.
> >> >
> >> > The rest of the patches are basically to deal with some variables th=
at are
> >> > special in zsh, workaround a bug, and a minor discrepancy.
> >>
> >> There was a point at which the tests worked entirely in sh mode with
> >> zsh.  I know because I fixed a handful of tests there, ending with
> >> c64368e3a2a47, and I patched zsh to run all commands in a pipeline in =
a
> >> subshell in sh mode to fix the remaining tests.
> >>
> >> If I symlink zsh (zsh 5.9 (x86_64-debian-linux-gnu)) to sh in a
> >> temporary directory and use it in SHELL_PATH, I get only the following
> >> failures:
> >
> > That would defeat my motivation behind the patches, which is to be
> > able to run one test file in zsh.
>
> "One" as in one specific file you have in mind, or a "one-off run"?

One specific file.

I just did a quick porting of the code in my fork, and this should
give you a good idea (it's preliminary):

https://github.com/felipec/git/blob/zsh/tests/t/t9904-completion-zsh.sh

I had already sent versions of this test file that run in bash, but
it's much better to fix test-lib.sh so that it works for zsh and they
can be run directly.

> The
> 1/6 here looks like it fixes most of the issues, but e.g. the
> test-lib.sh fix in 2/6 would be needed by any test that reached that
> code, wouldn't it?

Yes, but my test file doesn't reach that code.

> Some details on all of this in an updated commit message would be most
> welcome...

Well, those details depended on the response.

Since nobody seems to be interested in the tests running with vanilla
zsh, I can just drop them and the explanation.

> > Only the first patch is needed for that, the rest were in case anyone
> > cared to run all the tests.
> >
> >> I don't care a lot of other folks want to make zsh run the testsuite i=
n
> >> zsh mode, but I'd think that using sh mode would be simpler and less
> >> likely to break in general, and would avoid us needing to carry a lot =
of
> >> patches to work around various variables that are special in zsh mode.
> >
> > We don't need to carry the patches if the patches are applied.
>
> But we do need to carry some hacks going forward, some of it seems
> pretty isolated & easy to spot, but e.g. the 6/6 fix of:
>
> -               if test "$c" =3D " "
> +               if test "$c" =3D " " || test -z "$c"
>
> Is quite subtle, you might look at that and be convinced that the RHS is
> redundant, and be right, but only because you assume POSIX semantics.
>
> If we are going to include this I think the relevant t/README and
> Documentation/CodingGuidelines parts should be updated to note that
> we're not targeting POSIX shellscripts anymore, but the subset of it
> that zsh is happy with.

There's no point in that. I consider it a bug in zsh, along with 5/6,
so presumably at some point it's going to be fixed.

And if nobody cares about running these tests in zsh, it doesn't matter any=
way.

Cheers.

--=20
Felipe Contreras

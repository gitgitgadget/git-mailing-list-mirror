Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156BC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiCVTYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCVTYa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 15:24:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E662C3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 12:23:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b15so22927642edn.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWK3qkjYMCccIjowhxLdXayXk6VFHN+x6S3FclwAPPU=;
        b=OmjeEkQ5pd+3qOxYjxqHtSGBMXZ3VgOz9FPlG9BfYrfKyFWBGorouR2y99ANju89fQ
         KvlVGPcKW7Bx2HSjzpyI9KRiP1ESejgpjm65ISrOECzl6IPQbzbyL5kX9yIKMf1yJIvg
         u07CToTu066k48yfTd5yVgwmX+AAsWscVRdDTV/TiZp2QOXW3/+yFvDy03xC4OqxR8Wy
         sIpQ2m2aYxPB42TK2y27VQAh6POHY1uYvncT0XUxK7hHth9+93GeyPCF+sOQ1ad6cpVB
         kmlYSyhGtq48Yk2dvf4eR6RzWvYC0xvf+MreqjgoxhCeeVx9Ogv12pKLZj9CkItn8UT9
         AJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWK3qkjYMCccIjowhxLdXayXk6VFHN+x6S3FclwAPPU=;
        b=RN3AdhH8z7Fmdsex3kbSKW6ibJUtT0Bn+uLGdnJMNnwd3Uci8nJheL2P2jFVb3UV3M
         u6LvbEEi+CGXwvvpLGQzvLdPE1Vbi7NbqsJnZqs/CJUF2RQA0VTaZQtdzUnnq98V2wHT
         MtUWL7sDxB3vcdciYfUlKrffcsgchAtqR7GuhGlUNBL69eTf0SMUHYfv9NH7ls+EZvva
         tMeR6rHoqUWhy3QG4Rh1URYFAhp6ZDMk88JHQ/q0Eo3g2pK2JsK4GkhK1T4ZPw4J5AhQ
         PnVab0WoWycgeMDChUl4V57Qsc3T5ZUXf1ndVYWqT+DLCGdCWjxk6NcagkxXXKNtAYjb
         gDlw==
X-Gm-Message-State: AOAM532iFDIdHKEEpuohxjnMt7Vs6G/1ArPSElPMLsnO70gJtxXMvMDD
        LokhbFsSTCVd7U8MAWmF1S/oB6GJa5dCgCwlab4Xe5EPK19JZh3V
X-Google-Smtp-Source: ABdhPJz0ZTV8GCmM7TTo+8nu92OTfA18jstu22+e9BGDqKlwp9byGTs/QBBELw5wFl3qSXEyhnBxeB5Ij8aACaTifnY=
X-Received: by 2002:aa7:da1a:0:b0:419:b08:476f with SMTP id
 r26-20020aa7da1a000000b004190b08476fmr23838560eds.281.1647976979823; Tue, 22
 Mar 2022 12:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1182.git.1647845516517.gitgitgadget@gmail.com> <220321.86mthj9zny.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.86mthj9zny.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 22 Mar 2022 20:22:47 +0100
Message-ID: <CAPMMpoiYY=19Bb5uVV__FMbty+Z=G3xm+Y4=ZhVE5TR2guwaOg@mail.gmail.com>
Subject: Re: [PATCH] t3200: fix antipatterns in existing branch tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 2:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 21 2022, Tao Klerks via GitGitGadget wrote:
>
> > +fetch_if_remote_ref_missing () {
> > +     # this is an anti-pattern: swallows segfault
> > +     #git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
> > +     # this is slightly slower, up to 1s out of 6s on this set of test=
s:
> > +     git fetch "$2"
> > +     # this doesn't work
> > +     #test_might_fail git show-ref -q "refs/remotes/$2/$1" || git fetc=
h "$2"
> > +}
>
> Moving the context around a bit, as this refers to this code above:
>
> >     I'm submitting this as RFC because I have a couple of significant
> >     doubts:
> >
> >      1. Does it make sense to do this? I believe it's a good idea to ke=
ep
> >         things "clean" so that newcomers more easily do the right thing=
 than
> >         the wrong thing, but on the other hand, I've definitely read th=
at we
> >         have a "don't change things unnecessarily" bias somewhere.
> >      2. What's the right pattern for the "(git show-ref -q
> >         refs/remotes/local/main || git fetch local)" fetch-avoidance
> >         optimization? Removing it adds a second to test runtimes, but =
=C3=86var
> >         warned it hides segfaults
>
> So first, 6s? Is this on Windows?

Eh, kind of. It's Ubuntu running under a WSL2 VM, which in my
experience so far runs *almost* as fast as bare-metal - certainly with
none of the per-process or per-disk-access overheads of Windows.

It looks like my hardware is a little more "vintage" than yours, and
more importantly during my initial testing I had some significant
overhead and variability from VS Code's server trying to track file
changes.

> I tried running this v.s. master:
>
>     $ git hyperfine -L rev origin/master,HEAD~,HEAD -s 'make' '(cd t && .=
/t3200-branch.sh)'
>     Benchmark 1: (cd t && ./t3200-branch.sh)' in 'origin/master
>       Time (mean =C2=B1 =CF=83):      1.887 s =C2=B1  0.095 s    [User: 1=
.534 s, System: 0.514 s]
>       Range (min =E2=80=A6 max):    1.826 s =E2=80=A6  2.117 s    10 runs
>
>     Benchmark 2: (cd t && ./t3200-branch.sh)' in 'HEAD~
>       Time (mean =C2=B1 =CF=83):      2.132 s =C2=B1  0.013 s    [User: 1=
.742 s, System: 0.561 s]
>       Range (min =E2=80=A6 max):    2.120 s =E2=80=A6  2.166 s    10 runs
>
>     Benchmark 3: (cd t && ./t3200-branch.sh)' in 'HEAD
>       Time (mean =C2=B1 =CF=83):      1.944 s =C2=B1  0.005 s    [User: 1=
.620 s, System: 0.495 s]
>       Range (min =E2=80=A6 max):    1.938 s =E2=80=A6  1.953 s    10 runs
>
>     Summary
>       '(cd t && ./t3200-branch.sh)' in 'origin/master' ran
>         1.03 =C2=B1 0.05 times faster than '(cd t && ./t3200-branch.sh)' =
in 'HEAD'
>         1.13 =C2=B1 0.06 times faster than '(cd t && ./t3200-branch.sh)' =
in 'HEAD~'
>

When applying this more rigorous testing approach (without your
git-hyperfine setup, which I haven't understood yet), without VSCode
in the way, I get slower but similar outcomes:

~/git/t$ git checkout cleanup-t3200-tests 2>/dev/null && hyperfine
'./t3200-branch.sh' && git checkout cleanup-t3200-tests~ 2>/dev/null
&& hyperfine './t3200-branch.sh' && git checkout cleanup-t3200-tests~2
2>/dev/null && hyperfine './t3200-branch.sh'

Benchmark 1: ./t3200-branch.sh
  Time (mean =C2=B1 =CF=83):      3.372 s =C2=B1  0.030 s    [User: 2.945 s=
, System: 0.825 s]
  Range (min =E2=80=A6 max):    3.336 s =E2=80=A6  3.417 s    10 runs

Benchmark 1: ./t3200-branch.sh
  Time (mean =C2=B1 =CF=83):      3.630 s =C2=B1  0.032 s    [User: 3.134 s=
, System: 0.898 s]
  Range (min =E2=80=A6 max):    3.592 s =E2=80=A6  3.668 s    10 runs

Benchmark 1: ./t3200-branch.sh
  Time (mean =C2=B1 =CF=83):      3.097 s =C2=B1  0.055 s    [User: 2.741 s=
, System: 0.730 s]
  Range (min =E2=80=A6 max):    3.018 s =E2=80=A6  3.216 s    10 runs

Upshot: some of my other changes had improved performance by 10%, the
unconditional git fetch had worsened performance by 20%, and your
change fixed the latter.

>
> That's a safe way to do it that won't hide segfaults.
>

Thx!

> In *general* it's a bit painful to convert some of these, because we
> really should refactor out the whole bit after "exit_code=3D$?" in
> test_must_fail in test-lib-functions.sh into a utility
> function. I.e. have the ability to run an arbitrary command, and then
> after-the-fact ask if its exit code was OK.
>
> If you'd like to refactor that that would be most welcome, and it
> *would* help to convert some of these...

I'm interested, but this looks like it would require bash-fu far
beyond my level.

>
> But in this case we can just use "rev-parse -q --verify", or rather,
> nothing :)
>
> I.e. my bias would be to just not try to optimize this, i.e. just
> convert the users to the equivalent of a:
>
>     git fetch "$2"
>
> I.e. it's also useful to see that we behave correctly in the noop case,
> and as there's no behavior difference it's a marginally more useful test
> as a result.

I will happily buy this argument; I also like that the simple "git
fetch" call is inherently clearer/more legible than any alternative.

>
> And if you are trying to optimize this on Windows as I suspect I think
> it's better to not do it. ~5s is the time it takes it just to get out of
> bed in the morning as far as our test runtimes are concerned.
>
> The real underlying issue is presumably its the shelling we'll do in
> "git fetch", which we can eventually fix, and then make it approximately
> the cost of the rev-parse when run locally...

Makes sense, but not the case. I was just being oversensitive I guess.

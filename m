Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F004C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhKWMri (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhKWMrh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:47:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D8C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:44:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x6so79462212edr.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Y0hmB2aOUmxUhgJPLr1On2/x+c4EqcG+zKGafQs4AXs=;
        b=dxumSggiPqyAePx7BQssG65iZluyCC2ofIrHUtH9bF50MYALbrSi4V/AH8q7tWxzDV
         SDE1COWjBGvwMqSM55q6/t3yAxvLNP43fPlzsCrihyA4gq8yKEdV2uQauBtwe8L5LTSR
         t8/vOGDJ4HA5jyP51C9Lif3abBUVAcOH1wUO7/QwMCoDsep5t4Ig3GIcb7xcgBIZYv25
         8p0tVSerI3wfPOt7csq9AXX6S0Q7N8PQ4l9QDRSMhgzoQvonkL5cYHbWDPFTntVnQ30v
         WbA0ZSXtUGp8qUBH7FUBY/GGO0t+CYZnIo8hlBxCf3KFUIxxNLf5eAAus+MYUnI0xFKz
         NYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Y0hmB2aOUmxUhgJPLr1On2/x+c4EqcG+zKGafQs4AXs=;
        b=U3cMCe3sKCya+l2xEcDC9pYVepnYm/dEjO1dR1FRAO0j5yQ5Xr2OSXmeGFCH3ijScE
         QSf5Sqs1sP8t2Lf21InndawQthqDs4XVxI6D4SDSqKNyA+sgFcAi/lDcn+aV+MfoCXhr
         Csk/4lSU9RDE5HkFyeJb3gjgo+QXyqMvOOwfg0LtrlRZT9aMUMqcG7FW+yg8KsfuXPQI
         6mpL14sLL11ReBp4ZuyLapN/s7eXV7ktjLQe7wz9JlNjrhQMro9dOycHwqANOFTd5rS4
         yA9fbirW4K3j9FOFPcSbVuFjpnIl7FY48tHd0ZVm7Zr7nxIitEBNCA7ZTRqawQXTHZ42
         QAwQ==
X-Gm-Message-State: AOAM533xo0K17qBRMIzIKSXNpjLtGCRi59RlWPxiXWV/02CBDbmumbR+
        uQzpVe+jUHU0ES+YLb1t1DM=
X-Google-Smtp-Source: ABdhPJw1bkRlJIAdv/XC/B6tV91J9/cX0/P1DmxfxI0o3Oow0buzk0hlhGL88CTG8OY/Rn5qX/1M2w==
X-Received: by 2002:a17:906:b51:: with SMTP id v17mr7420446ejg.262.1637671467623;
        Tue, 23 Nov 2021 04:44:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g1sm5132151eje.105.2021.11.23.04.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:44:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpV9u-001Mie-1p;
        Tue, 23 Nov 2021 13:44:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
Date:   Tue, 23 Nov 2021 13:18:09 +0100
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
 <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111222257430.63@tvgsbejvaqbjf.bet>
 <211123.8635nnydmm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111231215020.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111231215020.63@tvgsbejvaqbjf.bet>
Message-ID: <211123.86ilwjujmd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Nov 22 2021, Johannes Schindelin wrote:
>>
>> > On Mon, 22 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> >> On Mon, Nov 22 2021, Johannes Schindelin via GitGitGadget wrote:
>> >>
>> >> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> >> > index c0bae709b3b..c508c18ad44 100755
>> >> > --- a/ci/run-build-and-tests.sh
>> >> > +++ b/ci/run-build-and-tests.sh
>> >> > @@ -45,9 +45,8 @@ linux-gcc-4.8)
>> >> >  	export MAKE_TARGETS=3Dall
>> >> >  	;;
>> >> >  esac
>> >> > -make -C contrib/scalar test
>> >> > -
>> >> >  make $MAKE_TARGETS
>> >> > +make -C contrib/scalar test
>> >> >
>> >> >  check_unignored_build_artifacts
>> >>
>> >> The CI breakage was introduced with the merger with ab/ci-updates, but
>> >> the combination of the two just reveals an existing breakage in
>> >> js/scalar.
>> >
>> > Which shows that I was wrong to pander to your repeated demand to incl=
ude
>> > Scalar in the CI builds already at this early stage.
>>
>> Us finding an a bug in a topic that's happening outside of CI means we
>> shouldn't have added it to CI in the first place? Isn't spotting these
>> issues a good thing?
>
> Let's analyze "these issues".
>
> Before your patch series, Scalar's `make -C contrib/scalar test` came
> after the `make test` which ensured that Git was built. As designed.
>
> After merging your patch series, the `make test` was magically moved
> _after_ `make -C contrib/scalar test` (which is wrong for more reasons
> than just that Git was not built yet).
>
> So the "issue" is a simple mis-merge, and I provided a fix.

I'm pointing out that your patch to "master" has a logic error where you
added the scalar tests after that case/esac, but on "master" any new
"make new-test" needs to be added thusly:

    diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
    index cc62616d806..37df8e2397a 100755
    --- a/ci/run-build-and-tests.sh
    +++ b/ci/run-build-and-tests.sh
    @@ -34,21 +34,28 @@ linux-gcc)
            export GIT_TEST_WRITE_REV_INDEX=3D1
            export GIT_TEST_CHECKOUT_WORKERS=3D2
            make test
    +       make new-test
            ;;
     linux-clang)
            export GIT_TEST_DEFAULT_HASH=3Dsha1
            make test
    +       make new-test
            export GIT_TEST_DEFAULT_HASH=3Dsha256
            make test
    +       make new-test
            ;;
     linux-gcc-4.8|pedantic)
            # Don't run the tests; we only care about whether Git can be
            # built with GCC 4.8 or with pedantic
    +        "make new test does not go here"
            ;;
     *)
            make test
    +       make new-test
            ;;
     esac
    +"and not here, as it would run under pedantic"
=20=20=20=20=20
     check_unignored_build_artifacts
=20=20=20=20=20
As a result if you look at your own CI run's "pedantic" job at
https://github.com/gitgitgadget/git/runs/4292915519?check_suite_focus=3Dtrue
you'll see that it runs the scalar test, which is not the
intention. That job should be compile-only job with the -pedantic flag.

I also notice now that it doesn't behave the same way with the
sha1/sha256 test. We do end up testing both, but it's not tested like
the rest (but in any case that job is split up in my CI topic).

The other issue is that even if you put a "make test" before a "make"
etc. it should still work, as "test" knows to depend on the compilation
it needs for "test", but that's not the case with "make -C
contrib/scalar test".

Shouldn't it either know how to build git from scratch, or better yet
behave like "make -C t" which doesn't, and just punts out entirely? The
in-between seems strange.

In any case, I see js/scalar got ejected out of "seen" with Junio's last
push-out. I think that any re-roll based on "master" should be adding
the "make new-test" like the above diff. At that point we'll only have a
textual conflict, not a semantic one.

> P.S.: Of course, this could have been easily avoided by holding off
> patches that intentionally touch the very same code as other patch series
> that are already in flight. This kind of conflict seems to happen more
> often than usual as of late. It happened with the FSMonitor patches and
> repo-settings, with the hooks patches, the pager patch yesterday, etc.

Sure, without going into the details of some of those (which I think
you've got the wrong impression of) it's also the responsibility of us
to try to avoid these conflicts when possible.

You've picked an approach with js/scalar that'll require changing every
place where we invoke "make test" in CI to also invoke a "make -C
contrib/scalar test", instead of just adding it to "make test"
itself. The latter is clearly possible, I've sent you a patch to do it
that way, and it works.

So why can't we discuss why that more invasive and textually conflicting
approach is necessary? The scalar topic is clearly a much bigger bite
for git.git than any relatively recent and tiny ci/ topic of mine, and
will be longer in-flight. So anything that reduces such conflicts would
be a good thing.

My current diffstat on top of your "vanilla" topic showing no
special-casing in .github/*, ci/* etc. is needed with that approach, and
thus any potential for conflicts there doesn't exist anymore[1]:

 .github/workflows/main.yml                   | 15 -----
 .gitignore                                   |  1 +
 Documentation/Makefile                       |  4 ++
 Documentation/cmd-list.perl                  |  2 +-
 Documentation/git.txt                        | 12 ++++
 {contrib/scalar =3D> Documentation}/scalar.txt |  4 +-
 Makefile                                     | 96 +++++++++++++++++++-----=
----
 ci/run-build-and-tests.sh                    |  1 -
 ci/run-test-slice.sh                         |  5 --
 command-list.txt                             |  2 +
 contrib/scalar/.gitignore                    |  2 -
 contrib/scalar/Makefile                      | 45 -------------
 contrib/scalar/t/Makefile                    | 78 ----------------------
 contrib/scalar/scalar.c =3D> scalar.c          |  0
 {contrib/scalar/t =3D> t}/t9099-scalar.sh      | 42 +++++++-----
 15 files changed, 115 insertions(+), 194 deletions(-)

1. http://github.com/avar/git/commit/6df9fc2812d (commit message not
   entirely up-to-date)

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F2C4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 14:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579827AbiAYOj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:39:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:39163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238969AbiAYOew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643121285;
        bh=ftz0HMM5CrG4/F0mVCH+YJuoR5/hxRANRMr4CWnQfTs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XAvkVpw8CWPgWZBvcfmBsMeql5UjKhcX3oXZooY128aftFyVXIZbR94MVBtuXb3pT
         eCDYleL7LJnEjFdqLTirMgQvtiY50OWkqCbqzEKj/zn7FpfydcgyCoG0QwC64AHSPh
         jkV0pGlOJFMmC81D8clmvSbj9LkhDC7ohGxG13Fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1mPcZX1Vcc-00us7c; Tue, 25
 Jan 2022 15:34:45 +0100
Date:   Tue, 25 Jan 2022 15:34:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/9] ci/run-build-and-tests: take a more high-level
 view
In-Reply-To: <CAPig+cTk142o5xkN0jHB6y1h=4zYBwhpwdTxG0oO3Ox+xqdgdQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201251527000.2121@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <d2ff51bb5dacfe084166de106e9a864c902f0f36.1643050574.git.gitgitgadget@gmail.com> <CAPig+cTk142o5xkN0jHB6y1h=4zYBwhpwdTxG0oO3Ox+xqdgdQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:91/rcqbo71e0BoWF/rsmhYmjuMy6phv/E7leWtG9MY96wE2S6vF
 KXzC3Ij09DTbFggPXfdUNMEsUaNCHZDoVTqQFGEaaiLB/1IbEmzSvt+gR/bz80DMoCZ8IlQ
 vrS32Is82JI/qFA+bQWaixCsciVoIUAAQY3ZWGOXlEfYr7v4lJSHaB66WbHdsyKx2tOHOaf
 mLn2tT6fYbwnRhvGNAXfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4hpbAt4B2E=:VQRt0arLBXhWk2oLSaTM7L
 NOdCdyZWoUWmAfdsc4W5YNqwbRji5Fnu564gmG4OZQxyvGkmjzuVIn8ejZYSVJSHEeA4ODZK/
 /+V6xT9Ez0YleQrs3e3GJ0LBS1ZNc+CWiw778fjXp1Jxsgt2zu6dBgBX5f7SphlzcVGfJ+gWJ
 Y22aaOoku1G/jOoLoF2JhrfHK+7zwy+kJ3j08X94Rdzw5t2BLyuDsHpejCgW6VLHIThfaDcc8
 GWrATvnD/WYQHMHSijxVZPu1+J5d7sBCAsOTikogwed3nUphqA2DZR470480dmxkIC/hY0rBC
 Cd7dDxCEv0Fsl7Tt/dKSIxEC3iuHa0kHt96NGuGxUGBUFl84HKafR4Icl+7yTLppxY0VtDmLI
 7nlpC5CCm+6XMMJdbSGaY2vV/F5+InxJMY4HPFfMpBT4uLG/73KzoGVTOPZVr+K1BaXy7V9YK
 xSwpDki22FqPKuQ7B+9vGQujSY4Msn7dDiWGIBW2pjV6f5HGTG/VmVZ4WfnFiGWx/X2vgHNzn
 4XKzaPmBdjPcEWRl2zQCl++eHDUBozbe2+Hd/ewN9iWSlKuVwZuepuYdyTssMV+ZUTzaatv9S
 KJoCr0p0wdamO6ci99FWNVq2uya4KdQNesooTmhKYJjz536pTptMLrt08MK47ijZwrxcplb3e
 /DsEPq7DXnA6aiYjgW5fPs2FlYXGdLyEtFTUUjE0DpDk8w8VU9DwsRN5jzzgJfSL/xt4xSRHS
 VgGSSkoAnkkMmbQWc9X081eUYv9oWLf0R56mZCqEcq6D9ML6yk6Cw/rNdgsKAvwmPux37BDP7
 GHZDbJvKHdVRZjqqO5yEekHTmivFJrOLAH+jg+QwsehVixPsg0A1Q98Md9sCJ0Dwzvmn5SCAx
 uN2GrFs8qi9rurYauEyyxugjkS/4qF9/g+WreV5/j0q0WslLzMXOGtIk54VB14KFrIlUeXH/9
 lII2NDzZLdTNjdb21ofpahJD6SFxXvqytWjGWUdVocKiNHO+LbuatcR5KPNFNmeJM0wZp2k8w
 tbEa74FOxaVLWO8C5ZbxIImZZIG2yc/SjWMg8j1oHUjIORZi0qu0OgREYk4KO7F/qn23F70F2
 E4/Q7i+JpKy2Vs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 24 Jan 2022, Eric Sunshine wrote:

> On Mon, Jan 24, 2022 at 3:02 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > In the web UI of GitHub workflows, failed runs are presented with the
> > job step that failed auto-expanded. In the current setup, this is not
> > helpful at all because that shows only the output of `prove`, which sa=
ys
> > which test failed, but not in what way.
> >
> > What would help understand the reader what went wrong is the verbose
> > test output of the failed test.
> >
> > The logs of the failed runs do contain that verbose test output, but i=
t
> > is shown in the _next_ step (which is marked as succeeding, and is
> > therefore _not_ auto-expanded). Anyone not intimately familiar with th=
is
> > would completely miss the verbose test output, being left mostly
> > puzzled with the test failures.
> >
> > We are about to show the failed test cases' output in the _same_ step,
> > so that the user has a much easier time to figure out what was going
> > wrong.
> >
> > But first, we must partially revert the change that tried to improve t=
he
> > CI runs by combining the `Makefile` targets to build into a single
> > `make` invocation. That might have sounded like a good idea at the tim=
e,
> > but it does make it rather impossible for the CI script to determine
> > whether the _build_ failed, or the _tests_. If the tests were run at
> > all, that is.
> >
> > So let's go back to calling `make` for the build, and call `make test`
> > separately so that we can easily detect that _that_ invocation failed,
> > and react appropriately.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -a=
w "$cache_dir/.prove")";;
> > -export MAKE_TARGETS=3D"all test"
> > +run_tests=3Dt
> >
> >  case "$jobname" in
> >  linux-gcc)
> > @@ -41,14 +41,18 @@ pedantic)
> >         # Don't run the tests; we only care about whether Git can be
> >         # built.
> >         export DEVOPTS=3Dpedantic
> > -       export MAKE_TARGETS=3Dall
> > +       run_tests=3D
> >         ;;
> >  esac
> >
> >  # Any new "test" targets should not go after this "make", but should
> >  # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
> >  # start running tests.
> > -make $MAKE_TARGETS
>
> The comment talking about MAKE_TARGETS seems out of date now that
> MAKE_TARGETS has been removed from this script.

Good catch!

> > +make
> > +if test -n "$run_tests"
> > +then
> > +       make test
> > +fi
> >  check_unignored_build_artifacts
>
> This changes behavior, doesn't it? Wth the original "make all test",
> if the `all` target failed, then the `test` target would not be
> invoked. However, with the revised code, `make test` is invoked even
> if `make all` fails. Is that behavior change significant? Do we care
> about it?

That is actually not the case. Compare to what 25715419bf4 (CI: don't run
"make test" twice in one job, 2021-11-23) did: it removed code that _also_
did not specifically prevent `make test` from running when `make all`
failed.

The clue to the riddle is this line in `ci/lib.sh`:

	set -ex

The `-e` part lets the script fail whenever any command fails (unless it
is part of an `if`/`while` condition, or properly chained with `||`).

This line is actually touched by the "ci/run-build-and-tests: add some
structure to the GitHub workflow output" patch in this patch series, which
breaks it apart into the `set -e` and the `set -x` part (so that the
latter can be called later in GitHub workflows, to unclutter the output a
bit).

Ciao,
Dscho

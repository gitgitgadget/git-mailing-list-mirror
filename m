Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A4C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiKHJwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiKHJvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:51:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C4F67
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667901107; bh=+0LxepMEjhbTfnYXpLhXA1lEcnSxqFGat20Euj3Vuyg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LzHOTLfdrRmeGJhB/1w4Dzg4XbX3R02M2YcO6vbgtRSBEPcpFPQ+QbdTlAqbZNTDA
         KND0xnOLqlBNILkehDQgNdvKHShQoCP7q2lTn8PLZUp7vT4BhqL2YZgnU/v0v4JYQ6
         xHElTMl/uioGboPeXODNa+Ql/DnhbeGZN2t83Kqxea0iQsXhZ/GgPuW8fQGG13WKQY
         UlmVzej41MC3JWKO6qHWE5+HiHh0JwLhF3jEk8AkjMEn013oo/sELEGItCk+KyUkWG
         X/c1fICpDcj5A1Gc0FVVdN7qBakyUn5ijQkmVqqdHEODH/iuHEAd3R7ywJZa/sohNa
         5vUX0pkZYM7pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.219.74] ([213.196.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1pAgrs40KE-00shmJ; Tue, 08
 Nov 2022 10:51:47 +0100
Date:   Tue, 8 Nov 2022 10:51:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
In-Reply-To: <xmqqk046cmmv.fsf@gitster.g>
Message-ID: <2p770o19-s3o3-o6r9-18r5-25n91r1r2210@tzk.qr>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>        <f975f57e-71e2-3227-8039-14dff82f04db@github.com> <xmqqk046cmmv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WeCjzujN0vQB4zO06hMbQK5cW1RY9K92qw30+zRFXta5eEeuHs9
 AJCOWJP+BrUsWMZ4fqrmL5pV7jRjXOMimBLXTHXvliVyz6Xzp99QBBXbkZlU3K26qpm/wAE
 gUDAHAC1cTI90PjbXBXZTZWi/gDTb74wDnLGOd00KL4lXlDm8ZxQFPmjXl+/sJCtJyoEYIl
 3OSl/E+gM473nGj5P0kkA==
UI-OutboundReport: notjunk:1;M01:P0:mEV+YqdDgDs=;ATungkUl5W5aYlfYU4o3aoQttVS
 djUt9iEoCXWJlpLOWES2TslYGCltxsVGw5iIDwinNjUc0O1f16pINIi35oTvRCUtfF57E2ePI
 Ec8Lr6/7Kym40n3TnMy9GmmQByrWdK8y+y+7r3bi5tc3ScFu9NYDUmpMgX+ORpJvC5OUMro8f
 DML9vFsJot7ujPLKQpp/6cfzsiecGBVadrRpcwOa6gWeSF4IOhSTK5D/iL9LcQqlFwHNBoB0F
 8PT6M+iS7ZbKtuk7LPMWlrlVn321t4wDnI8J9auDAuHKxA1SrNhHMkWHiEPgMFxWwl4FlngFq
 3WS2rpRfI3o4993TyBD3mynEE4HFDxqdd+aQcmkm34SxCnICW9mgOtJDcStaSSPKza1oiPbd1
 5k9hwRMETBuRRoaUmGKriFD8dkJtiShFYLWucLsSP8zhr6rMWVQ7sclH4MFrUlm0+8oRFwY/8
 tBSzAQzIqL2VI/adjzAu/M1Q+jKLEvQTBurgEAEAH7uQEuO79rcp2mtIL67/e4vbzE9A1yQ/o
 Cw6hP4mVObFIK6/76z4/4zSNhq2346WshHJVlsu3VWdxodf4wxfYVuhIiIFebZ76+RGKRLmfQ
 qyk92n2GrpyeNinBMLcwiOTsLEGoesYOTUE7NAteUd6lf/ivc0jQ+cgtYGYCcFtt8cG/PSXsp
 yzyHr3TWYl3QKV+Z8GGXQO5qnyDmsM6RqpYp5bWghMIjNntyzqLhRzJW7ZMF+lJ3W7cT04SLN
 +r/KHRHOZunjfqBW3F8jGzbvwu69mCrQdYiPOFOVHcfSTbebth0KQuWM2Ibya/vXbbUoeFOa3
 FQGUwug5CFaEFS8KrFHdqUgPOBQBEizwQmSzQ/r0xB5hhlx6hM7T0oNhWZoRkA0/gmL2FEgvw
 gDS/Cy4P5GlBXhz02kXyG/0GHSFdiN50rVvx+/le+pVlS3Ogcs1y8epJfS4wNzz9cNgjCb+jl
 8l4SPg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Nov 2022, Junio C Hamano wrote:

> Derrick Stolee <derrickstolee@github.com> writes:
>
> > On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> Whenever a branch is pushed to a repository which has GitHub Actions
> >> enabled, a bunch of new workflow runs are started.
> >>
> >> We sometimes see contributors push multiple branch updates in rapid
> >> succession, which in conjunction with the impressive time swallowed b=
y
> >> even just a single CI build frequently leads to many queued-up runs.
> >>
> >> This is particularly problematic in the case of Pull Requests where a
> >> single contributor can easily (inadvertently) prevent timely builds f=
or
> >> other contributors.
> >
> > As someone who is both the cause and the victim of this, I
> > thank you for finding a way to reduce wasted CPU time. This
> > patch looks good to me, though I'll need to trust the docs
> > and your testing to be sure it will work. We will definitely
> > see it in place as it merges into 'next' and 'main'.
>
> When I see breakages of 'seen' only at the CI, perhaps because it
> manifests only on macOS, I manually "bisected" by pushing various
> combinations of topics merged on top of 'master' and pushing the
> result out as 'seen' only to the GitHub repository, and not having
> to wait one to finish before pushing out another was a really nice
> feature.  Of course, I could wait before pushing another out, but
> after seeing the last one close to successful completion in a few
> minutes and being able to push out the next one was a great
> timesaver, not only for the "few minutes", but for the countless
> minutes because I will have to concentrate on more than just a "few
> minutes" on another task if I have to switch to another task in
> order to wait for just a "few minutes" before pushing the trial
> merge out.

I often find myself with similar problems where I have to test a couple of
revisions in order to pinpoint regressions that do not reproduce locally.

One of my power tools to figure these things out is
https://github.com/mxschmitt/action-tmate, allowing me to SSH into the
build agent where the failure happens (note: do use with prudence lest you=
r
account gets flagged for potential mining).

I find that much more surgical a tool than having multiple builds run
concurrently, not the least reason being that keeping track of which
builds correspond to which step of the bisection can be very, very
confusing.

Also, one of my core values is to use up only the resources that I need
to. And using up a lot of build minutes is contrary to that value.

So what I end up doing in similar situations is:

- first of all, switch to a temporary branch

- then, add a TO-DROP commit that rips out _all_ of the unnecessary
  builds. Typically the first to go are check-whitespace and git-l10n, and
  then I liberally delete jobs (including the `ci-config` job that's
  totally useless in this use case) and restrict the test suite to running
  just the failing script by editing the `T =3D [...]` line in `t/Makefile=
`,
  often even adding a `--run=3D[... only the minimal amount of test
  cases...]` (after figuring out which ones are needed which is
  unfortunately quite hard due to the abundance of side effects our test
  suite relies on) to the `GIT_TEST_OPTS` in `ci/`.

- then, if I need to test multiple revisions, I _create_ new branches for
  each bisection point (typically encoding information in the branch name
  that will help me with book-keeping), cherry-picking the just-created
  TO-DROP commit before pushing.

Since I want to minimize my footprint when it comes to using resources, I
typically am very judicious about what revisions I test, and how many I
run concurrently.

It is a bit sad that doing this is currently very much involved and that
it is so much easier to just go ahead and run the entire test suite on
every available platform even if the test failures one wishes to diagnose
happen on but one platform in but one test script. I.e. in the current
shape, our code base encourages wasting of resources.

That is a situation I would like to see improved. If I was not committed
to other work streams, I would work on it because I find it that
important.

> So, that is the only concern I have with this change, but in
> general, not running jobs whose results are clearly not needed is a
> good idea.  It just is "clearly" is hard to determine automatically.

Right. It is also very subjective what "clearly" should mean in this
context. For example, I find it clearly undesirable just how long our test
suite takes (and not for any good reason, really) and how inflexible it is
when it comes to things like Test Impact Analysis (i.e. running only tests
covering the code modified in a given PR, which would speed up everything
_tremendously_). At the same time I am fully aware that I find myself
pretty alone in this assessment, otherwise other contributors would
clearly be more interested in fixing these issues than they are.

Ciao,
Dscho

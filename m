Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C4C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbiA0RFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiA0RFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 12:05:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA81C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:05:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so7326648ejy.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=E3VPZB/Pia8Ih8OzfvV/5T9WA9w362QoyaFHn1BxLu0=;
        b=Q1mJYhFpPZ+Kwp3nLHjac9fxsarn45gJZQ6wCINhxmDmu05Jsj3otE3HxWlUFQMF2C
         Ul1/vtq1HN9zlAZYj7KzZSBktx3l79KGQmlqK5DsjFeTSZ+/cNsf7Wf4BQcGRTbfEOZ0
         9uHbOl0kMh+MVfHLouDpsOFi9zDbYVNRdtzo93+rA1rvz+bnbHQuuVSD44IAsSXBk3yT
         4Sje9UZrhreBY4CFbl9cMyEYKT7Fo7vvEm7/pps3uvEObOmudRYoQartKMHKlXGmsBxb
         8a+kttetTFKuDeVv4WdYkmjAnKvyv4sK9MwWMr/536AMwABIrs1JXPSGb/tNMJc7z6lk
         8aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=E3VPZB/Pia8Ih8OzfvV/5T9WA9w362QoyaFHn1BxLu0=;
        b=JjdMPXo9ytS3f0jgp0skrsFcatQyIEvr87dQsAwrHRz3DOpjtEhz1uE/6mYe2ECAo8
         CrMm6N9VxyFHVp8Ur833qsltki1ZQRbGP7U9+nSOt9jtYe/rTHWDNpVB1yvwNH0ZGbWI
         hHTdFUSlztFPxTvnP8gkSnbo6MJHY9gFxBdT2w7YFbMM1WXPpAW8Cjz3zuCU6o0EZo43
         xyZnywTbeWSq3+KEiN952BjeIpAvgX4q1ItZZg9JFNC/98WqxSnPFusTgpidjg1s2w9g
         TKMio1An6rrOCbFv4ByIoDOg/5orOKbN/3ZFNP5QrfC+8fUaVmdK+NaW57KHVG6/Bzor
         uWjQ==
X-Gm-Message-State: AOAM532lCtOBgO5WcCi3Ucalll5WbpK/0/0SkofVLBG6mhPNp8gcKr8Q
        AeghtkyUH44Ov4sp1AWlEROVPn76jvqVhg==
X-Google-Smtp-Source: ABdhPJwlRKO4dwZ6CpxbqEvY6/YFx+CF8AUH9bb2suHlyI0oXl9iESj+/Fu5MUGo8IMedcoOboLmhw==
X-Received: by 2002:a17:907:6d82:: with SMTP id sb2mr3638914ejc.3.1643303142130;
        Thu, 27 Jan 2022 09:05:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ha3sm8855632ejb.157.2022.01.27.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:05:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nD8DM-003YXt-Uo;
        Thu, 27 Jan 2022 18:05:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Taylor Blau <me@ttaylorr.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: CI "grouping" within jobs v.s. lighter split-out jobs (was: [PATCH
 0/9] ci: make Git's GitHub workflow output much more helpful)
Date:   Thu, 27 Jan 2022 17:31:51 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
Message-ID: <220127.86ilu5cdnf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[CC-ing some people who've been interested in CI architechture]

On Mon, Jan 24 2022, Johannes Schindelin via GitGitGadget wrote:

> [...]
> The current situation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Let me walk you through the current experience when a PR build fails: I g=
et
> a notification mail that only says that a certain job failed. There's no
> indication of which test failed (or was it the build?). I can click on a
> link at it takes me to the workflow run. Once there, all it says is "Proc=
ess
> completed with exit code 1", or even "code 2". Sure, I can click on one of
> the failed jobs. It even expands the failed step's log (collapsing the ot=
her
> steps). And what do I see there?
>
> Let's look at an example of a failed linux-clang (ubuntu-latest) job
> [https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=
=3Dtrue]:
>
> [...]
> Test Summary Report
> -------------------
> t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 Fa=
iled: 1)
>   Failed test:  49
>   Non-zero exit status: 1
> t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Fail=
ed: 0)
>   TODO passed:   45, 47
> Files=3D957, Tests=3D25489, 645 wallclock secs ( 5.74 usr  1.56 sys + 866=
.28 cusr 364.34 csys =3D 1237.92 CPU)
> Result: FAIL
> make[1]: *** [Makefile:53: prove] Error 1
> make[1]: Leaving directory '/home/runner/work/git/git/t'
> make: *** [Makefile:3018: test] Error 2
>

Firstly I very much applaud any effort to move the CI UX forward. I know
we haven't seen eye-to-eye on some of the trade-offs there, but I think
something like this series is a step in the right direction. I.e. trying
harder to summarize the output for the user, and making use of some CI
platform-specific features.

I sent a reply in this thread purely on some implementation concerns
related to that in
https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.com/,
but let's leave that aside for now...

> [...]
> So I had a look at what standards exist e.g. when testing PowerShell
> modules, in the way of marking up their test output in GitHub workflows, =
and
> I was not disappointed: GitHub workflows support "grouping" of output lin=
es,
> i.e. marking sections of the output as a group that is then collapsed by
> default and can be expanded. And it is this feature I decided to use in t=
his
> patch series, along with GitHub workflows' commands to display errors or
> notices that are also shown on the summary page of the workflow run. Now,=
 in
> addition to "Process completed with exit code" on the summary page, we al=
so
> read something like:
>
> =E2=8A=97 linux-gcc (ubuntu-latest)
>    failed: t9800.20 submit from detached head
>
> Even better, this message is a link, and following that, the reader is
> presented with something like this
> [https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue]:

This series is doing several different things, at least:

 1) "Grouping" the ci/ output, i.e. "make" from "make test"
 2) Doing likewise for t/test-lib.sh
 3) In doing that for t/test-lib.sh, also "signalling" the GitHub CI,
    to e.g. get the "submit from detached head" output you quote just
    a few lines above

I'd like to focus on just #1 here.

Where I was going with that in my last CI series was to make a start at
eventually being able to run simply "make" at the top-level
"step". I.e. to have a recipe that looks like:

    - run: make
    - run: make test

I feel strongly that that's where we should be heading, and the #1 part
of this series is basically trying to emulate what you'd get for free if
we simply did that.

I.e. if you run single commands at the "step" level (in GitHub CI
nomenclature) you'll get what you're doing with groupings in this series
for free, and without any special code in ci/*, better yet if you then
do want grouping *within* that step you're free to do so without having
clobbered your one-level of grouping already on distinguishing "make"
from "make test".

IOW our CI now looks like this (pseudocode):

     - job:
       - step1:
         - use ci/lib.sh to set env vars
         - run a script like ci/run-build-and-tests.sh
       - step2:
         - use ci/lib.sh to set env vars
         - run a script like print-test-failures.sh

But should instead look like:

     - job:
       - step1:
         - set variables in $GITHUB_ENV using ci/lib.sh
       - step2:
         - make
       - step3:
         - make test
       - step4:
         - run a script like print-test-failures.sh

Well, we can quibble about "step4", but again, let's focus on #1 here,
that's more #2-#3 territory.

I had some WIP code to do that which I polished up, here's how e.g. a
build failure looks like in your implementation (again, just focusing on
how "make" and "make test" is divided out, not the rest):

    https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue#s=
tep:4:62

I.e. you've made "build" an expandable group at the same level as a
single failed test, and still all under the opaque
ci/run-build-and-test.sh script.

And here's mine. This is using a semi-recent version of my patches that
happened to have a failure, not quite what I've got now, but close
enough for this E-Mail:

    https://github.com/avar/git/runs/4956260395?check_suite_focus=3Dtrue#st=
ep:7:1

Now, notice two things, one we've made "make" and "make test" top-level
steps, but more importantly if you expand that "make test" step on yours
you'll get the full "make test" output,

And two it's got something you don't have at all, which is that we're
now making use of the GitHub CI feature of having pre-declared an
environment for "make test", which the CI knows about (you need to click
to expand it):

    https://github.com/avar/git/runs/4956260395?check_suite_focus=3Dtrue#st=
ep:7:4

Right now that's something we hardly make use of at all, but with my
changes the environment is the *only* special sauce we specify before
the step, i.e. GIT_PROVE_OPTS=3D.. DEFAULT_TEST_TARGET=3D... etc.

I think I've run out of my ML quota for now, but here's the branch that imp=
lements it:

    https://github.com/git/git/compare/master...avar:avar/ci-unroll-make-co=
mmands-to-ci-recipe

That's "282 additions and 493 deletions.", much of what was required to
do this was to eject the remaining support for the dead Travis and Azure
CI's that we don't run, i.e. to entirely remove any sort of state
management or job control from ci/lib.sh, and have it *only* be tasked
with setting variables for subsequent steps to use.

That makes it much simpler, my end-state of it is ~170 lines v.s. your
~270 (but to be fair some of that's deleted Travis code):

    https://github.com/avar/git/blob/avar/ci-unroll-make-commands-to-ci-rec=
ipe/ci/lib.sh
    https://github.com/gitgitgadget/git/blob/pr-1117/dscho/use-grouping-in-=
ci-v1/ci/lib.sh

And much of the rest is just gone, e.g. ci/run-build-and-tests.sh isn't
there anymore, instead you simply run "make" or "make test" (or the
equivalent on Windows, which also works):

    https://github.com/avar/git/tree/avar/ci-unroll-make-commands-to-ci-rec=
ipe/ci
    https://github.com/gitgitgadget/git/tree/pr-1117/dscho/use-grouping-in-=
ci-v1/ci

Anyway, I hope we can find some sort of joint way forward with this,
because I think your #1 at least is going in the opposite direction we
should be going to achieve much the same ends you'd like to achieve.

We can really just do this in a much simpler way once we stop treating
ci/lib.sh and friends as monolithic ball of mud entry points.

But I'd really like us not to go in this direction of using markup to
"sub-divide" the "steps" within a given job, when we can relatively
easily just ... divide the steps.

As shown above that UI plays much more naturally into the CI's native
features & how it likes to arrange & present things.

And again, all of this is *only* discussing the "step #1" noted
above. Using "grouping" for presenting the test failures themselves or
sending summaries to the CI "Summary" is a different matter.

Thanks!




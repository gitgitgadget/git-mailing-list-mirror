Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32B01F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 13:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504729AbfJYNbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 09:31:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:41475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504607AbfJYNa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 09:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572010254;
        bh=3qmAJYwfnj0TYVddBPDeew1C3mXT9627u6BWww36LkY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q8FIzSGBrsjPrhmO1U/CyVIORIb+77nAuimXZA2LkVc+jOzu+dxHVnMNp1zctOP8H
         gR3J4953ahB2Dcfg57s0jQRD9Dp/r5VrAZbKnOJZBptndey8gqk8jN1hH4TfWhunKh
         /b0rpzBxHVx4Zn0KBLM3H42LTXWRwYQdtevt0q9w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1i8wAF3jDC-00upT5; Fri, 25
 Oct 2019 15:30:54 +0200
Date:   Fri, 25 Oct 2019 15:30:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com> <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet> <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5Gh84FK7zul865rdF2qfRK4INPAzj8ccFoYJHZU/z59XQ0IXPGj
 XryppxrZQRJjvr3QyHhqRzXbaBVq4B8SPK/A5dRZtkjCOsOrk71MxlvDKryuJfoW1feAlGw
 0XPJfNo+qZ94o+AmEF0SkQXjpgvM+KyRUFkHUup3ZTanMG+Pq+VVW7QKMtR9nJprkWnrK50
 s9Z1H/qotJN0tklI/WC3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D6EOdK4Ssqw=:CWWIcBcQx/B8HCb71uF8iB
 MldSHAHBfkU+NgNhvb/YjQsARFjUnz7000pin9vlunf8oTE10UkXE5PNkfb2zC57caN8MKbgI
 4nFctKpw5pS5UsiXuxCDnv7yWpl5K7coMXdLwDF2z9Izk9+7r1+kcPrOFWmyZ0lWSeG+Nrd47
 lQksuFJeGvVFee8kq3NoSIag059rmqGxw8b9F6uKMTpeDBWKf0BA3I6cBiDEM1auBYl6Ptvrm
 LPb7Yc1Rn2CU1ecqNg9u4GejalE8lQA4gO/AHSVogQPjOKpzmjfnjwIHKJhkdoGIjz3Kr/ux2
 4t5F6mnx9k8WFIwKIAOIjd1oNcEKpvRqVnzCgVz+5uWlHgEDy2bZzTmkkuwzfAveNzdE54nhc
 1e8DSPKkpif0po99sRcPvu9te/4TgMQTkTJ4m5s1iOBcbQPI23sxOJ1Ked6xNfJntxuF3TNUz
 Sp1DypeX23F0KOCeI/WweImcwQQ8S4JsqjQTFsOkSX5hFF+i5fPdDFf+pKkfpSzqIS8S+zz/j
 IyjrbSpT4fD0dvyzRN2sM7Byj8IXtSk4/uDihWkT1m+ChOCEd+8lRuF9gVZrUPq3xUJ+Uiu9F
 quU7c6mby6m6K6Q8mYAeIAfBJ89YxR3M7guCirEklOsj+m3KBWbZ2uT//O2M1A18BeQ6HDMqW
 pBxuMDnmLdF4L445zbz1slJzycYcUxkcMY0jRc4wuedbdQlJVBMX7HXQVn5y02ZjVCKsTVjkJ
 hiPr3PYga8/nJdIU2cjSzNHM7a4bberGfzOYq2elRgBbegpQ6EQhc7a0e/jgvsVJJe9yNgSab
 BT2WQoUzlycGoLyugP6p/KF4mXHTkfeQOSyt1ktEnrGMC4YDA9/kzfASEloHu8IMrV2CGbU52
 OdwT7s1SUv9M+OJYzlXteqfZmPWxaHCipIi45YCCR+rmHHGSvp9BFBcqVK61GGWH0WmQsU4zu
 RSAot8r51i8zskpCAkHAMSH8WEaIfHr7rf/LHKQ2BT7kbfUTipImdDl73gojqFmsBiAPVvXTU
 pHBJ1CXmeMMrEGy9IYnLM1wn7YWDLOT2iAAvN8R5Ka8KcjUSgOuy52eSh8la+MSjaYPWwoA2K
 tBfw0Oi+fuQBe4HAUIfyVdrom+f1vdUiiCgYk2T12Q2wFxYs1wGCMw5xsLP0B+27revdvJqQR
 1/UQBMqu9Jg6qRmFH+ncnR/kwiEJ6PPhVvCfbFkdjVhy51rk27j/t+Ohsz16CjiwXbhKbQO+4
 qkF/w3UqDR1YLCXIBKVF2c0yFuSEkWzDrAQoMAM6ue4GSs0rHOqBOw/UjDYI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 24 Oct 2019, Elijah Newren wrote:

> On Thu, Oct 24, 2019 at 3:23 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 22 Oct 2019, Elijah Newren wrote:
> >
> > > [...]
> > > Yes, t6043 is pretty long code-wise, and still has over five dozen
> > > tests after ditching the separate "setup" tests -- but all of those
> > > tests still run in 3.6s on my box. [...]
> >
> > $ time sh t6043-*.sh --quiet
> > not ok 74 - 9g-check: Renamed directory that only contained immediate =
subdirs, immediate subdirs renamed # TODO known breakage
> > not ok 87 - 10e-check: Does git complain about untracked file that is =
not really in the way? # TODO known breakage
> > # still have 2 known breakage(s)
> > # passed all remaining 117 test(s)
> > 1..119
> >
> > real    7m22.393s
> > user    0m52.115s
> > sys     3m53.212s
> >
> > And this is not a slow box. So yes, those extra spawned processes? The=
y
> > accumulate. Spawning processes is what Linux was optimized for. You're
> > optimizing for Linux.
> >
> > Ciao,
> > Dscho
>
> Wow, I knew it'd be slower on other platforms but I certainly didn't
> expect a factor of 122; you've made me eat my words about performance
> for this case.

I am glad that the numbers are more convincing than I am ;-)

> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
> sanity in the face of refactoring and rewriting -- and as mentioned
> before they have caught refactoring bugs in those areas that appear at
> first blush as "overzealous", and have done so multiple times.  So,
> what's the alternative -- mark the tests as linux only?  Do that but
> also add a second copy that is trimmed down so other platforms can run
> that one?  Keep a local copy of all these tests?  Jump on the
> our-testing-pyramid-is-inverted bandwagon when it materializes and
> provides a way to write unit tests instead of just end-to-end tests
> (I'm game for that one...)?  Start discussing crazy ideas like a
> busybox-like shell, possibly with git extensions (a "git shell" if you
> will, though I know the name is already taken), just for running the
> git testsuite faster?  Those alternatives all sound either unappealing
> or like very large projects that'll take a while to materialize (and
> which I certainly won't be spearheading; I've got too many big
> backburnered projects already).  This performance is clearly bad, but
> gutting the tests isn't tenable either.

One idea would be to try to guard those extra careful tests behind the
`EXPENSIVE` prereq.

I _do_ agree with you that it makes sense, in particular with the
recursive merge code, in particular because you are in the middle of
heavy refactoring, to add really, really overzealous tests.

That really helps getting confident in the changes.

I just don't see that we should pay the price (time-wise, and also
electricity-wise) of running those expensive tests even after the
refactoring, or for that matter, even for unrelated patches that are
more than 99.9% certain not to even touch the recursive merge.

Ciao,
Dscho

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5BD01F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKJPf (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:15:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:50257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKJPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573463720;
        bh=0rbYNmoVGfhosOuwSbr49RBoU9A0qKzldLyttY4ZRas=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CrkXF9GXyngz3sKk44Fk5FN1TkyGQR9nUpFDX5nMlaejNHgm2J08qv10w5+WPRPSg
         KmWJdol4vxTmgCZeS0bEQUagEqJkpJVKy1u4h5QRC20h7REhwuAcGQE4FnJ7+LFuVN
         zIdLLLvAvSH3t4RY8UcaKA2bWbAcSGFrgW9WUIRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1hs3MV1mPn-0167U9; Mon, 11
 Nov 2019 10:15:20 +0100
Date:   Mon, 11 Nov 2019 10:15:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet>
References: <pull.170.v4.git.gitgitgadget@gmail.com>        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>        <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>     
   <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet> <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:djFmrFFxateekph47YPhE2nkOsrscuCtOp8qpyetDYGHQEYKapX
 OuRm6b1LfAeCcuGzTpbXT+ZgWU5If+G3wBSbhnowppvDaM87nNewo1rI+8O7w283fJmkBzB
 2YuPO4Zs+z5oZq9pKtuKo/p8IZKDzGp+k3kMK6ylD6d/BqXG0L3cMABIhkeeRclWEY4BYXV
 uMzrmBdNpVw37D42the6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fi9b8Djf3LU=:4aM02ijAevtBrp2/FwU46h
 zggZn/NWOJz9fSB0FkuKW1VncGyEPpQ/z321r8ilVmnVmb/z1QIpSo/QcLc+YvGCtRGjXkM4S
 5qWDWdL+IHBJ0nf5AcN67oUhHqFjAretU4qEvnB5hld724rNBsyXQ5fA7H5ynXQBo1la4osqb
 HBxrHaBmikCWR9UFxR2vO224AiaXuxuf/4krs6jK0OENlvbuZg75w61QlqBOWdfkIHK8J7HIj
 lUvCUUFSeIqD+7Vpd0/Jn+xXGpFLm62ZtM6gLlxaAhOX8CGWmfaUgC3CNtA+4Wu7NvYZh7FfR
 84TJ+UvoT04fEFsTxYg7GNOqTAX/14bawlsHDdSgufe2s+yjdf/H1NWfMv2+6o4sDhT/n8/jb
 I3N4OuP7E4pnLdljGy1R8kprI6ex0rWwp4DKy1Rghzg3Nj0jvJC0Ujcjyfhtbi5tsY6d5i6fv
 gPem3WFwn/NiDM99R9x7sog0JcALBOpgh6ViszPZ37I8LB7Y+UECqrnC9tpUDJls1Bz2xObvg
 6twaTFVXFqVrjSPDByb0w5LkxSEuDhliZg2BgJb4Bav33Nf7FPHgoa+Ir+PlDIe3d8IUC4qlz
 zdJRg/RBpZvfmkPgU0AEe+gOMrFbrI+6rasHzeffz8YVYOJ8pjB51wPLVOBjy4WmnGx6psDmo
 DAl5TG3aZ08qjp+ShGBG1+qWy+zWwwjlbRpSvCiti33pKkHGpiqagQm48QPmikiwQySkdbCj8
 kFmbK7cC4zgSmlUmpP0KN13aXBux5CaXd0YjjDpGw11JJHb1TzANZHvBGFNvsSk8NoVN8+qpD
 bMIItOLix1eSrk8cI1CKN54SwjD98KYaeK8h79ok+6zfox6y3dCE+mlkIBg6un2+L3+pqwWbf
 Rlx8Kipo2UM3Nm1vwL4bTY8akOmY3YLvfHZag4wRM+/yGrLpSGvkK8Pd934w6YHSZh+QURPZl
 OZRb7Q+W8e7/9XIHzcj7X8c0aU+jx1k5bDEHIEQjHCtFaA6Adp9QjQu7KxrNzqNMWADHaZyc/
 +MGSDGV7mJ/YaC6MLs6gf7eQnVGdtbYUPQ70WRFboHeO2QHVWl0SD/t4rpoyRLraMJHMuai42
 pHPA1QM/oU8c4477wom7ILWrSLbzllZ9sJLQ9YlFJvzHHodnadcuDa5aOYyRx8jG+cfqpLOQ+
 BJe6eCG8zZcb1qzSw/5dquRCzVBF8T4WkbvTKDFdb2wfjsWJUkREYM+fG7zpcCnU05dCgAmKz
 4J2afWEFGHEN4UOkJpIXjPdu3GuD+ELm3tRjbxIT5EjO+wYKNqdBeoMJ6j1M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 10 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I reworded the commit message:
> >
> >     Start to implement a built-in version of `git add --interactive`
> >
> >     To convert the interactive `add` to C, we start with a bare-bones
> >     version of the built-in interactive add, guarded by the new
> >     `add.interactive.useBuiltin` config variable, and then add more an=
d more
> >     functionality to it, until it is feature complete.
> >
> >     This is in contrast to previous conversions to C, where we started=
 with
> >     a built-in helper that spawns the script by default, but optionall=
y
> >     executes the C code instead. The sole reason for this deviation fr=
om
> >     previous practice is that on Windows (where such a conversion has =
the
> >     most benefits in terms of speed and robustness) we face the very
> >     specific problem that a `system()` call in Perl seems to close `st=
din`
> >     in the parent process when the spawned process consumes even one
> >     character from `stdin`. And that just does not work for us here, a=
s it
> >     would stop the main loop as soon as any interactive command was
> >     performed by the helper. Which is almost all of the commands in `g=
it add
> >     -i`.
> >
> >     It is almost as if Perl told us once again that it does not want u=
s to
> >     use it on Windows.
> >
> >     At this point, the built-in version of `git add -i` only states th=
at it
> >     cannot do anything yet ;-)
> >
> > Hopefully you like this one better?
>
> Not really.  I find the "we could do the other way but we don't, and
> I hate Perl" totally irrelevant and misleading.

Okay, I understand that you take exception at my criticism of Git's use
of Perl, and I fully understand that you think I blame you for it
because you added most of it.

And I agree that this sidetrack is totally irrelevant for the patch
under discussion.

I do think, however, that the discussion of "we wanted to do it the
other way, but when we tried, it did not work" is relevant, even if I
shortened it to "we use a different approach than previous conversions,
because that previous approach would not work".

Truth be told: I would have _much rather_ stayed with the previous
`--helper` approach, as that would have made it possible to have a
passing test suite at every step, with and without
`GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue`.

The "let GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue use the built-in even for
functions we _know_ are not implemented" way only gives us the full
comfort of a passing test suite at the very end of all six patch series,
if which the patch series we are currently discussing is merely the
first.

If I was a reviewer of this patch series rather than the sender, I would
be a bit uncomfortable with the fact that `GIT_TEST_ADD_I_USE_BUILTIN`
cannot be added to the CI/PR builds' `linux-gcc` over-job, not until
much, much later. In fact, it can only be added as the very last patch
in the very last of the six patch series.

And as I write this, I realize that I never spelled that out in the
commit message, and it is a rather important point for reviewers to see
addressed pre-emptively, in my opinion.

Therefore I revised the commit message again:

    Start to implement a built-in version of `git add --interactive`

    Unlike previous conversions to C, where we started with a built-in
    helper, we start this conversion by adding an interception in the
    `run_add_interactive()` function when the new opt-in
    `add.interactive.useBuiltin` config knob is turned on (or the
    corresponding environment variable `GIT_TEST_ADD_I_USE_BUILTIN`), and
    calling the new internal API function `run_add_i()` that is implemente=
d
    directly in libgit.a.

    At this point, the built-in version of `git add -i` only states that i=
t
    cannot do anything yet. In subsequent patches/patch series, the
    `run_add_i()` function will gain more and more functionality, until it
    is feature complete. The whole arc of the conversion can be found in t=
he
    PRs #170-175 at https://github.com/gitgitgadget/git.

    The "--helper approach" can unfortunately not be used here: on Windows
    we face the very specific problem that a `system()` call in
    Perl seems to close `stdin` in the parent process when the spawned
    process consumes even one character from `stdin`. Which prevents us fr=
om
    implementing the main loop in C and still trying to hand off to the Pe=
rl
    script.

    The very real downside of the approach we have to take here is that th=
e
    test suite won't pass with `GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue` until t=
he
    conversion is complete (the `--helper` approach would have let it pass=
,
    even at each of the incremental conversion steps).

Any suggestions how to improve that commit message?

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D833C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbiHSOwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349585AbiHSOwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 10:52:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F097EEC77
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660920743;
        bh=qN/ff/ggvvafa6BE0mIvaafrHtlS78PcMAIyXfLCCiE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a4RYNB6b3uYGvklpU7bi27SeDGmmj2Ajg//6z048h0IjzLPW+ltvpxTvYtqG3vPPK
         a2RutFsSSFsZJh3VY85XtySI93W73uNcmSVaUHRoUKcGNfuvYJzZPIBrkaV6tsdqDd
         LXzlyHRaZyFiP8Gqf6RdvKkIU2H6aefib2ZXG0jU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1nnnGK1oiV-00bNTg; Fri, 19
 Aug 2022 16:52:23 +0200
Date:   Fri, 19 Aug 2022 16:52:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
In-Reply-To: <xmqqr11gxm04.fsf@gitster.g>
Message-ID: <nrr2312s-q256-61n7-2843-7r0s817rp432@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com> <xmqq7d3gm1bl.fsf@gitster.g> <r1461365-9np6-n988-0288-9ps4o944qqp4@tzk.qr> <xmqqr11gxm04.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-470004173-1660920752=:241"
X-Provags-ID: V03:K1:9ta9otcc8IdaBJVnZ2etlr10vqJJZk4BtIunK6mUrJlmMmmNi8k
 7Y307zBkYcuipDmq0Bpz7aJMtf/t0oiZ/mrWawL72ZVX5CKlj8Hvdx5JFoUYWnRboPRhWmq
 Zjfc+yX8GHXJKDNbQ6rqOIvZSvHp1Q0M97IpF+ANO+5Q0d3dFEzyYBMI08ZFqhbNQbYpKHL
 KIQtW4ulAsav21gXxIksg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCT9OkioE+c=:dZP9UiFpsqCWamPCio67FL
 ef84WTUf+GUTLHrBZubGcSLiOaxiwGaIsFBTqFXFyZoriSrYngrm6576ezBEU//rGe6nABPWh
 8ogg3oNLrOYf6Jwm5yT3fXKlGc9zty7V9eteA4PwrimFuGsGPlj+HerIsYoGrRnTM9Gr7g6IZ
 Wmo/mXP1PpDxZD4I/B/LWwKKf/s44pxQeCzY2UdY1soh1i3wd3KZ3aATW+Igv4wer2kgTKMLA
 qimE+i7FYyQSpXmF+kpVn3mSPmvifm8OhjUe3Nx8Hbg7iIbekpfS24LOE4WcUnFTIeADJkwff
 b+X8+kvkEetWQdEWcUXikj917krOF6tjAsBU5rLqkfOqMn5wmnyQRB5i6nUy98+7aTtg7uKHH
 67DqDdv4VPuDFnQ7SYIex7VFUeB23oxOGPVV0CTU/Uim8ML4LWcVvYgDjAs1rb/0Cq4n4NJw9
 ZfvByCNb78Thdt06S9yIc2PLjKIkwcNDIp52OPitE9syxL0A70B3GMNPctWsKgMyLzNaJuOvR
 Y/SoVJTyqoBpa0ueVu4eWwy7oyUF54d29X46a0gF10kHSr0z/I9daC7Eg7kVKuXZhJ2wUZAT5
 BpOpRyOgsNQQvIzAPwoPqFwhi9Pr0xQMfntBSwMvGwiZpSf4M6Ci+OhZH2fbFURX74idnwrQA
 RJO5yMr+sln2AAj94nGnO4PqWUznclxIE4Yg0eRublz8nz2GQnsDE6EbRdXxRcPzGUiyG4FZ/
 4LdaIvI6HOt7i064tbB6UB6xvqm4DEv/t6jxpg5nMy10h0hsdjBJo76vYuc1ix0n6Zg9GtUdj
 xQVDUn1dGeypsWTRPSMzcrTIXfmDpmT8YvIklKAgaVHF8nMJg/oUL1OGKKMIwax3RP5TpCRBh
 LQjInXwNnhOh+c4DajdStO/KWxX4p4I6pRW6Stpsze05rq3BNkwnR0ubPkVetyRNmKqcJLL/D
 hlvpIMjZ8+vWgJoK+szZ6eUAZtklXT+Sp2ciUnN1gRRFZ6xDf++vyL7hniSykjD1QX9bYT3w4
 9Sl3DrKHCqOePdmfkyOE4N1EL+EfR//ScHOjdx+CX/TOYIEXRAQ8PoI1z3nUI4/mr61hfJ7Pk
 cj0yiGkc2+nuhcWmpFb408Nlezdl+OkkFbEAG9zFhfbtVTTdlxF9foDAg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-470004173-1660920752=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 16 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The scope of this patch series is to fix running the tests in Visual
> > Studio when building using CMake.
>
> That's only the perspective of who cares about VS+CMake.  From my
> point of view who wants a healthy Git overall, the priority is
> different.  "add -p" fix is wider than the context of VS, and I do
> not discount the need that we need to fix it before we can call
> VS+CMake issue fixed (and I do not mean to say it is unnecessary to
> fix VS+CMake).  It's just this one can proceed with help by those
> who do not care about or have no environment to help with VS+CMake
> because it is more generic, and I do not think you mind to make the
> rest of the narrower VS+CMake topic _depend_ on it.

Sure.

But if I pull out that patch into its code contribution, all of a sudden
the scope of _that_ contribution is to address an implicit signed/unsigned
cast. What other purpose could it have? And if we're addressing that
signed/unsigned cast, we cannot just fix this single one. We need to fix
them all, no?

So let's have a look at that project, since you are implicitly
volunteering me for it. We do have this in our `config.mak.dev`:

	# These are disabled because we have these all over the place.
	DEVELOPER_CFLAGS +=3D -Wno-empty-body
	DEVELOPER_CFLAGS +=3D -Wno-missing-field-initializers
	DEVELOPER_CFLAGS +=3D -Wno-sign-compare
	DEVELOPER_CFLAGS +=3D -Wno-unused-parameter
	endif

Note the `-Wno-sign-compare` part. If I comment that out, I get these
reports:

=2D- snip --
diff.h:210:16: error: comparison of integer expressions of different signe=
dness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=E2=80=99 [-Wer=
ror=3Dsign-compare]
diff.h:210:16: error: comparison of integer expressions of different signe=
dness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=E2=80=99 [-Wer=
ror=3Dsign-compare]
diff.h:210:16: error: comparison of integer expressions of different signe=
dness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=E2=80=99 [-Wer=
ror=3Dsign-compare]
diff.h:210:16: error: comparison of integer expressions of different signe=
dness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=E2=80=99 [-Wer=
ror=3Dsign-compare]
add-interactive.c:207:21: error: comparison of integer expressions of diff=
erent signedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =
=E2=80=98long unsigned int=E2=80=99} [-Werror=3Dsign-compare]
add-interactive.c:210:17: error: comparison of integer expressions of diff=
erent signedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =
=E2=80=98long unsigned int=E2=80=99} [-Werror=3Dsign-compare]
add-interactive.c:238:16: error: comparison of integer expressions of diff=
erent signedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =
=E2=80=98long unsigned int=E2=80=99} [-Werror=3Dsign-compare]
add-patch.c:423:16: error: comparison of integer expressions of different =
signedness: =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=
=99} and =E2=80=98int=E2=80=99 [-Werror=3Dsign-compare]
add-interactive.c:379:25: error: comparison of integer expressions of diff=
erent signedness: =E2=80=98ssize_t=E2=80=99 {aka =E2=80=98long int=E2=80=
=99} and =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99=
} [-Werror=3Dsign-compare]
add-interactive.c:389:11: error: comparison of integer expressions of diff=
erent signedness: =E2=80=98ssize_t=E2=80=99 {aka =E2=80=98long int=E2=80=
=99} and =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99=
} [-Werror=3Dsign-compare]
[... 1260 more issues ...]
=2D- snap --

You see how that increases the amount of work you are asking me to do?

The worst part is that gcc (at least of version 9.4.0 which I have
available in my Ubuntu) does not even catch the line that is fixed by the
patch we are trying to discuss here. It catches 10 issues in
`add-patch.c`, but not the `i < file_diff->mode_change` one.

Neither does Visual C 2022, nor the gcc I have in Git for Windows' SDK,
which is v12.1.0.

So I would first need to find a tool that identifies all code locations
that compare signed with unsigned values.

And that's even before analyzing carefully how to address them (not all
instances will be as easy as upcasting from an unsigned bit to `int`, some
of those instances are about `size_t` vs `ssize_t`).

> > Pulling out this patch would break that patch series because it would
> > leave that breakage in place.
>
> We deal with topic that depends on another topic all the time, and I
> do not think there is anything that makes VS+CMake topic so special
> that it cannot be dependent on another topic.  It's just the matter
> of splitting this out and make it [1/1], and make the remainder to
> [1-4/4] and mark them rely on add-p fix when you send the latter
> out, isn't it?  Puzzled...

Sure, if you think that the signed/unsigned comparison project is more
important than fixing running Git's test suite inside Visual Studio, or
worse: if you are asking me to do a less than thorough job on those
signed/unsigned fixes by fixing only a single instance and leaving all
others unaddressed in a patch series that has nothing to do with Visual
Studio, then I understand how my stance could confuse you.

But my intention with this patch series is to fix running Git's test suite
in Visual Studio. And my intention is to provide a complete solution in my
patch series, no half measures.

As such, I would be loathe to have my authorship on a single patch that
solves neither the Visual Studio/CTest problem nor the vast majority of
the signed/unsigned problems. It would be incomplete in any way you look
at it. I would consider such a contribution lackluster, sloppy and
definitely not up to my standards.

Ciao,
Dscho

--8323328-470004173-1660920752=:241--

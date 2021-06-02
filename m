Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015CC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F33613D0
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFBLK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:10:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:57243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFBLKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622632121;
        bh=kwZXRBboXRNmMba9zHntaoSAIRY02Mu01yZntrzhL24=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dXJvetrOfR4ug+dGdfTg0HkJA9ivcFl79xXsiTCWhJokZy4T3c9a4zw2rlRO80N2L
         RFuBRcOdHgL+Maj4UHeoqnJ7VDB9UCVbkPdAcBlICJgU9NWcSMeNUwz7XEZaGAsiuS
         5n03uZzKU9oXzoAuzo+pLSxK64H/W0Is+gENfoRg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1luMt910V0-00XaMg; Wed, 02
 Jun 2021 13:08:41 +0200
Date:   Wed, 2 Jun 2021 13:08:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jordi Vilar <git.kernel.org@jordi.vilar.cat>
cc:     git@vger.kernel.org
Subject: Re: proposal for additional search path in config
In-Reply-To: <CAE-zgtYTutLZWO63QtqZJztMPqi9eHYQfFu6sda8YDf_bVeE3Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106021259480.55@tvgsbejvaqbjf.bet>
References: CAE-zgtbm=pv=qfErdMeSckQD6Fqe=FdwfHko9G5iCgo7pPQyXQ@mail.gmail.com <20210601113554.52585C06174A@lindbergh.monkeyblade.net> <CAE-zgtYTutLZWO63QtqZJztMPqi9eHYQfFu6sda8YDf_bVeE3Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fHGcE59FQOvI/dU+LEcnPkYOID+w4+/HBnrYBwKKUhYV3YKT4vq
 bI7O8QUl2nuYTLtAUjE7SaxlhCwIF4Hs/ZtJPG0y0FEEdfJYrkIOMBOYqsonx1cpxbgmR34
 qAwhxu/kg+Q+rnzkJ1d+ZmE70yJNGE04dO7fe//EUzEW/1E1cdFNFRXEm2+xQPquln14hu7
 tBUKLoXVqGrWqh/Kb9oKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JxbvYZKDPOA=:282D+/33eRluVXXeEWAMOt
 OKexdz10qasUQPdoYcdADGmaGjLF05mSgNCKhpUDZzr3nhhHlaUDQW/4hgsKw5wBF4GPkQ/YZ
 KOrw+VJalW4apAJFE9CBRzcv1Ssl2HDiLxz0wwXN+qO0BvWkap5IoOsuhn6JcrJQyKWg5HCPj
 fC58dcQt+KKuuhZ/PGHg1Z8PS7MJaqqPXiVTJWp2JYjUurEG6OQGnGJAHZy62in2ZMGiOVKn4
 F0nCUj2Bx+X4tK9OwmZF8H/6E5ktrBMfsjkT6pPGagJDgWqo3Vphie4N5XPKbmCIspZXoH/OW
 gKwR23ubg6YnPEucl39LFRHuZb1sTvEzisx8cTv8iXb7uLc2dYS+Spvui8TFpQ3F55DJQgJJn
 ZE765T8cpqL6oDVU2Jq+xmjD/KIqi4YLDvuWMacx1NpYhC9C5zPT6whAz3/hbojRjHoMZsOGv
 E1Dc4aPlEWD5Xnqm+l9+VvRFwQBGDi8gLSDS3gv1PklrFriuee863aMtWhfEuVstYb4+Av0qn
 aK8WpNlmiQYXaKF/b1rJ1IYuHhRx4QBSUrjivUSt4je/0d3cbMeCvy0ItZf051TDWDHiHUwrx
 +caHy/T78vILwD73WzDqvjAUPaFJq8G2Q2qO9zxrJ4KUTWOsdl3EG1Qm3A3X0RqIelZExsKg5
 e2yibgX81cHV/58G+CPeL0GrdD6lx6ZOqAyoavYhsodCzNatRKDdG/p9u6QgCEKbwIelexRrE
 aoEWoExEAAIfXi8IojXAf7hSZ/3BxKKcRoGRRSKwynrxAHv366wypykZvA4taH1DAohR/ZbzQ
 2sfgERhDVM61N+mx03C4aG9zAYvp7T5sb/j5vHxqDtbmKe9wGJe6Q/XZ/bpy3zRvLfI4dj2Sz
 m++WvnIDipHHKJYQAYrqovjzUjJ4+PHlYiLgNAocwKWQRhCM3DsuYLKQa4TQrcNj5C/7kktr+
 41UoeBFgUDiTDh37iGxOyLvPfhp9FlM9DSeXtFr+SzSrPwX+mN2PenHhrSrZgCRgFf/xDV4gR
 oiNuyHSXPLZWqLxon5ttE6NoVSV+6NOsLVvfzLGhESKq/ULJ/Mx3ik+I+ogS5h5d11tYKyosu
 eJSh+roJ26npqxwVIIn8l3PjHpVRUOe4DaOtKDZfvRaFEmncb26hJa+5g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jordi,

On Tue, 1 Jun 2021, Jordi Vilar wrote:

> I would like to gather feedback about a feature I'm considering about.
> Basically, I would like to propose a configuration setting with a path
> (possibly relative to the working tree) to look for executables. In
> that way, a local clone could setup additional tools/scripts private
> for its work tree, maybe also under revision control.

That sounds like a Remote Code Execution vulnerability by design in the
making. But let's read on.

> For instance, we could have a setting like:
>   git config core.extensions_path "./scripts"
> so that whenever git has to resolve an external command also includes
> that path in the search, resolving relative paths to the work tree, in
> this case, the "/scripts" subdir.
>
> A simple use case could be a custom tool integrated with git, but
> local to the repository and thus versioned.
>
> For instance, let's assume that we have some metadata required by a
> custom build tool that is stored in commit comments or tags, so we
> have a custom script git-project-metadata to handle it:
>   git project-metadata query ...
>
> Maybe the format for the metadata evolves, so the script must evolve
> also. Having it integrated in this way would allow that each checkout
> sees the correct script version, and that script is always invoked as
> a regular git command, without having to tweak the environment
> everytime.
>
> It is not clear to me whether it's a good idea for this additional
> path to have priority over the default search path, as in one hand it
> could allow to override the default tools, but in the other hand this
> may be a hole for bad things... For my, the conservative approach of
> having this additional path as a fallback is ok, so that it only adds
> more commands, but doesn't override commands.
>
> Also, this setting could be set either globally or locally, and in
> this case, in the conservative approach, the overloading rule is the
> different to the normal one: the system search path in the environment
> path variable has precedence over the global setting and this over the
> local setting, but all apply.
>
> Does it sound reasonable? Is there interest in such feature?

I am really wary about the security implications of this. Most obviously
with the idea of allowing to _override_ commands. Take for example
`git-lfs`: the assumption is that it is safe for Git to call `git-lfs`
after the initial check-out phase, but with this feature, it would be
possible for Git to clone a malicious repository and _immediately_
executing code it just cloned, _without_ giving the user a chance to even
inspect the code.

But even if you _append_ that path to the `PATH` variable, unintended
vulnerabilities could be opened. Take for example `git difftool`, which
looks for executables in the path until it finds one that is installed. An
attacker could guess which executables your setup is missing, and squat on
those, overriding your `git difftool` to execute code you did not intend
to be executed.

So putting a security lens before my eyes, I would be quite worried about
such a feature.

Note that the _use case_ you present is a common one, and what I see
projects do is to integrate the configuration into their build process
(carefully vetting any code changes to the build process is _always_ a
good idea, hence this is a lot safer than having Git configure what is run
automatically). And of course, this is already possible right now, it just
delays configuration of those included tools to the time of the first
build, as opposed to the clone time (as suggested above).

Ciao,
Johannes

Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB053C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DD1222E9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CIzZHCD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895984AbgJVJ37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:29:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:38609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509089AbgJVJ36 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603358991;
        bh=oWgPKRKEDiU5YVcmqKBks6efBA0hwdgxRrMedQBSOwE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CIzZHCD8lg+jfVrxgpMqWmFskKQBkpqqSaLgdhU8EHJ3qBRQp+azFYSXu1flyEhPh
         7qWUyYhvzqfQSfxnyCJs58m2fCDjjXLeGvJglbuJT0alfmMeo3Qhj58PF/lwdS7rwb
         j4Io7r0y0fyfnqPyi9Nx6FjWqYhemd/HuZfRsaSg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1k1RIz13Ra-00nAmp; Thu, 22
 Oct 2020 11:29:51 +0200
Date:   Thu, 22 Oct 2020 11:29:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Forney <mforney@mforney.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
In-Reply-To: <20201021172516.GB1237181@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2010221126240.56@tvgsbejvaqbjf.bet>
References: <pull.768.git.1603293211428.gitgitgadget@gmail.com> <20201021172516.GB1237181@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3q0XLPL2XSf2Syrag65neYrEd26BRN2qvUvRJlN50dzYrw1sZff
 9TQid7+lDzqqyA/db1+AYXza9NZnhLHQ/5vQ+0X1bUKuuCXsbJ/+F4fgVvicXiz9LpfU4IK
 l39h9tH0TM9KnOodMr1y9das23wAHt0VT1Q3iCpaVvg94MuKBvSjp+clINEHXf7RksiO76c
 sy3yeCWYC1985+ps2cgDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYuxD0t2z1g=:xMn4hntDgc2FUXg71iho39
 nZlBMDgQSDm9KxD6y8j+7TeM3KgHkHarx8y2JcbrjvvBlCjgmNWm5VMiXCeKYyOoUGElMmivj
 Lml2UmXTzilL3GdHQ7PdqrwNsVMingXfO+X6pKc605Gkgp5Hz+yvEmz5yBEGobfU/KOEuTGum
 XITaHGjtYI4Rg55S8UeHegfPtFx47GQAIYY4zFyuTN1nLnTmiPsHKWUh1hib21Va0VchDcI64
 0Ua4WZ5j4mZSspM8UW7icFs7RddLgGyKPAHhLfaSUyZi1PflHNOpnGXdug7PqObUUX2mirpvc
 b8KGkC1m3POCnRSuUnsB3Ha11WWGt1/34R6wEOYWdLb7PrCRpxyyy487oJO/SElqkuvgCiPUk
 xye+1HafycOCAPBVIuOboP1XOGLQ1ZaAava8ECUW4AO6d74u+Y8TZm6C2EhfyqjAxcs0zcgGa
 rCJ03M0XiWtCBdkMeiH4241f9R8SdrQEWZEpGaVIznvJW/VZs9KBBJrnZQE7zEccLPh+mt8VK
 qXWP81RHlnwOvYHYyLsBDKMHQCQEDFFoZRB1d34rBnajpxkbH+l+nHFffC/xh92wjnZCQ/Fue
 Cxt1KI2kMytV23egckjD2n6d+PoiBAwQyYNt1rdTVmiGukefDfU17ux1U+Dgy6FKqcrBdi7bt
 k+jFhnQuDd+8SyRAf/yhGLS9NflnTot/Vv/KcQP0EX2VASw16x2h+eb+IGpoj85twr4U1CH2p
 c51RJfPMXPF17qIivQzWayKJGI1dLlYLKyzyhUaNoGqxj2YHOALi5cTmGJNU9BJ8noMDI+0eG
 WwZiIt4jS2eUKJg/4sZ3sFm16MQmtszBe+0gHRFpWWm7ssUNfaNc2z5Q9hWJAHYqsUbFjOaEB
 kMg+EEjJOO55R7M1MN89v1PpmYCWzAtshRDWjhT44=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 21 Oct 2020, Taylor Blau wrote:

> On Wed, Oct 21, 2020 at 03:13:31PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The idea of the `SKIP_DASHED_BUILT_INS` option is to stop hard-linking
> > the built-in commands as separate executables. The patches to do that
> > specifically excluded the three commands `receive-pack`,
> > `upload-archive` and `upload-pack`, though: these commands are expecte=
d
> > to be present in the `PATH` in their dashed form on the server side of
> > any fetch/push.
> >
> > However, due to an oversight by myself, even if those commands were
> > still hard-linked, they were not installed into `bin/`.
> >
> > Noticed-by: Michael Forney <mforney@mforney.org>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
> >
> >     As reported by Michael in
> >     https://lore.kernel.org/git/CAGw6cBsEjOnh-ZqXCPfFha=3DNYEdy7JDddha=
=3DUzAau0Z1tBrWKg@mail.gmail.com
> >     , the SKIP_DASHED_BUILT_INS feature had a bug I wish we had caught=
 in
> >     the -rc cycle. But at least SKIP_DASHED_BUILT_INS is still strictl=
y
> >     opt-in, so the damage is somewhat contained.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-768%=
2Fdscho%2Fskip-dashed-built-ins-still-must-install-install_bindir_programs=
-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-768/dsc=
ho/skip-dashed-built-ins-still-must-install-install_bindir_programs-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/768
> >
> >  Makefile | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 95571ee3fc..1fb0ec1705 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2981,15 +2981,12 @@ endif
> >  	} && \
> >  	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
>
> This does still install 'git-shell' into my installation's 'bin'
> directory. I'm not up-to-date whether or not we mean to still be
> installing that, but, doing the same 'SKIP_DASHED_BUILT_INS=3D1 make
> install' on 'master' also installs git-shell, so I'm fine with that.

Yes, `git-shell` is not a built-in, that's why.

It is added as `PROGRAM_OBJS` in the `Makefile`, and it has its own small
`cmd_main()`. On purpose: the idea for `git-shell` is to serve as a pseudo
login shell for `git fetch`/`git push` to do the minimum amount of work to
ensure that only `git receive-pack`, `git upload-pack` and `git
upload-archive` commands are allowed. Everything else is blocked.

So yes, it is installed into `bin/`, expressly so, and it is not a
hard-linked copy of `bin/git`.

> >  		$(RM) "$$bindir/$$p" && \
> > -		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
> > -		then \
> > -			test -n "$(INSTALL_SYMLINKS)" && \
> > -			ln -s "git$X" "$$bindir/$$p" || \
> > -			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> > -			  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> > -			  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> > -			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
> > -		fi \
> > +		test -n "$(INSTALL_SYMLINKS)" && \
> > +		ln -s "git$X" "$$bindir/$$p" || \
> > +		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> > +		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> > +		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> > +		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
>
> OK. $(install_bindir_programs) is the set of programs that we want to
> install; that makes sense. And for those, we definitely don't want to
> skip them because SKIP_DASHED_BUILT_INS was set. So removing that test
> makes sense to me.
>
> >  	done && \
> >  	for p in $(BUILT_INS); do \
> >  		$(RM) "$$execdir/$$p" && \
> >
> > base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
> > --
> > gitgitgadget
>
> Looks great, thanks for turning my thoughts into a real patch.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Awesome, thanks!
Dscho

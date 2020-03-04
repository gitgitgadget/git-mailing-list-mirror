Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77471C3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404E02146E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cCKu8js6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgCDQlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:41:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:59569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgCDQlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 11:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583340084;
        bh=18+2tgQgeq0abkXcOSMxkdDOwWSFOcFQKrjtqcV6d0Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cCKu8js6mh2JdteBSo46wedS49GG88feKowPqM3ge+MDPzfTUe08zKIEd6K+Gmxg5
         E/46SyVCNAZNZlfG1LpNnljAf9O51PdljW36c7Xal0fpiSR3kMDqhJcHrA6vIO6bdt
         F3b001MQkmUyGuwkhRMu7HarUsYdMCTHD45UC5vA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.189]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MoO2E-1jknlc0of2-00onoJ; Wed, 04 Mar 2020 17:41:24 +0100
Date:   Wed, 4 Mar 2020 17:41:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
In-Reply-To: <20200303173625.GC1571684@cat>
Message-ID: <nycvar.QRO.7.76.6.2003041741060.46@tvgsbejvaqbjf.bet>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com> <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com> <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat> <nycvar.QRO.7.76.6.2003031430180.46@tvgsbejvaqbjf.bet> <20200303173625.GC1571684@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iwbaYE2JS5IgXN65fHtS7qbqc3+NKdHd97gYEgDzOoA6UhViDD6
 P2E7qwlYArdJ62RmsGA3acdKu1/lDBZWeViuuSGvFyO5zJCSYbun2bjmXn3+1knYuU2kfpE
 0keII1Wqm7y/O/6IjiTSsEfNspH1k1n5NTlyk4mIRdRHifRWdQlBH7cpeRgrhaPwGEZJfQf
 lkalB+Vq+IqnLN2CdiPWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NNDuS4e4OKE=:3jeIuUfy8XpWL9weSJ0EBR
 Bfj9TH8vGKsiMk/c/2q0MzRfj+zueTaC+OxcUn+2Fz+yRWYOsFXH3vFNWawMRLNfIpHMDKvSJ
 1DmZ+AsKIO4LClZ+EnN3YgxeY0XDY2kNkx+XpnQvctJ7N50opErt5YUFWeIG1z0dtsrP2VfmX
 xOnPzfStfnuuO36MciCFCKDNSsuL+k2wwgTfw4rjI7W7yxXAQBjeTBgHHzdfWN6UtrTbyYtNa
 +U7f2RbUPu+vmASMiAWUqa+MRCsvFlad9HU530yVRzfm7avE12DLuP+iLZFPzWcpVpLuyOVOV
 0Nk8nTcC9Xoi7JC8d0VtQJVkIBfN90koWRYSpM+MjmzSwRJ/3HNjoGBxrwJzVHx2X5n1Crn09
 YbAu5ZC4ucPRM/ZBfLJ7SxIgtonxHIk96iTcZJtu0RxHxdbk7puSbiB34BPONkUA+bk4HWajL
 bxCkOWJoqO8QlI26wCyDLb2A8sKn0jqs/fT1OhmghDgfL9eiqnpu8tQ5WZ4/+oo8zX7qr07Hl
 UiKz36G+/3zhOgcZwFGaEZRUHfnnBqveBNH8rL20DKCDngswuLoHPKUJlLzjT+6ONx5OPge8H
 sa5Puk6ETKoGCp55g0pKKcBfzOHfpdl6QsTZJtjbtWrnXz2bT7uDYxeyB0ApvoRoGla5nlJHK
 zzi6b0XOnSi9mxyXL8mfI6ceNekFgNs+o7A1z878ahkKRnWG3e38i6LuXNj3pQFAHCIDkvpkJ
 Ryo0PY9p/Fz/o47AUYHnrBuxB6c4idK3ODE67guxsJhXc09y4mRAj1Enpr2lyL5XwJ6YDFPzc
 oh1zWz2ZIEEiEvhRd6dfx5nqlcZBgHDtjh4cwW24qwNVjoz4jFnWC2Bs6jTUw6RKg9yo03NbU
 z7suO54UUisEuLTRuNNhZn760ade/yBDZScm+WFNQtgv06tG+rarnc61sQUooSMVGPYmu35DQ
 bu5aUfSyy2yTESJbhkze2EJhhLNmptV8czxjY57+mEphN1IPxo2yHNTG9MarQlV7NbVVt22Bp
 WUcw7CHbgyUdA6i55DaYMje21XYrBw9RcqWsEFwbKOBPgiZgMZs4mF8JwTLBY70spbptTXQWH
 p3tMM+W7sEoiAYehldCwEVkkJSFwPsc5rDxs36AniTJryyhDz1FlscdhaWPRPsH1kCsGqlCmu
 8BKAHoZXULUMwkm0yFiFZIKOjdnctqpJQyjA4JVNTzXcSCyTa5RN7a7tg21zAbvVdvrGVZ0rk
 Da8t7XO/IghlTsiUd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Tue, 3 Mar 2020, Thomas Gummerer wrote:

> On 03/03, Johannes Schindelin wrote:
> >
> > On Mon, 2 Mar 2020, Thomas Gummerer wrote:
> >
> > > Remove the stash.useBuiltin setting which was added as an escape hat=
ch
> > > to disable the builtin version of stash first released with Git 2.22=
.
> >
> > Great!
> >
> > > diff --git a/builtin/stash.c b/builtin/stash.c
> > > index f371db270c..5f4bd693df 100644
> > > --- a/builtin/stash.c
> > > +++ b/builtin/stash.c
> > > @@ -1558,22 +1540,18 @@ int cmd_stash(int argc, const char **argv, c=
onst char *prefix)
> > >  		OPT_END()
> > >  	};
> > >
> > > -	if (!use_builtin_stash()) {
> > > -		const char *path =3D mkpath("%s/git-legacy-stash",
> > > -					  git_exec_path());
> > > -
> > > -		if (sane_execvp(path, (char **)argv) < 0)
> > > -			die_errno(_("could not exec %s"), path);
> > > -		else
> > > -			BUG("sane_execvp() returned???");
> > > -	}
> > > -
> > >  	prefix =3D setup_git_directory();
> > >  	trace_repo_setup(prefix);
> > >  	setup_work_tree();
> >
> > However, this is only needed because we did not change `git.c` at the =
same
> > time (as I had done for `rebase` in 80dfc9242eb (git: mark cmd_rebase =
as
> > requiring a worktree, 2019-07-24)). In other words, I think we will al=
so
> > want to address this part of `git.c`:
> >
> >         /*
> >          * NEEDSWORK: Until the builtin stash is thoroughly robust and=
 no
> >          * longer needs redirection to the stash shell script this is =
kept as
> >          * is, then should be changed to RUN_SETUP | NEED_WORK_TREE
> >          */
> >         { "stash", cmd_stash },
> >
> > Other than that, I think your patch pair is good to go!
>
> Ah I had completely missed that, thanks for catching it!  Will send
> the updated patches shortly.

Thank you for fixing this so quickly!

Ciao,
Dscho

Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3AC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA53221775
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 08:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XruMJXZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508555AbgJVIrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:47:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:59303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505946AbgJVIrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603356433;
        bh=syhA6YI240nyFNvlOxJLcTJuQTihjxeAlJ95jPbUt28=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XruMJXZJgriR/x/lwRqVsB+JxKpzBOMHXywSt2/LUxsHPndGk3lzkkN6Bt3/KmuVB
         FBYhp7lo2+Y29fxaa/SOLiv/tqj1yUoyHETgsClU5hp0M9WUFGW1jqzFoUIqJcEGEd
         hfp4iHZUXTMT+UizS+/wWWVgNNZHGO2mxjqv+WHE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1kURO11Zu8-007nFX; Thu, 22
 Oct 2020 10:47:13 +0200
Date:   Thu, 22 Oct 2020 10:47:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
In-Reply-To: <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010221042260.56@tvgsbejvaqbjf.bet>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com> <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UmFi3CQ+Tjdvw1lJ5+dCSCWjsjjfjOznv6IvHX2Rd4gVeQAMxRM
 CRtFyEf+sUvLI14jy8jp45xmhXci36pfCP5ryOmvPhWIFUu3YIfMzDlgetS3IcD6EW1a4L3
 QY0s54bk8POElG7Y2aGucley5dCIwCkfa4YcNbeE9lYwqaV3wqt9LNUKPlYiEhzvCtzGTEf
 eeWzJoNGI0GGSb80alQbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KW2FEn1OOxM=:JDPBly/fscBJ5ZDbktMb0t
 d/CX52p5PafcsXi6xNfgp8Hgh8J6JXQyp2YEPnK8M9TL3SAb7wSCe//Atb/VR+hAWClFiQi2W
 MuK5kgghZnKJy+86POzboxoNrdicIDmUZ+Rud1sdj+RVtKU5UoLsyLAwu8Ov8qCFsF9JPmhcS
 9ZQeRFeI7Ma89brYS7yKrEBz471jRXtRfmhBC8lWyeSaXf/aKV5LdyRBdv+LF/WOqaUnGo2fW
 Xmc0Bah7NnxZ0jbnXPXdlLxcY3N54f0/HqazcOvVjlZtxxDiMF3QKAGujoWsXYEWSPgDEkORD
 IFO0OZEdXFmJOhMHp6NnBjs6UEcO7cJP5NaReNmkD0VfjOVJFGcLp/Q5EsoVNKdBYF02gQ/Xm
 djmphwU2hmuCRlf3GfPo8eJOb6PQuQ6aGoPMggFf6NZj0PEdYNdriBd1kfDA+QDF2fjV1On0N
 AJfBrSL0ZoroKRvDvoXmfduvd6AkELSk7EEzAHMAyAzIk3EFLvdll/tTPC6fK1OjR5mlr+M5A
 q5qQ5D0/fXYHz/r1PIz8QUkOkKYIW2TXeKuGGKcjbL0b2POQtLZY7Ye9s0Cz9ZmCmstkUHIbU
 YUYaj3gPUitMl5hG2YKCke3SUxsbXW6r29dJt7ZKX1Y1A8s2/ePkdhdFEbGDvYJGn9a3nsEfK
 ov9Ai2n/6oUuNeO73UsjcGUvzzXEC03MJQXOmjhnqsOqwQIHWgso1KAfPQNynS6YYg93XOnBl
 JalmHWic/SYiqBrihd4NAFE6pciALAUrbXVNptUzf6Fjc3ERG9BB/YA11C5xUUgmxXKaeOAcT
 WeBqqaQAsXQA4t4ApjKVUuQG454VCjvo3LVXGCMUquLyM5MsU4/mzb2ATir2XgPruekIJ9E4n
 LBwM+HxMsHIHQKF6QMfkrcaNyZMOwhwSAKS4sH9Cc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 21 Oct 2020, Phillip Wood wrote:

> Hi Sangeeta
>
> It's great to see you tackling another patch
>
> On 21/10/2020 10:09, Sangeeta via GitGitGadget wrote:
> > From: Sangeeta Jain <sangunb09@gmail.com>
> >
> > As `git rebase` was never prevented to run from subdirectory we should=
n't
> > prevent `git bisect` to run from subdirectories.
>
> I'm not sure it's relevant to bisect whether or not rebase can be run fr=
om a
> subdirectory.

The relevance is this: _iff_ we want to prevent `git bisect` from running
in a subdirectory under the premise that that subdirectory might need to
be removed, then why don't we prevent `git rebase` from running in a
subdirectory when that command is equally likely to remove that
subdirectory?

> What is important is that we want all commands to be able to be run from
> a subdirectory unless there is a good reason not to (and there isn't for
> bisect)

There is a difference in quality here, though. If you run, say, `git
fetch` in a subdirectory, or `git commit` or `git show`, there is not the
same worry that that subdirectory will go away as with `git bisect`, `git
rebase`, `git switch`, `git pull` and other commands.

> I'd recommend adding [Outreachy] to the beginning of the first line of
> the commit message as well.

I am opposed to that. The fact that this comes in via Outreachy is
interesting at the moment, for reviewers, but not for posterity (i.e. in
the commit that will make it into the commit history).

> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index ea7e684ebb..9cd0fa0483 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -32,6 +32,7 @@ git bisect run <cmd>...
> >   Please use "git help bisect" to get the full man page.'
> >
> >   OPTIONS_SPEC=3D
> > +SUBDIRECTORY_OK=3DYes
> >   . git-sh-setup
>
> `git bisect run` takes an optional script that is run to determine if th=
e
> current commit is good or bad. If the script is given with a relative pa=
th
> then we need to make sure it is invoked from the subdirectory that `git =
bisect
> run` was started from. As far as I can see git-bisect.sh does not change
> directory but it would be good to have a test for `git bisect run <cmd>`=
 from
> a subdirectory.

That's a very good point. We should first add a regression test for
exactly that use case, and then make sure that it passes.

Ciao,
Dscho

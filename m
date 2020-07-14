Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A13C433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AE42074A
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bpz4rBF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGNUia (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:38:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:40467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgGNUia (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594759105;
        bh=HHzBOhyO8/f7iPaariHJ07EisamB5hFHBe7Q7q7ASLU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bpz4rBF41uz2fE2Djh4bh58wQp+uOUTyQXkWu8VNZmArY1JEDiybFkYnjv/Md27Hj
         Ii45jW1j9th8u5N7/0X61SkGMNOsj+sQx+UoL13CK1U9eaO99o91ba3MOaEBuqdf/U
         u87aOCOVHFzav1pDLfKNev3eCedG1GLVPzyxhFGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1kN2B23b48-00Y9lK; Tue, 14
 Jul 2020 22:38:24 +0200
Date:   Tue, 14 Jul 2020 22:38:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Denton Liu <liu.denton@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [RFC] should `git rebase --keep-base` imply `--reapply-cherry-picks`
 ?
In-Reply-To: <9c6dff59-b204-1ace-e0aa-0885dd502214@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007142236060.52@tvgsbejvaqbjf.bet>
References: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com> <20200714031017.GA15143@generichostname> <9c6dff59-b204-1ace-e0aa-0885dd502214@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:blN4yEoB0fnAO3TWix+8QulpEhvyLmIjlFr6cj3JRigqkwrhPUS
 +v4yNcndHYON7KuCAKfx8hG6VG0YFKRNtsVH3z0D8LkWl3ffqKdD46VWILcN6dhQ3jUnXqk
 32VT2Q8ctbCzNIoknurIKUnfC6zhOJ08EwK/xB6wLtkN7wh4UOAFK5GO3m+rnmiTP4K63UV
 CCe0aWSDQM3KLg2695fXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l7Nsm0vxxZQ=:eVTBqFf/6+RvdTexcDAGvf
 BzXgM7LsLCxvG2OVHcw81KscnMPlGHUbEqIwp5dR7idzEsEZf69PLrbjRQ3UZZZULJsuEgPe5
 EmJKnk5EaoR/sXC2fBLTmjDfbYzndYs+t7nGxRAhpvqrdMUP9rYslzdyH+mt4gfV5b6NlfGwL
 +fwtvfoqbxd2OSDesQDwSyz4U46TzXFuycV/AcFZ8b+74CgHCpCUXQQ6/TW4WbjEc3raXBDlt
 JKFfmJsiA7KgHt75o0CibrF0qwTQ6HLaRVevhzEhk0B2C454Ymb2kkDFHrPmFdjXF8z3PULjE
 soYzt+oyb3f3+5xTQo2jDfpeqFkeZgrEfu1307dVYJ/91mgwgNuNagGsaJaTS05y/z6jKsm0j
 npdM6RcDT8+Pq0djIMjB/fTMuHoowjENlRfqrGeEv1YfwC+OS8ShgBpLX/Q397KICrsL4UpvT
 01OrYb9AVRxj2QPMBosBwX5MN7Ukri7SUKmL6JFzumBHGmxwasPi9lSiBV/ZmvDU8GWbiGumi
 fhBs5DNmGzRba+9Lzi1j4ZZNiFalolbOE7Esm7nkyQaFZHAka28dKiHA5U76LkDmniLr7G1U9
 Zwr44loiozJwgcvqIc01f96Qy9fPaNgbnndWxqbucnkcLXqKgJKv77CBt2ckyErF/t7PUj2e1
 bOJXyoWEkymnbJ5X1hr3OMUBnNfXG5tI2O5dB39mltBZIc8GouFM24C2Vf+WRXrHFOIwK1WFC
 VRr5a7AniRP/rxts4Wc6i/S/obTb+4EtIC58MLttN5cMKIgAaH6Ofdb7vjxdmjTuJ50JYuz6h
 varByIovwIxCUVm/tYu68T+V+j1OakNL4HmWLXMvcNgUcZqHDyfJh863YnALLKIEfwqGEGmED
 odTPWZ1Fsq3O1pf91ZGf5LTS/3FUIeUYEW/nWD7HdWkjrMQ75wr3RmP/ubyuhxzuAUY6Q8z56
 xytEiDgZN7KNmNoMAjqwgq3Uw8l8++iUuHnTrG+d5K5iVA723FqeMemaZ6LpfzgrpFGyLZ2vd
 KRwfTL9o3OGzBtV0keb/M7fG97irGKz9YdU3998vAn/T4PXgkUM7SNsIVj8P3QzhyKrdFKb9F
 4NcWmcUOy/uzDFhDnEDMrL0NEJgH8FB8M71wVNazvSIKLpv8j/+sWd4ozfWEW9s2veMuoxgR9
 KGaa1ohsP6j9/JBTDDnxUMx2EAWPGuGHKlaFneqtvJ7ZTQLAdj56HJnM2ubGL5hYGBv0BzOKV
 bDkOskFuwm+5qpUg8HFWrVwuvnl6p64nOq/5iew==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 14 Jul 2020, Phillip Wood wrote:

> On 14/07/2020 04:10, Denton Liu wrote:
> >
> > On Mon, Jul 13, 2020 at 10:44:06PM -0400, Philippe Blain wrote:
> > >
> > > I learned today that doing `git rebase --keep-base master` will drop
> > > commits that were cherry-picked from master to the current branch. I
> > > was simply doing a code clean up on my feature branch (the full
> > > command was `git rebase -i --keep-base master`), and this kind of
> > > confused me for a moment.
> >
> > Glad I'm not the only one using this feature :)
> >
> > > Is this a sane default ? I understand that it is a good default when
> > > we are rebasing *on top* of master, but here I'm just doing some
> > > squashing and fixup's and I did not want the commit I had
> > > cherry-picked from master to disappear (yet). In fact, because it
> > > was dropped, it created a modify/delete conflict because in a
> > > subsequent commit in my feature branch I'm modifying files that are
> > > added in the commit I cherry-picked.
> >
> > So if I'm not mistaken, if we have the following graph
> >
> >  A - B - C - D (master)
> >       \
> >         - C' - D (feature)
> >
> > and we do `git rebase --keep-base master` from feature, C' will be
> > dropped? Indeed, I am surprised by how this interacts with the
> > default setting of --reapply-cherry-picks.
>
> To me the question is why are we looking at the upstream commits at all
> with `--keep-base`? I had expected `rebase --keep-base` to be the same
> as `rebase $(git merge-base [--fork-point] @{upstream} HEAD)` but
> looking at the code it seems to be `rebase --onto $(git merge-base
> @{upstream} HEAD) @{upstream}`. I didn't really follow the development
> of this feature - is there a reason we don't just use the merge-base as
> the upstream commit?

Those are interesting questions, indeed.

And I dare to suspect that the answer is indeed: `--keep-base` really
should not only substitute `onto` but also `upstream` with the merge base.

Ciao,
Dscho

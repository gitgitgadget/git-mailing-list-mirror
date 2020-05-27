Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BEC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31B4207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TEgUWuxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbgE1O07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:26:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:35625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390932AbgE1O0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590675992;
        bh=OLrcilRuAkm1mMYQ19Q2H0BiMT3C70dvTdu7eQ92aNQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TEgUWuxelKw7AYGZrCHerELF4SISaaumvS/W0mFKxNTA3gHXItKbV9cqtnD4hk04X
         9aOpBK7PmFMjD9fmQqSxm+JpWmcz/gF7E0pss8/EY8TNLX+J+P3u9PeEOWee6Y7D9T
         pkEjTRKdax31NrLV6DXjBc6QHKMlRIRvUIdvAvZI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1ipFIk38O1-00xoyn; Thu, 28
 May 2020 16:26:31 +0200
Date:   Wed, 27 May 2020 23:52:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
In-Reply-To: <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>        <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>        <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>        <20200407014829.GL6369@camp.crustytoothpaste.net>       
 <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>        <20200408000149.GN6369@camp.crustytoothpaste.net>        <20200527223907.GB65111@google.com> <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VMfd3DuOcienVkHYxm12/xQDXh1KwOoeJu5WCFDeBLJwT4iYLAa
 v5XwJvRfK7fyJtqITYzkZa44/eVMw8k230hr8ffKakFZvZ0CXfV42eM9DgbltcVqRk00Rfm
 S8k4Gzuv0C/Wzu9zEzqxH142Rry4SPA3fcir2iUjkD2t/FsX7BnJNRNaG1wMf6zBVMNcfQ+
 sEs4vfwuZjL6O6xKyV9og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I7oQZhk/9Rk=:J+GBK23SWo+u3J/5ZSJpGm
 kSkhh+Kfqtl2XxAH5EOYS0N/Z3vJlre3tGXVquZ97zOqYrN9Rmlggp+JJJq5kFUNf3SSS83OT
 0OdXYn0sS6H0PIlJ3edrpMcXpIY4amgvKAjlBpsQas2M30azvaKjsOE1iILbKcD0abns7ryga
 Pw+eZe3GwCL76smwEa6asAU9VNE4i865Pnm10TVUNKimEhtQovNmFjy669PcoKLd3Tbx5qIv4
 /1lLZiTUeDxiGZKO8h4nzy0spUT+8OmsMG/dOumXBAeZFlOMUMBCtpE4D0OoKkYQps5F1MbZJ
 WJkIL+kU5bgEXGj7zyY+l95Ko/Ky4Xd77PJlUxkcf/uBmJOshjfsHX1nZRhVLRS4Eg1atOfF4
 OkAfxWEJnRNWn63paIEniFIpFNzh3nntp2qdAX/OHZhtrNUgeZg1Z1Jw7nFWywAxySWhyFBc1
 ywgzVZR7bTujvMyZYogd51eGOPNgLMbTcvKlCd39MBFakr0lA5BDSQ6FC/57sQ4AjsbOVphiK
 FXynDtSngdPE9fclrJBGDyHK+PGruU4Culi66Pf/KQEz6jEgkBPyG5jmqdkEdDN/O3wAAe7nd
 PQ2j/sOXaZkPW/xvbUzxxeGx1DhADwtU/2fRa9mO14Y4SXPV0h0cprCKwYrCji8SVr5fCaCrD
 WalX4/M87J4iJMmIvLJJM29R1q8uGtrrOjf+oucaLqs56SaDmp3LJqU6QnLHYB8Cc7Dm3bZML
 NzKuLJImkUxlwn2PfMkhclYIJoxhuC13OvNOjkUoiHyu1CpY0q2MRsq3upWmMQxThm9aHtPf6
 aWuyAkFCi5ni3b0AgOS7zH/s4wAxKhhelQw1rvrdxtBCKHLbtc8UTbcfaVZ/bS0rwHav4ib33
 mxleRy+gHbYZSqdN09ghM+1K2HZbn3LGxuBTCQCYnyO+FJENGZ97D/Fj7hAVRHOK6IicP6lVT
 npfXnu23HFLmQQyZUz/ergzvQ3ixOF8GcKN2BW0ERA4UXBjLBnTxUKsHJ0WOZQo+66QhClYu3
 R3Khe34FBa/XiwvKzGDHxj5L92pKYPn3hhoIuWukH2TTjQi/B2LNShBGeSP7WQ1iLmFMZekpe
 zRDOJJ097FqN2cSvqRFZOfHku7qSdLkaLv2hDmlCxsKvpPx/HgMES4oiCd4Lw1RQKUmxO/2sb
 Tt5//B1peZWpiDI9Z+Oes3dGjFCswY16ieNoS+zaW7CRP4Sw//W4t0HtRyp1Zi9wmcy8hABVP
 IZtYwJbrR2GF5vi7U
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 27 May 2020, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
>
> > Regardless of what happens with the job-runner, I would like to see a
> > top-level command that performs a single iteration of all the
> > recommended maintenance steps, with zero configuration required, on a
> > single repo. This gives an entry point for users who want to manage
> > their own maintenance schedule without running a background process.
> > ...
> >> Unix users will be unhappy with us if we use our own scheduling syste=
m
> >> when cron is available.  They will expect us to reimplement those
> >> features and they will complain if we do not.  While I cannot name
> >> names, there are a nontrivial number of large, enterprise monorepos t=
hat
> >> run only on macOS and Linux.
> >
> > Speaking purely as a user, I agree with this point. This is why I want=
 a
> > single-iteration top-level maintenance command.
>
> Yes, well said.
>
> It exactly is what "git gc" was meant to be.  To put it differently,
> if you asked any non-novice end-user if there is one single command
> that s/he would use to keep a repository healthy, it is very likely
> that the answer would be "git gc".

The biggest problem with bringing up `git gc` in this context (and it is
actually a quite big problem) is that "gc" stands for "garbage
collection", and these maintenance tasks are not even close to being about
collecting garbage.

So while `git gc` looks like a good candidate on its technical merits, the
usability/discoverability point of view paints a very different picture.

What Scalar does is conceptually a _very_ different thing from letting
`git gc --auto` (which I guess is what you _actually_ meant, as I have yet
to meet even a single Git user outside of this mailing list who knows `git
gc`, let alone who runs it manually) determine whether loose objects
should be cleaned up and packs should be consolidated.

Like, pre-fetching a daily pack in preparation for the user fetching
updates. You could argue that this is, in a way, _accumulating_ "garbage".

The entire idea of those maintenance tasks is that they are _not_
triggered by the user, not even as a side effect (`git gc --auto` is very
much a side effect, and on Windows, where it does not `daemonize()`
because that concept does not translate well into the Win32 API, having it
run in the foreground is very much felt by the users).

Those maintenance tasks should stay out of the users' way as much as
possible.

> And having such a single point of entry would be a good thing.

I guess I would argue for the introduction of a new command, like `git
maintenance`, which could potentially trigger a `git gc --auto`, but is
primarily intended to run _outside_ of the users' work hours.

Once we have that, we can always figure out whether there is a convenient
way to register this via `crontab` or Windows Task Scheduler, without
asking the users to do all of these tedious steps manually. I, for one,
have to spend the extra time looking up what those positional numbers in
the `crontab` thing _mean_, _every_ _single_ _time_ I touch the `crontab`.
_Every_ _single_ _time_.

Therefore, I would like very much to have a `git maintenance --schedule`
(or something like that), even if only on Windows, on the grounds alone
that it is even more tedious to work with the Windows Task Scheduler. But
I would prefer to have that also in my Linux setup. The convenience for
the users (myself included) is just too compelling.

Ciao,
Dscho

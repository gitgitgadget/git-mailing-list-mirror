Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529CCC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D9B610D0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhKSPr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:47:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:49791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhKSPrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637336689;
        bh=HCDEiqRzhDtKoaSz9lTBTNyH6iB66OrXuoQY4qikleg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hNDt6w8UJvuunE5vwrh+8Xu900snLEQuT4o9GIcspbLWVTakwbellUL+yfYYJrIza
         qR6Cgg8TxcAU8e/9WALTfNf++9PooUXyvO4E1TpEBR4SMK+ShFkeN+nEJiO8CaWx8u
         xUwkIf6ykfGTWhDOxdOBNrWR5/7W3VXvHUOc7TDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1nDM970eqi-00RXGl; Fri, 19
 Nov 2021 16:44:49 +0100
Date:   Fri, 19 Nov 2021 16:44:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Makefile: fix parallel build race
In-Reply-To: <211119.86ilwo4o8c.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111191625002.63@tvgsbejvaqbjf.bet>
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com> <YZR0djZbRUicXcQm@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet> <211118.86tuga5o68.gmgdl@evledraar.gmail.com> <YZWqK38NRjD7aPOG@danh.dev>
 <211119.86ilwo4o8c.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-130374965-1637336688=:63"
X-Provags-ID: V03:K1:lDPzDjA/rl3DmFLrhKGk2FbuqaW94RofoNiOXyv5uff1y0Toqg/
 bEf5zLCZ1f+c/Y9l+QPNVPuvWgKcvJMDarvnU7bBqSVK0wKH2RmQRpWnLTQzlTYl8mMc+ru
 DfCXvlHuEuh9WdjRr9SeDuzIoT8hYLZkkNtFqYqgBtWXBMaGJnSjwFcQZkQ8gOeqpLE1GKX
 PGxItuTsoWl6UiBlFXyaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9M/o50Ny1A=:kVLMtI5jWRjXXNTJQ2oRr7
 Wq7pkSxnyXZ4LpOuNv3M/HM10gIUzkmVpjIFNtoktUZ2nt4Fu5fqAhVZKU7wSTD9p18VzEgiF
 BUql3MIsU8zC9xrke9bWEkAv5mhRmP/jMgcyahlKF1VHy7PvudzLlJgmplIX/tfzLK4TYnD/5
 l54thfaMXQ4ej7uRlK1EOjyVJUh6GCcLjyl2VviYMgLLE+06vY90+y6FNrbJm3HiYTg8m4fq9
 WT6vA8Ea7u+tj45GIBOWHQPpf/weUJJ94r+1cSBB/wd4WkSZ4ANf3lVa+/35S9ZDfPQFECGGQ
 09U/hCaKoHKLo16RdDepgdx27UQevkuUUEC3R2UZljiAqz9eYog2HdjPD0L5UuL1FIBhOjPhu
 YgHiPIWn+1BINOyDvqP8LFbzfkOOiarN70P6x8UP2RZBpK1rNyDvJxzokva6pgWEbGGZYQA1Y
 iiE8oK88uPYDRRyRcECQlvsZq3pHft9cRb46cYo0kdUTiP+QyqXWiiYSBCcZjrOU/f0Rwq6LJ
 gZNhwGFSaaXGcYzqMUwqR/4IW07TIIja9FlB6E50y7ozLYt6r+64qATVxgW7dIbB0MafhLULt
 c0EBq9OzcLmEbklydu1Jwd/mxahvmptH/7N8D+46A4hh98T9z4TgRTXuIG+gNhRHv+opKicK2
 zl6TQ+YGHzn8Oyeqi48ExumU7dA/oAWfiIOt+zs6V8B+V7LFWp2NuInH4eocrEwidzf1pVxXS
 ts9eW1HH4T/IUTbCwQ3e7LtvFQ4QI2PJvucTnGDcPcNXgrcASP9KPocTUhPrnZxygcpKZI9WJ
 DX/tlQM/7FgNsxYYIjB5QZwPguieqL6NF2i/K7ZkowI5AI5BWUhSuQ9XtqgCYK/HkO3dyiWbA
 jAlaNXcuUO5vwawRk+KlOtqacuaan9rfx3HfKQaLI7JmJe0NKUVcPDlELH79VPK4sVKz93PCC
 NZOYZkoBQiTGbITmoLc2DzZs+DenOG43A2bjSkbFV7VvT5zY6M9lgWZ+qzZmdaQqoztbhBz4k
 0+N3YOUyBXIZXWfnsfXOz1EE/jZ0Y2mKFp9H0KjLb2kyKnjrzvvaxwbs3kSrSlFPyNDzIGGbg
 jLr3m4tRJruB7Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-130374965-1637336688=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 19 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I think getting it working on non-Windows if we're going to keep it
> (which looks to be the case) would be very useful.

The idea to extend the CMake to more than just Windows is contrary to what
Junio said in
https://lore.kernel.org/git/xmqq1rmcm6md.fsf@gitster.c.googlers.com/:

	Let's not worry about cross-platform and instead stick to Windows
	and nothing else for now to expedite the process.  As long as it
	is advertised as such, nobody would complain that it does not work
	on Linux or macOS.

If that is not enough to tone down opposing opinions (the opinion of the
Git maintainer is more important, after all, it's his maintenance burden
so he gets to decide), you can also look at this statement from
https://lore.kernel.org/git/xmqq8sikblv2.fsf@gitster.c.googlers.com/:

	I already said that I feel that engineering burden to divert
	resources for CMake support would be unacceptably high.

The only reason we have CMake in addition to the Makefile (and the
autoconf-based) setup is that CMake makes it possible to build Git on
Windows in the development environment with which the majority of the
developers on Windows are familiar: Visual Studio.

If it weren't for those developers, for who it would be a ridiculous
suggestion to "just go download GNU make", we would not have the CMake
based build at all.

And I am still agreeing with what Junio further said in the second mail I
linked above:

	[...] it is unclear why it would be beneficial to slow our
	existing developers down by forcing them to become familiar with
	CMake.

So now we are discussing to extend the CMake build to allow Linux and
macOS developers to use it, to, for little to no benefit. We are very much
in the situation where we are slowed down by discussing something as
non-essential as extending our CMake support beyond Windows, while patches
that are provably much more beneficial to a lot more people are left
under-reviewed.

Even worse: reviewers who _could_ provide high-quality reviews for those
patches (which takes a lot of time and diligence), but are as much pressed
for time as I am and therefore have to choose wisely how to spend their
time, are _actively_ distracted from spending their time more wisely.

Can't we please focus on more relevant things again? Pretty please?

Ciao,
Johannes

--8323328-130374965-1637336688=:63--

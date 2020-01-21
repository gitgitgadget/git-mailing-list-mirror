Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9678DC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C63620882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ibdkug4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAULsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:48:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:46621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgAULsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 06:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579607284;
        bh=HTouBxFLSjJOKaZMa4XN1xoBQcge2BIdHtIXIyGA2/I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ibdkug4CS/BXZu7F72zVBQAH24mtkGWkG7n9xtJW96vHJCgQ7KcsmcOaxmSVROj2w
         2Z9xAzplmbveHxe/nv7r8VZSfqOoG+arex8MDtOcPZWsizwdU4GinP8ijsRNFSV7rk
         secndl1euK7HW/D/Ykd10dGLa7+RTYHoHdQ90LLs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1jqoUJ2EVn-00ySMc; Tue, 21
 Jan 2020 12:48:04 +0100
Date:   Tue, 21 Jan 2020 12:47:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     git@vger.kernel.org
Subject: RE: Y2038 vs struct cache_time/time_t
In-Reply-To: <017401d5cfcf$8791d900$96b58b00$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.2001211247180.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet> <017401d5cfcf$8791d900$96b58b00$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XRbuaaiLLYs1jJ4T7EbZaDUQ5r+OhkrJ0F3525XLbtOCike02yf
 YNHQHPT/zv8HsjU1lZ5zr89ySpw3B+PlTX4OI3w3FeIkEy+AHnKNT1Q27fvajrRR8y3UVun
 WVeQ0/Z+uiKJ8+rvf4lUBbs9Vriz0TkUMgDV6TTw38c630Rzcsso1mGN54LBDTkF4vLtn6b
 rKo0iSUHpXHn+vVSy+bMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x+dGCCSxd9E=:7ojicken3TDfxALTv127mv
 r5qnJPEOGVAL0b4j4817TuFqpVqcgPVErFqBfBV62XqOv/sBLz2Ptf2VdvTtSpTf0h8VcVjlp
 oj/9JZyI5XZCWswx8uMzHF+ZaMkZD4woIiPDSO5R7wDx0yCEigv/G0XntxwjHqxQw3txQdMR4
 YwM1CFv6Zy3pLJfasH7v0vGHwNmwn9nKMYdwa97S04QcFZ/JJ9nG6nAll2UOIv41FbV9GWy5U
 +X3Inf7QlUAbyNOxfO5+V0UH0Cb/24Lb7mq4LsFVgQhbWsCoG/hwbPdAg33tQ+OiBhNTpFvAt
 TAYQc6YUhoW+61RKO1PvTYi43ThU7/6Kbcn0hS6sp4Mpx/DcP99bj/ugIJ1tGFvyQ8D+K9Mnh
 w0xL4cLHujwW1Ot6HQ7VIFhadm08uiVULU+Ze61Yuf5tKxKmUDLPX14Q7P0jXlJVf/Afoj6j6
 KM1QUK6+HtpEF0UXLTyiKdDVWWi91E5IWyJXt7AZQZeeNyyQJAYoma29PrWS4LIWoCok3Gm+R
 w7M0drqRU4vbEL6xlzEsJkY9vrOEzYmf8HVuIvhTW+u3uihkfQauuoKYD1FN0tBOXmEuOTyGg
 ZOXRzGGBwRIGl9sidtv+IhlO7vEWHuF4m9/IGJdcUIAeVrcKGhYHjV1Vezq1teSx80GzDLqko
 hAqEI6hd9+ruhpMxbuPlD/TS2Yd2joOEm1ik8EED98i0hfLjIdYT/iaVI/rPgkxd+yPtQM2HP
 B9PjIREkbMYKtPvYq2Nr05Xtl5ZTmNveMt9sEao4KLAw0LaY+Yb4EfLQjoJTGpt3Wos1OZhzs
 Wbss+o7n2HXXM3XsErq5iML83DHh2wKmVJ7iKfp5KgP/a3Bi3RDngzGFqnnRH/8v0Y4BWa2tV
 CdsVLc5d/t7litXxXUI3FVEzk7Pi7APN0xcAiNAqinlNuqAAEHYWNLxu0OLgy+11cKpAFpIi4
 hcyJiVQiY3KmoWSitrS6RviuoycJJxHm++Mhh109nLuB8/gciwzpKtQgfwcuUES+EG/oA4KZj
 pQf+TCSkxa4oAg/EyyoCrNeSJYlC+Ft9cgyg8qIpFMZjMiFdXYhWXuyyFN7on+l/IJJbpEhQl
 +17kR4QRXPFNDARatzdzr32zsLeinaEhZZts+/yrgsidL3ZUu/RX0f3RhFhxHbibkppqu33dE
 MqHq0SHL3cKQaXmdGRIL7ddoMt45Rkw9aresyINIEQNKeRJWZmoEkrHA+MpPb6JB9x95zO7Qr
 lpV56FxYWtDatzMvuPP2AAPmWZC7lsEPV1SUCvmKu9GKseR85F8PbndHnmyU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Mon, 20 Jan 2020, Randall S. Becker wrote:

> On January 19, 2038 (no really January 20, 2020 2:39 PM), Johannes
> Schindelin wrote:
> > today, in quite an entertaining thread on Twitter
> > (https://twitter.com/jxxf/status/1219009308438024200) I read about yet
> > another account how the Year 2038 problem already bites people. And co=
sts
> > real amounts of money.
> >
> > And after I stopped shaking my head in disbelief, I had a quick look, =
and
> it
> > seems that we're safe at least until February 7th, 2106. That's not gr=
eat,
> but I
> > plan on not being around at that date anymore, so there. That date is =
when
> > the unsigned 32-bit Unix epoch will roll over and play dead^W^Wwreak
> > havoc (iff the human species manages to actually turn around and rever=
se
> > the climate catastrophe it caused, and that's a big iff):
> > https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs#Year_21
> > 06
> >
> > Concretely, it looks as if we store our own timestamps on disk (in the
> index
> > file) as uint32_t:
> >
> > 	/*
> > 	 * The "cache_time" is just the low 32 bits of the
> > 	 * time. It doesn't matter if it overflows - we only
> > 	 * check it for equality in the 32 bits we save.
> > 	 */
> > 	struct cache_time {
> > 		uint32_t sec;
> > 		uint32_t nsec;
> > 	};
> >
> > The comment seems to indicate that we are still safe even if 2106 come=
s
> > around, but I am not _quite_ that sure, as I expect us to have "greate=
r
> than"
> > checks, not only equality checks.
> >
> > But wait, we're still not quite safe. If I remember correctly, 32-bit
> Linux still
> > uses _signed_ 32-bit integers as `time_t`, so when we render dates, fo=
r
> > example, and use system-provided functions, on 32-bit Linux we will at
> least
> > show the wrong dates starting 2038.
> >
> > This got me thinking, and I put on my QA hat. Kids, try this at home:
> >
> > 	$ git log --until=3D1.january.1960
> >
> > 	$ git log --since=3D1.january.2200
> >
> > Git does not really do what you expected, eh?
> >
> > Maybe we want to do something about that, and while at it also fix the
> > overflow problems, probably requiring a new index format?
>
> The preferred way of fixing this is traditionally - for those of us who =
have
> been through it (4-ish times), to convert to time64_t where available (b=
ig
> legacy machines, like z/OS and NonStop), or in gcc, time_t is 64 bit on =
64
> bit systems. It has been 64 bit on Windows since VS 2005. I have a
> relatively some relatively old Linux distros on 64 bit processors that a=
lso
> have time_t set as 64 bit in gcc. Those seem to be the standard approach=
es.
> To cover it, I suggest we move to a gittime_t which is always 64 bit (or=
 128
> bit if you don't want to be resurrected after the sun turns into a red g=
iant
> or later when we are left with evaporating black holes), no matter what =
the
> platform, and build the selection of what gittime_t is (time_t or time64=
_t)
> into our config and/or compat.h. That way, hopefully, people will rebuil=
d
> their git before 2038 or before someone decides to stick a fake date int=
o a
> Github repo just to mess with us.

I like it. If I had time to tackle this, I would definitely go for
`git_time64_t`.

Ciao,
Dscho

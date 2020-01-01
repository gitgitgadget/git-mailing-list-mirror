Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757EC2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3820722
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gGuj33a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgAAWHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:07:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:46561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgAAWHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 17:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577916428;
        bh=0BUnnJps0+aMIl3Sduej8OhhRAFtALnUPeFFEm5uGwA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gGuj33a1BjKoHd3HFURi8QS3XVJ403HLolUVI9XcPKzeADsT1qTSzf4ZDVpjYzvNy
         nUjXRILD91fFjgmG2fKghHyj3Pbp9XT9OzIij8IMZcEHznB1MZnHnInEG0eQ6bIO9N
         74s+ejwfRdR2SSGo3JoR5O+1IAy+VD/ni9n79tPI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1jIo6a1gnE-00cisf; Wed, 01
 Jan 2020 23:07:08 +0100
Date:   Wed, 1 Jan 2020 23:06:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Miller <jackerran@gmail.com>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
In-Reply-To: <BZBZ3Y9WU7J7.3PGDZKEYVQ165@penguin>
Message-ID: <nycvar.QRO.7.76.6.2001012303240.46@tvgsbejvaqbjf.bet>
References: <BZBZ3Y9WU7J7.3PGDZKEYVQ165@penguin>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o2vDAxfga0zZgtP+G6HXcgVARLwbri/TD+Zl6DErDQPV8s40Q7Q
 gm0L4j/DbIxE+y6Y8ZBEIzLhkxM3Sa7CJAy78DvlHY6Abe24DQ6e7Zk0crBIny7Kh1+w7r6
 uxO2qqkQlwgea8+Fv+tYK9YHynNv5Henc3pZDwNyyIf2o31edf2Dvhdr/PEwrkCwqGRKMoy
 GcPsCtLbigDABsJy2miug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OanBv/9P114=:7XRwSGskJGjjIqNHmrmsHZ
 abrf5uuz/5dtyPyAHf0EErB1CVL6htsa0uauRUAUvECkgDK0aHzLgYooX5GIlbjt6KXtNb5sp
 0iKPoVyV3HQN7T5V8iPf4P7kLsjxRyEVgQe0C7h6qUP3WEUAh4OdRItfuIyirPEaDXm04pALS
 DI7UHduj4gGGqTMwK1hywENVcDzYg2ywGQ0uTGQ3PZgSJ6ovhgXXvgwy7uZka1Ro+C6yxHXbk
 eabocRVCywIkkVk0dpmJZUje1y6RGOv9peg34p9BBhmMm2guxtvFbmYIn2my3hcLBoXOaEoYH
 f51NpP2+rVvjMFlineuoR1rTfnopt6cCT0T7hzehSqziWJGzdnXbWiyudPqYufVVPLWGEotbc
 g0FMdrYU6odUlcoLv3KXUY8G8kt93k7HrUw26d9sCx4bwEyKArl7LLMKDMgx6vdL3PMzveTKZ
 MhJzfWfkysZ4Mv3L7iChaX9SsVYJUom4/hcM5R7EjY/dC0k1SIOMID40B5Wt9PT1ikHuyTein
 asskYJKoogT1brMij8Xv8jHHqTd8g+DeIP73cJnrkKv53VgqWDmx52L9I9u6WNEE44mEL8xkQ
 z9i4qqIPeVB+SSud+aHQ4OhtbxuCwwPaZlM8jrJidG789KfK2HeqNYF4vReuu+BCFa873SVa4
 t/UjlxiV5nc9Ta95lnIXuRb3j1ePQLqfP8QcCzyYAa0+RqllOhct8NOuBwRIMLkBi5bGWeJ5i
 ibKILPxZNwy1XJUeRWxSz0OFXLcQ5i+QgbIBfVEc03N6Bd/0X009EuYlGJ+ZeJ6kACkpARlJ2
 ZjykfIbDo6g9o/l4507jl/ro7Z1T3+a/vJmYbPacjXm8R6pe901IKP72UGxZTyGhT/9GRDZp0
 MWH/rmJRnRhyKjOFHz96mTqVcymWzZfX8a5sEchXEILN6D3gntgt67P/Fym86E4OYJbD78fRf
 4hegfFS3TPZelDsJ6Mzjcv81ApDKELT2LjlIfPLLEvnbzYuokUzwZjreDjct0h9Ivwp6QKL30
 dTWtnZdPbkpnCSHPvC36H8DRd9+i+vppalx1HNGobwtd+j664sOjKR5WFnJAWnGBW//xR+25z
 Oyx6LtSLHfK/4sTSRKOTxRzlQ9o23KKjo0l3lLu+ROVWrCad2ZHKb/NyTFsQmjc/3LqqM2wve
 00rwoS7U7/kV2KqD49JCEOblFaHjFr0HgxVCO4lYP7360CfsCEEAQObHppZ/YV+8BDXugw9Xp
 ntfXZjOJpJJesKnXvOHaL883TM7GINCs7QU+SfnpYoI+kPzwJVfa9ABFN5k4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 22 Dec 2019, Tom Miller wrote:

> On Sun Dec 22, 2019 at 2:58 AM, Jeff King wrote:
> > On Sat, Dec 21, 2019 at 03:52:53PM -0800, Junio C Hamano wrote:
> >
> >
> > > Jeff King <peff@peff.net> writes:
> > >
> > > > The situations where I need rerere-train don't come up often, but =
when
> > > > they do, it has always worked easily and without hiccups for me. S=
o
> > > > perhaps there are lurking gotchas that Junio might know about, but=
 AFAIK
> > > > the quality is high enough for it to be part of normal Git.
> > >
> > > I actually suspect that rewriting has a high chance of initially
> > > degrading the quality, so we should take a two step approach if we
> > > really want it as part of the core distribution.  As to the UI, I
> > > think "git rerere train a..b" would be a good one, but if the
> > > scripted version is of high quality (I haven't looked at it for a
> > > long time---even though I used it for a couple of times a year in
> > > recent years), perhaps we can add it as "git-rerere--train"
> > > subcommand that is spawned from "builtin/rerere.c" for the first
> > > cut?
> >
> >
> > Yeah, I'd be pretty happy with that, too.
> >
> >
> > I just suspect its ultimate fate is conversion to C, given the general
> > trend. And converting it to C that just calls out to other git command=
s
> > via run_command would presumably behave just like the original, leavin=
g
> > the more challenging and error-prone conversion for later. Hopefully a=
ny
> > upgrade to "real Git command" would include some tests, though. :)
> >
> >
> > -Peff
>
> Thanks for the feedback everyone! This is roughly the feedback I
> expected. I think moving the shell version first will give more time to
> focus on getting a strong test harness in place and a some decent
> documentation. I happy with doing this in a multi phase approach as it
> introduces less risk. When I get to the point of writing it in C I will
> try to do the work internally by looking at commits as Jeff has
> suggested, and fall back to run commands if I have to.

As the person who traditionally ends up being stuck with such conversions,
I would like to point out that the rerere-train script has not changed _in
years_ and that there is little point in trying to let it "cook" some more
in the scripted form, _in particular_ because this would prevent the
command from having access to the more powerful C API for future
improvements.

One very obvious enhancement would be to perform the training in memory,
without even clobbering the worktree. That's simply not a thing that a
shell script can perform.

Food for thought,
Dscho

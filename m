Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233CFC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E845820888
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d9IPToK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgE1MZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 08:25:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:57473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388767AbgE1MZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 08:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590668714;
        bh=Hp2SykjHi+YLMQA7UK3BACeXIXyiSxyyd7Z7TJehnIQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d9IPToK/y0Tfr4LQHppYrvS990swsRstBNG1EgIwNJXI4h396OePDQUKeEN2mP7Wx
         bIclDWB/QHF5D2Q4dmMispETx+IpwTqGI5+ZdiWnZtox+FyLq302a6GgbB9t20+6DF
         qv2n5rBzxhOXQoQSu2DW3AS1pZSzmrNbcftJ1NuY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1jYpYs0lqW-00Vw01; Thu, 28
 May 2020 14:25:14 +0200
Date:   Wed, 27 May 2020 21:51:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Merlin_B=C3=BCge?= <toni@bluenox07.de>
Subject: Re: [PATCH] checkout -p: handle new files correctly
In-Reply-To: <20200527230357.GB546534@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2005272150220.56@tvgsbejvaqbjf.bet>
References: <pull.646.git.1590613746507.gitgitgadget@gmail.com> <20200527230357.GB546534@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Df7ilCG575Be4VsPzutdGI4NbRjBbjXVcVx005dVWF/DAhjVtdO
 swqaQoKeJjYsmb1wgeARS/CeCJM8WbnpGJww1IBKp4cB/8TYjTsOGdaIsk+AHcZ9DV3r3CP
 ZDvbVeJtVJPAt5nZtKoQ14/Qp3JQeh74kNRVMiHVrKYDpsAhuQ+uv6uTz8lNzomYUxG5ZKG
 fYVC4hCOuX5nNF0rjZTeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qmHIMiylI5c=:bUOshTF0e57r/WO1P+Oxnl
 bqX2iRb/8Gy9uXOM54HLE9UPlZoDY+cZwVyzVcGNPLgBcvY9neRdDuM3q8wAfWZE9yundJF/e
 eYpzUjOW1zsULg17hkx1juAhHIhA8827UQJ9xMwVdYT2cj5XL51cipvBtHr7PqFxnHGD+cSeq
 w2DmyNLhKvA2dc7SQziBpOh7TBCPPpmPTa2Cuftn/VkdtHhswPwNpSeLr3X/dWIW1oBk9aYrV
 n4CFj21HZOQ+Z5BNlBtY0vK8DBeqJUB4U4MC2832FybrGGksBTxEW/ZgzWXyBLyMCTry2nsFL
 6v5k8qS16Rtrqo4rzpjyTPlDV6/VUxJQUpqVxMQ6mBT+QlmKGjxmeMRoQ2fcogHm2GgqJUWBa
 vzS6Qcpm0rn2FACjVNWhrDoydz90ciET8JpM1wBGYkps3Zfj9o8cAbg7lCKTxn8c7mbukhZfY
 E1M/caSy5oIqJ5WC31Pm5IEd9MlDx/jTfWR5kp8Ns61QYYLx3DvgdqZiBTx6LR5xhQvOhKfs0
 xFkvuC5wFQoD6T+yzt40z8iTWwq0vCjdAgPPcFwlkQsZiUI8NiZdnB/qNI1OU/xwAZI9/mtWf
 81TlELwLeTd9NX5B51T1aEZCKUph48xQBY7f0D7nhKyGnEPWRuCwL0Um7vbO3Fv64dPn2aq4t
 NiZ/nQUNZi0nP9a1BcTQUf7HqiIqr1PzGsDHmeVSEbexW5FURG5gpIwCi5fGiMi/tf/W1ZBZM
 NXX04Evg3eA71w9WQhbaiGu/Xp+mdMfBs2bbghJlRqXTjh46iO5hSPjgKDF70pAbTEzlsjQY8
 9YrtKEHQeyg1YyKsk0KSAf1vje0/JjA91ZjWviLm/bzJm7eScnBEPY6ic28YMI2vmQ3ZuA4CX
 yXPkDtLJCkwoLD2h02sgmZcmeHZrRaR206qn8t1xiZFVSB5Q+Uz0ihybR9K6M+hls75b6ioPB
 KgZzkuMt87g+Cp7lO5ey3M1BzBIjoe2j7/3Dml2NGHYuIME4VdUoWMBHdl2/++aPuiJ+YkuXV
 MsqENAAj6KavoXHUAgor7UYoZEXe2TCSyIr5UN4YKnOOuaTidkudRkxmN10K732kdTDpj3Amn
 FLRGkZ9q1LG2TmOHkODtWO82N91/eiYAOLMSDfIgbQJ4cikCnEy1FcvlTm9nqY5yYqeac/wQm
 p8eMUl7oVSZca9GJLoyi/KVIi8xq63OAGoON+jrbuhHyuoCue3IkXY9+33b33ybjg4BqGjl4A
 CHxpC01jgbyr85Shx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 27 May 2020, Jeff King wrote:

> On Wed, May 27, 2020 at 09:09:06PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > However, since the same machinery was used for `git checkout -p` &
> > friends, we can see new files.
> >
> > Handle this case specifically, adding a new prompt for it that is
> > modeled after the `deleted file` case.
>
> Thanks! I was planning to dig further into this topic today, and here it
> is all wrapped up with a bow. :)

:-)

>
> >  add-patch.c                | 30 +++++++++++++++++++++++-------
> >  git-add--interactive.perl  | 21 +++++++++++++++++++--
>
> Ooh, you even fixed the perl version, too. I was just going to leave it
> in the dust and add a test that set GIT_TEST_ADD_I_USE_BUILTIN.

As long as there is an escape hatch, I try to keep it working.

> Both versions look good, and are similar to what I expected from looking
> at it last night.

Thank you!

> > The original patch selection code was written for `git add -p`, and th=
e
> > fundamental unit on which it works is a hunk.
> >
> > We hacked around that to handle deletions back in 24ab81ae4d
> > (add-interactive: handle deletion of empty files, 2009-10-27). But `gi=
t
> > add -p` would never see a new file, since we only consider the set of
> > tracked files in the index.
>
> I lied a little with "would never see a new file". There _is_ a related
> case with "add -p" that might be worth thinking about: intent-to-add
> files.

Indeed. Maybe I can leave that as #leftoverbits?

Ciao,
Dscho

>
>   $ git init
>   $ >empty
>   $ echo content >not-empty
>   $ git add -N .
>   $ git add -p
>   diff --git a/not-empty b/not-empty
>   index e69de29..d95f3ad 100644
>   --- a/not-empty
>   +++ b/not-empty
>   @@ -0,0 +1 @@
>   +content
>   (1/1) Stage this hunk [y,n,q,a,d,e,?]? n
>
>   [no mention of empty file!]
>
> I think the culprit here is diff-files, though, which doesn't show a
> patch for intent-to-add:
>
>   $ git diff-files
>   :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	empty
>   :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 00000000000000=
00000000000000000000000000 M	not-empty
>
>   $ git diff-files -p
>   diff --git a/not-empty b/not-empty
>   index e69de29..d95f3ad 100644
>   --- a/not-empty
>   +++ b/not-empty
>   @@ -0,0 +1 @@
>   +content
>
> I don't think this really intersects with the patch here at all, because
> diff-files is not producing "new file" lines for these entries (even for
> the non-empty one).
>
> The solution _might_ be to convince diff-files to treat i-t-a entries as
> creations. And then with your patch here, we'd naturally do the right
> thing. So I don't think this needs to hold up your patch in any way, nor
> do we necessarily need to deal with i-t-a now. I was mostly curious how
> they worked, since we don't support added files. The answer is just that
> they don't always. ;)
>
> -Peff
>

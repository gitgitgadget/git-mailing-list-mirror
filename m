Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEFC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E3F20870
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AXg2pj6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJLSoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:44:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:51835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLSoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602528253;
        bh=iUHSWJDJxpGtWfT/aoOOSiQiF3QR1NrdGEy7d0luxww=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AXg2pj6/aCJUpW5UEYMMvqhWODJmS23MOfOQeH3E52MlaCYi2zDLlzEcDSHlt0Zau
         WFhOyfRcYliRrbGaMfGVgo+Etq4KFp2UuZZON7mjeAGs+Fxxvdza/R067f43ITeaKw
         yI0KSoRYmHHHctnGdBNDTxeXnwRTPkZj0k6xOA7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1kCJIg0LMd-00v8tB; Mon, 12
 Oct 2020 20:44:13 +0200
Date:   Mon, 12 Oct 2020 20:44:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <20201012151919.GA3740546@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010122035330.50@tvgsbejvaqbjf.bet>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201008014855.1416580-1-jonathantanmy@google.com> <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com> <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
 <20201012151919.GA3740546@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1733648043-1602528253=:50"
X-Provags-ID: V03:K1:e7kSqcAMSxflpnTDOp9VvHIXRaCk5EhnK7mwspZ/aBeUUIKq8di
 Cg8l4xV5ANr0747BlRfBDDOJmsBIOdp3cW7omFztn8bzciTV1DDa+V9QhNHOr0PTfTs+eDM
 AuyUgXgg+/iJKg6BPZd5YASl/eV2IRjkHsfhIUs0EwN86CCIzAshXsWj3OS7PFi4/VaOzGC
 DoCnEXRGvHpTIp4QqXivg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z61YKDTg+b8=:If7T5pf4GB2WbLAvvW6rl+
 uja596HvJWRIfRW6fh92BmGrMrt6ww6mCVgQE9RA4FGHZMk6eVauy1T+gN7t3WBkWoPJTbEeK
 wKRQY0uH+UzKwQ900vsa7QG4quYoBZbvkA420kIM4h33hKzokDrTyWJox2TlrvsbymqrlAAyj
 Co5JBYNHbJ9euVFLPUA1wPUXw3f8z/7DwOJeI7+6TBaIG61TRB2bVEFFmvlhxx8ZM5nXM6Or+
 n9bLQvSOHWt8zYjsNEh4/NMI4dHrnGAG6tr7aA5GEHG9OvGLLFFvS8rbFSfGvOKByBf9N+gNS
 8SnKnGPhlV5yUjUZTEDaG/IHtQcHfhtd/pNjT0V86PP7SLViXWQ7kG+tpDY6izD4/UAWNztMn
 wU3cNWNk9/8+As1QfFHAEKBaRvzvL8iJ+C3rHwPDQbW9eSC+Ji1kMs7oq9vvyAdTJdidBLBY3
 irkcanN/fMzrfuSoKI8yqY6dBU16icSW+k2U4cBx4UQsq4mog1ZBae4PNtJtWFv70e/6/QKQc
 dVdmny5rM+V0nhrmSORB7TUrd2i1QxMZzG46PlwQ2o9SIbXkbsPM9b+jovOwbye7+B5sNb88i
 YJFgCi2AX4WNq7ydKgYv+U2dR6Dj9lkICgKfV3zbBHmfdSJGuKRMyZWBlnzc4YaXG9yFmwlsd
 Ix4osi6CP0qOowoxnsR8AL0nJ1q2p8xEqF1fiOlZiyzQhxZhvxGF2+YuxBBp8ckLQzXj+9h1z
 QmCEgwtlYskU0ye7EsmBOm8k46lAWjUSw/BBdaVYx0DCme3VjPazAZadRJM/z5XS2n6RrbLef
 VqOrsVaOzNzoaMbmK1YcvklPoZD96FanSdhyrXGc/WslU3fDgzO31kt41lBj1VJvQDuPXb+f8
 6KrYG5OakUxMcnZBYtDACgDfevP0UxD3UI4vzDQIM/HZuCM6IDLb6mGb0G66lkDDRPGef1Lf2
 69bheUX2r12BUrJYNVZqklaPr29W+gc6cZyMRmBBex10VJAqXsLPv82RV5JaQ89aTcDTjifii
 WTTsmntYDR2+h+X/rqdAploq/jTSiNyrPLVztU+7DVSjz+P7VqRSuDwaRAxe6rTbR4FHQwQ+J
 K3+LO3dJ29FinPtSy4ucDPO01YZtO6MExM8j9hrR3LvaYe/+fHxfMG+bU5ga3uyr8SjOApsKF
 5Iuo6P/qc3romQ54ma/j4D5KBh2Ey7xQdkqxQezcMUL1SJ0tKc5t3+jtRzbkZLezMOwPUx4QL
 OdQQkrtf71BHKrSzpbLaK1OXqkZI9cjUbjDeFJg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1733648043-1602528253=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 12 Oct 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > The `merge_bases_many()` function has only 33 lines of code, partially
> > duplicating `get_reachable_subset()`. Yet, it had a bug in it for two
> > years that was not found.
> >
> > How much worse will the situation be with your 431 lines of code.
> >
> > Even more so when you consider the fact that you intend to shove the s=
ame
> > duplication down libgit2's throat. It's "triplicating" code.
>
> Careful: you seem to be making a bunch of assumptions here (for
> example, around Han-Wen having some intent around shoving things down
> libgit2's throat), and you seem to be focusing on the person instead
> of the contribution.
>
> Would you mind restating your point in a way that is a little easier
> to process, for example by focusing on the effect that this patch
> would have on you as a Git developer?

I really hope that Han-Wen did not take this as a personal attack.

In case he did, I'll gladly try to re-phrase my point: It does not matter
how much code is duplicated. The fact that we run into bugs even in
unintentionally duplicated code is reason enough to not lightly accept
this design decision as being set in stone.

Which is why I, you, Emily and Josh pointed that out, and it is the same
reason why Peff and Junio had made the same point in the past.

I was quite unpleasantly surprised to see that all of those objections
seemed to be insufficient, hence my rather forceful reply.

As to the libgit2 angle: libgit2 also has `strbuf` (which it calls
`git_buf` IIRC), and I am certain that it also has those other helper
functions =C3=A0 la `put_be32()`. So yes, the triplication I mentioned is =
a
very real, undesirable feature of this patch series.

To be honest, I would much rather spend my time reviewing patches that
added `reftable` support using as much of libgit.a's functionality as
possible rather than repeating the same point over and over again: that it
makes very little sense _not_ to use that functionality. Of course, at
this stage I understand that my feedback is not very welcome, so I will
try to refrain from commenting on this patch series further (I do reserve
the right to send patches that fix CI failures, just like I've done quite
a few times up to this point).

Ciao,
Dscho

--8323328-1733648043-1602528253=:50--

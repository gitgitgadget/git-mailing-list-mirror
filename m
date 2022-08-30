Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D84EECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH3OCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiH3OCs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:02:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B1B4413
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661868164;
        bh=FjVOx++loLp5PZ4uBMW0cFO+qQA5wMWvldjOki+YLQo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LznMVbAI4vD3tFxhgvdJO795pUewQyjg66+c9MJ+9ccKHs5mzaLa6mGN1MT4As1ts
         dft53I5YiE9auJA8TJNGOyi0ON7hJ1XrW1/yqdQtrUe/VubX6on0LCRXCTlIsDtMbG
         eNoDNX/vO0iT6izAz8q3eCzS1GnEEmzHyGOVwwzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1p25jD0ZOd-00aF0m; Tue, 30
 Aug 2022 16:02:44 +0200
Date:   Tue, 30 Aug 2022 16:02:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
In-Reply-To: <CABPp-BGBEfFh0z0YHGcHE+rva9JdapXprPn-RSmif0xn6fcxYw@mail.gmail.com>
Message-ID: <30rq792s-818n-q078-3837-977prpqqprq6@tzk.qr>
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com> <CABPp-BGBEfFh0z0YHGcHE+rva9JdapXprPn-RSmif0xn6fcxYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:etYMW4Qh3/pKQhM7lY3dfZ3QgdEi0fpkKuepCW8jXV/HFTJDXGQ
 LeZOd9ccxqiUpIrjE88NRoM2qaXeslQ/Vat+z+TUw0iM3xe7gnyDiJV7LHD1XoUuJfaQ1IB
 BKGinanIC9t9L08RCuGmszezib6CbflUBKK3UWHFBTB3H3eFQS3AGEOutJ93Ryk7LTGPCpH
 ks9JGYn91JEkeT4NFYvfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K3aTsLud7yU=:UUFKLIQG70GWf3G/Pv64S8
 GL5htnosSBrv8Gw3nK4K84OtR2YUsHJG7K9zPoO2qDx1x05j8SerkD5CERwlR4+VXCrcXi6wF
 KCGYMS80ZmW+MBpBf9JXHhLP8sCRCwaAFhnoRQqXscgEbw0on4qQzRig0o0YfHF7iJT2VqHZv
 Sg3hWIOnr0NwfDjHvenTgG61UOSS3E0ZuMiYZ3wV+atCvyI+pQFyUBSIXzQj0U/1L9M+GO7n7
 0qKax0ap0R+JP0/b5tanvNdtiXjRgpm5Gn0exkWAq87+T8JW8BNJEP/ECYJq4oCPGNX+dJM6i
 A5jFtnRfEzdjmst1/evOTp+1ERoO7TsDWaSCseSf05UI8NZSaH2Ihm0M8CpTi0tepIr8XBRFt
 ChQSGE7Funi4d7l9B5XcRAFXm6C5jGk3i53jhH8HY06SYcjjCbuINRtkyRVNJvZ5RQh/FZRnn
 RT7J6bUkAw0RHU0J/XnngRGPA5AJqs+Ke0FzL/rRNXq9saq5hUXIKteiQ3Bievmg0+n2w1c6i
 yo/UM8daeRZyaCYd31iOEJLHit8Exqdj29KUeRbl4uDEfPuCCYGHawvTGS1JK5Uv9hqtlulPj
 tjJvjp/Mh+US5/VuuIT57jHjYLbzAabUoD35G2oRGn85x2Delo7YqjWcwDS+CjF5B3WrTeDLi
 HyoCsZEaPaVYq8QhjAVT73YzrBHCxnJj2NsV0hDLNLd9SKjCN64NzUyCTit9mM2NPYWVgbL0P
 BHlhfggQpNt6oopAsSdj12o4vqOM41XpZ1q8UkXAfYRREXmNgQdeYhZTq0pSN4+GNEV9MOhWV
 iXaN+P84UEHcyVqCaR8ylx8Qjqa/NdyiuS28s3neWE2TmSLmV8lmxbVVplvwSAw0bP3FHZk4H
 k5jfQSqbPr8Tr3QzJ/UxIFPUgcCQRaJL2qKe7U1oaLRPmCFjroEYi8e1zrnvyu6MK4waM7nya
 o7y6YBReRjcyCNlHMzr/hDc8kGP49IoQhTwXVod/5L8ZaJo3Q8L6/Le6TdHPbdn/cUdzjUm38
 fGJeqQ6xlB2nQ4+akgCPAtVDjWGepIqn/zCZQD7a+cw0UOS1FNTzkIIW8A7ZjLxhlnWZZZ0wE
 Sfh+KN5//HmTSU2IcoeZ/Whn9grlQLlE97yPmMD1NaCkgSGkBwPZfMR6g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah & Eric,

On Mon, 29 Aug 2022, Elijah Newren wrote:

> On Sat, Aug 27, 2022 at 10:18 PM Eric Sunshine via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > This series fixes a failing test in t4301 due to 'sed' behavioral
> > differences between implementations. It also fixes a couple broken &&-=
chains
> > and adds missing explicit loop termination.
> >
> > The third patch is entirely subjective and can be dropped if unwanted.=
 I
> > spent more than a few minutes puzzling over the script's use of 'print=
f
> > "\\n"' rather than the more typical 'printf "\n"' or even a simple 'ec=
ho',
> > wondering if there was some subtlety I was missing or whether Elijah h=
ad
> > encountered an unusual situation in which '\\n' was needed over '\n'. =
The
> > third patch chooses to replace 'printf "\\n"' with 'echo' which I find=
 more
> > idiomatic, but I can see value in using 'printf "\n"' as perhaps being
> > clearer that it is adding a newline where one is missing.
>
> I can't actually provide the reasoning for it; I took Dscho's testcase
> from [1] and used it as a basis for adding several other testcases.
> When I was copying & pasting and adjusting, I just didn't notice the
> 'printf "\\n"'.  But using a simple echo makes sense.
>
> [1] https://lore.kernel.org/git/3b4ed8bb1bb615277ee51a7b2af5fc53bae0a6e4=
.1660892256.git.gitgitgadget@gmail.com/

No other reason than that I _seem_ to recall having run into some issues
where _some_ POSIX shell (was it BusyBox' ash?) did not like the
single-escape form "\n".

I have no firm recollection, though, and am fine with converting all of
the double backslashes to single backslashes (read: I am very indifferent
to this issue).

Ciao,
Dscho

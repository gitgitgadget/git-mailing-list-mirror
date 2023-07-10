Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C58EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGJVEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGJVEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:04:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AECCA1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1689023045; x=1689627845; i=georgmueller@gmx.net;
 bh=Ph9S6D6REhh6dKgVdYXZWVWH+Bt4elf++uPV5l6isx8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=qwng+iOci6FTkHKBuinCV3uP0tpzjHTjvBOuDj3C0Yo2NozTN8/+u8n1E3vh/RvN7mQLn/l
 +vKcEPBIfKYetht7rQ2ZQ2XQsKCDdSZ9c2s1ablGtJMs9PRekr/FGUp392Zprm8AQkpZiPqdK
 4GtzNRWEpv1m2xKCauP06KIAHfUvmwDsXI4gGNAyHlG05gEJ/8fI5Knbgv3EiyYHT2pb5HepU
 1MzH7xnL1xhKWUX3QH48HN5uHTyn1Nxjsji06YLnfPn/iQrbHqfC3z8oO3C2KZj3d0SBDAMLO
 wOT0UXuR2w58+K1L5BPMYYS19xwDEmh+xfV5eZ3y/uFJFExuI7lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.55] ([109.104.37.175]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1qTr4v0kW0-00X1uU; Mon, 10
 Jul 2023 23:04:05 +0200
Message-ID: <2621e32f-128b-2254-3215-7a6fc69c9064@gmx.net>
Date:   Mon, 10 Jul 2023 23:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] fix resize issues on large screens
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20230708105546.2945446-2-georgmueller@gmx.net>
 <9a498c81-82b4-d441-6b5d-78ba3043b5a9@kdbg.org>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <9a498c81-82b4-d441-6b5d-78ba3043b5a9@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B2+BwJL1VApbjseT9Vj9jO+KB78sM83XzdPvZOYdheZbDkKWJRi
 PnEL9hNxjL4OuOwyQ/SYHwSup9gWJIs9Ru7HVEDA0o8D492Ims23dDLqmwnI0voF8ExLN1X
 1vc373QpFZJHuCGruVZmtfhxBaSgW3SUSP84Kb03lW+PHZDgzHIRivxNM8uJhdQrPSmkgEj
 9CBnuLMP0zpom3153PeEA==
UI-OutboundReport: notjunk:1;M01:P0:+biZrHS36r4=;Om8WKI85RHD0+eBg2v1H3Mor2W7
 piz9XQd1lw1McIZcec5fOByJryhFojRAh+m4sgtg3PgcsNrlQZJqbCsDccTm2EvBa7tcJvSWl
 Y8QEyQxVOu5OVBHzrQArqfvY5DZpX3S3Nd/2JbltokBvQmSRyxWLXC7lm289WxcrjJYj5FTgE
 J6I/PIyphme9SudJMFS4/FQqrg5wR0ecDUGoyFUReM1gtsvxNXiZ4Tx+BD/cWZotXSD2CyE3K
 HeXMtItixBuwRWKHgsvRxTwj0zpeOA3FNzEz1vFcy8Dhd5igqowCPO86aGzVBXBpD3qbYcR7P
 zXe3CC6AvdXesl9Jq9WxfubhPDCFYLqoqMgvm6eUPV2NL9cU/0c8Sammas+HUNZaB2GAvZqRn
 j5glrTHpeBVj/qnJosVbUwDzMGAhQHxfd1EQf2gkk3xoFgGwm1DEKcYZYa74Uz3VQIDTLIvKX
 G3LtAIwZ6esf6ZpnC5nJTL/a/02EXzUjpx6jSNrfcAVufgtndTFEqQj7KbphwD2toAspFye5z
 IEltFKRzHWCzs0MykTtD27uUzzXB66UHvM+URulf5jsMxhyud/F18WotFAR9T9xdW4v58+jo5
 qliFd9vqQ6Q21hwBcJumShxi7EqmL2QkwMUS3MBrmhq15W+tJ6NTwIZyeBq3EQM8NYMMrux4C
 Lp/TP7bs6hPai1TNQN4szaHspz1hlIwnX1EBT1pcsEhRLLwQNmgDqISsbjKJutM9j1fn7eL50
 YEn5K9O4ePjZTAeGzkF5v4BCmrpcszsnGRi/VuwvbQU+IBU6EwZWQxOnGT8ldEIrPC4ORZDYD
 y6WimxFqHZGj3M66dZBzcBag39c/z8yqjgYoMElvci+L6N/P53zVRPzT9LDuvKUYNkSb+lnBC
 CYVlTYv25SjaKz1fA+vOswVa7+gTk2g4yzp1j9drRs0en2PIGkJo8COx3Yy2TzUgYdAgXnn3S
 XOjSSsOeZRLo1j6eNrC4T0uz+ZA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 10.07.23 um 18:37 schrieb Johannes Sixt:
> Am 08.07.23 um 12:55 schrieb Georg M=C3=BCller:
>> When opening gitk in a multi-monitor setup with different resolutions,
>> the resize factor causes the first columns of the layout get bigger and
>> bigger while the other columns (author, date in upper pane, file list i=
n
>> lower pane) shrink to a minimum size.
>>
>> The following setup triggers the problem on Fedora 38/Gnome 44:
>> * primary screen 1 has a FHD resolution (1920x1080)
>> * secondary screen 2 has a QHD resolution (2560x1440)
>>
>> Every time gitk opens at screen 2, the resize is triggered and the colu=
mns
>> are shifted 1.33x to the right (2560/1920 =3D 1.33).
>> After multiple rounds of closing/opening gitk, the columns are at their
>> minimum size and the contents are not visible or only a minimum is
>> visible.
>>
>> The following patches are two approaches to fix the problem. Maybe the
>> hard-coded values could be variables, this is a first shot to solve the
>> problem.
>
> Since you haven't stated it explicitly, I assume that with "the problem
> solved" the resizing does not happen anymore. That's fine, but could be
> stated explicitly.
>
> When you say "two approaches", do you mean that the patches are
> independent and either one solves the problem? And only one of them
> should be taken?
>
> I've not read the code changes (because I don't know a lot of Tcl/Tk).
> But I've seen the commit messages of the patches. They are mostly empty.
> This cover letter has a pretty good explanation of the problem. Please
> copy everything that is relevant for each commit to the commit message,
> because the cover letter won't be available in the commit history.
>
> Thanks,
> -- Hannes

Thank you for your suggestions. I will rephrase the commit messages and
will resend the commits.

In general, the patches are independent and both solve it for me, but
both of them make sense since scaling author and date columns above a
certain resolution does not make sense anymore and having a sane minimum
width if there is enough space for the first column also makes sense.

Best regards,
Georg


>>
>> Georg M=C3=BCller (2):
>>    gitk: limit factor scaling on resize to widths below 1900px
>>    gitk: keep author and date colums to a minimal width on resize
>>
>>   gitk-git/gitk | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> --
>> 2.41.0
>>
>>
>

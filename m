Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391DC25B07
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbiHIImp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHIImo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 04:42:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD821E3B
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660034556;
        bh=ftokLaLvWJIKnDOm6B0rBev27O4QcBQui75UGkwp45A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TOae9fb2AkwnncjUM3wql3My0E56N2lktDjJqXgUoCXd5lgZJJxEJYYtLYIrYE49i
         +3Tg3OlG9B4AyLG1S9T8UakjIXaSovpbhVU1eC38dcl0zsAe0NG65VZhQRO6a8/qKq
         VYCr2z9Rlwp6pLwM3o0zCA/3gGQhUrazEoBVfcBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1o9nPy2eF8-00G2SP; Tue, 09
 Aug 2022 10:42:36 +0200
Date:   Tue, 9 Aug 2022 10:42:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
In-Reply-To: <xmqqv8r2smvr.fsf@gitster.g>
Message-ID: <3qn5r283-3232-4s58-8q9s-n67o407nr816@tzk.qr>
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com> <xmqq35f38yeb.fsf@gitster.g> <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr> <xmqqv8r2smvr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zjBKMtXIoBAklCrPDE5DiUzedO7malGnwzg2jrMQkjqfnWQ55OG
 /iVMLtCb2DuXfyNL/s3p2vtFwmboASyyeqIvN/UkgMbcrVL7AL9WGyvNsK3wyIDPCWMlIZj
 +tf3cjk7yZ8lhkeViuzUIdZjP7wWa0JfDlR7/9ZSZCk3Rqi/m6ZW58yEZMPKnAE2xwqkwXs
 SRMvYP5p+OcLs9sEzFT0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:izPkZsufocI=:k9Fkc5tVmTgoZvyOhCbKVW
 JZATvdhKfztlCV1dq59kgLsZyQ2nQTgG//SKik77w56wjsRv8Ha0P1HK5It6gjtzPDNgDgR8i
 MGYla9eveUHvvvOrHIJXAc1K6S5OVCm21gLDfSqH9+YDyCCHKWNkUJX8g1C7oFIxkz7cAiGcB
 ANXfN/AIPxjUl4QEc3RWs7duI04QodqOewgVjxfb8dJN91tBm4iAouI2Tra6V7fKfJpBVT4DF
 ejMt80MfSoSXY5Srs5sH5t/7p15UNS+Jxt59dRI9WDnweVuaqAICxwW7wN9WX5w12QRrSUTRa
 OvKZFYiu/AbokkzWX4YaCob2y60AWwQS556FeUJpy/MOtrhTdQXaFH9ISV3oQWRp9beqt7OnZ
 mB20ejRRJudWO6y05fzm7po0rc14Te9VsT1twytOFvG1VWYTbtsOVfveV3ye6GB8SykZjmU1f
 0SLSLkn5NIgvE03hu3eVN8XeQm90lKg1xqHsSxRW0PVQMwZ77561Qdbkj09ubI7kuM+7o933N
 2g724bN9iTUd1A5PZFZp3s2FwwmDVKJUyg2APIUFaG83Xg3Wc1gpmbUIVtICH3FZj23CWNMsZ
 5Ay73LIPtDdWZOPLiO00rmf1A+S4LZIRQC4UpDocg9lQQN3cYmvbuvVrAxjnSzIXyyuTjiCJX
 pHhr4sQ+OL8JovC3JzO0WZeyDNSeYyo0dAZKvrdto+WgnsBblZ5oC7XGuJ5IeFQmJ812oaGsR
 cxl17smnbHI56wJbt5++rI7HQ8J6EZgspyENXx6e6lYNCEcT5n4NytzV/ZCBjiaUQ4P3jak+C
 b2zd+mF8DIL7l42GKsD91Cvg3TB0Fe64/IyGcLF0uWhYH9dJPZbibip4i0sF7CUeLouCwRn5j
 TMBPa8TTvXTEIwVl1WHd3kJFKQr2jzK8TlFNQqSYIzfTKiQgdg7RrE/O0QA5imWVQyWAK5w9W
 JHm18OAxkERauMurZ5NbIXa4dJxdwHVrhufWqsOqS/UOYRVycjFxbmygzN+D10xz1yzNGls/G
 IujRRrLF9xS6W3e3aMIasZTBFE962UCKZGaFcoCkXoootVzCkfMoGe1jdUahyE7RPmaoBLOvD
 g9xvmGNSzXaXcvPq/jng/1yy9+iu9fKYuyEk7pZssuEbGlJ8rxLpo1zZQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > You asked me in private to provide more reviews for those refactorings=
 so
> > that they see some push-back, but I lack the bandwidth for that.
>
> I do remember telling you to push back what you do not want to see
> in 'seen' and advance to 'next'.  If everybody lacks the bandwidth
> for shooting down bad ideas and only has time to promote their own
> ideas, which are not guaranteed to be good ones, it does not lead
> to a good place X-<.

The funny thing is that you're usually simply not picking up patches that
do not get any reviews, but for these refactorings it is somehow
different, and I do not understand why it needs to be different.

I do not _want_ to spend time reviewing patch series of dubious benefit.
And that would hold true even if I could justify spending that time, which
I can't.

There are so many more contributions that promise a much higher return of
investment for reviewing them.

Ciao,
Dscho

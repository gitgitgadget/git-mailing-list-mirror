Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2445C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 10:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbiHIKAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiHIKAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 06:00:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC110D0
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660039204;
        bh=JRMFkanSBfcl6s+OQkGWIXy4o08lHLbnkSQlIFbHvhA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QsDQULWF+Hql9SGK527vGG3fU59QXX+1zeT7cdrLQMVSmIKbohsuxqP7xEQrH/vb1
         eUR7sI4U0slTZmmWQSg7EakvQ8AxY+IdyVzF1wIGRK2e/Yye6yJ0r3nR2cvQNgBcuK
         +6M7KLdV0opEKCXZXXl4owSSh46XGYmrm7FzTtyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1ncues34RW-00ihhm; Tue, 09
 Aug 2022 12:00:04 +0200
Date:   Tue, 9 Aug 2022 12:00:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
In-Reply-To: <xmqqr11zoe6i.fsf@gitster.g>
Message-ID: <439p713r-32o4-5187-n8nn-r81n3007s4pp@tzk.qr>
References: <cover.1659291025.git.matheus.bernardino@usp.br> <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br> <xmqqr11zoe6i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TXb6HNlgGXleJlXm500uufUB1TEnKXLV6zAHf/3Bk65ERb6LUgN
 ZaXsQJZBnIb/vlJWo21mebfk6zTrgxe8kHYgu57EYkqPHsGkFSLgtZs+7S+pQheCNTC8MHN
 v05Lyu+FuJf6VkkEwJpU4pW8cM88p2ahpOtXVzX2iWaxaKN27DoZrenHx8+A0z1At67m4nA
 F20eVpihji/rJsDFDNBEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BFwhB6ZHDUQ=:y2Q9dC8s/DK3Fimskxlkrz
 055L2+MPkqrz/6YBtDE8+CcbtjxMIZw7hdNCv/0vA6S6MEJfn4OZ+SreA5Z5VML1Yeu4KDkek
 QPBCsvVwOUSK6SXXrSOufeTXkJ6HHvylJ8c+H7O+g3geouyMx3xumiC7zRiDOUrXwYBPfyC/5
 XWASczPdQQbKMqDIb1K0FlegwFSuGBcnCJCzq3t6JsoDnnL6uMe7UY52VzTa0XpFhrrs38T90
 SpJ44iGEbpnBXciSWSkIqZOtM/8l+SWcNUY+FV3HryDWPk1GFe5eXzrMck9YzxmvOV94LpRAE
 1LPEjEIYzo4w0DW9ujdcXzPd2PHgmUJDG89Jy//jnI7kfHT9YWv7iIYQegDhHB9ioQh5ochDA
 +fvs8YdNeIrPYxFDJnU3rNNespg1swZnFDBtDnagXXwdo6XRptzlqW988V7jl7lWlqdK5Vs0I
 AYVue2BUWLk8poX53jSPjXsR46ugc/sJfMwYxJF5mJ2f6Bb52/fiUNzQGVGTguxjj6ZcWi4TN
 j+vx18HIInStRIhCerybn0b5K/hOQyaRu8EiKupF3lwRSBzFExwpvWJm/9jVlCUOXHhA9JHJd
 n3t5dUt2lwesBpyHLwS/PoKYEKQCPDhcdpwUipt6mecNzV099D+Iy7mPt8tAX38iWvsI313xg
 IPK0FDJhhjHG98Pi3RtbB6KGpRXK4TWsVqcc7dTnnQwICL4pR2XjmnSX/IiwZM1/mfxp5qgHy
 5ljMoo8zvOLTCIA/+EaDyzpu4UJfCcNgNgqMQ1+630OCQGA+btcRE0s2Y0JH0ksot6LKFn2I1
 YkDa8QFo7/mXmcq0+oCBcQeWvnBbYst9io2S7Kybg0ytWDu1pi5ZzXpNLr+mGxrG7/k8gY2kv
 ECtvAA5w0U3t1sT6YyLxV7uWVE+3XhIsBHwUXFmtj8qNveiLIJNSlpFXw5gDev81GCBy5Pty7
 nQMIewWhhW/OKB9F/ER9+H0BUrIVb0VuiHYO9IgXfSof6JUTwTSwB/QAElPVoEAkgCmozP1u3
 4vJGZlqf6HoMVvrpePoTTmXT1ppHzd/3K5GZF0N15dvyGyqoIiBvBTW5uoi3bwvJeQgnV4kmz
 UInKX/YVM9M+ykpA1ylXepdQzI9bRkPdIdUCRY4DcQK1X67TPQvuIa4rA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2022, Junio C Hamano wrote:

> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +		/* Read until flush */
> > +		while ((buf =3D packet_read_line(0, &size))) {
> > +			if (!strcmp(buf, "can-delay=3D1")) {
> > +				entry =3D strmap_get(&delay, pathname);
> > +				if (entry && !entry->requested) {
> > +					entry->requested =3D 1;
> > +				} else if (!entry && always_delay) {
> > +					add_delay_entry(pathname, 1, 1);
> > +				}
>
> These are unnecessary {} around single statement blocks, but let's
> let it pass in a test helper.

I would like to encourage you to think of ways how this project could
avoid the cost (mental space, reviewer time, back and forth between
contributor and reviewer) of such trivial code formatting issues.

My favored solution would be to adjust the code formatting rules in Git to
such an extent that it can be completely automated, whether via a
`clang-format-diff` rule [*1*] or via an adapted `checkpatch` [*2*] or via
something that is modeled after cURL's `checksrc` script [*3*].

It costs us too much time, and is too annoying all around, having to spend
so many brain cycles on code style (which people like me find much less
interesting than the actual, functional changes).

I'd much rather focus on the implementation of the rot13 filter and
potentially how this patch could give rise to even broader enhancements to
Git's source code that eventually have a user-visible, positive impact.

Ciao,
Dscho

Footnote *1*: https://lore.kernel.org/git/YstJl+5BPyR5RWnR@tapette.crustyt=
oothpaste.net/
Footnote *2*: https://lore.kernel.org/git/xmqqbktvl0s4.fsf@gitster.g/
Footnote *3*: https://github.com/curl/curl/blob/master/scripts/checksrc.pl

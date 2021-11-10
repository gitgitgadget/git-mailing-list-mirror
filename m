Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEDFC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34FF6102A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhKJMbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:31:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:39911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhKJMbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636547277;
        bh=dZ+plND8un5girmsYMSrjlGLQHkiSbsBMlL8IKQ1qZ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Avp5LWh+wBHxuXL8lXExY2VayfoK5AqzTH/igGNywmJLyEsP0Ibo8n4CLJbYQeO7U
         59Q82op9zCvRuycv9xE/Jd7jZv9UBRErtVDhRao7jn0iBrznluxQl56B/bh6nsSgZx
         8Zvl7Bn6CvlhSVGGM2oORZAxNbICGKjLneikHzsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79u8-1mf9xh1mY8-017Rtk; Wed, 10
 Nov 2021 13:27:57 +0100
Date:   Wed, 10 Nov 2021 13:27:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
In-Reply-To: <xmqqee7ozyx4.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com> <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet> <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com> <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OrBzt5q6ae2ONioQYsL+g5ZBwrzfCWO8tcUZfUJXHfaJomABqeI
 chuFiTYD3qCbV+U3IQ6tz/ccTkLe2UjTya2u+XNKo1h5uRlM8lvVfsyACBbGVYiFk7mvcyI
 lm8mElPG+0ahGiqbBTmcrXLhHFQ5t/igVuGwn06vWwE/5d814iIRjlrJOL8KHy7tSZ8wyw6
 MpyvGOGbm8GcUGMxDDB9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qPubY4pokFY=:yZMa7qyyWbO7BoIfmTrg1l
 6i8CK1/0Q9MjHneZS4NxnDgw8qiq85LxglKgQCM2HizTpceQtE1/IBlQCYPY8Zz1sbO3C2zAs
 a6uXpHzYBzEw1zqn5y2stRJPCAO0ifT8hsErFYpcuACroHq+k6OhZlfH0pGJMAQpKhmH42Y8w
 4hv4htyrw3ta+2SDlqWf0FHt/X8BoqdXKC0jPhsYy7ABpgyOpxjRYS7q21uCPzbMsUmCHf2zR
 4bO+7giWowthgrXnSkz1Wg6e0jj7eXI4cxis1Fgls0yXnKnpTqeQ8JcCdYjtr8RJC1B6XK4x0
 l97ocXZBFNP8ND8nfb8F5cNoC0l/G8ffaYzW28ahBF90t0M0Dzh5ACNSla2LYzicOynKIH7Vq
 RcIv0ixjkdcjGQde/Ne/yV0Cm29KI9xg7J+FM4ccqVfft+ZxzrA4C6jW9ppxuH5JJgvihbt3Z
 fI7n1AfvAeo3ynirpCDabDcsqt9KIFncRdVWMi5OluIdz0E8cobEKVhbEOQmIKNapRksdMGCy
 IXalLwkAJIP4I7G4rE+QhQqDqWPfXfZtROnpCCSid7ZBP3/ZZD4RnogTE0dFN9Lb/LWpruf7H
 YPBhEDS/9uLEVYxltAeL2ofvVF3/6GClo/GM2fim1nhyiuylK9fAU32iUnp5vYKwK6/b9Xsvl
 8GlQM3gHlubLJj624s6KslL33fzIMJnVg8Q+J+R4Gkbn34HrNrmlhoKE9ycTevI/EV22ZpDkD
 5WpvelLR1/pf/dbd/+Y5R3x9KMy/Gv0/qunyfAmdUYVjNuVzzVHFoXYB8sPzbCoruEUqteRau
 F/Hh0p5Ch6DaoEmwNMN4rR50XE0i8njBS8ZmDO/nLLZQbk+dB5TAGgzWRgnIIYt0xNxuEQIx9
 gZNoPrxsgNStf5GfYUFfmnN4zpt5VDeRNL85w3hRSdqWYciZ84/bxNUoQ+bnRdM/WMMc5em/0
 m4whAqv1epUdsaE7vavh+YYiKA2zQti2tZtXdh0cBl/ft+pqdqjan3zaQhRkgFIFPuRzXd1O6
 BxN0piJb4HnUyz4sy0wNl/P5h2cjvj58ZaRsfiVbM6ZoZlE1vlV02grMwh4GyqsxsvszElKIV
 5Dk0q+yRVb9c7g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I fear that it is a bit late in the -rc cycle to try to get this into =
the
> > official v2.34.0. Adam, since you are the maintainer of the Cygwin git
> > package, would you mind incorporating this patch into Cygwin's version=
 of
> > Git?
>
> I do not mind taking a Cygwin-only #ifdef block in compat/ like we
> see below from folks who have stake in Cygwin, and who are clearly
> leading Cygwin users on the list, like Ramsay and Adam are, even
> after I tag -rc2.

Thank you for your encouragement, I contributed it here:
https://lore.kernel.org/git/pull.1074.git.1636542550889.gitgitgadget@gmail=
.com

> I cannot give the change any better test than they can, and it is
> their platform to improve, or break by accident while trying to do
> so.

Right. I tested this as well as I could, via the `--stress` option, and am
fairly confident that it is correct. Since the patch touches only
`simply-ipc` code, the only test that could possibly affected is t0052,
and it passes with `--stress` over here (when it failed without the
patch).

Ciao,
Dscho

P.S.: in case you wondered, no, I did not run the entire test suite. With
the performance characteristics of the POSIX emulation provided by the
Cygwin runtime, this would simply take too long. It's not the first time I
wish our test suite was more efficient, across _all_ supported platforms.

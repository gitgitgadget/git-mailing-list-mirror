Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59D91F609
	for <e@80x24.org>; Tue, 18 Jun 2019 16:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfFRQPu (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 12:15:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:44949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbfFRQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 12:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560874535;
        bh=nU65tGdLEiB0s8NkJn9Rq+ElpH4+5IxnnOI+uoAU2QE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H2yuZ1z7inxBOvtRICAI13uWwsa8QrUH9kajgy2E5OaCE0vNEE00jUE9TMU0BP80V
         RphKmgwcDMK1W9lVKA2gEfJTs+JrYMJiyFjvFht0rn9JDdXUEpIaGu21sc/Xk1mzzB
         pTFl66WyC9MJDNqJ9+aVJKwSSmCpLk5v95pSiaJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMIO-1hrcEk3K8C-00EO6T; Tue, 18
 Jun 2019 18:15:34 +0200
Date:   Tue, 18 Jun 2019 18:15:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
In-Reply-To: <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net> <20190616185330.549436-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet> <20190618012943.GB8877@genre.crustytoothpaste.net>
 <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VagzO8SE85Xfh2/L2VWkZy7aeb31+Bu13iuBAcZMKYTC6NRZKWp
 daSS1mPI00gcRJ6U7k1mYzC6XVcnwbV7+trKGoju0A6iN8CmoNJ+pncWQWCYThdYBNvUoTv
 CfGsocvMu/dCI/ipNav8CoMh/ZYMopqpDCu/NnG2B7vVN3YUV7i0isiBnFlvb4n/26uf/Y4
 dRGzBoiCcniyicB1cOJ+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OpPhEquwP8A=:7i7kOOImPqbKLLLuuFO3E0
 XPISIFX9jpEDqkQdpdgIGTDEP0GMP+YO3lOoKpgMk5i6DamY+/xDQgspbfIDSM/I7UK/5JX3V
 aFJbFpDkzjXB4i2xmclQB1amNk/hEkRDSCNv5KIv8RhueqQXelzSnzSz1jrWifl23ghnxgTUs
 gpNydMFdAe4iLaqquKjcf5LDiz2YELKuDJyHnJLkprQaftvwhOLiaU6nEoR4lMxSGc8c+qXF3
 IwGqKbHo5CxjJtMmADp1ThW7Umz9o7hoAUde3P8M11kIMWilWC6pEsA4I5yqbGWENA9Wf4QbM
 LdVUgw3BRDL1uk61Dd3k8g7eiPC85Y/wfu+bK/MLPcWO4wxZnv5n109DWcyT7ATjLWGs5Bpas
 w09ATcJ9x+xrAt0j2DL4mHewwe1JRh19ezvcxvnXVi/eH9ZWwQR+CjzKWW4rTW5T1YQ9M2/q2
 6ARTgDogsU48ZB0bB7tJAgRMzsOnnIgtEQYAL1+WxwWrziRhYIs72i6RtnAbcW1oCk+AW0XOq
 0ogKtd5xhOtQrofU8mKuUa6ff+hyBBGxUKwuLjGBIdOd9x0+s4Nd9rSd3ApASfjF/jV88SikP
 QqOiTHL1EsU78u9HQ2sfjxlsKfrXCKCN9yBbibIununnNxro9Rfni0zFIpEKof3/1VjVsINoA
 K3Aq4kXCwMMoBcBxF7ocgh7X//BUyrKWYyFjt6/3tCaNBFW/X4st4ZAdS2E8eGgKpDi/gSt0V
 iBRE/TjxRuy9ouxGh/6EdQSmPA8hXLvI1jYFSP8leG5CJfwR7Ej5jluprDWdV6CDRHiHYZJ8b
 d1DEgPjRT6m0fZJr0AjSGymD13ND2fzkzw6pL6uu+uxe/GRidJq04moQ7KgBwqSt1v+NJH8Tr
 enS+L4AEGN/jtIdt/K+elcERda11lj3dqz6pnzzBDDTcPuQPgfrzYAJesfV4/A1S3sASPJu0N
 XuOKhCD6M8yG3TsweaJ/eeNmvBKlN0Y7ewnidqLF7lfTm5TFwQkHN
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 18 Jun 2019, Johannes Sixt wrote:

> Am 18.06.19 um 03:29 schrieb brian m. carlson:
> > On 2019-06-17 at 19:05:03, Johannes Schindelin wrote:
> >> I guess it does not *really* matter all that much, but this does spaw=
n a
> >> new process (and I think it actually spawns 4 on Windows, for reasons=
, and
> >> spawning processes is super expensive on Windows).
> >>
> >> We might actually want to think about using something like this inste=
ad
> >> (which admittedly looks a bit like gobbledygook to the uninitiated, b=
ut it
> >> definitely avoids any spawned process):
> >>
> >> test_oid_to_path () {
> >> 	echo "${1%${1#??}}/${1#??}"
> >> }
> >
> > I'm fine making that change. The original design was because we had
> > other code that used that technique and I didn't see an obviously bett=
er
> > solution. Now you've provided one and a good justification.
>
> Regardless of how it is implemented, I have another gripe with this
> helper: the way it must be used requires a process: $(test_out_to_path
> $foo)

Indeed.

> And looking through this patch series, I see a gazillion of *new*
> process substitutions $(test_something...) and $(basename $whatever).
> Can't we do something about it?

I wish there was. Unix shell scripting has not evolved much in the past,
what, 3 decades? So I don't really see a way to "pass variables by
reference" to shell functions, short of calling `eval` (which buys
preciously little as it _also_ has to spawn a new process [*1*]).

Of course, if we would slowly get away from depending so much on shell
scripting, then we would reap quite a few other benefits, too, not only
speed, but also much easier debugging, code coverage, etc.

Ciao,
Dscho

Footnote *1*: Theoretically, it could be a *ton* faster by using threads
on Windows. But threads are pretty much an afterthought on Unix/Linux, so
no mainstream POSIX shell supports this. They all `fork()` to interpret an
`eval` as far as I can tell.

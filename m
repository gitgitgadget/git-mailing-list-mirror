Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2DB1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDYHKT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:10:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:39899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeDYHKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:10:17 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsOsW-1eE05K07aK-011wFk; Wed, 25
 Apr 2018 09:10:10 +0200
Date:   Wed, 25 Apr 2018 09:10:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 04/11] replace: "libify" create_graft() and callees
In-Reply-To: <CAGZ79kZgpvcAzpttwHyjnSDcfGYa0gfKRBG9zBqiXfBZetGLtg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804250905110.4978@tvgsbejvaqbjf.bet>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de> <f962f8043fb1125b47090a82c35e2d67d3d9d216.1524303776.git.johannes.schindelin@gmx.de> <CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804242048360.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAGZ79kZgpvcAzpttwHyjnSDcfGYa0gfKRBG9zBqiXfBZetGLtg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bn7fm9GN0uAvPynFg2FWnP/t4tK3GMhXR5BRqeisrpEbe/khfIL
 03COFlrOjBIulgAVlIFLsaX++l6vy5SfoCj/N7TzPpJlq86uSUb/DM+1qs4LqbrTUb5PwDp
 JgiONPWkgp2MFazRTCVe/e2JDIFouoYT/wfuD4+4kBR1z33aGm5g9QNpi8q+bPAFqZ8aq0N
 sULIrCFiCmlBiKT+DMd/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2S4BXGEkeSM=:VqVyyVCcS9lk7lg7n9qh6K
 pRnjbR3w/JG7JzXgf6ZomQyTd2T+j3OumWmoVWIa/2X5HKnYasNJYEFpLfZJgRoMINysg8iS+
 D8u5F07WDjffzN/3sw2xSu+/EesaKNDFgcIQwf/e2NzDCkawjtYm4u/xrxV2sNawLs7xsbIAA
 nSmrirIaCuj52qmF0zHo2tcPiQb2L/FhpsZ8LmxFY1eyXPl5seYT0TZF/JF5F5qYPGzCacM7A
 T+rZbtkA3seTCULMhgHuXmNr+WEptkTHu1pY1dNaHx3y6G5VR9Lp5giOhR7dfvXzyEDsYNY9V
 RaV7xNSWSp6akJgSufXcj5U0JUrjvxr7AlLT8Epn9bItvfiCwrzXw74UjkfgBgs4NXY60VNwm
 9LNqftaq7gXkEAi+XjscKtOvE/VMK7RWkmEPMzuyfGhfr3K+ukS1LGvBubYLgQVr0M+uvlkNj
 RHuSBHABnxfzHH1IO2bvw7Z5B9j/M7O+uonFIz2uCbbHiwkPuEHm6gJLylt9J9zk84kZTL5UG
 7iro3f3Gl9MAHcq9Era7M/P210pVUyGaR0cyWcRNBRTGDv8+4B7mgyejRaNPAXWOc0fQywGoH
 BMzLnzV8cwd6Bz02geh8fbiMA1qdUwov+q0SaihMa9WS/2epGAQI/pLPEoWdr3xwRPPN0iiMY
 n1ekwPs8FzIG9JFAc6kaqEIusXZ26PSkawsV/y/F4MEzMdiOLKDdnXamY6Ps8xsMNAecS6IhY
 b6YQ1zLTsWgKwqSgKVChH5OQKRn1iwRylh7qbbTt9Rw5OKAk7415IaIq3mYW1acN/+T/uo96w
 PbnZlrmK2HtfAAM3ULc9+SE0KchGxPgO6g4keJFV52Y/BPcr9Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 24 Apr 2018, Stefan Beller wrote:

> On Tue, Apr 24, 2018 at 11:51 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >
> > Oy vey. How many more mistakes can I introduce in one commit...
> >
> 
> I ask this myself all the time, but Software is hard when not having
> computer assisted checks.

Right. I still hope to find some time to play with Infer (Open Source
alternative to Coverity, started at Facebook). Windows support is not
there yet, which is the main hold-up for me (if I had the time, I would
spend it on adding Windows support to Infer). I could imagine that Infer
might be flexible enough to ask these questions programmatically:

- is there a code path that forgets to close() file handles?

- is there a code path that forgets to release strbufs?

- are there redundant strbuf_release() calls?

> The test suite doesn't quite count here, as it doesn't yell loudly
> enough for leaks in corner cases.

Right, and running everything through valgrind is not fast enough.
Besides, this misses non-Linux code paths.

> Thanks for taking these seriously, I was unsure if the
> first issues (close() clobbering the errno) were sever enough
> to bother. It complicates the code, but the effect is theoretical)
> (for EBADF) or a real niche corner case (EINTR).

Maybe it might not be *that* serious currently. It is incorrect, though,
and makes the code less reusable. I like to copy-edit my code a lot when
refactoring is not an option.

> Speaking of that, I wonder if we eventually want to have
> a wrapper
> 
> int xclose(int fd)
> {
>     int err = errno;
>     int ret = close(fd)
>     if (errno == EINTR)
>         /* on linux we don't care about this, other OSes? */
>         ;
>     errno = err;
>     return ret;
> }
> 
> Though not in this series.

Or maybe a Coccinelle rule? (Still not in this series, though.)

Ciao,
Dscho

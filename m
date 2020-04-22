Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88478C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550392098B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PCqUY3Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDVTUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:20:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:37699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgDVTUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587583222;
        bh=Oj82yu76wEM7y/172KTmL3NWThqmVX+P3rk/PC9964Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PCqUY3KcDDGory0ZmrAYLE8sXBV8ON9ywcRr+fl7eLvRMsOg659adkiLxPXrvakcV
         U8sO944aUtBmpEFtcxSAQa77b4VbOnBhUyenSPw3loiUr81GFp+jrs/tnjp/M+uz2B
         yjH4IVkT9DoqrK1bUtCPYSZp60aNN9gxgzfCEDQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.165]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MJmGP-1jlTGp0NWj-00KAv1; Wed, 22 Apr 2020 21:20:22 +0200
Date:   Wed, 22 Apr 2020 21:20:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
In-Reply-To: <20200422040644.GC3559880@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2004222117400.18039@tvgsbejvaqbjf.bet>
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com> <20200421225837.GB3515235@coredump.intra.peff.net> <20200422010943.GD6465@camp.crustytoothpaste.net> <20200422012817.GD103469@google.com> <20200422022020.GF6465@camp.crustytoothpaste.net>
 <20200422040644.GC3559880@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bRc+Aj3+kiBOXD64XkdB+dLUOjZQ4Zw65UesfIBb8fI6yKEvPwm
 w4JVK9TCZy8b7Q+rM66/f/9QU6TGmXq3zWqRw2FPDnQ16+chZO0fD/w1a6yBmOID6p6m6us
 CHJtvSrWPMJ95D5m5JhgqcrbgDMxwdzea3tcTkb+t4hWOf2BpT6zxMz4nC4uiAqVUwGU8xL
 Rck3hUYO8HzVK2hKF+2oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P5zW65hYsmE=:/QCufBtmelQyEMiVbzNxP8
 Z33Q6lMDgdAEMR3zME3SxVOFKjjYahugrSPTOzR3THsfNk6juMy/pjLfKKVhTrIzGBpTqtdXT
 7jroqyECAYfxAPNDyR2U82qVx22JoMmtf+VC+mqLt9nH+ZyQyXTRty+IpOf2uKOVLnl8dJRKt
 JTLuUzH7AaQ/DBJu2PeLYnhm0b59Wbn5LFEnRxmq7QRMG+NcvlI6zxVhCvpVf+iq9xtwyoIOL
 t8J2ynxeOc6aPTOoOP5eGUFerp1aXzIAZ7NL27X20s6GdpoUzLpUg3KReSWIEHisV3u45wsqp
 bLwQzqfWDh3EGUnB8MLZ9MRrEnhUOc3QZqiR9tWN/pfGeS22U7FD5+6QrphoyiQmwsj2oAE8N
 yjShCHhfbLM2RnnMJevlnCuBna0UK9BeJJXZrzoH6YJvVKIMbNrYYCa0AGUho2IpbZYVXdWqf
 KzW3+bRrPNKEx5ExE5F20KSt0nKzTgTAQYs1cebny/Arj2//JtOBZMHhQntYX85F/9EGx7jWK
 ni2uQjYyTQJwM6LPZI4GRV/iJPPOpd4M5Ip2j4CcY9vSeUYk/dD1aAh0iGTiwAEq/KKTGyII9
 ecd11uSlLuBoHHNLPemk5xK7/PYOoboMac/8OLMkzFL2ShsHE09jV7jJTLvgfZx2tt80cE4o2
 17NRrzZeypyDWNEWqIAPAdjYn8D6TP2Rx4kN9kgB+1cp7SJobIJfOCTwCHzCN1/rxvgCJO1Am
 EZNwX9pCU13oIvO9mvadt9qXoNRE84BYEDQA0wDphtoKVQc2RmC4X1M9p/ZrLsZqTlUexJujp
 o4GVjZ6K72bV5gPXXZ5mWmGfUbVyn3RCUyrDlRGWszsdtePWhmwRpHJqItLD0Z/EfQZzBhuAu
 KASEfbBtgBAfpSFqqd94lGPKoZJogfbLJc49st/YJ9uDhrvizzKsQ8yi7pUthLWx7nXnJ82Ar
 pzS7NQZ0+lwPQ6unroymQSdFR7gfg1zyPTCT6wts8IQfNMq/LHw9Y+ZkFloOgpAlREJDzcBF0
 jBccjbox1a/Q6uE/B+IIbeNr810ff0A7ACymgR37ZqkIVc90MvLLpc5tbViHHPkAawQnIZDQt
 1kRrJkUy4aLlG++MdJNMJ2j97rhmuYTH46ryOjFMPxvdzyfovWC2GOi3nawYAtsdlB9RaPfKU
 sVqVpYMoA9HY33sO02k4OJ7FYJe27zyLouHsO8M3zeDlxjUnrU1i/xdQBN9FTHz2aS1c8MRKR
 YvHdC5rchD/C+Tyzs
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 22 Apr 2020, Jeff King wrote:

> On Wed, Apr 22, 2020 at 02:20:20AM +0000, brian m. carlson wrote:
>
> > > Thanks.  Here's another (though I haven't tried bisecting yet):
> > >
> > > 	echo url=3D'https://github.com/git/git' |
> > > 	GIT_TERMINAL_PROMPT=3D0 \
> > > 	git -c credential.helper=3D \
> > > 		-c credential.github.com.helper=3D'!echo username=3Dfoo; echo pass=
word=3Dbar;:' \
> > > 		credential fill
> >
> > gitcredentials(7) says the following:
> >
> >   Git considers each credential to have a context defined by a URL.
> >   This context is used to look up context-specific configuration, and =
is
> >   passed to any helpers, which may use it as an index into secure
> >   storage.
> >
> > I'm not sure a hostname qualifies as a URL in this case.  So while my
> > patch did break this, I don't believe it's ever been documented to
> > actually work and was an artifact of our implementation (along with
> > "credential./git/git.helper" and "credential.https://.helper").  I've
> > also never seen this syntax used in the wild, but maybe I'm not lookin=
g
> > in the right places.
>
> I'm pretty sure it was an intended use case, though it is a natural
> outcome of the credential_match() strategy of "unspecified things match
> anything". I'd suspect that anybody relying on it is doing so
> unintentionally, and just forgot to put the protocol field in. Though I
> suppose doing so would let you cover http/https in a single block.
>
> At any rate, even in versions _without_ your patch, that became a hard
> error in this week's release. In v2.24.3, for example:
>
>   $ echo url=3Dhttps://anyhost.example.com |
>     git -c credential.example.com.username=3Dfoo credential fill
>   warning: url has no scheme: example.com
>   fatal: credential url cannot be parsed: example.com
>
> because we're relying there on credential_from_url() to parse the config
> credentials, too. After your patch, we use the http-config machinery,
> which simply doesn't match.

This affects also pre-v2.26.* versions. One fallout is that some GitHub
Desktop users reported that they cannot fetch anymore:
https://github.com/desktop/desktop/issues/9597

I _think_ I have a good fix for this, and am only waiting for the PR
builds at https://github.com/gitgitgadget/git/pull/615 to finish before I
will submit that patch series for review.

Ideally, I will integrate these patches into some MinGit backports
tonight, still, so that GitHub Desktop can roll out another release to
avoid many more reports. Therefore, I hope for quick reviews ;-)

Ciao,
Dscho

>
> > I don't think we can shoehorn it into urlmatch, since that would break
> > compatibility with the `http.*` config options, so I think we'd have t=
o
> > revert the entire feature if we want to preserve it.  I think I'd pref=
er
> > to leave things as it is since it seems uncommon and there are easy
> > alternatives, but if folks prefer, I can send a patch to revert the
> > urlmatch feature.
>
> I agree that we should leave it. Aside from the dual http/https thing
> (which _hopefully_ is rare these days as https become more of a
> standard), I don't think it has a legitimate use case. And I think we
> should be pushing users to be a bit more careful with their url config.
>
> -Peff
>
>

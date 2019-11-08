Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56C41F454
	for <e@80x24.org>; Fri,  8 Nov 2019 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfKHNoe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 08:44:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:37869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfKHNoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 08:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573220662;
        bh=ffLWT0kSR1ij14aotVFMc+ZeUPuY5A4lbIz82xGepaw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O0Ux6ldT/88JWBUvuYO/RvNzOHmTndl4GFmG1cMoMZhS7OkdfXfpk8e5fb4BIsjNv
         5vbB1bRheUbzvXFzSEg0g/novnMRcK487B5EQkh6JcAzBuTtxYgiTafhkxVzn9yd/X
         2ZwbnUeovxokragtJgw3pahKfAFV3ztldSwjjOq0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1i0KNj22m1-00gKJZ; Fri, 08
 Nov 2019 14:44:22 +0100
Date:   Fri, 8 Nov 2019 14:44:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
In-Reply-To: <xmqqimnun4v5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911081443500.46@tvgsbejvaqbjf.bet>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com> <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com> <20191106041644.GE4307@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet>
 <xmqqsgn1tjup.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911062029230.46@tvgsbejvaqbjf.bet> <xmqqimnun4v5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zjimK48x9KEUgXUEI8navfpoMdR+FOGC6kWX1LIpWnpWzAHbWiE
 r7rGdS41aBcxzilGFPCdNrfjK5i/oFiHC0SDZY+r3jgzy2OfTTujUJlerHUs67rQa+k9gwC
 rXI9LUllm+IvuCP+uUwCEF+hkzc929gb7cmkRWZLLCpAPA7sIBlVaqQ27sW3Nf1Y1c7mkhR
 hXjWXueJtCFrWIZl9BRgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XdihbaXCUS0=:YnJ4t9XcZ2Lf0alRXAXepj
 AwXQBV8CmdsWIVB5WxKMOhG7L9vH+vdD7HhqUoi7fd3mWT/g5WC+1pILeWYNGyYwbp0yQjeHq
 TYRKYB0Vy6Wh7aqJflAX/TDKW70VSelKBAzvBptAlPZOu+9+jJTq9yr/04IKLH2varIoNftzV
 wNxygkcSlAvZipjvDYUfth5l4bnYooZfAyKeCX113SmnWmC+wSTHW/8ZS+H8mXjKJ5vvPeiV6
 Fps6YpFY8RFtMaKG/J90vqBDZzJphmYc3RUjJqRIP5UTwYV/6izx3xcE58JDYYO525LDzCNLR
 92RkmY6lxxogadFuW3DqFkcfgY701aY3VPekUfJ3ZfJJqrFk2BlbmyCg6Emo0DUVXd7tx3YJQ
 UlNMhlhiapcUgcIomVgV1GckehUS1TITPWMpegwhFjJZWGdUhXJI2s5c6GFk0Hq3ffqLxV8Sy
 aUGYHFtZNd2BQI/Kvpr8ovwfHIZC3ssf40A/q8fkyJ5z19BKxp94KYnXYDJy9cadYRT+cJm8k
 ONj+Hg9CcVRCtrf1VreKGbDVgFucPVyHHniQQhFkHnqjJaRyoYta9OpZgA4PESKbHhvJ3C86N
 35WPz6gVEAb3nUR7tVdAUXPd7iQxJTiiT1fCZ3pXaWBXfwyd6noanyaJac5ldsc5GlyyJhUqT
 H1KvJxEicXX3A9XT2DV3izBiQ0xB8ktGcnz24GjF81HLu71lm8fzrgWJ9CKnwTCR3qHY0KvJy
 6W45sDI/tYOq3dsy8Jy+O0hYxQkoOe3lzY15duo3q0hGS0F/82/OgSxrPJfA34SZEF7AmOc7a
 Y0sZ7f8NjREXlDjE5a9Nk+mIzpqgnHCAWnalHd1K5eBXLI/TrXjuxKfrwH1bCzkX9uGV+Qd6T
 rJROGZMWt9FoPnwwUjAu77UD6TRYOpw1oXHvLQ4fJE76rJAc6IOErlP3QV7p8oH+v7BaMxXmP
 UUnbwoV7vsJAEKMTpZDQbPF74FEANzO+lt/9Yvhe1zZt+GLrsDYQQzRY+aX/9Ag6RVi65d44B
 CLg9233i2emMqUZVUhxzhR2h4Sw2wWCGMB5YNic2BA+YEVm15vtp/lW1vPw0o3JJcCM00gBtx
 fWBBdEeO9kO78vTMuuwfF2BHVjU7Ax057jdBFuVi0Li72glxA4EXvZyT/uGlac42Xfbc0rwn1
 ap3ibPZK2fqxsJvv7Vg6/tkrrvdLAfxXZaAnFebxEsZQT/Kc9QzX2tiDPWlMq3RffAvk/KadV
 7oEK7iBDm+TmB3bb/ufqhfW3DQZbC6ikLjQkl0Tn4b8PMP85gcUvzakHontI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > ... which was broken in non-US locales (most notably in a Japanese set=
up;
> > apparently there _still_ are developers who did not yet move away from=
 a
> > Japanese locale... at least on Windows).
>
> I think the above was a reference to a tangential comment I made in
> a response to Peff.
>
> Oh, I do not expect Japanese Windows users would "move away from"
> Japanese locale, ever.
>
> I do however know that an app that supports only legacy encoding is
> frowned upon these days.  They still use and will keep using
> Japanese menus and messages, and they still write their documents in
> Japanese and not in US English.
>
> But they store their Japenese documents encoded in UTF-8 on their
> system that is in Japanese locale.
>
> There are two models of gadgets I am interested in getting, between
> which one of them that is slightly older supports UTF-8 and MS-Kanji
> (aka Shift-JIS) while the latest model only supports MS-Kanji.  The
> list price of them are comparable (actually, the latest one lists a
> bit more), but the latest model is deeply discounted while the other
> one with UTF-8 is not as much.  At shopping sites, user reviews
> often mention "I've migrated my text to UTF-8 already and going back
> to Shift JIS in this year is too cumbersome, so I'll skip this
> latest model".
>
> I am hoping a software update might happen, and will pull the
> trigger once the latest one starts supporting UTF-8 ;-)

Thank you for that interesting note.

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF3C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A3D20797
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 13:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Es98npja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKJN6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:58:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:38575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJN6c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 08:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605016703;
        bh=kwdwTvs7FtCm2pZpzjjZFIUrWzslQvqeGE2e+x6gcZI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Es98npjaiDE/U2FM9CIzQntwwvUmycFEMZzBodnY3ENuWKzHmbsC+0Ks4hmwEa4Fx
         qBJvmpeLdn8SnCppy+/H0nGF6HbND0mo74UoQmQ3fhrcljJ6ePvFD/+vSAv1ROgJ37
         gLgw9EAIU23iwAN2YrVCWAlhfxQ1U4Ef8wqyxBTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1kWiaO0rQV-00HNtX; Tue, 10
 Nov 2020 14:58:23 +0100
Date:   Tue, 10 Nov 2020 14:58:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] compat/bswap.h: detect ARM64 when using MSVC
In-Reply-To: <20201107224747.GF6252@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2011101418550.18437@tvgsbejvaqbjf.bet>
References: <20201107221916.1428757-1-dgurney99@gmail.com> <20201107224747.GF6252@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:phZ8rahlfkDoR4xY7gvg84SPR3ph1VqnLwDw8eUeyEui7gAzBS+
 Q6+Q0SngJjTd0BMIGBjIyq0fWdS0NKtYTIENXlxx4IpeuZuim0JiyyxmCWsi9ubqR3Gr4z9
 o9Wz/CHTW+/rzmMSoRBoAYMivgcQDFMM7TYKHq/+AAOeoScDaKXtrgF/RFtqu5YStzGDfl2
 A/ySpMa4zkpCtRwdk/oTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huA2ZMTV0XQ=:YrXjGh8eFs7MqZn7GxC3La
 4ht8bBt5gFSBXtwA/ZhQEsaqFhmYRRVYj8WUVPmArfbrn/6+GfPn2Ms5ivZALHGEupoVVF8Fu
 KZV5CzKFUjR0FnoeTy1aNBndcdxQGevxA5fSRlNXDx+ULayGy7ZvQw+L6RLzr9TLJ/ObBIUIb
 vX6ONQ7zcB9QBI7LcA82oriEkAKRI7JcbB2pWysJU9j24jUWSuZNzKy88wvsTu+ZymFs/tBuB
 A/b4S7BcfI5n+idaPH7U2AYGpzoZE666ACPd3D1z20MKNfGtrNkmkxBVSw3TqG1P0jxn5um4Z
 T/ip1Yp84lSQE+Htq6hGCFnpg28CarpjQLpumCoQNCwb6YnRSeIvMLV7+zvybtrKWAUhedZWQ
 psHinzKmfzSfDjrZnZQwc+n/lAG7yg0zsSKvY+O8KVT+/1Bwz8PhprO8JA7FbXSx6Zf/dDlQ7
 KFc6m3vGbVIw5d7te6DrK0H4cBSF/VQp9W/s72GtRaKt+/j/HJulS+bon/ezkq7NUkBX7M9U9
 FSFPwW019DTipWafalAq74zjfqG2b51tBjGIDu94XLSpeLIA0Cz5Z/U1hK1hYkPXqJ53REuMO
 z2HmVzEuen+x6I6U3X2kCz7jsv5bca9MSAP2j9CHz3XOoDjN2FP7IQNYszJOHPktc68nrAKsY
 VhHHNw6DLI/Fl03u2oclX/0pa2HxAJYfHfnmEsHPDWnWEM1vAkOBRJRATuL4odCL2dbPkCWSU
 0oAfUxzWvqIIxnAgb54u/hw2M8F2JpEdikcx7C4y+vFcXKt7lvfyt4a57LLFwzEktFN8ztA+C
 kEjK/O4gQMLy96PJanwftyR0Qv+BZtn+0SZ97Sr4W4pn16tjTc6TY7jo7ZGP+3U0mOmANrYqn
 9SOb+RPoN0GLumqc7qjxs3NFGY2XTn9lyRslFvw9Y=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian & Daniel,

On Sat, 7 Nov 2020, brian m. carlson wrote:

> On 2020-11-07 at 22:19:16, Daniel Gurney wrote:
> > Signed-off-by: Daniel Gurney <dgurney99@gmail.com>
> > ---
> >  compat/bswap.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/compat/bswap.h b/compat/bswap.h
> > index c0bb744adc..512f6f4b99 100644
> > --- a/compat/bswap.h
> > +++ b/compat/bswap.h
> > @@ -74,7 +74,7 @@ static inline uint64_t git_bswap64(uint64_t x)
> >  }
> >  #endif
> >
> > -#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> > +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || de=
fined(_M_ARM64))
> >
> >  #include <stdlib.h>
> >
>
> I think this is fine as it is, but I have a question here: why, if we're
> using MSVC, is that not sufficient to enable this?  In other words, why
> can't this line simply be this:
>
>   #elif defined(_MSC_VER)

That is a good question. As far as I can see, this code path has been
introduced in 0fcabdeb52b (Use faster byte swapping when compiling with
MSVC, 2009-10-19). Then commit looks like this:

    Author: Sebastian Schuberth <sschuberth@gmail.com>
    Date:   Mon Oct 19 18:37:05 2009 +0200
    Subject: Use faster byte swapping when compiling with MSVC

    When compiling with MSVC on x86-compatible, use an intrinsic for
    byte swapping. In contrast to the GCC path, we do not prefer
    inline assembly here as it is not supported for the x64 platform.

    Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

    diff --git a/compat/bswap.h b/compat/bswap.h
    index 5cc4acbfcce..279e0b48b15 100644
    --- a/compat/bswap.h
    +++ b/compat/bswap.h
    @@ -28,6 +28,16 @@ static inline uint32_t default_swab32(uint32_t val)
     	} \
     	__res; })

    +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
    +
    +#include <stdlib.h>
    +
    +#define bswap32(x) _byteswap_ulong(x)
    +
    +#endif
    +
    +#ifdef bswap32
    +
     #undef ntohl
     #undef htonl
     #define ntohl(x) bswap32(x)

I Cc:ed Sebastian, to confirm my hunch: Looking a bit above that hunk, I
see that this merely imitates the way things are done for GCC:

    #if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))

    [...]

Now, let's have a slightly harder look at the patch under consideration:
what this does is to re-use the (known to be little-endian) code path of
x86 and x86_64 to define the `bswap32()` and `bswap64()` macros also for
ARM64.

Further down, the presence of these macros is taken for a sign that we
_are_ little-endian and therefore the `ntol()` family of functions isn't a
no-op, but has to swap the order, and that's what those macros are then
used for.

The biggest question now is: are we certain that `_M_ARM64` implies
little-endian?

I remember that ARM (the 32-bit variety, that is) has support for
switching endianness on the fly. Happily, MSVC talks specifically about
_not_ supporting that:
https://docs.microsoft.com/en-us/cpp/build/overview-of-arm-abi-conventions

Likewise, it says the same about ARM64 (mentioning that it would be much
harder to switch endianness there to begin with):
https://docs.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions

So does that make us confident that we can just add that `_M_ARM64` part?
Yes. Does it make me confident that we can just drop all of the
architecture-dependent conditions? No, it does not. There _were_ versions
of MSVC that could compile code for PowerPC, for example, which _is_
big-endian.

> As far as I know, Windows has always run on little-endian hardware.

I think that depends on your point of view... IIRC an early version of
Windows NT (or was it still VMS Plus?) ran on DEC Alpha, which I seem to
_vaguely_ remember was big-endian.

> It looks like MSVC did run on the M68000 series and MIPS[0] at some
> point. Are those really versions of MSVC we care about and think Git can
> practically support, given the fact that we require so many C99
> constructs that are not practically available in old versions of MSVC?
> If not, wouldn't it make sense to simplify?

Indeed, and it is more than just the C99 constructs that prevent us from
supporting other MSVC versions: we do not support compiling with MSVC out
of the box. Nowadays, we rely on CMake to generate the appropriate files
to allow us to build with MSVC because our Makefile-based approach very
much hardcodes GCC (or compatible) options.

>
> [0] Wikipedia does not specify the endiannesses supported by the MIPS
> edition.

I have another vague memory about MIPS (a wonderful SGI machine I had the
pleasure of banging my head against, for lack of Python support and Git
requiring Python back then) being big-endian, too.

Short version: while I managed to convince myself that _currently_ there
are no big-endian platforms that we can support via MSVC, I would like to
stay within the boundaries of caution and _not_ drop those `defined(_M_*)`
parts.

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB7C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B5120809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="C4nZURGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgKJOFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:05:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:53831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbgKJOFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 09:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605017087;
        bh=JC2kCAjSjzUyEMPr8EWnRImVgrxl3T1Rm60qkAhYVqU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C4nZURGlz2XYQkqJOkUXIPbegM2tjhAV+n05ikYj3y+VhAxRgQtD6AfmwaGjHVpjr
         +7F7TVCJ0ud+hkP3YxT5vbEjODUsBsAZG3fNiqwjEzvRO16nZ9aVQ0LWbLQ0HtvKHp
         JGLEUof2Ju5EVGVDaUwvSlcxu/bcjHJKPbCn9C1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1kTRq007fP-009fIq; Tue, 10
 Nov 2020 15:04:47 +0100
Date:   Tue, 10 Nov 2020 15:04:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Daniel Gurney <dgurney99@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
In-Reply-To: <xmqqft5h92fm.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet>
References: <20201107234751.10661-1-dgurney99@gmail.com> <20201108095739.23144-1-dgurney99@gmail.com> <20201110003127.GA1268480@coredump.intra.peff.net> <20201110023620.GH6252@camp.crustytoothpaste.net> <xmqqft5h92fm.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ikyx6XzVyMzDtBsoxk9Hxynhtq2rA0t8R2PEh3Skk5obGG/SKZm
 sGffL2ocfMhwGU5n423mXOPtN2z22n4bDRaV1KpyeCwjIkwl6UlkCSi8TQz9PkfQHyhD19N
 BvMQE7u6i8v7Az8uwv6k3wArvvk481hoA1sBbALRwWpzE3sodsT6koqaAoilP4UhvTwqVs7
 UmI3ymolN65mwoeiMtfTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiKY5ssiaLg=:bs2G8szqqcScXamIxmHgIp
 S4tOy0ASzlaFIvC81znEkl2WPSfs/JC75EgGQrLT8wiaspbbWjHHJkLj2vDJ0aMRT8Sh6Unu9
 cfFisSE8Vl7MjHSaLmM6EfH5UROFtBCmxIriRQ3Sn9CbGO2DODDO97cJGg7dddlghXFpFBbnM
 9xCQ60AxhFDnUCygZlvLvjSjgBkmUSGtadqAKfAbU21gD1e/mkyxBkpnXOeIB51rGP1beBr0p
 ST1S8gjAV4W9C5V91Ddv8+PnD01Lp0yW4AK93KugeZGvSLFhcnl+1PT+zzVS1EM2Q+ecBXOtS
 wkKyeiNqog81pjetslABfnSf6vAIosSGCVYWhHzRU9OFhqmaaZ6GovtHsQSnGuBl1D50NHLM5
 hdBthJCu292BjwjijgLRXrHFx1j39vm6yjNMw0cDx6d0QI3QOlDmQX2JWM/W6v6xvECsPR2dT
 9YlU0e6jOyus3N3CE5pPuIy/pEoAF05HVAwDHW0mcUkv4Z6aqIIm/2g9cnA+kKULw8RUffdm1
 uXkugr2FWQG+kAel6/Om/i/MB8DWzdPX4a0/wV0oKv+CKosZ1mRZI8r96a/Mux5bQDPXT1EZe
 2Hwe47e+kDKWS5rliyp12Y03HFpGlbgbLJv+wNiFQPD9EVNcfFMc3cprELf1Ke+0zB+InuwKo
 5y1FDCTBr2Yiq7AZ4wz8kgjwX5D9/aIO+Oyvei59T8NIDNORgCRRrEsSdgL9SxiFh8pSqoEfL
 GZ47nHu1BzynzzRyMGiIG6kdFPvtdFqf7JiBEyNCHjP/guZQrAxkjKppEKlcu+d1UAsE+3BAF
 Gn3ndS28Ti2nL8CMZcqTV3Cs8Ndi5jhPAtDfNbLhu9aKwmR/PzMEd0ilZjT+pxgR+WAZkax2c
 ZS75Dwg1wGu4ZXtrkmJOHIp+B5MXDelEgoh4CCqUs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Nov 2020, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On 2020-11-10 at 00:31:27, Jeff King wrote:
> >> On Sun, Nov 08, 2020 at 11:57:41AM +0200, Daniel Gurney wrote:
> >>
> >> > Modern MSVC or Windows versions don't support big-endian, so it's
> >> > unnecessary to consider architectures when using it.
> >>
> >> This made me wonder if we support any non-modern versions (which woul=
d
> >> be negatively impacted).
> >
> > I'm pretty sure we don't.  As I said, we're using several C99 features
> > and that version precedes the C99 standard (and 1999).
> >
> >> From the earlier thread at [1], it sounds like probably not, but I
> >> wonder if we can offer a stronger argument there (or just define
> >> "modern" a little more clearly).
> >
> > According to Wikipedia[0]:
> >
> >   Visual C++ 2013 [12.0] finally added support for various C99 feature=
s
> >   in its C mode (including designated initializers, compound literals,
> >   and the _Bool type), though it was still not complete. Visual C++ 20=
15
> >   further improved the C99 support, with full support of the C99
> >   Standard Library, except for features that require C99 language
> >   features not yet supported by the compiler.
> >
> > The version mentioned that supported MIPS, Alpha, and m68k was Visual
> > C++ 2.0 RISC Edition.  While Wikipedia doesn't mention its release dat=
e,
> > its successor, Visual C++ 4.0, was released in 1995.  The m68k version
> > ran on Macs using those processors, and Apple abandoned m68k for Power=
PC
> > in 1994[1].
>
> So,
>
> 	The only versions of MSVC that support big-endian are too
> 	ancient and do not understand some C99 features we use in
> 	our codebase, so it is unnecessary...
>
> would be sufficient?
>
> > I'm entirely comfortable with requiring that people use a compiler and
> > operating system newer than 25 years old to compile Git correctly.  As
> > I've said or implied in previous threads, I'm also fine requiring C99
> > (vendors having had over two decades to implement it) and only
> > supporting OSes with vendor security support, although obviously these
> > latter two items are much more controversial.
>
> Maybe controversial, but worth at least laying the ground rules
> ahead of time?
>
> Do we have any specific feature we avoid only due to portability
> concerns?  Declaring an identifier in the first part of for() is the
> only thing that comes to my mind, but there may be others.  I think
> we should consider how well each individual feature is supported by
> systems we care about as we feel the need.

I would feel a bit more comfortable reintroducing the part that
specifically checks for x86, x86_64 and ARM64, for the reasons I outlined
in my reply to a previous version of this patch: just because the MSVC
versions we can currently use to build Git currently only supports little
endian does not mean that all future versions will do. Point in reference:
you can build Linux applications in Visual Studio like _right now_ [*1*].

Ciao,
Dscho

Footnote *1*: It currently uses GCC, but who says it always will?
https://docs.microsoft.com/en-us/cpp/linux/cmake-linux-project

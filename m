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
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A821F4B6
	for <e@80x24.org>; Thu, 27 Jun 2019 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0MAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 08:00:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:33187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0MAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 08:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561636833;
        bh=RuvIzqWdRVg0wOp1TXEgolyXgEZv0KWWYM0oyirjP/A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HnK4lvkMGfk56MVy+wnzW7d//MCmkahi/F/KCx13YkXNNMG4MTWrDI1ugnGO2+d3U
         k5rmPAYIWJMmUlS7l0xV3/X8YQxtme0rmFmUKQZAB4mCXScFAlLUjZhGIH9yH+JJrR
         noKhv8Mewv6wPgHj16tOGl1nYlgQolDL73vDWWBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1iJLzr2gbe-00oEkd; Thu, 27
 Jun 2019 14:00:33 +0200
Date:   Thu, 27 Jun 2019 14:00:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
In-Reply-To: <20190627055739.GA9322@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906271358260.44@tvgsbejvaqbjf.bet>
References: <20190627052515.GA21207@sigill.intra.peff.net> <20190627055739.GA9322@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CLZ1x6WNKSqr16izm6g7ylymdMkWOCheMeWzZVO1MqYrKAMVhWK
 cL4Nk6dLXvp0ekYCLtiwLP3Wu4kt1M/mycEfAP/UmPrsXOoU3CTP9JFv2+VaZagwInI7i/A
 8QCrdaQJFRiF+75JVbBEEgQQBp6Jutn84Ic99yEuWcZYas5xL6CMoOP/f0tJ1eF6JLGEtMs
 afkCqETk8nykdbGTacRvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCQSr1Hf26E=:ZIDZUWTgauiIzvLdczR0ew
 JBc4xUjk4/zg9k/hN3IOQR/JCf0wB8lR93toiBsZKMGOvu/fe5tAHhbrru8TDQsNiFvmZ14Y9
 IBEM88S26Pml8LBi1RPX7XjGj8Z6ZMEkz2DHazeNDjV+0ujPm9HLz6s22Bwc6W/hVrRouvCnY
 GzlaUBD8R7iGkPIIr1UNw+IHCFxHxsYN0BRtvBUY8XP4gtzkHwnTCubGbSUnUWsseYXegF0+V
 lldPFKE0hOhzPGcFB8mmChrX/+yBkpm0VFjZ+ztlDwLlwIwZutlA93PzK4LauFM3AJ9JXWTEO
 aL1UVIDQgcvCSumCIjR8oKFYc3XY6yGUuinDuw8ud33zjfp3iN/NfkPSn95RnokSHAdf6TqKN
 N9JmV7LYl3Erw0633K3dKH6vRbK62smXG9Hchpd62mhlw4wkzEP0A5+JSAs/0SwXD+nelLlDS
 Hawz4w7++UtTvTZaSi2MHErxGyZprIod2qKLML4DeD6lws12MVWgriqdWDuzQCFfHUYO0Eh1F
 5IJqntfSKNVDAm3SQodZdDfxrItvdxVkGnmb0exwRHozdwsWqFcibXeogl1IjyPez4tRTbe2l
 7/R9gxtVc9bko6Ey94JPz7YploXq4BvnlhuGJEoEpq0p0iKU1QbITfnPQ/K+QoPJruckftGLg
 2hlAfFo0FLS+bp9HgQpng+XO9gvsI9ZDUfs2C8FZ3ybZS/PRI7MpPcjXo/aYopQXz4rBLutQa
 M3Y3eGgXtjXXRPaPgcdRYl6qrD10Bbz4ZgMkjpFhFg0PYQvFde+Yu0caDHrejmUXgg6SDdpDJ
 5+/GNWJqJLg1px6qyXUghRc3IGdbojfiLfdXnGNCKuymGpMuR3x/MvpdiRgjSy3tacp2/Qh2j
 EpmVDk/d9NHTXNrXWwnsU46K301XbJPyvw2L2QxGElsRgx7Q1o8CRR7pEJPd6bU/i/kPaNOcs
 8EWiC6i99g6P3fNsWcVTw8oFM2hmNiTsui/eXqU+tc4/LNwa8xgVcLIBqkQft7WCY+TKbsMNP
 S77QCM9L/xXEqQDDZkclv9zwbb2a3i61WixfHX/Zfi+wb7r9m0BZ9A+WSo5EXM3cyO51GiLul
 U10sQKZ7FKXMrQk2puPcfMr16wNA72ZAXa+
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 27 Jun 2019, Jeff King wrote:

> On Thu, Jun 27, 2019 at 01:25:15AM -0400, Jeff King wrote:
>
> > Taylor and I noticed a slowdown in p1451 between v2.20.1 and v2.21.0. =
I
> > was surprised to find that it bisects to bbb15c5193 (fsck: reduce word
> > legos to help i18n, 2018-11-10).
> >
> > The important part, as it turns out, is the switch to using fprintf_ln=
()
> > instead of a regular fprintf() with a "\n" in it. Doing this:
> > [...]
> > on top of the current tip of master yields this result:
> >
> >   Test                                             HEAD^             H=
EAD
> >   --------------------------------------------------------------------=
---------------------
> >   1451.3: fsck with 0 skipped bad commits          9.78(7.46+2.32)   8=
.74(7.38+1.36) -10.6%
> >   1451.5: fsck with 1 skipped bad commits          9.78(7.66+2.11)   8=
.49(7.04+1.44) -13.2%
> >   1451.7: fsck with 10 skipped bad commits         9.83(7.45+2.37)   8=
.53(7.26+1.24) -13.2%
> >   1451.9: fsck with 100 skipped bad commits        9.87(7.47+2.40)   8=
.54(7.24+1.30) -13.5%
> >   1451.11: fsck with 1000 skipped bad commits      9.79(7.67+2.12)   8=
.48(7.25+1.23) -13.4%
> >   1451.13: fsck with 10000 skipped bad commits     9.86(7.58+2.26)   8=
.38(7.09+1.28) -15.0%
> >   1451.15: fsck with 100000 skipped bad commits    9.58(7.39+2.19)   8=
.41(7.21+1.19) -12.2%
> >   1451.17: fsck with 1000000 skipped bad commits   6.38(6.31+0.07)   6=
.35(6.26+0.07) -0.5%
>
> Ah, I think I see it.
>
> See how the system times for HEAD^ (with fprintf_ln) are higher? We're
> flushing stderr more frequently (twice as much, since it's unbuffered,
> and we now have an fprintf followed by a putc).
>
> I can get similar speedups by formatting into a buffer:
>
> diff --git a/strbuf.c b/strbuf.c
> index 0e18b259ce..07ce9b9178 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -880,8 +880,22 @@ int printf_ln(const char *fmt, ...)
>
>  int fprintf_ln(FILE *fp, const char *fmt, ...)
>  {
> +	char buf[1024];
>  	int ret;
>  	va_list ap;
> +
> +	/* Fast path: format it ourselves and dump it via fwrite. */
> +	va_start(ap, fmt);
> +	ret =3D vsnprintf(buf, sizeof(buf), fmt, ap);
> +	va_end(ap);
> +	if (ret < sizeof(buf)) {
> +		buf[ret++] =3D '\n';
> +		if (fwrite(buf, 1, ret, fp) !=3D ret)
> +			return -1;
> +		return ret;
> +	}
> +
> +	/* Slow path: a normal fprintf/putc combo */
>  	va_start(ap, fmt);
>  	ret =3D vfprintf(fp, fmt, ap);
>  	va_end(ap);
>
> But we shouldn't have to resort to that.

Why not?

It would make for a perfectly fine excuse to finally get work going in
direction of a initially heap-backed strbuf. Which we have wanted for ages
now.

> We can use setvbuf() to toggle buffering back and forth, but I'm not
> sure if there's a way to query the current buffering scheme for a stdio
> stream.

It also is not very safe, especially when we want to have this work in a
multi-threaded fashion.

I'd be much more comfortable with rendering the string into a buffer and
then sending that buffer wholesale to stderr.

Ciao,
Dscho

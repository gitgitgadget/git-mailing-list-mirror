Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7501F597
	for <e@80x24.org>; Sun,  5 Aug 2018 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeHEWza (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 18:55:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43750 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbeHEWza (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Aug 2018 18:55:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6d31:4d41:ad10:173d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 010326046C;
        Sun,  5 Aug 2018 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533502176;
        bh=5nFWoWefUxiwUQ09PxDUrO+N/19I0uuUbq5pmD1qSnY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MT+GxScJXDNCt1rhNPO+aDQerY0qdDY5KcVZqAUpmLMqPYesYKQ+VD0xl6RWcHL87
         Sc29IEBQqzntunVrurEOeiY2ITXvAv8uxf0GfMfz43W/WVPkY/ZbZaZ98/Hc91i9Li
         GPLXhWObKFh6L/kbper92oaM7SkJDJ6pOevYuco2ItIKfuZjWZWasmbMT+s4ryA8H4
         YBFoLjc3coF7zEBPQ9txEagqlw2Q+vcRxdRUYqxTjRSLx2Op6FxrMe0Vpvn2Y1W9pv
         k+OA5FjWq2ix++b/ZsvQ3QoLM9GgWSe6U3SAwFvZ3/Hlm1L6pdzuOrvXYbnjk81E3+
         tezrQtfH8HYYCZ5G+KJlB0/XH4nkv2r/XaPWktIl9bQ+UOPEdw8jHBswIBySAIO7xs
         q1HXNejiJge/jm89GiJc5RQ0wGigI7v0VUxVYBIuSpXFhwmdGdnrmaRw8zkY+kPntf
         dlJ7xmOYTbS1ETHf3G0OdiR/5bK07Rx8PvcLeiwHlhxWC9yoYqv
Date:   Sun, 5 Aug 2018 20:49:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180805204930.GA202464@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20180803205204.GA3790@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180803205204.GA3790@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2018 at 04:52:05PM -0400, Jeff King wrote:
> I wrote this up for my own use after our discussion in [1]. I'm not sure
> if it's too ugly for inclusion, or if it might be helpful to others.
> I've only just written it, but my plan is to try to run it on anything I
> submit to check the formatting. So it _seems_ useful and appears to
> work, but only after a few minutes of playing with it. :)

I think this would indeed be valuable.  Junio seemed to indicate that he
would use it, and I would certainly use it as well.

> diff --git a/Documentation/doc-diff b/Documentation/doc-diff
> new file mode 100755
> index 0000000000..61deb2579e
> --- /dev/null
> +++ b/Documentation/doc-diff
> @@ -0,0 +1,100 @@
> +#!/bin/sh
> +
> +OPTIONS_SPEC=3D"\
> +doc-diff <from> <to> [-- diff options]
> +--
> +j	parallel argument to pass to make
> +f	force rebuild; do not rely on cached results
> +"
> +SUBDIRECTORY_OK=3D1
> +. "$(git --exec-path)/git-sh-setup"
> +
> +parallel=3D8

I'm not sure -j8 is a great default.  There are still a lot of
two-core/four-thread machines out there, such as my laptop (from 2016).
Maybe we should default this to 1 unless -j is provided, like make does.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltnYtoACgkQv1NdgR9S
9ovZ7xAAtzICM9NuqKf6aSvFk3AzDE+ZQheDzBJMCkpOuFk7Bh6qZj0TlaHkIDJ3
zH5zph03bx+n99WgW0tc28qYrTjiPXpMcD/om5b12T6UEIBbfjvGQadTv9a+rEL+
vCjNmV7ZOCNmXj8xdVqO3XYO6YELnM2FKjnWoO5Kiz6nfHSAUxPhA2uMh5HBGlun
UpaQnDk4umkVcG/NR1aGwFM/nZADwxxmlEvB6cNCamDpzi0IGCpn/IL/Yw3G2/NB
VFkmXTtSse1zYWi7eULN2AgLwRghQ/0NqUHdg/JSEZiMYqvazq3ONLgnuNX9CEfT
hhW8hbnu/zGcimuv8u5LBWMLriAUQoPTwWXFSzLi1Tsaar/xG/ebz9AdaHlDrhYg
CppEBPLZ28QYqqZIr2aPdZm66ekC4jA4pmzgZ99OV2KRaja9eKyQWton4COUbRDS
uDGu07gTAh2AJtKZM4+okMWrdfJNQRUs2h68fn9R7fhoAjk2OiApFkotjm99DkAx
2FwAgk9td220oy5S6RChdcpZFk+8ID1goqi4G7KHAPz16+Cm/4yxSGKR0Fn968/T
UzQxEm+2ONalO8llavCc68wG51tq7xS4fz8ILplwtYHtMpuEqk7vX5+Aj5kB5oxb
JPxqvIZ8MCMJ6hdfB69auhLqaDp/1LZHkm1tvjRqnZeMYuDGx/8=
=H0Gp
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

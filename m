Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A361F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406634AbfHILrd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:47:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57408 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406175AbfHILrc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Aug 2019 07:47:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE44C6047B;
        Fri,  9 Aug 2019 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565351249;
        bh=vTUdqOVhSYQQFb3OYATtuAo44q88Ssuc2/OEcOSHgyM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xF/evk9d5Zxd6J9eZIMf+5RyKNwMGBcs/VkJ8IFP+ftwcfCU9XgOuNvnnzzPA+2o2
         VwWd1N8snzjDC04kRPXziuHpj6/xLALi79j9MzsqWOPhOwpBcgqMd7DUQl7obfv5Am
         5YrujmMeG//E0deP94jd7WGos960V+dX9OiTfyOK0pBu6b8pi8lYkrf839ohvAXzfO
         hbUInMl4H9lxIJzcfXosKZEmzSbGhZiY+V+1jzf+sZN/UmZN/dAtn7Ibf+EVLOukO+
         aIGgoAjgbiJLjapfnEkbBw0j2otCfV5ALKkKg7fZuxV/FcwIsTSKeUE2M1It6v560I
         IlCYP6vy0cmPDqsKNiyqn0PIPn3HpWA8iUJFqWmeKgXDorWA/2AejRmv4sr8oKK2hT
         e85T2VpA0qYTT4KeLZh7WEjt7jwY0FwwloV9Gqff6Z2ibevtLGQjjU13lRU/OIDz0P
         P1UrcyYd79XQ0grQkjjPJogLu1cUCpGUjaYVfbokpRI/SCqKe13
Date:   Fri, 9 Aug 2019 11:47:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809114723.GN118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190809111452.GA93559@syl.local>
 <20190809112552.GM118825@genre.crustytoothpaste.net>
 <20190809113613.GA3957@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline
In-Reply-To: <20190809113613.GA3957@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-09 at 11:36:14, Jeff King wrote:
> I think you could do this with:
>=20
>   size_t len;
>   if (strip_suffix(patch->new_name, GITATTRIBUTES_FILE, &len) &&
>       len > 0 && is_dir_sep(patch->new_name[len-1]))
>           flush_attributes =3D 1;
>=20
> Not sure if that is better or worse. It avoids the extra memory
> boilerplate, but the logic is a slightly more subtle.

I think an approach like that would be fine with a comment. I'm not sure
this exact approach works with -p0, though, so I'll have to tweak it a
bit.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1NXUsACgkQv1NdgR9S
9ouRfg/+Mfvdl47v6bPbG4QT2JENrr+v2N8TTjuAitFC/H2LNe8gjH0x/ZL1LM4z
jc/rwpGn238+9/8LOb9xUm+0tZJgpfQQbKZTXO9ca++WTJ1saavd1CyNi/0eqVXe
JSTvIIvqjygfco/fAmi/X6KlY8oTFeS0fEOYKrr265FVaEq055Yrcvx613a0/bk1
v4+jdhrPnGQj6v+c1AsDqyd2KQm0+WA8UIOb5jE6h8yqlAUIa10yETDIhcgSLpOI
SQQ5aiU6iJ4/zJc0zHGpBWOq8buPJ18owkQyeD+qvqfAIZbOAFducRbdFxCz5tcc
pRo2BXg1GXsTCWOau4KJ89DFxoDYOJ/1vzV/1MjVHswdKnGp2+X2wYA6n6/wqolt
fgZahOp4N+5LUbF+x+A7ynHcokSrHMgNpkj0g/oLOwvawKTW0Gk7ZVI9bDMkv2bS
ghXOVQRyzWwzTc4uYsoWw5OWUr4w2FkN/NiQ4lfV7HVD5EZ/oGlZNV780+BZdhWD
L0GIn2e/MuV6gjWn3QA8C+kZ0lUyoNnl6Kv1h5xKI1IjX8jewnosab2UwK9HM+0I
g0DSg6mBg16Ag/ef9WXS/uj84QowKgqO8q+lQ26pIToW1U6W/W5rvCP6mwn7eExc
rjxpZbyLm3+nJVMWNWf5aCw3QswD7d0cbfw4H2ySaZbMIY1IPOA=
=Tl59
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--

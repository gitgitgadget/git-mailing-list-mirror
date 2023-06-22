Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6EEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFVVUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVVUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:20:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD81BD0
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:20:41 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2EEE85A210;
        Thu, 22 Jun 2023 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687468841;
        bh=VazS2sYPBH8QaXFgykoq13+FvB8mO8X3NYJ+jt9fXIY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=m4Vrs99WI1TToOwGr6fDZSQOSyRT0V6uOQ636rrbH20LOfM4nqMZhFevDVwJl4k46
         tPERiQVdRz8VgeuufptHlQ0YsPnVzVc7C6WK+BJPGrcgwIJw7bOBrZSc/NTrhR0yqd
         RSSDP4ZGixHgGfdC7PZqevVkbVVp/KWLbcp0Bf0XUtQ53PEi9iLQZcd/iGvj6qqigr
         2hk+ytY/LpMW6FwQMUtVTVCWl/an8i2EURHmRGgFBKYA+rsMB6ZEXSVDoRN17IzL/v
         ulBtoEmezxjuBI7I7DMos5VNPqPbKJfdjKtr5uu7vbjWmUNGa+HHX+M/PrWUmE4fdN
         vYPqAekkTc8j8sBqW57DbZr20IDw37JhqOymWkvzk6l5AV318Q5U/lsWk4om8EsM9q
         7Np3WIK0L2d7+yvijf4d9Myps4UwwIrze+YWw/q9IvJ/QDorhap8W7jQo2c4455yn1
         WyddRkR3nc8lTq18BzeK5bxaDcGxc8WZB4Zbm7o1UkzOyMLTEWP
Date:   Thu, 22 Jun 2023 21:20:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
Message-ID: <ZJS7J/IoHqgZISy6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-2-sandals@crustytoothpaste.net>
 <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VwZIFudwltPTknl+"
Content-Disposition: inline
In-Reply-To: <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VwZIFudwltPTknl+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-22 at 20:42:31, Eric Sunshine wrote:
> This can be implemented more simply without a temporary file:
>=20
>     shpath=3D$(git var GIT_SHELL_PATH) &&
>     test -x "$shpath"
>=20
> This is safe since the exit code of the Git command is preserved
> across the `shpath=3D...` assignment.

I can do this in v2.

> Similarly, there is no need for a temporary file or an extra process.
> This can all be done entirely in the shell itself:
>=20
>     shpath=3D$(git var GIT_SHELL_PATH) &&
>     case "$shpath" in
>     *sh) ;;
>     *) return 1
>     esac

That's true, but this is much uglier and harder to read.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--VwZIFudwltPTknl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJS7JwAKCRB8DEliiIei
gbOTAP9Drib005PtRilwTqD/z7kPi4YjyMirTQuPFgKBBCtVkgD+Md2I/lmiet3B
Rus5CG0RUo7h7LPaGUE2YhczohWqNQg=
=rgWE
-----END PGP SIGNATURE-----

--VwZIFudwltPTknl+--

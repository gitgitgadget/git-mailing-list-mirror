Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C48211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeLFAXv (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 19:23:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57188 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbeLFAXu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Dec 2018 19:23:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c029:e61c:1a0c:a1e6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3452960100;
        Thu,  6 Dec 2018 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1544055827;
        bh=twoX6G0VZN4JMbnWSzoNcwOicExW1FamzA/H6ypFjIs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dg8JJzVJNfr1PxqDrEMG0IDqaeXaG7dkk7Bex309oVNxnAM4U9T8Btp8jv66PEvun
         MeVYyp8PWnedS8d2VnuNwU+2WA127QjrbcMiwgjWzvujDloi+uNpJrrp1roooNfd/4
         4xP6RZx6Uh+VzG0GkYnQ4ftR5MGZK9ne5YoV8GSE+JrVKnLWDuzVjQwv8n2f68F8px
         XxdSqJgG2aemGEMKp2NPIz4LB5hI4BtZjhV4FkfJupELNVd5i7xubchxu8yZnrhJxe
         79ko9OrKOMSynG6EWUO84yGs+TUB/mSfu/+TRg3EkR1w4QLuYb7obLoB4+Q8Ki5rIB
         ARHeyOR1Tys5G6ci9OjeTdSQOsQuW7DgatpJQPWJRR9coleCmla7kHFrmyjAlVVCF1
         8gsCBvSKUisDdhRoiw1aL5oowenCfxB8eAqT2yBrcdT//FxiEjzg7iB3jcOfoXmImP
         BOvEJNvfEf7Urx8GR4MSpCWr1j501iZuqqODD6rDtZbFt//jnCt
Date:   Thu, 6 Dec 2018 00:23:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Coiner, John" <John.Coiner@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Message-ID: <20181206002342.GD890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Coiner, John" <John.Coiner@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <20181205210104.GC19936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C4ZO9l7mQWyMv5+Y"
Content-Disposition: inline
In-Reply-To: <20181205210104.GC19936@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--C4ZO9l7mQWyMv5+Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 04:01:05PM -0500, Jeff King wrote:
> You could work around that by teaching the server to refuse to use "X"
> in any way when the client does not have the right permissions. But:
>=20
>   - that's just one example; there are probably a number of such leaks
>=20
>   - you're fighting an uphill battle against the way Git is implemented;
>     there's no single point to enforce this kind of segmentation
>=20
> The model that fits more naturally with how Git is implemented would be
> to use submodules. There you leak the hash of the commit from the
> private submodule, but that's probably obscure enough (and if you're
> really worried, you can add a random nonce to the commit messages in the
> submodule to make their hashes unguessable).

I tend to agree that submodules are the way to go here over a monorepo.
Not only do you have much better access control opportunities, in
general, smaller repositories are going to perform better and be easier
to work with than monorepos. While VFS for Git is a great technology,
using a set of smaller repositories is going to outperform it every
time, both on developer machines, and on your source code hosting
platform.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--C4ZO9l7mQWyMv5+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.11 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwIbA4ACgkQv1NdgR9S
9ouPmw/8DUFRJQs0PkbYAy3ae3jjNabm5+JfeRWxVgNelEh+ZFaY3oVgkx7ZopOj
lN010o9yxvbbvEsXW7WbyehopaVRD6SWw6dF3O8a6b2/IDOy7gyae3rpVHQDpi/9
cJsAeXGawcZA7/iq0Fu8jBrHInezDnEfq6dDNwBb8XX5sCXUK7exn40Wq0eA02JB
5xd4CFBjX0SZm+zDGJYY2r40RQVcU/0cbRg2HIfUcC8lXrQ6q3t9jB5MkuJU9Wcr
MBnjFn35XitHbQ9TS/8EoMJPDoA94R/klSCAnL4BNa7ZV8aiUeKh/omAKoxjRx+Q
onYN4MlYwqf6aM0ZMLHWQLUvVY+5b4TtMzk20V7OVnikdHFUNwfjBh5VKrhqbBeQ
BdrjlMx5syXLQ6R/MKhcM/vn1OwhG6W72zXK8IK1O1jvCOdCZSyf+BXl7xDiScSS
ZrxbTfVLNM1ku3HGtUku1jaxxKRsRHL846LMo/3N5rCbMDDjrPMlmfdWsca8iI6Y
bcoZOpqy1cFlCjIsrdnKyHBsT6M7P9QUw9Ha5YWVLs2C6iXuyScMFuEsnY0yQ+lt
eqZTZXjYgl/Pj6qQhINXgK08Zd20ljetJFtkEYTmupwBxoBZe+II8hAPHfaAsCm7
awtY5Xbcyc2CsDNz9hqLgT5TUfpicpKEbR6KEAvm6umAoILEkmI=
=FMdW
-----END PGP SIGNATURE-----

--C4ZO9l7mQWyMv5+Y--

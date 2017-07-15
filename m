Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EF02082F
	for <e@80x24.org>; Sat, 15 Jul 2017 17:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbdGORWh (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 13:22:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60930 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbdGORWg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Jul 2017 13:22:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AC6A5280AD;
        Sat, 15 Jul 2017 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1500139355;
        bh=SJVJYbfMb+1oBECUMxz9m1P2Eo732UKykXn4Ch6lifo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcCNsNIXMbsWEQSHxb7t9odIGQWA3ibsXlVI0jQuCIjHMD6GNWw5bAcMsPjTq3pO1
         IkUcLSW7xZW0b2JL3XZ7YQpIRJIJc9+Ndti+o/rWgcRcZPzKZFtxS58uBtM2zgJd6Q
         cSeG+CqZcx69GdVWimRrgaHJKy+aT1NkefxEHOe4J4EWDaW2T/xcnGvCIWVR+FLpIH
         G7vmV0VgbdAtkDFkldyQ+wwTajSskMF+6ZeKBqfAwjYJ8UmhU4dSXHJ9IisaJm5Rvj
         Y9toh8J3c4ll/pF2WpyIAAeBl0FAClZUACI36DKco/bIkR00XqOOucZzqUKlvHZNX1
         DvdFF/b9MOkQKkF6uUYd3pY81lupTVgpbW0STJ5TZgLFvMylymz4TwMktSUKdEIupm
         UzNQCVrklf8zuQOsLdw/5f2/JZ/xV2kmZIPj7Q2jaIUYhq2eutp+OWQtNw6dapCORc
         nXLxWs/ceYC+v+d8Vj+5wznSmvqNqrOsKD3BUyFU0Vq4lh9A3Lb
Date:   Sat, 15 Jul 2017 17:22:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct
 object_id
Message-ID: <20170715172230.x65t5pof4upkonpl@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-31-bmwill@google.com>
 <28328b72-40c0-f6bb-09dc-574ca33ce622@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbs7cmgblatbnawd"
Content-Disposition: inline
In-Reply-To: <28328b72-40c0-f6bb-09dc-574ca33ce622@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hbs7cmgblatbnawd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2017 at 07:18:51PM +0200, Ren=C3=A9 Scharfe wrote:
> -- >8 --
> Subject: [PATCH] tree-diff: don't access hash of NULL object_id pointer
>=20
> The object_id pointers can be NULL for invalid entries.  Don't try to
> dereference them and pass NULL along to fill_tree_descriptor() instead,
> which handles them just fine.
>=20
> Found with Clang's UBSan.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> fill_tree_descriptor() can easily be converted to object_id, by the
> way, which would get us rid of the extra check introduced here, but
> this patch is meant as a minimal fix.
>=20
>  tree-diff.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tree-diff.c b/tree-diff.c
> index bd6d65a409..2357f72899 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -421,8 +421,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
>  	 *   diff_tree_oid(parent, commit) )
>  	 */
>  	for (i =3D 0; i < nparent; ++i)
> -		tptree[i] =3D fill_tree_descriptor(&tp[i], parents_oid[i]->hash);
> -	ttree =3D fill_tree_descriptor(&t, oid->hash);
> +		tptree[i] =3D fill_tree_descriptor(&tp[i],
> +				parents_oid[i] ? parents_oid[i]->hash : NULL);
> +	ttree =3D fill_tree_descriptor(&t, oid ? oid->hash : NULL);

Good catch.  This seems obviously correct.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hbs7cmgblatbnawd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllqT1YACgkQv1NdgR9S
9ov7Mg//Y05b7iWqLyVPMvZdYrgDSt13xl0xAwbYdZ/hHq+sTfEueU+pcxZQ9go5
oauHzJlNuk8/PX8lID7RAkQzo7vsb1fZur2NXAPb1gr6RC+ygiTaprvR4onXBjjH
rALNHHXbD2gFRAxNWY4py+0DDxmW1SR08irfj/cDRrPEBu9cuGN0VkxuAgCIhgwI
+fDSLSjHCoy4EWx1V76QIYYBQYYA/hR4LZlwt6EQ8IdvPtczUtWu1pbOUaITm8kJ
TSGFSVP8R7oc+wmdGdxC7GP8xURnTq7sIh6q1EwCCImJM1AXfgOJ1bEIzGlq2aSu
IaasfWfpzvDnFSR8ud4meXUagtx0RuysfmAT8Xp6thv48P9QbObHitsTds1sb5gA
3ONONZk+vpxpvsq10w2L17jhUe/b3/klNdyiiJlZ2lQe1uLfQCSQwlPJlF64Xghs
TE2CcodWegnmNF2+n8U/nhhVBIlxnYhmnlxEtF0zPckTJ3ih5Yt7czWYyVJpkzYg
CKd9bMUaETN439vUxWZ62z0DGifnu0r26svvvtPJye+6sTYOVjcKpGjZpByrjjo0
qwEFjFToAiXGYhuuu57lgIdQVBKnTvPq6krdTnh5h9FuKp/2DLJQQydFadM9ab2f
HQJ+YOaQs8WnW2eai+lL0M3YLpSyPifuWQT2h+4/SrvxR6JUhNE=
=ikK1
-----END PGP SIGNATURE-----

--hbs7cmgblatbnawd--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21181C4332F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D81A61A40
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbhKOXc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348858AbhKOXaW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:30:22 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB0C025556
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:26:36 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D9BDF5B466;
        Mon, 15 Nov 2021 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637015194;
        bh=tnhDKNFUlN9n0IVGYIkc+ZJjz3oUvw7HUDPz5/ZAVZ0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=x+8WLbqvMg7nAYIPkIPGHV9VLwuiBaC+KOINO4g509zjiG+SJj85XbQzWzsjsJMqj
         f7iKzRBAjHup92ufYXam2IffFQDYIl5ewNSQgarRhj4VOolE08gWO3A2TAe/1V3PEk
         SzmaBGTzs2/0mc7F8BhhVALZsQvrfmCZ9iE/oJlBYZb4SBpo6v0atZG64+WmQzrtcn
         DojxFHpY9M7pHusZuzoe9TadOX7jIpFLe0yCP+a9uwENkhuKQWaw/U1Z9t3CWCf+74
         pS/5Bgz0pHvF5KjY94Xmhmn9LE+mV3JCtV3u2A/claCMakcn4idIhp4Hf68kL2BLn/
         L+V/D/m6GDHlFHWAR9QSlK18NmKolSQ6L5730gRGby0OiC/ZFAS4j1G3HiSZoSBx0d
         TQEgMaswzIK8OrxfM1NRFOVPhyC5x/r9i7DtLNH+tEVGWQ1X0Vn7aiDOIgogcsIQCj
         Mt58YApYk4/gQeZfzVepKXXjc0PbtVFiUekTdPg/s8VmENArbxO
Date:   Mon, 15 Nov 2021 22:26:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
Message-ID: <YZLemOWM0rAuRTRe@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g>
 <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g>
 <xmqqpmr2j5lq.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="89HDCV+9+xfhCF2+"
Content-Disposition: inline
In-Reply-To: <xmqqpmr2j5lq.fsf_-_@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--89HDCV+9+xfhCF2+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-15 at 06:27:45, Junio C Hamano wrote:
> There are certain C99 features that might be nice to use in our code
> base, but we've hesitated to do so in order to avoid breaking
> compatibility with older compilers. But we don't actually know if
> people are even using pre-C99 compilers these days.
>=20
> One way to figure that out is to introduce a very small use of a
> feature, and see if anybody complains, and we've done so to probe
> the portability for a few features like "trailing comma in enum
> declaration", "designated initializer for struct", and "designated
> initializer for array".  A few years ago, we tried to use a handy
>=20
>     for (int i =3D 0; i < n; i++)
> 	use(i);
>=20
> to introduce a new variable valid only in the loop, but found that
> some compilers we cared about didn't like it back then.  Two years
> is a long-enough time, so let's try it agin.

I think you absolutely need a compiler option for this to work on older
systems.  Many of those compilers support C99 just fine but need an
option to enable it.

I think this could go on top of my patch, though.

> If this patch can survive a few releases without complaint, then we
> can feel more confident that variable declaration in for() loop is
> supported by the compilers our user base use.  And if we do get
> complaints, then we'll have gained some data and we can easily
> revert this patch.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  revision.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 9dff845bed..44492f2c02 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -43,10 +43,8 @@ static inline int want_ancestry(const struct rev_info =
*revs);
> =20
>  void show_object_with_name(FILE *out, struct object *obj, const char *na=
me)
>  {
> -	const char *p;
> -
>  	fprintf(out, "%s ", oid_to_hex(&obj->oid));
> -	for (p =3D name; *p && *p !=3D '\n'; p++)
> +	for (const char *p =3D name; *p && *p !=3D '\n'; p++)
>  		fputc(*p, out);
>  	fputc('\n', out);
>  }
> --=20
> 2.34.0-rc2-165-g9b3c04af29
>=20

--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--89HDCV+9+xfhCF2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZLelgAKCRB8DEliiIei
gTL9APsG4G8xFmomiuwa742HZaOjWUbgLY6dbn3BSz15H64HRwEA686CdecwlTfG
Zht+a9Xukyh8fxwZJep4WfOMsObMxAM=
=YEwR
-----END PGP SIGNATURE-----

--89HDCV+9+xfhCF2+--

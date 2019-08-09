Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297211F731
	for <e@80x24.org>; Fri,  9 Aug 2019 00:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfHIAWz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 20:22:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732796AbfHIAWy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Aug 2019 20:22:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c831:5a62:6d5c:8da3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9A60F6047B;
        Fri,  9 Aug 2019 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565310171;
        bh=CVCGLhcjprBRualWrHuN9e+nnk7wVRWZ04FQBVeQxZ0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=R1RyhjaTccjgoIF/5j1iUkaiqSNIuXMzAnp0WCWG20JZvL/0A5CQsZmL2+yW92ArR
         QQ+0xcmOiSs7vq+D+EkjvwJkvfZMgZaJT0+ezf4Rhr1UCcZc6Zq61Xb9Ap01Wrh8lL
         XVRLWLY4kz7UgKXj8VgPUEEFVVrv04d6bZaZamr4F6cKRbJbPyy/xZEupRcp7Hcsit
         jFIlDHzm8M+TMBvROY+mHplu4+34jW8Cn72O4xoh+VLoPbNJengWOomPC80zHqrnGg
         pGF6CC/djTjxC8SLjexqJDmQR+zncx+SG/dTAl4WFDXmobzsnFgGOw7ZBGXMWjHZyh
         PhHYPJH1biJJnhQDhwdyq4EHxTQTFlBzItJ7E9yYqTjEsjmmd1p9ol26jtNdVHXjfm
         s8eRBLiFbkO15RiJn9JBHEQLMQLVy6/vbM3J6IuEAKWw5M42OnFTA+uypE2U2apl29
         1j/NeSB7SemWINaEyGcamQx7D29WWoyCE5yYFQ3l0eM+JnXa8Am
Date:   Fri, 9 Aug 2019 00:22:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christopher Ertl <Christopher.Ertl@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Windows absolute drive path detection incomplete
Message-ID: <20190809002246.GL118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christopher Ertl <Christopher.Ertl@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline
In-Reply-To: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-08 at 16:44:52, Christopher Ertl wrote:
> So I'm proposing to remove the check for the drive letter being alpha in =
`has_dos_drive_prefix` macro:
>=20
> #define has_dos_drive_prefix(path) \
> 	( (path)[1] =3D=3D ':' ? 2 : 0)

Is the drive character required to be ASCII? If it can be non-ASCII
Unicode, then this doesn't work, because the drive character will be
encoded in UTF-8 and will be longer than one character.

An ABNF grammar of valid Windows path names would be helpful here.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1MvNYACgkQv1NdgR9S
9ouF6w//Z9LWbCNzrDIm3Zj4K/H25Rf0JtEozTEn+O3Qkt8deGZsHu0rUbmxfFN1
Wwo3rhFeop9Y1UtDNXWz88gpj9t7J4Va/qPT3m3OYfYwFh631jDyzfNBPfEJ0U1+
9I00OjfAhXXTy+zU+CJtbUFh7WqqAz7vLtXvIbEMvDW9ZwozYDuZEG7PcQlriB0c
Kfnd/LbojIvSiEDxD/IKIVXrib53XvzLJFH3eNnpiKMt4QVqcyI9i0ZnjyyM8A7k
mg+N+KsvcxlhKqpS0VeDGuAmCAIGzIFIpiIpav6jhEUSe7S4ppw1zZHDOzL5o620
cHIrf9nXD/VUszTHJ7vbPvvM5xlheYFyYCRV7tiTRPNzeHwaI+dGFr+DiyZCjmmj
PYAxxsiGfQHJJ60JgYdB+7I1BaKJXIC1/XvKYCKspSjGkjAO6Bb1s540MaZNNxhe
IQmqNMM15wpDzZN+mbH8GgbfvgFHXGEDvUVKGZjgYQ8gW3r6ZrQX0DSNhueoqEMQ
dkUWiTTKqN1944q5fHYDQO4tcXYaL/VCNiAJuXMmvS7F7FoQarlecUii6KH0M0Ex
eh8LD0n1x6Od7SKj3U1/aTjIh+oDYvOcOzjIc+QTWcpmyRE5vIlEc1Y1ZCtRyTrJ
Msgz2ocIvW93h/FVEBxnfbd+xHnKsnOWo8WQ8H6qZd8bUJw9RPM=
=ELVV
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--

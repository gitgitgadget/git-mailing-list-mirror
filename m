Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E4D528
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233837; cv=none; b=WsLw8g1Alrv5EfI/o3gC4U50by73skCtCGhZO2PO+2gZ8lRXK2CF+KUusknKYsJAk1TiO4QLlYesYrR7nRXjpZb/HdUnqKQNwiF7SdJmN5tnLMLcc4kcGKRCcmykRbStgybl4Mc+bMz+CF7Ycu/YIK/xkI+UU/a3dSPSsSt//Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233837; c=relaxed/simple;
	bh=S4T/xUK795k75kFXM+dtvDRdwaG8MN5MJUoe+uwnCOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5ytAOeYDhhuHSbZI0BB47V5HDsWUbl7G1PiwsUn9bV6LH/MWzGZz0a9Ig3kQWtTftScNvpIEf/B6f2vkDiTIxrz2kMoMMZVYC3IxOh3/2NdMKcQ1t78rLuyCu+VPDkTdDaCHMUb6qAZN43aBAPJbwHrw7RRbMrBAXcn8HPJ3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fkzFl/lK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fkzFl/lK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746233833;
	bh=S4T/xUK795k75kFXM+dtvDRdwaG8MN5MJUoe+uwnCOY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fkzFl/lKuMINcRMYxaA/QPZIzLjHx26hdfHa8r2nubl3psbrmR68G0ic31sGfWiDp
	 0iAXkdk0nKyRmYE82/3iewjs3X5ajgC2lKoBT/JRJW4TfJGUqyoEiPyJJh0bH/I4iK
	 aNuPHqX9Vj5btww9v22Mo23CR8J9rgecWSFA9iw41LuBP/Ouvk4e5W9lNePpg6GVvW
	 yEQqz9wNGpyq+H4Dyr13O5nX9S3HBTm4grmh4exrj5hB7qst0RAPxvQzPjlDr6vl1N
	 iGVbd1Y+OPJT+EyTL/OJN8c4Z8TWckkbs3sJucT75KnDfYvxUSsPsJJjBUDOyskSCc
	 VgMDwK24aPNUz+h3nwm/r4ytIfQ17avmjwavKfi5D8eqWLXfvorLB9kQQpAnfDNpuy
	 4JoMt8tIZo7ojlwusar6ru3McEJVqoNr6Rxf+c/y3OebA6apd2VcpXwnI6zn4L1VgL
	 Kp72/rt7kpoU91SCdwIU1hJwPBhGPdymWHPnYxK/f2JHcGlgT84
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3BBE12011C;
	Sat,  3 May 2025 00:57:13 +0000 (UTC)
Date: Sat, 3 May 2025 00:57:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GDM5ibzO46MtpyOo"
Content-Disposition: inline
In-Reply-To: <20250502233403.289761-1-collin.funk1@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--GDM5ibzO46MtpyOo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-02 at 23:33:32, Collin Funk wrote:
> As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
> symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
> This patch fixes the following test failure:
>=20
> $ sh t0602-reffiles-fsck.sh --verbose
> --- expect	2025-05-02 23:05:23.920890147 +0000
> +++ err	2025-05-02 23:05:23.916794959 +0000
> @@ -1 +1 @@
> -error: packed-refs: badRefFiletype: not a regular file but a symlink
> +error: unable to open '.git/packed-refs': Inappropriate file type or for=
mat
> not ok 12 - the filetype of packed-refs should be checked
>=20
> This portability issue was introduced in Commit
> cfea2f2da8 (packed-backend: check whether the "packed-refs" is regular fi=
le, 2025-02-28)
>=20
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  wrapper.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/wrapper.c b/wrapper.c
> index 3c79778055..4d448d7c57 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -737,7 +737,19 @@ int is_empty_or_missing_file(const char *filename)
>  int open_nofollow(const char *path, int flags)
>  {
>  #ifdef O_NOFOLLOW
> -	return open(path, flags | O_NOFOLLOW);
> +	int ret =3D open(path, flags | O_NOFOLLOW);
> +#ifdef __NetBSD__
> +	/*
> +	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
> +	 * time this errno occurs when O_REGULAR is used. Since we don't use
> +	 * it anywhere we can avoid an lstat here.
> +	 */
> +	if (ret < 0 && errno =3D=3D EFTYPE) {
> +		errno =3D ELOOP;
> +		return -1;
> +	}
> +#endif
> +	return ret;

This patch seems reasonable and correct.  I don't use NetBSD, but I do
often test there, and I'm aware of this infelicity.  I'm surprised we
haven't hit it before.

I suspect we'll also hit this on FreeBSD, which has a similar issue in
that it returns `EMLINK` instead of `ELOOP`.  I do wish these two OSes
would provide an appropriate POSIX-compatible `open` call when set with
`_POSIX_SOURCE`, since this is one of the biggest portability problems
with them.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--GDM5ibzO46MtpyOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgVaecJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ7Cur8KnmvbSPLdo/wBpn+SlZpOtuWrcWb0LxyLZRdTi
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHotAP4o6/4QENw3LaMFiG3OL8TAkHlt
4czQQE2P6OChKiSmpAEAohm7Ev6STDm70hDa/GHEgk2xYpA8ZDiM3Su27yIhaQ8=
=4F3e
-----END PGP SIGNATURE-----

--GDM5ibzO46MtpyOo--

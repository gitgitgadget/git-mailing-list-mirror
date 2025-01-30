Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F012E7E
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738203985; cv=none; b=DgC5LQ8Hp5d2e+LkzGhMY8hc2U1sGqrJNCYLORUlLFNG3sT4VqSdgJdoQRTQ8mf7a49W0joPTTkd6O4kVsbyLgff6gH653eatcQe/OmBWUID973sYUfftOC3+Nk0nLbGqOvrTNZiGL6T2rzvbx5VSjwFoo2/wIuTK4Bp0NDDQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738203985; c=relaxed/simple;
	bh=9HlcIqsaU/4D6PWVm37KpdbsnHCPB+d2KOZb9EmG43E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhBCTsFRKEBCgu/T2f3e6FJpD/j36+0VZ03hZjLQmKwG4cTXGcTpGeG5KOsW5XHnfnZIWKnYdDTYMO6wRLzmEJaetiMMKRPbVp3kZfBKREtz4GDsiT27lKxpUv24LTtD48PhNNUBQE0+1Bi35IgKvSHS4d1iyKRPhKyyxwxZ54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Fm/IiUHx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Fm/IiUHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738203981;
	bh=9HlcIqsaU/4D6PWVm37KpdbsnHCPB+d2KOZb9EmG43E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Fm/IiUHxycztPv+9NFW3/2V6g4X1I0DlCB5tu0zV1lBJtCnpZzmYgBoIQIdscrtiA
	 ttQh6JNL9oIfUjw52AoaJYoCpARaO7ZTjf7cwlPbUtdT+rwx6ezRXFW78KbyNF/Q2p
	 t+XgGDzR8tmt5gsq2wi5aS5hjhEZiObvJn+db+8su0d11nXM0+taB0DgJTh+lGFw61
	 7f4GiDUQmqoR1J9BQDHDTtahDhxOE4I5TAVWRJgWQckaIiN19wonb9XhZyaaWgJ+qY
	 BgpNud1isMGLnnTYOnBNBEwF16vzAHxBv0FRlDWCpTcLqW2p1+D8+ZHbwCeTkqPKcF
	 nB4kp4uVgxqdamk6t7wHv/SYsZ2BJ1H66iaowvAyUzHoranrIk87GkQJeO0aLUF0Tt
	 I0BbsFMHfyUnDskcz9nXbt7c1QDa6g0ZjjWsLSzlyeAewh+yh3gvMULe+TRA8Jk8wd
	 QCLj/5OilVVsQPooY7thwuYiKgjxJ/emkayE3CJu7KhgmEz9bnz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 652BD20042;
	Thu, 30 Jan 2025 02:26:21 +0000 (UTC)
Date: Thu, 30 Jan 2025 02:26:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH resend] builtin/repack: Honor --keep-pack and .keep
 when repacking promisor objects
Message-ID: <Z5rjSzjOXrV77_nJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
References: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3TclfUqYG9DC9N/7"
Content-Disposition: inline
In-Reply-To: <2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--3TclfUqYG9DC9N/7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-29 at 10:02:06, Tom=C3=A1=C5=A1 Trnka wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index d6bb37e84a..fe62fe03eb 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -388,15 +388,23 @@ static int has_pack_ext(const struct generated_pack=
_data=20
> *data,
>  }
> =20
>  static void repack_promisor_objects(const struct pack_objects_args *args,
> -				    struct string_list *names)
> +				    struct string_list *names,
> +				    struct string_list=20
> *keep_pack_list)

I don't have a strong opinion about the technical aspects of this patch
(nor sufficient knowledge to review it)[0], but I noticed that there's a
couple of places, this line among them, which are unexpectedly wrapped,
so I don't believe this patch will actually apply.  I noticed that the
email didn't specify an MUA header (or I missed it), so I can't make a
suggestion on how to fix your MUA, but you may want to use `git
send-email` to avoid this problem in the future.

[0] In other words, no need to CC me on a resend.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--3TclfUqYG9DC9N/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5rjSwAKCRB8DEliiIei
gf3gAQDBa9v8+mVTXYjD9zZJeL3QldzKM42ZOohAkTyLvYGszgEA4y4+FLjQ8/v5
xjsZyeXHbskUhT4cs9GC38sWBPw7xQs=
=dUaR
-----END PGP SIGNATURE-----

--3TclfUqYG9DC9N/7--

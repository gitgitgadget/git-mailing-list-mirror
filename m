Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044981D5ADE
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783789; cv=none; b=lic+oKhc37IyISpNMtN1CPwPam10ZxafMa4q3xc0IPUICj4SVK9QYvppbX0gJk9gJlRdyDzuKe1sx5lmlRuVQauboi96oSWI/MNGYd/huSIEU/7LDRRJSz9Xrs4wvxwoyXP9geRP1ZS0vI9VB6epHe9+N3kjHIfiqRfscabOd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783789; c=relaxed/simple;
	bh=uMFF0x8nKM7Vg448iYNwQzVNx1bzNIL7Q34hrLE1or0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZECcmgmDMLh841v7/jiFGveLIKdNajt2aILaLuOHK0zJ82LiMAuDxuODWHc045oKUfrFzSZ0STtpFL8D/gO26FjJGAkttInWhg0Et6fw3BZ4ISKgmqES+AAB740FH+ql6Hq3qiHi32Px9zNdu1tGcsF3mPFDAQdaV3DFXD5WAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LsQB9b7Y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LsQB9b7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761783784;
	bh=uMFF0x8nKM7Vg448iYNwQzVNx1bzNIL7Q34hrLE1or0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LsQB9b7Y1cbnqhZ5aErclLWnnvp0z6oNxon39vqvAuMGkNtr7WT7/aNap3Ek0N0qL
	 oRp1WlQk8FzrPic0Ip47qyiDVoVpzRRezuEuqgO6VOYCGVXiLwokTyYb/vf/CQmZIl
	 UqGX7bQJqN+1f7f3ORIFj5fB5hbZ5a1CIApKHv2ZY5AHv033g7FxFQ7nngrhGNyhv4
	 1uKLExgKlazaZemyhE+2QbFaDAQcAq8mSRNfyp+5EH4CEcw6wqESk6LyNFvx4apeyH
	 C0xLrGzyQxsh37t2eKqG/Xq41T0ss04nsIlW8LkXkAG2ETfQUMPHvPAkj/YCHzMo+L
	 qh3YT2qiwu2SyDytzmPeRlgkvGzr3ghnDDDiqwwzjRu6ZCxLXd1jDWBj2stnXJ/DGa
	 KgRCu0fi2A4/vqaLNAxtMmL1hnwH3Igm9QdCYK7Q2ijhvRXdi2j4l3a5EA0g8XYCkw
	 WtEjy8qoPBsJeBkW8A+uBSqHLKttW2W5LKSoGkzOlvYq+TW43fm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8caa:b0a3:2e22:c46c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A52F220036;
	Thu, 30 Oct 2025 00:23:04 +0000 (UTC)
Date: Thu, 30 Oct 2025 00:23:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
Message-ID: <aQKv550C6nXhCzf0@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net>
 <aQCKCfuaEKBArD-g@pks.im>
 <xmqqh5viddo3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YO/V0k3riCovn2n4"
Content-Disposition: inline
In-Reply-To: <xmqqh5viddo3.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YO/V0k3riCovn2n4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 19:33:32, Junio C Hamano wrote:
> Yeah, I do not very much appreciate change from "int" to "uint32_t"
> randomly done only for things that happen to be used by both C and
> Rust.  "When should I use 'int' or 'unsigned' and when should I use
> 'uint32_t'?" becomes extremely hard to answer.

In general, the answer is that we should use `int` or `unsigned` when
you're defining a loop index or other non-structure types that are only
used from C.  Otherwise, we should use one of the stdint.h or stddef.h
types ((u)int*_t, (s)size_t, etc.), since these have defined,
well-understood sizes.  Also, in general, we want to use unsigned types
for things that cannot have valid negative values (such as the hash
algorithm constants that are also array indices), especially since Rust
tends not to use sentinel values (preferring `Option` instead).

Part of our problem is that being lazy and making lots of assumptions in
our codebase has led to some suboptimal consequences.  Our diff code
can't handle files bigger than about 1 GiB because we use `int` and
Windows has all sorts of size limitations because we assumed that
sizeof(long) =3D=3D sizeof(size_t) =3D=3D sizeof(void *).  Nobody now would=
 say,
"Gee, I think we'd like to have these arbitrary 32-bit size limits," and
using something with a fixed size helps us think, "How big should this
data type be?  Do I really want to limit this data structure to
processing only 32 bits worth of data?"

In this case, the use of a 32-bit value is fine because we already have
that for the existing type (via `int`) and it is extremely unlikely that
4 billion cryptographic hash algorithms will ever be created, let alone
implemented in Git, so the size is not a factor.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--YO/V0k3riCovn2n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQKv5gAKCRB8DEliiIei
gRYYAQC5hdlsdsG9Gb9U5MiB2kPCtuEGZg1m0lbgS4smnO7tjQEA0F3JPwIDjoOL
0hiHtFc1/UPwp/k+CyOaXd8mKrIp9Aw=
=2AR2
-----END PGP SIGNATURE-----

--YO/V0k3riCovn2n4--

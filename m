Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC954A2D
	for <git@vger.kernel.org>; Mon, 26 May 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289827; cv=none; b=B5uz5d8urpzvvGlb2xHHN3R2AcF5LiHlWTA83uYgVKvrBv2YtUX3Nwu6SkRh/O+gliSjEKHNqdzy7RDxHwUvJI349/IeiXCPz8fsMAykIZLdZ12+IsEBNU9eQi5FqMNkAMEtKCmf0wH9X49yQMqqRw5f/IMX4I979i4almg1Dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289827; c=relaxed/simple;
	bh=MwbR+4+VxxAdTasPBsOa4NElP5CCZ+QtGfnpu3l8lZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbjZw6iQOEAW/S5CKhe8zUgba2yaZDM1fdULmBZqWx9tUSqI1rT5r7QAnayDR47+BrVNc2EU9I24AlAelxTm3b7j56yVZ/ZXFohZ2JsVpUdQRVs622eAMPDkk5yLs1iNVItF+O/0aNxlZEJhRvUo0b/g27IqsdlhOBX/VywsM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ee+IXqqX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ee+IXqqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748289823;
	bh=MwbR+4+VxxAdTasPBsOa4NElP5CCZ+QtGfnpu3l8lZs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ee+IXqqX3x4Zpn6Z7yyYSodiSm6DqxbeLPZI3JOv26BMZVoapJv+uOD+egxsDtbHi
	 o0XaED/8xte3nAF7JCtvLK7eBB/37yMaIUmqT8DajIJtuuwXCOyvlKSKow94fDegqH
	 GWlfQecF3/cutn5XiUhrp3GdInGxneLFDI649C6Az2k/JPlh/JCw8Kkvn8EYu8PFeR
	 ZJjlxLPraDMgfjybaXMD51hHfEDBNBD62UcvQ3IJXAHwHpo1SUP20UZVNhW2RFMVKV
	 Cr+pK++wypSl++IoEpnLNswerBqx+UKt/yO/ycPpIrg8yJtUM6dsV7qbFKo4BwK9R1
	 oEfuTJwHiAPB20/hsiROGE9l1ZV9bNvEMK8a4huVfQt/TlYemjN8vSyT9lSyr5vMw3
	 TFsk/tGY2rSerpIyonPEauFoCHr1Oh8d+OzxU/IGgcpp2qG+8aOQb4sM+pDr91W6fL
	 qtHclTFYA2TjVn3cfr7yjN9JJbsEfMcm5XZyLFYITxwQ/gwFwhB
Received: from tapette.crustytoothpaste.net (unknown [204.148.157.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E853220038;
	Mon, 26 May 2025 20:03:42 +0000 (UTC)
Date: Mon, 26 May 2025 20:03:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 5/5] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <aDTJHGmCnvdFkswt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-7-sandals@crustytoothpaste.net>
 <xmqqcyc04akc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pMfR5C07PDrw7f+2"
Content-Disposition: inline
In-Reply-To: <xmqqcyc04akc.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pMfR5C07PDrw7f+2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 21:09:23, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > +		const char *author, *committer;
> > +		size_t author_len, committer_len;
> > +		const char *p;
> > +		const char *expected =3D "git stash <git@stash> 1000684800 +0000";
>=20
> Makes me wonder if we can somehow share this with [4/5] where we
> establish the author and committer ident (timestamp spelled in a
> different form).  Three strings that has to stay in sync is not a
> huge deal, though.

I'll take a look and see if I can come up with a nice way to solve this.

> > +		p =3D strstr(buffer, "\n\n");
> > +		if (!p) {
> > +			res =3D error(_("cannot parse commit %s"), oid_to_hex(&this->object=
=2Eoid));
> > +			goto out;
> > +		}
> > +
> > +		p +=3D 2;
> > +		if (((size_t)(bufsize - (p - buffer)) < strlen(prefix)) ||
> > +		    memcmp(prefix, p, strlen(prefix))) {
> > +			res =3D error(_("found stash commit %s with unexpected prefix"), oi=
d_to_hex(&this->object.oid));
> > +			goto out;
> > +		}
>=20
> I'd call that "without expected prefix" (the difference being "we
> expected 'git stash:' prefix but you have 'git stosh:' prefix" vs
> "your commit title is 'hello world'"), but OK.  The important thing
> is that we are being careful not to get confused.

Will fix.

> It is unfortunate historical practice to measure almost everything
> in "unsigned long" and bufsize here is one of them, but do we need
> that cast?  We know strlen(prefix) is a small known constant
> integer, we know p is not smaller than buffer, we know (p-buffer) is
> not larger than bufsize.

Yes, we do, because Windows will complain about a comparison between
signed and unsigned integer.  `p - buffer` is `ptrdiff_t`, which is 64
bits, but `unsigned long` is only 32 bite, so they both get promoted to
long long, which is 64 bits and signed, and then the comparison is to
`size_t`, which is 64 bits and unsigned.  The CI jobs fail without this.

I'll make a note in the commit message to that effect.

> OK.  Again, I suspect that commit_list may be a more natural thing
> to use to accumulate the stash entries, but that is not a huge deal.

I'll try to fix that in v7.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--pMfR5C07PDrw7f+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg0yRwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ6eFcC/KriB/O1AaMXI7TVZ5kCiYOttLgNoYLrgxjes/
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADbDAP9RLORvUoA2T9EadnI5YIU+avxC
EkcbdnlEc6xDLluA9gD7BZWytX/pblrUuhJEku9REJhNWldJ4xwZyCPOfqLtqA4=
=3aGR
-----END PGP SIGNATURE-----

--pMfR5C07PDrw7f+2--

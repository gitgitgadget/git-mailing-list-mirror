Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575E3368AE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676976; cv=none; b=pZmx7M+KDbZ1y2kDj22f8moK0t6RNaW2tXIsGIKbVLPaHQwY4Zi9vTZlIrw6mBHQDCsuELSm8xmHZSqemnLGFEd13E3PAkBuRIWf6JUzzEr6nhDCjfrnZguSuAkZL1edRWbPn5sSIbrHY+FT6eWo5amph00TZwC5p0eSO8pUijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676976; c=relaxed/simple;
	bh=pmx9i5vZCwHD9XQ2/FOiM8vf62xjseb6FqZB0ceE854=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRwgneYUa7qTiD/DDpmLF/jPAJGEWvDqpL+d/pLtUQi1V0ZAF81uSaK9nLtxsDOyymQstt0BLOCqweLoYhzo19i4XfmYLcneiFmf+9Hgq/o6sty1pFJwonjRBqpNtbCWzHX+w/2wokIH4zDvuHNU9MQVsdX/1aTDoAZn0Lcx8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UEoU90bZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UEoU90bZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772676967;
	bh=pmx9i5vZCwHD9XQ2/FOiM8vf62xjseb6FqZB0ceE854=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UEoU90bZqowhMDuqW5TlJ6xuSXLDZnaRCBYLOWvV4g945/nnVgoG3atWvnPUHcwct
	 IrGAxgGFXkZ3KDuhsUVVX1AsnHs9+RJlJFUtxLrd3vMY46ByJ9+tc3VjvoHozjJBDm
	 /49a8x31RWNbkmPyQz9LMxuL4mfQt9MP5Pxfoe8YiVOUGDYahwzbdIiD6n9iSDdEBg
	 BF/WbLt8iz0LR7CFkdeCbjhgOKV3LiSoZlaJkKOWmW5JYnYuoRujSi1FRKbvNZMJlr
	 isUTAjEULuB9ms4+elRxUs7MjG8x7WhBikrRufcbgLTUCVPRTbntTg4pS0/NXZLpzI
	 Ra6Py0HqV016hflSTSdLxnWmNLigGK0bG9as/+5nR93W9dg/LMU7JitqZESPYCBHRI
	 tBtdcaW6Y6T14WHapF8MbQ84bHfphyHsieZ0OiQQnZyLHtFxbiJAiFgj6OOSF6jEtK
	 p4g9Cy7s25blul+TMv39mpKHaAMCfHhH3bdF9Zfeamxz7bGnVUf
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:aa9:e857:742a:574e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 15EAC20107;
	Thu,  5 Mar 2026 02:16:07 +0000 (UTC)
Date: Thu, 5 Mar 2026 02:16:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
Message-ID: <aajnZZI5yqL9CYeR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Matt Smiley <msmiley@gitlab.com>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
 <xmqqseaf5k5t.fsf@gitster.g>
 <20260305003745.GA4943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1A1xz/+VedeRRf6G"
Content-Disposition: inline
In-Reply-To: <20260305003745.GA4943@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1A1xz/+VedeRRf6G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-05 at 00:37:45, Jeff King wrote:
> I like that writev() can work as a drop-in replacement for write() at
> the lowest level. But given that our main use is likely to be pkt-lines,
> I do kind of wonder if we should just try to be more clever in forming
> our buffers. That makes all of the portability and compat questions go
> away (and gives the benefit to platforms that don't even have writev).

This does work and it is clever, but I think the writev is clearer and
more explicit.  In addition, this is literally the kind of use case that
it's designed for and the kernel will have a highly optimized
implementation handling it.  I could also see myself making use of
writev in my future work as well, although I don't have any concrete
code depending on it at the moment (but I could probably add it in the
interop code).

There is a Windows equivalent as well (according to the Rust
documentation[0]) which doesn't have to be added at this point, but
could in the future as a quality-of-implementation issue.  And almost
all Unix systems will support this, with the possible exception of
NonStop, since it's part of XSI and effectively everyone implements
those C functions.  (Also, writev was in 4.2BSD, released in 1983, so
you'd have to be really behind the times to not support it.)

[0] Rust defines the `std::io::IoSlice` type which is documented as
follows:

    A buffer type used with `Write::write_vectored`.

    It is semantically a wrapper around a `&[u8]`, but is guaranteed to
    be ABI compatible with the `iovec` type on Unix platforms and
    `WSABUF` on Windows.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1A1xz/+VedeRRf6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaajnZQAKCRB8DEliiIei
gRSyAQDDExmDp9QsmD/+3FZWUPdMx0vCCp63Z2o/0pQol52NAwEAwH0ZL/NxH/19
L3fzeDiSTJiphZ26Y8TFLRaqIREP4QQ=
=3wxm
-----END PGP SIGNATURE-----

--1A1xz/+VedeRRf6G--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA536DA0D
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459558; cv=none; b=fWZ0xDQ1zotMLOZ1CH0oVwhjLvYgUSNUC8iDft/jo+KP+6SUdbitStrL9wz1EAs6FhfnyPAlmuKwXTH+KSUipmpFCFxQyaBBAf3prCjQrur1CvzeGcvkPvDh29P2E4jc18DvDyxn/K1XuUsm0+OCyd8Mxom0U0kDWhJT2dAHv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459558; c=relaxed/simple;
	bh=0lLpYfV5r1TBVZoZ+NQynXW/kVuoc6XArHcB3cd1AF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeY8NJIs3k6qktGdct1R8ONjC6rbPptTbSJRjOf6nfK6zc4ic63kT9PfVRkHTZiBrBSl0HD9sJ4zffXBbWJmSqboWUV4el0WezAYRJuy3jGqiBPY8NzlK1Ui3jr1FnO0DmXAkbSgb0X0YfK//Xx87q6B2/9/2hOBnDKmf4Y672w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=slWTwPjg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="slWTwPjg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783459549;
	bh=0lLpYfV5r1TBVZoZ+NQynXW/kVuoc6XArHcB3cd1AF8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=slWTwPjg0+nkovbQmxADM6KivdbWlPToFItaxjA6fi0mNzLaIClISXiEfwV+3aTWM
	 0p0rR0f1N6EGtp/t3SL+uFMZ1pkPiEu205fUFhP6l+hrwUojoapzS6CbrsYu7Jkedl
	 24muJMXgXRPILyK2h4wTq6mi3r/A3qQD2LB0+bXl+mlDdKFni0yg8i2nUcuefS/1No
	 43ZXKEyPW5kGHYdBFK/RnXRt2OijXkNgRdvOCBIAmViThIC7yBY1pgHtS+suToI2Va
	 L91C4zUGsA3ZdVwn6teCJSvcZroWXskrMyPFPNCQicb8uKmJL+zNRDssVR7Bg3d5Iu
	 IowyFzhZVTcLdHIMeL5u3rvMpRybpRFD7dn1DniR8iIr9/vBurAVPZ5Ta93qShsKXK
	 nyLV3mRmnhk7H5NVGzfYwP/EOhh9pN8GNixJdEEvDxXh+/M56x3GsJC9dyCpUTBFkJ
	 AxQV6AA1W0xEa9E9+g51z0sadgQSdoa4e2WdfHTeY6bhGwy9OPD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D26E3200B0;
	Tue,  7 Jul 2026 21:25:49 +0000 (UTC)
Date: Tue, 7 Jul 2026 21:25:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
Message-ID: <ak1u25b2pmRAQIxD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050141.GA1288294@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3o5SBY7gc13+HZ/"
Content-Disposition: inline
In-Reply-To: <20260707050141.GA1288294@coredump.intra.peff.net>
User-Agent: Mutt/2.4.0 (2026-06-19)

--h3o5SBY7gc13+HZ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-07 at 05:01:41, Jeff King wrote:
> We'd like to add more logic to git_hash_init(), but many callers skip it
> and call algop->init_fn() directly. Let's make sure we're consistently
> using the wrapper by adding a coccinelle rule.
>=20
> Besides the coccinelle file itself, this is a purely mechanical
> conversion based on the patch it generates. There should be no bare
> init_fn() calls left (except for the one in the wrapper).

For context, the reason `git_hash_init` exists is that our Rust code
needs to initialize a hash context but it treats `const struct
git_hash_algo *` as `const void *` and doesn't have any access to the
contents of the structure.  We could fix this with `cbindgen` and
`bindgen`, but haven't done so yet.

So that's why everybody has been using `init_fn` instead of
`git_hash_init`.  Anyway, I have no objections to making this the
standard interface going forward.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--h3o5SBY7gc13+HZ/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpNbtsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0tAvk9Ox2ijg3q/Enb+vKEBlEmdovWiFr14tK6dJGkS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALiLAP9XBbCoe7bV7up9fZzZ0s6p+BDG
QhYazrzvnbylJlngWgD/Ye0GJytAFU7V1Arg17d6DBLZZpR7CXHxbtUTnMg36QU=
=3aHb
-----END PGP SIGNATURE-----

--h3o5SBY7gc13+HZ/--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B84266571
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404502; cv=none; b=VAw1fumDAYAWZA56cjNtSnIX71mwzDvoMyoHY7OaQFP4GuImRaSKSHpawCJgN/bHFabOtRj3uIcTKbuhkLMkG3M/kPG1SFjEwmwI7Y5GTWQhuN1jMNVizv/hEvL0xP6iGRsTwt6ph9ReLsrd0YtURAQzJKac5jDIuZ7jzm+wJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404502; c=relaxed/simple;
	bh=+t1fAlq2xamD1MqazW5rvBgriukPvUyZdWQpTkEegw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTnvMAC46dLiyQggMbu/IcDGrp4qJwmQnmQYnHl//o4t+1Nr5bSk2iFIAgaod7VgiddfLmKUKBmF8W2i+rGjsDJSBe7cRvv3z/7cNvtd9aPiI3JvsNyOKRa5lFCBTCNsFkQm8GvN7ohemGzBz4ruMudRA1WZQzjVKrTIiq1WaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Q6qFyKzN; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Q6qFyKzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404499;
	bh=+t1fAlq2xamD1MqazW5rvBgriukPvUyZdWQpTkEegw4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Q6qFyKzNOsUZ+86Cnig6SJaPlsDBKWHUiMgsR086jc5jkAMQJOBZ55oKnI6JswEeH
	 6WEbGeiezpPQQw9rAxhZ1lvBjsiV0M9QufMn9eflEbLhVY6XvmUbSfWJdwU13YRRTJ
	 BBQ9W3gbnubwhAA47uwpp8k7L+trABKZn/5U7ZsaP+/q6M0gqCcgtddFaFaaxlWLTr
	 wjrMmKgZbu6N/WULsDp+EaBAp55u7y0181NsultMl4MlSilMHrtkDllwFT7S1RjvYT
	 3tvy8RGNWrPNQh9nK3WpK7nm2y6dOT1hZBcq3ZTYKSN9p47FlE7/l/H6Xdw+07lCFV
	 skNrO6y5QLD0PRA/35OatdsAn5pD3T6SsKaY5lwkcWjIKkfyl9NR18lrbBu6yPIq6Y
	 /P4FV8xZzouP6yvEi7CeQfd1JVyTa5rIrZ/4wxgeFojeVrUzIoMm1/y13LlqwJpvK8
	 Z/ES1VNLm5hUUG7ElTusib1X7F2M/IVoJRUxH20ycL79cxAh5rc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 09A6D2003B;
	Tue,  1 Jul 2025 21:14:59 +0000 (UTC)
Date: Tue, 1 Jul 2025 21:14:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] builtin: use default hash when outside a repository
Message-ID: <aGRP0WiG8ZRzgilp@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-4-sandals@crustytoothpaste.net>
 <aGPIBa-1xjqk8EEE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tz9qV7xoothIIU+E"
Content-Disposition: inline
In-Reply-To: <aGPIBa-1xjqk8EEE@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--tz9qV7xoothIIU+E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-01 at 11:35:33, Patrick Steinhardt wrote:
> On Fri, Jun 20, 2025 at 01:19:35AM +0000, brian m. carlson wrote:
> > We have some commands that can operate inside or outside a repository.
> > If we're operating outside a repository, we clearly cannot use the
> > repository's hash algorithm as a default since it doesn't exist, so
> > instead, let's pick the default instead of specifically SHA-1.  Right
> > now this results in no functional change since the default is SHA-1, but
> > that may change in the future.
>=20
> With the preceding commit in mind that introduced GIT_HASH_ORIGINAL you
> could also argue that those callsites should be converted to use that
> define instead. We always used to treat them as SHA1 repositories, and
> we have no better way of telling otherwise, so we use the historical
> value of SHA1 so that scripts aren't dependent on how exactly Git was
> built.

I don't think I want to do that.  A lot of the functionality people use
outside of repositories, such as index-pack and ls-remote, actually
operates on repository objects and so it makes sense to use the default.

For instance, it will be a major inconvenience to still have to specify
a custom object format three to five years after the switchover.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--tz9qV7xoothIIU+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGRP0QAKCRB8DEliiIei
gU6LAP4v7G+VPVKfdDOhS5LsepzRwToMcQt29q0IQ7fBYFWVsgEArU4UMRjTyYFp
atO0AZv/n0nvka50Atc/PJgBxDW1YQU=
=U/7V
-----END PGP SIGNATURE-----

--tz9qV7xoothIIU+E--

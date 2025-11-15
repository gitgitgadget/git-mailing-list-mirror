Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9821D3E2
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763237216; cv=none; b=Oo47H5ecy/HUkh5pipA7RS7xWkDz1Rb+i+Bgy4fh6da4PylPt27xSSqJxjj6QcPevnchhEtSBjtnyfl5i0Dcs+2xKlRIZPbht+CtkSVIvGdoBIlrXFjiKvGUVdq3j26EtmHrCPvMOdbbq/eu3MPIk+nJl7heqhYJipaWhV3wd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763237216; c=relaxed/simple;
	bh=wlWnN5DxINZ3QgblmG6OVR5Vd+Au+5BzXPnjuzCmKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwUqE707gfQ9lIgSJGgDpMaYlmFxr8nw1Nm8jVC0gA1ziWK9xRto94DxszoBXA4JqPBLX4CsJlqQ0uF3xjiP8D4sLF/r/ez1tSOocuRY3Le5mo+SrinhgHigIao5iVRqGG8aVr43szjUeTMppdKNXO2D2zBASH/Qcc4InBK7Eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hYUHQrfe; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hYUHQrfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763237212;
	bh=wlWnN5DxINZ3QgblmG6OVR5Vd+Au+5BzXPnjuzCmKWY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hYUHQrfep9+r1jiAnA/J19XqLPT9LzUrb8WWlxT7UwLx2BzOz0uw1i7LcYK4qlHAD
	 vaOolW5FlmusrvmVGhyhcazQyRlB8rGGW8QpZfzDG74heLARPCTNWxDSsHkf92CKtF
	 vA6oBbe6YvDVATVxE+PpAhm9+Ao5kEqDDZlCiJGMkFIkKjv+2qep+qQaFHkNR8LImn
	 FghhTWfDPN9/FCDj/NS9Ey6+jGO+N/5RS7fna06l7cQmKxSjdAkiwg0AhsybBMqJmv
	 sGTbjzdZCNPzR6ny6wUOw4FhPWtjBHQzHNW+j4t+9evJ/lpLcxhpKH/pz6R8f8T7DP
	 EcEFJB/aTKFCzVwJ7O7LVoxfsYJO+J9weYdvXTkm0b6NYpAOwKX3G4qNGuTp0f4zva
	 ScjdTmNbfyd66fvFLhQmCsp+cI3gPW2KwfowHClfD0iusSXzA/ne/DUNBQXq23lPPP
	 OJMbBTUs4rzfaR3v0ne5Nd2IzWPhNtUE6zQGRVfJ1S6rr/L4sv/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d905:f83:f129:9863])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F1DF20065;
	Sat, 15 Nov 2025 20:06:52 +0000 (UTC)
Date: Sat, 15 Nov 2025 20:06:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Martin Wilck <mwilck@suse.com>, Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH v2 2/2] read-cache: drop submodule check from
 add_to_cache()
Message-ID: <aRjdWunjdMHxpS6Z@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
References: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
 <20251115005818.2271557-1-sandals@crustytoothpaste.net>
 <20251115005818.2271557-2-sandals@crustytoothpaste.net>
 <xmqqseefdq76.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0B3ublUOUmyhzvWQ"
Content-Disposition: inline
In-Reply-To: <xmqqseefdq76.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0B3ublUOUmyhzvWQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-15 at 19:57:17, Junio C Hamano wrote:
> A tangent.
>=20
> You can (!) place your own sign-off after Peff's, as you would want
> to certify
>=20
> c. The contribution was provided directly to me by some other
>    person who certified (a), (b) or (c) and I have not modified
>    it.
>=20
> of the DCO, but it seems that it is optional (which I did not know
> about---the explanation in SubmittingPatches stops at "Indeed you
> are encouraged to do so" without making it a requirement).

Yes, I should have done so; my apologies.  Please feel free to add it:

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

If you need, I can send a v3 with that fixed.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0B3ublUOUmyhzvWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRjdWgAKCRB8DEliiIei
gTRhAP4/YMAth2RFWcex5oL5z6lgj4vdrOa26VheLezlob2zngEAwmo3q72wCMWU
dbaKWfVCaNakdxKd6OuTxl9V0kz5cQ4=
=KFBv
-----END PGP SIGNATURE-----

--0B3ublUOUmyhzvWQ--

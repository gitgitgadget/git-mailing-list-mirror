Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FD5B683
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536073; cv=none; b=P1a+Az5JC8FiKYnWaysCY/gDAHIyl3S9F2OsEhcmP7ijMus2heaemp+NrkAbBR2W5mssH9BxZzIIP65tfQNn2Hrf7kwUKiJObP15lqbtAClFGeNkpX0qL2/Mr2f6gjtk6Ur1kxzSqGU9LujejHt7hWqrfjGpKWzGgMCooBm/jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536073; c=relaxed/simple;
	bh=Zm/16QsnqEEcxCYEmf4dhW2ZMzs7psZ9+OF2UhlThKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNfq59uY4BsXRFL5xFoes29FsvCzmNgRCFv5WKb7bZZpPDTXww9vCWBcmJhvjCvrLgEDeOYyTDXE6ej3fcrvMEeluC/QQQr4u/UzXDDnzKq2n/1TACQmAZ24RwdwS7GmfGgphZjiIEQFPV4DPBpyVA1U+nFAInk7G1rgwCQw4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UCAbkVPf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UCAbkVPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1717536069;
	bh=Zm/16QsnqEEcxCYEmf4dhW2ZMzs7psZ9+OF2UhlThKA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UCAbkVPfF9au+RZ+opJ5OT1EOOdbuZPRH9ykNj6mQV42op+TEvt5YbuKc+ohecppQ
	 MmM+HGVKCeQtaBzHrUaL6iw9d47L/yLvmjgURMrxg0GzFcJFb6PBfcz22XNIJ1AgF9
	 pj9BOgeeOYW9n/6EsSyMmjHP9pBJ2cCbItlvfK5Utn2pj/RUVLgd0eAvG25VAG9/kn
	 fGmeIfr8uisj2LzBk6rHMoJ3M8UPOPq6a7R8Z+YOG4hql0E2oP7MX8FcKUya4TyP2z
	 5reUleqUrE3gA3i9ga2GV4B0f7Iu19KQkOO2m4l7zVsNl6LQNEpv+J8R9sbmX4CRu1
	 D5wPZBt74axyvAXqTclzSOggrnyqbLdZx/BL59I8TnPPG7eiLt4K9WhLzLNPuJa9ST
	 pKM+6H62c6zjdM9MPqLXbQg6OlchP9qSaCEUODkWtiUREn+6gDd2b8lkw02ua9VHP2
	 AtaWXUQGs87cCTDltci0ixLGmQkGf6jmdwRbO1YmOX0eqDsnh5Z
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B7CFD2638E;
	Tue,  4 Jun 2024 21:21:09 +0000 (UTC)
Date: Tue, 4 Jun 2024 21:21:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
Message-ID: <Zl-FQ3SwNKM_4x6Q@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JMqPCGXjpJM34gCh"
Content-Disposition: inline
In-Reply-To: <20240604192929.3252626-1-aplattner@nvidia.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--JMqPCGXjpJM34gCh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-04 at 19:29:28, Aaron Plattner wrote:
> When a struct credential expires, credential_fill() clears c->password
> so that clients don't try to use it later. However, a struct cred that
> uses an alternate authtype won't have a password, but might have a
> credential stored in c->credential.
>=20
> This is a problem, for example, when an OAuth2 bearer token is used. In
> the system I'm using, the OAuth2 configuration generates and caches a
> bearer token that is valid for an hour. After the token expires, git
> needs to call back into the credential helper to use a stored refresh
> token to get a new bearer token. But if c->credential is still non-NULL,
> git will instead try to use the expired token and fail with an error:
>=20
>  fatal: Authentication failed for 'https://<oauth2-enabled-server>/reposi=
tory'
>=20
> And on the server:
>=20
>  [auth_openidc:error] [client <ip>:34012] oidc_proto_validate_exp: "exp" =
validation failure (1717522989): JWT expired 224 seconds ago
>=20
> Fix this by clearing both c->password and c->credential for an expired
> struct credential. While we're at it, use credential_clear_secrets()
> wherever both c->password and c->credential are being cleared, and use
> the full credential_clear() in credential_reject() after the credential
> has been erased from all of the helpers.

I think this is fine.  I'm assuming that the credential (and other
appurtenant information, such as the state[] values) are still passed to
the erase call, and if so, I don't see a problem.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--JMqPCGXjpJM34gCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZl+FQgAKCRB8DEliiIei
gebOAP4sPk/T5v8LcKKLP7/qrM1nfvMuhmwpFTSqHXL1JrYSxAEAjYcF9F6HQWgp
5db8+j8lmnGj1Zbyvrb6pePhw7eqEw0=
=y2Tg
-----END PGP SIGNATURE-----

--JMqPCGXjpJM34gCh--

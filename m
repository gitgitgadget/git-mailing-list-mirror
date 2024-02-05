Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7648CCC
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171497; cv=none; b=IAen8QYpui5QvhMkOsHgikSv3aavnmhm++dFim+1yfvOY4bdNnjdDnpijKPkQ/BqjO8BetixqePAz7FuyLLRFhIKm1QPukr3kLT8KjALkXpu0HYWLAYEDzvKkuJDy7lek0O5c7c4vOtZWU1FVupTsofSZu3HHZzczJjqG/9u2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171497; c=relaxed/simple;
	bh=yFV3aTdMWbISWS/zemxrrVbYFOajAeUHopDm512MMSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVCJZKJuN2W+lNDEEswFZbo7Gl+pOeCh2/dKdq90HtnQD9hckmCsdShDrJ8GuH8r/n6EBB2kyRd2knFXgwYGn5GhuMxDaMlf4N4CqkuyWdPN2Zrh9ZKM5fI/Q00pfTM552erR8PV5JSjaAf9qJk2EXFG7sWaj+KUE9d83UYQ2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hlkA1wec; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hlkA1wec"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 97E1F5A455;
	Mon,  5 Feb 2024 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707171493;
	bh=yFV3aTdMWbISWS/zemxrrVbYFOajAeUHopDm512MMSg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hlkA1wecYDHUKs9optLHjsvkUC6C3QJgswbJgXx4NOV7A9S7CsD61closL5TjcyIN
	 KFVpTe0t9opIsBi5w8hMuWL94M8UUfg31FbYdshvD9oJtoqzHFcW79mi/RjrTKRZBA
	 gT/+RrQHQ1skjvyswj8nYUQg5It+94k2GqlNoksEHNMbaqe+KhLyLB7GgLE+2mkTb9
	 CTdgeariN7CjW8B7augOauZjrCZzA/w+Z0iObYlzRGmPeABPxBvZEWFhP8KVavqCTD
	 C2DjMAkCUtPvg/ySob7YcU96sy/5YQRDApFPjbqGgopka0+mgqHn4du7hcvBZIF54t
	 BPGwlgyOsgY/B+TWe18sNKNfOKEVnoSOuevugRNMYnbBXt7tsUW1BINaHzLC3P8pTK
	 624nEQpqnqR9peWVQYv+97O1G5/rxPbmzdQZH+WJeUrfP143lD9e26l5DkTLo/rpd2
	 hbY4TsolQoKlPuIGvCxYye9bMLasLX60nTX5s3Nz0tPyV4japVW
Date: Mon, 5 Feb 2024 22:18:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Quentin Bouget <ypsah@devyard.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
Message-ID: <ZcFeoyFXqLhMXVRh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Quentin Bouget <ypsah@devyard.org>, git@vger.kernel.org
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-3-ypsah@devyard.org>
 <ZcARb4YNCD4NLJku@tapette.crustytoothpaste.net>
 <CYWT6JWQCTFG.106OCJTV3NQDU@devyard.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rKtwmGkDohAlEXS4"
Content-Disposition: inline
In-Reply-To: <CYWT6JWQCTFG.106OCJTV3NQDU@devyard.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--rKtwmGkDohAlEXS4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-05 at 03:01:17, Quentin Bouget wrote:
> Good point, I had not considered the security implications.
>=20
> I can see libcurl only reuses credentials after a redirect if the
> hostname has not changed: [1]
>=20
> 	By default, libcurl only sends credentials and Authentication
> 	headers to the initial hostname as given in the original URL, to
> 	avoid leaking username + password to other sites.=20
>=20
> Does it sound OK if I use the credentials provided by the redirect when
> there are any (out of consistency with the current implementation), and
> only allow reusing the current credentials when the redirect and the
> original URLs share the same hostname?

I don't think we can actually rely on that functionality because
`credential.usehttppath` could actually have been set, in which case
we'd need a different credential.  For example, I know some forges issue
certain types of tokens that are tied to a specific URL and wouldn't
validate for a redirect, even if it were actually the same repo.

If there are credentials in the URL provided by the redirect, I think it
should be safe to use them; otherwise, we'd need to rely on filling them
with the credential protocol.

> Apologies, I feel like I may have given the impression I wanted to
> configure credentials in git's configuration files, which is not the
> case.
>=20
> My use case is to `git push` a tag from a CI/CD pipeline to trigger a
> release, similar to how I do it here. [3]
>=20
> Or is this the kind of use case you are trying to discourage?

We're trying to discourage all use of credentials in the URL at the
command line and in remote names/configuration files.  If you want to
pass in credentials from the environment, the Git FAQ explains how to do
that[0], and that technique can be used in such a situation.

[0] https://git-scm.com/docs/gitfaq#http-credentials-environment
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rKtwmGkDohAlEXS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcFeowAKCRB8DEliiIei
ga0aAQCy0HJSU22HZ9iR1v0Zj6N9Ht6m81b50oIsV3St3P+YLQEAj5sRyZPbpV34
H2ijj8qHrx8VdnAUrxVq3FBtnS3KvwY=
=1+Ii
-----END PGP SIGNATURE-----

--rKtwmGkDohAlEXS4--

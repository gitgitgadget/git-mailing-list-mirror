Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42799BA26
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707086203; cv=none; b=f72Ssz5ynZw+MOPBigLZtnXVIKrW+/7vz5PzBFK8F4UwZgihNmZyks1P6Kjh5M5dPUO5tfdCIJmOxEKOKbCBRySvqxy+0QMeb/q5HrIgmU8pEL7Ao525Z0q2zNUnyf31LiFX29TKQJScG7vzz31CMkBOpI2Bru8QMnbeA5dvE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707086203; c=relaxed/simple;
	bh=RMWDRGJw2IVGDCGL9Gx80Fgpb2T53uZbXHHRdQn9h4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BceMU3YFuGkh1YfvmcqVyTYZmeGC7DYbEG0ROqiyd7ZMHOUs//+SdzntdU+3Th72YDLQ8upFl4P6GJdPayvCNFnDwUzzuQu/oOkwxN7wUgKdO5GEyaS1ZlXS8hDsCDt79FbQ5xn61d4/3VHK8BPivH/nOB7tYWETAvajEMY3NsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wE6r+CQl; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wE6r+CQl"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B7ACD5A453;
	Sun,  4 Feb 2024 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707086193;
	bh=RMWDRGJw2IVGDCGL9Gx80Fgpb2T53uZbXHHRdQn9h4E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wE6r+CQlEKCKLXLtZQ9GBUnc/p0g5bLk2zqz5mnfvK0F5JQi0fW9aghQD1Xl76Oz/
	 UyggSF3Xg9ordIQ+if8iCQNz7JbyLQI2OrQYMjt9LLvBLJPgV+vhsCHvOtKUeUl9Tv
	 4KaBHpcOz8Atx9WoxrYXdZVVAiL//qujkNuS2ckepdKAQxVgDLeekB3HJMU6+YyE+9
	 RK99nUxuIZI0bUAU8772lpHTk7U74GDkBEYuOb3Iq090Ij5sQteRU41fKPiiMChF5H
	 m+rKCUjuTFJrFVRuaj9367QL6JGTWYtZj6VOK+YJCbQz/0vYeTpKIwzjwYdIVhiwdY
	 R9ZQDVwlAm8yarwEq0ii/YY56v1iILA8XOSnKfn7nnTmzCfHMhwVfC1BQHieXf6tHt
	 axnbp+J+yrNUOaK2sPP8edilYRcg+XT8LSrxV0mqhG2GcTPmKomohRdQZZN9YU+VPT
	 VW7nWjrRgE3P9/gagyurd7WbNYG7kn91v4zGmiRSA7qAbGuQ4wL
Date: Sun, 4 Feb 2024 22:36:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Quentin Bouget <ypsah@devyard.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
Message-ID: <ZcARb4YNCD4NLJku@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Quentin Bouget <ypsah@devyard.org>, git@vger.kernel.org
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-3-ypsah@devyard.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CNZ+U1Ixs5rSYBsn"
Content-Disposition: inline
In-Reply-To: <20240204185427.39664-3-ypsah@devyard.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--CNZ+U1Ixs5rSYBsn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-04 at 18:54:27, Quentin Bouget wrote:
> During a re-authentication (second attempt at authenticating with a
> remote, e.g. after a failed GSSAPI attempt), git allows the remote to
> provide credential overrides in the redirect URL and unconditionnaly
> drops the current HTTP credentials in favors of those, even when there
> aren't any.
>=20
> This commit makes it so HTTP credentials are only overridden when the
> redirect URL actually contains credentials itself.

I don't think your proposed change is safe.  Credentials are supposed to
be tied to a certain site and may even be tied to a specific repository,
and if there's a redirect, then we need to re-fetch credentials or we
could leak credentials to the wrong site by reusing them.  Your change
would therefore introduce a security vulnerability.

I should also point out that in general we are trying to make it less
easy and less convenient for people to use credentials in the URL
because that always necessitates insecure storage.  There have in fact
been proposals to remove that functionality entirely.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--CNZ+U1Ixs5rSYBsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcARbgAKCRB8DEliiIei
gQ1rAP43pyt8kxfMy2499C2lYGgsgRJ4N/ZO/RpiHRLZIp6PMQEAy1OSNYE6ytuU
Lm7c9n2RAgh28dPbOARUM1BjNuJyrQw=
=y1lg
-----END PGP SIGNATURE-----

--CNZ+U1Ixs5rSYBsn--

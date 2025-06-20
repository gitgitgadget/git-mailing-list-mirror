Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280623185D
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452670; cv=none; b=AsRgsgBquVowIoYxV7pgN8SF5wSSPWlZA2HAhri+XrYM9DfXCl/Uf8lmK+qipACUs6Hi+LErcK+R/2uWgHeok36GHodyf+8iwlzTGZiZcauCf6mYyFZSLJL5T3BivmdOff/WObpF/QM0t79LJ4wetOLYzbjd0Exb3KZeu4Jp508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452670; c=relaxed/simple;
	bh=4v75Li/8ej5se7LR6u4Wb36Ulcr/obNRMoK4ZQrxM60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf0xamvPDEAjxQFGsvU/2+0K0NgnNxWZp0MQjd8iduCzk6iYMhxTcWF5QuZKYPFdFKFoPJziC+ZL8gGnZIvftLtvvQKZfs8IxRWOC6t3DtPawSGxFgauLTw7RfX5grDEPweNzncoJwDo2vUtrf3ZWXr6b/o1nbTg8SJbfQz/g3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XSI0MBBA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XSI0MBBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750452667;
	bh=4v75Li/8ej5se7LR6u4Wb36Ulcr/obNRMoK4ZQrxM60=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XSI0MBBAhySbWWwr5RaNhq1CnB32awIXEta102BRRSZG88d/qKVHUUBXsUw2u6xF3
	 9/v4FpyFxn9TiiRE9h+UYwmXmbreu7Jq0PGylWW7Z9QB0RepL1/u6KbdH7ioXinL/i
	 oAoTvNu14nYhMm0nbsVAPbNJhfRo3Z1kI+8oUFUE0HZWnOwmynTVXZzS327nlXVocF
	 gBSQAy3dJp0LXSDEj3fus3Ws3Oq8bstDGsJiJXuv6Kl/0avx0OKX01++UjLR0yteZd
	 vafft9mDJmHLBD/cEjBAIVLjMe479YiOvDxXgMMlnFO6Dowcsme8fq74PXNbhIe6KK
	 SSVrq5wRKvQT1uE+ZEnHXP3w83OvqIAN7Hwz/L9fm5J2QQDS/URtNGVmyE5aqGrvjf
	 M9MCTwS+2WDc1e7JDyM/XHEphmYsPLt/A4PzdFDOlv+HsDJE2H063aqWMCBwMSN6fG
	 wh9ZqKogq98WSbZNwH5zScZxM/DJh/WrfGJwY0+aTSxccxZb4Gx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B812820069;
	Fri, 20 Jun 2025 20:51:07 +0000 (UTC)
Date: Fri, 20 Jun 2025 20:51:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/10] Use original hash for legacy formats
Message-ID: <aFXJunWKq28BeX-a@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-5-sandals@crustytoothpaste.net>
 <xmqqcyay7ale.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMkiFH+9gTdjVeIE"
Content-Disposition: inline
In-Reply-To: <xmqqcyay7ale.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lMkiFH+9gTdjVeIE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 14:26:37, Junio C Hamano wrote:
> If we call use a name with SHA-1 in it (e.g., GIT_HASH_MUST_BE_SHA1)
> from the beginning, perhaps we do not have to rename _ORIGINAL later?

We could call it GIT_HASH_LEGACY_SHA1 if you prefer that.  I originally
considered something like GIT_HASH_GOOD_OLD_REV (GOOD_OLD_REV comes from
ext2's much more rigid and less extendable v0 rather than its newer v1
format), but I felt like that would be too esoteric and not document
things well enough.

I'm also open to other ideas for naming if someone has them.  After all,
naming things is one of the hard problems in computer science.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lMkiFH+9gTdjVeIE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFXJugAKCRB8DEliiIei
gWx6AP9IfU6AMcKschSMHaTspBeMS+T2+YQ1C4FB8Ed51TqIDwD/S+A+GVyujnlL
G1GvsYszKTHPTtdsiizB/zjfp21THQA=
=5vOc
-----END PGP SIGNATURE-----

--lMkiFH+9gTdjVeIE--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2C13C9D9
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081239; cv=none; b=V3AMrtIx8gkQTpdwuxBUPGf1aAIXbv1Rm4Kz0/hZPBFLY6L6J2iFgiRtW3xP7vdEpfp05kad8MZA5WjY35xnbTGYijENCbEhymadN2zDlkzsM0nVhXBM5yWsrk5whOaE3uAYiAzi5pJmOUjuzoYRxpi8JYLrpQ5bIWJ3jZoptZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081239; c=relaxed/simple;
	bh=/3iTy7+FZw781R7Nl2itJezRVJf5XfP63R2/UZt0oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPxm5ZwsmlABrwmn2yZg9ewTdmG0L8ocnCTgQkqaQHEJR4XHDfgT53TySOAs5Tc4bousca8HzK9dpx8U2Fhj5XE2JDenKr2qJvynBZycb2h6rxvmFsEYTC1eya+lL+pBcNZMRruHqejn3uUXo5qgU5n6fHf+1TvQnQdzkoTFj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nCtIb5Pv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nCtIb5Pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721081235;
	bh=/3iTy7+FZw781R7Nl2itJezRVJf5XfP63R2/UZt0oz8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nCtIb5PvsVY0NyNF1ZuxEpJI4cU2mbt21zLIPqpL3nwqnKrxZdDdNmvTioLBkJNlx
	 3ylG3C1QNlXMSalKVPjGLhPQS33gZMzLBoW1YsrgBGAIJo2hahWT01nT8SBTW+TI7h
	 DqYBd8bwuiphQwwknu2tBBm4JiZNkLxgbd+43kETn9PGOeW3D+GOlED6mhsve1xrBt
	 2rYjVk7wL26F+R+KxRUBk2Vf/VBf66Wxv2lPWc7nNPiGlE9TjGmbVTE3dOWgtY/Tqo
	 vyVPYIrQIeiTnuU8g1URphvk7bGe1HT/1j8XSN7tlLD12UgIk3OW6f90vj7qecxRK6
	 v2cvt9XKGMEP2Z/j++IjtQ8chlxJMYftxP1ZE4gzWyKDB6X0p/TjFxRZHD9o7A6Ouc
	 efbPIK6vKHrQlVvJTFmIH9Ki7tIqCERZnOoFllDOnArtC97fqG0SD2qyivsch828aB
	 G8VsSAVALnhCJm/nr4Bx4jgSHDHHYqXyxvxAEPIuMfO61i0SaQ+
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 73A2320991;
	Mon, 15 Jul 2024 22:07:15 +0000 (UTC)
Date: Mon, 15 Jul 2024 22:07:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] show-index: fix uninitialized hash function
Message-ID: <ZpWdkq2GBqIBI8Lr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <xmqqbk32oc7g.fsf@gitster.g>
 <20240715102344.182388-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9DAiU6RhaoeO25W"
Content-Disposition: inline
In-Reply-To: <20240715102344.182388-1-abhijeet.nkt@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--N9DAiU6RhaoeO25W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-15 at 10:23:43, Abhijeet Sonar wrote:
> diff --git a/t/t8101-show-index-hash-function.sh b/t/t8101-show-index-has=
h-function.sh
> new file mode 100755
> index 0000000000..2e9308f73c
> --- /dev/null
> +++ b/t/t8101-show-index-hash-function.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +
> +test_description=3D'git show-index'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'show-index: should not fail outside a repository' '
> +    git init --object-format=3Dsha1 && (
> +        echo "" | git hash-object -w --stdin | git pack-objects test &&
> +        rm -rf .git &&
> +        cat test-*.idx | git show-index
> +    )
> +'

I don't think this change is going to work.  If you run with
`GIT_TEST_DEFAULT_HASH=3Dsha256`, as I do, you see this error:

  fatal: attempt to reinitialize repository with different hash

That's because the repository is already initialized as SHA-256 when you
do `git init`.

The reason that the `--object-format` option was added was to make this
configuration work outside a repository.  It would probably be better to
require the user to specify that option if we're outside of a repository
rather than just try to guess.  We want to have _fewer_ dependencies on
SHA-1 as the implicit algorithm, not more.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--N9DAiU6RhaoeO25W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZpWdkgAKCRB8DEliiIei
gTUjAQC80j8Eg2eb/3ScnusXNGj6yUJSZQo8dUVjV/bzJsK9HgEAjWIQtMt+2bi8
DBg3i4fCbMp2iAHcnSXQttFCGMneYgU=
=VAWz
-----END PGP SIGNATURE-----

--N9DAiU6RhaoeO25W--

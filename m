Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA21A9B24
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836902; cv=none; b=SciJyyQ6A7BMqaouo7ILybp3uFwhDoQlp1C5PusVRS4wp1joP5XokHRoRL9y1Oj8RfLDLg/+o0C1KCeI5v5vOTHfdEqtd5D0U9T29jo0G2yqyrl+8yJc+Lz8U+9JDqw1NsvHLVB3lXLXzd7ylT5yZP3jtBAFBNCZBl6lIoeWmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836902; c=relaxed/simple;
	bh=unuhPo6QSGquoQ8YHJsG9uBtx2uJOUbjwaT8ANoUOuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ouX6Dr67d+r5uYImN6NzEzNEhYbbM3gwDmkwroCdbqEc6/1ezqApjxKOq6NO1J/ogPaG9Mn/QLVgEm6EDjuoCz7Unn6BBOLUUaKCEj8ID/rXxs6QspTrPgM6W3ITg1XKim80vZjdAwENJbl7V0egfoAwWpy37aE7IkrAdjKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=h4wmLdir; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h4wmLdir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751836891;
	bh=unuhPo6QSGquoQ8YHJsG9uBtx2uJOUbjwaT8ANoUOuw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=h4wmLdirMIm8uGlVYTZO9kraZMbTvKn3UgToADT/Pv4Kt3YdJJ9+r+J9vqhYmDRHu
	 nryzk8f8vSHCX6Ibj0wPTKlwVmyF7Xyqzr4srX/oARDii67h4fo7nRopAUVkZLdWxd
	 soZUTpL/HMIWfi31r1qOA0JE8BWIFlawxJdHy4fiWn4axsIgpK3RJw6MxleU3Yv5y6
	 RI5m0xkwV3ZYhLJRTW26bKKnz/nkhSjtseom9Sz2AvHtpFrgXNSXZ5D6hUSXcb5SJZ
	 IKUWnAes97kTz1gUh9upDVjaqCZLFUmj5/B9Qg+wvce9BDYvWDicx9l7+BjXa8fp+i
	 bQiCoETwPZK41AxPU5aypccKR8FpgkwVZSZDxoEfI/csQDT3WEz5aRUls4KF5b21FY
	 Mewe9nAjJuaiaBWDRj6PgyXINi97ulXwQa2LIP+/nhQ0x/l7UY7coSxvh/D3LzW/o/
	 JlOmgt740fwkVZykI3VZj8Zfx486DDcQH9zJ3SUTfoGtLlRuLXv
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:63d3:f0a0:2fc3:f348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 70DCE20075;
	Sun,  6 Jul 2025 21:21:31 +0000 (UTC)
Date: Sun, 6 Jul 2025 21:21:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: redoste <redoste@redoste.xyz>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Fabian Stelzer <fs@gigacodes.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <aGro2h1VsSEYYCmp@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	redoste <redoste@redoste.xyz>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Fabian Stelzer <fs@gigacodes.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250706173450.12995-1-redoste@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g0Tfs44nOl4H+dqm"
Content-Disposition: inline
In-Reply-To: <20250706173450.12995-1-redoste@redoste.xyz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--g0Tfs44nOl4H+dqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-06 at 17:34:49, redoste wrote:
> Detaching the filename string from the tempfile structure used to cause
> delete_tempfile() to fail and the temporary file was not cleaned up.
>=20
> While it's possible to get rid of the allocation and copy from
> xstrdup(), it keeps the code symetric with the other branch since
> interpolate_path() also allocates and ssh_signing_key_file is freed
> in both cases.
>=20
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: redoste <redoste@redoste.xyz>

Yup, this looks good to me.  Thanks so much for the patch; I always
appreciate keeping the temporary directory tidy.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--g0Tfs44nOl4H+dqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGro2QAKCRB8DEliiIei
gdcaAP0a5LUGm1ToOkIV6K+HHMX0o05PerzaMBzr9dLbZnHaUAEAxi0IlI49V4++
0RK3n2YS+u4tSGYjtEb0l1vWhVH5eQQ=
=ODiX
-----END PGP SIGNATURE-----

--g0Tfs44nOl4H+dqm--

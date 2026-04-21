Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9234A799
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809613; cv=none; b=gDJbQT0b/4qkFx1PXSZ09thI+TAycAO85PUxO4inJHC8Lg7R6uTN/k0YT6HcTRUKZ2unSyF5va82EQ15eUUHcSBprLLo19vYjGNoNm5WSFZGDSnDiJHp4ksafvluRf7IfnlkcRN3hDk9GM15iPsTQlaFKtsvnJNQXRJ/jhI45Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809613; c=relaxed/simple;
	bh=DSTwp4gJEvnsYI9QYL1z2o+tlnAaIlyJkns3JnzQQn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEMzMEKOaB/CKaNbjbqJILGWj5cCYy/xPOBZj3xWtA5vI0R3pofhI1IE5Gy447v9vsIRE7ZWPSylyjttdC4fhnTMkkfobc84ES/FBjE9cE7VuZoVb6FStG8wHFLyBjnzE9RHln2x+L5Nf7LZmNZfWk4ZgjUS/KhA/41IBLLnPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vtPG1Ubq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vtPG1Ubq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776809605;
	bh=DSTwp4gJEvnsYI9QYL1z2o+tlnAaIlyJkns3JnzQQn4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vtPG1UbqHNbESSMTf2jsLUYDYOwCsJ50nOR9ZP8qzZ3bMngmFykmuW5shCh9l0K0D
	 I3+SBhWVPcFB/f+W0D4N1F8Aii/xaaSLOfeJYh6HPAb0i1yIcOuD1xsZaZs5Rjty/+
	 Jap1YA0eXZd+wPcxESPkThfJX3nR7hdtv7VTEoZ2pltcRw5RtfiQeZtscNXfA+3ce4
	 lonNyHRsry0Wab9HqWV8EyUchu4ou23x75rKZWZwTPY7znf37YcUjAYogdZl6BRpsf
	 hwYbM1LFr4THDFHnz34qrX3ziM9WB83ir6C6keheKITSDvZLIE01OuQyOJsPyyM0Tl
	 J9RUXHu93lKMzDycg/7t8ha0yr5SbX1ojNjqq+bMQNJ4oU9BeJ8Vhi4zwZRhgdsIrW
	 xpp4N0Jxfrnz/UCrWUvI8eAKlnwpwbjc4ReqTVriATOHbtbcanHdWifxrEkIk/AdUR
	 ftkcrOgU8rR05wEQEKdaRdnRje1GollQHgWyAwSA/J/5X4SSmON
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5ad8:61c3:7428:ec68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 22F30200FF;
	Tue, 21 Apr 2026 22:13:25 +0000 (UTC)
Date: Tue, 21 Apr 2026 22:13:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kushal Das <kushal@sunet.se>
Cc: git@vger.kernel.org
Subject: Re: [BUG] v2.45+: git commit -S invalidates signature for non-UTF-8
 messages
Message-ID: <aef2g0j-ws4zZ2Zp@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kushal Das <kushal@sunet.se>, git@vger.kernel.org
References: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se>
 <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
 <c0df6dbd-47f9-4a2d-b68d-cb0c1e19ca5a@sunet.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvrlMylemSpu7cJl"
Content-Disposition: inline
In-Reply-To: <c0df6dbd-47f9-4a2d-b68d-cb0c1e19ca5a@sunet.se>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wvrlMylemSpu7cJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-21 at 07:39:11, Kushal Das wrote:
> I am also wondering in the test harness for git signing, if you want to
> include other tools than gnupg for testing.

The signing code is abstract at that point in the code, so it should
work identically with SSH or X.509 and I don't think a separate test is
necessary.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wvrlMylemSpu7cJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmnn9oMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4g/19FDgczVjZoewzdqWERzMz+UG/6qPEWJgSa5akbz
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOV7AP9overOSWX4Ghu/AyI2Ku7JlK8D
yWL6hhl+lanif/rhRAEA8+8ZKsWUW0KsD5oAfXyKV41uujos8KskyRfdlZjJog0=
=AN+c
-----END PGP SIGNATURE-----

--wvrlMylemSpu7cJl--

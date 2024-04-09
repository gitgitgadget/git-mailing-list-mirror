Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8D3236
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622921; cv=none; b=oJtr9sEKRhbzxMaZkDM8BU+fKigl0LcofQUcGFQ3ch4FngnGR2W3Qogf4jmuxy+VD0/ZoofT6FyPf+frBROsvupIi6cdvXnMVWCc0quokUREYU4Pq0nCeEU1ZuQnAXlsF5v2trRRBJb7DqBqEmgs+luhjp5IlFzhmIWyhLHlftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622921; c=relaxed/simple;
	bh=leasB8oLp/g/+djVbpdcPsSNY7nnmq7lphr88DS5CpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxWZJir/w5vAIWj9YhfxjFIsQesDJ6ah7NrwhCjHTWyvcwdBgI6WNUrPkqBA6jEB5ZrlNHWcto0t/rpLYEDp9xtDRfVbK/GhYf1LrYqjstbIYiQNw0oYdfSSPWH0bwuLRgJm6ytrTGdBDBNb73G6kjqTJmaTQsGpaQppHjBV3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uID+vlLm; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uID+vlLm"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1759A5D4D0;
	Tue,  9 Apr 2024 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712622911;
	bh=leasB8oLp/g/+djVbpdcPsSNY7nnmq7lphr88DS5CpY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uID+vlLm+1wMMfDeo8Clbc/iiU2fd0//eSnXfsuq+c+bF45Ir1O92eiTfNUYni3z7
	 ePp1ZcX5CQ8fzw8gXG81EsS+MyyJySlkPknpDcYkuHv9WFR3W8Sc2YDvLgHlmLq/t4
	 XoCZYHvLvyNWAk24JBjtBsYxdlT3m2QpcLRy1EhRi4h8IRr2I9V8Ypikf+9j2FLwdv
	 LA5ZsLx4/hIc0C8mpn/02r/V/T40kPbFILKoeWA/lRQKs1qkB8gLit/IXmJMkw9jqi
	 L+zOtq3BoWDOeWyodXU1ygdFYcCcrSpRlzL6FSqHhxwbGBDGN1h1mE/HEJP2kzPKzT
	 T70VnT3opzRLuvS0FjEM9s69/XTS4kRYK1a46p/MB2FOPbV2MvKOU74O0ce+4HSUNt
	 xMJlU4SLRrUCTHG+zj3PBb5w+VBfepyJxJKcR2zpmtyq/krFM8t8QR9c43H66AoP6A
	 KptwyHTfuZz+eDt2fIg5OBbO3bBu5sH1Ag41U4TyYGk9WHg/Qha
Date: Tue, 9 Apr 2024 00:35:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Calvin Wan' <calvinwan@google.com>,
	'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
Message-ID: <ZhSNPTiaPbfekOrJ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	'Calvin Wan' <calvinwan@google.com>,
	'Git Mailing List' <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
 <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
 <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net>
 <xmqqr0ff8rwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQPpYxtDSb8A0kqQ"
Content-Disposition: inline
In-Reply-To: <xmqqr0ff8rwo.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--EQPpYxtDSb8A0kqQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-08 at 21:29:27, Junio C Hamano wrote:
> I thought one of the yardstick to gauge the success of this
> "libification" effort, if not the purpose of this effort, is to
> allow Git to be its first client.
>=20
> I am not sure how it would supposed to work.  Unless you are giving
> parallel implementations of "main Git binaries", one with the native
> code and the other replaced the native code with thin wrappers
> around the library calls, that is.

I think the plan as proposed in the original file was to have an
internal and external library and to have the binaries use the internal
library.  However, perhaps I misunderstood the proposal, in which case
clarification on the part of the proposers would be helpful.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--EQPpYxtDSb8A0kqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhSNPAAKCRB8DEliiIei
gWM5AP9yGsPzM2cnRupyD1BKzeVJ0Ecv9Jpsor+hUxmOihR2ogD9Ho01k382y2Yq
B09WaCOg/PU4LVxu5qLsIiZaleI+GA0=
=+eoW
-----END PGP SIGNATURE-----

--EQPpYxtDSb8A0kqQ--

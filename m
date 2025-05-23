Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DD137E
	for <git@vger.kernel.org>; Fri, 23 May 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042725; cv=none; b=momReOaRJuP308z4ZXEnN+v9ZTYi/OBU514pt51bEn7SVWkLWMrILgsmlzSO3uwF8culpNj5HxyTyl8fSAJVI0LWBYhfbq+iRvx6rSGfIAHMrKR/Ks6gjxh9sXP+zn1Nzk9334pMWOk724jDxn8SSPqUWSdr+6aQgCbhRFmkZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042725; c=relaxed/simple;
	bh=FZbI7cEBKBj8O54LOKUSA+Pn7s83pq9aSz0sBAVH5wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNqZFb3LMG0Zpre98bNhky+SDjXyuXxWKIoypc9dgzFgVzxiWCFt01R0EACCAiZfhmTRt0ohQ+wnSFyUZRhxfSV3jzlRGcfp2NWTE2uTebPruQD3AxT9ta3b3wOdnTEUvzgPTkY/IccHeXnu6oHMlPDgIO0A2iXJCO93xyl/YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hFgDEQMU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hFgDEQMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748042722;
	bh=FZbI7cEBKBj8O54LOKUSA+Pn7s83pq9aSz0sBAVH5wQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hFgDEQMUUnFtK+HwzTspePzAx+K6GPXfF1ymrdm3ylTobE3IXH+Gqigj92MDjmEn3
	 +eVUDM1VC8V8PdOnMP++oKSYr6A3vZW75QUi3OMSyTVTowW1DAqOjXFZI3g2An8Or/
	 F/SPie/B2zw9PQlvMa3RNNF7W60q60r1ur/jDif6jdHmj21oZpEOLVj6uey/uZAQGY
	 StKFrykZoHt9ebkg9SJ01Ovy2BDBFZsMQSN/W/NO882gk5jRJeyuGwMCwzVd1Ygcyg
	 BMeaVs0WrTeDgBhY0TzNlzaeU7KC/VNDQr3t74f/8QQHFaJchZNaVnJ9DPqY6lFyTw
	 jAoE/+rT/dvyg3A99BTNt1lj5pq1ndFaRARCqgY4QS1iIjkvyN5YU3JxA9T2K3qEgR
	 UGM1N7sSG5MNep6VkKiVjRwDfm0dfXe70XtbbQYd1FvtsgDxFTNyV8H5sy1G0uw17G
	 XaNpvW5FhyNo4ScTmQOn9kj9bw0lTmsAHG8QTDOnexls9ONcV97
Received: from tapette.crustytoothpaste.net (syn-071-015-116-126.biz.spectrum.com [71.15.116.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9E6352010F;
	Fri, 23 May 2025 23:25:22 +0000 (UTC)
Date: Fri, 23 May 2025 23:25:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/5] builtin/stash: factor out revision parsing into a
 function
Message-ID: <aDED4MrweIc0N51h@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-5-sandals@crustytoothpaste.net>
 <xmqq1psg5qrb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FNBZhVDkQWlOoFhe"
Content-Disposition: inline
In-Reply-To: <xmqq1psg5qrb.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--FNBZhVDkQWlOoFhe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 20:34:16, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +	strbuf_init(&info->revision, 0);
> > +	if (parse_stash_revision(&info->revision, commit, 0)) {
> > +		return -1;
> >  	}
>=20
> It does not look like this series add more code inside this block in
> a later step, so let's lose the unnecessary {braces} around a single
> statement "return -1" here.

Sounds good.  I'll fix that in a v7.

> By the way, what is "pwodd" I saw in the e-mail header?

A typo for "pwood", which is my alias for Phillip Wood, who I intended
to CC.  A typo which I unfortunately didn't catch before sending out
patches (mostly because I was sitting in an airport lounge when I sent
them out instead of using my giant screens at home).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--FNBZhVDkQWlOoFhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgxA+AJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8uOzrNYcWmmQmtLaf4wK5mv8gdSMcRjJiLl+mWPiILL
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALLDAP0RHtGkSjoPnJGhfvCkd5gnoSaI
cynPaD3Vp53Ta+vFLQEA5M2KKd3QsnE4mKAxZZnFfUFIVWud+ZvnijchhX5/Jg0=
=eeUa
-----END PGP SIGNATURE-----

--FNBZhVDkQWlOoFhe--

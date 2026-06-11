Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131F36F8E3
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211987; cv=none; b=D/tyNcw4cpX4Bf/ufAkPLOQuCPIwkjPhifjBjnVHpSQcBA1H19znUCm+H2Fgp78y0lvrd5BBh4H7ovBdOnK1mLQ95d9cm02TzhoomohWTbOAGAiHJ8aJuF7txMuSPMIZa8AV8cAWQSM4gbHWHUwtnnWnXW3hPUL3RZfqpAm8tLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211987; c=relaxed/simple;
	bh=yxAERNl7VltwmeX5vEdbj18YnEU/bhKLuRcrXeJ7waI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCWgkZleyIyxp4BG+/PAz+bBkW7i4VQzJw7GLiFNlXPH7doV5VVKLD8XCCcgX1Si7fEpW4raPLTbXI/+Sinw57v32Z5bFHkcNQaxSzNLz4CeLFaJKMvDyoLxtuZJwldrGMSoIJPRL3V/gQceIQIl+rifmh99yot3zgqNRZqsx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=He5k4N3M; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="He5k4N3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1781211977;
	bh=yxAERNl7VltwmeX5vEdbj18YnEU/bhKLuRcrXeJ7waI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=He5k4N3Mkr5MWIuwlT2Y3sGHCGPV3DIjYduw8ZzsRPzOU0PH/u36o5NWy+1/IVJKN
	 I0+RKJ4KUm/LPSq317gf1gKfRvej+F0thdXF1ntWO7DCeP5o4gsA1plAt8nyYUWDzM
	 d48IfkeAXX3d+dY4rh5L0QsKuIHgPBIC7yfOkUkgQnhBm8h5CPkoLVK4px9YXQKBhu
	 tJAAxEHeyKexIm4ebq0+Ldv985TzXcfOciaXzWbMR5Ek7c12Vk1v8MEeCbRdfgtC+t
	 4n3nNqXaNYIUB4Jc/WYgswKSc6ELN4kL6qolEQcShbgb7YiGI1CkDStK9hOD1niGA6
	 U3XBUjOnbdMl/T8kOhs9JxTBuamjAxLldbkcGP2D0i/4+8pRiYEzmXr8wBRiRTo0Gg
	 v0gItrUC3tT17CZ+7sbQl3YjL6597yL9CMf9b6keAG48UdHUZX9ix/eOTZIFg9W09U
	 33ljDdbSbv4Vcr7hihw3sEsj1CS/zvSxWf3DK3by1GOhQfr90XF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f6a9:769d:da0:9356])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8AEBB200AF;
	Thu, 11 Jun 2026 21:06:17 +0000 (UTC)
Date: Thu, 11 Jun 2026 21:06:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <aisjSH1N2IWdhrtn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <xmqqbjdhnfaf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SevJ/bSFLAHxfoga"
Content-Disposition: inline
In-Reply-To: <xmqqbjdhnfaf.fsf@gitster.g>
User-Agent: Mutt/2.3.2 (2026-04-26)


--SevJ/bSFLAHxfoga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-11 at 17:43:52, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > I guess the distinction goes back to c06ff4908b (Record ns-timestamps if
> > possible, but do not use it without USE_NSEC, 2009-03-04), which details
> > some reasons you might not want USE_NSEC. Feels like it ought to be a
> > run-time config, though, and maybe even something that gets auto-probed
> > by git-init.
>=20
> I thought for a bit but didn't think of a clean way to auto-probe if
> a filesystem loses nanosecond-precision part of .st_Xtime when
> "metadata is flushed and later read back in" with reasonable
> overhead.  I do not think we want to trigger system-wide sync and/or
> dropping of buffer cache ;-)

We could have `git update-index` take options like it does for
`--untracked-cache` and `--no-untracked-cache` to control these for
people who want them.  For instance, I know what operating system and
file system I'm using (Linux with btrfs), so if I know that option is
safe, I can enable it at runtime and reap the benefits.

We could even have `--test-use-nsec` to perform a `uname` and `statfs`
call to determine whether this is a known safe configuration if probing
is not possible.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--SevJ/bSFLAHxfoga
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmorI0cJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/20pVocz/uHTN45da65+RvcAwpHiEh887RK3iR2XKd+
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALUiAQDtWIGypXtonFBCoM3PnLOv3kvG
Vk1Xu4Ow3qGTykwTgQEA7TSGXvVpRtwFoCYfcr86WMaQZpxeHJ1FB9wEK7gegQo=
=PG7x
-----END PGP SIGNATURE-----

--SevJ/bSFLAHxfoga--

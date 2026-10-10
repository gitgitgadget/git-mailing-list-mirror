Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC5547059
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591739; cv=none; b=dWlbI1hiuZYZwXuKzvlKnQy/X+3+Wl+iOEsabGAhUyqcwAOF4UX3ee7ncCoq+mOLTEpMEZ+z20MqvJkwVKU82+ZxITGB9G/LuCxFkCqOjtzrkH7mzM7WVqGGo3e03M+skYKyKt5ZCv9EGJQe6Tmp3jHcS+tbiOYUwYuRAoC5GEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591739; c=relaxed/simple;
	bh=LI/tK4wxHEFCstbwCDWcOdmIJBHz3BeGEah4dEF16f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWNI6p4+nWfio1d1Th5NyBf6ANAA/4ZRGuF8Ez0bCC0ASap89c/R3oeok4E73abomI25vSIWg6WGvW+rEFa1gJiK3UW+NqoT8arWlI2q9VhXADGU27t3e57l8yaLCFCfMEEn+mvAU0v5Wr/XrN09xUhy9w7IWY9tA372EcIyls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eMKlVW6w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eMKlVW6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791591728;
	bh=LI/tK4wxHEFCstbwCDWcOdmIJBHz3BeGEah4dEF16f4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eMKlVW6wIsUIqFsdaWjVd3pjWPt1wgtSU8eJkswgN6kzb4ZmcJ4AzjgdyyAy/CJYX
	 5XA7VVxWZ72y6u5v8fHdBfJ0ywzFa/7nkO2PmsJ+G+efSzi79mGNRdfxnI73veWU6y
	 xEcsFxz+gmwxxQj0DH4fuQaLAa9pqgCkre7PVDlQTuDL5xcS19KxFNikLARX/VLl9e
	 eVd1AoOs3RLOBSEIHu/c3/vyEjaPOHuRDWMzGW5KYabshO3j2a56tlZLVpmSDBjMzB
	 wlXCMyIRHKKYq6nwGOmM7HU/kJi7IKST7sCT0AE0oUFsy9VMbTeh6HYT3/EVlxIeV/
	 t4CGfLXFXr/XMcBwelW8bgH3QVMEWV5z6j7+5k0AiA7p5hnAChL1XnIvy99wh4MVry
	 3NEgybYc8In4ZU7t0/btP8q4FOj1aUiAQav6wq79iPETROdNZmnQB0Tf7/kXATw4V/
	 QKSO8QumqKQteDdabHOwU48LprO6WTBdLWyc6YUtSVdar0Ym2MY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e916:dcc3:fa34:c7e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D8872200FF;
	Sat, 10 Oct 2026 00:22:08 +0000 (UTC)
Date: Sat, 10 Oct 2026 00:22:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
Message-ID: <asmFLjno-vuuN1ZS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
 <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
 <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
 <xmqqqzi02o22.fsf@gitster.g>
 <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hqgE1x5k+hTEuvL"
Content-Disposition: inline
In-Reply-To: <CACQ=SRHRp4vKpV5JagAXS1n4iX-LJ7fm78OwMGB5fke2CTC4FQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--0hqgE1x5k+hTEuvL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-08 at 19:06:32, Maciej Ciemborowicz wrote:
> At this point, I face a moral dilemma, because the next step is to
> hand the patch over to other people to read, which means asking them
> to spend their time on it. I have the following options:
>=20
> 1. Report the bug without submitting a patch.
> 2. Report the bug and spend a month writing the patch myself, learning
> Git internals and C along the way. Unfortunately, I'm not planning a
> career in C. I've been programming for well over a decade in a
> completely different stack, and I simply can't afford to devote that
> much time to it. It might be worthwhile if I intended to spend the
> next several years working with Git and C, but unfortunately, that's
> not an option for me. On top of that, I can't shake the feeling that
> AI is already learning faster than I am.
> 3. Report the bug and solve the problem as well as I can with the help
> of an AI agent.
>=20
> So realistically, my choice comes down to options 1 and 3. And that's
> my moral dilemma: I don't know whether it's better not to submit a
> patch at all, or to do the best I can with the time I have, using AI.

It's better not to submit a patch at all if you can't submit something
of reasonably good quality or can't satisfy the guidelines in
SubmittingPatches (either with regard to AI usage or in any other way).
I've been contributing for probably a decade and there are lots of times
I submit a bug report or notice a problem and _don't_ submit a patch,
either because I'm limited in time or because it's something that I'm
just not familiar with (like the internals of the pack bitmap code).
Reporting bugs is valuable to us even without a patch and nobody is
expected to magically understand all the code.

The problem you reported has been noticed by other people, so it may be
that someone who _is_ familiar with the code or confidence in C picks it
up.  That happened with a change that went into 2.56 about an issue I
reported around the 2.51 time frame.  I agree this is something that
should ideally be fixed and a fix would be valuable for another problem
that I've also reported (`git remote rename` is very expensive with many
remote-tracking refs), so it's likely someone will pick it up
eventually and that could end up being me if nobody else gets to it
first (no promises, though).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0hqgE1x5k+hTEuvL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrJhS4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ7BgDs1xqRnT23967ZJRp/NekbFFT1Bo4Ybke1H3sJr6
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACbKAQCJG8mffTxGzkSo/z4LltdlAZcj
K9MbDqpdZ7drfB5WfgD+J5cyaP9k157eqRag/g+dpDrXFMVdQjO5EBUVs0p++AQ=
=YKpm
-----END PGP SIGNATURE-----

--0hqgE1x5k+hTEuvL--

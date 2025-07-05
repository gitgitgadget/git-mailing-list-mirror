Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4DF16DEB3
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751746069; cv=none; b=sS/DoWhpUxDa7xMCziXLNeX/6fi+LhK/4bHfZAozoL+DF/eKN6zbqcALuCR3tD9PdNq9whd957wiYhRVC1rPwLvG1H4niNdgsozZUgVnh9+A3exJ/vXdWAaQisPR7KTOYZweyrfxfK0j+AMYcZPvS+UPzocuyz6anxyDRYVd5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751746069; c=relaxed/simple;
	bh=InihbGgkkF6URs2GkKv8RVEhPgECdtkqRUx4SJh1weY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oidm6t5PH1BApFgLQQ3A6a4xevfY+D8uKLzGRZgpkwVjuSsfDpWKgH9wExvdxJRZXjfZsktR0RLl5K4wVCf3sm2ylVI94fpyFT9CsFR+ZBtDxPEmyDbNZ6Hcvver7uJ5FpAWuHVgAU4IoqGP2R1xS4UywX0co/SAMqERc+8k+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bvvyVchb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bvvyVchb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751746059;
	bh=InihbGgkkF6URs2GkKv8RVEhPgECdtkqRUx4SJh1weY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bvvyVchbP+ilLibELOcAN9YVR94OgT21H18ZpgZJY3lPwaXPwskh6bfbuhek5XcZT
	 wHL9ECB65VN7SbgfrROSR2y6aQn9cdk6/TtY4hIjRwu14GQParciRQR5PrmyrGccGH
	 Ln/mqM2/n2oUesxinaquxJUG5WGX2F8A4EjH5xXliD4bWb+QQh+fXThw8jH0dgoFix
	 rVzb451Gj5A6aVtFsvNYtSru7/hOZbJhsax5noAYGld7LmDRFqa3PIN2ZGK5DcpfoP
	 K68cgjvK0cGUdHsAKWJHcWyi1OLLufN1OSvFN5cQ1WwEy+kf2JinB+P1aR8d/D2k8n
	 msdlYWNMTBydVaVHs3DiTxsj9ovzfa8dzP361COudW+71SWymr+qzFG6l25hBdO2f0
	 nXPEmF/6ZojQpD7Qgije2GGUyqL7m83NcO5351vURQPu2AYbJDCT5mC6Crza2Tqwr5
	 9+c5YYA2YucSsFDyfwVoS6bZBIyTopTRzi/0kL43kc1vtlQ6ZPA
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f46e:145:3ba4:8bd6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A6D412003B;
	Sat,  5 Jul 2025 20:07:39 +0000 (UTC)
Date: Sat, 5 Jul 2025 20:07:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: redoste <redoste@redoste.xyz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, redoste <redoste@redoste.xyz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8/9gsF7z/D6tyYzf"
Content-Disposition: inline
In-Reply-To: <20250705192113.GB2496172@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8/9gsF7z/D6tyYzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-05 at 19:21:13, Jeff King wrote:
> On Sat, Jul 05, 2025 at 01:08:28AM +0200, redoste wrote:
>=20
> > Detaching the filename string from the tempfile structure used to cause
> > delete_tempfile() to fail and the temporary file was not cleaned up.
>=20
> Good catch. I can reproduce this easily with:
>=20
>   git -c gpg.format=3Dssh \
>       -c user.signingkey=3Dkey::does-not-exist \
>       commit --allow-empty -S -m foo
>=20
> which creates /tmp/.git_signing_key_tmp* and never cleans it up.
>=20
> I wonder if it is worth adding a test, or if it would be too weirdly
> focused on this obscure case to be very useful against future
> regressions.

I don't have a strong view either way, but I do wonder if it's a good
idea to have the testsuite poking around in `/tmp`, although maybe if we
honour `TMPDIR` then it would be possible to do in a tidy way.

> > Signed-off-by: redoste <redoste@redoste.xyz>
>=20
> We look for a real name in the sign-off trailer, since it indicates an
> acceptance of the DCO and the ability to legally contribute the patch to
> the project. See the section of Documentation/SubmittingPatches starting
> with the '[[dco]]'. Or here:
>=20
>   https://git-scm.com/docs/SubmittingPatches#sign-off
>=20
> Looking at your web page, it looks like you may prefer not to associate
> your online identity with a legal name. I can't remember if we've dealt
> with this before. I'm adding brian to the cc, who has given a lot of
> thought to naming and privacy issues.

I don't know if we have a strict policy.  I do know that there are
developers who always go by a pseudonym, such as chromatic[0], the
contributor to Perl, and obviously we'd want to allow them to
contribute. We also let people use shortened forms of their names or
initials (for instance, Jeff King).

I also have some friends who are trans and have transitioned or are in
the process of transitioning but have simply not gotten around to
getting legal paperwork done[1].  Obviously they have a distinct and
identifiable name that they go by and we'd allow them to use a preferred
name.

There might also be good reasons that a contributor might not want to
use a legal name: harassment, threats, employer hostility, fame[2], or a
hostile government, to name a few.  I think those are legitimate reasons
to contribute pseudonymously.

So I would say that if someone has a distinct and identifiable identity
that is pseudonymous and that is generally used and visible in the
public sphere online, that's probably good enough.  While I'm not a
lawyer, it's my understanding that in many locales, making a legal
promise of sorts (such as a sign-off) is equally binding whether made
with one's real name or a pseudonym, so I don't see a problem with the
legal aspect of it.

[0] https://en.wikipedia.org/wiki/Chromatic_(programmer)
[1] In some locales this involves hiring an attorney, getting paperwork
=66rom a doctor, and getting a court order, so it can be expensive and
kind of a hassle to do.  It may also not be legally possible to do that
in some places.
[2] Notably the frontman of the band Weezer, Rivers Cuomo, is involved
in coding under his real name (https://github.com/riverscuomo), but
perhaps a CEO, musician, actor, or other famous person might not want
their open-source contributions to be associated with their real name.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8/9gsF7z/D6tyYzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGmGCQAKCRB8DEliiIei
gXYhAQCjXgFgqAWaItyJfnNgBFYbZAqo2LeZVu/fe86rXmLMggD/VAFl2nNOMoLk
GRhm5bVpQhYacg6/9g/6kQbxjESUuQw=
=urYh
-----END PGP SIGNATURE-----

--8/9gsF7z/D6tyYzf--

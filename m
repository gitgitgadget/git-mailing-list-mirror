Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11D2D592F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042129; cv=none; b=OZlAJx9EM8KuBu8wVtXqmWJeQKNqq8mwBDDAZJQ7e0dbZsXjKkvxm/SBh2g9HcXSPv9OK5o/ME1jGcvzKf56o288jVsDePUiaVH09xiMEJhXmj1s+8f1HFdnKf9FUV6XrB/kwWhQ3nFcS8krDvSFd0mh/98lSWmVXekO7+QDJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042129; c=relaxed/simple;
	bh=vEYit26npmhyfdmwuAsypzzlGwTi92uOj9i+SND7Mzc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XjXtajAHswUg8CCwg0waPdzpy1L93QoZSSR9oV1aptuvugZZSyVylFB38MJR7yqM0NPuSEHS5tFzYp6BOa4kjHgTHLXqBF2oAEw9pWdlYJ+QzOlAYCt6NyzRIkpLm33nmVfIgxYswNDWrOrJhTpzs681qxQBkGkB0dB0M9kwJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+mayeIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+mayeIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B65C116D0
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772042129;
	bh=vEYit26npmhyfdmwuAsypzzlGwTi92uOj9i+SND7Mzc=;
	h=Date:From:To:Subject:From;
	b=q+mayeIfnG14jyYewYLhkoMzUAU5gdleSgPsoX5oO0NIO50ypltKKHnW5vGiDSc4h
	 cX6o5TTRtHScZseZ+nDC30oPX//2NaXfTlpqONekJrHAv8RvtOaXs6inGdaSPuLFPz
	 Bes+lrJfclx1hOys/u9coXmHw3fE5soa28aebEATF+v0X7vfSnjP7Ihd30BiOlvcls
	 qShd5uMl5i/UDZVCt9b3VTmj3lNQWHEopL8l5vu4cJ1ZibncPgMffKYoGzLxL6dPB9
	 jEXU3VvrXw3ijZQv0405guBVO2Ka0ev3pM8fYbZfCQ4/4nxP4V8QDsKvTFCS5G1fe7
	 +or3rosE+sCLA==
Date: Wed, 25 Feb 2026 18:55:26 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: --no-decorate and %d in git-log(1)
Message-ID: <aZ81X6ERyx5fcm6L@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g34kzedpxc6u2456"
Content-Disposition: inline


--g34kzedpxc6u2456
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: --no-decorate and %d in git-log(1)
Message-ID: <aZ81X6ERyx5fcm6L@devuan>
MIME-Version: 1.0

Hi!

I use a custom alias that is very similar to
	git log --oneline

The reason is that the command above doesn't show the signatures on
commits, and if I were to show it (--show-signature) that would take too
much space (I really want --oneline).  So I use the following format:
	--format=3Dtformat:'%C(magenta)%G?%C(reset) %C(auto)%h%d%C(reset) %C(auto)=
%s%C(reset)'

which imitates --oneline, except for the %G? at the beginning of the
format.

A problem with it is that '%d' is unconditional.  I'd like to be able to
use --no-decorate to turn it off.  This would be consistent with %h
being affected by core.abbrev, and %cd and %ad being affected by
log.date.

Would you mind changing %d to be affected by --decorate=3D?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--g34kzedpxc6u2456
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmfN4cACgkQ64mZXMKQ
wqm7KQ//fLgGsP7T5zMfN9BTJUGFHLEGtPX9g3n6sCGJHXWe0sIck2DSf3NAgjQs
mSsxeujSvl/vVM4xw8azMQzZcAClvOKWUTvoaxu7/MiFriGJvEcc//mrJcMW7kJt
wefS5pEmc6RPHCHePmVf9XEN43NP59R3f4TD6IClXNdcrWKW5LRyJ6/EsSc5z+f0
D6E6df+ApAPrabxC+LQXwkMlB1P3GHmpeHtibwgA8uRuJwymAfFR9qOOUQ9xWJjB
XxwNMSFIQY5SpUmg8Qgs27vz12tnSzeDLW335Kb35NOkXfAVM+McI+vjoLdzuDRZ
zeCQg1FpkX8Adg1YnRFFRYxxt4DT73gpCy2M5CZNPEPknIzRoNJKNvJ11eJvDBlU
IBSh+IXTgapS/RPyPbPe6kHfRhYYu031exZpDvB5y3XMOjRFl4SbUOMjGoJIrUqB
QuvoWqi/i3+LzETE+tb2dqY3nPt5sUJr/tvxBw5Kr/oAtlI7tuMa6W+x8Ta6eBTZ
iw5YLi/20GO01Z0LZgIklOZVd6ZJyVgNO9LWrWvSC4gaHE5mh6m/dLy/Js1z5grl
yLVnpBbkzeWM+e9lxjWNn2lrm0JAv+bxcEygijZ41bBe23y1UIxKJJENPWxFj6Zo
qk/7l7RA9rDeFwVEVDaSO0gVhmA8Oe1NGWiU/y11X+10zZu91Mo=
=kOUx
-----END PGP SIGNATURE-----

--g34kzedpxc6u2456--

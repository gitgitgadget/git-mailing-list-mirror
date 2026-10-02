Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF8332EBC
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967978; cv=none; b=XKOxZuUPVdd3pHHZ0ILz040QH4/kfVY6yTUgSBzAp0L8R5/EoxgmpeY+97ufuW4xy/M8CriPRxFni9ELqReZQ9epbg5t/yA8mTWPaCynygmVSY+5yQSoESMpSgD0tKmTC2SeZm3qcQVv7M8U7RCKCCkvoUmJcTon8OV3PxpnS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967978; c=relaxed/simple;
	bh=wkjYJ1kefSz2dCiG+4dp+8J97Avm4oQsa92jidaqGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDFz+HN+kA4PiM9lX3DugTPlgmpjFzz6rFhm4/EmbgJ3WOCWGTozVPE5B+vksTWsmpLaZsTQ/oFmGKMH4isvnNz6vLfiVBJbFz/zuamEh5L952fkLbK4ksXRip3lcBChpwuzJ4OpKytS92QjmZEV/KkK68yPP73F6ZSQzRtCNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=diQcR7/I; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="diQcR7/I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790967969;
	bh=wkjYJ1kefSz2dCiG+4dp+8J97Avm4oQsa92jidaqGrk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=diQcR7/It6aG3OoznOMHwvwgLjMNc2tgSNYsoaPA342jYx9dnARfMSjN+HT55iQxs
	 hsvL+C+zsEzsI2b+eANpaaZ7QJCejVqH3HaWrYszrXOcVrCa/fG91FaUTCiw6PUy/x
	 9LK4QJX+cWl/xYBwAVv1pa1WgygSQ+Q2Fp1lvKaYPYumTgPF9KRcgVHQHVhB2zrBuT
	 ogJkt7wrThWFNuoAbVzKWBWWViIk4cLt+Hq5G18s+C5GhmlE6l/tD/vxhBGZKvjE9I
	 /kdkV/Ehqty4IJVTupuP75WdfuxC5/Bas1h452DvSbOd3WqbmECmFZEPbEfk1FFI64
	 bglIxIse2cfdCwVuobilvGt8XMK+wozgXDL5QD3+Q59ZgA681+KqaM1nHYEQNpTHYn
	 LHG5Th1kNaXa4CcL+b/Edh2jr+4Zu+O9/N2oInXtG5gP9LIfQiLSskCc7tM5JVlxFr
	 H7uNwfV1mcWp2RAkGhEhWI7KrS6xcgqr4WeNL2n4QsvJdbiKuQ2
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b933:116b:3dd2:3ac4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A4F9320075;
	Fri,  2 Oct 2026 19:06:09 +0000 (UTC)
Date: Fri, 2 Oct 2026 19:06:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
References: <20261002081846.25144-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rherp020SBs8x4D3"
Content-Disposition: inline
In-Reply-To: <20261002081846.25144-1-scott@gitbutler.net>
User-Agent: Mutt/2.4.1 (2026-07-04)

--rherp020SBs8x4D3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-02 at 08:18:42, Scott Chacon wrote:
> I'm concerned about the ecosystem impact of moving the `git init` default
> hashing function to SHA-256 in 3.0. I have suggested that it may be more
> feasible with similar benefits to add the ability to inject an independen=
tly
> calculated and verifiable tree content sha into signed objects instead.

I don't think this is a good idea.  There are lots of reasons it's not,
but the simplest one is that Git requires collision resistance because
it is impossible to store two different colliding blobs.  We don't have
any such blobs yet, but I fully expect SHA-1 to become as weak as MD5,
in which case there will be a large number of items that cannot be
stored in a Git repository.  Even if you don't want to store those
blobs, there are many people, such as security researchers, who _do_
want to store those blobs and that requires a SHA-256 repository.  Your
approach does nothing to address that problem.

Consequently, we need to make the problem better as soon as possible and
that means moving away from SHA-1.  TLS, OpenPGP, and other major
ecosystems have already made this transition and we're very far behind
the times.  The Canadian government already recommends users to have
moved away from SHA-1 and the U.S. government will no longer allow SHA-1
for any purpose as of 2030.  I want to be clear that 4 years in the
large business and government sector is nothing.

I'll also add that the design we have is the design we've had for many
years and there has been ample opportunity to propose alternative
designs.  The plan for Git 3.0 is around the March timeframe and making
substantial changes now is far too late.  Every major forge has support
for SHA-256, whether publicly or in preview, and no forge has support
for this design, nor do I anticipate it seeing a lot of traction,
especially since we explicitly rejected the kind of half-transition
you're proposing for security and other reasons.  Git 3.0 and the
requirement for SHA-256 were discussed at Git Merge 2024 in Berlin and
discussion has happened on the list quite a bit since then, so it
shouldn't be a surprise to anyone.

The thing you really want is the interoperability work, which can
automatically rewrite repositories from one hash algorithm to another
during a clone or fetch operation.  Yes, it isn't quite that simple for
submodules, but if you recursively clone the repository and all its
submodules, it should be possible to rewrite it in place, although that
hasn't been written yet.  That work has not yet been sent upstream
because some of it was written at $DAYJOB, which requires that we use
Outlook and we all know that Outlook corrupts patches.  However, there
is some intention for another company to handle the polishing and
sending, so it should be available sooner or later.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--rherp020SBs8x4D3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrAAJ8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ81pReEf3Dml75jug9j+mwlJsKhBeHBbRpfz8TyWR+wV
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGmfAP0UOFHwMMYSH1wJnE1wYeQqtAkK
Me/f3nQt+lOFOIOPoQEAsZr6Dn/zOduQeI/s+KCknQChLNwCeb1jgZTPTu5caQw=
=IjgO
-----END PGP SIGNATURE-----

--rherp020SBs8x4D3--

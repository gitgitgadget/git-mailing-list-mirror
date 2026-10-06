Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAC39656E
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330062; cv=none; b=o7rMNEm+U9Wn3ZCJJVDqwVFQgk69+1RLkEhkV8JE5G1LDP1RAxNzN2iPxdkM67uQuHZvDCXDcx5eModZzO0vJwLghze4w3h0a/EY5iglfMQYyz65fAsgR1bsnetyVMLlpr0qT9jKwUj8nLjkYcvBzOE+PW1AjeJC/G/BVfi5lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330062; c=relaxed/simple;
	bh=qzCQYsghOtzL9NSvmni23QQ29mCiP3/jRODAtbEFn+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbBbNIriJdSDMy/uD6gMm0jPemBg5bGbOfLl0mvF+3etZo+esdSrMiVe1iJ46QKuJ52aW8nccG12M4RMXXEcJOpRLTAkrqD68ynRFck6NGlHUh9Vcmi+QfWf3TzDJml7iJZxCrnseXz/v+7/r6e6Q2m09WnK4Kd/fV/GlbYfGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LH7fFU9K; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LH7fFU9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791330053;
	bh=qzCQYsghOtzL9NSvmni23QQ29mCiP3/jRODAtbEFn+U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=LH7fFU9KJOR3C9uLsWJXg2eUIHB2UpJip9jO3u56ZJzSPBgO8wQBfMe7mfg0UOkfE
	 aHWJR7V4eUTKVUhqe24kLtfnvsmc2B1qot+Re/tQ45SsTFw+lNEPEVTCC2shEbns0P
	 CFWW9lPoGZHAkli4Gf3FMoiMXS/iurQsSi8vJ2UCx2e/ASi1Z0q+Snkubs9XNs56Mr
	 /VwG+ILaJbQXxvdVjKLQwz/m0WjzL7mD9jJigP76Y7bfd4XLcndoK1jR+iTEq1S/OK
	 45h6mOChLJjWW4m7EWq8695smVKboeHXPz0YXzkiqbikOMs0lNFd2k4pLcWIa8E4cI
	 pkLJvKGMQUoWvu7JJqhE7PyrBuT7JGAR/odJlEMZA8Hvz7cXSSh+0qBL3lTZWuN4hA
	 rsjF8mZQXbnPob/iUtjcrlzeQDw9kwG9Zzd7MK8kfrZJ+Visz9FF41OvcToKKcs8mP
	 5u7TYBwNMpzX+1fhUnAhiXj9dNtahmjA6rUywOaBPe93k0/l/S5
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1808:f548:d307:7e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 69A6D20077;
	Tue,  6 Oct 2026 23:40:53 +0000 (UTC)
Date: Tue, 6 Oct 2026 23:40:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asWHAyDpUPdS6vuE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
 <asOa6dgpj0qV5QAU@pks.im>
 <d59dfe7e-5958-4a72-92d7-788521f3e55f@app.fastmail.com>
 <asVuadq79SNc-1y1@fruit.crustytoothpaste.net>
 <xmqqzewqbgk2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DQ7R20j28sbKzxbH"
Content-Disposition: inline
In-Reply-To: <xmqqzewqbgk2.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--DQ7R20j28sbKzxbH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-06 at 22:38:37, Junio C Hamano wrote:
> If your time were corporate-funded, and if I declared that we would
> accept no changes other than the SHA-256 interoperability work and
> perhaps other low-impact changes, and that we would give anyone
> helping with the SHA-256 interoperability work the power to veto any
> topics that may interfere with quick integration of their work for N
> months, would it have worked better, I wonder?

It might have.  I don't want to say that the ODB work and other
in-flight topics aren't valuable because I feel the opposite, in fact,
but they just make things a moving target and if I'm doing less things
in my personal time, it makes it hard to keep up.

As I mentioned, one of the main impediments to my time being
corporate-funded at the moment is that I can't send out patches from
$DAYJOB because we're forced to use Outlook, which will corrupt patches,
and I don't want to send out work patches from my personal address.  I
don't mind if other people wanted to send out those patches, though, so
that kind of collaboration could work if I could get my employer to
agree (which is likely, given the fact that I previously spent time
working on it, but not guaranteed).

I think if we could get someone to polish and upstream patches while I
work on the next steps at work, that might work well, but of course I
don't want to be very prescriptive about how others contribute.  As I
said, there's plenty of things that need to be done such that we can
have several people working on things and I'm grateful for any
assistance I can get.  Even someone rebasing things, resolving
conflicts, and fixing tests would be super helpful.

One thing is that we would need reviews if we want to get patches merged
in a timely manner and that's kind of difficult at the moment.  That was
an issue for the original SHA-256 work, in fact, as well.

> Such an arrangement certainly requires buy-in from other
> stakeholders.  Employers who fund scalability work would not only
> have to wait their turn, but might also need to be convinced to
> divert their resources to help this effort, so that the magic
> number N becomes smaller and they get their turn sooner, for
> example.

Of course.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DQ7R20j28sbKzxbH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrFhwMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyomhJhGgroS+NxmvMZg5+gwR+TZs9JGruANnwTSqAZ9
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANLhAP4lBI5Z2gW9Wc+OHamrgHrcwEEN
zCtE0XC/a+JyghRAmAEA3FhDGSM00Gf3Ge9D6jeIwYC/ZRVx3t9VCIFetkLCqgQ=
=kl0j
-----END PGP SIGNATURE-----

--DQ7R20j28sbKzxbH--

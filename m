Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096A38F91
	for <git@vger.kernel.org>; Mon, 26 May 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288584; cv=none; b=lidLmdYgVmyvAe7N2EYaZfvnjdM3mjpUxTQqSXEZMNP+eAaWTNNzUvD72EuLKkDQfwQOoK13miuijudpBBMfc0i+PjSERhZ6FTwMy67g5tXjEtBehu6Aco49KhM1xiDmFDdZyoXMld/kncYpLVgBagwmIfz2TduslafVlmncXTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288584; c=relaxed/simple;
	bh=fp2c1GR8NRVkLdPpWgYW+1K6n09Z+0r9HnTBYXU4Qps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWxbi4ilZJQD5MRwarsO6uL7ZlmqTdmsXXmYyYa0RyijBveianlI62mzu6QJWiyMTcjFPcyxOXu5ETAT10lMRcYSkvnOOueuwwkUoksuKBUfJSkPaVb1/VVUMd0XAouknVBvZl5STEOjtwQkfR6BQud89eprESomIPseeG+7s5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vXXqQlsQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vXXqQlsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748288580;
	bh=fp2c1GR8NRVkLdPpWgYW+1K6n09Z+0r9HnTBYXU4Qps=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vXXqQlsQLDepPWvahR5s9KPT1sDL9VJZkewlOeBtOhJewkF2R6So1dZdjxOqIwEmJ
	 UD1LbpXz5BK5tmv8kfS0ddlS8Q2BQddr2QyRBHKG1NZ+nWb/EzEcO0Sg9Sr9Bhmoym
	 ar7BgkaeAtPqBA5109sNfW75duFNavPWo0CHI9H8wEvc+wXKyf+vAduRzDdo6Eob7e
	 yN1cKMGM+AyQBA/PhhtYnjPd5kxwGm/klJoDmX+Q1VJqQGFYvCPA6BWfDnnFUKE8LR
	 kOxazpYNTurtwXY4wFYPKFRouxqvrvVvqsXww27S67yEDNUKLonqDvar7SY7LRQmUX
	 AX7mwCIPv93ofULzwURytaNbrLM6VKS1x0RVVbgeOd27g58Q8ARj/bV1ZXEI8byflz
	 n6GDISTaVoxn3AqdELgIsBffHwaHQFcjKxU4avJTuWKFVDX33QcjuZkaPQCuPjodD8
	 SXYKPX7bLAqrbgkX3C3vEm55vKgMuB0mwgMRX4eh6cJNtXzuk4q
Received: from tapette.crustytoothpaste.net (unknown [204.148.157.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9864B20038;
	Mon, 26 May 2025 19:43:00 +0000 (UTC)
Date: Mon, 26 May 2025 19:42:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 4/5] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <aDTEQDwLTOONeYp_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-6-sandals@crustytoothpaste.net>
 <xmqqv7ps4bef.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1oaJGXOTT7QZIqnw"
Content-Disposition: inline
In-Reply-To: <xmqqv7ps4bef.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1oaJGXOTT7QZIqnw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 20:51:20, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +static int check_stash_topology(struct repository *r, struct commit *s=
tash)
> > +{
> > +	struct commit *p1, *p2, *p3 =3D NULL;
> > +
> > +	/* stash must have two or three parents */
> > +	if (!stash->parents || !stash->parents->next ||
> > +			(stash->parents->next->next && stash->parents->next->next->next))
> > +		return -1;
> > +	p1 =3D stash->parents->item;
> > +	p2 =3D stash->parents->next->item;
> > +	if (stash->parents->next->next)
> > +		p3 =3D stash->parents->next->next->item;
> > +	if (repo_parse_commit(r, p1) || repo_parse_commit(r, p2) ||
> > +			(p3 && repo_parse_commit(r, p3)))
> > +		return -1;
> > +	/* p2 must have a single parent, p3 must have no parents */
> > +	if (!p2->parents || p2->parents->next || (p3 && p3->parents))
> > +		return -1;
> > +	if (repo_parse_commit(r, p2->parents->item))
> > +		return -1;
> > +	/* p2^1 must equal p1 */
> > +	if (!oideq(&p1->object.oid, &p2->parents->item->object.oid))
> > +		return -1;
> > +
> > +	return 0;
> > +}
>=20
> This is much more elaborate than the existing "does this commit look
> like a stash entry" test done elsewhere, isn't it?  Very nicely done.

This is Phillip Wood's code, but yes, it is very nice.  I looked at the
patch he provided and it seemed very sensible, so I adopted it.

> Hmph.  As we work with the commit objects in the above part already,
> would it still make sense to use an oid array?  That would force us
> to look up the same set of commits using the object names again in
> the later loop.  I would have thought we might use commit_list or
> something to accumulate commits, and then consume in the loop below.

I can do that in v7.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1oaJGXOTT7QZIqnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmg0xEAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2/dvE7m2lBQZE7TTofUf1fLhQyv7Zbv6zc65RNlTPpg
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAB/zAQCV9OVUyZvPFA0llGL8bS//Vcsw
u1tPMHf0UchoFRVOdQEA0pmcSkhqZFeOCY4XJcC/6zD2WY2yNdFod61TMZ7nOAM=
=TYwM
-----END PGP SIGNATURE-----

--1oaJGXOTT7QZIqnw--

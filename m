Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8417BA5
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535279; cv=none; b=mRnBqqGNjPntl18yGnTenR46lDyWwQf890+hrqUlyQZqwOKbPp98d8bKAsp15zjdL9yzyMbGAa5nw45CFLaQMaoG8BC5+sYQKJ+KYw+liAPXkLC50uGIu94Mwsf9u1RRxhK6ii7nY/PJWdOhpvIpOo/hl4QdzBCltbwq2C899Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535279; c=relaxed/simple;
	bh=TH0E5t5Wrh410MVKMW/5NIAQdzAa8628hP25hugR9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeOcUjquUWuFjpNDfjNW0UzyrvpXTb6wi/FnY5EsUP4opq7j3KyL9U648OxREQ3EasuAPtYvYiX9M6eUIu9g6WQyc64RMm/fjt26jMkDJKFKl4O3h0Cv3Z1ObnJn4Bnz3hSSu1uD/pMDsZROwyr76SNQ8g7Ff8G4ksDeS0NbM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zgx3q1wX; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zgx3q1wX"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B10B15B3E0;
	Fri, 15 Mar 2024 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710535275;
	bh=TH0E5t5Wrh410MVKMW/5NIAQdzAa8628hP25hugR9YI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zgx3q1wXSFe8gD779BsoYS2a5nieOfzU8W5h96gBTeYRoUQCwwwEt1G2R8Y/2PTsU
	 DnvkRZJ/MrbAopv2yeHCiQHRmhPurePx4xQ0fN1RDjAj1xX6snNFXj0ZwhKbirq/8f
	 2pryaGUgVZN4KKOKraad4BeuQPYXmO7KcEr3ubXBK9GeFmJ4C7N2gJcV96uETjOIE1
	 vebuaSOnubPhCNsEEdvDm2FTaa5C8MJ97kl1jAaRl3RVGi2JfKCA2SfvoMuBPvWq0Z
	 anjkk+m8BtSbVGWDKFcLl92WtE9wLBEsXb1pGtOpbPK0GSyVwoorObF/Hw/7krfwQb
	 o6qWZ2lD3Qa77Woidr73VcKB2Mx+5JLkRtU2CQD7j4oL26udFZ5jTQSLEsM+Rf4DQa
	 H/JogYn6u8LP4tZ8rpijS5L7mnFrr+x3LWM9vKePFZpimaJ5uIQRHvNW1H+8dbQPfj
	 UZFmH8wQTERRqtUL+okWLEA0x/1t3eUzMYu5oo3Vde7c2eJSOfe
Date: Fri, 15 Mar 2024 20:41:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: leon <leon@kske.dev>
Cc: git@vger.kernel.org
Subject: Re: [Idea] Only allow commits when no undeletable file has been
 deleted
Message-ID: <ZfSyakFaxHyTEdxR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	leon <leon@kske.dev>, git@vger.kernel.org
References: <5f4701bf-3121-4c78-90c8-b1f3a942512b@kske.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1KM2N7jQ0yPOMY5g"
Content-Disposition: inline
In-Reply-To: <5f4701bf-3121-4c78-90c8-b1f3a942512b@kske.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1KM2N7jQ0yPOMY5g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-15 at 18:55:37, leon wrote:
> Hello,
>=20
> I have an idea for a feature I am missing often enough within Git (and it
> **needs** to be part of Git itself as it would be rather useless within
> third-party tools):
> Oftentimes, when you have submodules, you are depending on specific files
> being present within them, i.e. so that your Shell scripts and/or CI tools
> work correctly.
> However, especially when the submodule is under your own control, you
> currently have no option to tell future collaborators that deleting or
> renaming such a file will break things.
> Or even your future self, FWIW.
> So, what if there was a recognized attribute within the `.gitattributes`
> that said `files matching this path spec cannot be deleted`?
> The actual content of the file is irrelevant as long as it exists.
> I don't care how this attribute is called in the end and cannot think of =
any
> good name.
> My best approach was something like `depended-on-externally` or
> `undeletable`.

I think you want something more than "undeletable".  If I change your
`script/build` file to contain only "Kilroy was here", it's still not
going to work, since that's neither a valid script nor a valid
executable.  I certainly haven't deleted it, but I've rendered it
unusable nonetheless.  This sounds like a contrived example, but it's
entirely possible for people to typo a filename using completion and
save the wrong thing to the wrong file or redirect the output of a
program to the wrong place accidentally.  We've all done it.

I think this is a great place for a CI job, though.  If you know these
files are required, you can add a cheap CI job that simply checks to see
whether the files are valid scripts (or whatever policy you'd like to
have) and fails early on.  You can even make other CI jobs depend on it
so that you don't waste a lot of time failing all the other CI jobs when
their files are missing.

One thing I've also seen that we have at work is that you can link CI
jobs for project A to project B.  Thus, if project B is a dependency of
project A, changes to project B run its own CI jobs plus a standard
project A CI job, to verify that nothing's broken.  This is really
useful and a great way to avoid breaking things in more subtle ways
(e.g., removing a function that you didn't think you needed, but project
A does, or changing the behaviour of a function in a way that breaks
other projects).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--1KM2N7jQ0yPOMY5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfSyaQAKCRB8DEliiIei
gVVZAP9LKqPBBj9NY7ckBkysPWVNsuy+/ZKB31IlDpEHhGCLwwD/dZislcqjxUqQ
xGhixdsCMyqzCbsu6fl+QzlpXkaAigY=
=n/IG
-----END PGP SIGNATURE-----

--1KM2N7jQ0yPOMY5g--

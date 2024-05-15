Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F24D10A
	for <git@vger.kernel.org>; Wed, 15 May 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763920; cv=none; b=sOlte13qLGrZ1rErDLguaStTxGJyhg8pGPgxo5Kh8EWMTWqp/Ep5+Ql/n29qrcA4gcozH1bIOjFxmqir4/+90FPL+4SOjJ+YkYPPub9CGq2UCwFxeT5xaoogNpm/tSxtKvNMpazbTBQtAan0mw4cQ1CPvWfC9C7GfgZp7K2zBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763920; c=relaxed/simple;
	bh=4md9ySHcbj5+owpJGZ8X+VeVYraeZ0XhEuMuhGr5Ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP67P3EH+GA+JK0l8ptX5l0CGYLvPucda3IPbt/c0zKknIwGH7FheRDYclYp13eOul1EqfuVVQ+uR/RBQ2V3cdY7x0D9bH3SnPoROfIeBjtzDnXfbY/IJXR9yeuSRftJkSdf1LKBiV8HX38MkPeV7uQfKxLZPow3Zjc/mfjMB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HGSVcB6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeSEZNun; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HGSVcB6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeSEZNun"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 67A6F11400E9;
	Wed, 15 May 2024 05:05:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 05:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715763917; x=1715850317; bh=sC4wO4lU6x
	SSeFF4YfBVwtYJs4lRN/x6OLHou8cVl7M=; b=HGSVcB6qMdbG2TU4zC+rp66VC/
	Hnd7PGWs/4xpFMnVNun/Kdzzz34/6e1j0j7x9rdnclWe6InibTQvWZt0wWtUe0Kg
	TPZCZ+ATUcGqkKA5xkoH7slXOjPwZcHzzQoGkEeDsYy7M4eAqm9OcjczxccA1GsA
	DO1pVr2HGfI3DwxMaZrwOK+ttzwEjJ+ejJvXlv7M9Wtu6d/jRsr4syQ/Vsg559Ta
	nIMfX4kq9Xqd7bzOKMXxd+N8Sth+zJC+kvk0XgWg5VnG7rnjPs7A4S0e/Fw4TiB6
	ESTR7xyOMF+fbCfS15Xtu9n3lBWQZLGyaCK4cGbM+jHRwAGkwa79u2peC7VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715763917; x=1715850317; bh=sC4wO4lU6xSSeFF4YfBVwtYJs4lR
	N/x6OLHou8cVl7M=; b=PeSEZNunhmTQSuimfA97pVXM6WiDBvvmDZB62R/YnqbT
	p6oViAbBZa3YAql6R5Eha575/bGFkyMF+X5SAOOalUGYfzvfeZoxxKZLOUNXymwl
	B7A9zyjlsOU/kJhh3+XN5seV+EbkrzoyC1jTKL9jtj5xGBoG1g+pxHQpK2+JaJu2
	GEtggYR+SrgG+gLbg1kpToh3iP4/BoifHhjypmgI5YbuXzuVv9J/FI1Ff9haO7nF
	MZIhxWVxGe1kMszjfW3IxtxOEDyYh5Nclgrsue8RYpha5KmvGbXGA+hBSZWXzSo0
	znDvWm80ycbQU75vJk1vnU8vYd+2S5t/Z7EMZFijdw==
X-ME-Sender: <xms:zXpEZnNyxSspwGcT5-L53kt87pykrE-ZVhl-QeQ83WcT0086xDiBaA>
    <xme:zXpEZh8p34vF8z6kvOrLAvBjHjmnAo8REGfm38FbjczBsiVRGq6F-73FdQPJ2XH0T
    IYVH13M6fuhZATQTQ>
X-ME-Received: <xmr:zXpEZmS06s6HQL3lIWk57hhjhfVzOh2W3qQ5ZwHWk7vUPTQXaBWbxola7sPpbP75VNWiwa1O8OgMBYrnVQTJfOTVwCEj3VMlYovx3v1b5o2X1JTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zXpEZrsSFEFbHRa94e6vR9QVlnqSj7eJxHVvO81qy1QMQPx8yUgH5w>
    <xmx:zXpEZve_B2mSZJLX4YGdg-bFkAPKRUTfgcvebL1tInUXqAxbW9b1QQ>
    <xmx:zXpEZn1CX1nDG_Nx4vyH2TMnrgPS4wxKcJ_gep2DBrNhUnjqi5AoSQ>
    <xmx:zXpEZr8uJcdKIZ0OTujQjEc765Io4PRkxm6ks9NHdVJLin-O-Rdc5Q>
    <xmx:zXpEZm42YHsdZfchyiBdcdBiEXUGO8DiOf2nWo61LHjuRdpf3vDpxvvF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 05:05:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f632b517 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 09:04:49 +0000 (UTC)
Date: Wed, 15 May 2024 11:05:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] pack-bitmap-write.c: avoid uninitialized 'write_as'
 field
Message-ID: <ZkR6xqHgrIvoV6OR@tanuki>
References: <cover.1715716605.git.me@ttaylorr.com>
 <f16175295f5c786fea2d56ebffc2b9a6beb07aa0.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a+fmI9cJ3KbjJDvb"
Content-Disposition: inline
In-Reply-To: <f16175295f5c786fea2d56ebffc2b9a6beb07aa0.1715716605.git.me@ttaylorr.com>


--a+fmI9cJ3KbjJDvb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:57:03PM -0400, Taylor Blau wrote:
> Prepare to free() memory associated with bitmapped_commit structs by
> zero'ing the 'write_as' field.
>=20
> In ideal cases, it is fine to do something like:
>=20
>     for (i =3D 0; i < writer->selected_nr; i++) {
>         struct bitmapped_commit *bc =3D &writer->selected[i];
>         if (bc->write_as !=3D bc->bitmap)
>             ewah_free(bc->write_as);
>         ewah_free(bc->bitmap);
>     }
>=20
> but if not all of the 'write_as' fields were populated (e.g., because
> the packing_data given does not form a reachability closure), then we
> may attempt to free uninitialized memory.
>=20
> Guard against this by preemptively zero'ing this field just in case.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap-write.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c0087dab12..420f17c2e0 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -112,6 +112,7 @@ static inline void push_bitmapped_commit(struct bitma=
p_writer *writer,
> =20
>  	writer->selected[writer->selected_nr].commit =3D commit;
>  	writer->selected[writer->selected_nr].bitmap =3D NULL;
> +	writer->selected[writer->selected_nr].write_as =3D NULL;
>  	writer->selected[writer->selected_nr].flags =3D 0;

Instead of having to ensure that all fields are initialized we could
also set the whole structure to zero via `memset()`, which might be a
bit more sustainable in the future. That alone doesn't really warrant a
reroll though.

Patrick

--a+fmI9cJ3KbjJDvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEesUACgkQVbJhu7ck
PpQBwQ/+NaL6DO6iXR3VafU5HtbNIsE6TNE3TUX90s8ub1Ngo0b88j4fgc1DEJTL
L8CCoPXyTVFZeqGFh5hmqdPe2Ti/E30NDstKNgiYRV6MKDsfNxkIZJwuVwz+NCmF
343yZb6b95DBU0n7Kfw49XV+riLTrfXKHXJ+nbRJmmI9D146JKM+rrDQ4P2Zq2KU
6pbyQeJntkkSXSVr1L3W1sEbqu7bZJQj4hUBqGR/3caTOPb+obR+pLdWGaoMovIL
Q864KJ6E5KWXRshT+sbiuZUIXpJ4TPt+kgG1muOIAiLVCqEl7pE4q844wknKjmp1
KHYRoGbfJqQeU8uDdJV0PL3jtS3wuADQopWxN1i2/BBBE6d0Kwv1fObJNQY1NLcq
Ur2gCcT9a2SMliLtRTiiy5DDMgS/uqHTB4rR2GX5A/H9w0H2hAM8UhNEkouSY8qM
ycTEdIkZfxAoFKU2oU9F/AvDjgLtICsQmZ2zPWkcKSC00GoYKxEw+cnLp3UCGdtn
c2hDb+g/5Ton7kprUzs3fBgtPxE0ED7nUpd7DQ1a7ZX0xcB00jx935bTKpYqTLEJ
8bpz9rD/OaRD8DKXe7Cw9ImMsBJCZpMsZSIVq/0chLqt9ZVv/ZhTgmK3jpQJbrrq
6+JeWsy2YiMbBajfHFfOwXRw4G+t9AhxQLpu4fGsuxnQykkmtMM=
=8Y9s
-----END PGP SIGNATURE-----

--a+fmI9cJ3KbjJDvb--

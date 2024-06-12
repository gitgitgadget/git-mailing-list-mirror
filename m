Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42736AF8
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171719; cv=none; b=hFlKuvMF689wPNn/95ebzSGHAM6nMQ2hXleIeCjiONm546qM1d8H5ogck85qBe2kwCGRbXYXoljhG3iZOSLtnQAIfJZR0iOqZ+FL1wB61zOPXRUDXMgDi48bNn74DTQRAMC/Uh18M3xvc1wf+M8ZuCLXUufvwfI8ORTiLI8g88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171719; c=relaxed/simple;
	bh=n/9WsSDfpWPhmu5aefL1XzoWc5YTkRctvH8jukKbpa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF3UM3dRxUnVKBDEot8v6ywGOJXbqVLyNkJTsjcuZuAIE34KndhAEpxbF7uO/Ibg38ytcb0786Rdu1ywT++PZHWXXvOJiX/7Bhl2xc02IpORcw8KimDkXp3IZZ0rZHV0wNzCFaFEtafK4j0+n2ceIieHHoIK5XsLE5QuI8o0DrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A556pfar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0EB5IU6; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A556pfar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0EB5IU6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8CC901800147;
	Wed, 12 Jun 2024 01:55:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 01:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718171716; x=1718258116; bh=bC1GBzdn+M
	U5lP280BcU3p2GqEohtyXZWAFUzBRw46M=; b=A556pfarpkX3VgFwXxOf2kZmwK
	dntGCYcBcuGlIZLqon6NL8t3J5cN8P4Q6c3m4WAtR1Y2FHswzVeADgZA0T4HTwkR
	ucTijIzEiwiZ5J4q8KHXal1QNkuMYD3fdluLiov0pTF6zIHlOaRUoYHwq129Mb8t
	aOo1RPUtHhvcZ+DoQSCqlxqQ29NPy1N9pSiTo52ExoiD+tDoslRm6Sq7QYqGH0xo
	dfmTACPKoNO+5bjkaUHtz/nRlGgmh8XDTUbJIb1Oy/NV22NcfzRCBM06LBoapX0f
	thphu/ZjrYEEP+KBq00xfbb7jXKGJt7AvQ+MOr9O8kgJq9nAF4xFYPnOkFaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718171716; x=1718258116; bh=bC1GBzdn+MU5lP280BcU3p2GqEoh
	tyXZWAFUzBRw46M=; b=m0EB5IU6TPila5OZ+fGdnX+t4O3ikpL4zeGdf9QSQcPk
	xNSj/a79h0eqrg3HADwtTkFzR10SGyR14RzD41ahHqVDA6O1Di3lF4XzYc/bV7Z9
	Vsp9oXLLkZvgHnzVkxiyglOQ61PTKanlh4a8b1gwpjEZKxgl8giL2lYQOZ4rZDvc
	QpnV1+ejwaWWVZtDCun6n4vWx1SfL3c951iRCWFCXJ7INEBK0DvSMcCVxtapN29Z
	6FwbxrMDVebXPxY/pEIF7owpENFSflntsGiL21v7U2/bSorS3Z98QwCWjSAorLL0
	4Gqh6en8FHmtPqKFb4Ra0Y6oQPx+ZZ3fta3DGHUhgw==
X-ME-Sender: <xms:QzhpZvBtVJlTvufE5WrGoj_px5W9H9JpRhWidyAB70_EZMukT7ovhg>
    <xme:QzhpZliL7uT7gAB7oN37TlzkLTH2qCwc9uYCPxk65yYFXd-bJhcwKzUVZTENDNOCX
    rOcva858z5qHeZInw>
X-ME-Received: <xmr:QzhpZqm8Qod1yztrl0njueN-eGpVFCJEpG_wdkwhRQnnwrbgJXbbDhhgc6DLIDn3GjX1Pap4MDmJjXNfWyIJe1hlZGglRfg-ckKzubwmX3c5AgcQp2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RDhpZhyWmUup1DOIsnBqpghZmB5PNgp_ZQOME7_ZM7CykBHQJRNjJw>
    <xmx:RDhpZkTWVRPeIgfGn7dl4-bwSCj5xBRPpOActzXPFTssRmXQiCIQXg>
    <xmx:RDhpZkbvo1mgQHtfhxdYB_Ku57TIl9d7zY-WbYR3CknfLkrzlzUAtA>
    <xmx:RDhpZlRW6y6CXlTnz0_mf-RvSAAoNb8S5SNUHbzRDw0uAZnd7uLv5A>
    <xmx:RDhpZqe3hFTUc8bo-6dgVYRsBOCnP48_CoHpGkbXe6GF0fjNFCzZ8tPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 01:55:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 52ff24a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 05:55:02 +0000 (UTC)
Date: Wed, 12 Jun 2024 07:55:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] config: fix segfault when parsing "core.abbrev"
 without repo
Message-ID: <Zmk4PvvBMwEzePrk@tanuki>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <7ded51bbce1b23cf4110e3bf0abb7579efd4d344.1718095090.git.ps@pks.im>
 <xmqqh6dzwek0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0Q6ol4Lzc5giySP"
Content-Disposition: inline
In-Reply-To: <xmqqh6dzwek0.fsf@gitster.g>


--W0Q6ol4Lzc5giySP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:54:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Fix both of these issues by not making it an error anymore when the
> > given length exceeds the hash length. Instead, if we have a repository,
> > then we truncate the length to the maximum length of `the_hash_algo`.
> > Otherwise, we simply leave the abbreviated length intact and store it
> > as-is. This is equivalent to the logic in `parse_opt_abbrev_cb()` and is
> > handled just fine by `repo_find_unique_abbrev_r()`. In practice, we
> > should never even end up using `default_abbrev` without a repository
> > anyway given that abbreviating object IDs to unique prefixes requires us
> > to have access to an object database.
>=20
> Makes sense.
>=20
> > diff --git a/config.c b/config.c
> > index abce05b774..ab2844d9e1 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1460,11 +1460,14 @@ static int git_default_core_config(const char *=
var, const char *value,
> >  		if (!strcasecmp(value, "auto"))
> >  			default_abbrev =3D -1;
> >  		else if (!git_parse_maybe_bool_text(value))
> > -			default_abbrev =3D the_hash_algo->hexsz;
> > +			default_abbrev =3D startup_info->have_repository ?
> > +				the_hash_algo->hexsz : GIT_MAX_HEXSZ;
>=20
> We will need to have some code that further adjusts overly long
> default_abbrev when we really have to abbreviate (at which time,
> hopefully we are already aware of the real hash algorithm used in
> the repository, and that may be SHA-1) anyway.
>=20
> So do we even need the conditional here?  Can't we just set it to
> GIT_MAX_HEXSZ here unconditionally?

Not really. I was erring on the safe side here to retain the status quo
for all relevant cases. As explained in the commit message, the length
is only relevant when we have a repository because we otherwise wouldn't
be able to abbreviate anything anyway. So essentially, this change is a
functional no-op.

There's also the question of the second commit, where we only handle
`abbrev =3D=3D the_hash_algo->size`, but not `abbrev > the_hash_algo->size`.
It works, but is slower when not truncating the length until the second
patch fixes it.

So yes, we can set this unconditionally to `GIT_MAX_HEXSZ`, but out of
abundance of caution I decided to make this conditional.

Patrick

--W0Q6ol4Lzc5giySP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpOD0ACgkQVbJhu7ck
PpTI6xAArd8WeqGuqmyLc3tmhi0dg0WZ9WN9txEgyTlh2WVN6IBATmIAJ5Hx3R91
vLJM7O3DU5KHArnbz0cBLZgns0ZJ/ZEM0JlfhN63xzOh20mjgLzqYhK0eKXDu8rw
s8WMkEHnh65e6HVzd6Hiq8yLNpLEDgC0bn8K8/hRFV6ALddEFj3RwaR2uweLCH7l
sBlV8ahxU8vuGfSNW3fSsNJVWbHpjM3TP7w1ObdnYVu7vazwIyXj+o95zsl23ALo
1wxLoNZTRxG+4uKMdMCiF1JZceqZjKqC80XzTjXfRC5xozJbINdadsMBtt6IiasX
efLnNej2ZbHlAfpwtAUZ3pTi+fv+blfevaGBfXfTJaxzN3q/7ijAHRLd+lDFTwUi
PQmX8QeziYEa1Zp7r6Vj9REEHjzFxOD7vohswf11ICsA2oMDRbcCcNHH7GTNMeCK
UyrtLBkSKW5WRJsz9tn65LaxjSwDdzg9BB4hphb+7SH6RsPixLFOD2nJbbATvSr4
inANZQLwk+cr4OFxTLKibIEzmvPfxuWowhZFka9Wz9yYC0klurwE1yEoN6sRiEdu
jx5KGTOMaACmeJU3HY/tfhCAud9TUHAro6ocKIBnGnWheIZDdExew3CG/qkVCmji
a20vwXR2jP+vzwq/hACAQV50QZ7MFXmjQnUJS/gms6LwYOyly5I=
=C19/
-----END PGP SIGNATURE-----

--W0Q6ol4Lzc5giySP--

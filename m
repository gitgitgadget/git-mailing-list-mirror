Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B43946C
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566767; cv=none; b=U0OSRqbkmYTt39m9LbadqxZBom+n2L6Ve2f5oMBnleGHobdZXqG2kHG95OkGV8WZT2xs4X/tNg2Xydj7ksCPsn34pRxrMF4DI+MF39Uiwnd1jZLpISiX/mnIX/acpoihiS+6b8lyR0CneENlfeufFFbMhC+A4wgR6GkIx2lMYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566767; c=relaxed/simple;
	bh=CNhviS3L1rsWDrli+fsm/M/akI+bvOVILmJ3wu3XxUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBiJkXxmxwkBCPGSLWDW0NmS4WlskZYGvXerchtPtnZOTuCbQHNBwlQcYsnCOd3sH1byMTAF/jNscbw2UUQRB1jVfiWMWOC4ccl9tv+96hCq7P7mUbSxOJ8w54s7H5dlOYSAN7RyZ5/jPZTBJPHoPQAWnLKxZ0rcmHHDPFgq7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J5iy4OgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lsH0lntJ; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J5iy4OgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lsH0lntJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 34C641C00143;
	Wed,  5 Jun 2024 01:52:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 01:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717566763; x=1717653163; bh=biv3BmWygw
	GtIzDpp9dZgf9Yeghd7yQglbC/d6HKkTY=; b=J5iy4OgCQRgbcNAJGTVFFlSSkA
	45xfYJLLrRcmZ4yqmP+/XQMaY06ugjHj6E/9BDzqC4fs311JlvdNdtrRYqOjsNR/
	xT6JOvld3qbDgFtQryU/suWfin6BjkKHiWLnTNmZgJb9NrxRdt9Kr4MIBj48Hnso
	i46KauGuvMI00FJf5Na39NigzTo4iXiOyRA3PW9SdIDeKCiLCKytQnjPiX7Ixl6Z
	pkkkobet1pZYetxVBvfr3EoJWdilzUfR38eakClt3iXmuKLA9IAO6GQHwCdxUniD
	u+84hAghEcFcwRpkTqzHgWWFxYB8/W83OHK6X5kjCRGxJwg2Y1y2pQwU75HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717566763; x=1717653163; bh=biv3BmWygwGtIzDpp9dZgf9Yeghd
	7yQglbC/d6HKkTY=; b=lsH0lntJyCv+EhN7XGgbfP4lYR3D6wiZhVU3y10ngBeD
	KCOr/Tr8diDS4jA6FhKgk6UpgNGPjFIkjvhDgfmw2lgZg4tkWoj0AZAXfvozj/Ce
	fAtZFNMKKlq8gJZQIX6rf7+sHjanGwgJhgC6y1v9p6IOYVmb92B4FNNE+5J2y0gH
	/z1fDhUSrdASXpVt9KlvCY7lNdWeUhN2pX5VcSVUKpOpb4WifvRKWOaCI7xs46FE
	T329qU0eSwAuDeQCM5qrUMFeagWJWCgc151v7C10B/YZaV1jnSR7KIVV14ojiPqF
	rowz3gA63BSj/1tuWPfF3e2e+QelBrgs/ywNyyChug==
X-ME-Sender: <xms:K_1fZq2dz6hux_PCsUjK_uArAhs45y97QrtU3hhQbJfzr_6zJj0KTw>
    <xme:K_1fZtGsgRFufQ5XKZ8GkqU_6rF8-C8yjXT5Ja3nlbtGcx-tbpNoW8nf9rhaQe5km
    WDUDY7GCayq_agFSg>
X-ME-Received: <xmr:K_1fZi6zhnv2pi6CTMJGsmxv93Sh0NcyS3n4wPVeRTu6mNGjCbf-vQlfyvxnBVQJUXgCINI74Sp_QEX2xjGEE4ImK_TH5EnXixZQ9f4Rh0t1UTZgwC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:K_1fZr0KofSDqOnYKxx7W00t54YuT_Ja5Np7g95o0vQSLZ6NMuuFnQ>
    <xmx:K_1fZtEkt-A-o_TAw9o3M_5201PUIEc5lO2tH1vQ5X17jdsIUMzYzg>
    <xmx:K_1fZk8PoejF9GttRKYsDP3jyRqtH4ynxZHPp47XjkyfnUdxXN8R6A>
    <xmx:K_1fZikQxtG0hqlTx1IRPaOtQPTx9bd09SPOgyzAP4gWRkTgcMhy5Q>
    <xmx:K_1fZi7Iw3n3X3ni_85RuVP2Z-OImLfIRp65j_jKnQH5woyAVprLfCLU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 01:52:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7cfe9a9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 05:52:12 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:52:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <Zl_9JkKAvDIl9PDA@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
 <CAOLa=ZS_2gH4Ob-OTpwFARmmNivW9QXHf5de_ybw2swLwhb79g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GVaFp4ugcyb3iLHa"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS_2gH4Ob-OTpwFARmmNivW9QXHf5de_ybw2swLwhb79g@mail.gmail.com>


--GVaFp4ugcyb3iLHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:28:07PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +int repo_migrate_ref_storage_format(struct repository *repo,
> > +				    enum ref_storage_format format,
> > +				    unsigned int flags,
> > +				    struct strbuf *errbuf)
> > +{
> > +	struct ref_store *old_refs =3D NULL, *new_refs =3D NULL;
> > +	struct ref_transaction *transaction =3D NULL;
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	struct migration_data data;
> > +	size_t reflog_count =3D 0;
> > +	char *new_gitdir =3D NULL;
> > +	int did_migrate_refs =3D 0;
> > +	int ret;
> > +
> > +	old_refs =3D get_main_ref_store(repo);
>=20
> Should we add a check to ensure the `old_refs->repo->ref_storage_format`
> and `format` are different?

Hm, yeah. We do have that check in git-refs(1), but having it here as
well wouldn't hurt. As the patch series has been merged to `next`, I'll
leave this for a future iteration though. Probably the one where I
implement support for migrating reflogs.

> > +
> > +	/*
> > +	 * We do not have any interfaces that would allow us to write many
> > +	 * reflog entries. Once we have them we can remove this restriction.
> > +	 */
> > +	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0)=
 {
> > +		strbuf_addstr(errbuf, "cannot count reflogs");
> > +		ret =3D -1;
> > +		goto done;
> > +	}
> > +	if (reflog_count) {
> > +		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
> > +		ret =3D -1;
> > +		goto done;
> > +	}
>=20
> Isn't this restrictive? It would be nice to perhaps say "git refs
> migrate --ignore-reflogs", which could make it possible to not care
> about reflogs. But maybe that can be part of a follow up.

Oh yeah, it is. In this case it would be possible to add a flag to
override this check, because the result would be that we simply discard
all reflogs altogether. But I don't think adding such a flag makes
sense, because I'd much rather want to remove the underlying restriction
itself and start handling the migration of reflogs.

> > +	/*
> > +	 * Worktrees complicate the migration because every worktree has a
> > +	 * separate ref storage. While it should be feasible to implement, th=
is
> > +	 * is pushed out to a future iteration.
> > +	 *
> > +	 * TODO: we should really be passing the caller-provided repository to
> > +	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
> > +	 * that.
> > +	 */
> > +	if (has_worktrees()) {
> > +		strbuf_addstr(errbuf, "migrating repositories with worktrees is not =
supported yet");
> > +		ret =3D -1;
> > +		goto done;
> > +	}
> > +
>=20
> Same as above.

Allowing users to override this would leave them with broken worktree
refdbs, so I don't think we should add such a flag, either.

Patrick

--GVaFp4ugcyb3iLHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf/SUACgkQVbJhu7ck
PpRmUA//Zc59gn9W4mXwkI8kxxHAE3we4TuaHVjMr1LQemwGheSuxQ6Bjg+N+4qs
fFuIGrc4t8Tb2RM0KEE58pHwOE5NbntPmEZsz1x/AhX7dd9ZlB41ENBLvPvWflv1
eAokZK5AU/DARtSPeLsNMdZWZEpiIa28bBAWYHw+ma0JIwLiwSrklPLHnYDqCqsv
fxZM5NokisTRE08XiqyVGvvKZe4c+st4rVImVnCDXCwSa73LfNlF0gRalIHTVuKo
wG7RdmJNVyNhe058rcS7tUIk5Q9KCClYFtz5W4YtjJbPwV9gvKDOWuy8oDQ/qQop
cvdJHowohI622vzsYplDtH9lSNxUD6U1QZFcx619dZwp5iLnIxjeHCsdMc7Fs0dR
gPqY8THLT3e34G8ziBHJPRvVtQTVHXeR4hRdffiSGvmvDcKci1rxnPzcpZGay3qh
8PW3GM2PW7bPWwDl4wOO0PN4ow0AfhfDL+F9HTH2/lqEYBpvKy9MvTybVQ7YP6iV
Ef1ptj7kQCZxKek7lEivZAl1yQWhPPEBoiI4EEPS8T3jUfpsxJBeeA25CDaBh+sy
0mwrbSjWW0XsFeRgTLLce2u12P52TW50C0MwFDQ/v6A28oILMd+p+Oyb5Q0hhnym
2ygHKUbyvlQaOb4FdgfcbDeLPLoXx2Ry1Y6aidkwlYYsw+I/N6Q=
=ZE7v
-----END PGP SIGNATURE-----

--GVaFp4ugcyb3iLHa--

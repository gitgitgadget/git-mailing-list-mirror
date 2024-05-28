Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED83E487
	for <git@vger.kernel.org>; Tue, 28 May 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873247; cv=none; b=AGz0haG5l8ifWzc26blGaz8//63Zj0hdjz7oua5WnqbZAVtS0ynZIjywhxrqgals4n3+DUcybswzUorVnzP3BgZgwF/fGtVpRju3wGN9DCm35gMwS4oXB443ztjNMIBam46JdMMtucOxgy9M9830LrQfC/CnC30bqtnCJCEnwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873247; c=relaxed/simple;
	bh=MFviuKs5cWDAnRiDOExm3WSN9o4GL+FTZuOQgqj7Kxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liwMXaydCOVLG1rzyr3vreUHkIb0aXuS7v2dT77N54RkKMgzkvvNo0DeS6U0BPPSTPPgEqcAn9lZSiYyjS1vkfWJNaVTlzoM+OEdNFzCBiOcYM4aJJTvGNxpOaGg4zWHRlAORlEHXiIMKejnDtR02SpVbvVvrHNKqrKd8hgQTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ctFwUvjp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hn+ZTMte; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ctFwUvjp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hn+ZTMte"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id CDD7B1800121;
	Tue, 28 May 2024 01:14:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 May 2024 01:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716873244; x=1716959644; bh=xHyePdefSQ
	LKgQW0MdIibpC83p+0dn7toBNtJB1GBLE=; b=ctFwUvjpBnyzlUAAKlkSF268FX
	OCWnYfNxvU62qMUoiI/OISLLxjSpeIRNEqrFVNgRNZjwBelXOwenbV+zdbWUCIew
	QaziZJ1m0R0RBj+bV0KPEy8aShK8DPaR67YIU2n9IVUbe9G1j3fTbticCn5CF35p
	clwWimWHQoh44FMkCNnSpV6rmBJat47fcHAdRBDrdZHvTsWwlrwcAa1Ovif080A2
	cKdazEAHxie33p/SKUgq8ULLsyNm+oea48XHHoE82Z1jTXuZfa+f083DgIyHnDzo
	Z+quVQWiryjTvm8GLVxP9qNfpiNa1NtEY4e9h1Lyh3sZl3FLS0UovcNDWEDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716873244; x=1716959644; bh=xHyePdefSQLKgQW0MdIibpC83p+0
	dn7toBNtJB1GBLE=; b=hn+ZTMteopox8e/VxaZayC3WyHM5rpVnicgH20q05QLA
	T1nx/9J++OnI7WWzitJxZsU97MPG6Hy3LoofMkVnjaDonzJTGClPmPLc4dlRT+lA
	2uKgNTPMUXqS5nG2lxvyDbA28epg7mkNAkK6j9URKDg5N/HZVjhEL7evHNyimH0E
	msv64rj43+p9W+vPKBqi8LpaShFqI6KFqt7T5ywzsBbwfKkW5/Xzonk/PaIWS8OQ
	eVx/X1HvVjvWLXNGOd+7hlRYjQYgNgrCMEhIlODh3cnczYgvRLGqdUdwVBub/P2S
	F1nTGPm46TOwCdFmET/Rww5Eb5gXTEiF2Kn1p5U7sg==
X-ME-Sender: <xms:HGhVZp2UcC1o4yKqxYeGdwCXgXKLRk4R_k76PzEirEZYVDXRx0SW1g>
    <xme:HGhVZgFxJu2iI6snE75AZ97gSuo0bocRYzHBxX6AIWAyJt_QD4sAVPil92fwp4VXc
    lYh7Lj-lEdZSzVr8Q>
X-ME-Received: <xmr:HGhVZp5bMYW3EwsPVeh92DcBJBH0d3Sc4_0IMfISrPNmOy4uSzhU9YIXvklYiO3lrcsLjzfOFUnGmtd-do1Jp-BkagU4uCjjaAktfdcHm_bRPdh3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HGhVZm1i38xWKyVbz8VR8ugyej70uNTKGW7BTvVZLXRngmQ0viCUlw>
    <xmx:HGhVZsGaSmwybJQ86lBYzAcqKOdKMGj2Q9yvi0OaIhpxJPKmD6kA9A>
    <xmx:HGhVZn_mn6uE-KYe3CLiAb9s_Gh5MJ-JqZgzxz5X6rsz3va9-aEZLw>
    <xmx:HGhVZpnP3M382iDttdWYs1EA3XckFMAOsyEA4ZZLRxG5GEBxJha4_A>
    <xmx:HGhVZohYdQvhDFAYwPCPVhIGd8qY4h_17IQdEROWdDVisLpBhqBxovas>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 01:14:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 12567cb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 05:13:51 +0000 (UTC)
Date: Tue, 28 May 2024 07:14:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] refs: implement logic to migrate between ref
 storage formats
Message-ID: <ZlVoGVzTVb2-1NK0@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
 <4d3eb5ea896bffffbf28ab4865b69901cc9edee7.1716545235.git.ps@pks.im>
 <wt5hbn62kq6wvbbkkqxj2ev23cvybtcfxwygdcg5fjuhbmdwdx@azuetlk3jwgo>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4kekgoQ5sYnNQ/d"
Content-Disposition: inline
In-Reply-To: <wt5hbn62kq6wvbbkkqxj2ev23cvybtcfxwygdcg5fjuhbmdwdx@azuetlk3jwgo>


--t4kekgoQ5sYnNQ/d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:32:20PM -0500, Justin Tobler wrote:
> On 24/05/24 12:15PM, Patrick Steinhardt wrote:
[snip]
> > +	/*
> > +	 * The overall logic looks like this:
> > +	 *
> > +	 *   1. Set up a new temporary directory and initialize it with the n=
ew
> > +	 *      format. This is where all refs will be migrated into.
> > +	 *
> > +	 *   2. Enumerate all refs and write them into the new ref storage.
> > +	 *      This operation is safe as we do not yet modify the main
> > +	 *      repository.
> > +	 *
> > +	 *   3. If we're in dry-run mode then we are done and can hand over t=
he
> > +	 *      directory to the caller for inspection. If not, we now start
> > +	 *      with the destructive part.
> > +	 *
> > +	 *   4. Delete the old ref storage from disk. As we have a copy of re=
fs
> > +	 *      in the new ref storage it's okay(ish) if we now get interrupt=
ed
> > +	 *      as there is an equivalent copy of all refs available.
> > +	 *
> > +	 *   5. Move the new ref storage files into place.
> > +	 *
> > +	 *   6. Change the repository format to the new ref format.
> > +	 */
> > +	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
> > +	new_gitdir =3D mkdtemp(buf.buf);
> > +	if (!new_gitdir) {
> > +		strbuf_addf(errbuf, "cannot create migration directory: %s",
> > +			    strerror(errno));
> > +		ret =3D -1;
> > +		goto done;
> > +	}
>=20
> If the repository contains reflogs or has worktrees the migration does
> not proceed. This means that the created tempdir gets left behind with
> no indication and would be left to the user clean it up.
>=20
> Instead, we could move tempdir creation to after these checks so it is
> not needlessly created.

True, done.

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
> > +
> > +	/*
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
> [snip]
> > +	/*
> > +	 * Until now we were in the non-destructive phase, where we only
> > +	 * populated the new ref store. From hereon though we are about
> > +	 * to get hands by deleting the old ref store and then moving
> > +	 * the new one into place.
> > +	 *
> > +	 * Assuming that there were no concurrent writes, the new ref
> > +	 * store should have all information. So if we fail from hereon
> > +	 * we may be in an in-between state, but it would still be able
> > +	 * to recover by manually moving remaining files from the
> > +	 * temporary migration directory into place.
> > +	 */
>=20
> If there a failure after this point, should we provide a hint to user
> that the refernces exist in the tempdir?

Good idea.

Patrick

--t4kekgoQ5sYnNQ/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVaBgACgkQVbJhu7ck
PpQecA/9EcaWPTBhbCcKntPU47daSsGlSwP/PgBKBd2iSNiGNlggWgrjQICVCnig
nZIeRz4hE6FxHTANXww0eCD3bwXRllDOidOUulpS2gSBKuXJ5TdF3UuOSh0tc1k5
2DyZKN7mQr92pDmv9SB+LjlRITz57dBpt57OnW4rJDYrZiOJChq2OU2f50qQKaeO
gfuNLZ1KSvz4jIMPwM65M/GEykB/djNYzvz6lbje1O/+GWhOcruW9ZvOOlijTRNg
1xIBcoapsyzWQSxy88PGLs9RYxk3tW19H7Gxsndh4FF7u6DPv8x1UNB3kVSW5KZq
3ejgNHgu+gjr31+NahjK8IeQvRLCtsIDTFrhHSwVvhhl3XOg4HUYrwhqfO8FinOR
pT3hNYd7EbIH8oRtMg7r5Fiuv4Vt2Kc1/UX72jhNjyYZsCOPTcBviaUS3BkMZmnN
j3CLX2Gs/B1I7ZjuaF25/jCYFyyKV9y3nPSy4rNC79nQUXNJlw/yWUwdvLQN9vUE
ycy4GuoczEZaI1haabK4XQruL/1W63tOju2cVC7+kEnn8MRiAwjP0kZZAddrgZbn
hQI4ixaMlzlvP78r8w1TmGBXy1m4V284u0XT8v8cLkrahnq3s91nnOOORO/oQ+Lg
tgmIz34SNU9GEBFyHhd0eancspLcmCWmzQLxMjNyeVIdxOlps40=
=K/nM
-----END PGP SIGNATURE-----

--t4kekgoQ5sYnNQ/d--

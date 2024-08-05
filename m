Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E505155730
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859904; cv=none; b=VVeHGoCoXS4MXj2uC8/Ux0PC8tWJV54eEWeHOIGXII9opbRsaJt5Pv1hPq4Guzdj6oON/TVOTEobj147638mJf5fBzq5jvxrEBPiAfGhQv03DM5iiNZL2rgF0XNfmn8boaKWo5T54HPXwxN475oQbhQgARFVAfqiqu9DbmdUULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859904; c=relaxed/simple;
	bh=Pkj6wndSNn9rBRI5joUuIOEkD3IsSRNkdQgso9vmiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpGX16PuG2FTgK6MbTwdY8YsvRq9oFfgFhBxNAsYagoi0VnUbfB+dKJ5wTh8FRDuZrTb1FO5pVwY8C4yLlMAoIAFONyQdrf02uAlCdnYDV3hj4j04lPtqkBy9B7+NN1pY4aFEqYFoEEhLs160XbYRSw50/Lr8LJHHi8eUvWypYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=afvT+O3W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CY2VFwAY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="afvT+O3W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CY2VFwAY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 28F9D138FC64;
	Mon,  5 Aug 2024 08:11:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Aug 2024 08:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722859902; x=1722946302; bh=wI5VqlQQcQ
	bvhWf/vyNW2djC7mxv3Kgtr9+wmfcJ+ZE=; b=afvT+O3WEvL1RclxOdHGo68F6h
	ZbbI7QBU5P9vjvvUW/40QcV8tg6roftTg2FOT4YMheNsw12EKfenooWRekvJirCa
	zITk/3pnXR83ZF5JbaEO4ZiiF2SSCffpkbaiKfgudUPGt599xS2YTCLKEgV3FoyP
	+EnlGqYwCuXEZOv58Z6SfzZE+kviSn0E43mgI/UfC9P6sNLVHY82pZdKErJ0iJim
	V8syEJ8ajD+Sj7cUBIaz/Am1KX51WQrwosknuXDk4Froh/5Jovbh3yluR3NmFpyX
	gcW10c+S5EAoODRa15r27OddmLkH/zwmLQZMKbewGPwalHfbg0bFRAT501jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722859902; x=1722946302; bh=wI5VqlQQcQbvhWf/vyNW2djC7mxv
	3Kgtr9+wmfcJ+ZE=; b=CY2VFwAYoJxe4sjwUiSWxM9fr2GsvNVKQFRYCqSvu2Vs
	MnONJMTArwNfsd9N5XG7HpkSteLULr6LfzETFBUR5dMUt07Lxo2XbV9iJK9/E1HJ
	RMzsB0+hr3m+jClGxjmcTtJHztU61uil84sapz+zo13L21z/QypRgqOEu8IDeojp
	Gh007bF0N9LSJY7dD9eTEju5bVcJr4VD8AO8oLqYmlDtepVDKo7NSssBAtlU4za6
	w9ayFeC7qq8BN0lf8JmuhfdA0QRwV53xK7/3HVWwq9oWsJA+2p4t4iSgV9H1vXLT
	rBC5o+5QnhYMmfbiut1KRcTkzTgZ4t+s4E6Oz1MzQg==
X-ME-Sender: <xms:fsGwZnE6-A6Sfzs2P_cm_tcwjteNssnb9Ej8B-zjJ6RUglKts0ijNQ>
    <xme:fsGwZkWEVIqN3OKEJVvctyPB7Zw6KcMVmSxDuO3714Z6Iglk8rcOCt4IY9Te76UCz
    9C62Ro9ruGY20Teog>
X-ME-Received: <xmr:fsGwZpKnzpF8MGt4bC_uune6nB1iqrsiXnfjqmxLstaBaSaue-V08rQWM4oYc0CeKZAXGSCRm1y7SlgAitdcMdJuKysBThQiP-OCtZdeNn6ZZUr4jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:fsGwZlHxBRtamQynN_bpkYUvBSZVMItbqiEDcRbU-GvgtnBcn1s7EQ>
    <xmx:fsGwZtVJRsm_ReZ0mMhWg2wyTMC2_nsFNbCqoZe8oTD3Kw38OCEgAg>
    <xmx:fsGwZgNqhSBdFt2apZwi3kYjaPcRqDp7lNP_PoEOBqsTFwyqr6tCHg>
    <xmx:fsGwZs1mbn3pNN_d4oLB2e3iCcc4sLVJ4xPcF_DRy_kuEWlJRGWu7Q>
    <xmx:fsGwZqjcfk16DeVfvMw1vXaHlNM9PY4hp--GkLDVujo0nTh3gcPsj3cG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:11:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06864ed8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:11:40 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:11:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] reftable/stack: simplify tracking of table locks
Message-ID: <ZrDBet_24S4J8vhN@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <40d9f75cf20d4b76adb1683709e054e264d4e06f.1722435214.git.ps@pks.im>
 <xmqqy15e8r8b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gYcxdQRolriHpbBH"
Content-Disposition: inline
In-Reply-To: <xmqqy15e8r8b.fsf@gitster.g>


--gYcxdQRolriHpbBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 04:00:52PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -1192,8 +1192,8 @@ static int stack_compact_range(struct reftable_st=
ack *st,
> > =20
> >  done:
> >  	rollback_lock_file(&tables_list_lock);
> > -	for (i =3D first; table_locks && i <=3D last; i++)
> > -		rollback_lock_file(&table_locks[i - first]);
> > +	for (i =3D 0; table_locks && i < nlocks; i++)
> > +		rollback_lock_file(&table_locks[i]);
>=20
> This is a true bugfix, isn't it?  If we failed to create lock file
> somewhere in the middle, we used to still go ahead and attempted
> rollback_lock_file() on all of them.  Now we rollback only what we
> successfully called hold_lock_file_for_update().
>=20
> I wonder why nobody segfaulted where after a failed lock.  The
> answer probably is that lk->tempfile that is NULL will safely bypass
> most of the things because is_tempfile_active() would say "false" on
> such a lockfile.  But still it probably still were wrong to call
> rollback_lock_file() on a "struct lockfile" full of NUL-bytes, and
> it is good that we no longer do that.

I don't think it is. `table_locks` is an array of `struct lockfile` and
is allocated with calloc(3P), so we know that each uninitialized lock
will be all zeroes. For each uninitialized lock, `rollback_lock_file()`
calls `delete_tempfile(&lk->tempfile)`, which derefs the pointer and
thus essentially calls `!is_tempfile_active(lk->tempfile)`, and that
ultimately ends up checking whethere `tempfile` is a `NULL` pointer or
not. And as the structs were zero-initialized, it is a `NULL` pointer
and thus we bail out.

We also have tests that exercise this logic, so it also seems to be fine
in practice.

Patrick

--gYcxdQRolriHpbBH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawwXkACgkQVbJhu7ck
PpQz1w/+NJgWhJ90OxPQMnTZK9OnNK7AjI+UwI8pR5eQ8/ZN142cU7Al+zMsdEHC
zVjlGD57k1QkoLMth2uuPwj0VUmdi0074KNuOvAFbOGP4BTzL1a509q0hZCTxOUa
IxHh7ahda3PHOG+CVA+iLCy3OeTi3CeBQ3S/1EjMAe9rE7CW+O8wxsp4gi9JTVti
4hjNSPRjxRwHM0LHm/Ciz15V5r3N5F6kixT317+z7Cw1QxqsX5Vc3IaPb6dCfgsL
DuaTgJXL+5tyPqq3r3kWt/50Tdd9yul0NCEI+MOZ+rnf66lyujbrtsXEcz/gFwde
vRyHIMGyMqjXqIrjMJNwiCvt1ljCK3nHjObuvBvPxVJA30lLt4DBDb6xikNbRcnl
CS4gF6z24v72aI38PQ+dMMxvtbuB4xyYZNtWpDOEsrpEMK/TChtVltNzXxMQ70Dr
uP96JV4R/ywLnrX9PCgu6O1QbzHVbnTqDqP983cDMkMuA5c6SOe999qgfEtjiiOH
Lj219OavVB/YrZQtPC4jZa511J5WuODxh0/C1C4YgJxSzQWQLUYVsVYA3Qw4UAhI
F0qjUvz0vqzMbUQAjD0ZquecEkUu3O9/KTKem7NEh3e+dyhz+I0d2mQsn/vk3x3w
J2qRwaeG74WBDTlfZ7zoon728W4qcRWLaCCkAabb2mnLJwz9D40=
=q9nH
-----END PGP SIGNATURE-----

--gYcxdQRolriHpbBH--

Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB554672
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019587; cv=none; b=fhhvcO5M2F+41XymFNJN/fmzNZ0UH87mGz9tFS4FwxUYzCzDaUUAFaQH09868Ng3nNtVaTWxRiMZjoGADNL1n826BcNwTcvXT58Qr1qne9fcY4Q0Z2xvdKPyOLaHeGXABw2xEMTD7yqkMKxDKQ3ymbZUN5cFTgnSmPWSJDl5A2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019587; c=relaxed/simple;
	bh=O6Ofz7dUwX2dTSg6X0lYLmlePTwxjqfU/UZ9TrduW7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxcuffRzTy5wKtrAbgh7SZnlBJ6HyK2ci8GoUVPVhZ2StXTnBvj6QESJ7dNBP5k4ryPZ5m+jOC1yRzRYNLeXtX6GB7Swzcw3npoY8puFnG3GmIfs28PqgcIytpckKxFbWKmOJQf+Bl1BHlzLLPLWwZiBEK/1LsAQELJGoNuLg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OsN2ZOQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvQF5WpK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OsN2ZOQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvQF5WpK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D8AA211400B9;
	Tue, 27 Feb 2024 02:39:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Feb 2024 02:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709019583; x=1709105983; bh=w+QWYR85X6
	y7IA48fTWkGZVwpcX7YTVYRez1uZlWCts=; b=OsN2ZOQGWGWJbDDsUgbqu0i510
	W74VATQAIX+LfoYz/gVh6GiPLa/GGYNgeC2Zbk4r3J97IWoW2hXaxfFyxycBAXfl
	S5sCMd8FzNhfMLyn7b825MYJ5p0aGWTAD88RQJF3wGbW+XfR/zFOE/F5YZHXfkxy
	b8YHlQ/nkhxc5+dWiiLC34tU8b3jHwpF4dt3ak0E31v2VkO/UrB5C0+N6EmGJsYI
	tUrCTVbYhLfZ5OalohfOHznzsaG68ZumcBPNjXZIaCGQZsoxnzLTTcyjk81KqzlL
	jwABG012rkfgZ9UaQsz0lo377bzsIpIHd/4IOR/PXaZYPpIj65w6cul8cyBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709019583; x=1709105983; bh=w+QWYR85X6y7IA48fTWkGZVwpcX7
	YTVYRez1uZlWCts=; b=FvQF5WpK+lh5THw2UwJctB3KEebnE/emkBqlMbm78PU6
	Kuw8DDYr9Ef+qsZ4kiIqhgihcfFY9v41mzQMsBMnk7hB1eJsFyNiohvilAUGdF6i
	PajXCfeRJ7dWLPGIenTLrfOoqSNJPTju+3uYIGXGAb6jq8TJ3e6Q6IMpMf/R4TE2
	Fz891CZKE9iFnwbNizFdh0JVxcao5x+pnM34DB+kspirbUpHtBQfq596lYxHeCdh
	/1T+rTKkh00HAa0icsYlp+ocuxf7mzl9gcqqOj0cb6PLRZ2vJyXK4m+aOZ55vg2b
	gtyjPGKdWtyMsN6g7Yy94z6feh3mzJwx8NYyZFL+ZQ==
X-ME-Sender: <xms:v5HdZaN_vk7Q0H4cZz5FHJe9mGnMJdYb0Tsh9kJpG_ho39lKQ2k0YQ>
    <xme:v5HdZY_mAvrfykg6sULj7ahHwnoHZLbG_IAV80lg4zLA3cCaeTjBzKA3FIc1yspug
    aOGgqGMTeSiBXg4TA>
X-ME-Received: <xmr:v5HdZRT9lJMXlcirVsH-0EoMisu2bLW46v2ow9VddDxOng0JhvT9yGIHgcZGb7dahIxpP1u-OLgmGU9i9rzJvPPh_z4WLsAYNCuO_vONGf_Fwooe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:v5HdZaslI53DOglnhVflys_mTk5jBilz4etH-fLQzqd43RBopC3CVQ>
    <xmx:v5HdZSdwtrt0fm9xgrBg4QxODqDy4OeB7IgNW2HIT1UJjPXfLcaCqw>
    <xmx:v5HdZe1mS4wO__mgcEvDZ_QRacGA0__w7nbx6mEZtZ7__Zt1IedaYw>
    <xmx:v5HdZR4gh-Hp6letzeu8_DqxogkaiKt7oxttXGCmhFpr0fO9oR6BJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 02:39:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8aff23a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 07:35:25 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:39:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/5] for-each-ref: add '--include-root-refs' option
Message-ID: <Zd2Ru7LWYyGprvcr@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240223100112.44127-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z/tfvLpm3g9S7hG2"
Content-Disposition: inline
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com>


--z/tfvLpm3g9S7hG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:01:07AM +0100, Karthik Nayak wrote:
> This is the fifth version of my patch series to print root refs
> in git-for-each-ref(1).
>=20
> With the introduction of the reftable backend, it becomes ever
> so important to provide the necessary tooling for printing all refs
> associated with a worktree.
>=20
> While regular refs stored within the "refs/" namespace are currently
> supported by multiple commands like git-for-each-ref(1),
> git-show-ref(1). Neither support printing root refs within the worktree.
>=20
> This patch series is a follow up to the RFC/discussion we had earlier on
> the list [1].
>=20
> The first 4 commits add the required functionality to ensure we can print
> all refs (regular, pseudo, HEAD). The 5th commit modifies the
> git-for-each-ref(1) command to add the "--include-root-refs" command which
> will include HEAD and pseudorefs with regular "refs/" refs.
>=20
> [1]: https://lore.kernel.org/git/20231221170715.110565-1-karthik.188@gmai=
l.com/#t
>=20
> Changes from v4:
> 1. Fixed erratic whitespace
> 2. Remove braces from single line block
> 3. Starting the comments with a capital and also adding more context.
> 4. Removed a duplicate check.
>=20
> Thanks for the reviews.
>=20
> Range diff against v4:

The range-diff looks as expected, so this patch series looks good to me.
Thanks!

Patrick

> 1:  98130a7ad7 ! 1:  6016042965 refs: introduce `is_pseudoref()` and `is_=
headref()`
>     @@ refs.c: static int is_pseudoref_syntax(const char *refname)
>      +
>      +	if (ends_with(refname, "_HEAD")) {
>      +		refs_resolve_ref_unsafe(refs, refname,
>     -+   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>     -+   					&oid, NULL);
>     -+   		return !is_null_oid(&oid);
>     ++					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>     ++					&oid, NULL);
>     ++		return !is_null_oid(&oid);
>      +	}
>      +
>      +	for (i =3D 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
>      +		if (!strcmp(refname, irregular_pseudorefs[i])) {
>      +			refs_resolve_ref_unsafe(refs, refname,
>     -+   						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>     -+   						&oid, NULL);
>     ++						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>     ++						&oid, NULL);
>      +			return !is_null_oid(&oid);
>      +		}
>      +
> 2:  060ab08af5 =3D 2:  acaa014841 refs: extract out `loose_fill_ref_dir_r=
egular_file()`
> 3:  40d2375ad9 =3D 3:  f51c5bc307 refs: introduce `refs_for_each_include_=
root_refs()`
> 4:  b4b9435505 =3D 4:  7c004db6e7 ref-filter: rename 'FILTER_REFS_ALL' to=
 'FILTER_REFS_REGULAR'
> 5:  ee99ac41ae ! 5:  53f6c0a6db for-each-ref: add new option to include r=
oot refs
>     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char =
**argv, const
>       		filter.name_patterns =3D argv;
>       	}
>      =20
>     -+	if (include_root_refs) {
>     ++	if (include_root_refs)
>      +		flags |=3D FILTER_REFS_ROOT_REFS;
>     -+	}
>      +
>       	filter.match_as_path =3D 1;
>      -	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &for=
mat);
>     @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_fi=
lter *filter,
>       				       void *cb_data)
>       {
>      +	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK) {
>     -+		/* in this case, we want to print all refs including root refs. */
>     ++		/* In this case, we want to print all refs including root refs. */
>      +		return refs_for_each_include_root_refs(get_main_ref_store(the_rep=
ository),
>      +						       cb, cb_data);
>      +	}
>     @@ ref-filter.c: static struct ref_array_item *apply_ref_filter(const=
 char *refname
>      =20
>       	/* Obtain the current ref kind from filter_ref_kind() and ignore u=
nwanted refs. */
>       	kind =3D filter_ref_kind(filter, refname);
>     +-	if (!(kind & filter->kind))
>      +
>      +	/*
>     -+	 * When printing HEAD with all other refs, we want to apply the sa=
me formatting
>     -+	 * rules as the other refs, so we simply ask it to be treated as a=
 pseudoref.
>     ++	 * Generally HEAD refs are printed with special description denoti=
ng a rebase,
>     ++	 * detached state and so forth. This is useful when only printing =
the HEAD ref
>     ++	 * But when it is being printed along with other pseudorefs, it ma=
kes sense to
>     ++	 * keep the formatting consistent. So we mask the type to act like=
 a pseudoref.
>      +	 */
>      +	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK && kind =3D=3D FILTE=
R_REFS_DETACHED_HEAD)
>      +		kind =3D FILTER_REFS_PSEUDOREFS;
>      +	else if (!(kind & filter->kind))
>     -+		return NULL;
>     -+
>     - 	if (!(kind & filter->kind))
>       		return NULL;
>      =20
>     + 	if (!filter_pattern_match(filter, refname))
>      @@ ref-filter.c: static int do_filter_refs(struct ref_filter *filter=
, unsigned int type, each_ref
>       			ret =3D for_each_fullref_in("refs/tags/", fn, cb_data);
>       		else if (filter->kind & FILTER_REFS_REGULAR)
>=20
>=20
> Karthik Nayak (5):
>   refs: introduce `is_pseudoref()` and `is_headref()`
>   refs: extract out `loose_fill_ref_dir_regular_file()`
>   refs: introduce `refs_for_each_include_root_refs()`
>   ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
>   for-each-ref: add new option to include root refs
>=20
>  Documentation/git-for-each-ref.txt |   5 +-
>  builtin/for-each-ref.c             |  10 ++-
>  ref-filter.c                       |  30 ++++++-
>  ref-filter.h                       |   7 +-
>  refs.c                             |  48 +++++++++++
>  refs.h                             |   9 ++
>  refs/files-backend.c               | 127 +++++++++++++++++++++--------
>  refs/refs-internal.h               |   6 ++
>  refs/reftable-backend.c            |  11 ++-
>  t/t6302-for-each-ref-filter.sh     |  31 +++++++
>  10 files changed, 237 insertions(+), 47 deletions(-)
>=20
> --=20
> 2.43.GIT
>=20

--z/tfvLpm3g9S7hG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdkboACgkQVbJhu7ck
PpQ+oxAAkPQJx8hI31IDS8VHdV4WbgVIIV98fOmdTZR2/gv0uKSOvbomVG7chk4F
s183kndYah/mMmsYbLxtpQJVq93uXuwqsDxPmeXS12JAl4zGXPGZcXQigcvI/XyT
cnqJda1cnunY5XtBqfxdTDuB/tZ3kNmAhL/PDVG/Yyjzb1v97dWF0MYp8Hvc0Du2
i08C/1iz0WaXqHUnt4oV5UdhtUCh9BdFzJoAT6Z1hOmS0zpr6ZX0vS2Ww5wzxrtA
Dyd/48DtMdA4Yv6qrkS9IzINRDnZdQaLz9FocfPXeoFm1eSPOL2QbqGWoppYu++6
ZwailXiteRwgRsuVGf+hqEUoj6KDVXlhyMhD16PKLqxXsMn1IbcFEX9qoN6xG2oq
+/jhlCJ/mJdwUio3R9Nss3J9EjKPZoVvmZyKj3SXjAZnVW2h8BkOOgg5YIbXV6zC
U8yUHW7W90dMt3eD/I7dmTL5m2V0rQoWy6arQCOoAWqP4hjQnR8+xVDcxKmEF6wd
/NNqZiRBFGLcHKSjjPgHQcM8MYVijg93bCWlMRBXQMuGN/XgzYxlB7MJyiTK+3hk
fbgLVoq/iTxnatdiOKidGhy+c3cn8sApeglp/9mXPpc1IbB8VbXZgZNxcwNQygSP
Uv+sQmxWPg9CGUcAZdug/WOdz+q5CNTMuaUK/3AFqO4Eq5fl7QE=
=LiWI
-----END PGP SIGNATURE-----

--z/tfvLpm3g9S7hG2--

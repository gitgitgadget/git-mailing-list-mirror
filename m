Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FD2BB18
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591575; cv=none; b=u7XHIxdjqY75pRXpLiFjojC8BCTwJij/90lzR8e85aCFuzvTJp9DASW6nx434RR+hAZeDESVuT6o8gluBfI8AhSXSaio8GMh6YQ3HaQXGY8myyNlK6MMdtMtaTEGIQ6RaIwUwmyTHfMzaYPSNTrH8g/z3DRGCVKdSN15jZM2vq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591575; c=relaxed/simple;
	bh=gvcQZ5ZK/Qd0rcCrAGAHnSIDEKUmOchrC9v4JH5UkOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgXXgIWvPQsKeI6eqyHVS+jSAr4eB9XOYESaZRY8BOTZqUR6LRH5ssSyqBWHHXfPbI5Et5Z2+q6TYQLBWC12Bu0rEy9xBsnLDlyKZ0E0GsLjltvQFJM/u+W/+OSWm3MPx0491mjBc4NF9y7aHZks7MlB/3kOBzuoQLFncrnNMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iM4VTdae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e83Bb13/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iM4VTdae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e83Bb13/"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF69113800C5;
	Thu, 22 Feb 2024 03:46:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 22 Feb 2024 03:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708591571; x=1708677971; bh=037t3gLK91
	C/iS0I3HX83lK0AFRy//82ZkXx4PIlG0w=; b=iM4VTdaeVzSA34I2/w3xiKuPE1
	uL6IeFZdbcqcidPcCGrjia+nS9UQ1HfDYZcTTx8lzT6B8ewVWrnw/PnaKCTkLepr
	KtUIoFb01f/QsPMVfLK5sjp/NKj7KMUsJF+UyFZ9dCpxmpTymoeGNVoQ02img8iF
	QQJtFmzGcHJEVjpSy2pdPYFb/pqAPy26IiyqvFr/H4Ql5Muhn3OFlmT79K7DGWue
	Yr978YVzhk1aDovSEiWeDkE47vCj86UUzx5WanxRioIIvpOXR3LlI8gLMnCxSVCY
	oDBUBk2slQiXVP2L6UboGMaYGfz/Qe5gstR4DtFrUI0UzrM0LsRB96+awfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708591571; x=1708677971; bh=037t3gLK91C/iS0I3HX83lK0AFRy
	//82ZkXx4PIlG0w=; b=e83Bb13/xT1/L62GdZ20Xn4mE+F3Ly+Jg7Wdp36NNdaq
	3+Z/JznvNadnlJ3MURRmrwULWqj15AgWLQvQrVsrHFDqoYB3qaiFukmVTJ6u1Oi7
	zsmMmxY9oR0SPzg6SCIlp/6HnwadedBXRDDJ1RTnUvq2TdaMSgAQsFljDpn/grh7
	2XfyEYK0OnwGVMFt//xJ25/jJ0L4P3kHoAN7vwnkxvmvXtAJUazBx68bt31td8I1
	a/DNbeR25FMtKhhgmGf9E9oNlNk3K5OcWgTpTqmzCfFd79ccNcrQziGkKu2TUPGa
	+A9T6Hx7Eo3otCd9NBA2dCqaWs5PxEIn891oX6m0kg==
X-ME-Sender: <xms:0wnXZXClxl_pMBXw6Gf7k3mELjgYgxFIoPMjVHNVJPSR-gVV4lYWTQ>
    <xme:0wnXZdgsbSsDRPkiWsXDWXxRnASuMKQhzQb8p7LBzxA23TbUecFqMmCHA-5nYC3pI
    994bgcTWIoXWzlZYw>
X-ME-Received: <xmr:0wnXZSmARjJkcZSCxfN8ej3mZWohUSI6TUAULcBHxaPXmW62GB62pjsu5s4FdoVzpkn50YIl77M8yguVFCB8JP94CVlZgLzggAL0Fr_78ZciENna>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0wnXZZzT2LfUkseWk-aJpBxG5pz4eivfTR4TauKPQVv_Opf-xGe8mA>
    <xmx:0wnXZcQFhK0chEezCdy6c3xE3DlpfpCJYEsvo-r9I2Y46Vwzj-cvZQ>
    <xmx:0wnXZcYo-0dPMYh-132QwDpiOcICl88L0iqhS7gRdhHS_0M4xLyZyg>
    <xmx:0wnXZSNHmsC5RT_fufY7Hh3Ho7qlhn1Pr_K4Yz6atF_wP1F8wWpuxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 03:46:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 460a1992 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 08:42:02 +0000 (UTC)
Date: Thu, 22 Feb 2024 09:46:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 5/5] for-each-ref: add new option to include root refs
Message-ID: <ZdcJzs2vNkHJsjyN@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
 <20240211183923.131278-6-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pBuBtXGud9BqXRkZ"
Content-Disposition: inline
In-Reply-To: <20240211183923.131278-6-karthik.188@gmail.com>


--pBuBtXGud9BqXRkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 07:39:23PM +0100, Karthik Nayak wrote:
> The git-for-each-ref(1) command doesn't provide a way to print root refs
> i.e pseudorefs and HEAD with the regular "refs/" prefixed refs.
>=20
> This commit adds a new option "--include-root-refs" to
> git-for-each-ref(1). When used this would also print pseudorefs and HEAD
> for the current worktree.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  5 ++++-
>  builtin/for-each-ref.c             | 11 ++++++++---
>  ref-filter.c                       | 27 +++++++++++++++++++++++++-
>  ref-filter.h                       |  5 ++++-
>  refs/reftable-backend.c            | 11 +++++++----
>  t/t6302-for-each-ref-filter.sh     | 31 ++++++++++++++++++++++++++++++
>  6 files changed, 80 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-e=
ach-ref.txt
> index 3a9ad91b7a..c1dd12b93c 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=3D<key>)...] [--format=3D<format>]
> -		   [ --stdin | <pattern>... ]
> +		   [--include-root-refs] [ --stdin | <pattern>... ]
>  		   [--points-at=3D<object>]
>  		   [--merged[=3D<object>]] [--no-merged[=3D<object>]]
>  		   [--contains[=3D<object>]] [--no-contains[=3D<object>]]
> @@ -105,6 +105,9 @@ TAB %(refname)`.
>  	any excluded pattern(s) are shown. Matching is done using the
>  	same rules as `<pattern>` above.
> =20
> +--include-root-refs::
> +	List root refs (HEAD and pseudorefs) apart from regular refs.
> +
>  FIELD NAMES
>  -----------
> =20
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 23d352e371..9ed146dad3 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -20,10 +20,10 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
>  {
>  	struct ref_sorting *sorting;
>  	struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
> -	int icase =3D 0;
> +	int icase =3D 0, include_root_refs =3D 0, from_stdin =3D 0;
>  	struct ref_filter filter =3D REF_FILTER_INIT;
>  	struct ref_format format =3D REF_FORMAT_INIT;
> -	int from_stdin =3D 0;
> +	unsigned int flags =3D FILTER_REFS_REGULAR;
>  	struct strvec vec =3D STRVEC_INIT;
> =20
>  	struct option opts[] =3D {
> @@ -53,6 +53,7 @@ int cmd_for_each_ref(int argc, const char **argv, const=
 char *prefix)
>  		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't con=
tain the commit")),
>  		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case =
insensitive")),
>  		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from std=
in")),
> +		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include =
HEAD ref and pseudorefs")),
>  		OPT_END(),
>  	};
> =20
> @@ -96,8 +97,12 @@ int cmd_for_each_ref(int argc, const char **argv, cons=
t char *prefix)
>  		filter.name_patterns =3D argv;
>  	}
> =20
> +	if (include_root_refs) {
> +		flags |=3D FILTER_REFS_ROOT_REFS;
> +	}

Nit: we don't use braces for single-line blocks.

> +
>  	filter.match_as_path =3D 1;
> -	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
> +	filter_and_format_refs(&filter, flags, sorting, &format);
> =20
>  	ref_filter_clear(&filter);
>  	ref_sorting_release(sorting);
> diff --git a/ref-filter.c b/ref-filter.c
> index acb960e35c..0e83e29390 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2628,6 +2628,12 @@ static int for_each_fullref_in_pattern(struct ref_=
filter *filter,
>  				       each_ref_fn cb,
>  				       void *cb_data)
>  {
> +	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK) {
> +		/* in this case, we want to print all refs including root refs. */

Nit: s/in/In, as this is a full sentence.

> +		return refs_for_each_include_root_refs(get_main_ref_store(the_reposito=
ry),
> +						       cb, cb_data);
> +	}
> +
>  	if (!filter->match_as_path) {
>  		/*
>  		 * in this case, the patterns are applied after
> @@ -2750,6 +2756,9 @@ static int ref_kind_from_refname(const char *refnam=
e)
>  			return ref_kind[i].kind;
>  	}
> =20
> +	if (is_pseudoref(get_main_ref_store(the_repository), refname))
> +		return FILTER_REFS_PSEUDOREFS;
> +
>  	return FILTER_REFS_OTHERS;
>  }
> =20
> @@ -2781,6 +2790,16 @@ static struct ref_array_item *apply_ref_filter(con=
st char *refname, const struct
> =20
>  	/* Obtain the current ref kind from filter_ref_kind() and ignore unwant=
ed refs. */
>  	kind =3D filter_ref_kind(filter, refname);
> +
> +	/*
> +	 * When printing HEAD with all other refs, we want to apply the same fo=
rmatting
> +	 * rules as the other refs, so we simply ask it to be treated as a pseu=
doref.
> +	 */
> +	if (filter->kind =3D=3D FILTER_REFS_KIND_MASK && kind =3D=3D FILTER_REF=
S_DETACHED_HEAD)
> +		kind =3D FILTER_REFS_PSEUDOREFS;

I'm not sure why exactly we need to munge the kind here. Would be great
if the comment explained what the actual difference would be.

> +	else if (!(kind & filter->kind))
> +		return NULL;
> +
>  	if (!(kind & filter->kind))
>  		return NULL;

This condition here is duplicated now, isn't it?

Patrick

> @@ -3049,7 +3068,13 @@ static int do_filter_refs(struct ref_filter *filte=
r, unsigned int type, each_ref
>  			ret =3D for_each_fullref_in("refs/tags/", fn, cb_data);
>  		else if (filter->kind & FILTER_REFS_REGULAR)
>  			ret =3D for_each_fullref_in_pattern(filter, fn, cb_data);
> -		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
> +
> +		/*
> +		 * When printing all ref types, HEAD is already included,
> +		 * so we don't want to print HEAD again.
> +		 */
> +		if (!ret && (filter->kind !=3D FILTER_REFS_KIND_MASK) &&
> +		    (filter->kind & FILTER_REFS_DETACHED_HEAD))
>  			head_ref(fn, cb_data);
>  	}
> =20
> diff --git a/ref-filter.h b/ref-filter.h
> index 5416936800..0ca28d2bba 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -22,7 +22,10 @@
>  #define FILTER_REFS_REGULAR        (FILTER_REFS_TAGS | FILTER_REFS_BRANC=
HES | \
>  				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
>  #define FILTER_REFS_DETACHED_HEAD  0x0020
> -#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DE=
TACHED_HEAD)
> +#define FILTER_REFS_PSEUDOREFS     0x0040
> +#define FILTER_REFS_ROOT_REFS      (FILTER_REFS_DETACHED_HEAD | FILTER_R=
EFS_PSEUDOREFS)
> +#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DE=
TACHED_HEAD | \
> +				    FILTER_REFS_PSEUDOREFS)
> =20
>  struct atom_value;
>  struct ref_sorting;
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index a14f2ad7f4..c23a516ac2 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -364,12 +364,15 @@ static int reftable_ref_iterator_advance(struct ref=
_iterator *ref_iterator)
>  			break;
> =20
>  		/*
> -		 * The files backend only lists references contained in
> -		 * "refs/". We emulate the same behaviour here and thus skip
> -		 * all references that don't start with this prefix.
> +		 * The files backend only lists references contained in "refs/" unless
> +		 * the root refs are to be included. We emulate the same behaviour her=
e.
>  		 */
> -		if (!starts_with(iter->ref.refname, "refs/"))
> +		if (!starts_with(iter->ref.refname, "refs/") &&
> +		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
> +		     (is_pseudoref(&iter->refs->base, iter->ref.refname) ||
> +		      is_headref(&iter->refs->base, iter->ref.refname)))) {
>  			continue;
> +		}
> =20
>  		if (iter->prefix &&
>  		    strncmp(iter->prefix, iter->ref.refname, strlen(iter->prefix))) {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter=
=2Esh
> index 82f3d1ea0f..948f1bb5f4 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -31,6 +31,37 @@ test_expect_success 'setup some history and refs' '
>  	git update-ref refs/odd/spot main
>  '
> =20
> +test_expect_success '--include-root-refs pattern prints pseudorefs' '
> +	cat >expect <<-\EOF &&
> +	HEAD
> +	ORIG_HEAD
> +	refs/heads/main
> +	refs/heads/side
> +	refs/odd/spot
> +	refs/tags/annotated-tag
> +	refs/tags/doubly-annotated-tag
> +	refs/tags/doubly-signed-tag
> +	refs/tags/four
> +	refs/tags/one
> +	refs/tags/signed-tag
> +	refs/tags/three
> +	refs/tags/two
> +	EOF
> +	git update-ref ORIG_HEAD main &&
> +	git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--include-root-refs with other patterns' '
> +	cat >expect <<-\EOF &&
> +	HEAD
> +	ORIG_HEAD
> +	EOF
> +	git update-ref ORIG_HEAD main &&
> +	git for-each-ref --format=3D"%(refname)" --include-root-refs "*HEAD" >a=
ctual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'filtering with --points-at' '
>  	cat >expect <<-\EOF &&
>  	refs/heads/main
> --=20
> 2.43.GIT
>=20

--pBuBtXGud9BqXRkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXCc0ACgkQVbJhu7ck
PpRjcBAAqdyESyjrhVq47C/s+M5rsXLuXZCOKn0uwOgGXtRPOLAdhhSndlkdeJp9
CXGRhKH/os2W8D4LBtULDGpiHxSHitjx0/odxzpZbyrdalZIyM2EjN1ktyluYC6Z
69WE14RptZo0JoZknQgyYkKkhFdssAlygT8wnHp48idZtT8SVzKZAOgsbZm1ZJ67
HPMuoSHsbtmXgBsTMlQDkyRwhZp0dvoQ1XGaHC2DvX/cFkU154E9LiOSyd+2LtEq
am+DWC6O6PYTU2VDS+HGrrc6F5dWF8bA3hERNSNur8IephRMTRusdPBGtXgz91y8
RI/3PL4JI7YrD9fd3Y8cF1UwwpNMEfuYVm+JEAzPEgzz78aCMarzSj5suFxR4UWk
9+WRwn1V6GNJjsNig/uDLrT1uQDtSOETiznlGrMYWAX4YF1ekOgg+kwmEJeFQWRN
EHGD9tx9WfadB6OnKFmnn1ybzS0gk3a0SRfDsijo2q+yKN0i1DVO8rlL3vCds60j
ItogZjWpnl9SPS+gc0Qma3j4vxvArzdvCy++HgKwur+bWDlQM4HuP3m3IPqYPdMH
sZOYkS7/ncCdfxClj3kMF3XpPecnN8h9UWsFdbKZEQhZZ6obfpkE1tQGGLf0KLXA
HeN5762PgfcA/gf59aK6D7BE5W2K07J4KyVUlAJpD/Ihexp3Jis=
=6P7K
-----END PGP SIGNATURE-----

--pBuBtXGud9BqXRkZ--

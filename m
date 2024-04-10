Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4713AA54
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731991; cv=none; b=IGU/Ehb/DeL54LdUzJQaaXOFMldnbNg9VrtgQaDDyh9a4fUxG7Uq5K9NuvkBMEIuaxdXnHLVXADLIrSOb+Z2dQHoav/7ZP4PTOaUHqzsvQ0K/ShywAJ7GHHf5VnbfOTQueZ42INfLGgho1o38e1uPGYi+9jqxLbtU4YjmXFOGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731991; c=relaxed/simple;
	bh=//5jlXTGEkFNo1xDM4zcmx4U/NfVWWxAltSj5fbFZ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXYvQ8qyDCvGyQw5uRYLSvAv1MPNo2o/1e8d43NJjpfLaYR6ptgTkfosax/fcGeCxUc4EtbJhHDa9zoM6xoIAL3NMnDQ2ibabdnKTINztbbiV+trKc1VDXSapXnBw1sv5c7YKgvSqnkL139ioef+AAvWJ+dLbZgUpWWgWuVYKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Srf2QK8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyWVg4Ff; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Srf2QK8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyWVg4Ff"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C5159114017A;
	Wed, 10 Apr 2024 02:53:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2024 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712731988; x=1712818388; bh=inyltezKa9
	pKb+QDusMkRQSwIGjtNFNleWS+RMq5WJA=; b=Srf2QK8pBni1u/i4q40Z7RecQo
	QZ9Q/6Ut5qHLMcp6wjIYeWvhp3p0zT3mESPP0OZzFEIy4l7UV25eZk0YlFoyTWXC
	gCSjOQ8ZPvvtwJsCXbEK7VVO6ba5PsppxybZTOZAlrKUC8yLq1I/jjj4bEYCZxAc
	bdy36ZueeHD259jjCrGmXGBmbF8MYlVke8WhVTfsq/ckgVfaudlQ0P9xHYm6V/BL
	H6Tame7DfyNUAAq6hCjDFkm16hMz+jWXken/kUmMAL7ppTiQ4tsbPbAIfOhw95PI
	lXx/w6r7MwVARct6zuwj05PCzyxPc5+pulGsUftsxY1sM3Ih1aos9x/BBGVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712731988; x=1712818388; bh=inyltezKa9pKb+QDusMkRQSwIGjt
	NFNleWS+RMq5WJA=; b=dyWVg4Ffs268fOjfEgevwAi1/x3Vq8568JGc9L2HzJvt
	LScNWOZ7jcyn5EdiODNSVsgulHQWWlWq1k/1DJpkGVaquV1btLh3dgRrEd/MNuND
	NeFtaiFLngvt7QV2WN5crGAngWLJnoJ267nmldRHGJDEmvUpgRWVvMd/fzIK7p/k
	35cFj5TTSuB+TkxzAW693TAzK5Donw+FNh1Qa3KQoTULWlEy598C9INlabqtuE4Z
	6vRv9zsNtvMbT7zoO+a5Dmw6U0G4NOBmNPxsWHx5snEaRUTs1cxWlfaD2W7ScMT+
	5Ybut4nTz6UlR9L4+MjqO5JfsFuIccwo2LYs3VZx2A==
X-ME-Sender: <xms:VDcWZhs4YPdoN2-dEcPY59xfX6U6CyVVpubYpViJZywHgRudXWkakg>
    <xme:VDcWZqdBOjG82mKZDvjyU3NFHcmfEj0OwKMxGo57thkhIk91N-LMJ5_YboTL8GkTe
    RK4uOKpOhfVWA2BVw>
X-ME-Received: <xmr:VDcWZkxWHpwbm-XH5Qqef6lJT9JthhGO_xaXPZd4t_p1CRfV0WizUR0tV0vE4LV8VyNwhzkOGbjkNN9zhf4gDVE9uxMEJHzPWPLWxeNNHHG48zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:VDcWZoNyZnVQ3OUnwHptntT0mCjmwEfjiKbsflNegrgK6r-rGKwvVQ>
    <xmx:VDcWZh84iG7D3ixemKRl-RL3MWYkVKHFV_TLUJofDS436NE7npJfEA>
    <xmx:VDcWZoVb5pGzw_MHHUk2s8RW6-287V8fFBP0AtK3UIGBu_LlfwB_MA>
    <xmx:VDcWZicHiDzV5G2RbqwD3b57MsrePzl7agjEVv0lqzUvAj6FO825nQ>
    <xmx:VDcWZqODY0ZxLdsrjiqcRGKW7cTQbrramThTs8Vap5wmvEOz-mACLMMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 02:53:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6ce435a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 06:52:57 +0000 (UTC)
Date: Wed, 10 Apr 2024 08:53:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
Message-ID: <ZhY3UCwJeMcG4fH1@tanuki>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8/Tu3ZBExhAGAOL"
Content-Disposition: inline
In-Reply-To: <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>


--K8/Tu3ZBExhAGAOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 05:38:13PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> For reftable development, it would be handy to have a tool to provide
> the direct value of any ref whether it be a symbolic ref or not.
> Currently there is git-symbolic-ref, which only works for symbolic refs,
> and git-rev-parse, which will resolve the ref. Let's teach show-ref a
> --symbolic-name option that will cause git-show-ref(1) to print out the
> value symbolic references points to.

I think it was Peff who shared a way to achieve this without actually
introducing a new option via `git for-each-ref --format=3D`. Can we maybe
provide some benchmarks to demonstrate that this variant is preferable
over what's already possible?

Patrick

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/git-show-ref.txt | 21 ++++++++++++++++++-
>  builtin/show-ref.c             | 38 ++++++++++++++++++++++++----------
>  refs.c                         |  6 ++++++
>  refs.h                         |  2 +-
>  t/t1403-show-ref.sh            | 20 ++++++++++++++++++
>  5 files changed, 74 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.=
txt
> index ba757470059..9627b34b37f 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git show-ref' [--head] [-d | --dereference]
>  	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
> -	     [--heads] [--] [<pattern>...]
> +	     [--heads] [--symbolic-name] [--] [<pattern>...]
>  'git show-ref' --verify [-q | --quiet] [-d | --dereference]
>  	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
>  	     [--] [<ref>...]
> @@ -58,6 +58,11 @@ OPTIONS
>  	Dereference tags into object IDs as well. They will be shown with `^{}`
>  	appended.
> =20
> +--symbolic-name::
> +
> +	Print out the value the reference points to without dereferencing. This
> +	is useful to know the reference that a symbolic ref is pointing to.
> +
>  -s::
>  --hash[=3D<n>]::
> =20
> @@ -146,6 +151,20 @@ $ git show-ref --heads --hash
>  ...
>  ------------------------------------------------------------------------=
-----
> =20
> +When using `--symbolic-name`, the output is in the format:
> +
> +-----------
> +<oid> SP <ref> SP <symbolic-name>
> +-----------
> +
> +For example,
> +
> +------------------------------------------------------------------------=
-----
> +$ git show-ref --symbolic-name
> +b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:ref=
s/heads/main
> +...
> +------------------------------------------------------------------------=
-----
> +
>  EXAMPLES
>  --------
> =20
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 1c15421e600..1d681505eac 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -12,7 +12,7 @@
>  static const char * const show_ref_usage[] =3D {
>  	N_("git show-ref [--head] [-d | --dereference]\n"
>  	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
> -	   "             [--heads] [--] [<pattern>...]"),
> +	   "             [--heads] [--symbolic-name] [--] [<pattern>...]"),
>  	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
>  	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
>  	   "             [--] [<ref>...]"),
> @@ -26,10 +26,13 @@ struct show_one_options {
>  	int hash_only;
>  	int abbrev;
>  	int deref_tags;
> +	int symbolic_name;
>  };
> =20
>  static void show_one(const struct show_one_options *opts,
> -		     const char *refname, const struct object_id *oid)
> +		     const char *refname,
> +		     const char *referent,
> +		     const struct object_id *oid, const int is_symref)
>  {
>  	const char *hex;
>  	struct object_id peeled;
> @@ -44,7 +47,9 @@ static void show_one(const struct show_one_options *opt=
s,
>  	hex =3D repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
>  	if (opts->hash_only)
>  		printf("%s\n", hex);
> -	else
> +	else if (opts->symbolic_name & is_symref) {
> +		printf("%s %s ref:%s\n", hex, refname, referent);
> +	} else
>  		printf("%s %s\n", hex, refname);
> =20
>  	if (!opts->deref_tags)
> @@ -63,8 +68,11 @@ struct show_ref_data {
>  	int show_head;
>  };
> =20
> -static int show_ref(const char *refname, const struct object_id *oid,
> -		    int flag UNUSED, void *cbdata)
> +static int show_ref_referent(struct repository *repo UNUSED,
> +			     const char *refname,
> +			     const char *referent,
> +			     const struct object_id *oid,
> +			     int flag, void *cbdata)
>  {
>  	struct show_ref_data *data =3D cbdata;
> =20
> @@ -91,11 +99,17 @@ static int show_ref(const char *refname, const struct=
 object_id *oid,
>  match:
>  	data->found_match++;
> =20
> -	show_one(data->show_one_opts, refname, oid);
> +	show_one(data->show_one_opts, refname, referent, oid, flag & REF_ISSYMR=
EF);
> =20
>  	return 0;
>  }
> =20
> +static int show_ref(const char *refname, const struct object_id *oid,
> +		    int flag, void *cbdata)
> +{
> +	return show_ref_referent(NULL, refname, NULL, oid, flag, cbdata);
> +}
> +
>  static int add_existing(const char *refname,
>  			const struct object_id *oid UNUSED,
>  			int flag UNUSED, void *cbdata)
> @@ -171,10 +185,11 @@ static int cmd_show_ref__verify(const struct show_o=
ne_options *show_one_opts,
> =20
>  	while (*refs) {
>  		struct object_id oid;
> +		int flags =3D 0;
> =20
>  		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
> -		    !read_ref(*refs, &oid)) {
> -			show_one(show_one_opts, *refs, &oid);
> +		    !read_ref_full(*refs, 0, &oid, &flags)) {
> +			show_one(show_one_opts, *refs, NULL, &oid, flags & REF_ISSYMREF);
>  		}
>  		else if (!show_one_opts->quiet)
>  			die("'%s' - not a valid ref", *refs);
> @@ -208,11 +223,11 @@ static int cmd_show_ref__patterns(const struct patt=
erns_options *opts,
>  		head_ref(show_ref, &show_ref_data);
>  	if (opts->heads_only || opts->tags_only) {
>  		if (opts->heads_only)
> -			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
> +			for_each_ref_all("refs/heads/", show_ref_referent, &show_ref_data);
>  		if (opts->tags_only)
> -			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
> +			for_each_ref_all("refs/tags/", show_ref_referent, &show_ref_data);
>  	} else {
> -		for_each_ref(show_ref, &show_ref_data);
> +		for_each_ref_all("", show_ref_referent, &show_ref_data);
>  	}
>  	if (!show_ref_data.found_match)
>  		return 1;
> @@ -289,6 +304,7 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
>  		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can =
be combined with heads)")),
>  		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (c=
an be combined with tags)")),
>  		OPT_BOOL(0, "exists", &exists, N_("check for reference existence witho=
ut resolving")),
> +		OPT_BOOL(0, "symbolic-name", &show_one_opts.symbolic_name, N_("print o=
ut symbolic reference values")),
>  		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
>  			    "requires exact ref path")),
>  		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
> diff --git a/refs.c b/refs.c
> index 77ae38ea214..9488ad9594d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1734,6 +1734,12 @@ int for_each_replace_ref(struct repository *r, eac=
h_repo_ref_fn fn, void *cb_dat
>  				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
>  }
> =20
> +int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_d=
ata)
> +{
> +	return do_for_each_repo_ref(the_repository, prefix, fn, 0,
> +				    0, cb_data);
> +}
> +
>  int for_each_namespaced_ref(const char **exclude_patterns,
>  			    each_ref_fn fn, void *cb_data)
>  {
> diff --git a/refs.h b/refs.h
> index 23e5aaba2e9..54b459375be 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -337,7 +337,6 @@ int refs_for_each_branch_ref(struct ref_store *refs,
>  			     each_ref_fn fn, void *cb_data);
>  int refs_for_each_remote_ref(struct ref_store *refs,
>  			     each_ref_fn fn, void *cb_data);
> -
>  /* just iterates the head ref. */
>  int head_ref(each_ref_fn fn, void *cb_data);
> =20
> @@ -381,6 +380,7 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data);
>  int for_each_branch_ref(each_ref_fn fn, void *cb_data);
>  int for_each_remote_ref(each_ref_fn fn, void *cb_data);
>  int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void=
 *cb_data);
> +int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_d=
ata);
> =20
>  /* iterates all refs that match the specified glob pattern. */
>  int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data=
);
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 33fb7a38fff..0aebe709dca 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -286,4 +286,24 @@ test_expect_success '--exists with existing special =
ref' '
>  	git show-ref --exists FETCH_HEAD
>  '
> =20
> +test_expect_success '--symbolic-name with a non symbolic ref' '
> +	commit_oid=3D$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANC=
H_NAME) &&
> +	cat >expect <<-EOF &&
> +	$commit_oid refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +	EOF
> +	git show-ref --symbolic-name refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANC=
H_NAME >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--symbolic-name with symbolic ref' '
> +	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &&
> +	commit_oid=3D$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANC=
H_NAME) &&
> +	cat >expect <<-EOF &&
> +	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAULT_=
INITIAL_BRANCH_NAME
> +	EOF
> +	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT=
_INITIAL_BRANCH_NAME &&
> +	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --=20
> gitgitgadget

--K8/Tu3ZBExhAGAOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWN08ACgkQVbJhu7ck
PpSFYBAAhxoUlI5rvRbQPa+ohBucAagutNX2jf1Pngs3ZmrvGPmmiq8u+Di61UGR
9BaIkjwBBzGbWHuJuOsbdkmELxE3sbGegZeEFBfTbKZBwXgfTHCPZIPhF+c8lOVe
ZLR6UWgwdfWF5xIx13m4ygiJl1YCg65NN6zhb3w2gC577r5g06GRGzQwU8vD/Skt
YEH+e6Kh5i2QC+k9dVXrt9pZ4dAPgAoAk6UF//1HKLeM/2xc4qhVXi6MhodotpAL
c0eZ5rtUpRNYosYz28WedDQK4vDwfd+yZsv3bNZYT/HVf18PmF5+gwqZfDgLUbBx
DKIPgLrur5Y/lunDm5fFTOllFWuwAWUJ9HAzhazXJ1Y5fTNB3WLDRHmYudyzXz9U
KheO4m2t03qJ6HYcHIna6HegHaLTD1+qyVLiZBoRwl4KhX/GCgauIrwa8baCVtjH
lPTMEg4Gz9tFQy96lgsiRpKp5bWYaQRmBvhLXh2AF2KHqoPR6xLN35PTo4S82CN8
JZ5p29bjqZpgSIEGo6XbwkVoaFoBAanzJBJzfhBDTGKey35+JwVG4Uq10w9AVKae
+TlWmJHQgTusYwRhTlXwJJS1Cy1LkDGy8vA6JNZyqIA0ai3N010TUJzDGD59msUY
wzoHocx3rCkqvXff/o+D8V3PdxV0a88dGKsnYUwK/xL2vp4SBQU=
=JIAq
-----END PGP SIGNATURE-----

--K8/Tu3ZBExhAGAOL--

Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438831BF28
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989601; cv=none; b=l9igyAQXPI2dozpN+qbmM/ODvViKXz9mtbFZXc5i7+Q8SCambVs6jtd5wQR2JXLHY2AjHaoETdMP/eNlkqGHoWuwv1CwFd5TrUwz6fl+LB6LBrZ9UnICRKkCdvv434gKH5ySp5bgIO6pAfB+fl+e0Iiw1lTEwZ620L8q67DIOUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989601; c=relaxed/simple;
	bh=Pz5DTC/EnparsDdJi15palOwXAywIzB2VTdB9jcU0d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAp33fz6B42WHBQNNY9uo8ofMnSdVrwOYdqqPyCpVfVjcyS2uIF9gvRY9xf/6R/O1N43bPQD7psrkATe9JRlO6M3BxC1W0VUN1uen7037bU5r21H/lxAzJbATsSc6Hqf7cghi0ARmqmu95Q1Y36CUVYbOJ+IgZuzju1ZlSfUwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ke/djXJK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NViPoxnv; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ke/djXJK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NViPoxnv"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6E0945C00BC;
	Thu, 15 Feb 2024 04:33:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 04:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989598; x=1708075998; bh=RV/UrvHFGh
	YPErz7zgrlItFYEjrwvFKXtGoT1qmbSks=; b=Ke/djXJKo/d5gvToZmnwCTo2GO
	fuzDk47FMkTe/Pxmu5FJOACUfcya3ulTewgULG5VWdW4moZleLnpLSX13wDJGK3i
	axf0WJ9+oqTSnDEMWF15Nd6aLHLBU8DwlUvNb5PSUJn92HwNQiXv3vBt7PYySa31
	0YqXxLh5Iw3CyiCrbP9k7OM5bfcU6OE/+zCDFJ0M1NcPlf7baUwCGR62KssOLFyq
	38CtkLNcjIFeUec//QEjVREnhs1d1Z8XL7hTTb99JCx7uwjsSQLNLmBI2kwoRulE
	/XY1YmqJj+NSU+Ot+b1Op51+PD34vkIbDekd1MDuF0vh39kiYm2nObkG/30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989598; x=1708075998; bh=RV/UrvHFGhYPErz7zgrlItFYEjrw
	vFKXtGoT1qmbSks=; b=NViPoxnv0DZZLw4ZKhGNnUo4ZNv4F9FHW+eRc3rswgEI
	Dl0nlDIZBlFoyegIMg+7eMWCNp2wcfhu+GWltaFQgYk0IEOMKvpeZ68yJpmQbfOW
	v7BUQpa2vaQcZhqxSAWDLrT/Lig7N12t5M4/1hekjoovrHESTaDsjqhy7r9LBYgc
	xTiqf6+/RDUuh8CK2lXKPDwryAw+66pycM6/3ASfdJXesnCWjD6DK2jkpuCgicJD
	h+WTgMSkw53N6NxFh04FYQ1yKm6Tfh0xZ+9KL/BJs7NVMUr00fgfy/UsKNQ1jYYx
	MkV6Jgx9682tgLlkvlgxyEcfy6OEhxOwReg2Va82Pg==
X-ME-Sender: <xms:XtrNZWqtuGCqWloX4muLe_Gr7yEJSGVUnc1WSt3V4btXRaBoEM4CnQ>
    <xme:XtrNZUouHSz7l_I89S-fv8UvtaFWh8QwBDvZRByy2LDpGNGfRd7m2w-XwZEpQ1hVf
    xUWQBKfCmnOk6PyEA>
X-ME-Received: <xmr:XtrNZbOJm8_rhr5HBQZLhyjLIMkIpK3RTBcAZ3tOGMKJJdAyGI6DUG4kqs6jyX5Z_ra1Q57tIHPearwXqBfTzf2kC5WFXHdn4m_lenX9umhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:XtrNZV7f15LBaPy__Q-xRc-qmVzIsM8ieClsPdTcscXv00pBUtpn7w>
    <xmx:XtrNZV5ThCNmOPBwBz7jS7iEX6E8UTTaILWMHLMGVI3-ExjDesLC4w>
    <xmx:XtrNZViPzOHcv5qwHffGqdiC4370IM_fEQALB2jw0g9HxUoJVB-TTA>
    <xmx:XtrNZVEuN-9Sr6nH9nPFfUeQTka7wDuIsdVPxoh2CwSYMFYF52ByQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:33:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0a3a19c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:29:25 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:33:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/12] Let `repo_in_merge_bases()` report missing commits
Message-ID: <Zc3aWzeRXFm1E2O_@tanuki>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
 <5f0af7fc0b95f9539ba7f740cb805ff1638d14cc.1707813709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X38eSQbqGcUE6A1k"
Content-Disposition: inline
In-Reply-To: <5f0af7fc0b95f9539ba7f740cb805ff1638d14cc.1707813709.git.gitgitgadget@gmail.com>


--X38eSQbqGcUE6A1k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:41:38AM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
[snip]
> diff --git a/http-push.c b/http-push.c
> index a704f490fdb..85fa2f457d4 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1576,8 +1576,11 @@ static int verify_merge_base(struct object_id *hea=
d_oid, struct ref *remote)
>  	struct commit *head =3D lookup_commit_or_die(head_oid, "HEAD");
>  	struct commit *branch =3D lookup_commit_or_die(&remote->old_oid,
>  						     remote->name);
> +	int i =3D repo_in_merge_bases(the_repository, branch, head);
> =20
> -	return repo_in_merge_bases(the_repository, branch, head);
> +	if (i < 0)
> +		exit(128);
> +	return i;

Nit: it's a bit unusual that we use `i` here instead of `ret`. Not worth
a reroll on its own though.

>  }
> =20
>  static int delete_remote_branch(const char *pattern, int force)
> diff --git a/merge-ort.c b/merge-ort.c
> index 6491070d965..64e76afe89f 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -544,6 +544,7 @@ enum conflict_and_info_types {
>  	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
>  	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
>  	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
> +	CONFLICT_SUBMODULE_CORRUPT,
> =20
>  	/* Keep this entry _last_ in the list */
>  	NB_CONFLICT_TYPES,
> @@ -596,7 +597,9 @@ static const char *type_short_descriptions[] =3D {
>  	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =3D
>  		"CONFLICT (submodule may have rewinds)",
>  	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =3D
> -		"CONFLICT (submodule lacks merge base)"
> +		"CONFLICT (submodule lacks merge base)",
> +	[CONFLICT_SUBMODULE_CORRUPT] =3D
> +		"CONFLICT (submodule corrupt)"
>  };
> =20
>  struct logical_conflict_info {
> @@ -1710,7 +1713,11 @@ static int find_first_merges(struct repository *re=
po,
>  		die("revision walk setup failed");
>  	while ((commit =3D get_revision(&revs)) !=3D NULL) {
>  		struct object *o =3D &(commit->object);
> -		if (repo_in_merge_bases(repo, b, commit))
> +		int ret =3D repo_in_merge_bases(repo, b, commit);
> +
> +		if (ret < 0)
> +			return ret;

This is leaking both `merges` and `revs`.

> +		if (ret > 0)
>  			add_object_array(o, NULL, &merges);
>  	}
>  	reset_revision_walk();
> @@ -1725,9 +1732,14 @@ static int find_first_merges(struct repository *re=
po,
>  		contains_another =3D 0;
>  		for (j =3D 0; j < merges.nr; j++) {
>  			struct commit *m2 =3D (struct commit *) merges.objects[j].item;
> -			if (i !=3D j && repo_in_merge_bases(repo, m2, m1)) {
> -				contains_another =3D 1;
> -				break;
> +			if (i !=3D j) {
> +				int ret =3D repo_in_merge_bases(repo, m2, m1);
> +				if (ret < 0)
> +					return ret;
> +				if (ret > 0) {
> +					contains_another =3D 1;
> +					break;
> +				}
>  			}
>  		}
> =20
> @@ -1749,7 +1761,7 @@ static int merge_submodule(struct merge_options *op=
t,
>  {
>  	struct repository subrepo;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	int ret =3D 0;
> +	int ret =3D 0, ret2;
>  	struct commit *commit_o, *commit_a, *commit_b;
>  	int parent_count;
>  	struct object_array merges;
> @@ -1796,8 +1808,26 @@ static int merge_submodule(struct merge_options *o=
pt,
>  	}
> =20
>  	/* check whether both changes are forward */
> -	if (!repo_in_merge_bases(&subrepo, commit_o, commit_a) ||
> -	    !repo_in_merge_bases(&subrepo, commit_o, commit_b)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_o, commit_a);
> +	if (ret2 < 1) {
> +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s "
> +			   "(repository corrupt)"),
> +			 path);
> +		goto cleanup;
> +	}

Is `if (ret2 < 1)` intentional? I doubt it is, because it would also
trigger for `ret2 =3D=3D 0`, which we try to explicitly handle in the next
line. So the following condition `if (!ret2)` cannot ever be true.

> +	if (!ret2)
> +		ret2 =3D repo_in_merge_bases(&subrepo, commit_o, commit_b);
> +	if (ret2 < 1) {
> +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s "
> +			   "(repository corrupt)"),
> +			 path);
> +		goto cleanup;
> +	}

Same here.

> +	if (!ret2) {
>  		path_msg(opt, CONFLICT_SUBMODULE_MAY_HAVE_REWINDS, 0,
>  			 path, NULL, NULL, NULL,
>  			 _("Failed to merge submodule %s "
> @@ -1807,7 +1837,16 @@ static int merge_submodule(struct merge_options *o=
pt,
>  	}
> =20
>  	/* Case #1: a is contained in b or vice versa */
> -	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_a, commit_b);
> +	if (ret2 < 0) {
> +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s "
> +			   "(repository corrupt)"),
> +			 path);
> +		goto cleanup;
> +	}
> +	if (ret2 > 0) {
>  		oidcpy(result, b);
>  		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
>  			 path, NULL, NULL, NULL,
> @@ -1816,7 +1855,16 @@ static int merge_submodule(struct merge_options *o=
pt,
>  		ret =3D 1;
>  		goto cleanup;
>  	}
> -	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_b, commit_a);
> +	if (ret2 < 0) {
> +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s "
> +			   "(repository corrupt)"),
> +			 path);
> +		goto cleanup;
> +	}
> +	if (ret2 > 0) {
>  		oidcpy(result, a);
>  		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
>  			 path, NULL, NULL, NULL,
> @@ -1841,6 +1889,13 @@ static int merge_submodule(struct merge_options *o=
pt,
>  	parent_count =3D find_first_merges(&subrepo, path, commit_a, commit_b,
>  					 &merges);
>  	switch (parent_count) {
> +	case -1:
> +		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
> +			 path, NULL, NULL, NULL,
> +			 _("Failed to merge submodule %s "
> +			   "(repository corrupt)"),
> +			 path);
> +		break;

I was wondering whether it is safe to `break` here because we do end up
calling `object_array_clear()` on `merges` which we didn't initialize in
this function. But `find_first_merges()` always initializes the array
with zeroes, so this is fine.

>  	case 0:
>  		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE, 0,
>  			 path, NULL, NULL, NULL,
> diff --git a/merge-recursive.c b/merge-recursive.c
> index e3beb0801b1..e3fe7803cbe 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1144,7 +1144,10 @@ static int find_first_merges(struct repository *re=
po,
>  		die("revision walk setup failed");
>  	while ((commit =3D get_revision(&revs)) !=3D NULL) {
>  		struct object *o =3D &(commit->object);
> -		if (repo_in_merge_bases(repo, b, commit))
> +		int ret =3D repo_in_merge_bases(repo, b, commit);
> +		if (ret < 0)
> +			return ret;

We also leak `merges` and `revs` here.

Patrick

> +		if (ret)
>  			add_object_array(o, NULL, &merges);
>  	}
>  	reset_revision_walk();
> @@ -1159,9 +1162,14 @@ static int find_first_merges(struct repository *re=
po,
>  		contains_another =3D 0;
>  		for (j =3D 0; j < merges.nr; j++) {
>  			struct commit *m2 =3D (struct commit *) merges.objects[j].item;
> -			if (i !=3D j && repo_in_merge_bases(repo, m2, m1)) {
> -				contains_another =3D 1;
> -				break;
> +			if (i !=3D j) {
> +				int ret =3D repo_in_merge_bases(repo, m2, m1);
> +				if (ret < 0)
> +					return ret;
> +				if (ret > 0) {
> +					contains_another =3D 1;
> +					break;
> +				}
>  			}
>  		}
> =20
> @@ -1197,7 +1205,7 @@ static int merge_submodule(struct merge_options *op=
t,
>  			   const struct object_id *b)
>  {
>  	struct repository subrepo;
> -	int ret =3D 0;
> +	int ret =3D 0, ret2;
>  	struct commit *commit_base, *commit_a, *commit_b;
>  	int parent_count;
>  	struct object_array merges;
> @@ -1234,14 +1242,29 @@ static int merge_submodule(struct merge_options *=
opt,
>  	}
> =20
>  	/* check whether both changes are forward */
> -	if (!repo_in_merge_bases(&subrepo, commit_base, commit_a) ||
> -	    !repo_in_merge_bases(&subrepo, commit_base, commit_b)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_base, commit_a);
> +	if (ret2 < 0) {
> +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"),=
 path);
> +		goto cleanup;
> +	}
> +	if (ret2)
> +		ret2 =3D repo_in_merge_bases(&subrepo, commit_base, commit_b);
> +	if (ret2 < 0) {
> +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"),=
 path);
> +		goto cleanup;
> +	}
> +	if (!ret2) {
>  		output(opt, 1, _("Failed to merge submodule %s (commits don't follow m=
erge-base)"), path);
>  		goto cleanup;
>  	}
> =20
>  	/* Case #1: a is contained in b or vice versa */
> -	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_a, commit_b);
> +	if (ret2 < 0) {
> +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"),=
 path);
> +		goto cleanup;
> +	}
> +	if (ret2) {
>  		oidcpy(result, b);
>  		if (show(opt, 3)) {
>  			output(opt, 3, _("Fast-forwarding submodule %s to the following commi=
t:"), path);
> @@ -1254,7 +1277,12 @@ static int merge_submodule(struct merge_options *o=
pt,
>  		ret =3D 1;
>  		goto cleanup;
>  	}
> -	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
> +	ret2 =3D repo_in_merge_bases(&subrepo, commit_b, commit_a);
> +	if (ret2 < 0) {
> +		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"),=
 path);
> +		goto cleanup;
> +	}
> +	if (ret2) {
>  		oidcpy(result, a);
>  		if (show(opt, 3)) {
>  			output(opt, 3, _("Fast-forwarding submodule %s to the following commi=
t:"), path);
> @@ -1402,6 +1430,8 @@ static int merge_mode_and_contents(struct merge_opt=
ions *opt,
>  							&o->oid,
>  							&a->oid,
>  							&b->oid);
> +			if (result->clean < 0)
> +				return -1;
>  		} else if (S_ISLNK(a->mode)) {
>  			switch (opt->recursive_variant) {
>  			case MERGE_VARIANT_NORMAL:
> diff --git a/shallow.c b/shallow.c
> index ac728cdd778..cf4b95114b7 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -795,12 +795,16 @@ static void post_assign_shallow(struct shallow_info=
 *info,
>  		if (!*bitmap)
>  			continue;
>  		for (j =3D 0; j < bitmap_nr; j++)
> -			if (bitmap[0][j] &&
> -			    /* Step 7, reachability test at commit level */
> -			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
> -				update_refstatus(ref_status, info->ref->nr, *bitmap);
> -				dst++;
> -				break;
> +			if (bitmap[0][j]) {
> +				/* Step 7, reachability test at commit level */
> +				int ret =3D repo_in_merge_bases_many(the_repository, c, ca.nr, ca.co=
mmits);
> +				if (ret < 0)
> +					exit(128);
> +				if (!ret) {
> +					update_refstatus(ref_status, info->ref->nr, *bitmap);
> +					dst++;
> +					break;
> +				}
>  			}
>  	}
>  	info->nr_ours =3D dst;
> @@ -829,6 +833,8 @@ int delayed_reachability_test(struct shallow_info *si=
, int c)
>  							    commit,
>  							    si->nr_commits,
>  							    si->commits);
> +		if (si->reachable[c] < 0)
> +			exit(128);
>  		si->need_reachability_test[c] =3D 0;
>  	}
>  	return si->reachable[c];
> --=20
> gitgitgadget
>=20
>=20

--X38eSQbqGcUE6A1k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2loACgkQVbJhu7ck
PpRWmA//aSJVXEvmXbZ0ZX/dpi/jOHvL7/YvoqDkR2uI2Cf46lx/hkOsEqeh7MCn
xIHpMfxeB3+3bwUrb6TgLshR661NIgFgBzFw/fsQPXv9ud3iUwF7/U7g9B00VifQ
y7nFYzSiyhY5xAS3JJlGs9MkrdvvxZLotz3dJVfEBC7tDYxRtKiuG5mHWEUcX4v8
0XBnTY8tDNRNKXT6C0T6W54SGe2AFMU4bfUamM0ycBIIKNGZ9xTZkKRp4bf4S1lX
FdOShpPmJeSAmtECZ0rKzluo1+7OkbN/ZxLZ0ewglaSznXK6QY/Qa+0ci5gt2kmx
/vwAXQSAQin9ustX+ZVvU5lRyHip3goS7s3wfWPuLgfuQhKEyuIxkGFS1F29msLC
vvUBZk5c7o6xE6XCSpzb2pGvp8tUBLy9ctGMS9y1f9jf2Os0oZfYIAkk0KiOBueC
zBQjiXWfBpYWgsuTqyV1C4zfWJ7PQxg/h6QTRBg058SBnEpLVvvF8xTV5fBMOaoF
iDShD/khj0+G4pBMDRMmaMq82ztDdVFdgRVqUtkRyz3OqNxgEApszsmFGpFgSopo
/1yEBkrZnfpVCtI6SdZDGzeDtLwMeBmWpcg4STkO2SJpMtyga3hWVRiH9JDzzJTo
3TG7YV+3VgY/k6U2SGJNZDITvgjA5cKKNOIExkJmwdUSVgt6Vr8=
=qvU9
-----END PGP SIGNATURE-----

--X38eSQbqGcUE6A1k--

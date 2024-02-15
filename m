Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D112AAE5
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996126; cv=none; b=HJh0gA+EtDlPtsYKc8jjJ16qXVfLl1cMP6DU5Fl7vdcWYNFoNsdvn7h0x64Fimap8lu46AuF6KeigLvQSZF8tgjNo7eipAY6ReLE7PaJvfNMlsAsKsnKiT4CYQuDU1fZFd31Gmrg3GTFHKIxrghyIx43aO8JZuZeHWHLgd5xYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996126; c=relaxed/simple;
	bh=QCLxVzUW6YwwKlUsagfyYdICB07zV+tsT57enpnbCHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWqwGI7MX0oIKKOSYsf2ecIrdrtI/C3au+bmd+7SJdEYiAxdgzJl1TsRx2TyvDQovkRjPUK99EpPJVh9IZ+CJjMEyuOmlOPMdR3F2Th4tkiYJKC9AwvmL5xY4gQHC5oDz27gAaWBT+NugDENhNqu47QvCYzEb1ej9BcaCmfGWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkh+qVb3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxF7/r3U; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkh+qVb3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxF7/r3U"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6200A13800CE;
	Thu, 15 Feb 2024 06:22:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 06:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996123; x=1708082523; bh=KIJJ59hjWi
	KKMCRH1IdVaygVkr1yIj7HSFmrwS2XDdI=; b=nkh+qVb317IWziGenePinJiWPj
	dLNNBHeiIWBooBUhhOGWvOy9vkOsPMfLRJN+XCrW5H3DQ12tI4UDju5VVpoRKVMN
	NRijAi45yxFpBNzJrZvYqL3c932+0Q7iVWMkpTp8b51wBp7wf/Xer7oQlZPnK4g9
	Xth6P+0DI4pI7CK2nh41B9CHtYVrC2rW4Enn8lzrQDGQr5OS3XbCgrYVnu8KQeBr
	xD/ytyFXXPxcfgZ4xFITLseQL63qVTrGqP3IA8gsNt/Wph1F8FuYYxOIeM7jsFxI
	DgJD0YnUxhEF7xC0cPGaypGyijTkkAOZcnslwgWDOplnpUc598+nd6STdmlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996123; x=1708082523; bh=KIJJ59hjWiKKMCRH1IdVaygVkr1y
	Ij7HSFmrwS2XDdI=; b=dxF7/r3U12EIVJLEkD5PCyZMs6IW/vP3PyRJQbKnkruA
	Pb1Su8Uwt06/YAiY6n8v/M1ZZ8ye6MrlWV+v/WhASRedmztcpBMb4yNPQ128T14u
	wi2Sn0O3FhgE6uUfyb5T3Xlo39teaHHAfxALgkWNHltnPQYnjzC8CV0tDqjYwJgJ
	Y07vcgZZOdaRWYP1I2JohkytJxcGxGoxwTjpbQEP7MTW439mnA4FeK1RbJxPr19V
	4ghUY+tIg4/jfZxa4lodupOwiB13hRbVpHNwS46RCx0TrrhGC0nIZTK1F99iqZgm
	fP7XsB1NpftXYjoX47HJeyDpj512oyK09M2QjmzVHg==
X-ME-Sender: <xms:2_PNZWjG8WCquDly-eQcrX9_CF5lBFg2Mrg2uVHBA2ULQ3onzTyctA>
    <xme:2_PNZXAGCd-AyjfQpzQldTy80cVnrN3hZi-isXuoZQIZlpzOx4eDH2Y82suB1eJx2
    mdwHZ9WSl-1u1ZBJQ>
X-ME-Received: <xmr:2_PNZeG1QBm4CC5DOKxwaITsLBweW77ApCe8NeF0Y67rCWFzEAnYUWNmg9XuOoJSkcUDOjlBsQhiPMG6w4Oz9GSBps0hcteB2rAeOSSCNIE3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:2_PNZfQCRfIFV8FhqRVku1_wtA9ihp_FZM1IZhXKYnVVqsJjUHC57g>
    <xmx:2_PNZTw-PbUEQ78UJHwtNQ5-mWf7wPILcpD-VptbdZsBgnbtr9Lidg>
    <xmx:2_PNZd4DNBnENe8dLAcEx9t3k5pPhx4bk40vGCG1KOhj15UTXW6Dtw>
    <xmx:2_PNZamVfRNw6JNFaP_BHuGPHvWV4Ls9HM77p6r5ygEpGJNo_0VWQA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:22:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6e55461 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:09 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:22:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 04/30] repository: add a compatibility hash algorithm
Message-ID: <Zc3z2F7r2oMSlOW-@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-4-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogKb1uTUzkJZrsAU"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-4-ebiederm@gmail.com>


--ogKb1uTUzkJZrsAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:08PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> We currently have support for using a full stage 4 SHA-256
> implementation.

What is a "full stage 4 SHA-256 implementation"? I was assuming that you
referred to "Documentation/technical/hash-function-transition.txt", but
it does not mention stages either.

> However, we'd like to support interoperability with
> SHA-1 repositories as well.  The transition plan anticipates a
> compatibility hash algorithm configuration option that we can use to
> implement support for this.  Let's add an element to the repository
> structure that indicates the compatibility hash algorithm so we can use
> it when we need to consider interoperability between algorithms.
>=20
> Add a helper function repo_set_compat_hash_algo that takes a
> compatibility hash algorithm and sets "repo->compat_hash_algo".  If
> GIT_HASH_UNKNOWN is passed as the compatibility hash algorithm
> "repo->compat_hash_algo" is set to NULL.
>=20
> For now, the code results in "repo->compat_hash_algo" always being set
> to NULL, but that will change once a configuration option is added.
>=20
> Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  repository.c | 8 ++++++++
>  repository.h | 4 ++++
>  setup.c      | 3 +++
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/repository.c b/repository.c
> index a7679ceeaa45..80252b79e93e 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -104,6 +104,13 @@ void repo_set_hash_algo(struct repository *repo, int=
 hash_algo)
>  	repo->hash_algo =3D &hash_algos[hash_algo];
>  }
> =20
> +void repo_set_compat_hash_algo(struct repository *repo, int algo)
> +{
> +	if (hash_algo_by_ptr(repo->hash_algo) =3D=3D algo)
> +		BUG("hash_algo and compat_hash_algo match");
> +	repo->compat_hash_algo =3D algo ? &hash_algos[algo] : NULL;
> +}
> +
>  /*
>   * Attempt to resolve and set the provided 'gitdir' for repository 'repo=
'.
>   * Return 0 upon success and a non-zero value upon failure.
> @@ -184,6 +191,7 @@ int repo_init(struct repository *repo,
>  		goto error;
> =20
>  	repo_set_hash_algo(repo, format.hash_algo);
> +	repo_set_compat_hash_algo(repo, GIT_HASH_UNKNOWN);
>  	repo->repository_format_worktree_config =3D format.worktree_config;
> =20
>  	/* take ownership of format.partial_clone */
> diff --git a/repository.h b/repository.h
> index 5f18486f6465..bf3fc601cc53 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -160,6 +160,9 @@ struct repository {
>  	/* Repository's current hash algorithm, as serialized on disk. */
>  	const struct git_hash_algo *hash_algo;
> =20
> +	/* Repository's compatibility hash algorithm. */
> +	const struct git_hash_algo *compat_hash_algo;
> +
>  	/* A unique-id for tracing purposes. */
>  	int trace2_repo_id;
> =20
> @@ -199,6 +202,7 @@ void repo_set_gitdir(struct repository *repo, const c=
har *root,
>  		     const struct set_gitdir_args *extra_args);
>  void repo_set_worktree(struct repository *repo, const char *path);
>  void repo_set_hash_algo(struct repository *repo, int algo);
> +void repo_set_compat_hash_algo(struct repository *repo, int compat_algo);
>  void initialize_the_repository(void);
>  RESULT_MUST_BE_USED
>  int repo_init(struct repository *r, const char *gitdir, const char *work=
tree);
> diff --git a/setup.c b/setup.c
> index 18927a847b86..aa8bf5da5226 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1564,6 +1564,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
>  		}
>  		if (startup_info->have_repository) {
>  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +			repo_set_compat_hash_algo(the_repository,
> +						  GIT_HASH_UNKNOWN);
>  			the_repository->repository_format_worktree_config =3D
>  				repo_fmt.worktree_config;
>  			/* take ownership of repo_fmt.partial_clone */
> @@ -1657,6 +1659,7 @@ void check_repository_format(struct repository_form=
at *fmt)
>  	check_repository_format_gently(get_git_dir(), fmt, NULL);
>  	startup_info->have_repository =3D 1;
>  	repo_set_hash_algo(the_repository, fmt->hash_algo);
> +	repo_set_compat_hash_algo(the_repository, GIT_HASH_UNKNOWN);
>  	the_repository->repository_format_worktree_config =3D
>  		fmt->worktree_config;
>  	the_repository->repository_format_partial_clone =3D

There's also `init_db()`, where we call `repo_set_hash_algo()`. Would we
have to call `repo_set_compat_hash_algo()` there, too? There are some
other locations when handling remotes or clones, but I don't think those
are relevant right now.

Patrick

--ogKb1uTUzkJZrsAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN89cACgkQVbJhu7ck
PpQKqA//dwj6UUcyO4xrmihJBUFT1GowTvWZfyMauJtr0DKYCZPyiaiGgw4mUBO6
feom9EwZLZTJvsPq1/sTllNI6sCvyBMiiwqfQhgyAgWqbWAC+8ZCtSo2eRtT79VF
oAXqnzD33+P08Rq9mk4s6q4ztw9k/ULj25qR4U8djCp/5L+kxsw1lh+rGqIfw2E4
qvUwx/CN4BNICTTVxotjqvpck6Sfkn9klL/pdXoiAtM5h/RCTNQ1rvFaNROJ4k3v
x8DvKOdjzFy4swwhacnOQzlQoNnJHZCNRJvu2SHo1GjtApBLJP0s8KTC7stqZbU1
RSkorRn2YbZ2rUWCBKGijENATbkxl9+aI5PM9g6Uc7PfuegT8WzSrIzAw9TCfjI+
oblkaPM5kGaxHRF2fUClARUfpmn/AayaR2KE5Ax47bgEAiG/t0WT1+OA0RR8M2d/
YsVKexSXtUBZsdn9hnIW82QbGl+ZtcsqviOhafww8pceHTgXtSj4C9MFvL8UbU9y
TzGEczZxbAW1/jhKR5q60ojqu+Ki05PrE7QtuYsH6e+SuL6P9shtJ9c9/xMd2qGj
abCoy3LQSFdqp+FNu9Evi67wbnnZbsKO93bJzrHmV5ku5CeN1x0wthu3QpTXaoXg
P7J3qxVLswqpR/V3PfbI5L5heNna+qkHhyvgWM/GehmmSinASZM=
=f8rM
-----END PGP SIGNATURE-----

--ogKb1uTUzkJZrsAU--

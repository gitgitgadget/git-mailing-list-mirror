Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75A39FE0
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742070; cv=none; b=Y0XSb+zgcsVWcye6dTDXEXb/qZSazX+kOHfB4M27wtlevlFtC5h3P6/rgG6esvqYjeQ54AxQiDGkZ4CeSBHNnnJwtgno3fZe/cpdfTkRMiQz4aFnH4KHcbpIzzRDpAiaWRdU/Cvz04z6nYF0fvnPcdUl3S00hsL54d0zhp+wSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742070; c=relaxed/simple;
	bh=x7hcePkU1Wb7vcIFk3rdyFFfoJHky2jHEu/zQMQOoYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoGFqKGgkc2XnfExsdMnYI/IxZ0qSGOEgBk4mVWdx7UbT8Wpjo2Ybcd2GBrE4F4UbNWz619fm+0aDd5wafSPkLYpmsn0RJVsRJG4L+NB7LIfDUljLuAaubl//JeBkbAcCrf1RWdUnSSL8oZ3inRD9PR6Bgn5TeYfMXjzstUgf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNwCVvhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yzImYV3F; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNwCVvhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yzImYV3F"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3917A1380084;
	Mon, 12 Feb 2024 07:47:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 12 Feb 2024 07:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707742067; x=1707828467; bh=qRbnY/+aEX
	zXoocs2M2dwsMMM3ERao49b08ETegc9Wc=; b=bNwCVvhgzMayEqEsYeatSFE5wq
	AVhfGKS4owXrJbww8dLg224czH0BTgc2o+XSXxNyoh59Zi6leaTY8kBFk2NaJSJj
	M0oTa1jsKO/PxvKqAC5DYuKoUiahj2933WyvAWtZBFMEl+oVZHsI45jZAFg/nnom
	83581HQ6uqhwb47W7HOyToejJjkPLtsEC3HaC4s+ZhQPitBivZa+eFeROEbqhVG4
	nFPEb4dy9r7CPd1Ffy1RzO7Z/P9h9WCn+pc7lCh9KluLMhIyGAzKJ4kU/yW1TG8x
	JuGLkpv30DlXHAc+OqUwgKupHqc0jRwlq2a1OStEUShW8s4PzcE+caBB2qaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707742067; x=1707828467; bh=qRbnY/+aEXzXoocs2M2dwsMMM3ER
	ao49b08ETegc9Wc=; b=yzImYV3Fc7/XltFzeRg1xpXw/KQukGWIDzaV6n9ttTyR
	8NvroQwvIpnsR+HCdFxrhu4K5dsEB+cPUHJmSj8Y83L/Gcg+ilzwBsz1eG1zCsRl
	RR25X1A9jTlk1lk2Kjb3o3wREwTHSp+XiqGuVGx0cUWSR3tuGhJu9KfAMSoN56N4
	O8MOPe6RWO6kOfhn7jCiw+hamo08u0fUcXbQQqx9DVpMJTC9551GYbibihgvb9i6
	kWfQeaJ0j5QEbH7UlOswrhhot8qgOgyXjw0VfoZpKksrWLnH8Ts2yAiqujeuWCcZ
	YVi/jNw542WrtZxKq6yHkn5wO9uq/D1D4GdY8hT/ZQ==
X-ME-Sender: <xms:chPKZcUeu2q5VXvR1ccJh8FBg6h-oQJsxaOioUr-OtE4J-W4sHIk4Q>
    <xme:chPKZQk04wo896wPbfoZhHFY76jBBLVHbKzFScBPclmuPPAa--0sd-ecTKrX7qhFQ
    Rkv3inSJKZmhbSDiw>
X-ME-Received: <xmr:chPKZQaWKYH0s5xvHxHEYSOGKoPTQvzg1P6wYzMN97-txrJeY3mM_D9wHLm44DWVP8UngmRJ1EA1PcEBjz3joCppR_haDNo3uL9-DiinDU-_iOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cxPKZbWw6SHCkqiJES-xwM8BxFEO2z_QYAvjOF29tanhlbewIf23aw>
    <xmx:cxPKZWmfYn5x753vmBWGvqCK6pONJaalR_kO8RVd4GwzmrtQqjMPfA>
    <xmx:cxPKZQfS6O7EY0E4F6ej-uTkDbF66VrM3VvpujkGpv4r6V5T12tydA>
    <xmx:cxPKZdtTfZYh7ytAithXijq-br1yfn4clmzFqJGpzfuElrHJzKcVvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 07:47:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77aaa67e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 12:43:57 +0000 (UTC)
Date: Mon, 12 Feb 2024 13:47:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and
 `is_headref()`
Message-ID: <ZcoTbRxIaGmTd4fJ@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
 <20240211183923.131278-2-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Oalnt6v84Wmfn+h"
Content-Disposition: inline
In-Reply-To: <20240211183923.131278-2-karthik.188@gmail.com>


--0Oalnt6v84Wmfn+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 07:39:19PM +0100, Karthik Nayak wrote:
> Introduce two new functions `is_pseudoref()` and `is_headref()`. This
> provides the necessary functionality for us to add pseudorefs and HEAD
> to the loose ref cache in the files backend, allowing us to build
> tooling to print these refs.
>=20
> The `is_pseudoref()` function internally calls `is_pseudoref_syntax()`
> but adds onto it by also checking to ensure that the pseudoref either
> ends with a "_HEAD" suffix or matches a list of exceptions. After which
> we also parse the contents of the pseudoref to ensure that it conforms
> to the ref format.
>=20
> We cannot directly add the new syntax checks to `is_pseudoref_syntax()`
> because the function is also used by `is_current_worktree_ref()` and
> making it stricter to match only known pseudorefs might have unintended
> consequences due to files like 'BISECT_START' which isn't a pseudoref
> but sometimes contains object ID.
>=20
> Keeping this in mind, we leave `is_pseudoref_syntax()` as is and create
> `is_pseudoref()` which is stricter. Ideally we'd want to move the new
> syntax checks to `is_pseudoref_syntax()` but a prerequisite for this
> would be to actually remove the exception list by converting those
> pseudorefs to also contain a '_HEAD' suffix and perhaps move bisect
> related files like 'BISECT_START' to a new directory similar to the
> 'rebase-merge' directory.
>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  refs.h |  3 +++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/refs.c b/refs.c
> index fff343c256..d8e4cf9a11 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -860,6 +860,47 @@ static int is_pseudoref_syntax(const char *refname)
>  	return 1;
>  }
> =20
> +int is_pseudoref(struct ref_store *refs, const char *refname)
> +{
> +	static const char *const irregular_pseudorefs[] =3D {
> +		"AUTO_MERGE",
> +		"BISECT_EXPECTED_REV",
> +		"NOTES_MERGE_PARTIAL",
> +		"NOTES_MERGE_REF",
> +		"MERGE_AUTOSTASH",
> +	};
> +	struct object_id oid;
> +	size_t i;
> +
> +	if (!is_pseudoref_syntax(refname))
> +		return 0;
> +
> +	if (ends_with(refname, "_HEAD")) {
> +		refs_resolve_ref_unsafe(refs, refname,
> +   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +   					&oid, NULL);
> +   		return !is_null_oid(&oid);
> +	}

I think it's quite confusing that `is_pseudoref()` not only checks
whether the refname may be a pseudoref, but also whether it actually
exists. Furthermore, why is a pseudoref only considered to exist in case
it's not a symbolic ref? That sounds overly restrictive to me.

So I think this at least needs to be renamed. But I find it really hard
to come up with a proper name here because in my opinion the function
does too much. `is_existing_pseudoref()` feels much too specific to me.
Also, the "reftable" backend wouldn't need to check whether the ref
exists, but only whether a name that it encounters is a pseudoref name
or not.

> +	for (i =3D 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
> +		if (!strcmp(refname, irregular_pseudorefs[i])) {
> +			refs_resolve_ref_unsafe(refs, refname,
> +   						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +   						&oid, NULL);
> +			return !is_null_oid(&oid);
> +		}
> +
> +	return 0;
> +}
> +
> +int is_headref(struct ref_store *refs, const char *refname)
> +{
> +	if (!strcmp(refname, "HEAD"))
> +		return refs_ref_exists(refs, refname);
> +
> +	return 0;
> +}

The same comment applies here, as well.

I also worry a bit about the API we have. It becomes really hard to
figure out which function to call now as the API surface seems to
explode. We have:

  - is_pseudoref_syntax
  - is_pseudoref
  - is_headref
  - check_refname_format
  - refname_is_safe

I wonder whether we can maybe consolidate the interface into one or
maybe even two functions where the behaviour can be tweaked with a flag
field. Something like `refname_is_valid()` with a bunch of flags:

  - REFNAME_ACCEPT_HEAD to accept "HEAD"
  - REFNAME_ACCEPT_PSEUDOREF to accept all of the refs ending with
    "_HEAD" or being one of the irregular pseudorefs.
  - REFNAME_ACCEPT_INVALID_BUT_SAFE to accept refnames which aren't
    valid, but which would pass `refname_is_safe()`.

Another alternative could be something like `classify_refname()` that
accepts a refname and returns an enum saying what kind of ref something
is.

Given that this topic won't be included in Git v2.44 anymore, I think
that opening this can of worms would be sensible now.

Patrick

>  static int is_current_worktree_ref(const char *ref) {
>  	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
>  }
> diff --git a/refs.h b/refs.h
> index 303c5fac4d..f66cdd731c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1023,4 +1023,7 @@ extern struct ref_namespace_info ref_namespace[NAME=
SPACE__COUNT];
>   */
>  void update_ref_namespace(enum ref_namespace namespace, char *ref);
> =20
> +int is_pseudoref(struct ref_store *refs, const char *refname);
> +int is_headref(struct ref_store *refs, const char *refname);
> +
>  #endif /* REFS_H */
> --=20
> 2.43.GIT
>=20

--0Oalnt6v84Wmfn+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXKE2wACgkQVbJhu7ck
PpQblhAAiGSxl84VFoP8eeSS35JppZ597Bi+CWdCLFVhjI3W38ZTPcRVCvMzrPCF
avTrZ1j9fOZdw8YaP+Kx2TInd9hgASib5Ph/ZBLmza2D2J0DOmPBNItsv0XVwMaV
edgBl2ETZzWS/pVR/RLi1Z3i8t3o/T2oQL1t1+6z36/COwhyPL93/bLISVXDbjiW
1G6rFWFiZaAD+oqsWq/nzbiQyZRz4APb1DPq+8CECEawM+qIFOKWpLfTUQCNlFtq
J6zsR3+/LZkU1HGfq9IMFQ6cWyuJry76/hGHSuDlDpyfmY8WhOeLLoXfrBZ4xa2T
p8EdRgHlkAaI0Rdy07OsCpsCCDOO28M2BSS7yneS42ieaCB7C2Ki7U8fyqZEAR5I
H5rIKbeaN2sGG2/mRJa1ZptqwiKaDGMZuaUqwBb7Q4K04m/xufrtcDOFh5NFIhdM
M5EtMPzaROcHPCsFLuzxb5No2q6C488Ilk2+1GIUvp6WF+zMXEOVMVauxKS22LTr
hMUMGdFD5a7aVcxSO4Rg7wHuHXkTlw6Lqw+os0bhsoTiFRSj4mxH0xMJcdqn5WBx
hkg/03BNKO8gGEf2V8FVgccFSPQQa9xDAicy45LJfeN74XHMVCK/wmUZjhoEA/8N
rHb1g6sB2lRC6KddKdeqS9e/wORnSZ7AJ55I2n3NQi6qgbkPJBo=
=DJRb
-----END PGP SIGNATURE-----

--0Oalnt6v84Wmfn+h--

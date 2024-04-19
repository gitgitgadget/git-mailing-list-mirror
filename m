Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7B7BB07
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519648; cv=none; b=Zw4gO5122O7ifT8BQJ35+jM0X5eYzGsL3jJL/vyRZxz7rMqKh9AezHIg5mL/nH9x7uXRflzKhDkiGZBiv81Wz41ZGTGsWiesIK9LYErJ8fnrFun1ocPJJXs+MrkaijLYQy2kexfsOWUiPkawv7Yruvu5+jooIYfTlsAxjXZhYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519648; c=relaxed/simple;
	bh=gRjaY5ZNrvp8UEqX1+rrHKIv6HHTVq3u07rvRGwFaSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+hvaCy0bXgk9rTB7VmYoNBcyF8khaEJeBHy/EF2MHPN2hRZYmDSVS3bkX6HL48599EHdyeAFx/MptnIguw5SAEtY82T069AJc8M1+sNLqtITyKwlLFgDx1PLt1qGZzhD9L4cGd2MZRuTfAxvYV5ZjhSj71B8wLnsmF4rDk4lz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RmO1A6jI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvRCEpSO; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RmO1A6jI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvRCEpSO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 58A7A1800123;
	Fri, 19 Apr 2024 05:40:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Apr 2024 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519644; x=1713606044; bh=CKp3DnkHjN
	dhauI/kzGHetgx8PmElD1SI1iVsJGkFs4=; b=RmO1A6jI9ikGx3LBgyslR6skz9
	suw1bTehAkO3uJnviuVFsZD4bHZvKuY5BBCx++8xlpatYnYlTsyq3q/WT16CSxaT
	6sHXkrKCdpd1cLvlkwRLzgQ79aR/qaB0WXLxNGE1cbId0oEZKG0DZ0+KNaBjcewL
	wjY2NsVy7xeTVRv/DPcFYiqt7mjwrbpAALkf9X0frg/Faruzb1ESql7m/k8cEkkB
	p2ab2CdpH/QXl2ImF9RHrOo1jaDOLmGUg6GIAUrSx5yACGHen/8Crv03zfJ95QJT
	0wq9VLl1BbJpw6lgYXs00qhPUqmKunc7hDxfdX1MVYHFt11L2rTe4M2HwcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519644; x=1713606044; bh=CKp3DnkHjNdhauI/kzGHetgx8PmE
	lD1SI1iVsJGkFs4=; b=hvRCEpSOsfUMLkScESus4u5ewaFrcplaD8QglHFdK8GA
	y3FYTBZg1ack9G+SOnsIoB3zCgkn9HcrB6uZz5N2bpJKrsKOSCA3BFedKOxK/sIB
	zwF+aPSMGJhJSz0ANi07PxTxo/hoee2Wk9f1mU1YYnGMrPYNTn7pmpwjeKHGXr4I
	a3FEjhutwq61HYddyAHowdLFqh9YA+v1e9xs2NdqzmkCecod/CGDFtTN6RFKH1tY
	2JWzz9p6v84umVCPJ7Aeb17HX1Q08OcIXACqTy6bAS2hrRmcRWRDhFKe62NJ0D0s
	VyZTZX1iCt6M8KegIJS6Hc0+Z4ixK4QWWpgf9qPbPw==
X-ME-Sender: <xms:HDwiZsphEhFk_SOjjq-hTDauRNx8jEsyI07Eot8Wow8QqBfgxApGkA>
    <xme:HDwiZio73WLE9M2gjED2BgPa45uLxd-BrLZdVfI4MfGokr_skn3yNr1j8xUUWvuQ3
    aje2dWlZSjD-yCKyQ>
X-ME-Received: <xmr:HDwiZhNFcsltVik1BxGur_rcgsJD6-PVGyCcnB99VqMXWaEpGsctm9oTfZ2G75F8xP0NSsPI1oq2u1kqR9c4rJ58wDjhIEjcAEqhl5MS9kIFmwF-NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HDwiZj7nHdyhA7PGvBxQapqGYK8vO6B_FRJZ2blmeRWOpPmLum4g6Q>
    <xmx:HDwiZr7t6MP1vC7WafJlsVqO4Hvv5i4ivvbdfiE3kAuHDOS11wUyTQ>
    <xmx:HDwiZjiK1B_BLgLi39L0DmzIw-16-kavP3H7ePn1hg93RxNr94di-g>
    <xmx:HDwiZl676u-xCOtuEk-quvxD1NSrpmftlITo9tengo8uVWT-lx0V4g>
    <xmx:HDwiZu0XKYPdmG3JHvgFsBmI8t1LHLAPDldyjzSPBb5ALrAEQuTAPa1B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c45efd91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:40:16 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
Message-ID: <ZiI8GaGupNzbLqnE@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-6-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2zkr08C15vqtjBPK"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-6-knayak@gitlab.com>


--2zkr08C15vqtjBPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:06AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
[snip]
> @@ -268,6 +268,39 @@ static void parse_cmd_create(struct ref_transaction =
*transaction,
>  	strbuf_release(&err);
>  }
> =20
> +static void parse_cmd_symref_create(struct ref_transaction *transaction,
> +				    const char *next, const char *end)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +	char *refname, *new_ref;
> +
> +	if (!(update_flags & REF_NO_DEREF))
> +                die("symref-create: cannot operate with deref mode");
> +
> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-create: missing <ref>");
> +
> +	new_ref =3D parse_next_refname(&next);
> +	if (!new_ref)
> +		die("symref-create %s: missing <new-ref>", refname);
> +	if (read_ref(new_ref, NULL))
> +		die("symref-create %s: invalid <new-ref>", refname);

This restricts the creation of dangling symrefs, right? I think we might
want to lift this restriction, in which case we can eventually get rid
of the `create_symref` callback in ref backends completely.

> +	if (*next !=3D line_termination)
> +		die("symref-create %s: extra input: %s", refname, next);
> +
> +	if (ref_transaction_create(transaction, refname, NULL, new_ref,
> +				   update_flags | create_reflog_flag |
> +				   REF_SYMREF_UPDATE, msg, &err))
> +		die("%s", err.buf);
> +
> +	update_flags =3D default_flags;
> +	free(refname);
> +	free(new_ref);
> +	strbuf_release(&err);
> +}
> +
>  static void parse_cmd_delete(struct ref_transaction *transaction,
>  			     const char *next, const char *end)
>  {
> @@ -476,6 +509,7 @@ static const struct parse_cmd {
>  	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
>  	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
>  	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
> +	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
>  	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
>  	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
>  	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
> diff --git a/refs.c b/refs.c
> index 6d98d9652d..e62c0f4aca 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1305,15 +1305,20 @@ int ref_transaction_update(struct ref_transaction=
 *transaction,
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *new_oid,
> +			   const char *new_ref,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	if (!new_oid || is_null_oid(new_oid)) {
> +	if ((flags & REF_SYMREF_UPDATE) && !new_ref) {
> +		strbuf_addf(err, "'%s' has a no new ref", refname);
> +		return 1;
> +	}
> +	if (!(flags & REF_SYMREF_UPDATE) && (!new_oid || is_null_oid(new_oid)))=
 {
>  		strbuf_addf(err, "'%s' has a null OID", refname);
>  		return 1;
>  	}
>  	return ref_transaction_update(transaction, refname, new_oid,
> -				      null_oid(), NULL, NULL, flags,
> +				      null_oid(), new_ref, NULL, flags,
>  				      msg, err);
>  }
> =20
> diff --git a/refs.h b/refs.h
> index 60e6a21a31..c01a517e40 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -744,6 +744,7 @@ int ref_transaction_update(struct ref_transaction *tr=
ansaction,
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *new_oid,
> +			   const char *new_ref,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
> =20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7c894ebe65..59d438878a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2609,6 +2609,27 @@ static int lock_ref_for_update(struct files_ref_st=
ore *refs,
>  		}
>  	}
> =20
> +	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {

Let's add braces around `(updaet->flags & REF_SYMREF_UPDATE)` to make
this easier to read.

> +		if (create_symref_lock(refs, lock, update->refname, update->new_ref)) {
> +			ret =3D TRANSACTION_GENERIC_ERROR;
> +			goto out;
> +		}
> +
> +		if (close_ref_gently(lock)) {
> +			strbuf_addf(err, "couldn't close '%s.lock'",
> +				    update->refname);
> +			ret =3D TRANSACTION_GENERIC_ERROR;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Once we have created the symref lock, the commit
> +		 * phase of the transaction only needs to commit the lock.
> +		 */
> +		update->flags |=3D REF_NEEDS_COMMIT;
> +	}
> +
> +
>  	if ((update->flags & REF_HAVE_NEW) &&
>  	    !(update->flags & REF_DELETING) &&
>  	    !(update->flags & REF_LOG_ONLY)) {
> @@ -2904,6 +2925,14 @@ static int files_transaction_finish(struct ref_sto=
re *ref_store,
> =20
>  		if (update->flags & REF_NEEDS_COMMIT ||
>  		    update->flags & REF_LOG_ONLY) {
> +			if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {

Here, as well.

> +				/* for dangling symrefs we gracefully set the oid to zero */
> +				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
> +					update->new_oid =3D *null_oid();
> +				}

Can this actually happenn right now? I thought that the `read_ref()`
further up forbids this case.

Patrick

--2zkr08C15vqtjBPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPBgACgkQVbJhu7ck
PpRkYQ/8DJchQXNl+ZADj9Alm4UJn1ANF/o3VRy22Fk9SaRJFf1FrFjyFqIVzk2L
BARxdxUxP6hkJd6pDuJgWvRxCo+nvJDzarL/r1hmd8aNhG4AC7V5RhLjmXPLGkTr
va1+UQC4qNTSuMrsrqomEx5oexTSDGpWUAv1xM0W7NFEYHa6h1CZjagiHr/a4tdI
ac5ORHgYTb2xpz+LMmJT+SA5twjFdie47x84nutj/ofYUh101vQ5DvAusCAcMErZ
OsEocBW+ZWo5iruwFn8h+7L5mTh7GEJo7w22sJGhMWdjYW3ItW+pwfIoE/tgY3Gm
LT5pRHIKb9aMg75/Ve00E5NummQCc5NEhIViA48CMTrYm5gt/b48HAMkfw9Jc0Jk
aox64k3+NmUAwkzMCT11uRJRQRZekQSdJzkXYn7YyTEqE5DY+96UN16zibk0L01S
8F8OvcthKDVqimFsTS7UgVij7lqiCGa0H5f0+ei/ayndwgR5FeHaLXv8BVR4JYgj
Frv8L81YpyBVstHvbeByuJkaHZxnx3Yzxg5WeRYa/uRBTFNXu9aLTtmwdsvo5nI0
QV/PFSQhbDNT/+xzDKJG/A3WMYw6xsCY3k6TIfVSAR7Ks/Gbr53FyPnc7lu23oW6
8U6jobwlhATUSBXSsaYMIptZdaSc1yUNkvOqh3xq9N5DkMVVTmg=
=gBKV
-----END PGP SIGNATURE-----

--2zkr08C15vqtjBPK--

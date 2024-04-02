Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40F80628
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060435; cv=none; b=SrHt4wferl+yBYaDE3gQdUTf8rmCVRh3JWsTwPgOKRdx5tOlemSh/mT6Np1Bse1SUHR8Ybsb8oqmbaJeEDTD/EZFYxl22TEMie7DZCouE8FaSvmtVrC5xDTa9aKlUr1vEI66GcxuOVG+1Gxi7jW7Yc0R+lOH9UIiJgJ2IbYOuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060435; c=relaxed/simple;
	bh=eN4Xg2EbIo1L1UPZ2cD5PKPIU89r/93nTibVSSqtojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1Qvr5xnDsk4vtM1Py/HZuf1wYdA6TK9lycO6yDBl0KIYuqJJb0KFKOkKwL716PiecUFj7qBe3OutVNk5PDo28Ooiet4pvxhzN2zx6+slAaeg5g6VjO4dfx8S1naiC3l7o6n005sH/1HKU1Xy2OIEwgxu9QNcCMqNZwWr71K4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QAtbD64r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ES1KzNk3; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QAtbD64r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ES1KzNk3"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D7F4C1C0009B;
	Tue,  2 Apr 2024 08:20:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 08:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060432; x=1712146832; bh=TbfORDYtvk
	WF1qXhRDFhhiogBNPcYg+hgGNREbdenn8=; b=QAtbD64rztGtpirsLd3yjoWq2U
	ft6KUSmUFJoa84UDfgC4bRo7t1yIVbEkEohuu2cHPCDu9npvxeh1ylgSZIbZ5wkE
	qxHuNNlTxyhgSy4S5a4EbodbruyBBAAWFUUY80+7kEbH1Djg4zh1Qo0yE5JquoEL
	/b2QCrolhAPf6j+Yg0LS1fD9xC/sYAgLwEA8oKZVWshdPkQLDWCW8v0+XK1zpPoU
	4xswzeYH1RXADEOwdwPFXzmahgbLQYjo2mFYAIQWGuO51GTwFBYQWhCKkKMSKYDA
	dMo6//5Rqiq4w0twZtmFBKVSx55lCN4srSPHTr+peWVOFk9oZIYeFoAFf4xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060432; x=1712146832; bh=TbfORDYtvkWF1qXhRDFhhiogBNPc
	Yg+hgGNREbdenn8=; b=ES1KzNk3V1W1Rb7nzQps7VwD2Vr3Ks7/cBFdRhJVh5eG
	9DuGx6dV82Y0PfBc/cvTaYAozNWegF1CKdEHpG/G3YMqawKUzixWvfwDAuKfhQmu
	vAbCr1411MTzlwOhber8OBAb37U6msgFYmDmdGfPlEGyAo7SBv/mMgbZUBlxxrUC
	pYchHY8gWWUfhTpSZhKzSzFEwuMMBWHtEahVb4XPNJHJNmk/cdjczlEcc77NMEmi
	X9wBYK4tOzmLY6U95eIKTy63DfilZfXqwNIhcM5BFzMlZaNZg35hAh2fh0z/Lz43
	/Yd8m7Dv7YcH6hwJQMRblOHotIQtuYJDlExTpG1Vgg==
X-ME-Sender: <xms:EPgLZlo9wqKjrvNTePSdrs2aNaPZVjVrAX2R5E-ucfCJo6GogknEfw>
    <xme:EPgLZnoXwbK_HAfKWIloy8Jy13ro6DlLH-kfKaipQMkxe4Y13Iz4hycRN4WQXT0hw
    cXeqgx4LXQdtqjHiA>
X-ME-Received: <xmr:EPgLZiPzJv-mAdOxGFsJTR9xCANpWjSPBfE_0SS3fTKoCDmOblxDvnG2YTsAJWLiPj9bYtLHVqdXFznQJIoS0dIM0Dn2f3StM4dL4gyvvO-s2Ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EPgLZg5kLmUyJ4EMtRsIPB_5XJcUmSa1-7fN3yJwdGH8BheyRMy0XQ>
    <xmx:EPgLZk7y0F8B6vIfWyvwYaorHFNVKIlUhkBRFhMUuxAFkP8o62L5Ag>
    <xmx:EPgLZojbdwrvtvSvbNLC4rEaNzIg0pMR2bKcEqcEJrl3ZEJK7kx_mw>
    <xmx:EPgLZm46Qujpv2Q5rZJcniyndTWLAXSJkDTZR8kUrcijUtYYHKxS1g>
    <xmx:EPgLZikqHeOVdWE-2Y1uEmvWrzwLTdVTQsrevQCR9i9Evf5dpOOOSs9I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60269c4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:23 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] refs/files-backend: add support for symref updates
Message-ID: <Zgv4DShrInEE30GA@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-6-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jRAy25Lr8gClmRp"
Content-Disposition: inline
In-Reply-To: <20240330224623.579457-6-knayak@gitlab.com>


--/jRAy25Lr8gClmRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:46:20PM +0100, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add support for transactional symbolic reference updates in the files
> backend. This also adheres to the config of using symlinks for symbolic
> references.
>=20
> While this commit is setting up the files-backend to support symrefs in
> transaction's. It will only be used in a consequent commit, when we wire
> up the `update-symref` option for `git-update-ref`.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c | 45 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4dbe73c106..6b4cc80843 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2323,7 +2323,7 @@ static int split_head_update(struct ref_update *upd=
ate,
>  			transaction, "HEAD",
>  			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
>  			&update->new_oid, &update->old_oid,
> -			update->msg, NULL);
> +			update->msg, update->symref_target);
> =20
>  	/*
>  	 * Add "HEAD". This insertion is O(N) in the transaction
> @@ -2386,7 +2386,7 @@ static int split_symref_update(struct ref_update *u=
pdate,
>  	new_update =3D ref_transaction_add_update(
>  			transaction, referent, new_flags,
>  			&update->new_oid, &update->old_oid,
> -			update->msg, NULL);
> +			update->msg, update->symref_target);
> =20
>  	new_update->parent_update =3D update;
> =20
> @@ -2396,7 +2396,7 @@ static int split_symref_update(struct ref_update *u=
pdate,
>  	 * done when new_update is processed.
>  	 */
>  	update->flags |=3D REF_LOG_ONLY | REF_NO_DEREF;
> -	update->flags &=3D ~REF_HAVE_OLD;
> +	update->flags &=3D ~(REF_HAVE_OLD|REF_UPDATE_SYMREF);
> =20
>  	/*
>  	 * Add the referent. This insertion is O(N) in the transaction
> @@ -2567,6 +2567,27 @@ static int lock_ref_for_update(struct files_ref_st=
ore *refs,
>  		}
>  	}
> =20
> +	if (update->flags & REF_UPDATE_SYMREF) {
> +		if (create_symref_lock(refs, lock, update->refname, update->symref_tar=
get)) {
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
> +		if (update->flags & REF_UPDATE_SYMREF)
> +			update->flags |=3D REF_NEEDS_COMMIT;

As far as I can see the `update->flags` aren't ever modified in this
block, which already is guarded via `update->flags =3D REF_UPDATE_SYMREF`.
This condition should thus be superfluous, and we can instead set
`REF_NEEDS_COMMIT` unconditionally here.

> +	}
> +
>  	if ((update->flags & REF_HAVE_NEW) &&
>  	    !(update->flags & REF_DELETING) &&
>  	    !(update->flags & REF_LOG_ONLY)) {
> @@ -2862,6 +2883,14 @@ static int files_transaction_finish(struct ref_sto=
re *ref_store,
> =20
>  		if (update->flags & REF_NEEDS_COMMIT ||
>  		    update->flags & REF_LOG_ONLY) {
> +			if (update->flags & REF_UPDATE_SYMREF) {
> +				if (!refs_resolve_ref_unsafe(&refs->base, update->symref_target,
> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
> +					strbuf_addf(err, "refname %s not found", update->symref_target);
> +					goto cleanup;
> +				}
> +			}

So we try to resolve the symref target here so that we can provide a
proper new object ID for the reflog entry. What happens though when the
caller tries to create a dangling symref where the target ref does not
exist? Wouldn't we raise an error and abort in that case?

I think we should handle this case gracefully and set the new object ID
to the zero OID. Which is also what happens when deleting the target of
e.g. the `HEAD` symref.

>  			if (files_log_ref_write(refs,
>  						lock->ref_name,
>  						&lock->old_oid,
> @@ -2879,6 +2908,16 @@ static int files_transaction_finish(struct ref_sto=
re *ref_store,
>  				goto cleanup;
>  			}
>  		}
> +
> +		/*
> +		 * We try creating a symlink, if that succeeds we continue to the
> +		 * next updated. If not, we try and create a regular symref.
> +		 */
> +		if (update->flags & REF_UPDATE_SYMREF && prefer_symlink_refs)
> +			if (!create_ref_symlink(lock, update->symref_target))
> +				continue;
> +
> +

There's a superfluous newline here.

>  		if (update->flags & REF_NEEDS_COMMIT) {
>  			clear_loose_ref_cache(refs);
>  			if (commit_ref(lock)) {

What is the purpose of `clear_loose_ref_cache()` here, and do we need to
call it when updating symrefs, too?

Patrick

> --=20
> 2.43.GIT
>=20

--/jRAy25Lr8gClmRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL+AwACgkQVbJhu7ck
PpS+/w//ZnTLEp4YVur7tGOBYs/5aqwPNSpSh0HZyUBovMq43GLy6yhnKB6yAymd
vcC3oCXMDPzqQVysN1Q9lT2PuzWoOAfG51fCm0sVds2H+HKubNHOcO/wSJSni/Jn
jGDWMGzDSQ//AidveJwkd4lNY1hqRllheeBByy/0v/TkXTq9QiR154BcULUwua6T
RWB0pNmdL89ypTg6VcF+fJ/TtjRZ3iDqyXRWQ/dp+zNZ9tM8RarxOxHp7kD//zLR
GJaXClKghgoFgF+NOKfNGS9OwulrWOcim/B6mFZJKIJS8DI6fyi+ySB8TMhZUOtA
slXcP9bvkehziyVh04bWpxB8tY2Hqz8aTnIgbM7L9EUz2dQ7Ki9k+nE8QjuTZ53R
leb4yEmJ3MtnQDllndEduMFtQfEnZaRt0j7gpAeDNzLkOeLJaqEpl7x04mZket74
2BbAkgY1kMQCCePqZSc68i9tYU5wnaf2oMbutolI4ddyABnmrWqUWRzQZDyGdnYl
4iAS4PFDLumrthXV6GAaVBg9ejSK8JmB6vs+8zA+38tiavMPaOoXLkwCbqOZQM4K
HtUgorOlEuoI8SArr9AXgrLBHh06svpBOLJ8EAooRVOPDp4WZh6FiwUgUaatQgZN
fNbYAzciYvs4vG9q64IdtTFb4ncfuzAztbeEU5NHetD4eTeUSWg=
=RhW2
-----END PGP SIGNATURE-----

--/jRAy25Lr8gClmRp--

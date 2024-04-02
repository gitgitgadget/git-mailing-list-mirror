Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BE69979
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060444; cv=none; b=I/NASUb7khMcgE19rTcxjfik25Wcb/rzoczMSeWz38p83ccd0eept98/nhczDOZmNMyrbQfXweXFuBglBkR/VtZvYiHkR/wgNNeew6YKTFJCV/ZHbT46LZmSTRUo70Ox+fKGhqZBxGXb5FoEetJg+8TVShA/WCY/QNZW9x3s6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060444; c=relaxed/simple;
	bh=mH5TZrUPE9rSiIgccm0pmYqmSeKFuHU8Fu74izbkL7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL9UVVan1DAI13vRwQ4E5MSlJvFvFl1S4jRUWUFickMX9acaqIEbst9CsQ8QkI2DXwBBYlc+2CJj5IprQ8JHjYqqorr7RpHcDzoEVZ2Jt+p+rZ200jbNdNFid54V0bcf/D+HnnVZxp4uyAnNVWmIUORpa6HKYDM0GBhl2edOsXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P75Ksdpv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuzYjlyK; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P75Ksdpv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuzYjlyK"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B8FED18000E6;
	Tue,  2 Apr 2024 08:20:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 08:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060441; x=1712146841; bh=kSS58ocqsV
	OwG619M0ZcKLRY4IRYUE5pRWkaiO++XZE=; b=P75Ksdpvd6btE7uwTF885JFPRA
	03U/Gn7KEvVaR123YR+QCCQ4bOMuPwFNeu5j30gEtoY3yhq8ZmPxAWHZvhzHmjr7
	z63750xvp7YUmQYuY6GAZqJdkjgtRIFC9IiLnqBHa/yhFZf4b5TeIb6iB9CYcbRm
	A4PurEjqgkkFaM9dTJqs4XMVro5jG5bnVGJbSsJ/CXmbVeKzG7FEANdWSlstH3N2
	cYM626ZHAz5Qzib74xqanXkg4wynzIaFzDfGFMBP63uUu2kWezfL6h9eJZoSKg9m
	6LOJlE3haEY1zQgeXzyCsKPmYye8ojaEeEaMgBEfalUmuLqo2/NyWkB0t0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060441; x=1712146841; bh=kSS58ocqsVOwG619M0ZcKLRY4IRY
	UE5pRWkaiO++XZE=; b=DuzYjlyKk/TkHz7H+mW0VQ6kDWj1wN6MeYoXxpfmZOg3
	keFAcXtGMuOwYN+uMR5BBXkZwTRogQ+/EwSGBj0YLBfQJ1rDFdqw/QzWD08aC7QF
	4XMYWuk796Cpq0vXBm2RKbVIfQqX7RGzW1KdsGq5K1oQ0f9WF34nv85MIi3Jwp0+
	EqsCuSgZW39x1WmXkOUfcMwpr0XZmTJru7Te77O1sE6+H4XMqhEa2JH8hAKwLaLY
	9UVAxTAvfRdsE9X7zE+YDUfi9UgsBkx7SAZlnTZfmSTsr/ZjTvmcaJG0Atuyy8mt
	jPiN2RC53VpJ1Du7i5dnbi1SVPDVTyEq2ldmP7r0BA==
X-ME-Sender: <xms:GfgLZq26GEFHDpXOvzWfZaAVovHApn5e3kSs59uH9G1oQp3FibpR3Q>
    <xme:GfgLZtEFsVSHC0w6E8QKI1LjOaZgFVfIDObpUI3Jr8UzVw96hZeZAnzIpRMh6T3Rj
    M5zI9iyWfMUQnC5rA>
X-ME-Received: <xmr:GfgLZi6Ypaz3bekWQu9LOs8HUBc2Kna0v3NPqmhNFG3yMcAx3I7oyzZvW_j1OUq4fZaRtCgkLqbqWml4p5uixI7waUzIrhzN0sVsT2NwBz4OzqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GfgLZr2LhrxyUlID5NDysSg8dFVjJuM_GvZ9nmzBdds9rqoPdBsMCQ>
    <xmx:GfgLZtERVRu8Acb8n0l3lclk0xAmTDj4h8y2K2erB_vsKGUFEzaSLQ>
    <xmx:GfgLZk_4zDyWo5XrbE4CWd9WND9ydvFziNFaNB3ddwQ0bSiwfS2rhQ>
    <xmx:GfgLZilFzudHYs_LNJlh5L1UNofiCxFfRumLMUSlftE862JaBp8Hyg>
    <xmx:GfgLZtB4uP45YF_dllnzrfXzcxVcrXq7_rqS8DOuBhZNyJEgTk8kTVam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1651b12f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:31 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] refs/reftable-backend: add support for symref updates
Message-ID: <Zgv4FvntLkmm5mQI@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-7-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SoGsP7gHhOyEXgXV"
Content-Disposition: inline
In-Reply-To: <20240330224623.579457-7-knayak@gitlab.com>


--SoGsP7gHhOyEXgXV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:46:21PM +0100, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add support for transactional symbolic reference updates in the reftable
> backend.
>=20
> While this commit is setting up the reftable-backend to support symrefs
> in transaction's. It will only be used in a consequent commit, when we
> wire up the `update-symref` option for `git-update-ref`.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/reftable-backend.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 92f2803e90..35f2e8e050 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -884,7 +884,7 @@ static int reftable_be_transaction_prepare(struct ref=
_store *ref_store,
>  			new_update =3D ref_transaction_add_update(
>  					transaction, "HEAD",
>  					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
> -					&u->new_oid, &u->old_oid, u->msg, NULL);
> +					&u->new_oid, &u->old_oid, u->msg, u->symref_target);
>  			string_list_insert(&affected_refnames, new_update->refname);
>  		}
> =20
> @@ -909,9 +909,11 @@ static int reftable_be_transaction_prepare(struct re=
f_store *ref_store,
> =20
>  			/*
>  			 * There is no need to write the reference deletion
> -			 * when the reference in question doesn't exist.
> +			 * when the reference in question doesn't exist except
> +			 * when we want to create new symrefs.

Nit: it's not really an exception because it's not a reference deletion
in the first place when we write a symref.

Patrick

>  			 */
> -			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
> +			if ((u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) ||
> +			    u->flags & REF_UPDATE_SYMREF) {
>  				 ret =3D queue_transaction_update(refs, tx_data, u,
>  								&current_oid, err);
>  				 if (ret)
> @@ -963,7 +965,7 @@ static int reftable_be_transaction_prepare(struct ref=
_store *ref_store,
>  				 */
>  				new_update =3D ref_transaction_add_update(
>  						transaction, referent.buf, new_flags,
> -						&u->new_oid, &u->old_oid, u->msg, NULL);
> +						&u->new_oid, &u->old_oid, u->msg, u->symref_target);
>  				new_update->parent_update =3D u;
> =20
>  				/*
> @@ -1026,6 +1028,7 @@ static int reftable_be_transaction_prepare(struct r=
ef_store *ref_store,
>  		 */
>  		if ((u->type & REF_ISSYMREF) ||
>  		    (u->flags & REF_LOG_ONLY) ||
> +		    (u->flags & REF_UPDATE_SYMREF) ||
>  		    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid))) {
>  			ret =3D queue_transaction_update(refs, tx_data, u,
>  						       &current_oid, err);
> @@ -1187,6 +1190,18 @@ static int write_transaction_table(struct reftable=
_writer *writer, void *cb_data
>  			ret =3D reftable_writer_add_ref(writer, &ref);
>  			if (ret < 0)
>  				goto done;
> +		} else if (u->flags & REF_UPDATE_SYMREF) {
> +			struct write_create_symref_arg create  =3D {
> +				.refs =3D arg->refs,
> +				.stack =3D arg->stack,
> +				.refname =3D u->refname,
> +				.target =3D u->symref_target,
> +				.logmsg =3D u->msg,
> +			};
> +
> +			write_symref_with_log(writer, &create, ts);
> +			if (ret < 0)
> +				goto done;
>  		}
>  	}
> =20
> --=20
> 2.43.GIT
>=20

--SoGsP7gHhOyEXgXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL+BUACgkQVbJhu7ck
PpQ8lRAApP1RA7uYobkQNJL/G5XZfQR2j0ZKyfzqPlYjFmbH6NSpsjabngCPuWbT
4NWOu1j959YN0iKE1H7C23oW3eZtjOWfATC0ALEuGpn47xhLg3FHdtxcfdeRTSIG
M6CI0fAElOVav2/vFs3c2B+Nw8dDT1vsZWJM7sv/vP3ZNAz2gv36v/Sdkz5J+Ng8
Pc+E0EYYpP3evRLlnr1drM7Z81yEdhv3+8HBw+bzx6nRrmTZx3XoE3XZeDlp9hKc
MXoq6uLi28S3QAHP1DaG9OXNMGKbj0u9sgNz/5OmzqrSefM+QGOYrrnZWja6YG7i
Tb44BzyX56jzoNflq0Ui34FqOk8xYbbmkAtpnbP09Y3C3pqHJUsrhIsLBFm1JcjL
36L0Ef0OOPnAWSw94maGaNnsCK9cK5M7Dqmz6/e9IhbedKRLrwvMpMc/PkLZr0sR
sGXRsI5q4KnlatVMYVydrfE4mxXnk/B1ez/4jTVTHLSA/FbJFzO+avalVKH/DAzP
rneSw9Ct92AJZO5TrzPcJJ/fT6PYjzbsfrxzkpiMB2Y4DL6fdmjHS+LNeP2ecFub
4IEQep34f1oWM41vy9GEJbsBWYHnXSGfxe7yN8voV5IBGEl+o7UHD8j7hq+zcZwN
5YQwRIZm3uiJNv4ZB9szjF8X6cd1z9PJNXRza8ZSw26lhfoPM4g=
=y6bt
-----END PGP SIGNATURE-----

--SoGsP7gHhOyEXgXV--

Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC519450
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671756; cv=none; b=GZBXDb1zZPp3jYKdJtZvX4Jn+FKDKC2hcR5Uykqq7HTzruiJPzyTtWgOgSB91V8gOzhZz5mX/AzT1LNuHuHCJKCLWWixmYfZAx4V/NC9IIsWrs81kwuHOHse/7eScViSTVLqoTWvXN9g/vji09RynruIcdiF/UXwYMByDMcRD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671756; c=relaxed/simple;
	bh=v+l7on47d21lyCE2LiX8T+R49EVftiz+cE9LaWOzXcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcYafGouEDja63g+E05Q2BVLH6tXpqUo1YzrUDJAaXmiIP3sQ1aLYdAu8H4QXSA5XXmGD1gZdfGoZULwxzmzgi5DhdloY8L6yDrVaBLysnWt+2D65RCLdSVNm54pK4fi+VH0+Kak198rCq4c1C16EmUzfBEdofd7qRw+aPSxL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9PNLRkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9ezBbwe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9PNLRkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9ezBbwe"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C549511401FE;
	Thu,  6 Jun 2024 07:02:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 07:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717671752; x=1717758152; bh=vHaBAZLbd1
	37+LodaWSr2uW19RQsCMv5p22ukOi1hU4=; b=R9PNLRkZeeUfSovJaFQPdjWlly
	6tdTzluFQzGNUD0kWBoi6snier62TC4rpeEgIhgzJWKarq3cQ8Wakm70s2SMDNpo
	1nCUkpj1JBo1SNoSkya3oRnYSaybQtU/hIqyIqAg1vscU/HoSO+E44gp4KtvJXaC
	HXBXsq7Ne91+7K96KJYvhPj32Lg/hauw6ws1FNRmHk2fMnWojH+1Eo7QwLTOwlnW
	JfFzTTIkS1n2eO3cgQf+HMJJVxsqlG7QFHVDN4GN3i/JqkTNx91IgZzw9taQBXHB
	NysP2Qxe4GuRQSkPz1F+F/wJX2uO3DMIM9k2w+KuZtz/XWSGqON5wLItpX3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717671752; x=1717758152; bh=vHaBAZLbd137+LodaWSr2uW19RQs
	CMv5p22ukOi1hU4=; b=n9ezBbweCQJW2byK4TQWivAqNt/pI7F+NsR7WW+ZhVqH
	y4HdF0/YzIUB7cYw/b10HSWhS9LEiiqX8X7FyJ52gcyyuf+4am9GulEj0g/Amdfb
	z1678k9kOKWIiemRbNS62tO6ufF/LlLx2aIbuCV9pk/6JoSIPCRIURjYaifnemrR
	5WAjDw8oHN7xCd0yXQVM19EbmjUwe9TJVAvv7kKgU9GlLU84Sv5nV3A2cpDQr9r3
	j/D1sKq4OfFhKcYPt9gaUvon1utLdWk13GU9hVSNs8TjKlZCKRNFedwEc5NAYgZ5
	UJBtmphMQtmb2mfAjgXRRcZCArFuVEyzLSK3S40WEg==
X-ME-Sender: <xms:SJdhZg0NZPxBTN5XRsvrl1dADXakKnOLJd0TcxxK3T7IhXVDiPy7LQ>
    <xme:SJdhZrFYRfAP-VkMnBEmVedQ52msqSli_pckBbRDwA_RYYbFJLJz7kWZM_isT1tSD
    r7fETLPySB4krF5EA>
X-ME-Received: <xmr:SJdhZo4hwtPODZ2jyn5AEKwq4U3dMCRSoRcv-37scfkE0nuuoKsTaePD8Lxq0hlVMHNKSM2ZUGmB_ZaaJROMxIeUCV0Jbg7Y-J_k43IyZNQgh0Uu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SJdhZp1Jmeu1pZps10FT7qGVFTgagMWCLDJ4B79zzZ1zxNRZkRCBvQ>
    <xmx:SJdhZjEqZ0fhNrd0beEou-EHpx-Dx9-yz0wwyYosU8fNvBMrl_rVdA>
    <xmx:SJdhZi-Z5_oQLXH-qgCpBIQcQ9pOTn_X2PXECcGnZCrdLmjiVlNTjw>
    <xmx:SJdhZokELlR0gHkbxY4KOQswPnDuBo_BuV0TG9mSkTS3njvcXX67Bw>
    <xmx:SJdhZrBVcmpCUq4iw9I7_vD7-_-s_ARuXEDFxNXM_NgELheElMldNooJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 07:02:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 18b74857 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 11:01:59 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:02:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 2/7] refs: specify error for regular refs with
 `old_target`
Message-ID: <ZmGXREp9Xa6qHpMC@tanuki>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
 <20240605102958.716432-3-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="480H3O4+gyPjOtTP"
Content-Disposition: inline
In-Reply-To: <20240605102958.716432-3-knayak@gitlab.com>


--480H3O4+gyPjOtTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 12:29:53PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> When a regular reference update contains `old_target` set, we call the

s/contains/has its/

> `ref_update_check_old_target` function to check the referent value. But
> for regular refs we know that the referent value is not set and this

This is fairly technical and focussed on the implementation. Can we
maybe talk more about intent ("expected a symref, but is a direct ref")
rather than the exact implementation to make the commit message a bit
easier to understand for folks?

> simply raises a generic error which says nothing about this being a
> regular ref. Instead let's raise a more specific error when a regular
> ref update contains `old_target`.

It might be helpful to include before/after in this commit message to
show the change. Even better would be a test of course, but I think we
cannot add one at this point in time yet.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/files-backend.c    | 13 +++++++------
>  refs/reftable-backend.c |  9 +++++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 194e74eb4d..f516d4d82f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2491,14 +2491,15 @@ static int lock_ref_for_update(struct files_ref_s=
tore *refs,
> =20
>  		/*
>  		 * Even if the ref is a regular ref, if `old_target` is set, we
> -		 * check the referent value. Ideally `old_target` should only
> -		 * be set for symrefs, but we're strict about its usage.
> +		 * fail with an error.
>  		 */
>  		if (update->old_target) {
> -			if (ref_update_check_old_target(referent.buf, update, err)) {
> -				ret =3D TRANSACTION_GENERIC_ERROR;
> -				goto out;
> -			}
> +			strbuf_addf(err, _("cannot update regular ref: '%s': "
> +					   "symref target '%s' set"),
> +				    ref_update_original_update_refname(update),
> +				    update->old_target);
> +			ret =3D TRANSACTION_GENERIC_ERROR;
> +			goto out;

I feel like these error messages are somewhat technical. If I were
reading it as a user, I don't think I'd understand what it is trying to
tell me. How about:

        strbuf_addf(err, _("cannot lock ref '%s': %s",
                           "expected symref but is a direct ref"));

This also matches the other error messages we have in this function more
closely. The same is true for the equivalent in the reftable backend.

Patrick

--480H3O4+gyPjOtTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhl0MACgkQVbJhu7ck
PpRC/g//ekYoUJ0a/MqlGVESWDSQFYrYpJgD+4xvspJWJFXgFqI4qbTq7NnDTdB5
YItU+YHPMyhx4zWUGZXVcxzxBQ5vGykGF+NMh1KcCRdh6Iq+nW1IrpeF9kb8jBg4
uXlvIWXBv+qWjKPcc3SPIGkcOIs9ZZwo8QwKT6JZTNiDRRp4TWMGqNtWW4ocAmqe
l6jGsmZ6TJZIRwxnZZNLF8sPDqQJV6FrJimQEg31KKoGOKHuxfEng3nY9q7Wwb78
NZgxoo1+NUEiSfAnb8s8+LVBRVScjfb2eSVeydqHSsehByL2hGLpaS2qw1SVjBu0
ljTBrFXAGlf2fbCGRiq2iHts2WHVAyUZ1WQdJI+VXT1EDzMU/EGkWC7m96E6RBC/
e2fKqYxfn+LvVFmKcN5iQxyUXINClTrim0HT5YmU5VWsxLv5dUXw8Z75dyeNDpLz
RAJWrm35j4Sf9enPmn4wV5f+JJXkN9jZYwnhbY+ihJptCPolkro1Ntbm7nPp4yfq
8D/YKWRU9lVsyg3All+xxXlcmy8GsJ/SwzD5+v+Nxu4bm3xFtmKizK4saXKmc2fl
Qd6Axt+ZpB5+7g24/r4M3qFZwfFdK+b+gnDtw7iouOjsqDJKLVjdmJW7GQnbhv1W
MI//lRcKxXxq3MPFEDhC2KL7wUd9iYI+8johbsrv0Zcsk2FbTFs=
=Mpf3
-----END PGP SIGNATURE-----

--480H3O4+gyPjOtTP--

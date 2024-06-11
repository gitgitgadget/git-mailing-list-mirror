Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A52230F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096543; cv=none; b=pDPCnDlteMeCxd/ohaXcq2V9lX7K2lZmzJNkjhPi0aEY+1gFcTWeAGF0dYW1ghyPyAGRhwuTtPi4J36HlAIvTWxJOkUP1yKp3iAuwJS99vN4TItDqVmyGsItjao2dJW1yBvSf18cv19N7XmYTWZk9ry+Juskf2gFRbPcqC4IhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096543; c=relaxed/simple;
	bh=ofXgaFMywROy6qv8W0d3BB8+8ypDsLTFvIGxUfL7Sjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nihhiW7BBJusfJ1d7T/XBof3FAD2LuN7R1pBE4EuUMkRXKjCCNYa9WRFfT4YGMEoi9RTxuVAw+7hyTjuBwnx5lVtg5SlHaHQV4Va4Imwy8F+AjX2n3HObxkhDjmKT80LRPNAYa4ykEmX3BqTfl8jKzu82N4czL6dRr1zlyGEE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evyAr/bp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IK9mEpQp; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evyAr/bp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IK9mEpQp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 08B2A1800099;
	Tue, 11 Jun 2024 05:02:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718096540; x=1718182940; bh=AzEqK3Q4Kj
	tRNM9aMCBHQTPFKtA6/jss/2LDbI7zkso=; b=evyAr/bpmLhRhpuIt3VCT1SUwJ
	6+goO8BO/Mm5EJqzU6Kqt/m3UrXHBCZPE7qHw1eiAXIEExfqm+7Lc39k7HyVhFcq
	D4OkO3DKgrKlZw2V5S9D8wHX5+gyHS5PJUU7931mtBxBjIYQTSE/8p3WAwCl607l
	BWutlvvZXkxSi3J8n4CEIGH6DjC/HiOGlTSAET/bd4W+eNFUbiNzxDj8guY0QKsS
	7b7nbLjg770TAf4vP5aC9xyLuDOkGQRYFzLOLNXE5egPhNF012yLhu3yS+3x8Opn
	84JTxsxTDOJhY1RY6Lv+LftqYZQTrl2Vs/yOsF3675hZGKMM1caXVfbzV3Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718096540; x=1718182940; bh=AzEqK3Q4KjtRNM9aMCBHQTPFKtA6
	/jss/2LDbI7zkso=; b=IK9mEpQp2Y8UMkanIFjd1qxJzVG0h/Cy28lZ7ho0AV8L
	piCGvjj9Dh8RJ7r1ccR56gAdSbMU3xJalZ3tbXWEib66oVZcB2EXT8lwXK7ZJOvM
	lp6t3KHz0M2OtCVe8i5Oj5/Va7H2AlBLqnrvh9yxnfJJK5ZTj3ICXdJ/KTdOidha
	XoevIS07gdwdbCcMnZzFy9e8y+dtospbJpbyWd4cN7gEsw8sbytDRdRFc3235q9q
	SI6bXp5nKkEsZLVCaL8EtwvbFI6Jmlq4niYf6Cphf9VvyEIVi4MY+bm7Gu03GxdZ
	D/PlgsQ2zQzuVEMRCd0GLJfaOOGfMuNvjv8keYrvvA==
X-ME-Sender: <xms:nBJoZmU48xL4zeCb21rVOikKbqOy2pLCWnm1Bj1Upp8iRHiT_5b_mQ>
    <xme:nBJoZindS3H8FJUjDpkpEBzxmNVxQmN5O1S7YeG3-UP1XNiZ9w6druVKBuDYKOv_A
    l0vCXH7EUe2hwK6Jg>
X-ME-Received: <xmr:nBJoZqZYLM3UOewEgtwAuI0gikJqXNVgD046Umk8_JvemrGNyLymbvwfUnVpHDdYMYewmj9qJXEoMZmV22s1NIbiHoUr4Ik4tgHs8YzVY8WBXXgk4KBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nBJoZtVOciWyX-1fZGi5--CfHWsN-Q8kBz6XFnQHiaJtfTno1HRoNw>
    <xmx:nBJoZgmzHkNplcu_pkw1OZyzb-ZuwDdFgLriNrmUdG0DLokN3tmyRQ>
    <xmx:nBJoZiftHoQMd-d0RsY5lXL31JlfBF2w5yyptIXhMnq69d1e17K03Q>
    <xmx:nBJoZiGVze5GMoiCGc7ZZQemyuhFAbAm5eQy698sHwJuNzDCnzPyqA>
    <xmx:nBJoZqgwk6K6qTILvcTlrdOuVwma0pKiX4LK63zPnTv07f6KWDjPuY5f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:02:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 249a8a44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:02:08 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:02:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/7] reftable: change the type of array indices to
 'size_t' in reftable/pq.c
Message-ID: <ZmgSluRGk-J_1K1w@tanuki>
References: <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-1-chandrapratap3519@gmail.com>
 <20240611083157.9876-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FUzoos1UJY7UFk2p"
Content-Disposition: inline
In-Reply-To: <20240611083157.9876-3-chandrapratap3519@gmail.com>


--FUzoos1UJY7UFk2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 01:49:19PM +0530, Chandra Pratap wrote:

This commit is missing a commit message. The important information that
the reader needs to understand this change is that `pq->len` is of type
`size_t`, as well. So that information should probably go in here.

Other than that this patch series looks good to me, thanks!

Patrick

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  reftable/pq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/reftable/pq.c b/reftable/pq.c
> index 1a180c5fa6..2b5b7d1c0e 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -22,15 +22,15 @@ int pq_less(struct pq_entry *a, struct pq_entry *b)
> =20
>  struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
>  {
> -	int i =3D 0;
> +	size_t i =3D 0;
>  	struct pq_entry e =3D pq->heap[0];
>  	pq->heap[0] =3D pq->heap[pq->len - 1];
>  	pq->len--;
> =20
>  	while (i < pq->len) {
> -		int min =3D i;
> -		int j =3D 2 * i + 1;
> -		int k =3D 2 * i + 2;
> +		size_t min =3D i;
> +		size_t j =3D 2 * i + 1;
> +		size_t k =3D 2 * i + 2;
>  		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
>  			min =3D j;
>  		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
> @@ -46,14 +46,14 @@ struct pq_entry merged_iter_pqueue_remove(struct merg=
ed_iter_pqueue *pq)
> =20
>  void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct =
pq_entry *e)
>  {
> -	int i =3D 0;
> +	size_t i =3D 0;
> =20
>  	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
>  	pq->heap[pq->len++] =3D *e;
> =20
>  	i =3D pq->len - 1;
>  	while (i > 0) {
> -		int j =3D (i - 1) / 2;
> +		size_t j =3D (i - 1) / 2;
>  		if (pq_less(&pq->heap[j], &pq->heap[i]))
>  			break;
>  		SWAP(pq->heap[j], pq->heap[i]);
> --=20
> 2.45.2.404.g9eaef5822c
>=20

--FUzoos1UJY7UFk2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoEpYACgkQVbJhu7ck
PpQyUw//Vw3TZE/K4MymGOupcnrzZmYayRymIDZ4Wj3w/SWBK1QwPedhnFkmlPLA
4vQQIoREWWKiPY7HKLoCwtEzt8I8szGfCKQjT/Wb8aGp3BBK49Wod/Cw4tMZZHmq
JFYGvNUt4+I1gApzfs4M0ZIWvZpB/CWeenpJAqArfMnMWFOzipdqsxaCBbW0+YuQ
ymnx2choBARQMBURQZACdmQb4zFrZLIEO4GfM01d23OxBp2ha85gUrudX0kMp1qZ
64wE9B/tt/jbsVdj4PexbzKgPH2sR4nb+1+BOCGv+S/el2ItL3i7EhJJDPcETf11
N3mALQ4Obv/o5eCx5pozKTBICkAZO94vqnCjKceyhfzA14JVJ5f7mYdHFLjnHTj1
OyK0RFgLqv9t7tBF/Pr2ldFngKiLLJv5pu0/XMuv4gqxN84UdRbZAkEbKnqxfomN
tyl+U7J3knAPwU0ZsqMHhM9PaIHSjbj+kk8BiawH6DKboP/sAIqpMAMPBvwG/zmM
FJ1AhzBjU+mPCqtSygJpCQ/Ec66mDSgjWDysy+xzcLi4GB8hz7YAjjxgHpN/Yowm
YI8qcTO9qP8QTywY4Iy9JN+gSgALVA6GDM23yTUvP6gpSIZgpZXNEA+LzVTgtuVZ
MOCJsoEfjAhxHHRbOvfiGGYgWR3h+VF0Av+gHNV5fTvAxrv3unw=
=drRc
-----END PGP SIGNATURE-----

--FUzoos1UJY7UFk2p--

Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4818633
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005007; cv=none; b=IfffO+cBl4Y86nTrsMxNE10U7HygpamuEgKKkGlPxCR0fQvj56qBhtyh/GG8zhXYo4/Q9xN+zjOoI1YgN+plmoD487uc4aKYL0jGOJpJjQmlkHf9pc2a+jrCjCuB8Q73eKA/DEeDBsA2dt15WoD0KrRM5h0Vdiev491al1QYOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005007; c=relaxed/simple;
	bh=2Gx35MSll0Qe83D0NVLjXci55r88rgSYwDC6skRrZX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW+RKyLKkC/WoRUaaAtR3qrdlqPjK5x8z7sIYsU+HlOfr30TRn53U8riNGg6c6e3x2VEVFjZJpkHUcuwxdeUsNldDuKg1YKV+IsyN3sr0Q7orBoufY0nPh3qH28idDqc24QXICtyAwZXwMhFSnmoExl9dkLCQZahJK60++DKUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mfcoyP7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUvEUasP; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mfcoyP7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUvEUasP"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4AEDE1800122;
	Mon, 10 Jun 2024 03:36:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 10 Jun 2024 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718005004; x=1718091404; bh=Lq3Mm8iaZW
	ThFpyZkAnao+ul9C3/vqwUHD3jTpVijUw=; b=mfcoyP7Bsy/i1saHRWfYQprQyb
	5qTBD7mvkdCaqO8+euRakzYFbwHdRFS4HGy83DdGM5So3uRPrlNyfS3qRS9R3Fx+
	g5SfazmbxehkJoZ1QbW3h7RdHYhYZQhedKcBGema/KdjuZPaDGTdYcQHB/hXrkSm
	DtKx1P/Ho8EmBMbMnT4VCalGH33o5VL9u8+jZ9BSK4msdILapi9awH+pFCDrgF7k
	+BXiEMMvETQlXklwEOU8Pch+qBgPZTHsmRWp3dX7PmSa5nEXe62zTeOd4EgRFqAy
	peYrJpHVB/CgE/F7ZTj4f7eeUnsrl7ZgJwW0lIAPxBNlXEh5s0yrz9fIMfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718005004; x=1718091404; bh=Lq3Mm8iaZWThFpyZkAnao+ul9C3/
	vqwUHD3jTpVijUw=; b=nUvEUasPfN8nNB0vej/GSSEvnEbY7JfvsxE+7xWuBuNG
	F2geif0vVbBh3MU5Zwmq373B6RzkIzceg/LjyUNKWI8Co27p/vIKe5Cx7S3Z4h8d
	b+kB+LL/+882SIzAR9WCD9obQF/7n9dF9Fqs49GOE+PwUg+3fymo7T8CSBqJ7iDm
	F34Cp9a3mDkVdCrm+9J14z1AIMDhOShTwbOCbSKkKfTXT2aOn0KcWmZfm8kxH1KD
	zVky4N6HGmKC8hlLAmhaF08MHnzKCAvFyoC8UuSdUH8cRMhfPBCAcNvnSBRZbfm9
	fYl5y13wckE6wG8Omr0+vhdhrxVop5RYgrIILC3oBg==
X-ME-Sender: <xms:DK1mZlUhOpS8QttEzKgmaCYR-5tiFZwHWBaUFiBFE-tj_c2LmmUl6Q>
    <xme:DK1mZlmrBA8OF0wGjcwPNuJ33RA-TlgzC8nvDati_QHYDzFjwQt7C53dUVAcwR4Iz
    v9f0ADr8qoklt6pSQ>
X-ME-Received: <xmr:DK1mZhZDW7LbmyB3y0HGutwtA88oqq1NL4bXDOnjXE5HyleDWHldNNoXuWXwqMGXec7CksxUul_eRRUBz9mfpqPWBCalaApBx-lVteYwMs9Tbhxj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DK1mZoXATCBkhrhxQervZdoiUX-YEdWol75Ra4JojmMUg_gTAsvpSg>
    <xmx:DK1mZvk6hcL5_SYY984Ee-LTmynS_aGB3zCuuWxs3VFcNwhKF_0W0Q>
    <xmx:DK1mZlduKFKcoS054pNuz39Y2YK5MRjUFTK5aP1DOURew2lbr4e7bw>
    <xmx:DK1mZpG2KutTemE7T9lfXDmRyvwwPJ4ZFkJvTqzoeAg_WXfVESu7Sg>
    <xmx:DK1mZtin-ZQSQzUoLN77GPGgNyu4mcPCHI8KYgrs32Mzj-iOYXuJPi6o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 03:36:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 268ad656 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 07:36:35 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:36:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2 1/6] reftable: clean up reftable/pq.c
Message-ID: <ZmatCKg6gbN3Aran@tanuki>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XV/vRrZodin6lDBG"
Content-Disposition: inline
In-Reply-To: <20240606154712.15935-2-chandrapratap3519@gmail.com>


--XV/vRrZodin6lDBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 08:53:37PM +0530, Chandra Pratap wrote:
> According to Documentation/CodingGuidelines, control-flow statements
> with a single line as their body must omit curly braces. Make
> reftable/pq.c conform to this guideline. Besides that, remove
> unnecessary newlines and variable assignment.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  reftable/pq.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>=20
> diff --git a/reftable/pq.c b/reftable/pq.c
> index 7fb45d8c60..0401c47068 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -27,22 +27,16 @@ struct pq_entry merged_iter_pqueue_remove(struct merg=
ed_iter_pqueue *pq)
>  	pq->heap[0] =3D pq->heap[pq->len - 1];
>  	pq->len--;
> =20
> -	i =3D 0;
>  	while (i < pq->len) {
>  		int min =3D i;
>  		int j =3D 2 * i + 1;
>  		int k =3D 2 * i + 2;
> -		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
> +		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
>  			min =3D j;
> -		}
> -		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
> +		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
>  			min =3D k;
> -		}
> -
> -		if (min =3D=3D i) {
> +		if (min =3D=3D i)
>  			break;
> -		}
> -
>  		SWAP(pq->heap[i], pq->heap[min]);
>  		i =3D min;
>  	}
> @@ -53,19 +47,15 @@ struct pq_entry merged_iter_pqueue_remove(struct merg=
ed_iter_pqueue *pq)
>  void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct =
pq_entry *e)
>  {
>  	int i =3D 0;
> -

Nit: I think this newline is helpful as it delimits the variable
declarations from the actual code.

I wonder whether we should also change the type of `i` to `size_t` while
at it, as `pq->len` is of type `size_t, as well (and further up in the
other test). It does mean that we have to add an explicit check whether
`pq->len =3D=3D 0`, but that isn't all that bad.

In any case, if we want to do such a change, it should probably be in a
separate commit.

>  	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
>  	pq->heap[pq->len++] =3D *e;
> =20
>  	i =3D pq->len - 1;
>  	while (i > 0) {
>  		int j =3D (i - 1) / 2;

The type of `j` is wrong, as well.

Other than that this patch series looks good to me, thanks.

Patrick

--XV/vRrZodin6lDBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmrQcACgkQVbJhu7ck
PpTqmA//WZ69fHlkQy+VFfDNCXCTZy53et3Nc8SnrgRv8yniIOgj4s/NWGnSJSls
xshHOtS8QeVYX/bl0+gPgXtcKkz9oAI/h97q26OZnyYQklHZrvEA8rAQcU22KL3E
1tr3LfMcBeb4dEsrz+w586gn8GWy6lCuDRzbusrrAzX9Zh0MrenWbDewyCtWSD0y
9ATsUbVOEcwZjeqGz8RlwtsOaeKxqbOPdfSKHy5BvG6w47AkVF1uEtWcWL+cbP0i
JmW0vP4Ls6oj+hZvvQ3et5X4mVrc3i/GCStzJyOJjmJLn6ch2EbmXmypZw8YWpiZ
Pkb+oWmQ958sd8sMxNeZ82FLj1e+tBeYh3Yh4ykvWEgSjGPxjBf+MLQC+lKH6fbd
BEodKBv6AubaTlKvMllXIqPTgwE8iBElsPZoks/3+FOEykebuMhnE9llrO95EU3Q
IkQEO2vulM2pcG0qznifUyJiXqiXyCHw0PDD8xS87l8dBAFln2MRBSKsND6XLmMC
LrjDWYT9vU4181ePZLFJmPHSL8XAwoi17Ifw7EHP+cl+X45GJ9Z06/RPoqpWat+o
JPV5Piei45Q8YYkcbzyYVlV9L4wbWrWRxcO73eHe8KN/IClQhwegeUMO6OEp9bV2
X6EuNLqwCqg/SpmUYtTTlERDS3PU+ZHXaxaaL5K0fSB0A9jaEeU=
=eVqQ
-----END PGP SIGNATURE-----

--XV/vRrZodin6lDBG--

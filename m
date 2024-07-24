Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6114D452
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810161; cv=none; b=FiZMkD5bRmQDdLtJ9fsG11aM83uYxVSC6Xcy0CIsFAt6qoHKFnOZFS1hKnGff0fu3vYQUaTvkCMYiGI/SspXZ53r5i+CXUpNo7+4t/eEFr6O7lKapwbm3oOvaTEKxIabYGaKoE1VoU9v0wP1if5qy/PC9GnF926Hp6hOckRfojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810161; c=relaxed/simple;
	bh=5nX6AMYD5XQ4279p9YIK7xKg5+FDf1wsAzayGV/SHR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oksco4abxoT9IcZ2B7xUagtV4rV3JdJwgmvP1dnQckc+x9GBso7z4b3K3P9rJNZMYOPobiNi10pmgJ6FU7lNU9/r/B5t3Khq7gmzxyx0GNONEKMhFk/vdt5xMKZLJeR5ClApx6exa3yAnsTLUwgZ/uRTFlRJbsyd29UqWdsy0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JBbckSw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpAvvUTZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JBbckSw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpAvvUTZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0AEC21140264;
	Wed, 24 Jul 2024 04:35:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 04:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810158; x=1721896558; bh=MbaavGryf7
	Ea/HDQBdhOzsgbOM+tvsOGkiRUpZdAPvE=; b=JBbckSw9Ck17BDmZHy1ADzPBmi
	RKHv5Sub8g6aGJgBMW+QbUx4eoORzZNZ5cvvnJxFcSLn2a3obRvl5I4A56HYzBjg
	S8/SGH0wDKOmRC+ZWDrTrXz6rg7GwwfDAnN96u9yKF+SxGmEkxfDGArfSYpL8VdP
	4P6xDAp5vvM8Hgzmkh38S0VBk9ClAn0kbH9ZKdWaDKjQcDC/doVnFy/c75dQaGEc
	N0XxRMFOynUl4rqZnfAz9/c2ylqaJ5DfCw+vmeHVj7fQ9M8BpsCcRVe6JJ3CNKSA
	qPlsby0Aig7uvLWtJ5MOE/bOZhIIJB6kB0UKVxII6ws7RrpQwqBzuHeMJnHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810158; x=1721896558; bh=MbaavGryf7Ea/HDQBdhOzsgbOM+t
	vsOGkiRUpZdAPvE=; b=OpAvvUTZ4be/5lPl7D0tMC74JU/YhTE6O3MigbD3ACQf
	UTk/0P356IPPuijIbJL3ybP7jj/3Fdr/rN+45Op+j/iEn4aLf9Csr1HZxA4NJogV
	4ucU4U7TCAjFEDiesQ5ecTembkXBXoo20mTb70afqLJoYcA5HjdRuWW2wGTfprDP
	4OBFvJgNTOGAszChedZxS6va1fA0sb0B3ueXPuTwhbsRPTAHaIJ4681uQdMKoZ35
	UES0UBv49GrVciNeYV5TRydIz9rS5d1GUUVVqYYWOINpCXdasdbKO/4DDRmyr80G
	27tBK2v+SKgqovtydJZUskikqxpnnWm+wBzbheAegw==
X-ME-Sender: <xms:7bygZkGIdcCNHJEQteV1ouOYIZ9jDnkjgZPKiXFq4haMPx-496IoJw>
    <xme:7bygZtWFV8y-oq0wzS9dfRRQUdiyI2un4hVoK25sJivXsOjXZZvMHqqSD4CUzVwft
    faONfSHDRtxy8GNSw>
X-ME-Received: <xmr:7bygZuKxPbH9H12aX_NRNtioxAanF154oPrxz6xrOhQBDtX-OuTAwX7fvJdcXZNNaXg5XUCPiPgisfUopFrofFTubR9Qd-I2-Gx_LYpasBVKsS_f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:7bygZmE1USLZpD9oSDU5d0zMoX6QKgwaCevZkWtRYq7EsfoesgJVfg>
    <xmx:7bygZqWkOCJHCdzT1xjnbIelUA155h6iwwcWwsqxrPWn_18bpZgP6w>
    <xmx:7bygZpP0DNVcun8JadWSbHRZefD2byxM7a72Pxni8gml-hVGs8sjug>
    <xmx:7bygZh3GYb436eWEriBlGpyN351bHTD7il7DZ4k3BEazlo3QgemU9w>
    <xmx:7rygZpQ5eg6EipzS41DRykUmfEYqu_EXl7xU9rNM_EmTqLOz9O2XOVMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:35:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 21febc7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:40 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:35:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 03/10] packfile: fix off-by-one in content_limit
 comparison
Message-ID: <ZqC86t7YpVhdmLh_@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-4-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kUfmvd8s83ZXKrTr"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-4-e@80x24.org>


--kUfmvd8s83ZXKrTr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:12AM +0000, Eric Wong wrote:
> object-file.c::loose_object_info() accepts objects matching
> content_limit exactly, so it follows packfile handling allows
> slurping objects which match loose object handling and slurp
> objects with size matching the content_limit exactly.
>=20
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  packfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/packfile.c b/packfile.c
> index 54b9d46928..371da96cdb 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1558,7 +1558,7 @@ int packed_object_info(struct repository *r, struct=
 packed_git *p,
>  		}
> =20
>  		if (oi->contentp) {
> -			if (oi->sizep && *oi->sizep < oi->content_limit) {
> +			if (oi->sizep && *oi->sizep <=3D oi->content_limit) {
>  				*oi->contentp =3D cache_or_unpack_entry(r, p, obj_offset,
>  								      oi->sizep, &type);
>  				if (!*oi->contentp)

In practice this doesn't really fix a user-visible bug, right? The only
difference before and after is that we now start to stream contents
earlier? And that's why we cannot have a test for this.

If so, I'd recommend to explain this in the commit message.

Patrick

--kUfmvd8s83ZXKrTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvOkACgkQVbJhu7ck
PpQlxQ//XHSQhuq8KbYPpwYMuQLv4jnj3h94HYPUXSB5bW3Wziz2efT/HWBf1QOq
bVAivDDzR/gcInm9UhkbB1LqFUXq2lNay5mklOnx56w3r7+Nc7DMCfLX7D2gb4sl
3QpnUrrbBtidzPJWXNn4PDf1YB5mcJHec7c3Glm0eGfP04TAyHBGYxo9iA/keRQ/
O5XIU1jzglX6/n+PL+o+OduqTnNyIY7Q74B2SEaHyOAKiZn6T1ooer3jprCiluDf
DdWA0w8A2aZRjECYQedsqpose1XRhXQnNIGuklYiA1W+7UHz2Wqy6AxjdSrD27jU
NXGXuWfuGhB7olJMNwGeo79+0j9kRFbfeDJNW8NARclt6RfVH+jUVvvBRc4xDHT1
SrVjuERxsb/KUQWsk91CZjje6ndmrtfgtjZfJbuUWqHoexwIWfZYob+yCaowmHx7
0sPAIHkRXkhMJ/SfJUlHMCYgHsi/fvFz99cO5Hv3tgzIL1B3Ve8MNcLNwiCq2nzi
sSCc1ATVxSmTw9089Z9M5XpZSh/iEKXsEQB0IBb1caDU+TUmpEVVVg9O5dbZIYXW
bGaxizdx7DpBUb+3vHJU8rBjSAT1mQWoLRlt1ZgqdGeSxwmwRtFMlBM16+0e3RE6
hTb8ETGZEP5FRGzGHaoDpiXkdVsNAcaMCAVaGdMVp6PcJXmLzk0=
=9V42
-----END PGP SIGNATURE-----

--kUfmvd8s83ZXKrTr--

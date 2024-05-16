Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6B145352
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857778; cv=none; b=LicZKSI/hsMA2g2rNMpxFinMblVVwSrXR2mCDPoSg+toqAsi3bRq2CgnT9pzZAW6JslNLJPclpPXp+dKMCFxQerzumJS4BJR6Cfap1oB8SOWLvWQyRfLGtplG/cBJwWRv6nb8WLMAqsRuUmB5mhYfahnE8EFts6JQkzfW85VAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857778; c=relaxed/simple;
	bh=+Zrs9rur2S+JQ6ptvIpdf3wogRfAZWXQx2TEXcF7PhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsyBT2hbCbp2bWeNc1MyMzCb1gGlTlYpeIOKnv9jRWg057NON6BjgMRv+3sXGCdSczXmskVJHH4QjVArYoWMyvgD5baxwioNnANUj2znAs+N5ZkPd/8yjaVIFY8x+kwG5bEghmapaQcZKvCX2i2FQK9STjGT0kmlzBpbEKCcNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k1BmMnEv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fEH7B+dz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k1BmMnEv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEH7B+dz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B0EBA11400E0;
	Thu, 16 May 2024 07:09:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 16 May 2024 07:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715857775; x=1715944175; bh=PrFmCv/0L0
	HTGCbj8aJ4vtQlPMi7zNWNQCVmOY4/UHs=; b=k1BmMnEvZCPtU9LlePJwDOXk0Y
	l7VhKn7m6aX1itvq2iapT3qZy5qCtqeM+LFAJkxiDV7GY21jOafHStst37qjdAn4
	q/huSRK2tlYmdZLwrymTgJWDlC1nxy6e3wew69fx+pf1fZyVXdGC43lAJqch9pS8
	zVaaF9o64HZfJOUNjp/P8R7I++qrBQFOnUDOovG/5jn9f1eGjrkv6urZzYfkGdKS
	/zKqAS7zMK42y2YkUoL2gwWSZkR2cVEVFNfA3fbxpa0VSAXOwsx5Laid+45iFDuw
	3iI3X6gmXUzFJMTs4JPDVGcC+gBBY4TRvTeractxDpG4nD372ET8wtIOUeKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715857775; x=1715944175; bh=PrFmCv/0L0HTGCbj8aJ4vtQlPMi7
	zNWNQCVmOY4/UHs=; b=fEH7B+dzAUguIPRxjkMmmJuD7z7nW7ZUJ+DqNGorTmHc
	0ltR/l88Fu57jk8kwkDAoZf0aRjPz7u+rDD1Ef5bxuZX8L/GqU8NCOkx51GmmUnV
	1MARzIJ2WR6lRu/KPns4/Klxm1ufcMOYDwYq8506tQEoDYxRd6S0+SzHV/kCYDmO
	xaWnTKk80NCGnIpNLwiOvJg+gdCq0UmSKmK82Bo9AYCerDCqSSwGjVINFVFeAgIQ
	6wcRT9fenrB9F+WlIcDKj6rowjAcdYSgqn2YK25AzOGh2FCbifZPgNBtRg2KuPos
	7P6zNVL2NGH3OauMZ0AfrCK0B6H9BuMgM50/e9guWA==
X-ME-Sender: <xms:b-lFZu73ZjwMSD9yUtUgBB0Z6x4OSgquCshNR6s3j0la6l_Copee0g>
    <xme:b-lFZn6A9XU4YWruURlkDUbkQbz9mCWbfL49DGYLk82XMsDcZWIAWFNA_4qPix3Gn
    KZgpKiZMKuwTnCGiQ>
X-ME-Received: <xmr:b-lFZtdBgXoVV4nNuXIycVMK5CBnWFU22DN_tCqz4PSCe5WZHv0UeD0ioeRcwEnSWGhScOVJaLbvGJRoactw6bveRsX05LWFr4e8XIo4tPUh-GE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:b-lFZrKeR7Pqn1ZFTlD3avfpijCK3NxEkwVHX51yzyenz790gAzujw>
    <xmx:b-lFZiJCbpLFo4AFGf7ikuuyelRxwm7SqzKitPH9XbdrZ853Y836bw>
    <xmx:b-lFZsxQm1yxBL6kNRv4_ITX25y44m-xq3lM7KiERlsxCzrvQOuTHA>
    <xmx:b-lFZmJAZs-wkBPKz_0b2aUXovtcXV4Cz87987NLoqj88pccwJwSrg>
    <xmx:b-lFZu2DWK69Odys7OCAWecbm4jhOmBl_39Atv6Hf-2QCK22NMsRK8Sz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:09:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id afa44a13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 11:09:09 +0000 (UTC)
Date: Thu, 16 May 2024 13:09:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/6] update-ref: add support for 'symref-create' command
Message-ID: <ZkXpbLPGgdqy6YJk@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-5-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lIRsDsaJSeHqI2Xh"
Content-Disposition: inline
In-Reply-To: <20240514124411.1037019-5-knayak@gitlab.com>


--lIRsDsaJSeHqI2Xh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:44:09PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> diff --git a/refs.c b/refs.c
> index c2c9889466..6b724343fe 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1302,15 +1302,16 @@ int ref_transaction_update(struct ref_transaction=
 *transaction,
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *new_oid,
> +			   const char *new_target,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	if (!new_oid || is_null_oid(new_oid)) {
> -		strbuf_addf(err, "'%s' has a null OID", refname);
> +	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
> +		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
>  		return 1;
>  	}

Shouldn't this be "'%s' has neither an OID nor a target"?

Also, we again miss `new_oid && new_target`.

> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index a390cffc80..cc7e20431e 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -468,4 +468,36 @@ test_expect_success POSIXPERM 'git reflog expire hon=
ors core.sharedRepository' '
>  	esac
>  '
> =20
> +test_expect_success SYMLINKS 'symref transaction supports symlinks' '
> +	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
> +	git update-ref refs/heads/new @ &&
> +	test_config core.prefersymlinkrefs true &&
> +	cat >stdin <<-EOF &&
> +	start
> +	symref-create TESTSYMREFONE refs/heads/new

Let's future proof this and create the ref with a name that matches our
root ref restrictions, like "TEST_SYMREF_HEAD". We do plan to enforce
those soonish, so these tests would break.

Patrick

--lIRsDsaJSeHqI2Xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF6WsACgkQVbJhu7ck
PpR1/RAAkKDLl1ZtKvFYGIOnUZsO3VWyJGxS3GC5G4LvbzeC1PU619cHfM6SMOIJ
sNmLreNC6Vm/QrVo/PEbe1xW5zyu+7zyegyGw9FX+VIgtZqr2ZN7arSyb/InO/1I
FtHQytgAGcVNWCWkp4ih6tym3j4QiApBZXbw8xbffFHtrF8TLg2K8pNFy5ZVe8qk
CywTIagnFUZBqp3LnYce6R3JRVWUoSl3XIWfpRqdFb/7I+6TV2effwJVTiqQV21D
cLn9Di9d8Qs625y+scrUeRw1JnyWd7DZK1J0/f9poIr8uVgcRiCb3wor7gG5YOoJ
lrIqtmTbJ+v532YWDbn8Ch+c6SE41gH2xv1BXC07yo1JMKxvNBtoKbmcaXIoMd1B
qkAKqHKLcekYH6V6JPWTisNc6aPTlzhngqfWs5GXgZe2Y2JqZXLMgGMihVz6MJdd
FRVzqgMob1D4ZlTrdTJNwUbM7dY93eYb7Lm6Tpn+IXWCxcZMKQc7IrpKuS4gx7yJ
Z9it4UQLg4omI05tlan+ttCVEpOmPfcrEvGe2DdGentqRk+XwanqXXp+W2SrCwm4
W+7Kj8uJQlP3Pni0lx6LA/Cw2+7D9vu459TLgCkvxeUtZT8kgpcjG9VACojYBGp/
+EpYrchj/fM/ntMCU80KvLjeJ438zTSHzSCpqEnsk3LcY2pWxPE=
=QWc4
-----END PGP SIGNATURE-----

--lIRsDsaJSeHqI2Xh--

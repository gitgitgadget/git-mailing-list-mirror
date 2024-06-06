Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8981667E3
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674544; cv=none; b=uQJB50jqc+h5fiawfqw/uLU1BaBxKqo3vihNNolI7KP8UczJEGgLZ25ZM3kbdwt6BDjZqCIUaMjVr2VVteyCso3sLGl0reG57VVi85oqyinx9DKRAt97L+wNSDSkO66x7+nr8/GD4qrrjQAcGjGkJn2nZ6TSpYG+R7xOEV1ezfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674544; c=relaxed/simple;
	bh=RBvE6Z21ZYONuwdskmxetuxFw/i9AGpHehVJKSVLL0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jue7RZ4gPwKLl5l4+kpVMfuyLhfpLL46qEb3Ya10pEMcB50hgh8lhsn9Hfde54OMW9ggP0v60Sk4G2Np8gxVdvHGsLNS6Ey63AvPpJ4SAXCEbCJQ3pCYzJ5+QTjVNWy+omY+S2iaLiYr+llshY0KSX23WPwiA7SA5eOn3n9IyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wpl3T5+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPGi/hUl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wpl3T5+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPGi/hUl"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 85C6F11401E3;
	Thu,  6 Jun 2024 07:49:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 07:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717674542; x=1717760942; bh=ze+k2h+VGE
	9DU8SpKXBkHWzJOJ6QP6lVjta68T+tSu4=; b=Wpl3T5+poFe25OLzNgrWmaj/Pb
	N1TW3CUKOSr/CH932fQO77co2gGPyPUNohDcyTQt2Epz4H8SzLxcR7jGwIE4Ompy
	9J1gMYshasSuiG2NiTcu4TG3NPdkWcNFU0RD4TtvBH/NsMyG91WiRFEq01X9fIBX
	7KbfrTOhaI/bikSEidRpvBrr36FFM/mNPVxBZ16FWGDZsT4ZSLOzsTHOS2pSffVn
	0TO2sP1TN5YI0e8n7tWrxbjE2iD+Fkg3Ru3gpyLM947kez1dtSKvOypzlF2lIM8Y
	3q+oOVd5jqkL+EACeqWB861a9m7ca2tjz62sQeWuMjUVuWrE4A+XUxu/2k4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717674542; x=1717760942; bh=ze+k2h+VGE9DU8SpKXBkHWzJOJ6Q
	P6lVjta68T+tSu4=; b=DPGi/hUlwZM32s4SEzfqBE9dUFhbpAou3DwqOfanIssp
	sdLOYMD9nvkdLHWanqNnIO0qHTvt1dr6UZ+7bK7EVmyL19tCypgNzTrNPreQrKmd
	nWGYwfsxFmhMGFcXJ4GRBPFtRIaBzVUXIqfuvB0VBkpFwN8fK2WPboA1lM69+Uk+
	/GK9/ZRrmv8fcBlMyyxWvrKVedgyR+TqKv4cF/k8SwiF1fxYmGMYPUAxGlZS7wXA
	fXDlSKG7teFsupNCulnQjV5Mfp/jqOY1N6nqkB2HxptLpB0VUaJs/nhabyx2VIW8
	FYKf24Ru1tKDbZ4KZktXt+8uJ/sEurwU/WzpYgCPsg==
X-ME-Sender: <xms:LqJhZnpbMybG4V1DhlGJ1hHVw2WDFF7vlNUV9Qw-6bdpxSHcEAF-xw>
    <xme:LqJhZhqre9CKAtggOvH9xu0x2ez7k6hvPdj9cXe7ktWjH0JVPRix_fRUoK9vhToBA
    f23ByJpkArd9NGMWw>
X-ME-Received: <xmr:LqJhZkOOuR8_g48n5AUM-dv_JARRjMUmIAQ3oDGoVx9BQ_7QVd89Zwk5NFNhYFSp6PAFOIQoEYJsUK9A02UaBFLa0Gzvi03aqbR6IePbn271dD3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LqJhZq4webyV_wQFYWpJO7mtnbvcI0dSh7v6y76GzGgTqbHFt1gLMQ>
    <xmx:LqJhZm7SASKisloEx24Jttoy0nUQhy-sCelZ0nuL4H6tu8H3AUA3Lg>
    <xmx:LqJhZigJJAAhyqZMCuwlWWOBBZDXIv35AcE50v2VXxE_9XAPgPH_gA>
    <xmx:LqJhZo5nDwOfvEr4qhFvi7Axpyt0SmiVBYHJHdKxxDCDjORt5A3UlQ>
    <xmx:LqJhZslrxXYQjHVqMZNQ1uKz32mDlvRJQCGiRYgGEkqeWDoFSRUwkWk6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 07:49:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e2176fe7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 11:48:30 +0000 (UTC)
Date: Thu, 6 Jun 2024 13:48:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH 5/6] t-reftable-pq: add test for index based
 comparison
Message-ID: <ZmGiK9aiSaXX8nXR@tanuki>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-6-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ImkkBsSG/I2MLoYU"
Content-Disposition: inline
In-Reply-To: <20240606075601.6989-6-chandrapratap3519@gmail.com>


--ImkkBsSG/I2MLoYU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:10:49PM +0530, Chandra Pratap wrote:
> diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
> index 30bf9cb492..6f6bf58307 100644
> --- a/t/unit-tests/t-reftable-pq.c
> +++ b/t/unit-tests/t-reftable-pq.c
> @@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merge=
d_iter_pqueue *pq)
>  	}
>  }
> =20
> -static void test_pq(void)
> +static void test_pq_record(void)
>  {
>  	struct merged_iter_pqueue pq =3D { 0 };
>  	struct reftable_record recs[54];
> @@ -59,9 +59,49 @@ static void test_pq(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> +

Nit: there's an extraneous empty line here.

Other than that this patch looks good to me.

Patrick

--ImkkBsSG/I2MLoYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhoioACgkQVbJhu7ck
PpTSmQ/9EjZpR0PpGgtHgZOHKkvlzdqZUtyLclNzEUFUiWu5LrFl7qzVMwE7823J
4nHXrq/pn4YfZRh7sb04rrNk4FV3GQEiYETVjw9cqnAHM0rbfIxusxt86JhSVUQ8
cWxvIlMr0wpJXiZuX7qno/lfXWePaiytk3A3jTSg/ussGqDHrabDchSfIcP0l952
/vZggeN6LSuyr0B9NqbrxRzld5B5gvNud+VyGUshMsirzXy/n+KlsEvJmsl43yPM
ogOg2XIqNTW24ktnBSkwAV8YPYaLz3xs8exQe99xj66v7Rqjb/QSN1Xpg3p1t2K4
s3CEDIovx+GRkYh5kQzyD5oILPLMzM5d49h3u3gLackxRqpIbTkR+5Qk0VW5HOT7
smRCFK041hup/CrOoqlzCYIhmRlaxE0Fy9mAikVnqv5fSwiPWFRshp2ke2/dnB38
6oKeYlqI4Wm81qwYogm2GU31mu8KDqBm6DIkKsN0WolXt/9GYW4cwG8wDEFsQGAR
GZnmTVkTothYyps63mGUNx+hJQU45L0cnQfLtyAAJDwsY07w90n/ZF2B3kOLcmQE
rTuhf3dCiYevM2Abv4aM+/1FkkvhyLVicBC7z0fgkNUB5U8Ahk3DM/dTiISiPfJ0
4YUV837tIwtPBNNbi0V05XVec/dpzEGQQUh1DuT4RZ/npH6bI8w=
=za8+
-----END PGP SIGNATURE-----

--ImkkBsSG/I2MLoYU--

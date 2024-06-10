Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBAD5FBBA
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998955; cv=none; b=D/J85Hgn3/i+T4Xq2lP0a0hTQYn0vv8howo5JUc4arGXtoX6CITsqWJkiQnQ6mL36V0C6fk2fUD8HCZsSxa4LIhxiB0+kqCSlagrOPOm/vR4cliRcHjutXBzM6sxISQQWHdCd6Gjb6pPrsBXP+mh54yUczsvhnKFndDQLhFA6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998955; c=relaxed/simple;
	bh=x1QoNjzIGNsNvtYKvegies4ZYj/KPG/SsfKtTuqtQ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgcIURA090cBnd7z+9evcoBIdctfVVLURIPHw8eyJBh6uzpAsyhZpLez98XKs81I7+PCBBNJw7l0MOA9BrZU3030ZWecR8HGGSg22qzfSUOSyK00pQcR/guBbEAqPYfElImH6KeqFqNR/vLZjhF4gYiNb062evSuTJqgSKrUn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G02Vjwqy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NN5kQn8f; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G02Vjwqy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NN5kQn8f"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D34E1380152;
	Mon, 10 Jun 2024 01:55:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 10 Jun 2024 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717998952; x=1718085352; bh=SPS1Fj22b4
	CwgySty5Z5YTtYoiOqeEjct/7p2MG/HXs=; b=G02VjwqyeYGyQYpswUlQ8evpYd
	ds71Mt/sHGZHdIRNd8Ems04sOShCSunYnvdwngdFOTBz+7CdJ42ljxQBhZKckf1p
	ecUcciViF4b7n9EHfG/HBXZmUg/5oszgbfzYZlUMfeH/Pir6+AW7CvN2N7df1pTB
	P2iEIPhQLwkpXJu0XNQRfm9tsXkH0ag/vyh4gVD2KJFKKfmt3+vZjWM7pN0lB/o9
	5ZtEWvMQ06ygOSglv4BB2vNajpldSE/I7/7Y6BogxMNs1/bOLDdMVhPV3dyS0Rx+
	5+5VsJLQ+lOB2ZfeYLR6Fjl3igykw43Amq5Oz/TeX/GMbEETjiTM2yo03/8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717998952; x=1718085352; bh=SPS1Fj22b4CwgySty5Z5YTtYoiOq
	eEjct/7p2MG/HXs=; b=NN5kQn8fIHNnyZhL++udzQAApsM0TLfnCuRWCbu1n1nr
	4eV0TsTdyRaTTr/4ENm9qLcyoetCalb8yGQiX8T5URNvhuwekpFSAEL1uMn2zgMy
	SZKQQ42sl5VLEgOhKlskGBfidAtFDibcBcPT+2puDiPMUeND1w162mMRQyBunczP
	81WA9BTd2BsKcyoZ352WgLrc3Xl0oDzpPFHbC/OdJBlornXWdUNlVdL2KT5pTIck
	t2mkEcJhzMDhBh/yRMOH8SwWX+6wnDQ1dLAystoOb1nS7RboSDlLLsCLb2XWU26v
	dxQuXK81RkCkOHdGJTbpVf9YQzJaFhy8tqWTTd44zg==
X-ME-Sender: <xms:Z5VmZuDVTTGqAp7KK6wa6dqggTIZY4zDVtcWyVn0dJphEZKREs1JMQ>
    <xme:Z5VmZohswZ7jqHI0aBr9scMxF5PkdWr7swMPVCt-0KguXRzxcmuB1uOuLyl2YZL5Q
    OA73ypYJkDx9UHrpQ>
X-ME-Received: <xmr:Z5VmZhm-nVRilX_qVaCjI2dbB6C3f60dzhMn_eVxVfPWG5nVbKqd11E6nqbFO9Jxc0yg64hNRmb6LCiar4zKSukTga6O-fcm0WAg1O1tvjx2nVpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Z5VmZszS4_EzwKojZ-1qaoSAo_C_t9XOvH8VFsrakc2q3ZOdh-bV0w>
    <xmx:Z5VmZjTNtyXE-BjkejiUuEJPsSc9E0qYdqNOAi7AYu7coSbU_MRabQ>
    <xmx:Z5VmZnazdfbe4xjopxdNOjJ1UJOqAxzBEMFCK8Mb50uX0RL8UwEj0w>
    <xmx:Z5VmZsT-vuaD7smZRDkbs99BLjJEXcPEoG6J7VoeetP5eIufEH_kBQ>
    <xmx:aJVmZkKKGB6vmMvc-s1TIedbWZmrvjZNwnuJk95xwqbBzgdoScxQf-QY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 01:55:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 540dc8cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 05:55:41 +0000 (UTC)
Date: Mon, 10 Jun 2024 07:55:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] pack-bitmap.c: avoid uninitialized `pack_int_id` during
 reuse
Message-ID: <ZmaVYnmgyAr0vapK@tanuki>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9dhMIui6bJcj4WO"
Content-Disposition: inline
In-Reply-To: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>


--N9dhMIui6bJcj4WO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 11:27:35AM -0400, Taylor Blau wrote:
> In 795006fff4 (pack-bitmap: gracefully handle missing BTMP chunks,
> 2024-04-15), we refactored the reuse_partial_packfile_from_bitmap()
> function and stopped assigning the pack_int_id field when reusing only
> the MIDX's preferred pack. This results in an uninitialized read down in
> try_partial_reuse() like so:

I feel like I'm blind, but I cannot see how the patch changed what we do
with `pack_int_id`. It's not mentioned a single time in the diff, so how
did it have the effect of not setting it anymore?

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index fe8e8a51d3..8b9a2c698f 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2073,6 +2073,7 @@ void reuse_partial_packfile_from_bitmap(struct bitm=
ap_index *bitmap_git,
>  		QSORT(packs, packs_nr, bitmapped_pack_cmp);
>  	} else {
>  		struct packed_git *pack;
> +		uint32_t pack_int_id;
>=20
>  		if (bitmap_is_midx(bitmap_git)) {
>  			uint32_t preferred_pack_pos;
> @@ -2083,12 +2084,21 @@ void reuse_partial_packfile_from_bitmap(struct bi=
tmap_index *bitmap_git,
>  			}
>=20
>  			pack =3D bitmap_git->midx->packs[preferred_pack_pos];
> +			pack_int_id =3D preferred_pack_pos;
>  		} else {
>  			pack =3D bitmap_git->pack;
> +			/*
> +			 * Any value for 'pack_int_id' will do here. When we
> +			 * process the pack via try_partial_reuse(), we won't
> +			 * use the `pack_int_id` field since we have a non-MIDX
> +			 * bitmap.
> +			 */
> +			pack_int_id =3D 0;
>  		}
>=20
>  		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
>  		packs[packs_nr].p =3D pack;
> +		packs[packs_nr].pack_int_id =3D pack_int_id;
>  		packs[packs_nr].bitmap_nr =3D pack->num_objects;
>  		packs[packs_nr].bitmap_pos =3D 0;

Okay, the patch looks trivial enough. I was wondering whether we might
want to `memset(&packs[packs_nr], 0, sizeof(packs[packs_nr]))` as it
feels rather easy to miss initialization of one of the members. But on
the other hand, this might also cause us to paper over bugs if we did
that.

Patrick

--N9dhMIui6bJcj4WO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmlV0ACgkQVbJhu7ck
PpR3hg/+Ib2cHgDVT4uYQLNA51e/KDamkmkxesGdo86338UzDyIUZSzyYVwvKsJS
Nd/L9YKnnwwb0VTyGzWkEmywLzbIWn1y9k0Js5sP1Azuqaz46jN8jabrQxnlMHIz
lRnn4QIcyvxQ+nfBius85/cyg06p/WN+zKkYSabXJK7bp4uzG1Iv8fcyreIr5bMV
5sHpFsvrGf6R4+U6RBPPPDZl1EnIsP81Efmmz9NG4enWS97UYTAqJTa1USvKv5Lx
tjrjHyL2ea/revZ6Xu/vk+4rvO1D41ZNZLrwCRZKhDAWAnQ2tV4SarZptbFJ9qQ1
Q9yFm/H59o1zsnK/ABZ65D6Z3wSKzoMYwjZWYlDvhj4LTR6Bwlpq5+1NFjOrqX6i
uguUjU+XfbLLaehyU1HQxotDuIZ1dcdP6Gz+JQ/aMf5SulnWV/awbTe7X8zPsLSs
V8qaJs6UuWRfrh3f7OVHZlbib79yVOYj+1SITTIb+lkMbmGzEjLYwxDocB3Vdw7P
qDx5UUp/sfxCkRzD6TWtM/1QAxo/DVXQFySyfrHO8UcpHSDjqFeM+9PAGVV7FnQR
ZVNy+XUZGpvyzIcghQygYyclc5GVXkVEYDk99QUsaFTSt8ceKbRZ+jMyUEpU5luX
8lY6oz9mvZQNY83I3yyWul3GWrlX2Y6GeZ1ud3IWsGSee2bDb4c=
=tm8r
-----END PGP SIGNATURE-----

--N9dhMIui6bJcj4WO--

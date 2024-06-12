Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E616DEC2
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185234; cv=none; b=cSgvkUKF6isuCExHHGLEcJe/ABv489HWoan1o9+6c8mClXD7sYHslqRCMr4vfa71wOtefMXWMdbqxB7TZ0NOSTPCBuZTU/2kfHbIQGldOBsb2pAZpdkbAgtA4XywH+gXYmfnrdtvK4yYFqFj54EfBk7zcU96YP6hhnK6D/b71t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185234; c=relaxed/simple;
	bh=551poSfk0jSAMpTOzayZYyAOr75XUxcpg7siWG+Y1/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE2/mUgDTT3eL56DfHdbaKNtWUoaWCaA19ZfP0Sc1ZNhNdPPl10TnGD3HeNm+3jp+4AiJyyvS4wN/Q++z4CzF5xzyG4iLARUp9NdhRdmSfZaPwrYL9FZop7fTpgQmKv22tGGRbTgRwutsaHgt4a8BTSHIxmMcEB8OAG1n2qCGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gZ/BbfqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4BaTv2n; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gZ/BbfqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4BaTv2n"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 29B2611401E7;
	Wed, 12 Jun 2024 05:40:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 05:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185231; x=1718271631; bh=NSmvjB1ZWy
	paqtspLunHQAKqSskf0mNOzE/Mi9+0eS4=; b=gZ/BbfqHDKE0iEAsiZZ9GYsYfE
	GtAnbyI7JK0oFK+YjPnLQhnmVnc9Ffv82rvCbvsp5tkYk1X3pd2lxMZj5S585pwe
	cmiJxJpCgUykWY1aG4ciRjpwcByvsuMx1Ui+7/pQGJphD/ZMkMqDUY680Rm7wOvz
	j8/JDefLQnEv1At7+FMcYirlofWtqe+ZrJKK/Z6KeBVYIiWrP03bPS1cJdqKd+HI
	/eTSnlCyfxC/dJLttE67KRzoY4X3LD9ba84DDJyfSjazsJpYG28iiiYQ4YUeVp1a
	3pel8i8v3zgwg+aD/Qwph1EMXHdLTaMZqosDZWXHti6Do/zSfAwHV44bhKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185231; x=1718271631; bh=NSmvjB1ZWypaqtspLunHQAKqSskf
	0mNOzE/Mi9+0eS4=; b=M4BaTv2n8vpE2KiUzR2rTFEHWFx+lVVvOEZb8ubxjHr+
	iuTyqUBsSxdd4EKpxGzDdnOmk1UNugc1TQJqMCXRmWQk+T/Eh5pQB8Y+7vM800ht
	SPYa7QlCMC+ufOkHCbgZg93qW54Xfd5bpNK8Lqc4Oj6IsgEsyDP7+5OXI4iS95cr
	dv5eyykcEXZUtkCaWp2GJF1/ai2EY21g/Zqv0xi4LpJ0EjKX6QG8HqFT1Z8ycy8T
	4L5TBnAWMvWgb/BtLG7/L3arUjojS2jbW88Hr1skByy0JHX8HYhQoS+yiXlmMd+8
	jmfYwlxzNxq+1MpKc72hlP2N3Lh6yRGMqLmloU3fxg==
X-ME-Sender: <xms:Dm1pZl3ji6uZfLXitrsfF3vVTDCaWmv-7DJ7inZDU8aG-erh2Z_CEg>
    <xme:Dm1pZsF4h0AouX_B2jMvQSkBIxqZ9MBDAK8osmtjZbxVKJFilSKutU9MXkxcm3_Uv
    NuHNbIK6nl5GIXLVQ>
X-ME-Received: <xmr:Dm1pZl4oeNf_CLBO1hA9VMPhfspguP3sbc2yfsMz_ka6uF2XQ9NwG25K6-bHKVlWTfR60uv79UK8SAqWGuA3uu9efzVe9p7lV3gM6jaz8vK_GnqRNAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:D21pZi0Q-bELllcaZR0DEg7NBdh4gtDu3Mr9nA2jhoLtqMnurFe9Jw>
    <xmx:D21pZoEVVLcgVi63JwOjPR5FQimwX8s7xSwBRfX7Hj4JK_1biDqPkg>
    <xmx:D21pZj-q8cvbtuTHABKBb-WU3nnLeqRKCFJgvvFELF8N2AmekRJPmA>
    <xmx:D21pZlmoi_texFYGgNDZkxWlLAehRKvKlmu0c7-sWqW_N0GkTpB6SQ>
    <xmx:D21pZsB4pwRKjy6tRdLUskBfdCf1neUk11B5nrJjmPKnB8Z2wADwQAS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f14e8475 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:16 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 02/16] mktree: rename treeent to tree_entry
Message-ID: <ZmltCIoeYgRdj-CN@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <4558f35e7bf9a1594510951ee54252069bdcfc5b.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nXFJkDTaXb75FdTu"
Content-Disposition: inline
In-Reply-To: <4558f35e7bf9a1594510951ee54252069bdcfc5b.1718130288.git.gitgitgadget@gmail.com>


--nXFJkDTaXb75FdTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:34PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Rename the type for better readability, clearly specifying "entry" (inste=
ad
> of the "ent" abbreviation) and separating "tree" from "entry".
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/mktree.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 8b19d440747..c02feb06aff 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -12,7 +12,7 @@
>  #include "parse-options.h"
>  #include "object-store-ll.h"
> =20
> -static struct treeent {
> +static struct tree_entry {
>  	unsigned mode;
>  	struct object_id oid;
>  	int len;

This reads a ton better compared to `treeent`, thanks! I've never been a
fan of abbreviations like this in code.

Patrick

--nXFJkDTaXb75FdTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbQcACgkQVbJhu7ck
PpSVEQ/5AXlW8mEqo4qGEFw7JQhRNu4lEtxoaycBNl2IkrRUUoex40EhsWqK2Y2N
YO2TMY6CKyPnz4FYxlmdqZISIPZzK/GPcC3pcf6VM3zBdOr7/MGd0CUrd7+YmspD
uja1QgbKpHkg4Eb9oEp4NgqUOwURm1eUuDs9nHZrQdixdoKX1204f8pw86lpokh7
xl+MIKQgUyZBHmcLNWJtmMcQX9v8SwSlPtsZUJzLbutuhYNXmTfCCdQrqx1hFZXt
bt/YH6kl9dVaFDeS6d2EWc8pwIao4lbS0fhwvvcquPjTz6CJyc9iuMxMtQoGeGIv
MX5X9QkHk6nYS9dr5YglLF7Ae6FWfU/mJVn6Gp79GFKCkXPzQ+gEogfMYr0S5Pk1
1RhVpKAoDD2YZDbxa1V/uOhAgk1FQWAOMtJpgmiGb+nnD5t4dkfI3tQvTGG8x8cj
GI6571tpgmxIc5lKxeHCtYpyuGKF33Y0/kHCDUXhLh6JeH0nTg6Ml9hkNTPdYsx/
lgeeRbUxl8dok0rGVwqcZx2knRIcqfFJcJu4CY7c/RdmtosJwuw7l2CahTIKjnkO
NpqHuSRV0GCzO/xg/FR9Kz15HhlYUvxdLHtyoYd+LxTUluzUPJzYBH+GPpyXF1Qz
FRrXLjKkWhN5F31r+UGxcJBqwH5+aPFULmiM1QoIG3dYWzwU/xU=
=FGFn
-----END PGP SIGNATURE-----

--nXFJkDTaXb75FdTu--

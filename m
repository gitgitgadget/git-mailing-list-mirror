Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF26ADE
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342600; cv=none; b=mgCsrmrOEET/jn4uMHSOj04G95AOVznJljNwhe3Qn6hIgmFP9RlXbcgjIVt54zvSX6U+bGxeJ+t4XObPm3yP4fqMEhHKQzK6jEhez0ADpYPJqzhDPhylYq4SjWHagDgJ9rM9SqwPMo3ZEI7wizTTm9rlx7lQzruFvL13vKuKpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342600; c=relaxed/simple;
	bh=3CTCxN87+0mYorezJqCwZwVlw0gOny3s0dVN3xC78kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp7I+SAZmW6YTBXiG6yABSKDx0ElA3CT51kgTme4S/w+cKvEkSLf0l1kPA+ceeNrXow+cm9X0UDFub9aJyX+dbF1BxrZR/uCABfOY0/NvhQvgP6s/LfRgFVdPDM0VYs+QiPXuedqZh03d8csOa+ZUbASBVIGtXxIfbe0JTD93s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zlx/em2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eadEGp4A; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zlx/em2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eadEGp4A"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 124E81C0012D;
	Fri, 14 Jun 2024 01:23:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Jun 2024 01:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718342596; x=1718428996; bh=XWb/quSV1n
	TtnwdbLVsILLsE8BoJI6xy8OZypxQoiMk=; b=Zlx/em2tTrGy/lwTv2rfzO/eZu
	ftDpiPkXw96u6N0R+mNTIHkxWNdtCChpnTKTXJ4PKXR5/bDQW3HEGeaXbQ0E2E4j
	Yyt3CZCG2R9BJKWZHoY9rseYdkJ5hOY7sg8+q5Q7KZ9c4PtlVXfsdKgrIlde8GL0
	dd/wmwQideWWKNxsZ8++eriJA4MQ8RBUUcBrOFPntP1XYak5stvwx/EK/K2901xj
	Lt4B8kSKoYheV/w3H3cyBaeWrj4E3AZRQvsf6Um4e9APrgZ6QrSdccikZuWPtviU
	9DhL2v8yEjSD7rxiEZVn81FvauhBHkGBlWA1EC36xwAPCoLgrr90vDO65pMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718342596; x=1718428996; bh=XWb/quSV1nTtnwdbLVsILLsE8BoJ
	I6xy8OZypxQoiMk=; b=eadEGp4ACYKGKE8PyMcRE8xTCVovl6LVuVBTmNCHhqr9
	m+qx1xXlN+0gPheX3J4jSL0ui75woKAz9ba/hEu0sVJAQ/DelAi9Ynqi2W+YlCRX
	qkB+HqPYfPdtDNSYklqHj03PDz1j/BMsyNKulV5XhfxFfbMps7sSmneQ9/nZbZ/y
	oOpSBezP2rxApDCPfY4SQ0RK1zC1bipeZI+/gIqbZV6fAX5n7l7tkCTsxwlMGZfV
	4+aDTYhoz4AWuyyU7Tk+pQsD2TkQJEJLy2Je/JJDXTVbsxHF+7aQvcxliaoZuwsh
	5Hdoxm/KRqTTJBif46mkvC+NKi4efh6Y2Ifs4xaMGw==
X-ME-Sender: <xms:xNNrZqzKMUoyijX4H0EYqMmtrshxwoQcnqmwglVFIaXp9bBPS0qp6w>
    <xme:xNNrZmTvz5nMpc-bRxC3blv2aHouwcFCpKopZkaJ5TQyNdtPrsnC8MwH5o_iKkjfd
    g1SBouZDWu9vIBP4Q>
X-ME-Received: <xmr:xNNrZsUdLa5inE-SLUPKchV7_rrzme06tc3rPvldgX8zkpyaiU_tm3VjjVxmd-u3Z0q8x9O885o7Ge2nVm_NU1FR-p55-6h-u3aExGzJ_0BM5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xNNrZggXdD5sVjVUdEDR8RQ1_eFYtFc9aktfaKp-uBS0qGz37VvosA>
    <xmx:xNNrZsDCwkt29EXqrgYJbh7ThO6Hq6r6Zk4sivmk3gs4mgZScmUgvg>
    <xmx:xNNrZhIIzMbizLLUe_74TeQygs4jl-Djeqy782ShGoYoTjo55aQYWg>
    <xmx:xNNrZjAtVXOjK8u07bpH731U_aOkiC6tRymOYntgrbkdtKH5wZiqQg>
    <xmx:xNNrZr5ZRgpdnoqrRgsiYLU6LiTmyZTi_H7KMAkKX9U9QP1KnOmynXW1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 01:23:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 37cc8b60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 05:22:58 +0000 (UTC)
Date: Fri, 14 Jun 2024 07:23:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 08/20] hash: require hash algorithm in
 `empty_tree_oid_hex()`
Message-ID: <ZmvTvtYXIfvzVc5e@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
 <4858cca25fe9e57c984fc3181fe8498d0b7222b0.1718259125.git.ps@pks.im>
 <66763b5a-3ea6-481f-b4d3-5fad76f5da0c@gmail.com>
 <xmqqv82cn97d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8bBMiu/CCDJ6Sx4"
Content-Disposition: inline
In-Reply-To: <xmqqv82cn97d.fsf@gitster.g>


--D8bBMiu/CCDJ6Sx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 08:39:18AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > diff --git a/sequencer.c b/sequencer.c
> >> index 68d62a12ff..823691e379 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -2263,7 +2263,7 @@ static int do_pick_commit(struct repository *r,
> >>   			unborn =3D 1;
> >>   		} else if (unborn)
> >>   			oidcpy(&head, the_hash_algo->empty_tree);
> >> -		if (index_differs_from(r, unborn ? empty_tree_oid_hex() : "HEAD",
> >> +		if (index_differs_from(r, unborn ? empty_tree_oid_hex(the_repositor=
y->hash_algo) : "HEAD",
> >
> > The hunk fragment shows that we already have a struct repository
> > instance in "r" which we should use instead of "the_repository" here.
>=20
> Yes, but the same "it is better to make a faithful conversion first,
> corrections separately in a later step" would apply.

Yeah, this is what I'm aiming for. In large patch series like this I
think it increases the risk of regression quite significantly if we also
try to deviate from the preceding code and do the "right" thing, even if
it is seemingly obvious. So I rather do a faithful conversion that does
not change the behaviour and leave conversion away from `the_repository`
to later steps after this series.

I can amend the commit message to say so.

Patrick

--D8bBMiu/CCDJ6Sx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr07gACgkQVbJhu7ck
PpQ1nxAAobUXJmE8RrOtEHNtJExEmJIAdUpq3X6St3SoHAVLNh/2oLJpnm24sb/k
rY9VXvXZELm9W6Bkn0RBtRJ/gw6DpWCZwxcOOx9NVpqBYUi8NZHDH6jea8XLIwi9
DMV0qqNDaBXzST0K6+YSg/liHGeLWEY5wuMKJAj3V3nJ49ya7p5R/9YZ59JNN+Gi
W9G1SDZ2kKCl1Wwy8+dYB48kQZCVVOAx0f1R3XVAugbST0NZ02IB82I0cDmsRJS9
KUIckRBSsT5m52yA4hIW0IQ7AX/a5HVUrwGWrwqgIqo05O1+iouLzlYdy3aK5Djs
YENA3F4ier3pTDIghMhRlEvvh2skyXOnKTpNkm0ugR7a1xrTAVTUgDEJZ4jJg8GL
n40jddtbzGmZiuqnku7jagspHR08eavXEZRTPxhXOHAgYCSIoERzh/zxThpFIbdq
w7AxAr89LMSoOwCnj0YtEZngukWtxdEI86gptrDBZ11+FQczX5P+6wwptffMMugN
rlu64DRBCOCY2Or42IsvaAa5vjsGkklb0AzQg0iDXeEQDxk2lkRa69KTQBLYY3Mk
t7wRqOF6btK3hnz/VxMtrRvOv0y95SxmxIIfEkjxJ5H4JL6VF+4+w6no+AFdXvtb
eNyfsVEKmhKQo/NgVIF0D78aqv7bAnxsSPDujgX4+NfoQyPc26U=
=CAdi
-----END PGP SIGNATURE-----

--D8bBMiu/CCDJ6Sx4--

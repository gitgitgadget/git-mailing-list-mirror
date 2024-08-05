Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48B156F3C
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863296; cv=none; b=BRzcagvsV3moDDaAJhT4tMigb3Zrg5JZD4rwiEtmYRr+vvmQOb2uaIvUG3sr7h+IwtxpAMa3L3lFS3ujw8wyJjYvc8NYSjSMm8rYJUf4t5fUc2k3J/Ujsedyol0YaNTiG5dDHVxyuZKdXC6HVUa+xl+KGFu6ofvIZk3JlD2NIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863296; c=relaxed/simple;
	bh=HmVi895vZT8rqBuueQd42lp5zDwDvvhpqsz8c7UCfMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuxnGwRah9Mc7NMxcKYNBGY+H3MbhdQvnRsgmVUyY8WLaBJom2ZzA6A6DibcI09bMf1MrhbBlQLRFzvK5JjBbXFx+78FqTBERpLdNhX3Yf3YmAP06eSwwSVrYV7VfKoSrjbjBlyXqlKCKVFqXnxLuyPuTrYVO6/nMyvlhyMn1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BGfoH0Vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ch0AzQ7W; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BGfoH0Vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ch0AzQ7W"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0DFB01151B4D;
	Mon,  5 Aug 2024 09:08:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 09:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863294; x=1722949694; bh=MByDtItTSH
	DNYOCjK/fsP0Dana783yODbOKgrg+J16g=; b=BGfoH0VxY+E8qfE3yciAtowaeP
	lzw1nVb0xfaj7vHW8BGuK3tnlkdbCRgQRNLHxDGITHJdK6SvK5Ek8/J607YjvnVH
	qFOXdTUFcbU2zq1t/LKNN4KiwUPPRzMYC6qBgl2BQJo4+HO450kvcgbCf8mMuPYx
	SBr/uTaF4wz4tQCmd/qMa2iDiuMccsPDCc3GJTI2yLWFTLPjCxq6p+HovE/LLZzZ
	E5VRVj08Bk0Pu/12IQYFpkkFdvIo9ef87VeAZvCsi9jfYXBRaVJl6UteLw4CKq8W
	HGu0W/0p2CfHGvkQE2xwxBWmcXstwH4jAcV2RZjhKb2vOZbQngPCDh2Fq7nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863294; x=1722949694; bh=MByDtItTSHDNYOCjK/fsP0Dana78
	3yODbOKgrg+J16g=; b=ch0AzQ7WlE+jukD9x5XJ1poyDU6TLo3bx4AjKMFYE5Ii
	22m0ug2GXzCFWFwZXlOp7fcPeAqyjYcJcVLgRNqHm7jncNUYE4NHdvfnRVqBnmFN
	jF2ZGJQ0z+4IHgAaWQPt13+ArwzNsm23zc4bWaIg6h5ga7vh+YiQZUQ0dwXk7R05
	Xxg9b+NBytrmuPy4aKOwCPJhFXtrFGKKJcbZw2eNHY2/B6VJZd1xKC+iRcbl+V9s
	0bsyf2IT16Yfw9Aq+7kFneU0ReUfRd4LkyzWgY5h05gQbgUB7GGj1pU/WUCH6U/r
	V1EtK6K+Lj5FhDzbsRzYioeFk+hm1o4tFLN3pzxvWw==
X-ME-Sender: <xms:vc6wZsOeW6S7jidU82stoKTEOfPnuy9O7nt5ugDexxkZm0KUrAYotg>
    <xme:vc6wZi_nXwmwtdpstkjiTnrThF6YzeqtMi7Ee948WjudZlDjbZ3d_MuDH_skichkh
    xpAVp3nqyX90DuNqQ>
X-ME-Received: <xmr:vc6wZjQBPgBBUnOcsdCnzpkOquNHwy_rohK2fah11LfLW3-26wcfjCiHa3ljETQR10kovzNzjMU4NuBpRZ7SY93E4_195RK2N0476z4Mt77OsMsJKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vc6wZkunTkjSzL8n6IPbGAMGDZyRKxMvdaWKjkJ1fbUjAQMNUzlkSg>
    <xmx:vc6wZkdhMvPs9HX0alVVXUVh9Ebr7uP6ZTJsTLiIiolpW-TyfuBO5Q>
    <xmx:vc6wZo3RM5CNylYNE_w6XG79Jf5kRmx6p-9nobszuSLSMN7IX7xGHw>
    <xmx:vc6wZo947tpGA9TzulF9vz0GUBX57O04KfU5K2YLjzrLLqCOcOENBA>
    <xmx:vs6wZs773YdC30fHeZu1mkQiBF_T5znE_Ps2yAjdnc1EE691nW2ebPs0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1550fba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:12 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] reftable/stack: do not die when fsyncing lock file
 files
Message-ID: <e411e14904b4381e7631662c54d22024e04c3996.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="86uFRkTIEinbFfl2"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--86uFRkTIEinbFfl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `fsync_component_or_die()` when committing an addition to the
"tables.list" lock file, which unsurprisingly dies in case the fsync
fails. Given that this is part of the reftable library, we should never
die and instead let callers handle the error.

Adapt accordingly and use `fsync_component()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 07e7ffc6b9..9ca549294f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -674,8 +674,11 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 		goto done;
 	}
=20
-	fsync_component_or_die(FSYNC_COMPONENT_REFERENCE, lock_file_fd,
-			       get_tempfile_path(add->lock_file));
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	if (err < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
=20
 	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
 	if (err < 0) {
--=20
2.46.0.dirty


--86uFRkTIEinbFfl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzrkACgkQVbJhu7ck
PpRMcA//XGzMNdyNUuRSCnhfdio3m6dB3F5rVcDs1BqKCes6Ei95efARCn0/A2CP
Fq6/m+b3y4MHJHUtSqbrYJr6iusS9/xLbF0Ijl7HfWBsShs1uVQlocjUdAMaXVL/
Xy7Etuh0G9Gtyh0KVpv7Kl1cYm5ZeSWsPHH++Wh601iWo7YUVqAK+rfR9Y9BB5rm
AzofAtPuA6ysYYhFYUbYFmclJubyiYADtOvd1ayM6j0j5OQmXnwFEsSnt0whZqnR
lsVK9wBoaor3CQcg/ZJ8/OZ9VkJF4T/KFUAZxEiWp/T9Tdqz3bwGwjDdNJEi9t9J
e/leWtdOzMtG3YoHnVOE7/SOqSpsx6+qW3xoXVUJgr4o2pFJNOnhhoPGrhSgyqMf
VPgl0GfmhQeJKpSVyYCGBPA4Q50D21qYd6ekJMby3HmK97dh99zItJItWx3qqzRa
F7kO60c1Rue82LQjn0LUwEFOVJOsPxi0p1KxkBa+lTZJSJEwSgdPbW3mlYOKTjKl
bB6BOEf3QuIaiSTnqEgxAiLKBfvMqEQDIdqxmEpB7OjmhIMNpf3bKi+ZAmVIxgtQ
fO1dMlNRWko1giiJaz3v0qsH/iBySzt8Tq3HH15h2ecjKkYhecqwq9v2voqODa2r
6ECs098O7kvyLJtQVbQ4R2XJw1jPdNAd+WSj4CoHhnXYdVt+Uqk=
=QFOB
-----END PGP SIGNATURE-----

--86uFRkTIEinbFfl2--

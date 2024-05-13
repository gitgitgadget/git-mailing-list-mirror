Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F19147C90
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590062; cv=none; b=UXQEUE3HGInVxYe1njWixtLzN6zPrgIVUJP8ib3yevDB5eUdNxNWJUDl1Cg4aE0FsmQYf/e0a/u7MFCg1WFH1n2nrVcxwAIuknCWPjfb0YbXv+UdSzVRmgw3bAhEw6qj2FFbeJuFX191tOtgtxq0bHRwvjz/fd15E1Nm/K+9Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590062; c=relaxed/simple;
	bh=f5g//odyxIPPYJFGH6Yr+dyJ7Fl7NlPYBcsbQW1QHQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIlnesqi4vqNc9nPo5CmTE1C45bvC2SYOIjKNfElIXXS2f1id8GrhDZNSgUfUxhQIbk6PRWjyr1/fv00kFxhmVxBZWOuMk4modxTGw1Nf6+PZ0CgrHxLAJ7BJHFDaVY2SfeBBoWg4DiKCWb0drcfI1IgT4dbItUeYEIj5gp+GPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qeGIM0uG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzoRQ7KF; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qeGIM0uG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzoRQ7KF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 08C071C00065;
	Mon, 13 May 2024 04:47:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 04:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590059; x=1715676459; bh=3J1xpdU/yx
	LirvvE9eG0ePjiXeKADZYaJnvQ3BHX0Iw=; b=qeGIM0uGYVqrvBZSJYKntMSF/E
	gHG836jLOVvZAfz2OzAJXdUfO6m343JVlU22sXtY1vSkKiQs6hiZSFqv6XEUG2hF
	4NjvpwCJczh9UPSD2VeRe8L4JOkhr6lIeHOMftfj9BO0ETvp7Am0zXYYSuENU1pm
	/iTnwRGfDKsmiQok8mwIePyYDGhj2UN1p09yqQ3e0E/5qBDXaDxxWAFV+krjYV1l
	xyr1PFNtf0ZUOkoZFwR2tTZFu1P9XbxWEgHkLdESpDjeiVQx1OJEiRN8o4SB+AjG
	kX68pGvXT8uHN0LJijj5+nHaXDPlpvkuyxO7MP4luIRQdfqHaSSmK2/qD9HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590059; x=1715676459; bh=3J1xpdU/yxLirvvE9eG0ePjiXeKA
	DZYaJnvQ3BHX0Iw=; b=QzoRQ7KFIW4FpTiIy1w47POuLNlvuauF94u41tBRFMWc
	LMyk5Rvs8vMGjfDYT/0vLdEN/LXx02ryqX06AdOy0or6qL0PyGjlCyDy4pFzmqff
	hzsVi1IdwTil7nmVja7n5+tKGCTnPkAUR2We6178qoTTP7W66vMwPnKUei5eYJRG
	dmTx53C0VOVsYIUAoqLgMjnHSgonp/O80a5osRKiLvtz58PO+2NWWSnyWhdlr+FM
	Hq+WMIY21BtL90XiZWO0n3C8vjNdRcwk1eyH5wdP7aIOWhiEFuryVTYWaocUVPKV
	V3VHSxgGzd4RCYcnG+qIO/gJ+ZryP0DBFMlvMQ69NQ==
X-ME-Sender: <xms:q9NBZqRbPJE8hvJq3L4CiKEjf6Oe3YJbcewbyjEJmcyrfS_KT2tgHg>
    <xme:q9NBZvx4LgylBrxLpRutEerDfXrqt2PQoN19E2ItMRgEBfeE_COwAUqWaoqZ-dMTL
    Q42F8OjrqXviv3Eqg>
X-ME-Received: <xmr:q9NBZn1DLPgm0w8HjYqQLiwMqOi7nH4MU4dMImMNPsRXvjeJ341mDni56aH3wvPF5P8AufRCjOlLs0yGnszwCTa97XZwuBmnOXQ72P7VN2O2LKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:q9NBZmB2mlEsBuzmlarjsvJOztRv7DSHJuW3MMv9KU5T1bSOg28qdQ>
    <xmx:q9NBZjhr4iFrNoaYPutw1cdpyhl7WI1kxkS0NlnmBsr1vb32uqxL2w>
    <xmx:q9NBZiqTQsJS9rIrkekSYPCZq8RpO0fT1rCuo6J--nIWa6QhqRZydA>
    <xmx:q9NBZmj25Q-dKMyfyqBQSpZ3mfiRS_BjIa19VlO7UV2Mevgvkvl-Qg>
    <xmx:q9NBZgt0tqSkDtWCOBWYvLyg4BCa8sEy_e4OWhcJ8ihfKihMJY4NoNbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3c40a12f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:20 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/13] reftable/merged: simplify indices for subiterators
Message-ID: <31bdfc1e34079dd79ba3bfd39a03eacaa2929762.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TZYBDC2bnDMaDiDI"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--TZYBDC2bnDMaDiDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When seeking on a merged table, we perform the seek for each of the
subiterators. If the subiterator has the desired record we add it to the
priority queue, otherwise we skip it and don't add it to the stack of
subiterators hosted by the merged table.

The consequence of this is that the index of the subiterator in the
merged table does not necessarily correspond to the index of it in the
merged iterator. Next to being potentially confusing, it also means that
we won't easily be able to re-seek the merged iterator because we have
no clear connection between both of the data structures.

Refactor the code so that the index stays the same in both structures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 4e1b78e93f..18a2a6f09b 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -37,6 +37,7 @@ static void merged_iter_init(struct merged_iter *mi,
 	mi->advance_index =3D -1;
 	mi->suppress_deletions =3D mt->suppress_deletions;
 	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->stack_len);
+	mi->stack_len =3D mt->stack_len;
 }
=20
 static void merged_iter_close(void *p)
@@ -236,21 +237,19 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 	merged_iter_init(&merged, mt);
=20
 	for (size_t i =3D 0; i < mt->stack_len; i++) {
-		reftable_record_init(&merged.subiters[merged.stack_len].rec,
+		reftable_record_init(&merged.subiters[i].rec,
 				     reftable_record_type(rec));
=20
 		err =3D reftable_table_seek_record(&mt->stack[i],
-						 &merged.subiters[merged.stack_len].iter, rec);
+						 &merged.subiters[i].iter, rec);
 		if (err < 0)
 			goto out;
 		if (err > 0)
 			continue;
=20
-		err =3D merged_iter_advance_subiter(&merged, merged.stack_len);
+		err =3D merged_iter_advance_subiter(&merged, i);
 		if (err < 0)
 			goto out;
-
-		merged.stack_len++;
 	}
=20
 	p =3D reftable_malloc(sizeof(*p));
--=20
2.45.GIT


--TZYBDC2bnDMaDiDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB06cACgkQVbJhu7ck
PpSeng//ef9rKQclPTGUjmMD700AVBwVuJonZXk9CFTeowvraGpdCDS05dSsflTA
YU+hrZx9IjN5bhU8VGJ8jOdmaiKqrY4jFa40r9i3V0r7gntfZk7HQ+sdP8Cnc2/m
pUsHBDMgCoQhLr817Y2aTtIxe1mF69J1cHJ6xx+rcM3idBzMs8R22GIrVsoceMal
iMefa2cNm+ZaJXbDcvnfG1wuK2D4fr4TxfvvXEZ5VuLk2BNjGWqUtHtkKQgbP5zU
ECWpiBp6JfalFvUA5frvkc3BiMERMIkNnbreu6MXcETX/F90KSZtbKuyvUoX8+/C
LplyuEeS8Z6APKKLBpdZOvL8Yb2MRbMiWJwz1sgLKku9GhQs6bL1ikiDZOQ2Phoz
1SIWmNXzDUomr4KMLpZxp85Y6EvNm4a/3p0ORATFAVDf3F+u5qBz2m47xHpVe2V5
HYtYMtc2hdswYuKG0easG38Ji1nUCTjSXrsta8HfR1Wv296viFEwesUyEuSAIq5x
Wn93dkqcBS/SvZ6qiBET+rFqDygWI+KgOSpDLz4Nw7Jd2gjmZF/IGKraTFbTQ2uR
lQ2lL+JbBu7oT1UpXdc0CvtqEzu4MzUhjDF2WGt6kHMULeusql0ML/zDfVjqDF77
tNMwujT47mw+SdViqQ+kRKImbf65PiJmB6BfSIymZ6Jdp4lMiI8=
=76C8
-----END PGP SIGNATURE-----

--TZYBDC2bnDMaDiDI--

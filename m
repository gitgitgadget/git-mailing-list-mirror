Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EC127B6E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201361; cv=none; b=APPjrKlM7mtJr6xyUUx09guxrUI45L9IsB/ejcZCP8cu5wefxwKC2hvbZyndPgK4wyH2TB3ggIEtM86rhV2s6iGMUrYhzP/+EbpXG93eHNAWtWZC6020sY4L+h8pTTP6BYgl64WZYaepTMdt77mrRjWRfhfY44EWtpCSZhaWnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201361; c=relaxed/simple;
	bh=8K2UDYZ1S+uKVhF14x80Z179r8eyQFEezvAtty+ZPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7Mcn0NV/cVZwl3ewsqD7KyK7QZhW6bEesmcHCdnki3LRCycKVz49uBrdtRlU8VE/9mo9//jiSkbmxD2fgcMdZOxUVNTwngVHfDxenpMAtA5DrxS20SqPurbCVXrhAM9mcVESmNSk2C9JnYMSIZd2y764UBGOvl4ETxvogabZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AY0tmTdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nN22M4BE; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AY0tmTdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nN22M4BE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4A7FF3200AAA;
	Tue,  6 Feb 2024 01:35:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 06 Feb 2024 01:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201358; x=1707287758; bh=UlFQQ4rNOj
	VH/J9GTkfpZo5/BAPIrVJII/b1rWxmosU=; b=AY0tmTdZqq06iLNxSv3yYjO1Mv
	wimr6ajcVf0JbgKz7N/ejwdFUjx/JTrWP+j+fWHgXKJg6pB2cL7KoGERRCq0opDD
	i1CRCm6A8sbebh/xR8WWhgCzhxuSNxmOLSCBKxeeHcQLct9sxwaLDwG4IZe3ZFVg
	MsyKSDqfgn3N0rA4ys8M2ggHnTWW7rv7ikwbq/UuIdYZGEsJ2l79npISJEfh3CU0
	dkqKIisEsml5cYKLPH/5AMMqYIusbMb0YP5XO1i0ElY5APTihYEna/VIGUphewNk
	CgYIpuysHt6kWHsho8DYcpgWIlnmczzFD0kDfezj0Jeekgm9+GAWO6XmDhTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201358; x=1707287758; bh=UlFQQ4rNOjVH/J9GTkfpZo5/BAPI
	rVJII/b1rWxmosU=; b=nN22M4BEhzSuZV+Sdm6JBqcVk/9TAhS/bjBFcme2uqSC
	+U7mxkwpe99EaA4YMhWaSdPKnL70nRAL3AAcBosDSurUXqAlSEPO6hytbXuAGRXb
	A+WVgMUtkupsNURhR7LQAM5BZ9pmtA8z/ZSjXqX9HPZyU3V/LVcya24saWnKkwar
	SKYoTCZcCYVI4ng0SwY07rdc1t47t42vD2Sm9mEchKquH5YxRCOHYuXlTJ69Fh9u
	V4kJg4I4NZdWgTRrhQNjGUdbzgeXUrgXagWCa9ObJPF5H5COLfmf6l4kMKAyQesm
	nu9wPKxgyMB2GC5WWpOOQlLcp+oclZf3E9/mJEQyHg==
X-ME-Sender: <xms:TtPBZaABWDKM3DpfhqmLLocqW2bVXPUiLswIHXs8Z4KMx5YoOtxMoQ>
    <xme:TtPBZUiNZAjZ36EecmQ2NTRIBuaAITD1Yart6nwql8Mb3sT9ti722zeJMBg3_grB-
    x9t4L4KhZSNzau3fQ>
X-ME-Received: <xmr:TtPBZdkvf49csQqu5m4L389QWg8EG3qy28hsdSWUMNLD3WfbWp1TlU0HZVZvEbR7k45eF7FDe3QtFqwC8tp6dPQI8bp6TxRznbAlR5lE_AZWssi9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TtPBZYzBE-39h0Xy-8fJqJZs0j83sX-t1Qsvetiv72-qDYIcg9emYw>
    <xmx:TtPBZfT0oMK9FVa7T-X5hwDbR74mCyu96LCrj2Mjo3ntHl-yfweKTA>
    <xmx:TtPBZTYgcmQe7LQuDIsW8CT2Sgv5KyJ8z7TsTJQ_U6W9AACVXV_EKg>
    <xmx:TtPBZdPnspUnxMokBXJmixDK529gpVtLX39piifyWK5BTqJhaQSUqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1a299bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:27 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 8/9] reftable/merged: refactor initialization of iterators
Message-ID: <8c35968ce82666e2fe0c055699e7bd1ac4de0de8.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4w+Lx0cMMXcoKSL/"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--4w+Lx0cMMXcoKSL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor the initialization of the merged iterator to fit our code style
better. This refactoring prepares the code for a refactoring of how
records are being initialized.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 0abcda26e8..0e60e2a39b 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -19,24 +19,23 @@ license that can be found in the LICENSE file or at
=20
 static int merged_iter_init(struct merged_iter *mi)
 {
-	int i =3D 0;
-	for (i =3D 0; i < mi->stack_len; i++) {
-		struct reftable_record rec =3D reftable_new_record(mi->typ);
-		int err =3D iterator_next(&mi->stack[i], &rec);
-		if (err < 0) {
+	for (size_t i =3D 0; i < mi->stack_len; i++) {
+		struct pq_entry e =3D {
+			.rec =3D reftable_new_record(mi->typ),
+			.index =3D i,
+		};
+		int err;
+
+		err =3D iterator_next(&mi->stack[i], &e.rec);
+		if (err < 0)
 			return err;
-		}
-
 		if (err > 0) {
 			reftable_iterator_destroy(&mi->stack[i]);
-			reftable_record_release(&rec);
-		} else {
-			struct pq_entry e =3D {
-				.rec =3D rec,
-				.index =3D i,
-			};
-			merged_iter_pqueue_add(&mi->pq, &e);
+			reftable_record_release(&e.rec);
+			continue;
 		}
+
+		merged_iter_pqueue_add(&mi->pq, &e);
 	}
=20
 	return 0;
--=20
2.43.GIT


--4w+Lx0cMMXcoKSL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB00oACgkQVbJhu7ck
PpSrHQ//ZmBrnY86mkLBMie6sd5urfin2HY9xB/Tu1684vKZ/g+ssoGjR6YpmSpa
+DKhs3sU9PmpBgjJNe1WQXehFyCrReoMC1PY21Oi9c36SOpPJ0VPtDyIzCvDKdRD
Ac/X0hixtBtC+w/VZ0kQr5EP5is0Lsw7/NvEeJrtOILvN+ywO2rjlzZWe3G56hry
cX44rNtoesDiS34wNRyELfm6O9hMrb3HvRCzBO2ugRLiulylWchkgDQzyYwPlWjE
/P2l+M34ImzimB1R32pTBJ+zQKCVnll8FYrafuaEkW/dAgj88iHKlGQkjzszC+pw
koj1Sj5Vy7v/5P6CQDn8L6U9hJfAvw72bq2yCrjTkj9Qv94/MgHNVAzJH9/WxQlQ
CqG1tYWBF0lzpaW22b/fZgzS1p9dQUH3bMHsR873cJKict285ce/2dEacuZqjURi
vXdEf3Z7n6VEl1/u3LkchtHtxHWOIRSMajtBpGRQJq+7ovGlxfzrZol52djgKQ+l
pN0+FsZp8M66Q//0m2jEdd7sUipvYg2BkzFCgFMKaPcm2CtihC+Ov5sOfgndbNTo
c8/Ap0y+YFkl04uAwC7T7v3xAu0olE0z/inMOmV5UiHcIW7mPN3E4KZqvWuUqSNl
a+y8WpyM2OayGuEEbbdTbDtPP/3lwTvTbmAbGoq/C308ipIO/1s=
=NH4+
-----END PGP SIGNATURE-----

--4w+Lx0cMMXcoKSL/--

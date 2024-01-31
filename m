Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A464CC8
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688097; cv=none; b=ueK44uL4WT95bqbkWn6oOXJFPUNZ7IqMz9pIKgsezUWcickCD5OsORUg0lyPmErYPzqiFmq0qww2Juf7wiDkWdaMTrIN1vlPPL/7qBELWrQDNKc9snqXyyUv+anixGfEzdD1hoxJjaUDlfNpiWW+rvhMt6FNCyTw6KLiuAp+SAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688097; c=relaxed/simple;
	bh=+GLYGqEilEO+U4jzAMvFtz/R8Hotjjlqb42hciZJSsQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl044vupc3uDi8weW541nPN4DPKnMDIW0Oko5EpFTJMZwOC8Z03KwFUOP1gR7iNgw1Jj7LSNCl7ZzuNvW6Iksv9vUIzzb8XgZqryUtWKYppXnJBKhKUkl7t4ULVk8S0pNVBc0Q5CxpOopoRwChnLH+L2BosXKbe0fc47ooSMdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=foF6D6n8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DcPvMwje; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="foF6D6n8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DcPvMwje"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B92B01380055
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 03:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688094; x=1706774494; bh=iQ86pfNUUM
	Run/a1kr3yZoYgaMu3ANPbW2p688YEu1w=; b=foF6D6n8VHalBFSCRB5gwV2pUb
	oJrrAuyAYg/GJNCWUTREvQaqnXx7ango058Zv39Qk5V70NrbBowo12/nYm9DXy04
	Oz75OXGz5gNQI58DwVLQBS8xNnx/yfVwg8WsBfOUoEfe7G936pe0ius76uptNd83
	OVnVscCx5GfEOt6ZO05IkOEYVi0rI2pCiNlnOEG2dNwaAuNCx+PIBESEIiIjlW8g
	dd2dfXg/HlbLcH8YiSZ0jepp+GFvEsFbJKCt3/2DfBFGitjs2M1l2qAYjJz9JZf1
	Ce/m5t3G1sGrPVqQiAdBUutvmLay2FgpsPvFSRmqyuclb/15LSSDRS5QxzkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688094; x=1706774494; bh=iQ86pfNUUMRun/a1kr3yZoYgaMu3
	ANPbW2p688YEu1w=; b=DcPvMwjeat05mjl5dC6bTi8xsVz1GrffVr+LmxQPNmWs
	OJvjJ7yoBmyXBC3FBZdXaZ968Y3HcCiE85LFGqzJA1I+qSNogRgW3yRrTcPNe1I1
	WkQCf/f547q4ZSYNahAAvt6UC0cLFd0PBtSNGkrh8qxBV2yfLTLqwgqoZRIz0Evl
	xugA60mggmyU7NCvXtN62GFTtoUXtyb9DAJK5fnbcCIX33sGx2fjSQ3HkOdaNrM6
	BxLJCZfsHXhk+OrRrX2rV1xP0HDkK3Qy9lAZLJ3KRd0cRotlsJRZ3Y8aCMbj/6Ee
	6mExlmEJS9WnDhXZUSTWdJCjrpEOYVYPnWQAvWd6Mg==
X-ME-Sender: <xms:Xv65Zc28kRHS39XV6QGRS7M_qui3HlZmokRflNLc8eefHQYd38sOmg>
    <xme:Xv65ZXGtn4UYewy24SdX772y8Z1oXahM7oIDjh3C159mnL36nYFGI39rvet9Yy1lU
    cwVyq1mSSdgSffifQ>
X-ME-Received: <xmr:Xv65ZU63XDRpFQ9tZozbCrjTueKwZa5t1ecWld1Xp1IKevb21dvvw_TyRad3Do8y-cSsZ_jGLfl4xi7yM3hKElMyPu6Hv9HjTp1Yf5zacrztA0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Xv65ZV2M9Xy1rqZ58XeSDhU5tNVcwBvgUXNZ7o1-kaewEoczzBySJQ>
    <xmx:Xv65ZfEVqBh09qndTwTzRFr_i_CmzgIVIadXnBhEsWVjFITbKgzYhA>
    <xmx:Xv65Ze95WjzS-xRH_C1xFQGCmEK1j8MyfAjfYH0SfmMvG0HlRC5ulw>
    <xmx:Xv65ZVPmnMX309EAYPwYusbacqAuG-i5OIXEu3PeyIRqUnVpVKGEdQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cfa7b36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:58:14 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/9] reftable/merged: refactor initialization of iterators
Message-ID: <31864740e996368f7b87cdd47e828502fe0e80ad.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cl4+p/8hh8m59kqO"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--Cl4+p/8hh8m59kqO
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


--Cl4+p/8hh8m59kqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/lsACgkQVbJhu7ck
PpRz6A/+PcX7VdkTW6kceecQ5avBJILLR7yeAeqV5/4fF23njlPhoyg+XlZAfJwH
FqDvT4GHWNHZEwar0QEfnT5zT0gYbZcHmKiywpVvDP0lkSUrMF5c9BnfCnVVfoVo
lkspiiGeXEil1pU7qSKzqY28fofzTZXo9WoQtx9OA3GIPBoZ1rsRdLsLFwPRErZ+
45eGg6sxs22AZIEGfi4yngxxqaDNqsMEDtyZAMkiUdBEyB41N6hFFJqASkOVrOCr
mbrKRvykiXYYwOGppTpcsbQkuw2vJDLo6TIkdIEiS7HK22FFCeNtEiUwzx+vhjDS
qdRNRIPdhnQw5PGZdMYhat3YMT1F3B5aO/mgvN29MuOsnppjiz+ITlZWABfiVEj9
v1tPgfnps6oT/gBGiNDbVq8HRunsJD4qBPJvslwyO1ofP46AWXxKyYoNYCWo8trZ
szQ4Ha6IPLpq4F9HFtF7ahrQ2417EPhkxG6gq4IxLXwF78sEPFQfcYKHK6zzFOf7
Z2inS2Iy25g7b5KAeCdU6FObmNZ470i+1IsQA2OKhTg3kh0nGj2Frp+O/f66CuoA
P+6Mdf3jwHj16KomQVZ4t6G55G3RayjHkslKS/XRVk1N3q4qHQtxXdPgCdLOugeT
EUYUHGKa/lbVjze1BK02amtrvnaUMWRYn+a6xL08QAyurKkOhPk=
=PKoS
-----END PGP SIGNATURE-----

--Cl4+p/8hh8m59kqO--

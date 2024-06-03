Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F47F7D1
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407603; cv=none; b=o6oIOMN5s5ycPsGlmlVFSQf9vzIc+5pmxohvLJoRfhN1Hffvx5n824qxAGRGkP/2WHwEMsNyMFc/+gkTvD0gOxYfcnCyMqifwXwIMFSHYbChyIqul2f3ZlQcU3x06mmZSVuJSBsVsdIqecu8/gYoiWfBMftC7ENu7a+Wiz9S/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407603; c=relaxed/simple;
	bh=DophGbMHthFF6Wx9VlEvrlMmOGAhUKYXxxgos8Al/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXtrX4oB40c7+for7N+Nm2bFl7cqu1FHJrjBea5HbLsEnjmgHWHQr/Sisduf5DvOxsU9fAnAUuwFHsG/ZLBlQXeDLDlP1Es0xrwDkNscwpLzxyFOcdkdm3bXV2ufnsLuA1obDpSn8qAuKCayiGV/T/79GjX6W4z0ptFcWoHvSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QQ7Ad98V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipzXP/KG; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QQ7Ad98V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipzXP/KG"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 2CEDF1C000CF;
	Mon,  3 Jun 2024 05:40:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407600; x=1717494000; bh=+jGcVkqvSi
	hNJ7CMUkfCS/YVfy1KU1Pi1Y+dlGBvIXE=; b=QQ7Ad98Vv3kXP2T5M7H9xhFmQs
	x0NeogX+w+Gd7vPY3Ao13r4Z6LPmJUEivLAlFs2C9rdYZarUuQzcKodE5GMH1BW2
	Kpss96dgnkmBE/qsNt6LQP2o3+EA3VKkfb2Oxd6iOdUQ0wksP6rkdBLwLwClPoqG
	oJr1wgJAWUTAn7a5Ou2/ctY1Qp4NTKmbZ77gArQSYoStGHVp1iO7ADpzFSKHgxKQ
	MHlBlV+QF8jL2a+xOv2uIfQS12yrcOZ9gBOdFDEjATgfYp3Sd+JdFRMeyS27Wwh/
	LKYyRtgpwUi1GRFDhT77o+MXxQERFIXOWDbuVgBYslVyxlJbD2YYOAtz9SIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407600; x=1717494000; bh=+jGcVkqvSihNJ7CMUkfCS/YVfy1K
	U1Pi1Y+dlGBvIXE=; b=ipzXP/KGEeWbDlW0OT/nhTKnrmjHsTFTwgVSrqISFiww
	k7Yq0N1w03g8Qs7IzUewzo2tY4VMRxZNLT00nNVUEgy7kPiGaOTI6ADeuaOdH+OP
	GTpjyUvmPCvA0c3Ip/sMqPrLGkjVbAYHiZ5+Uge+zZGqKxUYKQg7Gt7oCaiAHUYN
	8eA8Z7OWX70QnIMzkmW0PMetk+eaZ5ouEFrSM+jLZrdN561S3bIyWwSxtBGPkhW/
	lYCJpMXbdjOMKdv3TL+55L+FEaMFcQXykuq50y0cO24U+aHPThiT8HwwMRdLVIL4
	zU5ww7tY2iZC1D/Gmxr9843grKcf6ywS+xWk9KbasA==
X-ME-Sender: <xms:cI9dZoTvzfaUaN6AvfsdJMKzIEFwR3kp8WmPl297ZRzU9MqzJDOTkA>
    <xme:cI9dZlyvhajjOcbQw7OGcv1-IUHKt0A154u1msU5_Rkt54YjyRLWj4On6CIxhskXB
    9Wk-idDMVG7x5tWVg>
X-ME-Received: <xmr:cI9dZl2qqESxvbHGKvr1S6TEdep_lQNHNMg4FF6ub6oh325OZ-pH9Lq1EG8fzv4zS33e9-qGGeQGI7cYgSu0JSJp6R8fCKZVOC6vIWBfvrZGoX0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cI9dZsCDf73P6UqVeJ8eIFFh8T-y9QM6wYm-FF0cB0FmVHtonshPQA>
    <xmx:cI9dZhhd7XApbva6Zr5fmw_hb8Y3JdBby1ZHcAHvCr8ky0ckwkacag>
    <xmx:cI9dZorPunlvO0ykUXmzA6SblJP-bKt3Ge4249_1eUHBV70w-VKY2g>
    <xmx:cI9dZkjr1RxHPrAKuWGfYL5Tj74fqxzYtH5djgLe-uURx6EtMhOEjQ>
    <xmx:cI9dZmvclVJnt1JZ9AisqTaoVuqo5LAkWElFrC9t3njedVE4kbbfenzu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3e1cbf2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:35 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/27] object-file: make `buf` parameter of `index_mem()`
 a constant
Message-ID: <a1e8e776417c2c754ba5683f8931f520adc47b02.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l7IJWK9ve2c19DOC"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--l7IJWK9ve2c19DOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `buf` parameter of `index_mem()` is a non-constant string. This will
break once we enable `-Wwrite-strings` because we also pass constants
=66rom at least one callsite.

Adapt the parameter to be a constant. As we cannot free the buffer
without casting now, this also requires us to move the lifetime of the
nested buffer around.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 3afe9fce06..b5b5a59dc6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2485,12 +2485,13 @@ static int hash_format_check_report(struct fsck_opt=
ions *opts UNUSED,
 }
=20
 static int index_mem(struct index_state *istate,
-		     struct object_id *oid, void *buf, size_t size,
+		     struct object_id *oid,
+		     const void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
+	struct strbuf nbuf =3D STRBUF_INIT;
 	int ret =3D 0;
-	int re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
=20
 	if (!type)
@@ -2500,11 +2501,10 @@ static int index_mem(struct index_state *istate,
 	 * Convert blobs to git internal format
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
-		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
-			buf =3D strbuf_detach(&nbuf, &size);
-			re_allocated =3D 1;
+			buf =3D nbuf.buf;
+			size =3D nbuf.len;
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
@@ -2521,8 +2521,8 @@ static int index_mem(struct index_state *istate,
 		ret =3D write_object_file(buf, size, type, oid);
 	else
 		hash_object_file(the_hash_algo, buf, size, type, oid);
-	if (re_allocated)
-		free(buf);
+
+	strbuf_release(&nbuf);
 	return ret;
 }
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--l7IJWK9ve2c19DOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj2wACgkQVbJhu7ck
PpQN2A/+J9baBF8qgFGmJ4owf8izcVNUrDBFVtHHL2mZWuwitVrI01v/Gn89xK5z
FavDpLFy0QFnn1C4sjtu7gefIhVNuuvSsjaLgE3hMQia5qwtSEeAoqNRPb4ZuSRn
Uh+C5GoSIccj3SKJR3FKhvUaY1lfkk9tjXZj4E1XxkM1WfKMhnt44T+K55vDd+WD
jKo0EBXwazUQc/EwUgxvamkAfxMVmV6W/nVpr+uhi8j7d6q5Pl72moztS1q96vOK
WLq3eezcNKSvMnlu9QXk8PiniR7KsaWSQYqP+bo1V+ujk8Q0ogQNFpuqfvg9QKyD
4yOCkC3nmDWuiSb8oMob0QtKcDrZNuYxmuD1ot/VfYPxTS9Ol8s2jkGb1bAd5121
kOJjF2vT3hGtSyYcwEr9+b9P8q4WMQGdOK9fAibKpjLYNo+0SzfCtbzcRNh4c+j2
yl0dxpzIj8GztjmoQ2XK43Ck4AJ2SZdpbo8aU/ddB7Q30CRjrnFMxGGOCyjh3CQK
tj6ZXbfMvBxEU1Q3vIDsSK+o8kim0Ig2mBHccmJaZOTUW/w2jw87PgmmaxAJvq5m
uNBImAi8h8dRq4605yy3eUEioQ5i1BeC0bhxppBEpG5gufQVckj2BVidDyhdYZG5
2U5Vclh9Nn29otsjAMwwKmSbxUkft3mlkdezWZ0whiiKAk1yoCo=
=ckxz
-----END PGP SIGNATURE-----

--l7IJWK9ve2c19DOC--

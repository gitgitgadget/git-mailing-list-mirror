Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D09125A4
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896747; cv=none; b=DzsssYVlsA0KFXdv9ouiRhXWTdT4SExN2h6yovg8ndo0mEIVTJSmCjk+TVrXo8AqR/3WXkw0iEvU9OgWiSxxkUBIXa/vV7QcoSAnYySHE0CjCmaarwn/nruUkUfxpPky3SVXRVVJYn/pjeo7coczt7qnVH231Y26eX9jsBRCAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896747; c=relaxed/simple;
	bh=HdRmAI7kUhFZKc0IFBGMbcSSo9lvlfNQ5/fsbkRU6o8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNv/bkSvD/NA8OIdMYCzBsvcg0BP7gpJUBVSUyIAwbMKkP1Y4o4mJPfZNyPqQaGy2Oj9wBKghrosqhkOTMr0TCV/IJkzw4NaVBdVXMHsArG2UGhK/OJ0YNZPuUMiijngZdqM9vVNWB5LL93mKtCF963z4ppxzXNQAZC3kp0Fa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oVFn8mhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUSg/jWn; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oVFn8mhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUSg/jWn"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 709551C000AF
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Feb 2024 02:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896743; x=1707983143; bh=D0qUfCTQsS
	xupilXEVyxObeJVgUoWWw7AYNdqW0ec6o=; b=oVFn8mhhZmJSQUzpUQNyz3okb9
	hEE+XSkpA/Wy0MFv8pQBFHQ+LZHfcl2AW4WdDucVrAwcaacfAD8lYttpfeNIja1e
	Hp20ta5WXqWFkTolh+uqXUXtUgFxrXkylkCMQYF/9+VGSenIO2mT2uaVl8VvVdgL
	RO4HO/Sml0RjMdKjKUnFvtleAkkod95653ONjQcUg0/7ss+gRv/hZgj3SH0Cf0NP
	OCFB0CDLLBArPTSAMmFlvfrI6bXNTiflwpe31xJaxKnRdVephVq1MyRamV3LdqPK
	Nm8M/T3auHUde/LPolBgr0XaOdQsNdpXcClr3N8ATTrjyAiVqMMgR72dSh+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896743; x=1707983143; bh=D0qUfCTQsSxupilXEVyxObeJVgUo
	WWw7AYNdqW0ec6o=; b=NUSg/jWnE2tb0wWM7LupQrvdGk1djDLM0mAJ+ftGRIyZ
	TbtBJGjsgtecs88L38bifKO/EWzMFnt82HOXTFNqyCkpKR8U+uI4XHa75GvewGc/
	pzL9a54sORtFfUvbOM87QxNwdb78EV9KTbBMl9FIu0ro6v/xpo9MYavkaeAbzGev
	VUwpEfYTbO+4r+9qE6iYPxMsBUx17yD2jPgxS5mebe9xHjIchvoG/AY14Ym7OcKR
	queyRL6c3TQlv2wD83MJ86L9GtUy3jIWflBgg40WKzpRfERMHinu17L98yrixOqD
	Yo7TTDO3utDdJvSB2CrkJvVLfViriUlZdekFCfgLMA==
X-ME-Sender: <xms:p2_MZcnnnw4qXC9HXAA5FOsda4Idmz91bbJelB2cpqQh4s-t25X7HA>
    <xme:p2_MZb1iliexBudAZSsQkyyKSKjnhmtV11j-guXGQ41sGaOUHHd4xc62Rs0ZVHSHT
    Y84GV57nl9bT7gC9g>
X-ME-Received: <xmr:p2_MZaowWtssOBLvqUDxfD-DiNkv5n57Sqdt3oSrv7tAbNQ9_os_tDLqpBBUG_cXj_ulTApD5Ke9IYgBH955sCCiclJHeU9iewVGDZhIna2oWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:p2_MZYnguvriM8DNvkYqHWUP2CgtGyN9muL84lF71RSSBzybXg9c9g>
    <xmx:p2_MZa103K-RwVzDphiy41Jn-a2EOHnakU3mqHO_RLX-xD69gcd_5g>
    <xmx:p2_MZfu3EwgChHGJnAmlfLEf535QBOvpTwn7ZmE6pyzNwasyD20SMg>
    <xmx:p2_MZf8TsAn8v8Wr5vrPOaYW6zwVWjE8J688TYRg1WHoSMmBsJiA0QGj31Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1290adf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:41:53 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/12] reftable/pq: use `size_t` to track iterator index
Message-ID: <eeaaac9e07c830f1c1ccd9d238fe6f725374d16b.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sCMnicaCIGOwbH3g"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--sCMnicaCIGOwbH3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable priority queue is used by the merged iterator to yield
records from its sub-iterators in the expected order. Each entry has a
record corresponding to such a sub-iterator as well as an index that
indicates which sub-iterator the record belongs to. But while the
sub-iterators are tracked with a `size_t`, we store the index as an
`int` in the entry.

Fix this and use `size_t` consistently.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/pq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/pq.h b/reftable/pq.h
index e85bac9b52..9e25a43a36 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -12,7 +12,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
=20
 struct pq_entry {
-	int index;
+	size_t index;
 	struct reftable_record rec;
 };
=20
--=20
2.43.GIT


--sCMnicaCIGOwbH3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb6QACgkQVbJhu7ck
PpTv9g/7BPWq2xqYSMMC7He79Av5T6p9Vw+hVGUPu+t5cSrP9xNsqTh3xmoqCoWw
D+RebS5xnCIgohCs1dxVVC585Rd9LxeWXZ6pVP1c7UyyVz1SlrKO3C7ym0R0By7G
QHt+pm8pInNZh+HsVBeuQtPUgbJuPzS3HfLqxbeWSR+0+lCW4MEBTYPZyfAGcxSw
MjtAVIPCm82LQ6xv8ylDitN6pWhrlqYWtLkAJ/rEFpt6O2ft4Cv8vXp+JOze6Y5l
dbozwzBG63xqqWRDahhdnc/58c1z8OrEQcbgx0aYjDjWHnUdSnXygkXWKzaXIxFT
HT3Y08z7Quaqmeogy4gbBR7CvCFVb99apyJbnSVLh5Emf1nyYuUvaddD9/oXVuv+
AUPR58lxyx8YRhWzb4BUOS62qYo488TcUcDwVx6PCvZN9zolD4p01Zh4Rkv32q6v
hPPLO0VMDECofnKyLfhODVRf77mB3qZAbECgKw+UafRBBmlOJGIW78ldv0VV+P43
46UO6bSavcZs0A2Hmo0hh7crHzM1qOjZY5mLuvBaMSglhlCLLuvRLMb6XXfEJC5z
UC0MhezLYiMSeNgcQ7KKFW4rLKiFs9yJ4TtTN6untKNQo4a5RdikJ+gYO9FNPiHk
MbSB5KsGgeFlB+YQjmfkaMqlTQCcN3fNyJWX6/iBJh+ZbtV5Vak=
=IN3F
-----END PGP SIGNATURE-----

--sCMnicaCIGOwbH3g--

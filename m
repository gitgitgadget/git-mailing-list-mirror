Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CB1482E6
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590047; cv=none; b=EY5ugYDgsJropnl36d9I7dCavGYGL4cPsRskrj8jJoF5C1QoK0VToqccuMmDbMjRShLMn9ITI+Zr0YVS07jJ3DTvA9Hpn2JAhOTN1UhaHQ0Dnw8X74YGF2OHTJyt9Y3wH5w3zxO7wy2FzOqf2cZSq5ysnCv7USMUqAGLTvOkSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590047; c=relaxed/simple;
	bh=rj6dzg4uRBPAaVs4Wp1op0P7ZJ7bNZZvMDVYJp6YLSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGzLem6phyVV+6F+OmCbcUNRnueTM+FPJJb7fA4ZQc0zKnEBM0Eai2Oz7qg3UCtFpBDOVdvvGQ1vuMMTnMoi/+FxdQxg2NyaQYs3kLf9ME5YNPfK0jOTYimiO5nrP6NvovdMaTAbEM08fBq4zUWScchGwx1Iu6s8NZ8U2KkNnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nHt1dNNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxYlDRZ5; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nHt1dNNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxYlDRZ5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id B3B281C00077;
	Mon, 13 May 2024 04:47:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590045; x=1715676445; bh=cB4a/qLH55
	OAHnnBYi6RmwJT0pUx5JfEMHrKR4svJLE=; b=nHt1dNNcWFaU70enRdD2WLPyoC
	j/uXe1QxxyFZ6z40lSCWuHMeMvmf30LVRv4WtEAEMd0GkcHsUhpHdCV6UY5tZrQz
	aOEINBytOy0104Z0koospDpSq6uf32oS5Sw4GP8vp+DE/JvWLdYL4r3J25lSjo9w
	kZOIzEnh7m9WtmwP5BIX84rR1qKI6Wcjgb4LMBMfMOxunXCEZjUv1E+jwcnc9QvF
	IMYnKyB7rRjDZuPvM/x13zsRibvG/kyD5MeNzqxhMaayg1sPWt1RQMl0MRMpEw8d
	YkVXrwn7yYh6aRL/LxkRz3J0K8228RFn2sWMZptv4BKXMRHeD0VZlt+Rnryg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590045; x=1715676445; bh=cB4a/qLH55OAHnnBYi6RmwJT0pUx
	5JfEMHrKR4svJLE=; b=dxYlDRZ5BcN2HULd87MZOdg8bP2iZAeqyyW7m0MdzfSR
	44GK69ySotqKfYoibwugkmNmKfv/58dMnLlkVCDsAgjvyEePY/2CZJYKOR2R67UT
	vMYsoVvHEaHhCV/5oK9tua2nYkP4j+aQfj/7NLWaqLypaQTC2reYGe0sZQ20cTb0
	JS+NjudL2KJOc2Ucw4GF+E5jmMPR25SphVz04WvRO35hFh2YD4zQjdi3uu5W5n20
	REcaRahkmWTL7FnjKNHzw+wrdIZ5iD7UL5Sbmfdozo0SAHPb9SlflgDC3oO/WCgE
	bKlgSaLBzS07CBAeylsKBCc59yoJts3469n8ImEssw==
X-ME-Sender: <xms:ndNBZnMGV_TjkrO4jPf7ETssooT-MLxxLMg6SYy0XlxjmMgNZ-yEuA>
    <xme:ndNBZh8t0yxOAxIjUoxRJDWcpABq3hZBezZqcQLPaSIw38mHsen8dXxDjsAV6Ez2j
    KpeA9GATioFdEqwvA>
X-ME-Received: <xmr:ndNBZmRoaEIeOZIrHwE5sMpyxXbfDderF7g-9_5TnYgk6YIjXBMcX7Qvlwh80TWY11ogobk7ZvRhUCiNq2hkJBzvtTFGZPu3FgieUmuHIp1J2HM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ndNBZru2UU1gNE5yTclQdxga-bOg3_nYXeYafiM7ITiLg9SFvX97Jg>
    <xmx:ndNBZveTnjBx5eVXWz9flQt6X_XmZksK4Ajumfw1HXN5sRV44NFvpA>
    <xmx:ndNBZn2GD0fLzARPof9jMmAhnfOZa7up3Ej6_mbo0qR-DosrZhgkEw>
    <xmx:ndNBZr8iSgjAmDtN6B5wQBfYIOytBuq8LP0sIuO2ZMSGf2CRmKxFiQ>
    <xmx:ndNBZr5eQcY5OatUVSyXT5RW0Pjv93loHLZKzqZyAx5F6sGV9QcTa9sV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 64c3abdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:47:05 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/13] reftable/reader: inline `reader_seek_internal()`
Message-ID: <4d498ef3426877c703bababaa743dd5613ba5839.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q5Apy9r8M3Uk29po"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--Q5Apy9r8M3Uk29po
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have both `reader_seek()` and `reader_seek_internal()`, where the
former function only exists so that we can exit early in case the given
table has no records of the sought-after type.

Merge these two functions into one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index b210753441..c3541e2c43 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -573,21 +573,25 @@ static int table_iter_seek_indexed(struct table_iter =
*ti,
 	return err;
 }
=20
-static int reader_seek_internal(struct reftable_reader *r,
-				struct reftable_iterator *it,
-				struct reftable_record *rec)
+static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
+		       struct reftable_record *rec)
 {
-	struct reftable_reader_offsets *offs =3D
-		reader_offsets_for(r, reftable_record_type(rec));
-	uint64_t idx =3D offs->index_offset;
+	uint8_t typ =3D reftable_record_type(rec);
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
 	struct table_iter ti =3D TABLE_ITER_INIT, *p;
 	int err;
=20
-	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec), !!idx);
+	if (!offs->is_present) {
+		iterator_set_empty(it);
+		return 0;
+	}
+
+	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec),
+				    !!offs->index_offset);
 	if (err < 0)
 		goto out;
=20
-	if (idx)
+	if (offs->index_offset)
 		err =3D table_iter_seek_indexed(&ti, rec);
 	else
 		err =3D table_iter_seek_linear(&ti, rec);
@@ -604,20 +608,6 @@ static int reader_seek_internal(struct reftable_reader=
 *r,
 	return err;
 }
=20
-static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
-		       struct reftable_record *rec)
-{
-	uint8_t typ =3D reftable_record_type(rec);
-
-	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
-	if (!offs->is_present) {
-		iterator_set_empty(it);
-		return 0;
-	}
-
-	return reader_seek_internal(r, it, rec);
-}
-
 int reftable_reader_seek_ref(struct reftable_reader *r,
 			     struct reftable_iterator *it, const char *name)
 {
--=20
2.45.GIT


--Q5Apy9r8M3Uk29po
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB05gACgkQVbJhu7ck
PpRUfA//awV66z02DGVQp3SXiOLr9Prcq4DPAmuT2DuhHdO0DYELzMItwknZl875
82awjcdfz7pXTtXoeM0fQxoBW1kji2mRThCBuUR3GKhbvtEo4hDdkZ3/n5nH2hPS
Fzj0zOOXLHppymfXrrBVATPJyUPqLqemCpFpqjMV8yQW7WOhixLK7H6E/Fel9nvC
tS2ctnlJFMRG+2UWu89Slb1xTTH5AF084ZriOX2rS60ret1o8las7SHlQe3kI22M
EhfDevPfCgUtP/WoTPJTKmNtZxqYJjKOxHkCIbZ/C1GR/1H2ZdSpn7JfuX3ewgDD
2FNZqvOdxLYeyuA4hVfdcdOhFgwXpU03uRB4DQWwSFh+onzaEAgCTGbD19QITv2c
x+toyPyukCuwjx/jluqmWWbH7h00X5deSoO6JdgnvRSyGTkIEoxCf0h1DnmJFIEE
boVepJ0oXr+TaQzPiRGMlIMVmvp9BdwEd2e4k+PucobZ+AjT+1E1apvz/qTH76ie
At8ybbcHmJu2IWDYyS5NkV5tVAbpVkwwkeNNsprArlTplewxxy1RV2unIRcv6+V6
FcXMFtwBrU+w19bjpvn7HE7VfZ0iRBfoUa4o2YUG4iPLz4uYIUdN8gAWRss/31gz
mwszvOne+dViIcssn2oTwrOQshDPSy+Gzz3e30md4bgHQtHmFTg=
=9IDZ
-----END PGP SIGNATURE-----

--Q5Apy9r8M3Uk29po--

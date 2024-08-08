Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654418C33B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125999; cv=none; b=WLsjgYusTmmC06Uzh2x6fxKkt8V0BTlv+9+D8lP6t7nyLJh/S15JsaqNGD2lfDw7xMGIo+GVgRBq4d2z8Kf7+SsHNRpWeHjTCBFjK0KXv01oZSIUkBE0E8lFrtfBKquO627I0iDnlMMKbS9GTns22L8RXEfZVDGJNs8SA4C7EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125999; c=relaxed/simple;
	bh=SDcgO4YxoT/fbB6DbErrnOncHc+XYtLo1I5TgWJB2tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZfk+jIwzVorSDY2JU1X1lrn+aFYYvBhmCFFx8KfcD4tV47de/lpJtO7EHOBn4OGyC3EFdo+XH1p+BV0hbxnIxRgWnPX+DK+KsCq1q4r5EPGwkVSfBt3IXIreTeJMhwfzMHzgkhPh1fvMf70YPanVFGijXRsetm5OdEYlYUk7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tj3yncui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2ZoVNlF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tj3yncui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2ZoVNlF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6E14311516A0;
	Thu,  8 Aug 2024 10:06:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Aug 2024 10:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723125997; x=1723212397; bh=vkKNjdC1Io
	GuO9vsNfJPj7MuzErxDhk3l0lBBECs+fY=; b=Tj3yncuiEbWcOu/KAb6WC/CCKy
	GU/rQJfyhr5kLrczfR7M9viT6R2bQyI4Q3et+iXgdtQbrCipobO5o789lkf9RTX4
	2sa1mpoP/ghTR11eO6mQ20mc18UX794cb249nlo2z18VAoqfCu0Hdmd8AfgKADgQ
	PhW/73EFPb4WK81JvVENFSCBhCHX2otzldJC5JwQ+tu6501QI+ooQE0vopVRpfuY
	0MxOy6dLlONrJ31O4cRy8Prvj6HGwjyd/MSH+7glF0xWwTiPDTEOfidVTlQZT+EW
	duTdhc6EmPWZUNgYhGcUldDDjmth3GzyY0ToZqYD0k6Pij1D+MDHIxppsH6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723125997; x=1723212397; bh=vkKNjdC1IoGuO9vsNfJPj7MuzErx
	Dhk3l0lBBECs+fY=; b=c2ZoVNlFRcKUfVNLDdVgJLHj9W0Ch+D2iapZkDVRSl40
	Vv8r1GjiQ70l5iBWAZiaDIK39X3AL/aYTdPD5lR35ZTlJ5lr0OVI+yN4c5AlKAZW
	SF46b/Z6B9gl6avOZJmRBvK29xZzzf5faYDJz3Ph+M5D4R5gHX4f8Ts0SKdIS/bn
	2LLAoRZyl2YHwAhUuYlIDr29z1fnLgcU1NpQhqZ1pbFN/Ndz/jMejQgUokX83WIu
	WpI18dUm0JNPhjXC20bbMnwFAQuyzHSTzTz1CDuNi236rpA3xIA0UG1GeaYnDhff
	0+VGF0U2p6Cv4jGcYp2/BpjwHf0wcaANXacDMIV6Jw==
X-ME-Sender: <xms:7dC0ZkQFRddkTBOwe5kzZ1GDO8upvP6hlQv-RpqIXRdjSMYL2nbpUw>
    <xme:7dC0ZhxyxMWK9p_K9Q3tl3sxvRD8WkS0-y-DvC1CocOmhZ-r6rLqZDNu-ew1Vi2on
    x5dlEbhk4qHQupR5Q>
X-ME-Received: <xmr:7dC0Zh0WWiR3lT4sRif8wnNEAnQxPxc5gwuB1aTjtxBsVwvodtWeYY-AUwp2UmeUbgtTs6bXHuZyvwIswoFlo9LwCq96JqvMme1BLMV06shFHJlS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:7dC0ZoDk2DfyoNbb5wutqDvx49kgGgwxPzR7jLIlLILTyjbnHrU5fw>
    <xmx:7dC0ZtgO6IZFmoQly-KEdiI7AkX5e_IyTcz25pG5XVAgWHunzFFWcA>
    <xmx:7dC0Zkr-Km7tR8yiN8zLMPAVRUBprY6-ECaAeF4Kf5C1wH_MCD3mgQ>
    <xmx:7dC0ZghTmpP7aOUNo5xaht0CYrcsbKsvdPrLQ6VNr_XyS3IaYuxOIg>
    <xmx:7dC0Ztc6kC0wBzMae7bd43YsKiLI72vehzzSBZlfOel3gV49q3MEEFKb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5597cd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:29 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 4/9] reftable/stack: update stats on failed full compaction
Message-ID: <478f945a45dc1f5e613d5e1385f3bda5655fa325.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QyGNpP1HsSZ6e7k1"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--QyGNpP1HsSZ6e7k1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When auto-compaction fails due to a locking error, we update the
statistics to indicate this failure. We're not doing the same when
performing a full compaction.

Fix this inconsistency by using `stack_compact_range_stats()`, which
handles the stat update for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 14 +++++++-------
 reftable/stack_test.c |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ba8234b486..e5959d2c76 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1205,13 +1205,6 @@ static int stack_compact_range(struct reftable_stack=
 *st,
 	return err;
 }
=20
-int reftable_stack_compact_all(struct reftable_stack *st,
-			       struct reftable_log_expiry_config *config)
-{
-	return stack_compact_range(st, 0, st->merged->stack_len ?
-			st->merged->stack_len - 1 : 0, config);
-}
-
 static int stack_compact_range_stats(struct reftable_stack *st,
 				     size_t first, size_t last,
 				     struct reftable_log_expiry_config *config)
@@ -1222,6 +1215,13 @@ static int stack_compact_range_stats(struct reftable=
_stack *st,
 	return err;
 }
=20
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	size_t last =3D st->merged->stack_len ? st->merged->stack_len - 1 : 0;
+	return stack_compact_range_stats(st, 0, last, config);
+}
+
 static int segment_size(struct segment *s)
 {
 	return s->end - s->start;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 1d109933d3..3ed8e44924 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1005,8 +1005,7 @@ static void test_reftable_stack_compaction_with_locke=
d_tables(void)
 	 */
 	err =3D reftable_stack_compact_all(st, NULL);
 	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
-	/* TODO: this is wrong, we should get notified about the failure. */
-	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->stats.failures =3D=3D 1);
 	EXPECT(st->merged->stack_len =3D=3D 3);
=20
 	reftable_stack_destroy(st);
--=20
2.46.0.46.g406f326d27.dirty


--QyGNpP1HsSZ6e7k1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00OkACgkQVbJhu7ck
PpRzOg//ZQQ8l6fvOqAH2xuQbakUTrB9MgQ/S8XsFH/PN0Sud1P1V0WdhCZvp65/
NRF+1uFHUmOLDo2CqAPpAZMehqVefp60wgJo+t4Smx5+0s2RNwLaY+dUDcYslrMV
oDkSF0TxzY7Jhz46g4kI5Ro3oV/6JyUnXgu/2DtbtsfVT9MH7+cj1xZFjgXIgOrO
iSsFgkMDZseUUu8UO3rqPucpL0K1J3yl0MVUflARF7z3G074FsmaZF3OZQXOIJU2
Zyotil1OaetgzX+y84h747+kz00mOuEkrGt3R1/8LpPpltOtKcbqDg/q4xIiKkaE
PaLjug3ceNEeMjwaFzrtqaM52DMmZ4lvHobhMYoluTKQhKrnmFyR4Hn6yEEkoHku
bFGq57RVdt2S98zPeC4gXG0VI0syGmoc+2yQzLjf+7ztsBLCaluuQPxCXzWtrZzh
lTSd+3mLNLEgzquJLe11jsVcpzZAA3d7pmydqjjWUCKHRAQXfXiKCFgiLhHxNogl
IWusqAFuuOh+NM6wxmNVE/uTNvhFrf0sdE1q+DWmhXa5LUh7YB8v4LvZzMKjg8I+
l9etNiVAf1i0aSfNzghU//lSzz3YDFNS9ejQ1Qo2mV/IysY2yqPYUdh0PvcRVkvl
uB4/LZznDHHVdHqze1rHOqhTzDrmuQhVOwMt+QTxLKhVSIIBu1U=
=+e09
-----END PGP SIGNATURE-----

--QyGNpP1HsSZ6e7k1--

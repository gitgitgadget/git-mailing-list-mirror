Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA6127B73
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201356; cv=none; b=Zo8cEJc+avU3z2WoFej4M0iH3vfEH4Oh/bQe1PCIS6e/GMfwycg9/FwF31gU+5y9h0MR4aZQpp5IuHHq1QttupKC8DPZSDGAJ9fliKL/44hmMfMOn/Kmq1lsb9AdSkmW+lobspf2kYKtn7av02AvP8kOYu92qACnnkWgPgUsgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201356; c=relaxed/simple;
	bh=tGjYmNrNoUe2tYCGSGhJ0erhiFTJnxpRcIele1GpA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ3Pa9vItuCn80fQqP5GMtc8oXpHNYyDn0D594M9Qoot8nssNBYNf9uG0EvdcR7mICRdG/EmXgKxWa33q76OwrcUBmbOQHGiai9/Cbo0D623XLRdfMMCFJoVgyB11lk3imBp6rmlHPQhbFdyqo9qEZLbpYQ0ZGHAugm0qpzvRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ncxia9PG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muGGXmu8; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ncxia9PG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muGGXmu8"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B03CD3200ABE;
	Tue,  6 Feb 2024 01:35:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201352; x=1707287752; bh=Gr6RobcUCE
	QqjFTVBtMmWdvZpJqbHPgQ4qR9RrTAPAc=; b=ncxia9PGvymYVAXGincHPlegGb
	rhS5KVliMNPGm2Uqan0vEKnt2bZRakM5EgZF3nOAzxtZW3o5PFuz7jGFZ2G9RGJU
	qxZkJbg3X9xsGCcsrG3zXGYFEZI3qkz6UDOPpQNhjuIyKS0JOlfhonblvXZzBVqU
	7OdS5jKeqnqxtmSh1qPoyzgDtAl4PemmZ932fS02On+OwGNJSXU2racEq5fu1nUm
	lxVLLmLFVJeOTbQ68YHNe+WY1ujNENLSUigjBVYtHkzSLSMyV0F8oTyzPo4n8R+G
	8KDG6HdLhWLYn0JpAemllsoHXkjofUEtBsfNqLtSCOQA0QURA7pt+/Z5YX8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201352; x=1707287752; bh=Gr6RobcUCEQqjFTVBtMmWdvZpJqb
	HPgQ4qR9RrTAPAc=; b=muGGXmu8bFMO5+kIg6pc8grmcHiwqIXVbRUGKpdID5aD
	6TiwAUW9bsig7+NHqDOGWNteKnEJISoNl8GXx+lFfeWewx9bv78eURl4epEmhr2h
	iVT2efPUpd7E3Fe7veLqyCH7f3of1LVOwXpK+62ApqOOYLvU/JIZNcuGDBYRTfWR
	qs8BpFdPXL3r6j9glcEI2fzib9rYhcBBvLuh4U5/hDmvYWDw+FmB5AyNFH9Z/8S1
	kPFSVV7zb+dpGzEKOv1G1L3duBUlUT+G1d5mFdMvDSP6p9qaHHEQzdjeAQ5GHWrf
	nnnuCzokmKyOEY/UrVGjXm43eV+MBuyNy3slYnpERw==
X-ME-Sender: <xms:SNPBZSfU43HYbk0-i1Zc9vr9pQClSCVfgkvmtnKAeVc3fTbNAAGxTg>
    <xme:SNPBZcN6htx9T6hu0R9T8xhuVEXfniuOKLsH9Qq4gdP84ZRfDeElK34tR6jGRwJpX
    uP69vVDYyVAqVqomg>
X-ME-Received: <xmr:SNPBZTjPsfQETXm3xBe0yIr7gFyYw4mdiKmUFzouyhN81UYgvGHfnx6Wts5n8KZCTjUJ_9zWEs1aONokbkIhVCfGbMzWiEYDsF2lpgJYk5nrmAfb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SNPBZf_2ZMzVWgb0-IcZ82PLQuDLezVet0v7h-mQ5lFh2N9B3_BH_w>
    <xmx:SNPBZesIPs5TFi9x_F5VvMbrpfsxqJXUC3nY3dnBsxSTe08Cza0GWw>
    <xmx:SNPBZWGK9w_FI1pgEXMAjPB5QpVOhM4GQ3Ydsz_d8SFsZ2VEM1RLcA>
    <xmx:SNPBZQKZqLqUrf2i5qZN5KC49WeRlAE7c9FUdmc_YuYcwQyQ7Rwj-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7188ed17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:22 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 7/9] reftable/merged: refactor seeking of records
Message-ID: <4605ad724746db8c33710e54369105214481dbfb.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bPpDYzEvpgB8/J1"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--6bPpDYzEvpgB8/J1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code to seek reftable records in the merged table code is quite hard
to read and does not conform to our coding style in multiple ways:

  - We have multiple exit paths where we release resources even though
    that is not really necessary.

  - We use a scoped error variable `e` which is hard to reason about.
    This variable is not required at all.

  - We allocate memory in the variable declarations, which is easy to
    miss.

Refactor the function so that it becomes more maintainable in the
future.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 54 ++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index e2c6253324..0abcda26e8 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -238,50 +238,38 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 				    struct reftable_iterator *it,
 				    struct reftable_record *rec)
 {
-	struct reftable_iterator *iters =3D reftable_calloc(
-		mt->stack_len, sizeof(*iters));
 	struct merged_iter merged =3D {
-		.stack =3D iters,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
 		.key =3D STRBUF_INIT,
 		.entry_key =3D STRBUF_INIT,
 	};
-	int n =3D 0;
-	int err =3D 0;
-	int i =3D 0;
-	for (i =3D 0; i < mt->stack_len && err =3D=3D 0; i++) {
-		int e =3D reftable_table_seek_record(&mt->stack[i], &iters[n],
-						   rec);
-		if (e < 0) {
-			err =3D e;
-		}
-		if (e =3D=3D 0) {
-			n++;
-		}
-	}
-	if (err < 0) {
-		int i =3D 0;
-		for (i =3D 0; i < n; i++) {
-			reftable_iterator_destroy(&iters[i]);
-		}
-		reftable_free(iters);
-		return err;
+	struct merged_iter *p;
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(merged.stack, mt->stack_len);
+	for (size_t i =3D 0; i < mt->stack_len; i++) {
+		err =3D reftable_table_seek_record(&mt->stack[i],
+						 &merged.stack[merged.stack_len], rec);
+		if (err < 0)
+			goto out;
+		if (!err)
+			merged.stack_len++;
 	}
=20
-	merged.stack_len =3D n;
 	err =3D merged_iter_init(&merged);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	p =3D reftable_malloc(sizeof(struct merged_iter));
+	*p =3D merged;
+	iterator_from_merged_iter(it, p);
+
+out:
+	if (err < 0)
 		merged_iter_close(&merged);
-		return err;
-	} else {
-		struct merged_iter *p =3D
-			reftable_malloc(sizeof(struct merged_iter));
-		*p =3D merged;
-		iterator_from_merged_iter(it, p);
-	}
-	return 0;
+	return err;
 }
=20
 int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
--=20
2.43.GIT


--6bPpDYzEvpgB8/J1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB00UACgkQVbJhu7ck
PpQHGA//dZ2U7y7ofw+lPvd4ShLOe4Lv1N7rl/fjmtcLapEJPXpSNGqMBtLuDh9D
518L8fLjcYmyO99ipZ1TrCvUhAzJbM+XX82pkcfeBMSaGbNCL/wbwyNIOU3F/jSn
Olk6CLqtF6JxdmvuKv/g+oOPOuSzoQ9o+H1PfBkrDg+IX70IWw41tZcsp44B2TNB
dYJ9e58teR9CqFlvGydLYYvMLr+HyeF5W71LWlFO9Z+ECzn9gXwYFIaEOfsMo0WW
yxZqBMK28/0eJZol8R0SRwjxuSUMjUYtfeXNqyISp4oIIgiMQa3BUn778pFhUuLR
LfelFTUi+zngEcxGYr2O4i9aZqCykbPnQuktKA16DZ9/Dxgr5cZnBzSiOrW20OSn
85UjKp+L4lzBpBntCKfPWpy6IeZgmXBGa4ekODx6pvWdptECDPvQix1EnO4kBPxF
P9quWvkqDrHVUwMuUiCLJHz9I03D/0w5wM93DeLV8Rcm82G1jMp9kVw41UmjDPHT
PzYqy+cYo1xbdSdET9VrTkBbsaNtblGCEROdAr2oVqLPFj7GF2W3t3Nii3k2TBO7
GnQ8KWbH3dX4Zbj6zh4pJMjm3bpLq+R/0FIyRSJsLeVKiYaCRwa/6mMI7LKpAHfK
URaCDKlOT2pRKWc25l3c71ZiAoVGUj/PaVbK6HsBuvVlAbjAEZ0=
=0ERq
-----END PGP SIGNATURE-----

--6bPpDYzEvpgB8/J1--

Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C14159586
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773938; cv=none; b=LQNiN6QOcgsvAUzPBHNcW/jRW4vid5XRLGMeYLenIhmVvClnnN/VUUlrAFuTBEOa89+zFTOay3Aum7Y1IkxVq7bgobh3Jg/Pc33wIrutnC0HpGwOfwC3iIYUS+AIx7sZEzaBTBu1UV/yi7MpOQMxsa2xoyuk/Kj+v5DQAv367NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773938; c=relaxed/simple;
	bh=rQqegkjdGseutip1iHybIlMwPt+JNxZdD1ANJ/Gt7go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBlEKTuIzsVwqXtsGMNwXSlX2v8sluju63TGKPraa2N6NS/HF5Q3AaqRgnCjIA6YlC1sPfKZFr76oIJ3KL+vhsxcCZOD+Gji6xOUnHOfQZl70IxDlVTUXwENL9wr9SmTYUofk9iYRybrU4s6GHSdNontvoMxubENCfxAGVxoCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IJFnAMt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLR+9GmA; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IJFnAMt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLR+9GmA"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E7D143200B4D;
	Thu,  1 Feb 2024 02:52:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 02:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773935; x=1706860335; bh=conp/zc7SZ
	i/7gXUuJrtjSjM73BgGv8fQbEH997vCBc=; b=IJFnAMt5gpvKk3SSRVImSXEb/r
	je3OdJFrt7+PuW0V89crQ6T3YflZQSMcDzxb+ZjC/eCMTNLyyLowpV+U6i9d6toC
	gKbu150N7g/zNMM0ep5EBBz/zegyOT3RDp3zydWh9krqMsUhGCCARWVS8JuWIEPH
	VYm67IXFTCV50bbBtUzTNB14vNj8Ejci0Fcf/ldq3WAm+1BQyHrXrSJrkEYDUVp2
	7ggQBUlhT1gDqR4AZlVtOL7buNz01KpORPWWu7dTd+bScZSEBKk2B5zqKl2UkTsO
	gCzcIbjKo0xaLgJRK1FZvXw1SxK86YjxS2kBy6dZAAMsmoauiavocrZI5pYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773935; x=1706860335; bh=conp/zc7SZi/7gXUuJrtjSjM73Bg
	Gv8fQbEH997vCBc=; b=sLR+9GmA/zuhdBUMr/HGVuRsYWfWWsfbyeixqWvk9Jf1
	4q08mBRIHzllcNensU9SckPlxtt9iOJQByq9V2tGF3P8k4Upd+9UILobY85PFd6R
	9eCZyBhwrr7RpZy5XlYcUOsgk4yTTMbXOcUp4Tp86Ey4AX0I4kPCDtLFTexvVYkr
	G6zAUG/8Z3nrRTsxWOnumNOlOqTRV8vRA1mm6YZKNDMaoJg73KTqw9NXqTt2WSGY
	yiqWsoPqSV7N34cyZdCW3TyzdZSpAuYJ3enTvSAZVq64e5hxs21jwKYmY0ZQu0h6
	7DJ7xzfO5sg1HonqB0auNnizXmgOoJO8yLcAZeS+yg==
X-ME-Sender: <xms:r027ZUvIf4_vCOi0HUSESlxNtOXVWYE0tQFUy57lVGH6olPGKVIBBQ>
    <xme:r027ZRfGdd4Gl-P9sRJS9tiBZONACAl5n1VCGSujvhw0sOL0gTOEQbJnfFfOTOSdL
    BesJg7guqrPWwamuA>
X-ME-Received: <xmr:r027ZfxZsg4z3deEMtaLSuFHURkM1ofvK9i8ii58cVL6gJ8Hv375JUjGnFDfpISQLFcFAkYZZ8qX_nl4r4eLOiEdO31e7LJu1HmnNITcqjAjtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:r027ZXMk_D93llFCCJShW6b2oK1qSqqKMVShe5bVsQMVQdlmCeGBvw>
    <xmx:r027ZU-bYlesfolyf6mFPSZGhdUzyNXd0_KHy96sCRguLrNHU2lraw>
    <xmx:r027ZfW2P_xj1o2F21u1QLgD_A9O3ElaXvUcdlEHodGBF9YuLmsyGg>
    <xmx:r027ZTYm6pjXTdDrNTr4TbsukP8WAYrH5giS6fSJM-VqDG8bZ7WKUw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:52:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eed9a01a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:52 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:52:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 5/5] reftable: document reading and writing indices
Message-ID: <c3492bbd42b9d2c17764208e814faccf395cb282.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HeMsHYSPjOi6oNa9"
Content-Disposition: inline
In-Reply-To: <cover.1706773842.git.ps@pks.im>


--HeMsHYSPjOi6oNa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The way the index gets written and read is not trivial at all and
requires the reader to piece together a bunch of parts to figure out how
it works. Add some documentation to hopefully make this easier to
understand for the next reader.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 27 +++++++++++++++++++++++++++
 reftable/writer.c | 23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 278f727a3d..6011d0aa04 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -508,11 +508,38 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 	if (err < 0)
 		goto done;
=20
+	/*
+	 * The index may consist of multiple levels, where each level may have
+	 * multiple index blocks. We start by doing a linear search in the
+	 * highest layer that identifies the relevant index block as well as
+	 * the record inside that block that corresponds to our wanted key.
+	 */
 	err =3D reader_seek_linear(&index_iter, &want_index);
 	if (err < 0)
 		goto done;
=20
+	/*
+	 * Traverse down the levels until we find a non-index entry.
+	 */
 	while (1) {
+		/*
+		 * In case we seek a record that does not exist the index iter
+		 * will tell us that the iterator is over. This works because
+		 * the last index entry of the current level will contain the
+		 * last key it knows about. So in case our seeked key is larger
+		 * than the last indexed key we know that it won't exist.
+		 *
+		 * There is one subtlety in the layout of the index section
+		 * that makes this work as expected: the highest-level index is
+		 * at end of the section and will point backwards and thus we
+		 * start reading from the end of the index section, not the
+		 * beginning.
+		 *
+		 * If that wasn't the case and the order was reversed then the
+		 * linear seek would seek into the lower levels and traverse
+		 * all levels of the index only to find out that the key does
+		 * not exist.
+		 */
 		err =3D table_iter_next(&index_iter, &index_result);
 		table_iter_block_done(&index_iter);
 		if (err !=3D 0)
diff --git a/reftable/writer.c b/reftable/writer.c
index 0349094d29..e23953e498 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -391,6 +391,24 @@ static int writer_finish_section(struct reftable_write=
r *w)
 	if (err < 0)
 		return err;
=20
+	/*
+	 * When the section we are about to index has a lot of blocks then the
+	 * index itself may span across multiple blocks, as well. This would
+	 * require a linear scan over index blocks only to find the desired
+	 * indexed block, which is inefficient. Instead, we write a multi-level
+	 * index where index records of level N+1 will refer to index blocks of
+	 * level N. This isn't constant time, either, but at least logarithmic.
+	 *
+	 * This loop handles writing this multi-level index. Note that we write
+	 * the lowest-level index pointing to the indexed blocks first. We then
+	 * continue writing additional index levels until the current level has
+	 * less blocks than the threshold so that the highest level will be at
+	 * the end of the index section.
+	 *
+	 * Readers are thus required to start reading the index section from
+	 * its end, which is why we set `index_start` to the beginning of the
+	 * last index section.
+	 */
 	while (w->index_len > threshold) {
 		struct reftable_index_record *idx =3D NULL;
 		size_t i, idx_len;
@@ -427,6 +445,11 @@ static int writer_finish_section(struct reftable_write=
r *w)
 		reftable_free(idx);
 	}
=20
+	/*
+	 * The index may still contain a number of index blocks lower than the
+	 * threshold. Clear it so that these entries don't leak into the next
+	 * index section.
+	 */
 	writer_clear_index(w);
=20
 	bstats =3D writer_reftable_block_stats(w, typ);
--=20
2.43.GIT


--HeMsHYSPjOi6oNa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TawACgkQVbJhu7ck
PpTevA//fE55rUxRY2cwZrfoiTZtEWTcJMohLJfpUnMZVkKbKtWg6IRdc0gRNAng
Ew+YoTdb0P3RihZQSxq7p6Hub5eU6an8Ik+Z9ayZ6DG3++BdqWm46MUr4hn0A7hg
mHBbjwyP0ORUdG9ieQ/K/0JVsa85p0rZSeqVw4SgmNsKNypCmOv2ZnHhZcA6tlJ/
IbhzrpsVToTwLyzad/iBhTw+g2Qw/HKhEGEpYEfTgy4oUseqpeKV7tuaClfvmZ76
qjHPeGmGkfDush4qZs5dnh/vTaYpfYUfmNkfw+DY8BFb4vzvROUyCuCm3LpbEItx
kD2F7Ag/Zu7/Z4aYTHAlWayT+NGUsuapRVLaTGjOfNRka/ervTln0JcQThlEnBaj
MSRH8f6JfAaZmk/jfaavGpW7GhnrsmVwFShIgC6hjeNuJMy2e5QRutIZfZ9mBPEo
GKDTGyyTjR3E51P1jIY1ud05MyG30B5K4AmKlDuXsHtpMFn5ZYETUQ7YDUT2fzkN
EV5VMeEFMvq7v0KbEFWtjauRzBzI87YMz7y5LT9SuyKqyN7zdtRY03fecogr3N1M
+TSsdMKOdbqDL0L+ag8I6WyPMMliGDiySOq54Sq/3XzSb4tk5h0/spNW2zhmyi79
5Ne+Y2ahwdcVY7HQTbkAAprE254HVmQxLPrtClS1Hau1KmyDi/U=
=cIYP
-----END PGP SIGNATURE-----

--HeMsHYSPjOi6oNa9--

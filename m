Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0915158D8B
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773927; cv=none; b=nQC/h0wFRRegjyZ5DzFMe9xLpxmFYvQ6u+ge2Mj2XDjWkKaIJvEJJ9NzzibQzBqkZDzVBYcT/faY9bL+YPN8QnTMgv/NOoTTA9Kjd/Tmbk3Qmb1IJUX2X0aAK1kLKfWn/NvFUjgyjaZuOSJg1MyY2vTLoiZsUr5GzPgC3B1iUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773927; c=relaxed/simple;
	bh=LEZIHfuVjYRw/3uEB7/dB6ODg8nZZizDMWIl2X5goJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTcWAw69MTSFJu1kkwP/AtJXkWx/ZK0dIONyY1BUSsnFd52d8HRXhVDnj8C3kr9L4aq9KoinrW8FpVVQt40TXSNfmUKHFdXdzwA+s8AidUh2BXJGA0G6qJvMejGH3N6/Js3YyXyhcrwsmOI2WUR9OXr3fYWGHb3lk2eyb7XxggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MN+ow+At; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSProfIP; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MN+ow+At";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSProfIP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id A9F261800079;
	Thu,  1 Feb 2024 02:52:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 02:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773924; x=1706860324; bh=dhvGIyfDC7
	3YbY4Qip7QO1UmZanFqNCV3put3TaN2Ts=; b=MN+ow+At+gZKT52TNIpy2C3Ge4
	+7ME5SS1ZJrhOxO4u5MMEaZVpiyAc83e5CAhgHFbXTt6D8CeDDd33agEzzftIzWM
	9P3TrNkxH2RiwWZkVYBszfMbhfGbES4f+ngLb5tQ1PrS5MjGZRegsenbWYLL5Lg8
	9r/BT+D0H2gANnWDF08NQ+rH2aXj6ZHE/MXgtYv/ZwLChtHPa+WYfWdglXzBFTTu
	+ghyFKOeDZbbcvaUNuFlSlfMajF02QyJkvMg8d9ePw3JDlTXooQA9ukJkvbkQJvR
	7qoZEdy0aHRWuGNVZ94DUzvJfTjtEUBccYV2cbF+SooO8GvhI0nIJS8eMS1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773924; x=1706860324; bh=dhvGIyfDC73YbY4Qip7QO1UmZanF
	qNCV3put3TaN2Ts=; b=XSProfIPZD4YZR/FBuHuDF9SzDAGXPe94VGyj6SS+oFc
	ksMMdCQ26jmtU8iZb2Ih4t+LHn+obsTpeQzd4XLwBaR0x0GapnHSqBntsEOldrFh
	2KdZR1ysGmPRU+AvSyE0NgwiL18p8v+SZEEejvIZIpbLZv48RFH/qncQOC19YahJ
	6qOFaAtHq68RM04xRQPdI1kuVWqC3yR74uCA8nQGreIBLkRv0/8Xh2IcvXDwiFzO
	aaKSxmp+d+a1drOyIQKZzB2+Qr73AerlboxkNG1k3wL0PbdA2P+hJ3gE4toxqVkt
	glDxRKhSuYerhwfPjpvtfyIlLyJWZiI6DXKaZ/YV7g==
X-ME-Sender: <xms:o027ZVMXZt-zxxUPBQwMl_Zepliq1YpK9bb_NBXpbZhNelERD3abyg>
    <xme:o027ZX-c5pkvevnOFJbuY4LdlNM2ca4TizV1NtRNnTSynDBclFpd_yUm_xOoT35r8
    gxSDyRYqNKAkhcFfw>
X-ME-Received: <xmr:o027ZUQUPxZakYT4VgOWuPKiPd5E7QLl_5jL9q5C8OvOC0UV2KJbYpkV0FDq3JMnZKfzYMXViXWFU5JFmMpcgXoPd5JhhZno33j-aZAY86u3Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:o027ZRslpBC05jMEF9WdaQnkA3zXkCm-N0EM91CCy3-OsCH9KSpWvQ>
    <xmx:o027ZdfSYWq8gQNKetXWEsCGOVFKU4D1gtSLKglgeaHq-IWpDxEfzg>
    <xmx:o027Zd2LLoAc77SYS7_dLuiO0T21mt94jiU3YvRLDsCC0FxVDBgSmg>
    <xmx:pE27ZU6QbKnyCffyDXCRzP42md7ZqsElAm35D-17z2akTEKVGcfThJygHW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:52:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51865484 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:40 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:52:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/5] reftable/writer: use correct type to iterate through
 index entries
Message-ID: <88541d03bef7c6ff425d330b153f3e3d94ca7567.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <cover.1706773842.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WP91b1Yakr1SbrtS"
Content-Disposition: inline
In-Reply-To: <cover.1706773842.git.ps@pks.im>


--WP91b1Yakr1SbrtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable writer is tracking the number of blocks it has to index via
the `index_len` variable. But while this variable is of type `size_t`,
some sites use an `int` to loop through the index entries.

Convert the code to consistently use `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 92935baa70..5a0b87b406 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -379,20 +379,21 @@ int reftable_writer_add_logs(struct reftable_writer *=
w,
=20
 static int writer_finish_section(struct reftable_writer *w)
 {
+	struct reftable_block_stats *bstats =3D NULL;
 	uint8_t typ =3D block_writer_type(w->block_writer);
 	uint64_t index_start =3D 0;
 	int max_level =3D 0;
-	int threshold =3D w->opts.unpadded ? 1 : 3;
+	size_t threshold =3D w->opts.unpadded ? 1 : 3;
 	int before_blocks =3D w->stats.idx_stats.blocks;
-	int err =3D writer_flush_block(w);
-	int i =3D 0;
-	struct reftable_block_stats *bstats =3D NULL;
+	int err;
+
+	err =3D writer_flush_block(w);
 	if (err < 0)
 		return err;
=20
 	while (w->index_len > threshold) {
 		struct reftable_index_record *idx =3D NULL;
-		int idx_len =3D 0;
+		size_t i, idx_len;
=20
 		max_level++;
 		index_start =3D w->next;
@@ -630,11 +631,8 @@ int reftable_writer_close(struct reftable_writer *w)
=20
 static void writer_clear_index(struct reftable_writer *w)
 {
-	int i =3D 0;
-	for (i =3D 0; i < w->index_len; i++) {
+	for (size_t i =3D 0; i < w->index_len; i++)
 		strbuf_release(&w->index[i].last_key);
-	}
-
 	FREE_AND_NULL(w->index);
 	w->index_len =3D 0;
 	w->index_cap =3D 0;
--=20
2.43.GIT


--WP91b1Yakr1SbrtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TaAACgkQVbJhu7ck
PpSbew//Tje9ezb0tVYH66+0cn/mGCdxeRQfV1Ya8rO7WnsNlBc7nP/jIrPS8vXt
sZG+0BYf/zyMASHHcsNkBPgW/zjKd5i4zHJEQSo4vqEqgX+LAWaTPQtSSbGtZSsZ
AU0tY+z+zCzX9J5hQROZFEv+zhSeq7lyQN6a3n0lyTMJW+Qc/d5WY4aeBErJZbCG
KC4EBOy+fDdg+S3iTjzNkLw0rbIYORdaT1LerwSf93xUzwiyikt9NQIkpY0VTFq3
5ndb3WhUMFz7nySdmMieBf/EpG1EpMZDHw7MSCIhmHpcIihhxOphXCx27fuVB7NC
l1PrnpQItlDByNkvVWeOG9tP33YTUy0xa5Zv8SMReF3CAsfUdbUTGG8A4yHsIqoU
ssOVQEzvgfaAh0dN947ZhutMiJucnp80yToPX2slCV6m8WjJWc3bzddeZfL6fF3A
cZD7lbcwik8dgsg+NRbi2jRLFTAe3gF4sn8yFgqvRBZ7ShnRwOfLlphcfTXhFGME
xaYBT9YqDSh2aSgOhReJ2im6eyZhghc+GnTh8ov73PSgULZlRo/EQmxsehMOMzC6
KKkqUN96DVxYMzzvgTjstDpkXjzAbGenyIwXGE+Qbwpj752TWidCCYdFWi9Z7TEI
bn+fL97aTVOBMEIX6Fs/dVRpmnCsX4zxBumtQJuAu8hI+sPG8Y0=
=UnoY
-----END PGP SIGNATURE-----

--WP91b1Yakr1SbrtS--

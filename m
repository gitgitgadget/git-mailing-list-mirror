Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EA7B3EB
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579062; cv=none; b=dPCY7UplvTozc+5+7AWk9QhU+H+vBjuSTyoJW3VChkDkjlRAgoMoVUC/rzxqpBAuD97vj5yZQthIpiPGCTsY+IrdAS+ReAV7Xr/DiowTbeL1fdPbXr1+8y316/Y2xmAabyXA1HPJTZuImG1rOY2All4arbVqTwnqRaMQs8Qt7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579062; c=relaxed/simple;
	bh=P20/KeVieAHPSyhApAVgZGqz2EEikN3uMe+hXD1H9Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjYRJiYn51CZsWJyEj2oUNyUNNF6tYhJ6o4JRxY4srLAdNcFNAU+g5hOtUGmMi5VVRrcauvgIIMdhULPCL1OsbK55f3/kPK6Zcw4Oe6JPn+SK1IZB6vvuVFH742YwAcNORi+r5opz+lz+IGsP+UEozB7vRQEGMVP8vV5CGpAxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FUiep67z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5o2JYuc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FUiep67z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5o2JYuc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AAAC01140118;
	Mon,  8 Apr 2024 08:24:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 08:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579059; x=1712665459; bh=RYdmMcH0l9
	DAgvcx45US1gMYgfiMKVsYfGmgWtM9TzE=; b=FUiep67zLwmPF0QtUSTZIiNyaW
	amuKP9DQyTzT0r9PHrTEwtNw+ZPDgDg3Hlwb+PkYN1/yLak1Q+FYGRBooJVMfMah
	AOHjTwczLfvKxh9GUc8ibTxbSSq8AxuD908j54fhhrCdpepCk9a8n5wWLfaCJGas
	vBeLnHfSPM6KYp0X0b2lbKbrDr0LLoXG8lY6Dxxq1CD+791LAKRGFaTNYuLjSAZv
	quhGODi4x6MZUU+PSeNWIp7QeliHwLqY9gYCoAn3B4X4HOxll3lv6N+pAkEZRuiz
	RQpkTGP7eobHF7sfco60rvK4RUEwgNQaE0Jtxvrs+pyGYU+jh/nwJdwhbUuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579059; x=1712665459; bh=RYdmMcH0l9DAgvcx45US1gMYgfiM
	KVsYfGmgWtM9TzE=; b=E5o2JYuc8yZT+sHiOdX+UhYbRIetdo6Cpmq/8Gi81pDs
	VOpWLjJR/+TujhgR+IF7LihemC5+NOG33Jk+gM3A/6qRKa0QGRbfAR0pRM/2o3DE
	UKND3H7/YRK6bavRqgFoPuNHSSN855ijuR4dL+Y986ggcEM3lxExecUsRDJmHqYA
	bkVF1LgUSKBhiIIfuTWtJAUbqkb8pCzK3RIl4DHYYiL67eWaYtlG9c0ufu7C0Ihl
	tXqQrDRmqo/accCzwLMfPBDzyf1YWbaKB0+TZi3h/YeSSTp31wee/bXkSvB1OmF+
	rNu52DmGvpOhQzZbtvnToyoKPM6URSN3T+LBMD6xvQ==
X-ME-Sender: <xms:8-ETZl8KhA8cjsESNc9j8ftvMF1cxG-Svav_B2mAu16jtXkzn66n9w>
    <xme:8-ETZpvgE3bEPyrQDuU3iYYuWYJeLq2mhdCoa23deVW6DeGGxt9mis5pgdCgm1il_
    aqgR9WEePuN_faM8A>
X-ME-Received: <xmr:8-ETZjA8hpL2qwJF3QYBXS50Ci8Wgb2GOymvRBNuIExwrxs3Qn5BTL8iS0Up34mpx8cJ9-_kuLm7K8IgIzL96q5I1DKNAhEsyhyOcy0g5sk_L23oBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:8-ETZpcsXl4F0bc5cFsjSb0Sg25AC_Rz_CVcHfJlNCvzFTlTuLdkww>
    <xmx:8-ETZqNqoBOVGklVCQQXEtrOS79Bq2TzSSTQUAzMUmvqHuAxxZqxFw>
    <xmx:8-ETZrl1RqQtg_Ln0t29kPg0JEbfT2MCrtofZB4i8jGY7yJ4mjBN0Q>
    <xmx:8-ETZkvn7aZBD2mPtVxog6p1yafgWtjzd4sg62rIh5x9zq1fZgIzTQ>
    <xmx:8-ETZnp5mMC3OrtweYFpAcIQjaB54RgLrgI8LTiaObwSVrYHPYnqZ23q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8078336e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:12 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 06/11] reftable/writer: refactorings for
 `writer_add_record()`
Message-ID: <deabf821867e11f3f63f406ff88198a8f898b289.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfo6A/wkfKiObpRJ"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--kfo6A/wkfKiObpRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Large parts of the reftable library do not conform to Git's typical code
style. Refactor `writer_add_record()` such that it conforms better to it
and add some documentation that explains some of its more intricate
behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 1d9ff0fbfa..0ad5eb8887 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -209,7 +209,8 @@ static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
 	struct strbuf key =3D STRBUF_INIT;
-	int err =3D -1;
+	int err;
+
 	reftable_record_key(rec, &key);
 	if (strbuf_cmp(&w->last_key, &key) >=3D 0) {
 		err =3D REFTABLE_API_ERROR;
@@ -218,27 +219,42 @@ static int writer_add_record(struct reftable_writer *=
w,
=20
 	strbuf_reset(&w->last_key);
 	strbuf_addbuf(&w->last_key, &key);
-	if (!w->block_writer) {
+	if (!w->block_writer)
 		writer_reinit_block_writer(w, reftable_record_type(rec));
-	}
=20
-	assert(block_writer_type(w->block_writer) =3D=3D reftable_record_type(rec=
));
+	if (block_writer_type(w->block_writer) !=3D reftable_record_type(rec))
+		BUG("record of type %d added to writer of type %d",
+		    reftable_record_type(rec), block_writer_type(w->block_writer));
=20
-	if (block_writer_add(w->block_writer, rec) =3D=3D 0) {
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
+	if (!block_writer_add(w->block_writer, rec)) {
 		err =3D 0;
 		goto done;
 	}
=20
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	err =3D writer_flush_block(w);
-	if (err < 0) {
+	if (err < 0)
 		goto done;
-	}
-
 	writer_reinit_block_writer(w, reftable_record_type(rec));
+
+	/*
+	 * Try to add the record to the writer again. If this still fails then
+	 * the record does not fit into the block size.
+	 *
+	 * TODO: it would be great to have `block_writer_add()` return proper
+	 *       error codes so that we don't have to second-guess the failure
+	 *       mode here.
+	 */
 	err =3D block_writer_add(w->block_writer, rec);
-	if (err =3D=3D -1) {
-		/* we are writing into memory, so an error can only mean it
-		 * doesn't fit. */
+	if (err) {
 		err =3D REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
--=20
2.44.GIT


--kfo6A/wkfKiObpRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4e8ACgkQVbJhu7ck
PpT1fA/+IJuoRdzbwiQXyYqLC2EpP1XcQ+ilqR6jV8tQLrxh4mMG589rlvAwc6it
UxQ0Obea5X3U2Ke7gpAQ1rcGDUCHLNcE+E6lkT1WpE3UiPV9G5TBlbdMmLrWyD33
m9AMj60tW98sKJiZKIPkgfOD4ufMTwA7itmodVjCwESpuS0bJmysJp8or6s2bCA0
iBR7yjhKFJZuHd4g9V/CLhC7Uf3KdYjakVmuCQjGnUF0xCzwv+tWUPDj0xdyrRWF
02CEucxQn8e19byaq33M5bD5qlj41dj+RF/Kfc4x+ZfZDkzuY9gwjBrdYXYi8Egm
ofcz7SsCxMYWVzaxHwUHnVFKAYJx+VtCUbfQLn+jTRwdbFcOn0kYxddYdHWSlK2o
F4uc8FWnBuAtP44+e/bG3OFli7dp8buXzz+YHzrl9uiX2/G4oUYy+41pZmAO+93H
vIEq7qAuLrwrJNeotn2As7ZrQXKDyIw5B0cEogrCA6tLx6e5erCm3CXxbxCXmO4f
dm57sAXS5aOUkw5sD5ABLajtRIK/r1z4bvG3QZU9DvqFWDULElhYJysYQVeMbQtJ
NBgKqJmepCKduJHjHW0bSoMzyjD9LUmUKCjA5MmVCeTRgMF8iz3v43OaHdHkVzXm
fjogjFiGLxO46OXUzKZM1fiTPKX7cOAikw8nYJTZwq/09ZDtmTQ=
=P9oA
-----END PGP SIGNATURE-----

--kfo6A/wkfKiObpRJ--

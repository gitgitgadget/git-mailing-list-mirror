Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF71B80E
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265116; cv=none; b=hS5TB0OrxW+gLIIU6UI9f4XLgiZcPqoBviDRow925ZuHfg1t0ENWg0r6JipqAjPVkwH8ZPg4llauzXS1wK91dWuZ4QIzIEq7N9Bk7DCPik0pV0aL5kHQ2I0uAcSAqHJsIzd+fTM4vUl6z0mceerf1t8qhzW0agSAIZ1bTY1umAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265116; c=relaxed/simple;
	bh=1v/nHfdwS8kPmN8on6pGM3FwVdrO0Rhv36OUdjW85zE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSNyXaUCJdxMUssN9ZVJmTL7ohU4vUWaATXdtS4hsbq7YtD/jJgXZ58+ZiV3lw6dvbwKLEb3jrEJV75xgoUjZa0X8rb2UD6Wqq4jmiPiTExX5QNNkXFjQvzMSEp3siHxXnBivkPkVLriHdaPegfiJkmwvmrjK+fWoMW+QpYf/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qij7Nkmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqFcp4kP; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qij7Nkmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqFcp4kP"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 1311C5C010A
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jan 2024 05:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706265114; x=1706351514; bh=nQUMYDwSYb
	COlEfm4Lao2i8Wcz7akk874ms2hxBLpsU=; b=qij7NkmkQbfq060zrN+4WCI8my
	oUi5CyxTly8joFXPBxbBZ1CpjV6pZLXxSOZtrBxBuOey4RjHM+71+mRMCvqkbP50
	AGEjM4BerPctgrW5U+fv6ac9SGUY6qtFTdYr2Mo+x3O9bviO4EHE4xuiVDw6HxNx
	ujJyxUuxUj8OZ/WNW6Vh0Lzy2fPpEZhrIsDTRvgTaFUFMwkkohPN0PUCNJl+ktpo
	mQgFjCVFwUfFAkJgAWK1hwzyjlUXjWW0Pk7ws8AK06Uc4jrYd6TTwx95JZ8W6FyR
	gIvbiWJmXN6JNk/0iYER6CxstZIjylNqurNJ3I3wda3HtiH8J2IYdrNEVxEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706265114; x=1706351514; bh=nQUMYDwSYbCOlEfm4Lao2i8Wcz7a
	kk874ms2hxBLpsU=; b=eqFcp4kPw/I0DAtvPWdcj/snfux0VmHUYcx4ZhOBD+F7
	Eaw3z994VmWtKicuZANszwbVMlvi6cSnuzU+vrVDPisM76qpKd62biAC1rGfn1/e
	EEjeQ5WfiB3xpcmctsfBwMH5sfiluKmlD1WTRjcdi09bae9j+ybBgiaH9ECXUsSW
	ywx+uYY8h24LrjMZHT/nqdmXy2/J2drMC9laWO6wqk1X+ZVPORTe/YO8DTKj5qTh
	+d0lfxGbeZHrgAvyTb3xFIksWB8bF9GZi2Khck79wJuzMwQM/fFynUiQJy821X58
	imXGdRqqjADOZKCU1a0AO0FzaxvcW/PY6lAvCbkX0Q==
X-ME-Sender: <xms:GYqzZfTWIZ96SPMCW6sQgiv0vrrvlxGpYY6LcOx4C4lONmj4eF3BLg>
    <xme:GYqzZQzabTHArBzAjJeBbZ2rFbhoKCVskDk1sT1PBNyUpL_0D421tmAh31sPGkk9n
    eyivAd5VDzoQbcbXw>
X-ME-Received: <xmr:GYqzZU33HCAnxqQTvXLXMBTuA8ABVKAUThZFTlMYzZzl31NlFZrZb5Qhuo3n_inX1PgFCXnnaKH0SjLOq7Rvwtw7E17dIU4HH2Hg4MZScIRhD3H9gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GYqzZfDlY7hTnldWxmA6N-DvCW8l3G5l5A9ghcU5vdvJ_uXviLVkag>
    <xmx:GYqzZYhLopgvch0hPzAF6VKpDWHZAkkMnshDFmLtl5_4fKf4EhicwQ>
    <xmx:GYqzZTr1PN91-ASPm5kHq4bm_3Lf9Lc8rjicYfsGflkk9Z1zrCrYNw>
    <xmx:GoqzZWfCFgFMhe8y9pqr54tLULRL18mWFYlD7Duzw71TeHVPx-WeCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d641479f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:43 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/5] reftable: document reading and writing indices
Message-ID: <7850e65878e42c6ae5064554a3681a3ea1a7ae6e.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJdbPqz4yqoiVb54"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--sJdbPqz4yqoiVb54
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
index 24fce5630a..6028789dee 100644
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
@@ -428,6 +446,11 @@ static int writer_finish_section(struct reftable_write=
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


--sJdbPqz4yqoiVb54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzihYACgkQVbJhu7ck
PpTrHQ//XaV1xjWFUqyA+nPI/+S4c27dupjrE+zvErv+79hRL5pWarc7+oRSEReJ
l4wZjrjIx1xNLwCMTG+ThifvfhkQ4wCDMwldCSnxcgg2c1nvLzdXhGAjiu1kecH2
FnVWRJy3gOw2Ku0XXgYuzOXrWqk9XGK39cWKReDOLdzG7Umz7DW8+R15Ms4c6bat
/DeUr+v4ZRbjeX5rCrwhP1unmJPTCP6s9pvabPgweaOz2+nvmb3NNglkYiBt/vnx
paK1KpNrIJNMT6L4T9fFK66V3XhFaNcIaODQnWPw/6XP7x7XdiJaRnc0gd1y4wLt
Efr0Fqu8ye9x+oBfst49MBvEHK5EtDoMg7txYz2QIzpQSLlALQUT5jaJFT3xA81r
nYuE0yY8WMgKVaskAKAWZLE2gOZLnTehqoy/32qcq6FAofRidUFS9FZgmVoykdWj
miwVDljMpPT7FCzUJ9h3KhwfAEjvABLKyb523oqE8y2/A8oIyO+U30shYJmRh27N
rYrRLhztrrRGXXsNX1psX0vHOj42HAJUxhcou1w36sH793uZM5AmI3BxCNdyZugX
ln4OEQTxmu0iDacmNX9j1LnQnvhu1ZXBMiBEu+MxbWhAjjIz1aLdhaRWh/3mmKVN
Ss2cOvDJP7g7WC9p9ltETPD3WAfDMEWEDHIaOLMYMF9j+6CVU/k=
=Oxr3
-----END PGP SIGNATURE-----

--sJdbPqz4yqoiVb54--

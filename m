Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE11B596
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265108; cv=none; b=XBtiWgD2pj8J072eS4E6Ex9GnFPfE4Yh4OeDnQ7lGELf/5Iwh9rhPGcXB9ujL9nxGDRTdKINIcLw96glV9sw0uWxrar3tTf8l6avylLR+TJ5PiKi6TqxbRi+Y5tv0Z217Oc5Yc/kFMQcoD3IAu7pT3u13wLqWBvHcAbhhd5qbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265108; c=relaxed/simple;
	bh=Jxh3yw53FbP8JzUVqUtN4dKRTyLJlLq/yEdbq9QwG9g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDi5XKU8jP5qduDcPEqPuTZ6kTJ5CYdCTEsdh4dAWTi/2D399InO0LJf+e7prKflHWYlCkMowSmH4Uy/HE/FqrjEtTgYhVIvkQRJ1UbUckYhGnuyPgVsmembDPY85NnIrsjQ1yI5P5ZVMQ+QlBc9AZo1YBbFaAKN10Tqrpf4ZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fImXYY5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tzUqTjte; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fImXYY5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tzUqTjte"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 53F0C5C010A
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jan 2024 05:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706265106; x=1706351506; bh=u9CDuxME6v
	zFFZ3cuWGCDqimiQADWAD+aee/K6sRHgk=; b=fImXYY5yjdfa1GX7jQwcJMBrFl
	3Kr8gEoruNC4Lm9lazcUlEHFFdlJ2xBSRhrV+fynhOIouI256p6+RmJd4AF0oVOG
	yTRSrUVfTJNXhFRzpTcELE+WpbN4a3rClTPbBkQyoExM22ieAjlBQtMXsEQEiJJE
	lU4NBll2BEGk/jcdtLNZU5F/SkvNjg0T68yIhxaYaWaI+QzGbdMvyXBkOq0g5F21
	yVMq/Egc3jjl9kL4zv+Z1sy7nNdKl+l1E4s1NiNOgm2KE32W+LnTqaW1itXV3Ppq
	7b2S9gX3P3pyQ5dEPbFzscqr93CYhDXSCPjuw5SVDEKncop4WFMf/x2VLb+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706265106; x=1706351506; bh=u9CDuxME6vzFFZ3cuWGCDqimiQAD
	WAD+aee/K6sRHgk=; b=tzUqTjte6JGWf9w+5AhWDAI5IXd3AMD0qdUm7KPv7uZ6
	/ivfq+4hWlXDh1fuV/qfECZMYiy3XmvdzzWIS6FRDrsaDAMzXvtIBJ/CjklXajyH
	oelqhBy7Tv3aPuyhYvLVSHrrR4uGah+e2IQvzfe4vzahNhVvFquqykn1POKLCPnN
	RolyvftLDlP6xq0xWQ9hrLvouFumq/GDKJYH2LIAbRInvApMVIQquGABx+AMa9o9
	FaGZqT2RnZZyLi50XBZdWqEf35+lkmSpRkcoNB4TxL7QN9ulosPEwDIDE7OWrB0K
	ppc30sjh1mgPVoldfecbLNImffkwmrFws6Hmn2E0eg==
X-ME-Sender: <xms:EoqzZa89vGOW9x6qs70T9_-EdrtMOmmgwwBU9r7vbPakwCGC15A6IA>
    <xme:EoqzZauZ231iYii8UoA_lDgcWxm5HO--RIBLfsyMCKopQP3uoZQC21QNbpbhS8qfb
    9oKqEOeL9b3atDACg>
X-ME-Received: <xmr:EoqzZQBolM3hHX31EXu1X8Iwq6fHPdIk6O_GB0mfRKGfWnhTyXGRXAPk0W41A3DURmBP73649nPJI_EzNdYJsVGyXiJfYt_6i84MxUfz0qWd9ciDqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EoqzZSe0gwJhOst5sh14ZGvi2joMfsX4ZvRJ8lIDCQZTr4bwlnbg4w>
    <xmx:EoqzZfOCJojDC1yHeghdu2vtzHc90-yvYz6TIaJW5gpsO74qpbrFRQ>
    <xmx:EoqzZcmv9oSQLRGA4faEhsojqYomkCd09tRLu65uqIi05C5_FEczxg>
    <xmx:EoqzZeY2O3hmL8BYzK3zf3ycCDOruZGk2s3cKi_OMi7NVa9a7wZfXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jan 2024 05:31:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7477d9d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jan 2024 10:28:30 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:31:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/5] reftable/writer: use correct type to iterate through
 index entries
Message-ID: <88541d03bef7c6ff425d330b153f3e3d94ca7567.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iH5ZgbsJxmeXGwK+"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--iH5ZgbsJxmeXGwK+
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


--iH5ZgbsJxmeXGwK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWzigoACgkQVbJhu7ck
PpSNUBAAqwrb3FvDEPn7AmjZMYt4pj+PEJyVexc8FFuRtHMQLcMyCOe8B8nrfqem
ruxjvR+y6dkFyGeib1Ix69BjX4ALi21jwyuvk98AEZcpMB5Npss5M2pmlP3l0xDf
3ECXjFaSsjGkevBK3uDdH6eK9beyH4BovpfXXwDTNYVupqdq4kEAiheGKMaR7f+l
UHyZ9V3LpqKzst0XS+CtB1IFz0sM2mMKFtMaQUETaUqaLBG7k0h/gH9IWFGBFHxp
CqDVleRRDgZeKWoUePChplMigPzGt4JzxqiRxueVHZ8C0CariaTQCipKzGa0HxlX
PEGgbeZwXKaroH4hRijjeG1cZjAy+/WevX/517vz29iTzr6ybd+Qar/KepP4iGSE
8V4Inc2OBaaSUMOu9qPwy9snltXHlECkSRUmaSn7UFEHUn0r3PpWBOAi4PzArUGX
FxFAbt3saTn6Xl6jUSHFcpfdF4Pd+q5yka0qew1z2n7nG8UZqpUzbG2a8/9ELLvU
Jfq+fGsnrR9u1zBmWjfOp3VpgQjrWHRIpAgJSpYCQDmhKBRqfVRqsxOHtgxmUeXx
2wRiFOArd8ascy8g/Y4Izov1GduNHnjOZRm9T3z1P1r7yBzZjHnRaTRMoTtmGs0h
w6zZJ+8nAAx470U0EzDhmRL4a7NVTcemLy4PlY+kp5IqSOh5L7U=
=3N/g
-----END PGP SIGNATURE-----

--iH5ZgbsJxmeXGwK+--

Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC955E41
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521749; cv=none; b=QZbEkJQ5f6b4AzXrf26NyryT/MVorNBBpqOFPvCoi5H8lZKAlErkePeeIVlTEqpPLnf4o/anHqPyGjfOo5u3fzZOcRza5jYc8s0bvQlbzKPZIt+G97lh+V19LDQdN7GMP10rHnPXPYGVyJnjtnee9NiULZuXKrZ+1NIj1Zgq/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521749; c=relaxed/simple;
	bh=0PX2anF0n0FMjvfitMtpHIdGkMSyhztLhwTUAxnh8yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVZs04L3KaYLiZA5OEg3NGC/W924u8egr62tUyyOSB6Z78qUnl2ygAhKzrwJTRuTKHCQVHWwsNROHqqbsLozaG6QDB0anAHjBzoKDAQc6PU1zBSQBcSPKDMjfiDot5KFX2TLt+99hzbX9gDTEKwldmuedyOnWrpRRLQUvE11/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D/nrLbEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdLFeKn9; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D/nrLbEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdLFeKn9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 699C75C00D4;
	Mon, 29 Jan 2024 04:49:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 04:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706521744; x=1706608144; bh=bobE6q/8H9
	FAM8mGBztw+HGozc+Yf6cSEg20UMS02h8=; b=D/nrLbEBiAhxwty2kD5OtrZAfk
	VV7yoGAVnzVmpI8yTsFz/K/prjeyq47Vab0FZxysjcRd+cgmhpgEcmxzzd4z6FeS
	xal2Hhc1KzTetPLDsvpMVhsIsHAAQvXBliBUaS1lx7pqXfAtrNGFLjyYjTHFWloj
	7DQVfSaXyHfQAtw+6t1LFp3YN6L7hLrR2YMpk/umBFb9ngkGjrjj6uocq1BEHT/E
	es7U6CvRMcj8srw4XvJ5nxo7oMYcF/8Rm7LBcZ3u7jszgvTonbxrojchA+uZuB+I
	P+o/7HgeX5OZk4z7bQ5Hn26EyXOBnQLzK9/DmM+kBNUlVLlCjqqNBzvAHBWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706521744; x=1706608144; bh=bobE6q/8H9FAM8mGBztw+HGozc+Y
	f6cSEg20UMS02h8=; b=MdLFeKn9/xY69Z6iusipxVVu8TDr6OYfpRl1s6sD2e1w
	zFKOmswgzUab0W8HpwzqJv/9Q8RwO3MbFcdUuDAsYk2DeBGH4aPi+MMm7c07SCF8
	SHbaiA3SaeGaVfSzYbcq+5kzNki3TOMk5rvLTU/Hsb6NoncJj+a0MwwQdSRxnfCB
	ZkVnZQAs3vRO/H8/QZLNDglsItnO718Mdmd4e1QahtH3+kT40Yj49XxWZNGOACX7
	js99f85KlFl9UP4mbEoHtKlo25AA6zqcFFlXlUM0QREOnfVnnG8xLp8eczuMhw2R
	TfLe4CLWs+Df1fjmX7ogplrprxiQ8bW5P8I45qr9mw==
X-ME-Sender: <xms:kHS3ZSdPIGG81A7uAg8Wn373RHdO1Q6FvTxRr8lrxxAkGzc-hDC5Dg>
    <xme:kHS3ZcPZyHNs1cxe0yaodmVs04BKp-U-C2VIASU2VhA1MQv5ggi003V72M6vfkjhM
    RAsgHZ8GhnfNicl-w>
X-ME-Received: <xmr:kHS3ZThCTpHsJDbeWGGINgAg3Xeq6o0_vhhU8LpBtZlLqi3rzs8m44IzL5yVz6zSKSDkzTFjMhwJXx-AC4fa_agPPCwAq_iYS8qIvKoAnrXfqkEA3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kHS3Zf_tUw7AZkfr4zETuSMfMadFNY7Fes0EM_nHGq9Z1cjsoTMijQ>
    <xmx:kHS3Zesz50aJceepeF2hvUdcF9nN8wePQXsYzV1R9l9Tfce-vO91_g>
    <xmx:kHS3ZWHZoBAOe7aSuoyI66PgpvldwkxwiGsCNkk8ak8FdDr9mQpbFw>
    <xmx:kHS3ZX6zzu-_470nVwA5VWYuvPS9ACx2ZY5YIoiKdxdpd89J0Cx1Dw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 04:49:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86512e29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 09:45:44 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:48:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
Message-ID: <Zbd0i9nOeWWNQ2EW@tanuki>
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxa6MlptHi75ngde"
Content-Disposition: inline
In-Reply-To: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>


--pxa6MlptHi75ngde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 06:51:10PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> While the reffiles backend honors configured fsync settings, the
> reftable backend does not. Address this by fsyncing reftable files using
> the write-or-die api's fsync_component() in two places: when we
> add additional entries into the table, and when we close the reftable
> writer.
>=20
> This commits adds a flush function pointer as a new member of
> reftable_writer because we are not sure that the first argument to the
> *write function pointer always contains a file descriptor. In the case of
> strbuf_add_void, the first argument is a buffer. This way, we can pass
> in a corresponding flush function that knows how to flush depending on
> which writer is being used.
>=20
> This patch does not contain tests as they will need to wait for another
> patch to start to exercise the reftable backend. At that point, the
> tests will be added to observe that fsyncs are happening when the
> reftable is in use.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>

I noticed that we missed syncing the "tables.list" file when performing
auto-compaction. The below patch is needed on top of what we already
have.

The topic is currently in `next`, but not yet in `master`, so we might
still squash it in. Junio, please let me know whether you want to do so
or whether I shall send this fix-up as a new patch. Thanks!

Patrick

diff --git a/reftable/stack.c b/reftable/stack.c
index ab295341cc..b17cfb9516 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1018,6 +1018,10 @@ static int stack_compact_range(struct reftable_stack=
 *st, int first, int last,
 		unlink(new_table_path.buf);
 		goto done;
 	}
+
+	fsync_component_or_die(FSYNC_COMPONENT_REFERENCE, lock_file_fd,
+			       lock_file_name.buf);
+
 	err =3D close(lock_file_fd);
 	lock_file_fd =3D -1;
 	if (err < 0) {

--pxa6MlptHi75ngde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3dIUACgkQVbJhu7ck
PpRN4A//WXyVHmcStqdDUV/OakHEA15ExG8SGxUh6X+4M9MCjwjHxA4JXfu1SVec
9ZIjbKm/GrjoiPIpUtHmFTDN/0/CfsBhf32SVkxfH/MLGqZfkmpzjXBSHw0AOer1
EhgAE6LhhSLZ3pMBEzPDa8Y+xPzPov5NCpeaBSmg3Cfh+/+89aGabgvQdxMu7BF+
i8Di6U2ROj2488/yf1aNuEJarOiLmArh4+MHjwJWzeoe2wq0ZnuHTReGte8pRGul
M6EduvW7vGIOlgZTg2QoEXgJ3R0l0Ur3IrqAbMtJpBMRwDPX+6+cNjhYmyZWeKB+
Ygl7ntufTUfi+cj0NPAJJpUkmCBRQgYPr/OjyF9hav0XLiAkHhifkTf2SWTCu1Q0
MFno1SPoEkBNorlCiZEG6duEQ7iveLWp1RF+uRC9aYgqSbMqrRGwbXL5AcCT+6+U
sLmInElAsG4E3G19HJTm8glH6CLV10PREHd4REhi9K1QvFN4VxAl0FDCck27W4wk
83zA9l/sugaha8Vi2Ct3wYyv6ApiqRm90wh+Db+8lhE7QrFBJlp//UE3SQzeB3K9
g0u84uWZr6fee/ataYNZwhzte+UHzdSmd2Ey7iP0onpeFJGJufqMVUAgxdJoaLd2
g2xbRmog+gCYjw4AIwgPyk4MHtDIuFT6Kti3mp1evszSLhb6RR8=
=8sUy
-----END PGP SIGNATURE-----

--pxa6MlptHi75ngde--

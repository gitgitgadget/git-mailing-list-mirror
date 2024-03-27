Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855042C182
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521435; cv=none; b=fOh9vCA+NP5EkOsxIARnQx7A8kaIRPLmrHfbiGVNZwq1zPfgRreh0Dw5K83WcxH/jTxhNI1UHbIJlOEeAAVMKhVTLh+wHnbaRA9zuKWIb3GW08T66zCAhppMF35s9IEw6rj0DDK3WOAcgMDliPw9SL6EPJZaKZLccDUg6Lv6xRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521435; c=relaxed/simple;
	bh=rXtHS8SbhtZYYiCyMr1amo8GHviFzMjVXwSmaYXif9s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4VKywHkp7/EJfN5K1aKLax9g/skKHPp+RIb0dLfZu+B/bX1BBNxqcG5biFUkN5PdecGlt4gqC6u+PLqdeXC8+4+8F4yNFbLOCnTIBayaqJi260NK8km4ntfQwQDnZaSbasDmE7cR1aTCkmr5EVnO7LIKeXNVvygc0+gwS2QM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ncZKCphR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLmOAY4K; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ncZKCphR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLmOAY4K"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7DF8D13800D7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 02:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521432; x=1711607832; bh=zV/GntfS+w
	W4OF/tMqsa/BibSiG3yFtNXDgjS5MN6EQ=; b=ncZKCphRKpjbGhuoLP4WARvwIW
	QFH8yQW5EE8+14NO8YAETMwzyRqh9Q9xXPVsAF79PAPiKbmtZ6OjWE4DGBUlhsTB
	bvq9+RytsBAWo9Hz/k3uiM0bJH92p+jXxq3SSCmAZOKcsBJ3+BAxhyGGeaJw4TJ1
	9mqZnoRlsr70DR/4mKJcjLCoUBTvkSx54qv/0fO4hvRmKgFx+ClLqcHCqtciNDJ0
	qjkXb+r5vsdnLPvucoRnkvfWJsfz5CcUksn1QHhV14kMOpwh/LKmF7lgxk5wUn0N
	t3lCv0u+BXB6DmTLyAvkfB+haj3ybaDOi1jNPHIqVkA9eDrCVCmYmPQXZjqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521432; x=1711607832; bh=zV/GntfS+wW4OF/tMqsa/BibSiG3
	yFtNXDgjS5MN6EQ=; b=ZLmOAY4KJAvjATil18luf/dNGsnaNQG4rmt6k+Ga6P0Y
	UUht70v4RnhD+4NQLzP96wiQlcqZlhhMf2X1OAUFOt53RC9C9TItq4ra/bi31kNM
	S86a4vmc5dlmHouGa5v4CamtcSsDg411zmhAPNIMlVbBL1WwO2x+ESErQQQmTb2M
	FVkoWyXkbfggZ9UvHFOnamGwDjr7sEDvDO5XQQ88eE9SSIlEqOuCrP/dpYw2K+It
	jy39+ip5MW6ZODfcteO2g87HQBMJeunHuRUKrUKpFiC4ma/MMnOobBqAkBt7wd5F
	08VBnAxhdjUjdixCFAbTrFZ/eg0aPDMcyfnazD2Mpw==
X-ME-Sender: <xms:mL4DZqAwQ3rntqEX0zO0nGZIQtSmmX3I-8fu8fDnYBcb0ublwn_eaw>
    <xme:mL4DZkiQwUfD9UgjcMpv1XV8NWETHKNGz4IYu_42jbsJ3u4WtatvrtIF3Th8AZYs1
    7onz9fcepBIsOC_Nw>
X-ME-Received: <xmr:mL4DZtl2y94UUNO9u-_EO18bs3Ooe5S_zErd77cpc_ZOkWYrVsBaPFYMouNF0tNxVmCJPlusjssTV4U4UVetU0U9SQBJDbB3991brSeDHkQYKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mL4DZoz8V6wYJyOa9gkoHa0E2yqHngdLceEKn85MYlxEk0YGmajxzg>
    <xmx:mL4DZvQTsOOdUhOq6nscyDbSmVYWa8kurBxbjKMn5Qy1OMEyXYJxaQ>
    <xmx:mL4DZjZTvKFC3KzQTp1qpfpBurhJgBfiPqGI6GRzS5VfXctMiF5m4g>
    <xmx:mL4DZoSDVwwbS1S34SGl8VTMBq8u0OtaDuZFVBpSexlnmt7amaOhZg>
    <xmx:mL4DZqcrJuH3IpvvGVfEFhen7aa_NHd0N1-bRv4vrPCE_0XFkk9v5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 362e7ea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:36:58 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/9] reftable/block: introduce `block_reader_release()`
Message-ID: <9a1253649a4dc993da7caced2f15839d988905d9.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rp6IzfrhH78HJIIY"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--Rp6IzfrhH78HJIIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new function `block_reader_release()` that releases
resources acquired by the block reader. This function will be extended
in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 5 +++++
 reftable/block.h  | 2 ++
 reftable/reader.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 6b78dd3424..013849f028 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -256,6 +256,11 @@ int block_reader_init(struct block_reader *br, struct =
reftable_block *block,
 	return err;
 }
=20
+void block_reader_release(struct block_reader *br)
+{
+	reftable_block_done(&br->block);
+}
+
 uint8_t block_reader_type(struct block_reader *r)
 {
 	return r->block.data[r->header_off];
diff --git a/reftable/block.h b/reftable/block.h
index d73ed73549..601a1e0e89 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -81,6 +81,8 @@ int block_reader_init(struct block_reader *br, struct ref=
table_block *bl,
 		      uint32_t header_off, uint32_t table_block_size,
 		      int hash_size);
=20
+void block_reader_release(struct block_reader *br);
+
 /* Returns the block type (eg. 'r' for refs) */
 uint8_t block_reader_type(struct block_reader *r);
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index f70efa2b7c..f925570bf3 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -253,7 +253,7 @@ static void table_iter_block_done(struct table_iter *ti)
 	if (!ti->bi.br) {
 		return;
 	}
-	reftable_block_done(&ti->bi.br->block);
+	block_reader_release(ti->bi.br);
 	FREE_AND_NULL(ti->bi.br);
=20
 	ti->bi.last_key.len =3D 0;
--=20
2.44.GIT


--Rp6IzfrhH78HJIIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvpQACgkQVbJhu7ck
PpRpOQ//U6zMqSyTETl4V/u1WoSwYP/tTZJTtJNxlJzgC0nEfwik5BSGnLdenMue
jgbIot5bk7DiAkrODnvY2Uz/4d03HV7SBjMUV7D4cJM/fWqG1ZcrFqU+ZzU2GeXK
de8fHNKQNRRfhr4V+yz0o6SkAxnE911Qa1joQ1RqlOC4TcVFjOr0+YAgDIPMCEvC
zHi7ALQJNkE8Rbu0K87LcMO6HV3f6Wc6DdrxhYZH8CPiwdau9+VV793lMrjE9pVy
H/KU6Uczfvf7IL8cWBWf8xTl3JhPnlX3VETQnP6aZNWUo9lNgLZ+uexVyoeVo5Bj
C384/vV0NRaJP+TfDpFSudKnHljr7uJhpa0y/32ZJW5waFRo59nNOBP1iYiy/eLe
58j0IUhhcx+aeURdlELPlDEbgogxhYqetMoAWtF8xHpJG89JD4hSU7pIUNX3A5ls
3WY/aRNL/FsiMyP4mhLRPBHG5mJVBwHGwNxixW5bJ2Ec23sGgB3c/6KZ5fCz36iZ
z0uo6kqwOh/HBSZx8Nr5FePYRQRZ5VC2XF1I8TN5bzUpencnpbg+oprxKj2TsAPn
jdGJW5bP8xdgl+9fMuT8qY1jnjPM5ahuue0+6VVSXOPyRWLKE/pcCMawszbImVuS
ISdwXOmZp7FpdbxLQwv6Mm8bQuqa993jSjtMYf/6+O4xGM2EtCU=
=MOTk
-----END PGP SIGNATURE-----

--Rp6IzfrhH78HJIIY--

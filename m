Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5B1F606
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521426; cv=none; b=hnQK1VcPIufFfJNf2skFKXQqMaOVhEcllZgmEagpwo/u5qz4Is6LcXayWKfO41FfMTp0yqS0lWKmgU7KjlZQ60h42IXg4n/GsrzWmGIi7vjcvOgeLxSCoZQlXztQFqEfrk1/jKpIHoM7FkD26URS0Febp3FKUogvxmjMKFWW3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521426; c=relaxed/simple;
	bh=PtuuXpr8pMtDWBYeoWM6uac6njnMo0Rnw8qJOLTnD0U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxHuicZlWn61V6+SThln3J17T41/JwcLUcIDcypIIzMNQPl4EWsIkBwC5uNodmhkkODuU53yv5OJs6XwuKRpiRvk1kmmzw2zRiRQkOuM3QTP5TYU/XJriMuVUbeVqm3iE5xhz9+6YokmBgEgSDsCuj0HSYE0DmYEGJblLAX9qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HYROts8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXEKbDh1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HYROts8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXEKbDh1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D16F713800D7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 02:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521423; x=1711607823; bh=714LS9O5fB
	aXDYuRDuDGo3uDg+3A8XoK7efsyw5IkDM=; b=HYROts8SVCuApmPm8hJAlzHpu6
	I0xatttzZs5b6efEieKtixgCOFA60kYS+mLX3R6d4G1FqWrUH2mIE5iEvv2NcIol
	HYdHSDmMo+YnHD/lY46rC0L4B5bZqjcftEXF8+sLnbI0nNUOMxeOynR+yKuvENhE
	KFxm2xW+97aZBwx9Wk0PzTMlM5nfVPWLwWMPz3AyaYpQj66wCyQLVrD9VANXdDb7
	cbGrilWp7AvPATaRqMRBKx9Ew9DUea95DTK9uyaPer264MZHRtTlxbItQFiRtlnt
	/mQKiQ0sG8QNeww8x/sTJ/z1lZ8onlSFmKe3bj+icHy/jiY1XZMW4rpmloAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521423; x=1711607823; bh=714LS9O5fBaXDYuRDuDGo3uDg+3A
	8XoK7efsyw5IkDM=; b=sXEKbDh1+aRfEzBHlglLwcdgUBIH3n6DTeL83SwpnZIw
	SwEGYIdrFyq1x6A3qi64JMfYQNymlvWAPicfYInSHamCSsS10Q9qQURQ3jWp4rvQ
	+Ixks9TQQmlnBv0uwJhlBhfPE+cBx7cIaLDEJz7rXDfQoOYFwXByWLIsnslD2M0Y
	ivvvCBkEuObP+36+j4K9OqyDZORmmRckd7Z4bn7ohJ6a9B8s2NcCdZobL4qvKMo9
	EXre6+xvpw+uKYMu1D5ZWTWYFWaGUXPiI0pU8SnixwZMTzPeI1QmG8CrlILoniKp
	QfYalZd0HHa/7wtDc6PqGq8YpZEihCq7ub5wXFBWkw==
X-ME-Sender: <xms:j74DZkl6hyegxHAz5LxxdnxKVfBQWWJxgPCAvGDaB8_FxoPsO9XVwQ>
    <xme:j74DZj3Dzt29EGoayjTHLCsXKxy9E6FHhh3z3LrRIdPmzqbkgyAZ8p7-CZ4H3Lfmf
    cZu1a2qlWHbr5QBmw>
X-ME-Received: <xmr:j74DZipHDg6TzDowhrJINVSNkWBuxxSaMLSsjGcDNgJlpyascEFhRrizyMJtgzDlrVQvuNEkFarZ2mg6C3qLZ2uuzjMqtRsA4iz9Tv4-CxESCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:j74DZgl1nxu2Con-7Pwq7JYWg__y7Kr8UMBHh9utNh06ckym2RRxRw>
    <xmx:j74DZi2vmvTbNYjDBL0yz45VwnnuMSXoF0UnmMI1MioKDcnwtdYMdw>
    <xmx:j74DZnugoSMol9SNa1ANeuZayDDWq1n20qziY249ksl8K1SCQ4liJw>
    <xmx:j74DZuVnAXC3wDb9gJppZHwAS5huY9en5YAOngK3EC7J2PmRRr030Q>
    <xmx:j74DZgCVCZw5PQLaXFAhqHh203zMwhby8bTsYOxXY1m3zJ_6FLf_DQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16d7c4f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:36:49 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/9] reftable/block: merge `block_iter_seek()` and
 `block_reader_seek()`
Message-ID: <a2b7f0f559d381d649b6bf27403f099a68221f00.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mXxM2A4LZGnX8RRt"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--mXxM2A4LZGnX8RRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_iter_seek()` is merely a simple wrapper around
`block_reader_seek()`. Merge those two functions into a new function
`block_iter_seek_key()` that more clearly says what it is actually
doing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c      | 9 ++-------
 reftable/block.h      | 7 ++-----
 reftable/block_test.c | 4 ++--
 reftable/reader.c     | 4 ++--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index d5f32867bb..3f182c5d1f 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -362,19 +362,14 @@ int block_reader_first_key(struct block_reader *br, s=
truct strbuf *key)
 	return 0;
 }
=20
-int block_iter_seek(struct block_iter *it, struct strbuf *want)
-{
-	return block_reader_seek(it->br, it, want);
-}
-
 void block_iter_close(struct block_iter *it)
 {
 	strbuf_release(&it->last_key);
 	strbuf_release(&it->scratch);
 }
=20
-int block_reader_seek(struct block_reader *br, struct block_iter *it,
-		      struct strbuf *want)
+int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+			struct strbuf *want)
 {
 	struct restart_find_args args =3D {
 		.key =3D *want,
diff --git a/reftable/block.h b/reftable/block.h
index 44a9a8de7d..1734bee917 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -101,8 +101,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *bl,
 void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
=20
 /* Position `it` to the `want` key in the block */
-int block_reader_seek(struct block_reader *br, struct block_iter *it,
-		      struct strbuf *want);
+int block_iter_seek_key(struct block_iter *it, struct block_reader *br,
+			struct strbuf *want);
=20
 /* Returns the block type (eg. 'r' for refs) */
 uint8_t block_reader_type(struct block_reader *r);
@@ -115,9 +115,6 @@ void block_iter_copy_from(struct block_iter *dest, stru=
ct block_iter *src);
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
=20
-/* Seek to `want` with in the block pointed to by `it` */
-int block_iter_seek(struct block_iter *it, struct strbuf *want);
-
 /* deallocate memory for `it`. The block reader and its block is left inta=
ct. */
 void block_iter_close(struct block_iter *it);
=20
diff --git a/reftable/block_test.c b/reftable/block_test.c
index a719be7c50..26a9cfbc83 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -89,7 +89,7 @@ static void test_block_read_write(void)
 		strbuf_reset(&want);
 		strbuf_addstr(&want, names[i]);
=20
-		n =3D block_reader_seek(&br, &it, &want);
+		n =3D block_iter_seek_key(&it, &br, &want);
 		EXPECT(n =3D=3D 0);
=20
 		n =3D block_iter_next(&it, &rec);
@@ -98,7 +98,7 @@ static void test_block_read_write(void)
 		EXPECT_STREQ(names[i], rec.u.ref.refname);
=20
 		want.len--;
-		n =3D block_reader_seek(&br, &it, &want);
+		n =3D block_iter_seek_key(&it, &br, &want);
 		EXPECT(n =3D=3D 0);
=20
 		n =3D block_iter_next(&it, &rec);
diff --git a/reftable/reader.c b/reftable/reader.c
index d7d47e8640..f70efa2b7c 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -483,7 +483,7 @@ static int reader_seek_linear(struct table_iter *ti,
 		table_iter_copy_from(ti, &next);
 	}
=20
-	err =3D block_iter_seek(&ti->bi, &want_key);
+	err =3D block_iter_seek_key(&ti->bi, ti->bi.br, &want_key);
 	if (err < 0)
 		goto done;
 	err =3D 0;
@@ -558,7 +558,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek(&next.bi, &want_index.u.idx.last_key);
+		err =3D block_iter_seek_key(&next.bi, next.bi.br, &want_index.u.idx.last=
_key);
 		if (err < 0)
 			goto done;
=20
--=20
2.44.GIT


--mXxM2A4LZGnX8RRt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvowACgkQVbJhu7ck
PpSu/A/+M3/cP26KE14KRSC7k+l9Uj981bulRFsH9gC18MwALgLadJzT/aQO3YHf
r03THfyzDrulOtLLHsFwvMrl8+rTDsiyhRe4QFmITVwcYnD3IvvcJMNRE9L11axq
EPg3YzaIbBELNq3jYg7JiVOGWME1+gGXNQN1Iw4OSdS5p9QSAYUHTfuCz6IOSgDj
cj4CmBZT0raOiuA6nwPrvWYoMwgUTrM2CJdfO2D+xsClCZxJXO9W39FliZZq8VJn
YAI1Bf4PoUIcixy8xsFeqqIBBHwrS0LQ4QjlouVUX1kwNBBhZV+9yStIU2/I6mTQ
G6kB3JQfnuf9FNkcL1gdlFc6SNUffoyCII1oaJWPAKxeEWKMV1nJPqrAqWelauWV
DxWqFUoGybqelRg238i1c4X1uK4pcCAYFNrhcbaE5ambZ48Om6Cm6eNTLjtDmSBh
XBXQLfehpy49qYw8c8ewJKPF5+siX4lNWYtDS6MNi2RB7JbbsAhjZwRfpQegp6Zo
NVjjh0cHXOzOwET7M+srKB8hl7/fNru+IQGHzM//tjeLVf99DxOebHZ4WglXSMS2
hmAvY5oh94f6N3RvBtW3FuUNaFfFA/4pSgYkh4UsF64+BbG0fMzkrS57878DaSg6
J7crNO3IbXPbisMUdcQx+03TV4F1cP7oRIKK9TxWFqn+V10G0Eo=
=i4Pn
-----END PGP SIGNATURE-----

--mXxM2A4LZGnX8RRt--

Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0D6A33F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578590; cv=none; b=G18OzQXZYNWusj3tPpkBHeh/f9t8b6qFW4u18ayOl+PGBkyu0Sd/15WvQiCoLluHzXhiY2NSDqh9pKP1JkLrORj1pnZCeZuvMVUPyll9N+2sgwCa4TcS/n0JPAJpADBek+/+9ADjkRtEAQcpoqJPpEqdAI9rvd0M2/rjBnqFJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578590; c=relaxed/simple;
	bh=xVc+IjzeV1w1xktHOLJumt6neXUhA03X6KidEKUBpJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itg0xWNttFIZC0PNa5QZgcY9JijErrxWn0LN3FxCDjUrkFa1gCZwVNMhkqTr0m9BpHYTnVQw4aJptPJIQlwAj02kr1mil96WACr/Ugu0eixu1LBeQk1+/OUfoDdwcx6/irc5XIml5Qgxc0WUhaThwnRaQo066BHBCsgJ+OIovrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWDIlpu2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASDyIZCz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWDIlpu2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASDyIZCz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C27D114010F;
	Mon,  8 Apr 2024 08:16:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578587; x=1712664987; bh=Ax3JOv2Y28
	OrI27cZTdP+tnPdAm/VnCZrET20qCxPvQ=; b=JWDIlpu2QRFTp5zOcTg0Zmywhu
	2VcGa060zU4V+CNyAKy0RXsa6dzInebCHFGlVCBqBktR7YjMRYzui5CMAWZtbb0x
	YFjfTuYV53n1tpPgKdt1guLWeR5uBbvBehgwwo/fYFigwVMYoOTCMYeybvhOJBkm
	caePkhSQpQRT8OmptLLq3etWBjT6EUCF9D7t1Edg5PQqm79hG9sFjaURuqRVtoy/
	lJ5tRdwakA01IqNqwNpSQx7hEp5pzcLlDqHChAFX3/TGdm9K2yZzDtVG4UdEG2Zp
	D6ENnTzJAtRLWBPo1ACHshm8KgNKZAR+XdW9I1gUEpGYta5r4wRWoiluMP9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578587; x=1712664987; bh=Ax3JOv2Y28OrI27cZTdP+tnPdAm/
	VnCZrET20qCxPvQ=; b=ASDyIZCzcC8bzm1At3dNDqulka3g0YPaWRGn9Sv+9OYC
	41hfpXB2x5p5oYQGiaZnBr0HnBPTQNbY5QJw4K5EJzk5lcI6Afdy4mCy7gfFoGYK
	2nLuz8NwRV3SNnixbzt+Ha/sWD2iwVzApac7DLFjSsl2wRCTSjm0cxXaXnm7GmjP
	A8rKs1Ay5KNm+5hMcijga+odff5io/gB4PT7ciuUbWDsFFJz+n2vJZdF/01LN04e
	K7eTZ5Wbds//ZYgfTcYtY7pLOCyD9F5KiNnYNPD9xgo5/9BInvaWV+TRIWigygce
	8EyhU8y917Ar6kVa/OGNTrMIOwG28YuuWvWytxIMiA==
X-ME-Sender: <xms:G-ATZg06dvd1jGWEljpPloKj2WTN2DwAfU2KsyvQWXv823GEHsoPvw>
    <xme:G-ATZrGBcKdEIUEnbIkL1JTdgf3HCbUn4ak1obO9D10Uqc2YBHkRSbuVNGifwO5j-
    T-5DzL055v1Je-WhQ>
X-ME-Received: <xmr:G-ATZo6W-GNvWvsV7c8twIJznIH8jojbCLtb63mDpC241xbflyKYdeMKUNe6BSjTNti0WWadQlXb1m3O6j9zsveoSChoXh16wr6sDDpl3R7gNTqQwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:G-ATZp0a5xuWdtpRkHixyewvVgsF4FSWAuX5yIk5Sn2S0jgwMKjm4Q>
    <xmx:G-ATZjEnT26Mf92JmDSWRdMvvohQkZbmDCvhglnvlgSqRXC6umfJPg>
    <xmx:G-ATZi9S_DSRIOfTBVgIJIcvAJbUi8IgMu1A950xjfU5p_IRGTP1Zg>
    <xmx:G-ATZonJNjkljizZmBq95y8gEPDGSA6l_hvzudlWww8N3gQv-fs6SA>
    <xmx:G-ATZnig-vOIg5TI-za-0qTxVKXAkU9Xyfcaomv_NR_OoecRx8UR61yZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c8bfcd76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:18 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/10] reftable: optimize table and block iterators
Message-ID: <cover.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/xOwH4TdelXZ1Cll"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--/xOwH4TdelXZ1Cll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to optimize
the reftable table and block iterators.

Changes compared to v1:

    - The series now deepends on ps/reftable-binsearch-update at
      d51d8cc368 (reftable/block: avoid decoding keys when searching
      restart points, 2024-04-03). This is to resolve a merge conflict
      with that other series which has landed in "next" already.

    - Rewrote a comment to be single-line to fit into the style of other
      comments better.

    - A new patch on top that avoids copying block iterators altogether
      for another speedup.

Thanks!

Patrick

Patrick Steinhardt (10):
  reftable/block: rename `block_reader_start()`
  reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
  reftable/block: better grouping of functions
  reftable/block: introduce `block_reader_release()`
  reftable/block: move ownership of block reader into `struct
    table_iter`
  reftable/reader: iterate to next block in place
  reftable/block: reuse uncompressed blocks
  reftable/block: open-code call to `uncompress2()`
  reftable/block: reuse `zstream` state on inflation
  reftable/block: avoid copying block iterators on seek

 reftable/block.c      | 176 +++++++++++++++++++++++++-----------------
 reftable/block.h      |  47 ++++++-----
 reftable/block_test.c |   6 +-
 reftable/iter.c       |   2 +-
 reftable/reader.c     | 176 ++++++++++++++++++++++--------------------
 5 files changed, 229 insertions(+), 178 deletions(-)

Range-diff against v1:
 1:  24b0dda29e =3D  1:  eb487557a8 reftable/block: rename `block_reader_st=
art()`
 2:  a2b7f0f559 !  2:  d0b318b8ee reftable/block: merge `block_iter_seek()`=
 and `block_reader_seek()`
    @@ reftable/block.c: int block_reader_first_key(struct block_reader *br=
, struct str
     +int block_iter_seek_key(struct block_iter *it, struct block_reader *b=
r,
     +			struct strbuf *want)
      {
    - 	struct restart_find_args args =3D {
    - 		.key =3D *want,
    + 	struct restart_needle_less_args args =3D {
    + 		.needle =3D *want,
    =20
      ## reftable/block.h ##
     @@ reftable/block.h: int block_reader_init(struct block_reader *br, st=
ruct reftable_block *bl,
 3:  88a705b3e2 =3D  3:  c3f928d1e9 reftable/block: better grouping of func=
tions
 4:  9a1253649a =3D  4:  35f1bf5072 reftable/block: introduce `block_reader=
_release()`
 5:  f10882a084 !  5:  e8e8bbae62 reftable/block: move ownership of block r=
eader into `struct table_iter`
    @@ reftable/block.c: int block_reader_first_key(struct block_reader *br=
, struct str
      	it->next_off =3D br->header_off + 4;
      }
     @@ reftable/block.c: void block_iter_seek_start(struct block_iter *it,=
 struct block_reader *br)
    - struct restart_find_args {
    + struct restart_needle_less_args {
      	int error;
    - 	struct strbuf key;
    --	struct block_reader *r;
    -+	const struct block_reader *r;
    + 	struct strbuf needle;
    +-	struct block_reader *reader;
    ++	const struct block_reader *reader;
      };
     =20
    - static int restart_key_less(size_t idx, void *args)
    -@@ reftable/block.c: static int restart_key_less(size_t idx, void *arg=
s)
    - 	return result < 0;
    + static int restart_needle_less(size_t idx, void *_args)
    +@@ reftable/block.c: static int restart_needle_less(size_t idx, void *=
_args)
    + 	return args->needle.len < suffix_len;
      }
     =20
     -void block_iter_copy_from(struct block_iter *dest, struct block_iter =
*src)
    @@ reftable/block.c: int block_iter_next(struct block_iter *it, struct =
reftable_rec
     +int block_iter_seek_key(struct block_iter *it, const struct block_rea=
der *br,
      			struct strbuf *want)
      {
    - 	struct restart_find_args args =3D {
    + 	struct restart_needle_less_args args =3D {
     @@ reftable/block.c: int block_iter_seek_key(struct block_iter *it, st=
ruct block_reader *br,
      		it->next_off =3D block_reader_restart_offset(br, i - 1);
      	else
    @@ reftable/block.h: struct block_iter {
      /* return < 0 for error, 0 for OK, > 0 for EOF. */
      int block_iter_next(struct block_iter *it, struct reftable_record *re=
c);
     =20
    -+/*
    -+ * Reset the block iterator to pristine state without releasing its m=
emory.
    -+ */
    ++/* Reset the block iterator to pristine state without releasing its m=
emory. */
     +void block_iter_reset(struct block_iter *it);
     +
      /* deallocate memory for `it`. The block reader and its block is left=
 intact. */
 6:  ae359cb714 =3D  6:  685f0a40bc reftable/reader: iterate to next block =
in place
 7:  1e4eba7e9b =3D  7:  a7906a3383 reftable/block: reuse uncompressed bloc=
ks
 8:  bf4c1ab797 =3D  8:  6635c7b986 reftable/block: open-code call to `unco=
mpress2()`
 9:  43e6538968 =3D  9:  587b5601c0 reftable/block: reuse `zstream` state o=
n inflation
 -:  ---------- > 10:  cc5ff0d598 reftable/block: avoid copying block itera=
tors on seek
--=20
2.44.GIT


--/xOwH4TdelXZ1Cll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4BUACgkQVbJhu7ck
PpTl+A/+I2oBhKDXRl4waRt5oMYWFZXZCLAat687csZ4/pWB3cKoGbn/X1D5u/1Q
Role+7tSaydnFePrEJTsjyYNhF9XDedzSwIXBep6oHdRIhfBE7kBQR+U6k28gUjx
edHACAyeeRHh4DXkkBb5dREy2ihjqkdtO/3Pb8khmBXm5JDFEJMsv3BH7+6rXE+E
wtJecy9pGthq7l29xQWbeXDmS6yFPKUJn5VHnedz3wxMPJE1La+deC/0KHTw2kyF
3FLE51Il+dZrBYvxA0CNYqieWrIcKlwo9j0x3kzHlXUGrDpQ+pBVWhVMnVqzh8GV
RgDmdYM/0XVtib8HtlXE0a9HQQ/OMJ8BhV8iWMeWXBnnLLkUos76rO/m2jUWCTet
Z+D7NAVMxEs909ld/s6+o1e9YszoQa7//o6Ig65EW0dktnBZfczmwuqUenaN2zKm
aEafZWTF4i5P63cCXsc/I7TSYNpNdycEOSJKYNeJChGaS3u/aV701HWeT6Js7vy/
cJGcTd9bEb3DIMzzXUmUB9wpG55b4AAIOIRARvUBJ/yh2WpvQC7J/8wF9jt2VQEy
OcXsyD6zluP1UkLCAMCUEIfArZipU0j+me6Txo5XrkUL28PX+GahPcWinxL91T9a
v76oSepHnALQsGRQajSBR6NkkmsTAsMVCFykzdooia1008T76Zg=
=mIj0
-----END PGP SIGNATURE-----

--/xOwH4TdelXZ1Cll--

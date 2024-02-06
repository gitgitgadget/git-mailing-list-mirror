Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B73127B73
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201327; cv=none; b=itYeEDjvOYtbAwBnrViKPKeUfc7jNbyJodOzHEgHbIXWKIEe1lriKwTkXGSgdT4GpsPR5JwJLCbdkFX+sMIm5NELcfzAIn3RYt0kw1FYdXN8GfauLzY/tCBrzDBEAzdEqnJMi0/S6ZxbEGMHznn0AUGtWjCz2J8OZqgwQCR3+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201327; c=relaxed/simple;
	bh=AsnO7lf9kbnK7kgVZ/StJJStSuC1gPa9rJuI5bf6yuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0imrhxFCHXQ0HfRQQo/P2Lz8kFMx4MsnMlrYE+XXCtwwru3SG3s9vZqUDQAjJhflqYYeTXUTOwcGdpoIRbastTH5m8IYqrJrL4O/IQesSkyHzT/qa5isBMcOpOFL9HHJju3Im6SYejxSb0vHeym3T6Zb6THPhRXlkz2brL6BNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nGpP3+i4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eH3TLmPE; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nGpP3+i4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eH3TLmPE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 5F1003200A48;
	Tue,  6 Feb 2024 01:35:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201323; x=1707287723; bh=V9Xm+eobsg
	UELyVp42i7FOjBS12+56b90fzIVFShXj4=; b=nGpP3+i4W5VWTKVkUbzaSQtv+i
	5S1UYPLtzJAegXNP6upBqTwCX3pKsUu52A56w1CVl9T/DpFAgatAvuyTOljWGRtQ
	phV44GetTR3nPGMGQvdNqaxt/hLEGQ+IGGBaI+uWV+pD6hWyYtVM4QY5/VZUENo9
	MJqjUEshPjtQp3fswUijo7FBG0u66WzkUak6qYnr/0KMcVt5Vh6UVTdva5Y69Dhk
	19HArl41GD7wbFMa/+Mb0p/92+NbAa3yr4fsiU0vuHNB59qzOt1jVUedpkJZjkzN
	MM/AYLT6jW+A2ClURBObzRyntHX/rUs49haTPFYLqLweLq39s1kvB3TifLTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201323; x=1707287723; bh=V9Xm+eobsgUELyVp42i7FOjBS12+
	56b90fzIVFShXj4=; b=eH3TLmPEjHwcnCDQ0ofpBXGqHPwKfUGWpBjWRT/npxWG
	6Ki4JLexyOQKvo3C30lQsrQpFGeSc5uTi+uww5BuM2H2CB5e62/OVa38DPdLWTP0
	0d+6H2gDvXnUwRd/VzZGlcxsVlhJjASuLzKWwT7YPgbmLWOVMr3b0Cevp+1HspS4
	oGJNjJ0MuMsKSXOdnzRv+4CUdfB19I+UKPGWJN7ZhqjbDvFAtiufleIEE9W3agdU
	ug0PfdlXs1C11/nT1ceF1/uqofXDcTa2shP/nqD6rn8EqOxGZy7Smtl79gMGYCmo
	xzAY/jSYjB/umC1c42Aob4XYjhLnY1tQy+8cnDb8pA==
X-ME-Sender: <xms:K9PBZYpelKuaQ_LJdEMFTaVF_Rd-d_k7hpZ2yE8aPJaBTqb2FH8c5w>
    <xme:K9PBZepYSnZRGlU4fWgh04sWW6CSizOSnXY7mtAubAqS8vd4iHZ2F1PvwKJkth6_-
    p_A1nRTjOE7wNeTPA>
X-ME-Received: <xmr:K9PBZdNvogQSPIQYJAgluL26KnutFel92I5yfsLyhpQxhOynQ3UfujUvUXfc5TXkvxgMW1IIRpZVnH_vHC4kKOH74daomIoZWfT9VBx5HhGJ-CED>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegvedtffehvdehheegueeuffefteeitdefheejheetveeiheekkeeifefhvdev
    heenucffohhmrghinhepuhhpuggrthgvrdhnvgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:K9PBZf6aCD_4bs-Qgja7shJsCKcEAKgFpY68lKSfpjdusha34ws59g>
    <xmx:K9PBZX72VfS06pNHviucrGev1ELIiZaCipYDXX3Tz9f8iBg01fiGuA>
    <xmx:K9PBZfjDHUUOT100o9kteYRrce9kim_f3lyiNQzUuCGcAwLfKrribw>
    <xmx:K9PBZa1GHVT33VN1RARanRuwFoj-d4UnogXLf-BS5-3fcoVy1cc3jw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0f993ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:31:51 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/9] reftable: code style improvements
Message-ID: <cover.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xBj3apZ3AZA1F04l"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--xBj3apZ3AZA1F04l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that tries to align the
reftable library's coding style to be closer to Git's own code style.

The only change compared to v2 is that I've now also converted some
calls to `reftable_malloc()` to use `REFTABLE_ALLOC_ARRAY`.

Thanks!

Patrick

Patrick Steinhardt (9):
  reftable: introduce macros to grow arrays
  reftable: introduce macros to allocate arrays
  reftable/stack: fix parameter validation when compacting range
  reftable/stack: index segments with `size_t`
  reftable/stack: use `size_t` to track stack slices during compaction
  reftable/stack: use `size_t` to track stack length
  reftable/merged: refactor seeking of records
  reftable/merged: refactor initialization of iterators
  reftable/record: improve semantics when initializing records

 reftable/basics.c          |  15 ++--
 reftable/basics.h          |  17 ++++-
 reftable/block.c           |  35 ++++-----
 reftable/block_test.c      |   2 +-
 reftable/blocksource.c     |   4 +-
 reftable/iter.c            |   3 +-
 reftable/merged.c          | 100 +++++++++++-------------
 reftable/merged_test.c     |  52 ++++++-------
 reftable/pq.c              |   8 +-
 reftable/publicbasics.c    |   3 +-
 reftable/reader.c          |  12 ++-
 reftable/readwrite_test.c  |   8 +-
 reftable/record.c          |  57 +++++---------
 reftable/record.h          |  10 +--
 reftable/record_test.c     |   8 +-
 reftable/refname.c         |   4 +-
 reftable/reftable-merged.h |   2 +-
 reftable/stack.c           | 153 +++++++++++++++++--------------------
 reftable/stack.h           |   6 +-
 reftable/stack_test.c      |   7 +-
 reftable/tree.c            |   4 +-
 reftable/writer.c          |  21 ++---
 22 files changed, 236 insertions(+), 295 deletions(-)

Range-diff against v2:
 1:  12bd721ddf =3D  1:  12bd721ddf reftable: introduce macros to grow arra=
ys
 2:  2dde581a02 !  2:  95689ca7ce reftable: introduce macros to allocate ar=
rays
    @@ Commit message
         it means that we can now provide proper overflow checks when multi=
plying
         the array size with the member size.
    =20
    -    Convert callsites of `reftable_calloc()` to the new signature, usi=
ng the
    -    new macros where possible.
    +    Convert callsites of `reftable_calloc()` to the new signature and =
start
    +    using the new macros where possible.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ reftable/basics.h: int names_length(char **names);
      #define REFTABLE_ALLOC_GROW(x, nr, alloc) \
      	do { \
    =20
    + ## reftable/block.c ##
    +@@ reftable/block.c: int block_writer_finish(struct block_writer *w)
    + 		int block_header_skip =3D 4 + w->header_off;
    + 		uLongf src_len =3D w->next - block_header_skip;
    + 		uLongf dest_cap =3D src_len * 1.001 + 12;
    ++		uint8_t *compressed;
    ++
    ++		REFTABLE_ALLOC_ARRAY(compressed, dest_cap);
    +=20
    +-		uint8_t *compressed =3D reftable_malloc(dest_cap);
    + 		while (1) {
    + 			uLongf out_dest_len =3D dest_cap;
    + 			int zresult =3D compress2(compressed, &out_dest_len,
    +@@ reftable/block.c: int block_reader_init(struct block_reader *br, st=
ruct reftable_block *block,
    + 		uLongf dst_len =3D sz - block_header_skip; /* total size of dest
    + 							    buffer. */
    + 		uLongf src_len =3D block->len - block_header_skip;
    +-		/* Log blocks specify the *uncompressed* size in their header.
    +-		 */
    +-		uncompressed =3D reftable_malloc(sz);
    ++
    ++		/* Log blocks specify the *uncompressed* size in their header. */
    ++		REFTABLE_ALLOC_ARRAY(uncompressed, sz);
    +=20
    + 		/* Copy over the block header verbatim. It's not compressed. */
    + 		memcpy(uncompressed, block->data, block_header_skip);
    +
      ## reftable/block_test.c ##
     @@ reftable/block_test.c: static void test_block_read_write(void)
      	int j =3D 0;
    @@ reftable/readwrite_test.c: static void test_table_read_write_seek_in=
dex(void)
      	uint8_t want_hash[GIT_SHA1_RAWSZ];
     =20
    =20
    + ## reftable/record.c ##
    +@@ reftable/record.c: static void reftable_obj_record_copy_from(void *=
rec, const void *src_rec,
    + 		(const struct reftable_obj_record *)src_rec;
    +=20
    + 	reftable_obj_record_release(obj);
    +-	obj->hash_prefix =3D reftable_malloc(src->hash_prefix_len);
    ++
    ++	REFTABLE_ALLOC_ARRAY(obj->hash_prefix, src->hash_prefix_len);
    + 	obj->hash_prefix_len =3D src->hash_prefix_len;
    + 	if (src->hash_prefix_len)
    + 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
    +=20
    +-	obj->offsets =3D reftable_malloc(src->offset_len * sizeof(uint64_t));
    ++	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
    + 	obj->offset_len =3D src->offset_len;
    + 	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
    + }
    +@@ reftable/record.c: static int reftable_obj_record_decode(void *rec,=
 struct strbuf key,
    + 	int n =3D 0;
    + 	uint64_t last;
    + 	int j;
    +-	r->hash_prefix =3D reftable_malloc(key.len);
    ++
    ++	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
    + 	memcpy(r->hash_prefix, key.buf, key.len);
    + 	r->hash_prefix_len =3D key.len;
    +=20
    +@@ reftable/record.c: static int reftable_obj_record_decode(void *rec,=
 struct strbuf key,
    + 	if (count =3D=3D 0)
    + 		return start.len - in.len;
    +=20
    +-	r->offsets =3D reftable_malloc(count * sizeof(uint64_t));
    ++	REFTABLE_ALLOC_ARRAY(r->offsets, count);
    + 	r->offset_len =3D count;
    +=20
    + 	n =3D get_var_int(&r->offsets[0], &in);
    +@@ reftable/record.c: static void reftable_log_record_copy_from(void *=
rec, const void *src_rec,
    + 		}
    +=20
    + 		if (dst->value.update.new_hash) {
    +-			dst->value.update.new_hash =3D reftable_malloc(hash_size);
    ++			REFTABLE_ALLOC_ARRAY(dst->value.update.new_hash, hash_size);
    + 			memcpy(dst->value.update.new_hash,
    + 			       src->value.update.new_hash, hash_size);
    + 		}
    + 		if (dst->value.update.old_hash) {
    +-			dst->value.update.old_hash =3D reftable_malloc(hash_size);
    ++			REFTABLE_ALLOC_ARRAY(dst->value.update.old_hash, hash_size);
    + 			memcpy(dst->value.update.old_hash,
    + 			       src->value.update.old_hash, hash_size);
    + 		}
    +
      ## reftable/record_test.c ##
     @@ reftable/record_test.c: static void test_reftable_log_record_roundt=
rip(void)
      				.value_type =3D REFTABLE_LOG_UPDATE,
    @@ reftable/stack.c: static ssize_t reftable_fd_write(void *arg, const =
void *data,
      	struct strbuf list_file_name =3D STRBUF_INIT;
      	int err =3D 0;
     =20
    +@@ reftable/stack.c: static int fd_read_lines(int fd, char ***namesp)
    + 		goto done;
    + 	}
    +=20
    +-	buf =3D reftable_malloc(size + 1);
    ++	REFTABLE_ALLOC_ARRAY(buf, size + 1);
    + 	if (read_in_full(fd, buf, size) !=3D size) {
    + 		err =3D REFTABLE_IO_ERROR;
    + 		goto done;
     @@ reftable/stack.c: int read_lines(const char *filename, char ***name=
sp)
      	int err =3D 0;
      	if (fd < 0) {
 3:  f134702dc5 =3D  3:  f0e8f08884 reftable/stack: fix parameter validatio=
n when compacting range
 4:  50dac904e8 =3D  4:  7bcfe7b305 reftable/stack: index segments with `si=
ze_t`
 5:  a5ffbf09dd =3D  5:  a0867c0378 reftable/stack: use `size_t` to track s=
tack slices during compaction
 6:  55605fb53b =3D  6:  29c5a54ae8 reftable/stack: use `size_t` to track s=
tack length
 7:  80cf2fd272 =3D  7:  4605ad7247 reftable/merged: refactor seeking of re=
cords
 8:  8c1be2b159 =3D  8:  8c35968ce8 reftable/merged: refactor initializatio=
n of iterators
 9:  c39d7e30e7 =3D  9:  5bb2858c13 reftable/record: improve semantics when=
 initializing records
--=20
2.43.GIT


--xBj3apZ3AZA1F04l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0yYACgkQVbJhu7ck
PpSN0Q/+KZvduL1CaPMXV4+tuSs3LUScA/p/kKWKe7wLJPLsq7X9yZegfiMbHGYG
vG93XDHYVSwCd6f2/ImoIMHdm+d5cnTO9DlpRk/6rk0DILX+wgkhP0rsp8WEfatE
Zjj1DfCSqjz/tWfgue0gkx6DYGHzEuVFWptswl75jRuysGEIiQ+g2PCwhjf8yjXH
PW0VmHPJEtXjBEl4itp4s1+wFhwtXSwJDIrzhQGMxZcnIZfTfSVs2hVhzg86S4kt
y4pIydHg2g6UjWW9IJPXS031+i5h2JkhHD7Su7tHAmqB6CPhjFd9+CrIBD6hhveX
BRDKvY4w3mjuCLDuwUEwuRT48iqTHIIZSTW9X+3i3/0wW9WZXHXThSN1KilMFJpn
wX5c9CfFNeDSdmj1gtcx+wlu/CQ+QeSdgp8imgFVuKV4WJXyddlCPf5ZyDRbCN/U
RUUerX9Kuo97F0yllM7GGxoyxY2uXswLw08JQjUz6gVaKMSSAjhuhLoojdRLjDlT
prRlgNidbC6qZyd6uS+IxM4BRJwwKSEW7pe+HdS8w54toEegFv8VmRnt6VW+4gz9
hhAhBGL9vIC0ECG+f/vyvpsoYKeIV4XU7cXLJyOU9y/R2j1i7hHYnr9PyU/7yDNW
5gxnAlqeev7bhCbVMRxhSiBCQhN+jU+8G6RGG+OfQ3qD3kO+FTQ=
=72S2
-----END PGP SIGNATURE-----

--xBj3apZ3AZA1F04l--

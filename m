Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD22C6A6
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521450; cv=none; b=OfIuwpQXoRCR+kPYsDzTK2kaKAhqfShYW3rRob1BnnQ4dz4HjEL/KXFA6suowpX91WFArYZSlV5zV4tBMNNjuXK2a2GacxQdw+kgD3QItTUAFVUxNiiYhGDITazgkSQEsBL34WQTkMYhtExW70nYi5cQSLFF5yOU38zS6Ug6oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521450; c=relaxed/simple;
	bh=IdVC8k3FMK72jrQgPlSN+V22j4ADzqBIghoxQp2DS+Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1rkPKwf00vzwq5ksPO83dFoZthzW2qhAp2BteySN/zPrmcRiuNCernslVUdHdOZdkLkSIjR1GiONZvb6Iv+J2XGEZq32YjmY0HPhG0bGU8gbii3pAMgbEluEmFjBM0urjZi2nCJ06NQ0+x7iI5QqNBTuGYW7gOTF7BUpT0iaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gB4zbTMI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hsq8QByo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gB4zbTMI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hsq8QByo"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id CECDD13800D7
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 02:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521447; x=1711607847; bh=Rqg7RypIZf
	fH+1HJVz4Isxm3PsqW04EIop/3o0kO6ms=; b=gB4zbTMIBT8KpYyvK6wfZQlM2/
	eMXRQ5/jy9rsL/ouQufnimJvvn/Cg5jOO1OlKn0p0qftoCtchkVjExD2FuOMayGi
	WskcnJKlJL/yoX/y2CjQrnWRxkGUjKglsyUTPGb1SQpgYNlB+F0Lnx6ZZtd4clQa
	1lS39ytygx3HJiKzOgWv07FKvhmyDAawm67GOBJLi+N0jhbitzQkK8eTdGlYlOu/
	uhOi8cQ8dJOT6fqhn8Roh3UJAlfDVQEqo6PvxF45HE6B4WjK9dKdd4roTlVqyWTL
	E2KTE1NZDbGbofgar2qj3vWyKhkccnGP8LgbH7AXR6NOwVtDRavqHtF6Ar8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521447; x=1711607847; bh=Rqg7RypIZffH+1HJVz4Isxm3PsqW
	04EIop/3o0kO6ms=; b=Hsq8QByoEoHBZbc0dqVjzpKkihEp+tDQk0+wsXvzyxtr
	qaR2XkC1RcGWBK+2ql6FFkb7WiZ5fkGQv6gskcyrpw8LE23Ox0J/awp71fcIvDfP
	3pNqhz6dLYpVpQQMBd2VaNibBgamkyRLKUxI2Mw3CT3+mS4tMuL97nM+jkuxetUk
	G05OCfEXiITMLzgu1WaA/OF0MrXJWYy9DLBtzmM23Os4meRx3Rx66dcLCqYUU1K7
	EFQwEiMxorSV1Q3gclEGNbr6aq94YwpSVtZRwgpMDG6ErasIZgVWIxwVCItN3EJ0
	gMCRNG7wJDeV6Xc2050DsO7tGznyXYDZurtT6iICQA==
X-ME-Sender: <xms:p74DZvMb_e_j0RRNWs8Nzr0WwbwYGewdBr_sBtgT7TalT2iYheb2sg>
    <xme:p74DZp9U21ucvcvnIaa0EL-g9pc-gkePyjO-oa0sgMpuYn019X7WJIfzW4kdOXp3m
    Ag1e2ZRmuGblMkePA>
X-ME-Received: <xmr:p74DZuQ5XgYJ-ETI9AyesBjhprgbVJwdlcLX2G3gLfruT92JGo-XbdcZCo59n22JzHmMEjXx5KplmVHXYaaEff2Ksc8BYVA81W1CbeNOuwcgvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:p74DZjvqNLn5sB4lWzxD1F30K9cPK-yT6ze0819rWVh7ebOgcPkAvA>
    <xmx:p74DZneBoLpOyAnCV48Iw7HQYPzI3e0KJzzdtdTJ7Cf5Q_OJC9ulGg>
    <xmx:p74DZv2lQrfDu9qLD14d0IIoM2Ce4Xn_tVfwRxMRNFF3UERBG9abvg>
    <xmx:p74DZj-MW8YGz7bNJsXd17FDiw2vSH-ZvzoE2x-fToLFovfI5DHUNg>
    <xmx:p74DZoqmFxsvM9-tBu0r-ek-NPqBXoRv57yJAoQrb8YGSyw0JzCv5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82895446 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:37:14 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/9] reftable/block: open-code call to `uncompress2()`
Message-ID: <bf4c1ab797d32284b469034c5272383fd998439e.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cq/v6Lxxnc707u00"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--Cq/v6Lxxnc707u00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format stores log blocks in a compressed format. Thus,
whenever we want to read such a block we first need to decompress it.
This is done by calling the convenience function `uncompress2()` of the
zlib library, which is a simple wrapper that manages the lifecycle of
the `zstream` structure for us.

While nice for one-off inflation of data, when iterating through reflogs
we will likely end up inflating many such log blocks. This requires us
to reallocate the state of the `zstream` every single time, which adds
up over time. It would thus be great to reuse the `zstream` instead of
discarding it after every inflation.

Open-code the call to `uncompress2()` such that we can start reusing the
`zstream` in the subsequent commit. Note that our open-coded variant is
different from `uncompress2()` in two ways:

  - We do not loop around `inflate()` until we have processed all input.
    As our input is limited by the maximum block size, which is 16MB, we
    should not hit limits of `inflate()`.

  - We use `Z_FINISH` instead of `Z_NO_FLUSH`. Quoting the `inflate()`
    documentation: "inflate() should normally be called until it returns
    Z_STREAM_END or an error. However if all decompression is to be
    performed in a single step (a single call of inflate), the parameter
    flush should be set to Z_FINISH."

    Furthermore, "Z_FINISH also informs inflate to not maintain a
    sliding window if the stream completes, which reduces inflate's
    memory footprint."

Other than that this commit is expected to be functionally equivalent
and does not yet reuse the `zstream`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 31af075c1d..31e7255056 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -195,10 +195,10 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 	}
=20
 	if (typ =3D=3D BLOCK_TYPE_LOG) {
-		int block_header_skip =3D 4 + header_off;
-		uLongf dst_len =3D sz - block_header_skip; /* total size of dest
-							    buffer. */
-		uLongf src_len =3D block->len - block_header_skip;
+		uint32_t block_header_skip =3D 4 + header_off;
+		uLong dst_len =3D sz - block_header_skip;
+		uLong src_len =3D block->len - block_header_skip;
+		z_stream stream =3D {0};
=20
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
@@ -207,15 +207,33 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(br->uncompressed_data, block->data, block_header_skip);
=20
-		/* Uncompress */
-		if (Z_OK !=3D
-		    uncompress2(br->uncompressed_data + block_header_skip, &dst_len,
-				block->data + block_header_skip, &src_len)) {
+		err =3D inflateInit(&stream);
+		if (err !=3D Z_OK) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
=20
-		if (dst_len + block_header_skip !=3D sz) {
+		stream.next_in =3D block->data + block_header_skip;
+		stream.avail_in =3D src_len;
+		stream.next_out =3D br->uncompressed_data + block_header_skip;
+		stream.avail_out =3D dst_len;
+
+		/*
+		 * We know both input as well as output size, and we know that
+		 * the sizes should never be bigger than `uInt_MAX` because
+		 * blocks can at most be 16MB large. We can thus use `Z_FINISH`
+		 * here to instruct zlib to inflate the data in one go, which
+		 * is more efficient than using `Z_NO_FLUSH`.
+		 */
+		err =3D inflate(&stream, Z_FINISH);
+		inflateEnd(&stream);
+		if (err !=3D Z_STREAM_END) {
+			err =3D REFTABLE_ZLIB_ERROR;
+			goto done;
+		}
+		err =3D 0;
+
+		if (stream.total_out + block_header_skip !=3D sz) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
@@ -224,7 +242,7 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		reftable_block_done(block);
 		block->data =3D br->uncompressed_data;
 		block->len =3D sz;
-		full_block_size =3D src_len + block_header_skip;
+		full_block_size =3D src_len + block_header_skip - stream.avail_in;
 	} else if (full_block_size =3D=3D 0) {
 		full_block_size =3D sz;
 	} else if (sz < full_block_size && sz < block->len &&
--=20
2.44.GIT


--Cq/v6Lxxnc707u00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvqQACgkQVbJhu7ck
PpSsQQ/+I/zMgBo+BxCs4hXLPP77WV7SVbCNvj23pTEkqRyk/2vyp99ajNIqiOuu
iB50wOI2vhKMrjvFbu3gx448uQME5+xBiw9RICp4zVg4rS20V7Yecx6SwjoQV0Lz
V7t0hKOp1YHLnLHpDF028LoXqPQxHf9whBBnS+nvay8rh/XQpH3K4qtGrbYy0PXm
ulgIRZnGXT9IN0PWGu3xFA0iXH7vQOI864taVKVGWNK+3vxDcJBq/d2agU0ihgmN
XFdWRiH0fnVLto12vaySwcysvvZmRlispRux27ZQCKdSeH//GVSR6G82qJTI4yRb
HNlktihnQ3hqVmI0gL3uCYaKm/KBqzz0xJ1TcvVCjJSqXmCwS6njDjH3cvz8rLdZ
OyL30XlLYLH6nfZCcaDDU2UU8V6N7zhsw1pBIZu5APYCmwg1Yrn6sFh6wJZKQNQ1
Y6c/qyZ/l1wJqw2FZgAZPcnpqNhG8q7X248u8PlRQy3XvSv4n1JZPXVMJJZIHmDm
pb2ifKry03fN4Nb2GuAIN48GWhoD0GVndq+O21XWw1XfRWPZcgZzw+5mVPl+kkAh
gpxUHVbl9go8hx+wVAnALcyG+GfwJkrutF3vj0IA1GuDuW8tVMdGf5OIQb1kiL2c
joURQjZH7lQps9uqIFMqvmcd4tMYOOzN2V4GfKKn7taGQCf+EuU=
=KzkG
-----END PGP SIGNATURE-----

--Cq/v6Lxxnc707u00--

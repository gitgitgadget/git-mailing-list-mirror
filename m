Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298F2AF0F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578639; cv=none; b=avHzoMzNiPsyzw8WhoIMiyvAKrHIVCtipZCjPLU8BIUuOmFgRkOnEaihkzvp+TmDZwMBRmpwpvGF8lLik+yQxIWDyRa7HkdZDWtf8rVYdSW/fsOZOMCj9/irlJvmAgybbPzLtVwQBmDoNhA2WAouYOhJZRUXJ7k6jlYIU76U3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578639; c=relaxed/simple;
	bh=NUCfYJNFSAPiD5SdeKaNwEP6IPrYN+qdv3eAnbCtz3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPVOlraQWZycHnyW12Bcsftxazq3KvsKoCGwwOA4Sw0R8gN38OLSbecqQjJPUy6KVDjGNojF3vGzhRBmMQIBFz++CUtmwI6mhRjQUM/YMd4XJ4ehaorYHxXIP+RSkko6PxETUims6Gpg2D0+XhvcfWt/fRoJOVQWJHs3bjye/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DNxJjwLK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljBcfuUF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DNxJjwLK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljBcfuUF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CB96311400F9;
	Mon,  8 Apr 2024 08:17:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 08:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578631; x=1712665031; bh=jma2GOiNkp
	rpT2NaL0euVdJd//RSQxhROsTGTdurSkA=; b=DNxJjwLKPfKkmVo115nzsPkbfd
	tMpFqZtS+CoLAInyFlKZsRkWJcupn8Bd4kA2o6c+8JiCI3MiQIVrY+Of7H+4EQ8H
	d9Z5JLvbt3e04ov9zY9gdCf0jUisRpAtuHciRUIyyWOiTKkCA6Qpn5kAWLWHEbhf
	y8ZFhXjfMVNsxTDduwUTcGCgZvsSQ3AkY5+XeE+TYcBANHkF0GD1LVlBFS/fGA6G
	ZBjCcJsBdl0MJ/PsRDT6X3AqBzSyRTFaWBd8vFsN9c6LU8B9U1vPERK88h3naZp7
	Xz9URnuAWvHcCvw2PZQlZ/ukoc1/hugCs5pDUOGMOMYHjo5OVBaNeTJlGQ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578631; x=1712665031; bh=jma2GOiNkprpT2NaL0euVdJd//RS
	QxhROsTGTdurSkA=; b=ljBcfuUFRBz0ruWdI7wjOTAoD0dJDwg77VV076QwHQl0
	+QXTCKxc3GyoKunOyfl0nqsSRetoiomqfjbSVrrowqC/srvvKa4JQtBcqz47rEs3
	cduZMjSgjuZC+FDvsbKxAG5ry3Z+EJcn22ah/DiL7l/SwlDFmt/47s5tUxiX7wnd
	LIu8Ni/iHenYlUcaoOG3Y559h02ND9Yo8rXwJ95Nj9u7g1DS85e4ocQQqdExhd/M
	uKO9lFOhXk1iPlNhcM9kg3wWO0lRH14/mxhOg5Aja1mbkefLizLs8FNtMxOANuAR
	S87bBG8xYVg22Pu8zs4bpfbFTO66+1Z1MaqYc24c2g==
X-ME-Sender: <xms:R-ATZn8dQrTQffG2qT3AFesLW0h3ZUJyvVrxQDIjxby6GXF8RGY7eQ>
    <xme:R-ATZjvFsMF1NQrnBEO2mZFhfSt1hrPjBX1H3vYgjqdMAazkt1WOq9w-RmTKi34mW
    FXg5pacRWGQTuRIBg>
X-ME-Received: <xmr:R-ATZlBUOz2D3UBxd0ap3_VTh-oi3w0yqhiLaRtdBrkcw9eiLxRlq_llJ5tky4LwsPM2w3JAPqYjcacIIGtfErjyp1YJVOdHWX24ev7s0Q4EbhzDCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R-ATZjcypr46Q4cpwfo9fjpHFQivmmHVhc122A4bwx_5ktJuqD1hPQ>
    <xmx:R-ATZsOP2LbzhIappcTnCVqNrTXcnPI-KB5PdJjO6TplxHKHt_phqw>
    <xmx:R-ATZlkECY7-NeHk7ZikqJc5speBthf96ibHCMm785g0f_WWsfl1PA>
    <xmx:R-ATZmthaDYFoUz_tuuUlW0yoWqK3jJEBynKjHVfFdKv-UnpfHJEbg>
    <xmx:R-ATZpqSXrZKVUkHzjmczYPG-20bPrT3C7e52b61s6hXgoZb0w2CEnAh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:17:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 168ff877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:17:04 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:17:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/10] reftable/block: avoid copying block iterators on
 seek
Message-ID: <cc5ff0d5988691043206f9e912f5ffa1bcfee94e.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CV2eYUrIm+6KYGpK"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--CV2eYUrIm+6KYGpK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When seeking a reftable record in a block we need to position the
iterator _before_ the sought-after record so that the next call to
`block_iter_next()` would yield that record. To achieve this, the loop
that performs the linear needs to restore the previous position once it
has found the record.

This is done by advancing two `block_iter`s: one to check whether the
next record is our sought-after record, and one that we update after
every iteration. This of course involves quite a lot of copying and also
leads to needless memory allocations.

Refactor the code to get rid of the `next` iterator and the copying this
involves. Instead, we can restore the previous offset such that the call
to `next` will return the correct record.

Next to being simpler conceptually this also leads to a nice speedup.
The following benchmark parser 10k refs out of 100k existing refs via
`git-rev-list --no-walk`:

  Benchmark 1: rev-list: print many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):     170.2 ms =C2=B1   1.7 ms    [User: 86.1 =
ms, System: 83.6 ms]
    Range (min =E2=80=A6 max):   166.4 ms =E2=80=A6 180.3 ms    500 runs

  Benchmark 2: rev-list: print many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):     161.6 ms =C2=B1   1.6 ms    [User: 78.1 =
ms, System: 83.0 ms]
    Range (min =E2=80=A6 max):   158.4 ms =E2=80=A6 172.3 ms    500 runs

  Summary
    rev-list: print many refs (HEAD) ran
      1.05 =C2=B1 0.01 times faster than rev-list: print many refs (HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 32 ++++++++++++++------------------
 reftable/block.h |  2 --
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index c6c4a68ea1..3e87460cba 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -365,16 +365,6 @@ static int restart_needle_less(size_t idx, void *_args)
 	return args->needle.len < suffix_len;
 }
=20
-void block_iter_copy_from(struct block_iter *dest, const struct block_iter=
 *src)
-{
-	dest->block =3D src->block;
-	dest->block_len =3D src->block_len;
-	dest->hash_size =3D src->hash_size;
-	dest->next_off =3D src->next_off;
-	strbuf_reset(&dest->last_key);
-	strbuf_addbuf(&dest->last_key, &src->last_key);
-}
-
 int block_iter_next(struct block_iter *it, struct reftable_record *rec)
 {
 	struct string_view in =3D {
@@ -427,7 +417,6 @@ int block_iter_seek_key(struct block_iter *it, const st=
ruct block_reader *br,
 		.needle =3D *want,
 		.reader =3D br,
 	};
-	struct block_iter next =3D BLOCK_ITER_INIT;
 	struct reftable_record rec;
 	int err =3D 0;
 	size_t i;
@@ -486,11 +475,13 @@ int block_iter_seek_key(struct block_iter *it, const =
struct block_reader *br,
 	 * far and then back up.
 	 */
 	while (1) {
-		block_iter_copy_from(&next, it);
-		err =3D block_iter_next(&next, &rec);
+		size_t prev_off =3D it->next_off;
+
+		err =3D block_iter_next(it, &rec);
 		if (err < 0)
 			goto done;
 		if (err > 0) {
+			it->next_off =3D prev_off;
 			err =3D 0;
 			goto done;
 		}
@@ -501,18 +492,23 @@ int block_iter_seek_key(struct block_iter *it, const =
struct block_reader *br,
 		 * record does not exist in the block and can thus abort early.
 		 * In case it is equal to the sought-after key we have found
 		 * the desired record.
+		 *
+		 * Note that we store the next record's key record directly in
+		 * `last_key` without restoring the key of the preceding record
+		 * in case we need to go one record back. This is safe to do as
+		 * `block_iter_next()` would return the ref whose key is equal
+		 * to `last_key` now, and naturally all keys share a prefix
+		 * with themselves.
 		 */
 		reftable_record_key(&rec, &it->last_key);
-		if (strbuf_cmp(&it->last_key, want) >=3D 0)
+		if (strbuf_cmp(&it->last_key, want) >=3D 0) {
+			it->next_off =3D prev_off;
 			goto done;
-
-		block_iter_copy_from(it, &next);
+		}
 	}
=20
 done:
-	block_iter_close(&next);
 	reftable_record_release(&rec);
-
 	return err;
 }
=20
diff --git a/reftable/block.h b/reftable/block.h
index c1bd1892cb..ea4384a7e2 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -121,8 +121,6 @@ void block_iter_seek_start(struct block_iter *it, const=
 struct block_reader *br)
 int block_iter_seek_key(struct block_iter *it, const struct block_reader *=
br,
 			struct strbuf *want);
=20
-void block_iter_copy_from(struct block_iter *dest, const struct block_iter=
 *src);
-
 /* return < 0 for error, 0 for OK, > 0 for EOF. */
 int block_iter_next(struct block_iter *it, struct reftable_record *rec);
=20
--=20
2.44.GIT


--CV2eYUrIm+6KYGpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4EMACgkQVbJhu7ck
PpQvdA//Y1L9TZOsX5sYAKJu0GrCpKRW6N6TLE848gxT14O5isCLVp0VlHAKq9h5
eUNoAMQnE9AYxhAtp1RRCKI86hM5YUjWL/+xViDNBHBHVGD3PMDLVBt6EBsl+6nh
25ammJiIc0SJSfPsyX/1Y+3sJx92eca1FH736m+H8jvlAbaNYYX+o1bhOupBNC2z
G03b+RBMzSGD0vgiLsPN9ry8Sh4Nl9v+bVVqFbF1MUcTEm09GP5pWGjzpMME7SAH
dFBeY29lAO1i2Upxo4+LPhtqmURzjuC5MsdjsSy7/Vu41r9cLSrxX4/AV4TL5xeS
RdRN3UgAF4wKaTF/ECBwRVikd4xFTPapBTVsNHe+gKVhY1ujPWVPoU7tS5K/fIr4
66G9NdP2mA2GmaUq3sKMp9cU2JC2I2WMR7asthybY9Fcvvh2gQMPX9mu8FfIlr8g
x0AXoTwd8bn6J1WcrvgkFZqwUhadpp/y+7rn/WWho/7GWevitNReiAsmLy4OXNDL
VdXHnIQ0brFKDnOua1opgG0GBZMb22xmsqC/OfpfTpzhFamyjCk+yb2fdQVVt2tD
9uCTXBaueunk3XwRPHxKTZ4iBMZm1R9Pl7uERCJtkaRBh+pjcc4I67zpQwOYbexm
exlV62IaMpIe2HbYJP+MVEgyEaHEMgR+lfFb1ypQYMnsjveQXKU=
=1ABk
-----END PGP SIGNATURE-----

--CV2eYUrIm+6KYGpK--

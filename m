Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BC145351
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046416; cv=none; b=TE2EwrMbN+Nkn600DZwNcTeHZtTildxkM9seBPp1Ru2tFXO+Rd7wJxDp7G+QNrDp99+0hIeG2x5P3OwGoLspG1SyW6PtQKhjHaDrX9Vm7U77IhlckTCEe63vgsTv1vvTI6NB01cThAmGazBUqyUPGROBBlKhnJARdmsUCyx7M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046416; c=relaxed/simple;
	bh=O0i7cl+pVMocHj5q+texKRkpgE9VD3MP7b2knz32f8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpipxFwBdGnpxaf2rVJQbG9LEsDvmiXKw1OxyYh2i9Vj0yXMJPqzXVfTKpT/n9cXwMrTY1meE3Jxcn/iBeW4lMp46IXFEraqBuXzMoIeKgXFkMYwfPf4mvthz3k1rB7K2EkAdwIX+Wlv87lyn3h53DAuVK9mjaW5UpBBK6o/T0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ph1G8CUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RR8ZFfz1; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ph1G8CUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RR8ZFfz1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E69543200922;
	Tue, 27 Feb 2024 10:06:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 10:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046413; x=1709132813; bh=8XzelIHsNo
	RAKSB3XmYer3QVUYsgA1uiTOpSAxTXoPw=; b=ph1G8CUWvB29EAbS2QUoKqZrCo
	6GiO+2hOLP93GRqCUN6+o7xCLj9P+xJ8OKEMjWUyHK3dDw30rba78VVTl5u8gXUN
	v6GKl48IzGbX3lJrugt4UVChjFH0k+V3XcZTilsdR3HEfhJem9aIvoWNv9ZJvhJy
	LmMuc7CO0wEy62gAPa+Jrapuj2EBI5zRNKUXyJiDBsXMGAARU4XXBazcjxdQfvqS
	Q+Q+JEUs/okOk5t4l1CuvH+A632A5WuYRh+65+kJm9j7upkVdDjs/Ljgec3dffZ3
	OKrH3iI/5F9uwmiT/tyhnEjqyMfHdKFQxqYHaEuwZAVxMwCjghr2GAIL/XIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046413; x=1709132813; bh=8XzelIHsNoRAKSB3XmYer3QVUYsg
	A1uiTOpSAxTXoPw=; b=RR8ZFfz1u732fiWzJTM0npW3tW+/eP8V+CbKhQQfR1He
	/QK1Dzo55RZ68LOpbWF5uSRLM8kEWsU/J/9oumJHdUvwM2Qc4VRRbz0B7gJrmo2o
	6TaSk7NIDxm2k7yh/yCpLZuU3usEWw7gJLG2BKLGcU0wcAGnWA2NeD+ocqaQ3/uT
	C8bN49vSaH/VdZ7tjbTzDli22/l6nCAztH95u2nqLFBlz+Tdm5BLsPGKkbvPVdVT
	HlbONmo1aYqhU1pqj3dK3FMLEqW3MBewRmth8w9v/CvKGplHpkQdZnS99LVt7Fe6
	DaaB2lcVDZzsmntwQ7/VFk03EZPwZftFHSDJ8LzygQ==
X-ME-Sender: <xms:jfrdZXXI3Gt3q0hMw3Gv3r2cHXifyITFAhgtomc41yImo0WX7T61BQ>
    <xme:jfrdZfmT7NKtW-imabKc3Q70FNIECFRdL4K_-z91ens-tZ3Cua53FUxBMxEbRJz1F
    ZJEJK4sguLutFsCkw>
X-ME-Received: <xmr:jfrdZTYPmaoKKQmscwUTOmROQWg_mieuXL-lsDHiSvoLjTmayQ7-S7rcwbNlhh0eXBfDIo7hpBPG15ULG36tDLxWt2g5GeO_Wlue_BjOnShH60mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jfrdZSVqgUUrKPHzfg4WyGRUPx-_TYsDoJIOTYj3W4z5G-VIaZsWcQ>
    <xmx:jfrdZRk01wltsKSF81IBpqfFeiaf7rC3fgy6Bb2QFUcSQo3N9XsMMw>
    <xmx:jfrdZfdAYr8Jx1vn3SrQ97-xaA4h-xrEyU9BJC4Q0NxebJIsXN9lyw>
    <xmx:jfrdZRu1S8QFUHkggiHxkDwRK3dl8c3_zqu-nDOqYrc9PY5JiFhYzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a950e687 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:35 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/13] reftable/record: reuse refname when decoding
Message-ID: <15a8cbf6782653f4d57ef351e2d7894835813d88.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ft6d/a41XDGf43gC"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--ft6d/a41XDGf43gC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When decoding a reftable record we will first release the user-provided
record and then decode the new record into it. This is quite inefficient
as we basically need to reallocate at least the refname every time.

Refactor the function to start tracking the refname capacity. Like this,
we can stow away the refname, release, restore and then grow the refname
to the required number of bytes via `REFTABLE_ALLOC_GROW()`.

This refactoring is safe to do because all functions that assigning to
the refname will first call `release_reftable_record()`, which will zero
out the complete record after releasing memory.

This change results in a nice speedup when iterating over 1 million
refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)

    Time (mean =C2=B1 =CF=83):     124.0 ms =C2=B1   3.9 ms    [User: 121.1=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   120.4 ms =E2=80=A6 152.7 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     114.4 ms =C2=B1   3.7 ms    [User: 111.5=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   111.0 ms =E2=80=A6 152.1 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.08 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Furthermore, with this change we now perform a mostly constant number of
allocations when iterating. Before this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 1,006,620 allocs, 1,006,495 frees, 25,398,363 bytes a=
llocated

After this change:

  HEAP SUMMARY:
      in use at exit: 13,603 bytes in 125 blocks
    total heap usage: 6,623 allocs, 6,498 frees, 509,592 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 16 ++++++++++++----
 reftable/reftable-record.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index d6bb42e887..e800cfef00 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -368,16 +368,24 @@ static int reftable_ref_record_decode(void *rec, stru=
ct strbuf key,
 	struct reftable_ref_record *r =3D rec;
 	struct string_view start =3D in;
 	uint64_t update_index =3D 0;
-	int n =3D get_var_int(&update_index, &in);
+	const char *refname =3D NULL;
+	size_t refname_cap =3D 0;
+	int n;
+
+	assert(hash_size > 0);
+
+	n =3D get_var_int(&update_index, &in);
 	if (n < 0)
 		return n;
 	string_view_consume(&in, n);
=20
+	SWAP(refname, r->refname);
+	SWAP(refname_cap, r->refname_cap);
 	reftable_ref_record_release(r);
+	SWAP(refname, r->refname);
+	SWAP(refname_cap, r->refname_cap);
=20
-	assert(hash_size > 0);
-
-	r->refname =3D reftable_malloc(key.len + 1);
+	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
 	memcpy(r->refname, key.buf, key.len);
 	r->refname[key.len] =3D 0;
=20
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index bb6e99acd3..e657001d42 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -22,6 +22,7 @@ license that can be found in the LICENSE file or at
 /* reftable_ref_record holds a ref database entry target_value */
 struct reftable_ref_record {
 	char *refname; /* Name of the ref, malloced. */
+	size_t refname_cap;
 	uint64_t update_index; /* Logical timestamp at which this value is
 				* written */
=20
--=20
2.44.0


--ft6d/a41XDGf43gC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+ooACgkQVbJhu7ck
PpTkjhAAk0DoyKD/jyDDpOFAf1dww5n78LTtK9FfPvAXuiqdFxSGa+gGR/2+7b7a
YvG4okqWCR+oKVRQgWKnRJR9JvgDY8z8JQqw5xHnNpPK+fsqB96mxU8o4lqopW6I
8Hi5xGm4ceHDp9ADvy72iU93N3nbfGxPXEYTA95Oc7VDPLeNVpmcyHqDiqJHDO7A
lkhx55skVCQv2HnjaFgOQNtKieEi1CHmemWoACXYenS8/mbBOcet6+vznd+qZ/O9
6bPErv9QQj/0ikvhMePVQfeYX33Zmkts6Lqv40qRzCttCKczUzlp8E/wy2VcJMBe
/jNq/BD5ozeeP9hCZP183DpG1epksK69JeudsQ5unQqXIUnBBk69aPDT5jkVF4DV
eXkiNWWiD2t5uAZSp8BXdHkIo61+1/hmXN2b396lwedJsHKM7vEqgE0A8PtW8JwN
CG4uR9NN/TgEGHR6j27AANMXSOn6Qan47oIMe5rRgZzmVDrVVwQHl04LQiDv82Vz
fajDtRPv/kPnClQoneKZSsN50nxk+RXxEwuvUQdDUwelLmY9LBqFXrzI7wonlsEy
xrp8wdnfobnMYBHl9cKixO2CNUobrZa0Qca8FlNIW5oDtaQD91Xx5OcH8An+1XIl
8DmIGidUzCNZCDRZkBgJImpu4TVPJ4osf6ZFJHk/j3mh9xfpUkA=
=1s2Z
-----END PGP SIGNATURE-----

--ft6d/a41XDGf43gC--

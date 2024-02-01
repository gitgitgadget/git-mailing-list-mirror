Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF815B11A
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783104; cv=none; b=os5XDpglDKE+tSuGuuklzsz80t6K8TwzBD7eXmkaNuWRkJukOEKId0QEZzN+IQQukvRQClLQvzmewKn2Jhlm5/6KD66cFvXlRZ4qq7VU5rs++MBalzpMF9TEEc8hwNZxi0IDvWgWbM91KgPA1dwvZt1tp2r0YptZrmfWikaiGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783104; c=relaxed/simple;
	bh=t1lhvWCIhLgBM0o9XXQ6fD4AOsIEGH8RJVfbe++jovM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcvmywLblR+3f8LAo+kd8wB0RRo6ATHk/wj04NcKSfLGcyn7QcOB8W/aMLNQtGy34jUX5MOpEEZBATmhnL6KnWmjF2XFvfYU2rJCz36UTr4m1VKM3R//MZS5WZEoK4UzDZ00uFHCG0Jq9XzsPBx6rmFC0K29wml4yCKAipIrlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MVQy2UG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JyRpzqqf; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MVQy2UG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JyRpzqqf"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 64D373200AD5
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 05:25:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 05:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706783100; x=1706869500; bh=Lhv61fwiKG
	9qJgUQhy1YufZexrQNBvebUo+okskXm1I=; b=MVQy2UG1/DFcCuHWXcayOb5hTI
	TnYOH/zHbAHTfAm0JPZnYfhrRFDFJ4HdNlJiozZ+IxRa0QuAZVwT8uSpWnsk/9ST
	YTLzKDlLnP+s9lI/prrgFaclGy1abn6VZgItO0MTePKa5wH82a42LwfT6YXsKlKz
	DerRxcqwkp7bAKflbaUTQmkBz3IxmSMmvGbShXeeOw2Phrelq0wxGcYf9Kyz6EF0
	MJlU9nl1APB5zk43PxXxapjvCEbjN9TtBEC5PliRPUh48eIswJ8EDweEMIbsVYBb
	84wQKhUnsVZCpjctLr0zzenTWmmjyxkbUgycSx9RYcYSWGZSA8CW8qXWTJGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706783100; x=1706869500; bh=Lhv61fwiKG9qJgUQhy1YufZexrQN
	BvebUo+okskXm1I=; b=JyRpzqqfCfGFdiKZiLb2XKz4+w4wYpuODQ/dC/BSxSdp
	rOT9UKpdmlMoqgYNcfTO0P3GcFfLMSz8ZdTN6ADjI3IwXX/VLkpQe9mo9aDl2LIi
	L8cWWDWB4JDuiY5gMXMSJG+t1LGB3EKGWAKVVH8ZawxUBtbfbe7jIuAiiF8g4R8J
	CteOweQielVCfy44uUPs7k/k84XoMpVayngEZJFkASgBwhdes3xR/negnI/BQ7UP
	j53lzCkJI8utAhdWnAlfzwiq1uSPTm2jt4owaFIgOchn+aX6ltS0U4xP8VRYw2fi
	KRaie4e8erEyhnUEMqTxANCYWFeSBEIdRAWtXtaYKg==
X-ME-Sender: <xms:fHG7Zd_oqJPunMzuSp_ErkSJr2DybMQKlYy0CsM_kRrFn3_6LsEgrg>
    <xme:fHG7ZRudrffD_ize3bgXxU95lEg-rZ7y8E8XN3JXcb78-T8i6cTtoiOCP9Ntry6Go
    L_vZSu7kircc-9pCw>
X-ME-Received: <xmr:fHG7ZbB-VqbUDA7_svgHBZ0KivmEEJneL0q8NkkTjgcErJwC_QvnOgHpG2Kd83ojx8DmNQqIXRojQ0tNYat5BIUZJmPNFGdLN7RfKMBLnVYpyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fHG7ZRd9yTfmECocLR16x68dT-nfiejKIJrbQWsQzlMnacL4Yig2Ng>
    <xmx:fHG7ZSOxpEbxmJwvRSxPwBEG2LFC7pFbqXjNJXvSWsuiW7uIY1UQyg>
    <xmx:fHG7ZTl6bzJQWeoyNUNp0KhXw2N-kPAXRP-V11I42OMQM35zoF_VOQ>
    <xmx:fHG7ZcXBkvGscBOz_0cOZ_A7RB-nbb2ML0JYjjNE6BxwneKkGC25_A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Feb 2024 05:24:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1270aebe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Feb 2024 10:21:37 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:24:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] reftable/record: introduce function to compare records
 by key
Message-ID: <fadabec696f75ae0fa25bcbf87012fcc4768acaa.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lSCrKpl2q5WOdglL"
Content-Disposition: inline
In-Reply-To: <cover.1706782841.git.ps@pks.im>


--lSCrKpl2q5WOdglL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In some places we need to sort reftable records by their keys to
determine their ordering. This is done by first formatting the keys into
a `struct strbuf` and then using `strbuf_cmp()` to compare them. This
logic is needlessly roundabout and can end up costing quite a bit fo CPU
cycles, both due to the allocation and formatting logic.

Introduce a new `reftable_record_cmp()` function that knows to compare
two records with each other without requiring allocations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++-
 reftable/record.h |  7 ++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/reftable/record.c b/reftable/record.c
index 5c3fbb7b2a..f1b6a5eac9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -430,7 +430,6 @@ static int reftable_ref_record_is_deletion_void(const v=
oid *p)
 		(const struct reftable_ref_record *)p);
 }
=20
-
 static int reftable_ref_record_equal_void(const void *a,
 					  const void *b, int hash_size)
 {
@@ -439,6 +438,13 @@ static int reftable_ref_record_equal_void(const void *=
a,
 	return reftable_ref_record_equal(ra, rb, hash_size);
 }
=20
+static int reftable_ref_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_ref_record *a =3D _a;
+	const struct reftable_ref_record *b =3D _b;
+	return strcmp(a->refname, b->refname);
+}
+
 static void reftable_ref_record_print_void(const void *rec,
 					   int hash_size)
 {
@@ -455,6 +461,7 @@ static struct reftable_record_vtable reftable_ref_recor=
d_vtable =3D {
 	.release =3D &reftable_ref_record_release_void,
 	.is_deletion =3D &reftable_ref_record_is_deletion_void,
 	.equal =3D &reftable_ref_record_equal_void,
+	.cmp =3D &reftable_ref_record_cmp_void,
 	.print =3D &reftable_ref_record_print_void,
 };
=20
@@ -625,6 +632,25 @@ static int reftable_obj_record_equal_void(const void *=
a, const void *b, int hash
 	return 1;
 }
=20
+static int reftable_obj_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_obj_record *a =3D _a;
+	const struct reftable_obj_record *b =3D _b;
+	int cmp;
+
+	cmp =3D memcmp(a->hash_prefix, b->hash_prefix,
+		     a->hash_prefix_len > b->hash_prefix_len ?
+		     a->hash_prefix_len : b->hash_prefix_len);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * When the prefix is the same then the object record that is longer is
+	 * considered to be bigger.
+	 */
+	return a->hash_prefix_len - b->hash_prefix_len;
+}
+
 static struct reftable_record_vtable reftable_obj_record_vtable =3D {
 	.key =3D &reftable_obj_record_key,
 	.type =3D BLOCK_TYPE_OBJ,
@@ -635,6 +661,7 @@ static struct reftable_record_vtable reftable_obj_recor=
d_vtable =3D {
 	.release =3D &reftable_obj_record_release,
 	.is_deletion =3D &not_a_deletion,
 	.equal =3D &reftable_obj_record_equal_void,
+	.cmp =3D &reftable_obj_record_cmp_void,
 	.print =3D &reftable_obj_record_print,
 };
=20
@@ -953,6 +980,22 @@ static int reftable_log_record_equal_void(const void *=
a,
 					 hash_size);
 }
=20
+static int reftable_log_record_cmp_void(const void *_a, const void *_b)
+{
+	const struct reftable_log_record *a =3D _a;
+	const struct reftable_log_record *b =3D _b;
+	int cmp =3D strcmp(a->refname, b->refname);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * Note that the comparison here is reversed. This is because the
+	 * update index is reversed when comparing keys. For reference, see how
+	 * we handle this in reftable_log_record_key()`.
+	 */
+	return b->update_index - a->update_index;
+}
+
 int reftable_log_record_equal(const struct reftable_log_record *a,
 			      const struct reftable_log_record *b, int hash_size)
 {
@@ -1002,6 +1045,7 @@ static struct reftable_record_vtable reftable_log_rec=
ord_vtable =3D {
 	.release =3D &reftable_log_record_release_void,
 	.is_deletion =3D &reftable_log_record_is_deletion_void,
 	.equal =3D &reftable_log_record_equal_void,
+	.cmp =3D &reftable_log_record_cmp_void,
 	.print =3D &reftable_log_record_print_void,
 };
=20
@@ -1077,6 +1121,13 @@ static int reftable_index_record_equal(const void *a=
, const void *b, int hash_si
 	return ia->offset =3D=3D ib->offset && !strbuf_cmp(&ia->last_key, &ib->la=
st_key);
 }
=20
+static int reftable_index_record_cmp(const void *_a, const void *_b)
+{
+	const struct reftable_index_record *a =3D _a;
+	const struct reftable_index_record *b =3D _b;
+	return strbuf_cmp(&a->last_key, &b->last_key);
+}
+
 static void reftable_index_record_print(const void *rec, int hash_size)
 {
 	const struct reftable_index_record *idx =3D rec;
@@ -1094,6 +1145,7 @@ static struct reftable_record_vtable reftable_index_r=
ecord_vtable =3D {
 	.release =3D &reftable_index_record_release,
 	.is_deletion =3D &not_a_deletion,
 	.equal =3D &reftable_index_record_equal,
+	.cmp =3D &reftable_index_record_cmp,
 	.print =3D &reftable_index_record_print,
 };
=20
@@ -1147,6 +1199,14 @@ int reftable_record_is_deletion(struct reftable_reco=
rd *rec)
 		reftable_record_data(rec));
 }
=20
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record =
*b)
+{
+	if (a->type !=3D b->type)
+		BUG("cannot compare reftable records of different type");
+	return reftable_record_vtable(a)->cmp(
+		reftable_record_data(a), reftable_record_data(b));
+}
+
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size)
 {
 	if (a->type !=3D b->type)
diff --git a/reftable/record.h b/reftable/record.h
index fd80cd451d..0d96fbfd1b 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -62,6 +62,12 @@ struct reftable_record_vtable {
 	/* Are two records equal? This assumes they have the same type. Returns 0=
 for non-equal. */
 	int (*equal)(const void *a, const void *b, int hash_size);
=20
+	/*
+	 * Compare keys of two records with each other. The records must have
+	 * the same type.
+	 */
+	int (*cmp)(const void *a, const void *b);
+
 	/* Print on stdout, for debugging. */
 	void (*print)(const void *rec, int hash_size);
 };
@@ -114,6 +120,7 @@ struct reftable_record {
 };
=20
 /* see struct record_vtable */
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record =
*b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_recor=
d *b, int hash_size);
 void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
--=20
2.43.GIT


--lSCrKpl2q5WOdglL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7cXkACgkQVbJhu7ck
PpST7w//UWR+vvPfIaZq5qH3bZ7Z9pxScwF4PcS3AMoZEqB5vKKNWRzf0nU9Mh5D
2cXp1DBX2DzB773lxCdqyXXMXHAT16qXfbeO2pQmd4O3zkxH4imyRvCK4rVGZAI7
seWe/hwZU0HLslRxrh1Au7ycZcQB6DC7Plh7mzqIJkZgFHjBwMWbfB6w98AMZ6Sn
KPw7SREw2eml1rpCMXWW68GJVhyYI54PXN05EpMt0JOI3/EZoDKro+4EalQTE/qi
+t/KbpmR48XkJe8jcrc/1j7yiNAENR5rjTTh5yQD5pMLuhkpUjCbn8pFcXF647+b
PNMBzf3ZJzsVhXl52NcSDauLe93hhFyq7pfIrhqiER3n3DACx7W0A8khPTdJrGzG
zcSOa0BdK2IF8IVoMxm4RPnKLsNAqcOKCr+nbe7cSfNAvuRYr3H3CSoL3Dv2o6aQ
Meea8g59WtFIQmzQVZNAjxVOHo2lREct1Gp8bYv9Ip1dRZ/QuvTapzseeBmPDNwX
DufSJYWaivux0Ifc2kKSnUk6ZC19nREYZjnFUG43xmPYHUiDOujlcJw0/TFvcos7
63CPV6JPGy8sg5qBoPGs6X6belaBP8NzhJqHnjNvoCxda/qXk+bzESxUoUS9eF3Q
uKkl1O9kdfC3G0G/6FWDCTN1jD9C9QNbIhvvf7fU9D/AZ0n8j/E=
=Wsgh
-----END PGP SIGNATURE-----

--lSCrKpl2q5WOdglL--

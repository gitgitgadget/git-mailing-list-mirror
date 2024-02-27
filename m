Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18840145B0D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046393; cv=none; b=pvleiBc0QYf86K1n4UosDTg2LWKOVqh+A961sXCL8eQZbZ0VcXn2HY9NdEnflXZTT4CmbnJZqX6W/juKmkYaExHQuwBDmskgivzG6RBid4TBHpPeCSacXtaagiXvaskiavd+jzYVMBnHoISTNuQvtMuePHbhWrutdEhwZWzy+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046393; c=relaxed/simple;
	bh=wJoBN961lcxswmi/ceQBsLpu4GFYvh0D4mtPYOMo98o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL7PD4ImAOA++YS4hfQB1QTIKSjcoijF3qO+x1WcZrZN9U5ZCXkRLuz1mqHQV1GVKA/PFBTKRASy53OhKvAsIJFLWHa8rWoHYo1awvhDjULFLXgVqV8QpqGebmYIkysxNWdHk+21VX7VXPddGVH3+ZDwO6aG/5Cf6FoZr2cix54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=awzQ88gm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRNyZlKF; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="awzQ88gm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRNyZlKF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1326618000B4;
	Tue, 27 Feb 2024 10:06:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 10:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046389; x=1709132789; bh=UkXWnT48tL
	JPGrkW3f2G9afzcV3NwBACLd8XL1v07fU=; b=awzQ88gmikUx72LEkrQoXaqbF0
	OdPdKeL+ybe77hY6AVTSwIrQuCQG9/GFvPGE1vQr2RSaJYPBRwZKdCTY5b7MB0YS
	NiSAbYoePkY8rM1nGfFehTaaHQSN1zeLvaZs6JJQv3mLc8zq4NNGCpgyLLBX8BYy
	NsCvIK3HksgK2AfTlVRsX2NcQzRhwaRWajm2cu1twBs0tMPvyN2HQovmQ/fVrJSD
	NiRoksj1Q3IZQjlPrPcZr0+DxzgITEbECXYUicbFMrqG9FG8Z/djxr8CqPkxLxhk
	q6+YuKH0UZ4/L8NP8RusmfefhVbEkvOzlVpEfev7s52lOovXWt5nbkr6jXTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046389; x=1709132789; bh=UkXWnT48tLJPGrkW3f2G9afzcV3N
	wBACLd8XL1v07fU=; b=XRNyZlKFqaiN13k/iq/J0ydiP40qkcmQA15/0BUXuzpX
	/i2TMKvQKxiHsifohMPA9vXU1E9IU1O6qotd8OrI2QlFosSMyEzkZXHVU/dowDri
	/PbrLuCqLotY0KIgQ9MK7j6L4LIx6NX36/CCS/SosH5U2a7yTZS5vAQVMvoxRhZp
	KGb38/T2Db402q4l/v5kg6NchotRFxGnwoxKI3VWUw/8qdkWmOPAhtmy9ICa7G7L
	DQ17OrP9h3ISTv0c6Br6mSY0RdPxuVpC/cdgT7QV9sAQlDYKMGH/Kbs83HHq4HOi
	c/tHIvklW7uu71DdC0FJLb+vvRf6deEs8PxRJNtcNA==
X-ME-Sender: <xms:dfrdZQYCYCRM-9fdHW_a9rmnue0C3lDCPwARewH-1BRo0wKnbsCGQw>
    <xme:dfrdZbZcMBj0vLclhn9rTNAjMJvHuQXwQT5o54QJM2zabnlyryaKroZljTjyP7naB
    lj1e_zD4MpbepgVpA>
X-ME-Received: <xmr:dfrdZa9VCwNUSkxDGi4KlACmZUqA_9qWxgyy7jKNsUb0pkcKs5mJ3Af9LscjwDXidxvjXIvG1Dc62ix6ZfDjsJDYterNAapDz1HhfDxmPQpSiPPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:dfrdZaohBn8-kglA1hTQPQD9LOoQr0Alxgq4mup5cPbEewrGlxFYtg>
    <xmx:dfrdZbrV1khYPm2IvDvzdMiOJDC3yjbSACj8NrIR2rQu8ATphFPiUg>
    <xmx:dfrdZYS43NsjDji9eAhABhqC4WvdRmGaF3DMXnb7fVMcZyu9w-XY7A>
    <xmx:dfrdZS0gHfnffPZVGxJUMFgOrQgvueDQJzw8zk2wz5c4npvLnOoZCnildLg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 201f2797 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/13] reftable/merged: advance subiter on subsequent
 iteration
Message-ID: <0e327e5fe360560b4de8c5098879581bbde2baa9.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54ootfkn6oXQnjNJ"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--54ootfkn6oXQnjNJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When advancing the merged iterator, we pop the topmost entry from its
priority queue and then advance the sub-iterator that the entry belongs
to, adding the result as a new entry. This is quite sensible in the case
where the merged iterator is used to actually iterate through records.
But the merged iterator is also used when we look up a single record,
only, so advancing the sub-iterator is wasted effort because we would
never even look at the result.

Instead of immediately advancing the sub-iterator, we can also defer
this to the next iteration of the merged iterator by storing the
intent-to-advance. This results in a small speedup when reading many
records. The following benchmark creates 10000 refs, which will also end
up with many ref lookups:

    Benchmark 1: update-ref: create many refs (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     337.2 ms =C2=B1   7.3 ms    [User: 200=
=2E1 ms, System: 136.9 ms]
      Range (min =E2=80=A6 max):   329.3 ms =E2=80=A6 373.2 ms    100 runs

    Benchmark 2: update-ref: create many refs (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     332.5 ms =C2=B1   5.9 ms    [User: 197=
=2E2 ms, System: 135.1 ms]
      Range (min =E2=80=A6 max):   327.6 ms =E2=80=A6 359.8 ms    100 runs

    Summary
      update-ref: create many refs (revision =3D HEAD) ran
        1.01 =C2=B1 0.03 times faster than update-ref: create many refs (re=
vision =3D HEAD~)

While this speedup alone isn't really worth it, this refactoring will
also allow two additional optimizations in subsequent patches. First, it
will allow us to special-case when there is only a single sub-iter left
to circumvent the priority queue altogether. And second, it makes it
easier to avoid copying records to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 12ebd732e8..9b1ccfff00 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -19,11 +19,12 @@ license that can be found in the LICENSE file or at
=20
 struct merged_iter {
 	struct reftable_iterator *stack;
+	struct merged_iter_pqueue pq;
 	uint32_t hash_id;
 	size_t stack_len;
 	uint8_t typ;
 	int suppress_deletions;
-	struct merged_iter_pqueue pq;
+	ssize_t advance_index;
 };
=20
 static int merged_iter_init(struct merged_iter *mi)
@@ -96,13 +97,17 @@ static int merged_iter_next_entry(struct merged_iter *m=
i,
 	struct pq_entry entry =3D { 0 };
 	int err =3D 0;
=20
+	if (mi->advance_index >=3D 0) {
+		err =3D merged_iter_advance_subiter(mi, mi->advance_index);
+		if (err < 0)
+			return err;
+		mi->advance_index =3D -1;
+	}
+
 	if (merged_iter_pqueue_is_empty(mi->pq))
 		return 1;
=20
 	entry =3D merged_iter_pqueue_remove(&mi->pq);
-	err =3D merged_iter_advance_subiter(mi, entry.index);
-	if (err < 0)
-		return err;
=20
 	/*
 	  One can also use reftable as datacenter-local storage, where the ref
@@ -116,14 +121,6 @@ static int merged_iter_next_entry(struct merged_iter *=
mi,
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
 		int cmp;
=20
-		/*
-		 * When the next entry comes from the same queue as the current
-		 * entry then it must by definition be larger. This avoids a
-		 * comparison in the most common case.
-		 */
-		if (top.index =3D=3D entry.index)
-			break;
-
 		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
 		if (cmp > 0)
 			break;
@@ -137,6 +134,7 @@ static int merged_iter_next_entry(struct merged_iter *m=
i,
=20
 	reftable_record_release(rec);
 	*rec =3D entry.rec;
+	mi->advance_index =3D entry.index;
=20
 done:
 	if (err)
@@ -160,9 +158,8 @@ static int merged_iter_next(struct merged_iter *mi, str=
uct reftable_record *rec)
 static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
 	struct merged_iter *mi =3D p;
-	if (merged_iter_pqueue_is_empty(mi->pq))
+	if (merged_iter_pqueue_is_empty(mi->pq) && mi->advance_index < 0)
 		return 1;
-
 	return merged_iter_next(mi, rec);
 }
=20
@@ -255,6 +252,7 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
+		.advance_index =3D -1,
 	};
 	struct merged_iter *p;
 	int err;
--=20
2.44.0


--54ootfkn6oXQnjNJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+nEACgkQVbJhu7ck
PpQe7A/+J5CSszH1+In0brakhJqJPqV55yg5bLLQgdi/Y4j2faZOLShf3I1EL/sD
7svpfJT+GelPgFAfmg3SN7XBg4lIYZ4yDJ6o9FpEHqZFnkyZe/ln6D9q2LsabIrS
gL+g0OQntDTEdaQi9AHHDtgsc9XjRh9F6T4zTjqbAd0oY0r5e85OXb3SxHVEwRZh
dLemiCtkF6GXjwTWeFXba2ycHRqxzBd4yUsqsht5p1HWQVTa0Ys/ZQbnJn7fPXH8
7ILgPmsdZhQXX9EfRUczRiU0CXBCL3Mcy47caK7plwwJBKxSyiVl+arAXLoKr0Ip
SQN0rW5WWNOM9Qhd3Vd28XmzV44uGoKqp8/pBsAy8d0ERl52A4o57km+QEP67ync
VeKJ06pTuIBYVArsG7w5ROMoMKN6XUtCruFq0NkiFGFnD85gDbT4IuYIPIMsyNun
IjzAms4apfsmH9IoMBaLT316HF6lxpCB3hZNQxblkjMTfmtjCoKAdLnyBvmniORR
aPy3tqtzoY+dI8PoUxoSXccxyok9mZR8nyCW4bPYR7H40CQJXdDsBx9E1MRF4q9Z
SYDmEPY9kz+Jtn44/kdf6gSObJHTDS+0LPsxXn9zvyMPRlOCa3mVwAJUAHxQMhBe
89VYj146E9SEKUgRaw46IY1Q4MdCXvh8dovLSpfUPQJPRbDoqso=
=JhNF
-----END PGP SIGNATURE-----

--54ootfkn6oXQnjNJ--

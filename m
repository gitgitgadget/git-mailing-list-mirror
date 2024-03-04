Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256539AC2
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549341; cv=none; b=CMyw2owWJxAsIXgn26iOEhZb1tw6yPXfaiIsrzzLPPXafgQkctBtL2yr0hwUgOuREmMw976tKiBS2KoB19CEUUMiWH2nH3xN+4lNetr/NaoCeOPaWyYlZqPh1+k+q+Qit3if6lRLuql766bu3oeKfbeFnZieHgVO9jOSkELzqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549341; c=relaxed/simple;
	bh=jP8JkQNR4YkbyO6TJo3gyPhWk9XQsZoTZ1qKFnRE6As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9dROfAAHJN10ND7o9g22Cqxc7ViM/InMxA8A9hPs+nxDJoHnzwK84u9xYYOHdGmuWJWMCrZR/TFrHvdntRFw3U9GIxFPN5UJ94Gu7gAozARGTHTNkFavW8FJo2yXqP8Bn4Dd5l5Rn0WdSD2MTkSrVqHK60YXviHD68BcZf2LgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mo8Px4+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o1vHwsy0; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mo8Px4+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o1vHwsy0"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id AFEB4180008C;
	Mon,  4 Mar 2024 05:48:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549338; x=1709635738; bh=yn/nlBZHVO
	lO1ur8xKct+8KJMhh8mqnaisnnnNSR7v8=; b=mo8Px4+xqdujErPoM8Lg4EtHtp
	RGPiQYoPAWGOuGmDzNb8DK9k8TYckHZsVrY29u28jQOVGS3ozWo35WED5u+0d0g/
	hky8HoXPby+ISNi3djClcnw55O49WoaeEZ4aofkjgibRGRNGH2MnrOZA8r6AOX5i
	EkfzOjcU3Wq9UIq18bPHuqVqXpCfiBD+A6m2aLkx5gSPltZ2QJ582DfzoyFYfq3w
	cBCTUHyUem02YY3SsRDCPjzOHxFAWW7nTDMjMvSCjwtj4aIOTN/XQiwG192OHM26
	/b4zn341lOlRDTAxkIHDiRDBfvG1Dx2CpKQVGvc6/8TyGec6z0JWqbLNd9/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549338; x=1709635738; bh=yn/nlBZHVOlO1ur8xKct+8KJMhh8
	mqnaisnnnNSR7v8=; b=o1vHwsy0tyAItMDDvaUspXVET/AoGBE/C8CsvnkkgLBB
	6RdW3qau13kcdRYnBygjGvgqaLTv6RtyAyN1Tns23RgUVH9qu7F9OgGt7sJxAa7R
	SMFbrMYwoUnPllL9fRVX1MHAp0YgEqnl2q1FDSc3CNYARKI7TpRDRVVASOH++viV
	Z5C9iYzqPmqaC3tdzkAYqpg3+Nnsx/TA+Y5iQtiZM6KJp61jsi17NFAZ4pNAPRN7
	fRQ/uK+A1sjuXFrqChO0fZl9PDh+YFvKGp0Mdk6wUAyq5dgZUuCODgTx15894Kfv
	slHMorC8NZmYJQR/cPSTLdJ8N5UCJl8caDcSh+ykdQ==
X-ME-Sender: <xms:GqflZUynxSzaRhLO2Betz-ff6ZkGL2I0hktvCPgXgaV6h8zDPzKQEQ>
    <xme:GqflZYSffA5mTkEy8BHHOs3TAip4K7Nfhq1mUP6qkKGU24DmTWzHM3LXBWY7U9OM4
    L2ONJNGrCr-knksYQ>
X-ME-Received: <xmr:GqflZWXbcJ_ucBS5C1ZAm_eCWKkl60-QhjQjDOpULNedgvrRqo3JZedm-i63voLek3ZVlpck2nfTXO0AU7CYiT0FdyWHU-4FneyUasI552fvpXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GqflZSiUKWQ_3cIkuh4uEi0eeJ9ActHkuMWMDN7d6tf2bdzF8XoETg>
    <xmx:GqflZWDJ84Ga5BTHXbCJYCuH5zYFuOjjupj2qIGLZkv7WLvMCbsWlw>
    <xmx:GqflZTKaH8EnFs_h1kVB6iXpkDGcP1MB84N79K6boUt6ezqp3yehtw>
    <xmx:GqflZRNUusLiaQWzGknBhCH4eL3LjiWo9sXmlY8owG-ZeT2yHHvonRbfiNs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:48:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eeffa4fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:44:32 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:48:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 03/13] reftable/merged: advance subiter on subsequent
 iteration
Message-ID: <1bf09661e5c6533b0da9bdf0f05c7459db314a64.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yL5c2fRZgu2Fri8b"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--yL5c2fRZgu2Fri8b
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


--yL5c2fRZgu2Fri8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlpxYACgkQVbJhu7ck
PpRqlQ//diXY7O/8DLp7H5zvrMh2OXTVfIgrFjdepvCA4pe4d+CzLd5AchgWZcfM
amZgG2SEMhrm/ZBIiw99jBS3gn8zSHUFioYzRUnr5OfdBmesBTap/JbQUlP8gMnV
iy4iI2ZkkV+j/ZdajEN2jXK8W/wV8H+EjKW2K5x/+qJE+kbAQ2n19BPsEf9NUVZu
HOMwYKVNY8/xuHQbvK20QhBWNSUBcFEdkVXmNc5NA9QM3AjnKGCQg+o3szEknz3n
XuPry1u5dpF6d2CkaK/IPSbk4nUVVRxFCfklCj2oXpstIYFV+YoBL4y9mDW1FP5J
twrmBQO3CW1gJnjKWl5t8QKS1CnlEl63HQAJFjJhJ+Wx1iFz+UXbVAFuaqTS4alo
ekOFxi5h34sBCJdhAzIvTYwNAFkuU5l692TDHNZnRn4wus9EMKvH4zfCiWhRBWLO
EehS4aj396V2sE6rzUXVi4joE1mlrFhPA0xX76HakPzOwSap/JpaqphOS6vcmWe/
tHpDcEl1LqtFNN0E906IfDvwcuBIEhmwQY4OUz3oUPZ/D8hW4wamM1i5wwocBU+d
V3tta8vVcUjn4PkPZLpEZtf6ng6e5IpYR44CVtAUMxFmCbZPYkScRuUtkmQcZMmO
5YY6DBZMm4Fk6ciPtBiBuYH3X/wPCzPh7mV1C83gUkw7vKcDT0o=
=E9aE
-----END PGP SIGNATURE-----

--yL5c2fRZgu2Fri8b--

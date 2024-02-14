Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F512B61
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896756; cv=none; b=lxViF3vI3c60dsfcsDlXo2tsEaM1DMmVmVLdg0GUjoBid8C0IxUpv95p/XRBTqipBbc2Yvvu7XgcnpClGXVJ2Wx9sis8aSyt7ydX1mTJFb8i0CyLn38RRVUPVlA9YPKz5PQk0FOYlND8pPedm6qovluBMA+23jjNfT6JFdRMGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896756; c=relaxed/simple;
	bh=b5kOUuyLjTa0ZyujA5rBDHGroVF6bTBRrEH6qcJ7Tp0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YofaimuKXp8kqhzqE7zuMw52RBTTg2awAc0Nde8l4wwfeSZUcqte97n1ElqC2+GRL7KExodxmklH/c8owxwYZXO0jFpx7yeOHjAFVZmIzhpT+yDgOiLJuvTCOfutJiM0mTtJ9JCKRmqbJTXtuxZi+WVOrc372jBJ7myRlt8uCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VwiNEMeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N75O3PFv; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VwiNEMeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N75O3PFv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id A3F2E1C000B1
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Feb 2024 02:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707896753; x=1707983153; bh=MTUGI0IVCz
	rddG8oxnE2TQQ5ClezQoBl9a21+C43m3E=; b=VwiNEMebpi5u2c8123poLh2ULZ
	20ZHbt7IhrhQHbrbI69yYuxKog1KoioVuRXVdRd5Z/gZAihSpTEiyjBTHDIFVufT
	l7KZ2okrZP5MAWy6jQktRRWcJ1rGp4hxf05IwvGmiQpqM8IViLGcp8gj08U3DPNu
	uW7ctzblESnnsujJdFc/RctdhfkCYWkl3cWAtxj1lY4W5pekmAVUD/vK8NuUsJbo
	Dg7M2DeI8INQY2/QnrNsZZXP0+OBd4SFUmHP4YxII5JhgJHcuvjsjASHHrTdJNTY
	vJl0uc59nxCR+USs7YHdr8xYVSQskXVN4XNEWKX6LSXPuTFrC4Nx/tepJD1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707896753; x=1707983153; bh=MTUGI0IVCzrddG8oxnE2TQQ5Clez
	QoBl9a21+C43m3E=; b=N75O3PFvcKCrDo+DSv4GR6sLOkJeA8C3nY8VLf0p+/v8
	nVug6C3rlbO26cXE5r1VeeokRYQliFTurTVJQigWXCGmUz9VWQN1GFFPWJ1LtInL
	0OhiiOIsJQGXS3CODWlpto0oz5gXnaFGAkMFeByDA3NbTps0HBsUGGKxZv+9Hrhf
	fxyFE/I/2NAGiWqP3bBQaB6NbrO1UZ58OInlxmOvhdKhT2b7TAABkZDrYONe21qw
	R1MpaI+STAPHdkKLJawm5CIitb5K5mhkIGCelHKppLcpgcOPsfwjydp4vpUlk/Bu
	mKgEb3FjH+nFsKdnj5xD0/oR9dP3cilXEGS9E8/vqA==
X-ME-Sender: <xms:sW_MZTbOE5Z3UL56HWhy2j8u1sTL205a2YUoMfOysR6tEWML129KmA>
    <xme:sW_MZSZtcef5fuwSvQ0L_8dFkZA8Z1gKC5pE1saF06PEJv7p8wlwxfsnc_MMobm4E
    I442TxJN35x4GGPtw>
X-ME-Received: <xmr:sW_MZV_1w_3cp7G_uvo02HxnIp8JXrEZKIbfgc-kSa_YTrC93OCGvBV7U3V4z8WxSmHNN2flu0ew0xNulgzmieliJidqkmFK_LZSQznVv_iVIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sW_MZZo_WvUqL0Q4kbSRelQ9SCe398xc5cu4WFgrfQXdeuSvktgGgQ>
    <xmx:sW_MZeo0zfaOI2FBhMYcAcGakPdVa-wLvSTk0cyr-kWnvIJArqYyeg>
    <xmx:sW_MZfRfiKfFKl7dD9XmQT3l06wnx4mDQXWp2dG8-nHHp1go0Y_sgg>
    <xmx:sW_MZTDku6D_r3VvwO0q86UnDYYE0DpDmaL9ZLIPnXd3JkGjHSg_l7slQbo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Feb 2024 02:45:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50a4df57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 14 Feb 2024 07:42:02 +0000 (UTC)
Date: Wed, 14 Feb 2024 08:45:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/12] reftable/merged: advance subiter on subsequent
 iteration
Message-ID: <38d45995662ba92f4b985b82deac298446274511.1707895758.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8hi0nkaVekJu28m"
Content-Disposition: inline
In-Reply-To: <cover.1707895758.git.ps@pks.im>


--m8hi0nkaVekJu28m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When advancing the merged iterator, we pop the top-most entry from its
priority queue and then advance the sub-iterator that the entry belongs
to, adding the result as a new entry. This is quite sensible in the case
where the merged iterator is used to actual iterate through records. But
the merged iterator is also used when we look up a single record, only,
so advancing the sub-iterator is wasted effort because we would never
even look at the result.

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
2.43.GIT


--m8hi0nkaVekJu28m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXMb60ACgkQVbJhu7ck
PpRcxw//V5WF9/YkkImo/M9fk4cfzIiWmbK7SDVOJk2Auv+pN5fel3pfYDaUKAO7
yvUFvSqYLhu/mpKyffahLJZx1z4/GDRG4gMWhxBDnuAhFcQzJhcPJb21qKt0a6pj
INmrvzPFF7blJqtij16ZYgxVRreCdZ1rrFLLV/xVGAz5AAaqU0mASCVyOLZnaHTl
RNjeNBA+J8yKZ/MAjLRjVdOyya5owsMIusTDAJI4TF3RP/nkUBxTtCLAzZb5MySB
562iIYycJsr7M/7OaVLOB2rlQ/aHWACh5cILTWk3bILOJ1BHqBlZb1lhExzP5Xdm
FLtz6+X2w+Kgip5NqfvXpjDiyg9g+/wI1ANgymKoEafxqfEOZGUYv20MYQm1gAKz
ZfNc1fKPgqCu5ICEDMdtzx9OJtR6HPFJZucnB6Rkf4BUIzJXMsin3SqVszSSOE1U
PGVjux04To8dD8Al/sFcg5wAeCbyv7igzZ0CyIYsp6frVnUwNMBGz4Zcm19mRYP9
3HMKfgkT/dYkjoimnq7rNj+LParc4wu77MM/nXEzUqx8wK2nKSHoPs6e/DvwUdKT
CYy6TD7nQr/Sg85foRwwDiRibg7RC/C+wkFsEbt+yXG4tV2nqmF579rEOvGCMRkX
b8K3YATQ86HyY8XIA3kQn8TIpSoEWfx0SGJ5zhRpgJOX/Ij5ZVg=
=KMr2
-----END PGP SIGNATURE-----

--m8hi0nkaVekJu28m--

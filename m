Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5610A05
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726755; cv=none; b=dYNSALBqmltOa7rz8UIbm9gkmqxJltqb7B1En/+wUHCH56kRwQ6SZc1jsjmHog7A9Do9p+BO0BoWNtNvI46GEPZXUtdbwFziMwO3AuOp2vc5dw5O3X7N7a4H2LVlLZOBSLtSRb0pdk2mIIq1D9oU3C8fJfyZsZMlaXDZw6GqCXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726755; c=relaxed/simple;
	bh=CJHSx1vBgsqj2R9gf0Wi7C+jSmP0h4B8Ii5Njbs9gNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=japNEzwoXfjL02v/zWkgu+4CLhGWK0yrBvK0XCol47t8ND55U+QEYA29YG7TPu57Ny9wu9+9Xz0qPrGiKuJcq8DKxM3o1dUXL/CWp4+BRzu7Ppptmt5cPgkoNqDyqZ+nVjtWBFSx9JsRZc/pEoURKqFwJ+SRm6AYRntAGzT37kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SFaH0j0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ihIFeZXC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SFaH0j0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ihIFeZXC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D68E81140091;
	Mon, 12 Feb 2024 03:32:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 03:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726752; x=1707813152; bh=66N+DOdzXN
	mWAMITmQ8SJRMgrkELdG2OYYK5RPVpKAI=; b=SFaH0j0R49Xez9YH5Bd5NC4/IP
	/MFJRbQEdv9aExCjxUO0/4Lujgpj5xr83ApzHEhwH8tBwTNZovgGJUlcAl+0QJYn
	uOd0WmixYT2C+cZP4zFaWFipI57P8RnFYP3TZPSLuvOa5tkCldTGHNj0racaILz6
	4IO5QBqA95DlLC/kOp5zyigCIFQ7FdcwKUwru4hlS+kT58WU+JYGfOGn0iVhSTkz
	0ELj5YeNuki44yQTsvGfxuqqRjyGqNP9R2iyyaykJX35yI7eJEbMLlBVB62lUzOF
	mSVG5hG/h7GsfuKQEZxGSVBQna2NB4Cod81+z0dQE9pwXNp/7/RGzv2Cprog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726752; x=1707813152; bh=66N+DOdzXNmWAMITmQ8SJRMgrkEL
	dG2OYYK5RPVpKAI=; b=ihIFeZXC8mCvHIvPfVlWHi0kuHD/acSGJMVsw5VqD0C0
	unYgVJ/d58L4LfkRs6su7HDyb/y8g8bsZ1HR6W5k9G3RMMAxyQP6EAg4rlkZmjNN
	zXbhXoqeOY/iYkzuNpn6MCjyheBfWMsePI90XRxK1F7CMey9V379NnJoBqniVDIL
	QhmRpDpH0ajq5JTJJZrhnHh7j680JJ2s7ETMpV0uG4dIei01UiiWt6BWmLBF4yRS
	s8f4viOQx2XzPkSUUZ2TTW4HyEemhzQ9CuZfV7ytO5EyKGSn6alHPdQuN2nsmMUE
	6n1HL/INZ8z3ooyBYvc97qSFO+yTUixB88QOJjKd9g==
X-ME-Sender: <xms:oNfJZboiS_xHn5Ym7QVhA00UkdfERPXHj51bGGumKpZmlVQoePReoQ>
    <xme:oNfJZVoBn4QO_YrQwwE4fCqSgZjjMVq-qzL7o-Tk-SQ9BLy2RAK8ZjeAqFrRr-8K0
    6IcYHePYYhNF01q-A>
X-ME-Received: <xmr:oNfJZYPHQpXagdGOX1FSS2gk7CTv8wdwKFkMNtd_-TNnaa2OutktVG3-KnO8tzVkzq1C7qYEgRhoE6pacBBAblGjWvdUbxfxKzyOsf8TZNVOle0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:oNfJZe4QVlgy8XAXEhW8hCsC3kiRifNsaW4JxgtO6BnTvT0HCYzAtQ>
    <xmx:oNfJZa7NhivXCqoeyB4MnaBoBOaDyd9TtBqao0d95L2q6DNmkkY4YA>
    <xmx:oNfJZWiDfqawn57xUgnZXP2gNxlkA0Z_z7BZxzP74wB-V77QPszbbQ>
    <xmx:oNfJZQnunIXveBlqVRKh3WCRcX_X-85J8u-VP6zwY4ZoBjtEjKq9ZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e5c3c38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:28:45 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 2/7] reftable/merged: allocation-less dropping of shadowed
 records
Message-ID: <2364a0fa3369063355bed966267a19fb9af3a6b6.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rx89383GdCGFe2MK"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--Rx89383GdCGFe2MK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The purpose of the merged reftable iterator is to iterate through all
entries of a set of tables in the correct order. This is implemented by
using a sub-iterator for each table, where the next entry of each of
these iterators gets put into a priority queue. For each iteration, we
do roughly the following steps:

  1. Retrieve the top record of the priority queue. This is the entry we
     want to return to the caller.

  2. Retrieve the next record of the sub-iterator that this record came
     from. If any, add it to the priority queue at the correct position.
     The position is determined by comparing the record keys, which e.g.
     corresponds to the refname for ref records.

  3. Keep removing the top record of the priority queue until we hit the
     first entry whose key is larger than the returned record's key.
     This is required to drop "shadowed" records.

The last step will lead to at least one comparison to the next entry,
but may lead to many comparisons in case the reftable stack consists of
many tables with shadowed records. It is thus part of the hot code path
when iterating through records.

The code to compare the entries with each other is quite inefficient
though. Instead of comparing record keys with each other directly, we
first format them into `struct strbuf`s and only then compare them with
each other. While we already optimized this code path to reuse buffers
in 829231dc20 (reftable/merged: reuse buffer to compute record keys,
2023-12-11), the cost to format the keys into the buffers still adds up
quite significantly.

Refactor the code to use `reftable_record_cmp()` instead, which has been
introduced in the preceding commit. This function compares records with
each other directly without requiring any memory allocations or copying
and is thus way more efficient.

The following benchmark uses git-show-ref(1) to print a single ref
matching a pattern out of 1 million refs. This is the most direct way to
exercise ref iteration speed as we remove all overhead of having to show
the refs, too.

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     180.7 ms =C2=B1   4.7 ms    [User: 177=
=2E1 ms, System: 3.4 ms]
      Range (min =E2=80=A6 max):   174.9 ms =E2=80=A6 211.7 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):     162.1 ms =C2=B1   4.4 ms    [User: 158=
=2E5 ms, System: 3.4 ms]
      Range (min =E2=80=A6 max):   155.4 ms =E2=80=A6 189.3 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.11 =C2=B1 0.04 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 11 ++---------
 reftable/merged.h |  2 --
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index c258ce953e..fb9978d798 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -51,8 +51,6 @@ static void merged_iter_close(void *p)
 		reftable_iterator_destroy(&mi->stack[i]);
 	}
 	reftable_free(mi->stack);
-	strbuf_release(&mi->key);
-	strbuf_release(&mi->entry_key);
 }
=20
 static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
@@ -105,14 +103,11 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 	  such a deployment, the loop below must be changed to collect all
 	  entries for the same key, and return new the newest one.
 	*/
-	reftable_record_key(&entry.rec, &mi->entry_key);
 	while (!merged_iter_pqueue_is_empty(mi->pq)) {
 		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
-		int cmp =3D 0;
+		int cmp;
=20
-		reftable_record_key(&top.rec, &mi->key);
-
-		cmp =3D strbuf_cmp(&mi->key, &mi->entry_key);
+		cmp =3D reftable_record_cmp(&top.rec, &entry.rec);
 		if (cmp > 0)
 			break;
=20
@@ -246,8 +241,6 @@ static int merged_table_seek_record(struct reftable_mer=
ged_table *mt,
 		.typ =3D reftable_record_type(rec),
 		.hash_id =3D mt->hash_id,
 		.suppress_deletions =3D mt->suppress_deletions,
-		.key =3D STRBUF_INIT,
-		.entry_key =3D STRBUF_INIT,
 	};
 	int n =3D 0;
 	int err =3D 0;
diff --git a/reftable/merged.h b/reftable/merged.h
index d5b39dfe7f..7d9f95d27e 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -31,8 +31,6 @@ struct merged_iter {
 	uint8_t typ;
 	int suppress_deletions;
 	struct merged_iter_pqueue pq;
-	struct strbuf key;
-	struct strbuf entry_key;
 };
=20
 void merged_table_release(struct reftable_merged_table *mt);
--=20
2.43.GIT


--Rx89383GdCGFe2MK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ15wACgkQVbJhu7ck
PpQKMA//YOYdUt0SM8LJfSR1duEHxduTDbdFDpKQQt8SbkBJsirWkOxFTmaIOrM5
BQaPXW5+C4uwLnxdi0sqSD4CyrQnb5VhnuBAfsAEZ8YRprF6klqDzJNWbVb56rU1
gzumsFyx4saPzqyZHKAStc+7cCdrAz7Ss8WMJ2nIXNd+ymwvDnOMhXEPbAoOw4G7
fppTDKNYWyXqvJMGe3s/EWAk2LfPhEChPyednUV5+MgPuYA/WyaIxYHm/kuo4QlV
v/+n3mWh9vH0SoYxPB9rRIUuhC7de6Gk1r9Wre95+oLqO0QXNcIrnMCIMDRorote
0BWoJTpwIP8MjLDoPrx8zLuPHyGAF+GklcNa02W9TcriswKqcG/b9zBt4cA5mNhU
PHBPjKAnIDO+vYbz/yxOz8cLuNkRKV+6zEVG3BxcryKMjmoRhKfmW/Ke1T7lLqAM
QPgtJEvsgwH281rdbtzM3d/y5ujezPFtl8KunQD9LXnKen3DMGWWfATGJED46Wum
3uEXHLvjMbZGDFcWAz5GUML5s5mn50vPP4k/ST44wMtSPGmxFm4dFfvYV7wyeaGE
0FaFZb0BWHnuw0kKRI+2QoA7aKLi0E63IfAURz0uFCjOV8tjgIH4dtd9DSHV/G4s
I1lH9dIzF8XGUSHSsugnZqLQO6ThqeHNpfFm/Keqlx6SlsQBAz8=
=MXzM
-----END PGP SIGNATURE-----

--Rx89383GdCGFe2MK--

Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF37219E0
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632742; cv=none; b=rhzCcNOmxwQNRtQ2GkXvalwVcK7HjjGh5iHGNkwrWQKljwS0tXqB4ZF7CdYQ0FricXEvMbipOQPXDvV0cRFJUGcxE9V4wMT0DMXFxhrR9WxEKSblGiopP792T1kvCpmgd+dbnF7SvOwM7QR1lHR2ERLSwTDSkJZW4XTS8vWvvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632742; c=relaxed/simple;
	bh=VDQoA3a+5Za7OGZ4jRKYfu+LjUY1nTIrDnyI7CELch4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Boyu44TKvW6xWbieDL/UacxGaSBj83JvsAlWxAFtgBGanvSFKKcH/TPlIuAbNg+FDEp6NTbVcdUvupAhoc1CWi3va+y+RnGZUKH49tGioT644hGHpl4AQqs53oRjw6ABc1T5eVtjZmgYLYB76oQfRtoPDBo7RfeTHAurcNWKwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iS9jBE2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hddm0+2W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iS9jBE2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hddm0+2W"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4B3681380395
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:52:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 May 2024 02:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632740; x=1714719140; bh=8R8GoFO2SD
	tOs8Uv59r7cJHXfmw8BMKfAsRgeWiuRvA=; b=iS9jBE2rL0mpRUvCmzLfukWsDe
	bX1OwSOzMU6WuUkqkmYseIKRDAD0nSzXmzWuWO93VGsqUt6ocbsPecJ3HQmWAOjp
	bU72qIJ6nT96mb1yuVuqoXf2UgsX1++cfsYmBE2IMRwlSeyFBgi4DHbx0QkiallG
	zfmAaT8CwOmFoRwvb6GL4e64qgjrS9OG9klomhtE5kqNaCplCoKtUe+MQoa+AU++
	MfgXqD5ByKPeA8kqu0NCZmQ8Vrh6Mq+kjh5NxCArEPuC7kT7y9gJWX7auTUCRcDL
	I+xrajLEryNJa4C6RaKXtRARP1WwrFLzxbDeBIYHjbRtDTHyxnfoGLjQtKhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632740; x=1714719140; bh=8R8GoFO2SDtOs8Uv59r7cJHXfmw8
	BMKfAsRgeWiuRvA=; b=Hddm0+2W0BXCvmmYc5ckBz/k0hLR8tkg0LxTj0VwCXes
	xKgTshcH73M4iBQXk0e1q1rJtV6nSyEL28bG7WGDrAr0JDlHChF/qkInvEEEN9zv
	7Z91X89X9PLZ4E/Y+FP0PdxVM7aT+WMmdHOU0n+5NAt9LlJADtvJJDKxnSMuRq26
	w/bf3jhGzTNaceY5xLg7mrESnJvdXq1e/urvsndJF4u+xU3XoORq2nhVtSZdJ5j3
	mFMhVy+EdWmP2p6RpeF2wXDtK0QdlMn7G+TqNWeVM4x0ajhaQGPmpOAiBnu+o4ob
	QgDhLVimgZ5NqzH9x5Ai4ln0B1ED1lHSgfSdMjFH4Q==
X-ME-Sender: <xms:JDgzZl0Cg43_V7BO-o3r-zLZSn9zblZqfuQGVyCpqqbR5o6nf4KkuQ>
    <xme:JDgzZsGrmRBvzmA2p1mLdhJurBNZoI1l6ag5ikFlw9CQYAHy5TaIOahLVAGbcWOPN
    XUwlwNsPHsl02ziNQ>
X-ME-Received: <xmr:JDgzZl7fCc1jn1ajhPXudK0Au1VkjAXGbx1giLOn-YxwclYstOA3OxNTV35VGkQ_SL0QSLS3jrgxCRYoRcnkCOrtiNsUlOct5NJiHclsGA8VoeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JDgzZi37bd_gmrBvsPg7PuEsgI5-PpBnWjszNhrpjTtkQtFC5P0VZA>
    <xmx:JDgzZoEkPsHkTHkEkWH2QhMHJZcnPQoE4hVBZPAEhmayC6IqXyyHXQ>
    <xmx:JDgzZj8NFCKOlQUAtlnunhSj8g_m1OVg0p3ZCio3Z_AQEb7HQj6iEg>
    <xmx:JDgzZlnPIdF68xtdStXcPyrl-uBh79OniVCnVJ1pWeXWb2c0XvDIAA>
    <xmx:JDgzZiNfBngQEpHgStKNLdtAqg2sKSmI-Oqyk5TDp8AZjDMJuADGx28Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:52:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fa366084 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:54 +0000 (UTC)
Date: Thu, 2 May 2024 08:52:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/11] reftable: make the compaction factor configurable
Message-ID: <30e2e33479a6b6b07a4652e84eebd78f71fb363a.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e5xiBPfCrwOf3KBP"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--e5xiBPfCrwOf3KBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When auto-compacting, the reftable library packs references such that
the sizes of the tables form a geometric sequence. The factor for this
geometric sequence is hardcoded to 2 right now. We're about to expose
this as a config option though, so let's expose the factor via write
options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h |  6 ++++++
 reftable/stack.c           | 13 +++++++++----
 reftable/stack.h           |  3 ++-
 reftable/stack_test.c      |  4 ++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 4cd8ebe6c7..155457b042 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -49,6 +49,12 @@ struct reftable_write_options {
=20
 	/* boolean: Prevent auto-compaction of tables. */
 	unsigned disable_auto_compact : 1;
+
+	/*
+	 * Geometric sequence factor used by auto-compaction to decide which
+	 * tables to compact. Defaults to 2 if unset.
+	 */
+	uint8_t auto_compaction_factor;
 };
=20
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index 7b4fff7c9e..6b0f8e13e7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1215,12 +1215,16 @@ static int segment_size(struct segment *s)
 	return s->end - s->start;
 }
=20
-struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
+					  uint8_t factor)
 {
 	struct segment seg =3D { 0 };
 	uint64_t bytes;
 	size_t i;
=20
+	if (!factor)
+		factor =3D 2;
+
 	/*
 	 * If there are no tables or only a single one then we don't have to
 	 * compact anything. The sequence is geometric by definition already.
@@ -1252,7 +1256,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 	 * 	64, 32, 16, 8, 4, 3, 1
 	 */
 	for (i =3D n - 1; i > 0; i--) {
-		if (sizes[i - 1] < sizes[i] * 2) {
+		if (sizes[i - 1] < sizes[i] * factor) {
 			seg.end =3D i + 1;
 			bytes =3D sizes[i];
 			break;
@@ -1278,7 +1282,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 		uint64_t curr =3D bytes;
 		bytes +=3D sizes[i - 1];
=20
-		if (sizes[i - 1] < curr * 2) {
+		if (sizes[i - 1] < curr * factor) {
 			seg.start =3D i - 1;
 			seg.bytes =3D bytes;
 		}
@@ -1304,7 +1308,8 @@ int reftable_stack_auto_compact(struct reftable_stack=
 *st)
 {
 	uint64_t *sizes =3D stack_table_sizes_for_compaction(st);
 	struct segment seg =3D
-		suggest_compaction_segment(sizes, st->merged->stack_len);
+		suggest_compaction_segment(sizes, st->merged->stack_len,
+					   st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
 		return stack_compact_range_stats(st, seg.start, seg.end - 1,
diff --git a/reftable/stack.h b/reftable/stack.h
index 97d7ebc043..5b45cff4f7 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -35,6 +35,7 @@ struct segment {
 	uint64_t bytes;
 };
=20
-struct segment suggest_compaction_segment(uint64_t *sizes, size_t n);
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
+					  uint8_t factor);
=20
 #endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 3316d55f19..f6c11ef18d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -767,7 +767,7 @@ static void test_suggest_compaction_segment(void)
 {
 	uint64_t sizes[] =3D { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =3D
-		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
 	EXPECT(min.start =3D=3D 1);
 	EXPECT(min.end =3D=3D 10);
 }
@@ -776,7 +776,7 @@ static void test_suggest_compaction_segment_nothing(voi=
d)
 {
 	uint64_t sizes[] =3D { 64, 32, 16, 8, 4, 2 };
 	struct segment result =3D
-		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
 	EXPECT(result.start =3D=3D result.end);
 }
=20
--=20
2.45.0


--e5xiBPfCrwOf3KBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOCAACgkQVbJhu7ck
PpTCZg//T5lfpt29+O6bfVTp1yhKjj3N+zK/bj89wdeUPxL6MnFdTAWgfK2punw8
uyJWfPle2gSspTbbej8lYdr0xllnsYo20DQUPt5BWwjC0Fp4QvF3/RwwWi69vPwN
iftYDU29vGGCg6dJdtcQaJ7Rdfr8kyZ40qsnlF+IFLX8qkXxTQgeayQQ717+R9+u
fa5GLsYfob5hh2WhukzBLaZB/OCem3RJcOTU2W8ulJTMj/nW0CN5O1CtI5+FCXTM
dPijWhxFfZTm9a/Sc0lXg1urvrbWNrgfYXMpeW35ndxEj5bLLOlOpzMIUdGOBvzy
Tg4AUPFJE5ze11IkU/U6oLYDJIEkgWMovZZc9ue2pQWGDfOfLfBflomyA9yuQ1jP
S1G0ZWfvmv4D5SdA9GhxLdsADG5CRFMZTGaLW48Le85JhMwLdsShPyUPR/kX+7Ne
vCYEdqKdfEUV+ZrHLXO+3HZOjvSNFOLmZo1CbtQxkK/O9FmxmANcjdvizyeB4PWU
5ftX/IesS+4A6ouRRr+wOCIr62PcWLuPQzPnv+9mMsqoqoaqd0GKJoMoIilkKjwS
pn3KXeQLmRNk5f4q1mHvg2Y/NY7uk4317aIGuUgga4cBPKv2MNrVZ8OdIibELDQ0
uoKdTqneWtwo2ABPmKtsxq5TLJgxD6hMh4eXLABcKngnl3T8CH8=
=JwpW
-----END PGP SIGNATURE-----

--e5xiBPfCrwOf3KBP--

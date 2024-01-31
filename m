Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEB5D8E5
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688081; cv=none; b=lSopoYFtpjmqVyx9PLVwpx3dY9EwSUewZ/E/7Zv7ngr4zZCZFBlEk9KjAhiyg///2JDedgceIe4qOvQoSkCvpWaP76E7WXJqtbneCbo1WjyafGG3m7mgYrucB7eYc21XIS+p4FLnoMOq1dY1AoMAf+ZY4LORks4axkB6vlXi/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688081; c=relaxed/simple;
	bh=jZDKEfs1WpeRna99wyKahiaGerjFe6ZW6IpPH2yc4+g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU7b0sujJ8WpPkFk8mQaOnzWB/lN3sByhRp2UR7iACCisZIQcRMc/cW8VKgSZ4vBPFEKTGKpiQf6SnR6dT0H+oYLmGxvmDgB0HOQnKzsiCT+FCFcWuOy6EpAqWJwNcCU1APLttLh76jij04US6xfHy0qpCEy8N34iOaXtJUqUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IJYFq16Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OH3ZZ3ed; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IJYFq16Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OH3ZZ3ed"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CF0845C005F
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 03:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688078; x=1706774478; bh=qKgnGdCUyf
	L2nihbtgl+5EvbKhr4gSHKzebbkKNmuiU=; b=IJYFq16ZNPNcPmKJsjvuB7oY3P
	EBiqoFHXWhC8mnDkIPOFI5wOY/POIQIjBUadPstXylhls8NpK/p7Zam2hICh+MMG
	nRFwG7mV7cfm58AOMAaTdYnVaKYMOnIFBDYir3jH1/Fm2tJsF5i/ziazk564E4ex
	wcon8TxRorZPM6/T/zTM6byRa5RyHCj1xXyPwh2wiULuuqxqeXcK4ErlDcAcFESN
	mmOaYZh+B9BtW+EMIQwM/iahxAngufaihOJ3nIU+JEM8IByuKSRcKREqnK67bcId
	5McIzgH1Mq2fmZdGTNXx6XZEGG5VMhrwU5sddH2XxFJwB49vCeASYdkK99aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688078; x=1706774478; bh=qKgnGdCUyfL2nihbtgl+5EvbKhr4
	gSHKzebbkKNmuiU=; b=OH3ZZ3ed4OmV7G6FOS2j+Uk11fhH93P12nyPwS/77KzN
	NNOQYG4bwnK4YGJDWP8Ur9gNB1OrYCCHs52cTEVjEZjoTGQF0BRzlODVEqpTdHDq
	8f7iX7KLLoELpsHvyGLKYW0cuv9K5vtxz4aDnLydWO254ekajLWU96OUvr6GMHta
	dUETlcfUd4U5mE3XwuERb/UlGVI3m/0XsKWbnARQKcgoOlu3qMUsxYAyeeCxhNOJ
	OgggB9QLl8wpr5OVCrxpOFJ4BxAV7xPSFsOZ0uJ6vlsCtV54rnXnNd9YWZKYhpyw
	BqRFrFhyiukuBKhO3sw5RAxB5OyoTxPq63+cFp3qaQ==
X-ME-Sender: <xms:Tv65ZfQokdam-eqdT6waJg54rhwXldRDW4RvdVPVPCjhiIfRVCdGMQ>
    <xme:Tv65ZQzEf2fb_fQ9quxZYUSizGQKzPkvDBlpeWEjyGRqNBB7F82YSCTWuGEI3nj7D
    NnK-ld8T8Ua9UBOxQ>
X-ME-Received: <xmr:Tv65ZU2Z-fWoZgxLDNFZZcQBLx61QCdQwSAvd9NvS5SwLR-YHC0cR37IkpQ9eNLn3363WB2_lGUnAbqRkg3AfuZq1Uxkt_7FUBwBFIuMlmwFj_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Tv65ZfDf4Fjzw3AD4-tim5AhXoJrwXv867oyAsydbOePSPzF4VmYdg>
    <xmx:Tv65ZYi9dK6GjHoNSePRHj7DVDHpAMnSB1GV2Uluu7IklkNodXKcjA>
    <xmx:Tv65ZTp_Q1Qdzf87FCTUQlIOXUK42FZmJ57O2cIHHX5IpgSvEvQDgQ>
    <xmx:Tv65ZQKz0d5KM49tPF8p0kWCMQG2Wr8LjGuVlhSkJq1ExWTjcbUbHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e75cbd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:57:58 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/9] reftable/stack: index segments with `size_t`
Message-ID: <b8b2cce742dea7d720366ae086a80c976183e30e.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3JbXUkftRW+CynOL"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--3JbXUkftRW+CynOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `int`s to index into arrays of segments and track the length of
them, which is considered to be a code smell in the Git project. Convert
the code to use `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 25 +++++++++++--------------
 reftable/stack.h      |  6 +++---
 reftable/stack_test.c |  7 +++----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b6b24c90bf..2be3d1e4ba 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1202,12 +1202,11 @@ int fastlog2(uint64_t sz)
 	return l - 1;
 }
=20
-struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
+struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_t =
n)
 {
 	struct segment *segs =3D reftable_calloc(n, sizeof(*segs));
-	int next =3D 0;
 	struct segment cur =3D { 0 };
-	int i =3D 0;
+	size_t next =3D 0, i;
=20
 	if (n =3D=3D 0) {
 		*seglen =3D 0;
@@ -1233,29 +1232,27 @@ struct segment *sizes_to_segments(int *seglen, uint=
64_t *sizes, int n)
 	return segs;
 }
=20
-struct segment suggest_compaction_segment(uint64_t *sizes, int n)
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
 {
-	int seglen =3D 0;
-	struct segment *segs =3D sizes_to_segments(&seglen, sizes, n);
 	struct segment min_seg =3D {
 		.log =3D 64,
 	};
-	int i =3D 0;
+	struct segment *segs;
+	size_t seglen =3D 0, i;
+
+	segs =3D sizes_to_segments(&seglen, sizes, n);
 	for (i =3D 0; i < seglen; i++) {
-		if (segment_size(&segs[i]) =3D=3D 1) {
+		if (segment_size(&segs[i]) =3D=3D 1)
 			continue;
-		}
=20
-		if (segs[i].log < min_seg.log) {
+		if (segs[i].log < min_seg.log)
 			min_seg =3D segs[i];
-		}
 	}
=20
 	while (min_seg.start > 0) {
-		int prev =3D min_seg.start - 1;
-		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
+		size_t prev =3D min_seg.start - 1;
+		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev]))
 			break;
-		}
=20
 		min_seg.start =3D prev;
 		min_seg.bytes +=3D sizes[prev];
diff --git a/reftable/stack.h b/reftable/stack.h
index c1e3efa899..d919455669 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -32,13 +32,13 @@ struct reftable_stack {
 int read_lines(const char *filename, char ***lines);
=20
 struct segment {
-	int start, end;
+	size_t start, end;
 	int log;
 	uint64_t bytes;
 };
=20
 int fastlog2(uint64_t sz);
-struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
-struct segment suggest_compaction_segment(uint64_t *sizes, int n);
+struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_t =
n);
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n);
=20
 #endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 289e902146..2d5b24e5c5 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -711,7 +711,7 @@ static void test_sizes_to_segments(void)
 	uint64_t sizes[] =3D { 2, 3, 4, 5, 7, 9 };
 	/* .................0  1  2  3  4  5 */
=20
-	int seglen =3D 0;
+	size_t seglen =3D 0;
 	struct segment *segs =3D
 		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
 	EXPECT(segs[2].log =3D=3D 3);
@@ -726,7 +726,7 @@ static void test_sizes_to_segments(void)
=20
 static void test_sizes_to_segments_empty(void)
 {
-	int seglen =3D 0;
+	size_t seglen =3D 0;
 	struct segment *segs =3D sizes_to_segments(&seglen, NULL, 0);
 	EXPECT(seglen =3D=3D 0);
 	reftable_free(segs);
@@ -735,8 +735,7 @@ static void test_sizes_to_segments_empty(void)
 static void test_sizes_to_segments_all_equal(void)
 {
 	uint64_t sizes[] =3D { 5, 5 };
-
-	int seglen =3D 0;
+	size_t seglen =3D 0;
 	struct segment *segs =3D
 		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
 	EXPECT(seglen =3D=3D 1);
--=20
2.43.GIT


--3JbXUkftRW+CynOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/koACgkQVbJhu7ck
PpQ7eg//ci3TQSP8pmRT+fOVaHB2+zzaG+NThM0rlPKWrf0txIwDALOzY74nhJ/p
jugHsLdXFe0vz7YgveUatSsp02GaXrf9MbQdgZU+EPfNBcGf9/KNTQieSli738rI
NWjQhvF8Fafn/ueUWpzPQWsBwQX3sGt5n2O+UwrwDHvswX1ufzV23cz0z5Ktu/ys
NNN9IcuC/T4IaHKLAH3blf5HU/z/2K00UFWl5VsqRkHdtnUIEKUpz2YaeO/PjFQp
lDYCYpC4kqCuPT7EhvemSCR5PxquIHe1SN2rLx0k0u2SdftKxxOsBAZEPvSCC7QP
kFs7l4HSbKqc8Q+yr6OLBa+UAsiIJ50lr/ZpujS5w1TJOlAG2b5rZXOyANK+beQu
egrHOQNkLvjl9Q9JCicIBaYjs6QYoS12w46L8217ZPklEeJL0hNjfg+U2cy+VaDt
KPjzdWxg2LZL0qksWle3/GT5aFVx0ndkHRj2ARDKtHonw6kMRZbroxpNuL4ceAvI
k9zIzFv+P3yfcptjwqC7HDS0GLUCTwyVTqITKPNYzxPA4ZSP6xGXxPh6W/XsejHI
SNpaGK3pVUqRDnrGwlkAKL8SxifZYVZPEkkzIqJHErgVLiyIFSwopO/9Yb3fCg/g
9D4e2nQbuhHHV+seFu+SZq3jSnbCsQqEa8UgPe1YncTQnjGB5LE=
=KUax
-----END PGP SIGNATURE-----

--3JbXUkftRW+CynOL--

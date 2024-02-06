Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E444128361
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201342; cv=none; b=TntGtnfk8Wbqs9HFyCkaNa7PkcOt/mZjpb6jpoSiXdx58Qi6l+iYb74RcwPeaoMs684fhqDl71TTazFgB7hURcNoqBgejnJQPZMvmZUwjkSyrUN+WlzTmxJyOzUBeBcOcy9RYsSaENTJHPpEZveezc7evleHeErt3ZQX2WnTNlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201342; c=relaxed/simple;
	bh=DYzSdWt0waJVHIVE124yOd/fXzGmo4hza56tWQP+ews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF0nO6xtpjWIn7wUPGfIelfrtl9r6TrvYHaUyxffu82eTvPruWiwnTbQDBJUE00pOB9u3qyVYsRq5gJnVo7Ri2axVDd+UN5NEfel+MZTD1Je/I4cr6FBkY1oeqUbrY2PWcmcpvaUT2r3aNtXvVKUHOVSmFoRYFq71Si7paBMTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ICmluv/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uEj0xC3f; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ICmluv/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEj0xC3f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5796F1800080;
	Tue,  6 Feb 2024 01:35:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 01:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201338; x=1707287738; bh=KQ6+At56Ov
	vvDoUL9wUOQFplhKYONfH3azh95NQyc9w=; b=ICmluv/+DK47Xrrbc2UH1eH0Eo
	iRdMlm7gd6AAba2jv8aXRsirZigbMdOCNXPbBQ84vKceRk5ZTWDrniVHjZ8mdzUs
	zAMO9jugLBn+PJbRYapaZPS6z8bjYRmn85HGL6V4yQ5O5jPsQNRFzFmMhpRD/jEr
	XFpnlwuEjTWu5P61ieI+wXbVJMTOls4DIP7psLWIc8F+KIE8bBPijV41uWIcf/K1
	MU+++SQDBjFC+b/3m5WQfpOedXRJd+Lp0k6L5SRWEnEORue/Ta4/eWNw8CToRt8B
	SUcYnQwYHjo8vSLd3A7pzVGPe+5o0f66McqToO+zStClNCAytIo07Y68S5ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201338; x=1707287738; bh=KQ6+At56OvvvDoUL9wUOQFplhKYO
	NfH3azh95NQyc9w=; b=uEj0xC3f3gkESXSHYag0HS8P3p1tXNVVoeNPbbRLYvwy
	vo2MGqwH19KEvRBJNZxm74O7JVutlp//jhZKSeHjfW4LxxcFHJ0YCjUnuJv/sxtQ
	ikHZhOAgse1aGgwpXlTnEkREnREjpdTUn/xfaY3cutR3Cf5TycZwXft45+C9AD6+
	BmpGKqsFpUxgjq1tqJJd2cdJMx+RwlxlTXCpYMwd+elpY00prSaUdFuRbVzOyNUJ
	40P/uBydPRbcBM5Ta8PDyYFO8ySpLNWuWmJ/ukjv+2b5YdZlgiCllCF3KpO/YMK1
	WJVn/5fCqttBsN9odPtCAfer3tVt5iQzzB5qxIyD7A==
X-ME-Sender: <xms:OtPBZU1ub2CGStixHBHwp3yDotCai_Uwib8zzl-GYl2SysEJdex2kQ>
    <xme:OtPBZfFAfelUrD5NRug6-7fWycdfXD1qizg8UW_Uoml7tXNXYsnP8eNwwSqP1POgg
    n0327Z_3mnnOx4_4w>
X-ME-Received: <xmr:OtPBZc6EOcYj_rHeubALGsCQuxNCArwds0UmpKWAfQhObiM9hMeuDLVSO_klgIORhrnhGBezocnHbg2Wp3EPhMcpHAREFXBpwk9To2KpZcrHaI0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OtPBZd0LmmpcOCwbXrl5073CrCm5aeNWnyjgDbXhkyBNNv7i69o2Bg>
    <xmx:OtPBZXFfP5wDfuPBpbm900BtS4nqKsNoazZfZEsXP_dmgU3pAPZnow>
    <xmx:OtPBZW_FzfElGwPjr_3eqaoxxoZ27gKbPiVhbq1DGu1snHwFLgk7lA>
    <xmx:OtPBZYNGD3sY3TI5kxYXxlpBSNTXuH4kyhbZKkMmugENYwfJvjE2bxRnWIo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f269b53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:08 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 4/9] reftable/stack: index segments with `size_t`
Message-ID: <7bcfe7b305b800f0d7c20d8322ca8b68b4f9d656.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7F3Lrz7tShQuqKR"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--Y7F3Lrz7tShQuqKR
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
index 1de2f6751c..5da4ea8141 100644
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


--Y7F3Lrz7tShQuqKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0zYACgkQVbJhu7ck
PpSugw//a/GLFN2Ew233sCDeakw2rKetuf4V9XSx8MisnOd4zpZX+9nvNC4d1/v0
KFX/uynNQ9V6LdwIMCdZkprtqBcVLZETNo+A04xxQaGQawMsKT2QYlbqqAcFbJfW
nd00OVh6tTO9y+kkeNDjJdBPNPjIO0bm5ukpGmjgDA5Huf8uO14j6xp5i+uEa1FB
NCp0D06CG6jxZTc4JgyyEMaHLHJXZfyzyQCfwxvaxfVl4Fhs4MOBihVHlPGTu1SF
HbO1S6W0A6+3ynBmMZFu/Us3z77LYapK6Xm9pqPwcE2H4XYrGnD/yuQ9K3Kk1Wmn
tWsRncWJ0PztRGGKEE5uahp4XeU0KDQizvvQ+iW+excdOIZN66YFr9/ObD/5N6uV
l6ZcELtevFqr0RNLvSPdwuQsAPAbbz/R0l4xG7v8Af9L8vjqmO4ZuIDQ/Jqm5wSx
iSZd3XGUGrJgze5uOcbBRnFYyxpj1OVutt2R1bMGvBZw49RLJVWw9ACggMo936xm
+2VeCwT0m3tHCHt4FWGEiDDsF0VOI0VhLGIEKOVt02Egnj6cHIHBQ0d/j3X+P2+s
guBtkkbTrGc5yJNBbfKtLwEQt/hB6b0SqBNp5d282q3J09rCYf4ldmBbgL28mpyd
YUDAcDKPWFO+vdcj8JuDcszO3EQEo5TykgNHuzCMPn9GpMWXegE=
=eY7v
-----END PGP SIGNATURE-----

--Y7F3Lrz7tShQuqKR--

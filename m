Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450E15A4A7
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772792; cv=none; b=oU6pFtWUmyWU6XY1Z/Z5bZ9LXK2TVEd432nmnC16qiWUbsMlwrvMB795TRnllGnlBdR+Qvt16hW2NxUbTT0Wm4hBHcLK6iXIRmgg7x2voANGzv39L6FW5g8TQcOp0NrjladLIg3hOtH33Z3EKeH5SqzuHZkJQ6T8GiY3p9c6k5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772792; c=relaxed/simple;
	bh=W07L0VM6Wkf2Baujko45vdHmD5zZ/3SW4KPU0oQPM7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIh1aaN1vh4P10MLkN83otpaqQWbXx1rPThesjxFuG4MS0ID5F9FRfjwwbii6MvXlI/g8hwP1dkux+ewLvAlRTsqKoHlvzkMwXJdl+QUixXOOR8tgKibt3NbxY3/qWQ8q6X/+31HUKTuOgzGiNtyaD8jVB3VdvIY+EYYK1f6I9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lL+77xKj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHPZ2anF; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lL+77xKj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHPZ2anF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4CA681800085;
	Thu,  1 Feb 2024 02:33:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 02:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772789; x=1706859189; bh=HAdUdDM/Td
	2dZ+w2m+b9txK8SuIsM3CjBRz/biOOUSI=; b=lL+77xKj8uNpbKdkCWjf09VH1/
	R915YTzdS/f5RZ6FXpUeXwPGsZa1sAFhD4BMhtQDNwgPbZIQQrRFo4nLgEQaqQWH
	pDeeDV7M8Sndlao80XxUMsfY4PioupRSoY7RQEAExdc5j23K2n7qI9edKfSBzBrs
	pyDhFBFfuAFCCzHnliRhseCSHlK37nzRuiq9iwXE1V85LKPEyyX72wzWcQYRnYqj
	hpXwR20i6Zx9L1VcwMlFMdIGibDObzSrZjECXAQj6QMI+vqw0K319CTBTCw0i3HE
	ziIGRy/fb2ZTHoscunSCyaG+Fg2ON4GKTvwxtgHhlHsW5P/kkF4qyzg1AiWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772789; x=1706859189; bh=HAdUdDM/Td2dZ+w2m+b9txK8SuIs
	M3CjBRz/biOOUSI=; b=IHPZ2anFqa2WrCUlJKXdp7IrrDz2giGuAjUkgzYJLL9l
	sS36C+3a2wXvq5gZvsjLSvf18xKinn3I/hq5z6xWdzChVSzT5+eLx3dhDS73Z+6a
	G7/Og3wg6t1gQ+72Y0DMq6Q7trXP7RDzkKDid2YjBG0QyTh6lx/1yHIY7wvKN1De
	7gB3N3RV3adzt/U9a3dmzjwC5EY3C9pEIGdamcTYte3NM6F2wTFWJLljAgIRCfAP
	Zy6iPUAPakCfK9xtatBLpRQh/0YiHwllnBkqsAAKKz++te8pZGP3HcTyS0ZFN4/C
	XTmUofJ1Qo+kwrI0GrazKJRrchlE5WsP1i84GnWYPA==
X-ME-Sender: <xms:NUm7Zai87x2QzJ_ZxcFzyxgAJTyPtzl9dy0O8UPn27lg9EMwlJOu1g>
    <xme:NUm7ZbBfaAX4OXlGNq5QZvejoZwn6KbblQnLZNq4vjQsfw7c_DSjR2hVxVhcnzTtl
    yFMKokmbmvrrAoxlQ>
X-ME-Received: <xmr:NUm7ZSE2CeHtXLX-AnYvbguH0ZSwJx6oTfFGe2C6uh4XJTNqJMp2VbB2ferhAiOwfUMhXfb9SBo0OfYrHlQtH7G_Afs7TMIjqrVezepGot3Gyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NUm7ZTQe3eAlh3rxXL2fnfo8S3YWoSF0nzH1ni8Ih2Jbp2BIsvRE1g>
    <xmx:NUm7ZXxYfJN1GMWjYSMuFLpWYw0ACdmRxQR6IbEXDoAqimicmLwwNQ>
    <xmx:NUm7ZR6xpx55nwMTUa6_p9Vdmtr99EDQYqqHqfojY7j_yrEnIZzf-g>
    <xmx:NUm7ZX_cnTu5FFQRpYSmlwpohcQCXUhFV1DikfmPYc7IAdHWDBIcjCIhrxY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cdeb2259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:46 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/9] reftable/stack: index segments with `size_t`
Message-ID: <50dac904e86830aadcd4d3890ef6a0567d501bcf.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/cACMADkbmn+cy/Y"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--/cACMADkbmn+cy/Y
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


--/cACMADkbmn+cy/Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7STIACgkQVbJhu7ck
PpT5sQ//TvpJEJYC5zZbPOgpwdjD/cF/nLR6hX8ALsL5ZxjNSraA/4QzOGV/tNww
AMzO+EYHOYePkfEHaZSX8/9ewSRQn07ZOkwJf+YQeV4wf7oMmbCo+7dYgcaKV+95
51x2IJB08MdPfyt6liHzIRCyzPkzdl0ISLPaZm+h4TZGOpBuc5xrYKdg0ebEHhdN
F7yPVYSWnkiZV9byP3+sX/FM/aZuTr5MNjJ3ZJoI1sy6bv4ZooOWGsUyTrz4oPQt
ktb+TCmNw5Yd6R+ygPE+wDWgluSP85HyyC2JNfHuGXNBygWDkoVFd2Tu2JarUW7J
HBJvM94Ru5nPI9gfXWu9GUmhfv9Ti91f4A4dUjeyBFT+9e2a8zcrMiAG7xVbgQOS
WAR0xTBQWVH9Wd0hZFOTpJ5nFLKH34FCYpXfkHK8cxQ9CWqDqnsoKdcXGVJoV2mi
hBkEH2Nju48e36400PgYcmFtvc4ecWSAadYx1WZl6rPeHjuBWHFkknGz/yL6amDa
ud+Xi8Nw+VZAtQxQ8fll8W7yrIX/TBdVzAe8hFj+SJyfKrN47qJwrKRlGbdqvGKS
kGdC4SFrBSN4lZmtra+L6M6pEH8ZbLF+a7N+3hNTgaMy9nBkiWwqlDkzZoeERcnx
qpo6khbvadkyJABlv673zszW4/b/YuTnjFelFzjti4Rs+rB9aGk=
=jIi2
-----END PGP SIGNATURE-----

--/cACMADkbmn+cy/Y--

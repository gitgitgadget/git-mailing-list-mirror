Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0518026
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863277; cv=none; b=ZZ0WABxTfaI7YKOYIHmdP9dRQYp4I0PLFdbHcdNQdAbGUTsfvFUBGNqooDcqBHjZHDj/WaLmyE0u/z0PpuILQcOfQRywSJwRy3nn0jGUmffVDXFhW+/HalDjK+XINQQSo4Q0S0oCzZq39rI0Lfl4ePEyPYK6WhrFyb2r9g33jvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863277; c=relaxed/simple;
	bh=XEWq3KR9I/V5/i/SDtdq4W8BZ2oOmhqqTWQGG5klV20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8IRRGgWS/6lE/ME/jwfrOh7EMW3qoP2hsy2tD23IsLTrFiQaOSj15RSA7pSx2bgzjoOdP+fI0M2qYs5DftQC3Vyll8DV3GGVld+FOdTqGsXmoesZya80hUewU8EckK34LgUS5VXquDkpwUSS/pqYkbMEjpagtKgQ6BA2SSW9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R13E3kpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qs/dNvee; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R13E3kpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qs/dNvee"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7F599138FC9F;
	Mon,  5 Aug 2024 09:07:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 09:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863274; x=1722949674; bh=rBvmoj3Swq
	YFoQXdXyqaVU73L9bpPx2rG2VK8oiciPQ=; b=R13E3kpBgWTc8uOJgcJNFrOzMl
	Jev9JCtejiTDhOpV1xpxrV3WnRXpJeqKKYFJuDggSK8BRa6HwME9OgaWn3Ycgd/x
	tB9S8LieTMcvBTAKGWr9O0R6WpHd87oXuN2NcV30hhIodCY0h7aeMqyt7gUL7ygH
	w/fi2W/phZFShNSp0sl9vo7ER5blu4wS0JwWpepQ3slfrG2y25JQ82kGXYZfl1iP
	VU0z7fuZuoBd+Nvwa2wkWmG5KGL7CRAvPb9357hHdaF1vP99FM8Dmz0wh/VWEX0n
	c3qijhXT4GM9FNVSRfLUGPEPpGKjOWozUDG8SICE20bxLWwjYDyy0nnR2RFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863274; x=1722949674; bh=rBvmoj3SwqYFoQXdXyqaVU73L9bp
	Px2rG2VK8oiciPQ=; b=Qs/dNveet+GWwrE5ZTtZA1z7rLVMytKSOi+h+jCWqv3p
	PkFUxth0lWW1IMXdLBvTx4IZlHaRrWKY+gXNoWgY69g2KECeDZql4vG9HOe86Zz2
	Fdt++UELTWFHQ3h39IRL3WIoBXVQX13wOGvd1TmcWzJJD2wZYOHItpCkpDji+qjV
	nQs10eNJ67aKcSgVf2Dp/D5HXZkgtpxDlIdfrjwlykZfrtVfVsSm2yhyN/tQVPZu
	0ftraWWA5MWGiTQO9BjLzxMCiT+PtMcws9C2HQiXKAOmRvxusvSCm5CW9/TMhOxt
	TbgFME453j2syMy6iUjXPr5MJXxxHbdGlCvbOuTt3g==
X-ME-Sender: <xms:qs6wZkSQr3duI9Vc2R35mGha_90K_STBjR1jQ3zI3aNpNfqR6Eoqtw>
    <xme:qs6wZhyhA_DXBEOEash60meObASMPK_fVShVaDtvdNAeZovH8pIpFFgTxlv9iXFS6
    Dq2l2GR9ZmIMbfutg>
X-ME-Received: <xmr:qs6wZh0ZeznskGqbgJkZvUlf44hfN4m9l3av13CSod94V8O6OTsuyb2clh55NwIZIQQBE-hiCUa9LL7HfNQWL0ejWkXpPKiEHuvcWXqKR2LjkBDoXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:qs6wZoArmaO7I3t9vtybDDkkPPIS3NfOyh4Gf4BIWsfEAAE1hIn9hg>
    <xmx:qs6wZthJkJtPjUdjcp5RhPPgUgXu9XXN1_dVNLN6jPOROe_zHSDUlA>
    <xmx:qs6wZkodzsJPjDrLgX710Vq-rh_7bFpTYH5fyuHWaJ6B3qnbahGlGw>
    <xmx:qs6wZgiG6L4MFrcPhY6-QfKIvhrny6iUaZJLYMCqu5Tdh0s_8FqI-g>
    <xmx:qs6wZisiHTg-HtsKOtkhD0yf5FDYq94euX9CtMXEn-AmYp0TVGOjCvM5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:07:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d0a281f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:07:53 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:07:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] reftable/stack: extract function to setup stack with
 N tables
Message-ID: <ff17306cc03865bbf3f673079e7adc158a8c884b.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DVsLwVix6hOlUuac"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--DVsLwVix6hOlUuac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to add two tests, and both of them will want to initialize
the reftable stack with a set of N tables. Introduce a new function that
handles this and refactor existing tests that use such a setup to use
it.

Note that this changes the exact records contained in the preexisting
tests. This is fine though as we only care about the shape of the stack
here, not the shape of each table.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 60 ++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e3c11e6a6e..61dddf7f69 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -109,6 +109,30 @@ static int write_test_ref(struct reftable_writer *wr, =
void *arg)
 	return reftable_writer_add_ref(wr, ref);
 }
=20
+static void write_n_ref_tables(struct reftable_stack *st,
+			       struct reftable_write_options *opts,
+			       size_t n)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	int err;
+
+	for (size_t i =3D 0; i < n; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D reftable_stack_next_update_index(st),
+			.value_type =3D REFTABLE_REF_VAL1,
+		};
+
+		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
+		ref.refname =3D buf.buf;
+		set_test_hash(ref.value.val1, i);
+
+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+
+	strbuf_release(&buf);
+}
+
 struct write_log_arg {
 	struct reftable_log_record *log;
 	uint64_t update_index;
@@ -916,25 +940,11 @@ static void test_reftable_stack_compaction_concurrent=
(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-	int err, i;
-	int N =3D 3;
+	int err;
=20
 	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
-
-	for (i =3D 0; i < N; i++) {
-		char name[100];
-		struct reftable_ref_record ref =3D {
-			.refname =3D name,
-			.update_index =3D reftable_stack_next_update_index(st1),
-			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D (char *) "master",
-		};
-		snprintf(name, sizeof(name), "branch%04d", i);
-
-		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
-	}
+	write_n_ref_tables(st1, &opts, 3);
=20
 	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
@@ -965,25 +975,11 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL, *st3 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-	int err, i;
-	int N =3D 3;
+	int err;
=20
 	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
-
-	for (i =3D 0; i < N; i++) {
-		char name[100];
-		struct reftable_ref_record ref =3D {
-			.refname =3D name,
-			.update_index =3D reftable_stack_next_update_index(st1),
-			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D (char *) "master",
-		};
-		snprintf(name, sizeof(name), "branch%04d", i);
-
-		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
-	}
+	write_n_ref_tables(st1, &opts, 3);
=20
 	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
--=20
2.46.0.dirty


--DVsLwVix6hOlUuac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzqYACgkQVbJhu7ck
PpTbSA/+IfX7X1cZBbB1zqLe0x7t50Nzr5j0n2V1233kD2aoBW2iFyY1O+pPHm8W
4M7Gz2XAcH2b+OXZpNHZJBNA/F3Egp1vGYPz3IIm2MQHfzKjNWJoDJG2QDXYoMPw
L8eLq/KPibfOfEewYSHjO8JtqN0aeerjEL9WarivW+/qyLhKAYrUj+2Fg3HSwmWF
Zt60P8VLpPeyT+Pgvx1z9VoZ5Nqg13et7VS/bWBgT8ZyG4lNt+GKHnP9vJvbpGun
9xi55GY1wQx8GFdhotPpaV/+IV9ouACBTogzEZJmEBCZEygXILbAEs3ddT+Dgpbg
we08V/Cwp685Rw8UNvKj8ra9VmYeh9qZSfNpstFklbKJdzNZw/9VzC7ENVoCBImD
noVySpfL/GrBrIH9KRT0G5K/CaHI9ZOCzQ5DU6Kd0Yse8IgsXT+GOtvok+VZNCaB
qzhMl3X5x38jjSyyHyPUQwZ54BmDNLe3TUK008N1mb5ZHpPmMhs3Qy+172aqtw4d
jD8TlYF5ySd9cOCgB3MqfTiq5YXPA5jxUrVJMZq7qhvExw3GHYGLrEm+I0C0tW5S
SO4N+ZCUUUyRVXW2R+ZkQmpEbKPhUZnVeCJYc2xCnPhAc6xrin0fcaxRKP+5NbI9
j+kdFHCmnst2QwIW+/1oRnmjJQIJsl1tD9H5YWwXJ6pgib2DPRo=
=CGC9
-----END PGP SIGNATURE-----

--DVsLwVix6hOlUuac--

Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02C181BA8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095527; cv=none; b=Pm6f9DLOmYhvzVcYlJ7WLy0+8jbOFJlnLxQSMhu4JpSW/DVklk56yFALlNAmGzLCg9+aGrZchj4uIuwyHmE/Goo8R0cioffd67XZiNDHnTETL+GdevgkXvBzTeTQ5k9qkDOmiZASigeyDreyWM8uZCnJQRCN7ynrGiViQBx9l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095527; c=relaxed/simple;
	bh=izKo/8LjFrtfHBdM+CtNa7q2E6IJrluZyK7YpDfrpsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlZVCIVxeaAB9GljAgAT88kklCN5JwzgDQ9K7I709776yZcpAnf9Zs3xM3nD1XxTlBPVkH+8Xs/aqYEUtts77qvxujLQ2sUme69Kp8NmCQ6G0MlcrzDmdRkwJOm5PiztUykT9sra246vWDiI/VGGEoL2haYjYU5Kt3HNT41PVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HXLuo2JJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jn7snU6w; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HXLuo2JJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jn7snU6w"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 302FD1151BE8;
	Thu,  8 Aug 2024 01:38:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 01:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095525; x=1723181925; bh=JWgdp6ENJ1
	5HkbydayKeRFJrQt9lRu13eOSeVTiSvXw=; b=HXLuo2JJANMttnM1AtLNlbj0kg
	Q0f87Ty1tZLhOXSCBeVkaMG0ZjftmdeU/0VjvEJXqcuvPErDpaQDJhiqr1wPxIlF
	W6QDCuqF3D1Esbu8JCq9g5B/WEsOtzfI2pyCnN8XTv66zTkfmvyR1owmfN03BjzV
	Wq3rsjhfhv8izpQ761vSv8SmV1Dkpar5h0JXfSPzsyizU8pBN2qc/ootCeQUhHdU
	ol4sl4bEvJblNqu/UPmshb1IbeEp08DQA9XRvUYoHPrKpRv0i2jLzDkmsdMm/lOv
	Ytu+kxwLJXH3TCROrWRbLFRdystk9itQC3V9Ol941mfs7+HtSaooqMbp+8LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095525; x=1723181925; bh=JWgdp6ENJ15HkbydayKeRFJrQt9l
	Ru13eOSeVTiSvXw=; b=jn7snU6wpk96qEEs5KcGBN5Khp+EvrhD1Q+OF1FPXVVU
	U7CbQYxR3vUZ6LbtQif/BxzD4eeL74oubf9t8E6Psoe8QCbN3hvpd6i+qXtgdTnr
	n1OKkJ44Z+1eMAVlByPUxwkhFtE+swtxfHHCdQTzccxjiEfSmoYoeGQKlUm/ewbu
	CpAIN+6YBeKmm53EvAL3Av4pJVzMvtrYzPKy5VtC79JRv7xJ+/tPD4g4zgJ/WMOR
	YTVMZWhaXJpqDs1DRqeOkv+HHKBcA/ewQ0hyqKUuqw5lK317SHZLbERaj6PoZWGt
	dcvvyaP3ADeEId7fKH1Y7IfXJUDhPecFAij4HgfZOA==
X-ME-Sender: <xms:5Vm0ZmgSOJLfAN7f-KqnaMxbrd324ayfPc3m_UGuPRjZBhgS2frJGg>
    <xme:5Vm0ZnBiPxKQH8f2U-2OlHa2Az8FRpaum6mMiiwR6kwFSDtEWZxXNWbLn-RkR5ZPt
    7VB4nWapMCLI7IZWQ>
X-ME-Received: <xmr:5Vm0ZuHhDY6-vJB7H6eYfjWWItISNlbDIQqMtMaP3queD3snp7tkYwMdyQI32x0lrdUZrSUtZsS9z0-n-IJeX1ABLgyb59GGeUoRooHgcyP8cNZq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrh
    grlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhr
    tghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtg
    hpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrshgs
    vggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:5Vm0ZvS-KJNgUTPBgoJvrL-hRF_Rqshs5YRo4E5OGQ3SXyV7vGlO6g>
    <xmx:5Vm0ZjxKHCHJJvX3e_aPR_6f075klvaFIUsRNRikHpGqf53mLQLkpg>
    <xmx:5Vm0Zt4f9Hue7CbEJDaC3bpQudICBZcbsx0wwMbpXoXUJKSyoXU7Xg>
    <xmx:5Vm0ZgyX2HIfBvl_AVCj_6Xt-Jhe9YDUfme69I4UoJJyz0_6ZUiu2g>
    <xmx:5Vm0ZqkE7R7aIZ9z4_VUzKKr76knu2mt8lAhF4ahVrFC_J5THqsn2Amf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03f099e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:37 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 7/7] t/unit-tests: convert ctype tests to use clar
Message-ID: <f423b01c05586930a7f98e84f37b1b0d87d0a3f3.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cEIwUSHMAzyv6Wu0"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--cEIwUSHMAzyv6Wu0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert the ctype tests to use the new clar unit testing framework.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  2 +-
 t/unit-tests/{t-ctype.c =3D> ctype.c} | 71 +++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 14 deletions(-)
 rename t/unit-tests/{t-ctype.c =3D> ctype.c} (71%)

diff --git a/Makefile b/Makefile
index ec90b8ac35..fa7c540bc0 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,13 +1334,13 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
=20
+UNIT_TESTS_SUITES +=3D ctype
 UNIT_TESTS_SUITES +=3D strvec
 UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
=20
-UNIT_TEST_PROGRAMS +=3D t-ctype
 UNIT_TEST_PROGRAMS +=3D t-example-decorate
 UNIT_TEST_PROGRAMS +=3D t-hash
 UNIT_TEST_PROGRAMS +=3D t-mem-pool
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/ctype.c
similarity index 71%
rename from t/unit-tests/t-ctype.c
rename to t/unit-tests/ctype.c
index d6ac1fe678..311df3a539 100644
--- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/ctype.c
@@ -1,18 +1,12 @@
-#include "test-lib.h"
+#include "unit-test.h"
=20
 #define TEST_CHAR_CLASS(class, string) do { \
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
-		for (int i =3D 0; i < 256; i++) { \
-			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
-				test_msg("      i: 0x%02x", i); \
-		} \
-		check(!class(EOF)); \
-	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
+	for (int i =3D 0; i < 256; i++) \
+		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \
+	cl_assert(!class(EOF)); \
 } while (0)
=20
 #define DIGIT "0123456789"
@@ -33,21 +27,72 @@
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"
=20
-int cmd_main(int argc, const char **argv) {
+void test_ctype__isspace(void)
+{
 	TEST_CHAR_CLASS(isspace, " \n\r\t");
+}
+
+void test_ctype__isdigit(void)
+{
 	TEST_CHAR_CLASS(isdigit, DIGIT);
+}
+
+void test_ctype__isalpha(void)
+{
 	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
+}
+
+void test_ctype__isalnum(void)
+{
 	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
+}
+
+void test_ctype__is_glob_special(void)
+{
 	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
+}
+
+void test_ctype__is_regex_special(void)
+{
 	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
+}
+
+void test_ctype__is_pathspec_magic(void)
+{
 	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
+}
+
+void test_ctype__isascii(void)
+{
 	TEST_CHAR_CLASS(isascii, ASCII);
+}
+
+void test_ctype__islower(void)
+{
 	TEST_CHAR_CLASS(islower, LOWER);
+}
+
+void test_ctype__isupper(void)
+{
 	TEST_CHAR_CLASS(isupper, UPPER);
+}
+
+void test_ctype__iscntrl(void)
+{
 	TEST_CHAR_CLASS(iscntrl, CNTRL);
+}
+
+void test_ctype__ispunct(void)
+{
 	TEST_CHAR_CLASS(ispunct, PUNCT);
+}
+
+void test_ctype__isxdigit(void)
+{
 	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
+}
=20
-	return test_done();
+void test_ctype__isprint(void)
+{
+	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
 }
--=20
2.46.0.dirty


--cEIwUSHMAzyv6Wu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0WeAACgkQVbJhu7ck
PpQhoA/9Fz8A5VTspuQo2RUIjsiTHhyuWHhm0+DpiHTaxvGyCNZ1BDBXFLk69jvW
3v4j1ssxK23EvtfJRQNCGpzeVpljoA8jXHCfF58UfXijBY2gVFR6+2rx87Rmq08m
3DAnmdnN9V2HYUqmeLKFi6DT6dffYXBdCtWFRFIQtvjB4o7FAm5EZ0r+w5wQuRRv
gPJKi8dBUULxd3MoqXw1txSzwn5zrGiLlv1MKGhP/fKy4zwcdW91XRXDIiCYHsJz
ndWFLv3BcIt8Z59ery9utQiP+1eGDTeRQJeqL0oNnOM/IFjLrF4wWfW5EnNpaVqg
K/5J/N/HM6PdRQhpv7cxj4LiujyEjCHmkuSN1N7UyOevsAjANqr1HN2C5Mu7QooP
jAzSvxMtP5X3fMD6ZDbc8Qq71JZNSH7SPr+SrTDTz1+qjj19YCDOAmdhkuyuUDRC
jIQmzg2ap4ZVJf6HukGWPxI+4tc0mCNuBIB54jeIaKbIKnxAnyhBxrbOkpE0N64j
7+UHzkN6/gBKmpxKjr9droCxH4pTslm1MXiC69HCSx9mcirSeI961hXviMDss3Y1
9zEHwmBlVQyloJPbZjtWh6Br+x1SSNWjckfJu06Ko6GrFAkSp7EYc3wq+eqJnxEs
KwOc6PQNxGuV5Ej7xgtfvxTU9o25OJBbRmp35czNesssE8eB2k0=
=VRLj
-----END PGP SIGNATURE-----

--cEIwUSHMAzyv6Wu0--

Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0A16EC1B
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495125; cv=none; b=nPUwWQYDq3hauKkobXW2Tb9XsPMcib7lPtg98Tlf8JE9ZFWHW/PAc0INH3j59m2kq8TK8aNcwjUzVpmJG5BQGegPJrR+1MrqtfTc7TT8fLDvltJqbJ88+XhLGcxWngRa9qiERjBesuUoOSrUzeqRro3mC/l+tjtVvzajrXtKMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495125; c=relaxed/simple;
	bh=znQJGGa2SA8UDZiTNocSlWnbY7ExW/tygQPr8kfSwQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmyN/T6PDpGWl9zpJGnPFRQKkW2obhmgaFy3rR/xYOukuAN7RWHZsHIOG2E9kLN6gAxDbABynwwdLQoU/Mfx53itUiMuNqU8Rp9clSYpC9GmqRmPa+WYPP7OzO51zw1UxhH6C0+1o9rI4ASdv566CyNoI+pkhIia5vMBUoCzn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fm3SlrOd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S1MwP3AD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fm3SlrOd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S1MwP3AD"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B1D35114AB69;
	Thu,  1 Aug 2024 02:52:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 02:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722495121; x=1722581521; bh=k0AOrBcOPe
	Aiyov226PXP9VprKjGp9HqFQqIag+WpWM=; b=fm3SlrOdoLGNpkslV3FdCoo+eM
	Yq/gdRKwRZpI8nmBpWUcKdReMgjK9F3ICi6EndolAFQVgWQntEnxyF0y1OqAy5jR
	kG3TcR0xts17BQY+jgki+KGYy2uXACcWigh0s80y1gfx+UB9e+1rCyB9LsmJYJJG
	vgXZ5qhaWSB6fgy+lE8ErQpgiM/x520ZauhutKG5T0c4dc10ASGZsfV00h9GFvJQ
	Q7Bs78bmnvZFK6wh+fYkYlTJ6vuZqASz0v608a0xBpyOtAPkRu2eAm+Dk7Phs/eb
	+qZ+mbRC7Zn9zvi3omH/qzhCeyqEgpmiYEx6McrWlTDnx2xLH7GHj9Rv2cKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722495121; x=1722581521; bh=k0AOrBcOPeAiyov226PXP9VprKjG
	p9HqFQqIag+WpWM=; b=S1MwP3ADilqbMyanOxv6CuEi6qHPCG6wtzxBm5vGamXi
	rkqD5PuwdBmKlKnobHMv1N4lGUMf4udzpLd0MmNxZs3KsShiZFuweN5PawY1IAgf
	sDBrTf4EUumJDjpj6h4pe2R2oSUIkD9/rQt/kjx0xBiDWNLOpKyXk1rDjTrV23vd
	+12gV3tIh8Jnmx6vEFcwviEDL2XRFEYV4xSxTO0qgp0mc/VnoovqYf7G4HOWtwG7
	idH7zzFhza00eC2OhSYuSS1exxB5aztTGEz2kRNUW2WsB9SejTvlrU3gPHL3v+h6
	3mvsUOySLj9OjajoMu6UeKpBa0GFNZKINeWghk/QrQ==
X-ME-Sender: <xms:kTCrZugYYWq4ar9fyHEFbvyzv61UDlI6DjXVctllB_yt6ZCHBNvpqA>
    <xme:kTCrZvAmjvU6lKz_w_igppOac6xf6rEQ5EwiosfTVwpoc3Qbpa-Rkfp9APGYZhcuz
    OiYIEAx6gZyjcU7RA>
X-ME-Received: <xmr:kTCrZmGMIkFvict2uDgE19127KW0gs88VmQ-owJ4a19SDaDTOP2ZkQ9yVAOelphItBcXaMiDv2_2ZwjuJ9a1kwYgI8NKS30Lt8wcYe0oXKjztrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:kTCrZnRXJJKA5Qo39tSoNf0xYyNSkPraudbpFjhqiwXiGgLjlcSczA>
    <xmx:kTCrZrw4P1M3x9Tln-F6WQTCNwmPJKWaAHjF2UEw1OANaQA0ESXG8A>
    <xmx:kTCrZl6sGhVEw2YYiMJc9enhP5jKW3ISMz5-Uyuj7IdbHcuDUKHKOw>
    <xmx:kTCrZoxpfdDrvW5XSv8BdD4gytEc-nCD-Ld9gLEW2uYCuzbI8uRjaw>
    <xmx:kTCrZimIZrnQHWFq2e0PmjDMyn5L7TyxAX-5tfs00uFw8NJLcz3BFeAV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 02:51:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a6066fa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 06:50:26 +0000 (UTC)
Date: Thu, 1 Aug 2024 08:51:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Message-ID: <Zqswi3tmX9NCF0zI@tanuki>
References: <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g>
 <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g>
 <ZqdldZE2MV-Pkuu-@tanuki>
 <xmqq8qxkhvt3.fsf@gitster.g>
 <Zqhwwudf-yjvJ_By@tanuki>
 <53c1eaeb-6106-492c-9c44-13a7cd1bd0d0@web.de>
 <ZqnJcawtpzvguxtq@tanuki>
 <85c4f785-de27-488c-aace-c93c2c2a84ac@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PcRMtLB+ZnFVFGN2"
Content-Disposition: inline
In-Reply-To: <85c4f785-de27-488c-aace-c93c2c2a84ac@web.de>


--PcRMtLB+ZnFVFGN2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 06:48:33PM +0200, Ren=C3=A9 Scharfe wrote:
> Am 31.07.24 um 07:19 schrieb Patrick Steinhardt:
> > On Tue, Jul 30, 2024 at 04:00:07PM +0200, Ren=C3=A9 Scharfe wrote:
> Apropos, I wonder how a Clar-style t-ctype would look like, but didn't
> dare to even start thinking about it, yet.

Oh, I already had it converted locally, but didn't end up sending it out
to keep things focussed for now. Below diff is how it could look like.

Patrick

diff --git a/Makefile b/Makefile
index cfdce5770b..ed67feb32e 100644
--- a/Makefile
+++ b/Makefile
@@ -1332,13 +1332,13 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
 THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
+UNIT_TESTS_SUITES +=3D ctype
 UNIT_TESTS_SUITES +=3D strvec
 UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$X
 UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
=20
-UNIT_TEST_PROGRAMS +=3D t-ctype
 UNIT_TEST_PROGRAMS +=3D t-example-decorate
 UNIT_TEST_PROGRAMS +=3D t-hash
 UNIT_TEST_PROGRAMS +=3D t-mem-pool
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/ctype.c
similarity index 70%
rename from t/unit-tests/t-ctype.c
rename to t/unit-tests/ctype.c
index d6ac1fe678..2f6696e828 100644
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
+void test_TEST_CHAR_ctype__CLASSisdigit(void)
+{
 	TEST_CHAR_CLASS(isdigit, DIGIT);
+}
+
+void test_TEST_CHAR_ctype__CLASSisalpha(void)
+{
 	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
+}
+
+void test_ctype__isalnum(void)
+{
 	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
+}
+
+void test_is_glob_ctype__special(void)
+{
 	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
+}
+
+void test_is_regex_ctype__special(void)
+{
 	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
+}
+
+void test_is_pathspec_ctype__magic(void)
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


--PcRMtLB+ZnFVFGN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarMIYACgkQVbJhu7ck
PpQtNA//RhbSaEi8MQUePnlryrbQjplbg5mPOT9igUxfXfnMpEJDnLefNaWggOdl
WLPHQvIcTNEPxq7hWkL4HhpxQ2VVjhbIYrF2DJ2qKVzFemF8x+rATWj5rKQTUDu7
COlek5KSQGaef78Nb7fyQKx+TJ10bb7jW2uGnhPd7NriKGPkkoqGyhjr9tyDzSjr
tb8kDfz9S8AEo3PnJkx79TL28Xx17tU/DR0Qn8KiB+FFkxGiXWVZlEfPxBvCU5+F
gNECCj6TPRP7i/z6df/gSs+Vgbg5E5zUKdSBcCqEsd9mBLfsbdNbFnKfidpgZVIh
6q3BRnvmXLWYKzOhPWd3b4YcbY9hmIwu7/VyzWhpbb1hrKC8gz9XOWFSMsGJ8UMf
TLqmjDbvMs0cmDjSsRpFivOJaiRqRX21aRE7jctro5abm6CqFAtDNdsL/HrAw1WQ
waXxGMf7xx3Uzqu68h5kwY3d7YDR8MrYQGYcuXQevBseNHLUKNknQRDKDXPfug/s
0YCMdYxikBTmGVVkT230j5Kw4XeJZDhaAYlDh5R12Sr9JeMcHVftiSMgPuvWGG4k
XKL8z0cwELA0r5hIS+hqUhXFAqrC6Dd08eWgftZx1glRvInqpAhAYm4ENI2a8NYq
4RTBtIGIGX5J/6dKZSObQtuYs3O2dP6ISAD8+zOkQTLgP8IzFpw=
=GHIJ
-----END PGP SIGNATURE-----

--PcRMtLB+ZnFVFGN2--

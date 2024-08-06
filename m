Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99961BD50B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953709; cv=none; b=eiKh9NsIIu3OiDRoG1NMSx7J1M+m7NPpFyICd86wqheOcPwMN+CjKyFsUpZtP6CCMTBrJFM+/00VwfFo1L7Ami9ti8uKkdDNwmXwU90i0uJ7TznzTDKV2DK4oc1Xbs2xFVZklBBz8OLahAUa/ip2Ziu4GqAi8figltsowGO4kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953709; c=relaxed/simple;
	bh=TCZUJ8PkHQnejbvTwFFOZPk8pq8ZFDayLJDIVRMNjbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyehWlZR9IIoxJTwSgvQZZ4OVwyD52gFCGguaacJkwAHBNCDUf9s8xB/FWz8Q+DwXvrBL7qDRTjSZuO4nphqOX6SJahgA5SeCnzS6IdNS3mR7hpPZJ+rPP294zmlFr6VpJoO9F9tuA2fy+4W5L3UWC0U3WJMzyrGWW7FI5Rb+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VQU0cPBz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtVNvRin; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VQU0cPBz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtVNvRin"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1FA391150E15;
	Tue,  6 Aug 2024 10:15:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 06 Aug 2024 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953707; x=1723040107; bh=mIR+Yf6LL4
	CHjUL/ZjnuzzaFFDTA0GT8kQun/0/x7wA=; b=VQU0cPBzgS0bO3BuncDei+O2E0
	lgm3ajGKkXD39f7KNeu2P5sWreQ8n4PIt7Oapf0QqWeyj/YwP/SK/nIEupCw9GfL
	IQ3NbigBr2GWdrNabhoQp7I8bdEE69ejUcqt+I/1nGMmq3Y0qtRB6r+cd8IE3Fby
	kTkKyC++NPyMDETr6qeMS9FztvqbTQMR09LbHCVUybvd7/bJj6HjNkxyQW+r4472
	VlYUnzwaRWY7+WEzbZzDFmxnQxZ41hEYjsXliheC+HILjfbnB4cb2n71r8TxvRH0
	ZpXWnkzRsIH09lwOxyptLOm1E2AlqBKmUueHGPkzH0//1Y3TKTMTBsA2IKaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953707; x=1723040107; bh=mIR+Yf6LL4CHjUL/ZjnuzzaFFDTA
	0GT8kQun/0/x7wA=; b=HtVNvRin2vLi2QnJWayWg7gfDY4QviIsGwjpNh5Iygak
	SWAjd3K7Ekxv4LWDBUDoR7RjgU4TwpxPkarCk0C1gZqZZqiYh7kXeeLGF4BTTI3W
	Tmq9NgYwILDnE0a9QgtCdr7AtiAIN9QbLgH0I7iMS03ZuzRdmKjvn+Hue8FY7T78
	sTx8iX1bNEvsWh8lNf08hr3c8/HJc0fgbnKGx5atiUIw8QRBeb3jet4BrcCQW71I
	kKPGvJ53OXSQR0EQtcLoHc08ZKLM9uOZ1tDesWUEpKCQNYM0wv5RX5PUjL0mBBn2
	zNJe6XkipOg4WmE3C94N8EiLr5Oy+tgdPiNo/fbqeQ==
X-ME-Sender: <xms:6i-yZlMQ6DX6a95_xOyYv8M1iY8ieV7Vu5vCaNwLWI_CkAoFaVB7zQ>
    <xme:6i-yZn-h88DDuJi1vTu8pS_N-8VefV2T25SQwGkzz1SY4fVmAiLYFRrPrSUipBdxs
    xnoasZbseI6q45x1Q>
X-ME-Received: <xmr:6i-yZkQ1SAXvNjdKZzICqXyJBOl_Ep_vlVW0xkae283-LIhN84VY_Ap7g-6R7ypsNlwyqPw9u9w5MkNUIT_vzHsVFd9QeSs7Bge9uzu4v6pK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6i-yZhsyLXedmgWcYiTwOKjqfq0Rd3Rj0dglhRUayhoZlvZgMhEjRw>
    <xmx:6i-yZtdbajAT-qDt_PdJIetc9WGW6xRPULn62GRQelXTTmx7onrFdg>
    <xmx:6i-yZt3g5sguLkvcGFFSTR0SgyJzdjYECMuJSb6K5f2j77dblGaRAQ>
    <xmx:6i-yZp_drVw1ImmCZpXpe0jjX1Zot14nbx-V6U7xeOvCcmcQ_-XnYA>
    <xmx:6y-yZsz2PsKFmXE2MQkKbjb82-TsfeGZ3oWOTrisRJPIHWSDA3bZ7uXr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:15:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cccb6dee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:15:02 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:15:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 7/7] t/unit-tests: convert ctype tests to use clar
Message-ID: <238de33b9381dceaa8c4175251b3d25c2ef78777.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IzfFCn+Y+HC02+s0"
Content-Disposition: inline
In-Reply-To: <cover.1722952908.git.ps@pks.im>


--IzfFCn+Y+HC02+s0
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
index cf76f9b353..aa2bd5cec1 100644
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


--IzfFCn+Y+HC02+s0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL+YACgkQVbJhu7ck
PpQf7Q//bOgZn+xtbgSbZuJYaHIJA0m3UEKz690PIDtQosPZVHjw/q2nV8c+mYfD
ikpcT/TpFjBP5xGi0hZHBu8koYGTNPG7+F+SRFVFboBSwXxh7LxuoVP9HY+u6fsg
DJj0x2HHHFKvCWR2O81LM+TK+mg9YrPXbbzVsU4VHPaFzPQOEowF0VoO+gJ8uYVk
JkGbr1+rqlBIlZ3+XI0POjZHkBFLQHQ6Pcfzb+sdKHEP7bD8XdJXsF/9183aiHgP
mXuodwhfdo6Ll+dtYMXe2NRXyOjsc6aSCfToY4D7wtKbc6u9cZyIC9Y2xKU7srQs
6ubhzqsqF7CMNS57U8PwNGHUjai2rWLQkpfVzE4aBtfgZa3oohhayau+J+ifTlWH
AJptQEYs1Un/SEFaGvaKvA3b0njhscrcAV3iuCuzs0PFsLH6/jaOPOu90MiHt38F
qK2X10XdJUfrVLxqgNPvn2FKse5WsGE55r0sOGiJTUx9ooe5ouD0Sds+iPk9G+uj
UfG4VNHUGK+81rkh+gJ0SjD3vnFc8EJxa6P3NYa9syK2XFUH8WOnxocveT4HBydO
bHLrOMuK0w6v0QQTaVl+x+MeUGT4K/uaQD4jLSo8V47xiqV2wh8h7xLeVNNL98BW
Inpzw/ya1SPXd9BzcS1dYgFkpLT/eNDfetulkV+MOtmqVLn1n0o=
=GVuh
-----END PGP SIGNATURE-----

--IzfFCn+Y+HC02+s0--

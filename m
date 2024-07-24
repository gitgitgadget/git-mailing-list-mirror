Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A373383A9
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832857; cv=none; b=kGdTdSakn8j8UmoluyZXrCsrGENsvSz/3v3DA6vHwMS1jeZ7sA4AxT+TE3mMLtc7W/JASWYHfqjWuKWbS5Wns3bVTHFcI+SbsYUsmQhFUTk7rk9HoHK6SQl3xaZBmEoCHcs6c9LLxjoBri3xWnXKrQyuKpHNr2gIuO9SLL7hW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832857; c=relaxed/simple;
	bh=io31Oy+5/NlXxIZbQzVmGIU6zi1zoyNKY1/Zc4oPfpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=emf+E2zvzpGRGxrRDyqYKWVsg437beLjr9DBTfbVcA2JfRxCh9P2e/PTCKHI6bKRNY5zW/BxBguDw9IST9c7vISYJVQOby5scm8edykov8acZNzO9wTTqyv4zOOxSlpl0rhKDMfdB2RoP2r/ar3FW60UeMWK9kVMC60Iq+Sduvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=v2NhM8jp; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="v2NhM8jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721832844; x=1722437644; i=l.s.r@web.de;
	bh=LZOyqKP3WaNYlJzJ0ni/WGj1sjbYetLjofukSC3TDFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v2NhM8jpTk5U9NVmjGaZPtGIm1yAnHniSJ1DuZF1W0R1cj6opRD90vx1CnVWUye/
	 EL3oQxT67HYxX5ROsK6pkSgg4ulFELrjSm2XFrZHLbBJoGfU68Ro2LkbecJmwGQYY
	 J2plH/EP4aZbU8i8e7kUJ4UnQ3e9qUmCPQP+8eMAd1DmuUXM54sun1602syG/rMb1
	 3Qf8N1cSDAhbSwBAN7jkyCTJYBW6DG2nqluPjfpDg1QpNbao3RFfOVRsLzeTWK5h7
	 MJe/1z762KOQugRK+ylUNiJ06OXiYMChLr4jbjVPwcBnfKeXyy8FcloJEFvVndQsd
	 Bp5+8J2RvPBwYKbTqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1sLGtm0aPu-00svN0; Wed, 24
 Jul 2024 16:54:04 +0200
Message-ID: <e0485dd4-5428-4b92-8d3d-3cf6cfe6a53c@web.de>
Date: Wed, 24 Jul 2024 16:54:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 5/7] t-reftable-basics: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Language: en-US
In-Reply-To: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BOxviBKN/nDQS1jf8aqrASu5GAjIFL/VnUmObP6g+kwkP2kK+kk
 1qtI2ngWSLjBUyLnV6hh2rC8Hgc+Wl64/Lj6Kkqh7VIc83vPqBZ+M5s17eXYdF3Jw3AJdNC
 lmlPYmS6JBUndTPCuc1oa6LCIrMI8e+WswkgR1DRvhr7kMeyLx/4HA+K/36QLjEsgl97myP
 Ndo0kPm/5HiNqb9v1IDwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5cXWuRkcBVE=;PdIjTEA+p08D8O8CFl/nOa4YhFm
 YUvkqnaSQCXCznewxNYcryxwhrRjotjU387dAfIlsfIni6ZFnGQ3dRz1ojyNB9XbWWKBKaN62
 0EF41L6bv50GRllE1IonNNTHxCl9J9CFoFEVUgOLIpm/3dbAwHRU7dA/ig5zccT7VFp5bRuhQ
 Igrf6a+jysWnhfMJLdWgbI2yssjVKr4Ynqagfb9PBrJHsplKFOcBj5sn1TbTcg127wH6Fomw1
 5YKV7Ao9Ghj3L93AcDw2F3GB9iRaDUOWmG0RqG9EcbURQCHl1id5Wmmlj1I42QsrWTItH38X6
 dqa0JngoOpjbo3Ac4KNjL3i3ojDUIF6mIsgJpEKC8HbsXHwDrM09b3gU2AvROvOeqI1VTsxPs
 D4DUPyJrsHiTl56jDNnSnX9UvVxtPyco4F/tLTQEZ2SikQEPI+gis6LqH14xSPe/pVbPFm2UY
 KBYw9qiOWprlPXtXZtqlUkngR9eMHaaMeTdEaa0aKXy0TyZJefZABSD5zrlEDHvztoAoE9eOP
 8zfbBwBq3GcXbzUJPyULcNPEi9z93Wq4NQ0NUzRc1pmMkEl/n110P3MF3NfG2AM+esPMQ3CDH
 Gk3bXvr+u595ho/ym4tIzss4lAQy2TYcq8DAxHaZLodlJ/jSzFiYkRc0+XSaQPS/eyN3xp4Sa
 eSCX7Xwqbj08M5szCx21mRM5+RYbIHObdFQKPeWprZZl9WNZ6YzPgwfUe+KEAaUZ9n2wF30yD
 TGpo233nHYPD/NIsGOSzBdw/D2ue58nhyoqclhmyO1X0RpVgfIlJXxo+cUSEdGZPPskAP3i8S
 VBFprAwDZt5gWP37VapCupAA==

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the overhead of defining and calling single-use functions by
using for_test instead.

Run the tests in the order of definition.  We can reorder them like that
because they are independent.  Technically this changes the output, but
retains the meaning of a full run and allows for easier review e.g. with
diff option --ignore-all-space.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-reftable-basics.c | 228 ++++++++++++++-----------------
 1 file changed, 106 insertions(+), 122 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-ba=
sics.c
index 4e80bdf16d..eb7af9ade4 100644
=2D-- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -20,141 +20,125 @@ static int integer_needle_lesseq(size_t i, void *_ar=
gs)
 	return args->needle <=3D args->haystack[i];
 }

-static void test_binsearch(void)
+int cmd_main(int argc, const char *argv[])
 {
-	int haystack[] =3D { 2, 4, 6, 8, 10 };
-	struct {
-		int needle;
-		size_t expected_idx;
-	} testcases[] =3D {
-		{-9000, 0},
-		{-1, 0},
-		{0, 0},
-		{2, 0},
-		{3, 1},
-		{4, 1},
-		{7, 3},
-		{9, 4},
-		{10, 4},
-		{11, 5},
-		{9000, 5},
-	};
-
-	for (size_t i =3D 0; i < ARRAY_SIZE(testcases); i++) {
-		struct integer_needle_lesseq_args args =3D {
-			.haystack =3D haystack,
-			.needle =3D testcases[i].needle,
+	for_test ("binary search with binsearch works") {
+		int haystack[] =3D { 2, 4, 6, 8, 10 };
+		struct {
+			int needle;
+			size_t expected_idx;
+		} testcases[] =3D {
+			{-9000, 0},
+			{-1, 0},
+			{0, 0},
+			{2, 0},
+			{3, 1},
+			{4, 1},
+			{7, 3},
+			{9, 4},
+			{10, 4},
+			{11, 5},
+			{9000, 5},
 		};
-		size_t idx;

-		idx =3D binsearch(ARRAY_SIZE(haystack), &integer_needle_lesseq, &args);
-		check_int(idx, =3D=3D, testcases[i].expected_idx);
+		for (size_t i =3D 0; i < ARRAY_SIZE(testcases); i++) {
+			struct integer_needle_lesseq_args args =3D {
+				.haystack =3D haystack,
+				.needle =3D testcases[i].needle,
+			};
+			size_t idx;
+
+			idx =3D binsearch(ARRAY_SIZE(haystack),
+					&integer_needle_lesseq, &args);
+			check_int(idx, =3D=3D, testcases[i].expected_idx);
+		}
 	}
-}

-static void test_names_length(void)
-{
-	const char *a[] =3D { "a", "b", NULL };
-	check_int(names_length(a), =3D=3D, 2);
-}
-
-static void test_names_equal(void)
-{
-	const char *a[] =3D { "a", "b", "c", NULL };
-	const char *b[] =3D { "a", "b", "d", NULL };
-	const char *c[] =3D { "a", "b", NULL };
+	for_test ("names_length retuns size of a NULL-terminated string array") =
{
+		const char *a[] =3D { "a", "b", NULL };
+		check_int(names_length(a), =3D=3D, 2);
+	}

-	check(names_equal(a, a));
-	check(!names_equal(a, b));
-	check(!names_equal(a, c));
-}
+	for_test ("names_equal compares NULL-terminated string arrays") {
+		const char *a[] =3D { "a", "b", "c", NULL };
+		const char *b[] =3D { "a", "b", "d", NULL };
+		const char *c[] =3D { "a", "b", NULL };

-static void test_parse_names_normal(void)
-{
-	char in1[] =3D "line\n";
-	char in2[] =3D "a\nb\nc";
-	char **out =3D NULL;
-	parse_names(in1, strlen(in1), &out);
-	check_str(out[0], "line");
-	check(!out[1]);
-	free_names(out);
-
-	parse_names(in2, strlen(in2), &out);
-	check_str(out[0], "a");
-	check_str(out[1], "b");
-	check_str(out[2], "c");
-	check(!out[3]);
-	free_names(out);
-}
+		check(names_equal(a, a));
+		check(!names_equal(a, b));
+		check(!names_equal(a, c));
+	}

-static void test_parse_names_drop_empty(void)
-{
-	char in[] =3D "a\n\nb\n";
-	char **out =3D NULL;
-	parse_names(in, strlen(in), &out);
-	check_str(out[0], "a");
-	/* simply '\n' should be dropped as empty string */
-	check_str(out[1], "b");
-	check(!out[2]);
-	free_names(out);
-}
+	for_test ("parse_names works for basic input") {
+		char in1[] =3D "line\n";
+		char in2[] =3D "a\nb\nc";
+		char **out =3D NULL;
+		parse_names(in1, strlen(in1), &out);
+		check_str(out[0], "line");
+		check(!out[1]);
+		free_names(out);
+
+		parse_names(in2, strlen(in2), &out);
+		check_str(out[0], "a");
+		check_str(out[1], "b");
+		check_str(out[2], "c");
+		check(!out[3]);
+		free_names(out);
+	}

-static void test_common_prefix(void)
-{
-	struct strbuf a =3D STRBUF_INIT;
-	struct strbuf b =3D STRBUF_INIT;
-	struct {
-		const char *a, *b;
-		int want;
-	} cases[] =3D {
-		{"abcdef", "abc", 3},
-		{ "abc", "ab", 2 },
-		{ "", "abc", 0 },
-		{ "abc", "abd", 2 },
-		{ "abc", "pqr", 0 },
-	};
-
-	for (size_t i =3D 0; i < ARRAY_SIZE(cases); i++) {
-		strbuf_addstr(&a, cases[i].a);
-		strbuf_addstr(&b, cases[i].b);
-		check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
-		strbuf_reset(&a);
-		strbuf_reset(&b);
+	for_test ("parse_names drops empty string") {
+		char in[] =3D "a\n\nb\n";
+		char **out =3D NULL;
+		parse_names(in, strlen(in), &out);
+		check_str(out[0], "a");
+		/* simply '\n' should be dropped as empty string */
+		check_str(out[1], "b");
+		check(!out[2]);
+		free_names(out);
 	}
-	strbuf_release(&a);
-	strbuf_release(&b);
-}

-static void test_u24_roundtrip(void)
-{
-	uint32_t in =3D 0x112233;
-	uint8_t dest[3];
-	uint32_t out;
-	put_be24(dest, in);
-	out =3D get_be24(dest);
-	check_int(in, =3D=3D, out);
-}
+	for_test ("common_prefix_size works") {
+		struct strbuf a =3D STRBUF_INIT;
+		struct strbuf b =3D STRBUF_INIT;
+		struct {
+			const char *a, *b;
+			int want;
+		} cases[] =3D {
+			{"abcdef", "abc", 3},
+			{ "abc", "ab", 2 },
+			{ "", "abc", 0 },
+			{ "abc", "abd", 2 },
+			{ "abc", "pqr", 0 },
+		};

-static void test_u16_roundtrip(void)
-{
-	uint32_t in =3D 0xfef1;
-	uint8_t dest[3];
-	uint32_t out;
-	put_be16(dest, in);
-	out =3D get_be16(dest);
-	check_int(in, =3D=3D, out);
-}
+		for (size_t i =3D 0; i < ARRAY_SIZE(cases); i++) {
+			strbuf_addstr(&a, cases[i].a);
+			strbuf_addstr(&b, cases[i].b);
+			check_int(common_prefix_size(&a, &b), =3D=3D, cases[i].want);
+			strbuf_reset(&a);
+			strbuf_reset(&b);
+		}
+		strbuf_release(&a);
+		strbuf_release(&b);
+	}

-int cmd_main(int argc, const char *argv[])
-{
-	TEST(test_common_prefix(), "common_prefix_size works");
-	TEST(test_parse_names_normal(), "parse_names works for basic input");
-	TEST(test_parse_names_drop_empty(), "parse_names drops empty string");
-	TEST(test_binsearch(), "binary search with binsearch works");
-	TEST(test_names_length(), "names_length retuns size of a NULL-terminated=
 string array");
-	TEST(test_names_equal(), "names_equal compares NULL-terminated string ar=
rays");
-	TEST(test_u24_roundtrip(), "put_be24 and get_be24 work");
-	TEST(test_u16_roundtrip(), "put_be16 and get_be16 work");
+	for_test ("put_be24 and get_be24 work") {
+		uint32_t in =3D 0x112233;
+		uint8_t dest[3];
+		uint32_t out;
+		put_be24(dest, in);
+		out =3D get_be24(dest);
+		check_int(in, =3D=3D, out);
+	}
+
+	for_test ("put_be16 and get_be16 work") {
+		uint32_t in =3D 0xfef1;
+		uint8_t dest[3];
+		uint32_t out;
+		put_be16(dest, in);
+		out =3D get_be16(dest);
+		check_int(in, =3D=3D, out);
+	}

 	return test_done();
 }
=2D-
2.45.2

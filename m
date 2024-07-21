Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CC443D
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721543058; cv=none; b=lJ/b7cHJFjeNk58sr5/Qe0qj6baQGyItrka+cFxIlnoxyx+cF0CejPDdb1qHalVcNDYbhZudZf1AaWAZ+CT5BqNdArVEdYT7bxp4chfzbrnLenh4fo6LOfB/r8Q2LmMqjPw6CkDOJCqXhVnyHn/62WE6cBJkRVtbL7GcxivpdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721543058; c=relaxed/simple;
	bh=io31Oy+5/NlXxIZbQzVmGIU6zi1zoyNKY1/Zc4oPfpg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NBNed+iP5aH4sRSQp69o1CTqxoeN03yOjl/hvk+txbTU6RVKyZM2HkNhoXQIde49mRBvW0koTRr4VVrMGoZxA9BSycmskHYxwKk3UAI4e8UNv3u8sNz6XrPzB1TJCMYcNZQgGgB7tXJEtiYWI0fQsX59E5AKO5c/mL4poCaM1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bxjqs2/B; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bxjqs2/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721543039; x=1722147839; i=l.s.r@web.de;
	bh=LZOyqKP3WaNYlJzJ0ni/WGj1sjbYetLjofukSC3TDFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bxjqs2/Brl3fSei6zhf+IE8iO8OwhoxNHaVOvIhzkUQ65GFtt0QCAtg0Htwfifxv
	 rGb65+pt2v4opPCHwMl1MG1pMp6IGJ6r7W95KPgwy4kWLpnOMmlYa/PRLPHbp35e4
	 sGcdhRVO66PkVXtAo8g85QL4LUdtQCi/6glsuSgBQYyyLIeTG+vfE7ss9Qjq3tFW1
	 JxkJWAOsrqT0ZPIezwmddX/eAoyo8m8AaJrqARnZScF2E8AQS3JKvvmxIAKSa/oeY
	 YZOAmDRd3wtpU1813/MrY1hqGs0bryx47d+myn48+0RTUHiM2UmLT681I4YU7GQKK
	 ZVCtMDMHyjDdMkUR+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1sYhlD2YFQ-00G2Xh; Sun, 21
 Jul 2024 08:23:59 +0200
Message-ID: <e048ef54-5824-452d-ab1f-233581711f4e@web.de>
Date: Sun, 21 Jul 2024 08:23:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/6] t-reftable-basics: use for_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Language: en-US
In-Reply-To: <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzNCUUvfwyUcXoPA9I/3hYGxGwxU8pHZC/DK1hvDQKHmy0KXH9j
 a9hmna+AWdalnClJfLPGC6IXVeMuF8iAMLU+HNSaWQrd88zyYfBnYVri9XvyS4WHQFOeGOG
 bpmAWIriQqM0rvmnbxDtpM7nrBkhaJHAHzMRuoswOB5xCTi5a4WnqdGIddbr/vop4pv8EAO
 1+MSooqOQB3ixOnkfV5Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S4LsU8K9n3k=;s9HuJ+jOJqx/8KLswv9V40Y+GKV
 jkXz7YVe+fptWwGtkyg2oqFTxYRamKurUyZnwJW/C5dCND+d8fYpKWwYkn/JSOok8CAVagAkp
 WzM9CEPWIKNd+QnOhb/ENXnsp/Nev1GaGunjwNVlQfO1g9aidlRJ/FhfUkItwqUPl51qBzmri
 JChryUtU5OhQSxyP8VLlfGONuGxBBfbDQm3WY24xJ2NKJoG4X85WjWAifWv1NLQccsJ7e9P7D
 fTaDXOyjfRHlT78pYqW/LaXibiVLJVwCyWDwMlpG33vtEfp1i/f+tlL5cyzH4RMNlD+BlUX0G
 5kgqmBj4k050fuQMxS5A6QYCcCUpftE4zd95D2QnlIjVWsdijvXJN2wCPMmCMDnSs3x74wBT5
 sQ1zbKS+fgG3AL87imaIFlgJ0ebtTWG4+P9vdND1mUmq+GQ8lMwOAG/zIOtMtT4VDayzQ6jnr
 alroM3kC2Lc1rki70LmVCoZZ+et0TqgSsSL5tn9DLtbewKb5Fz0W84gzw5sw7t/DpL/4emlpS
 QvJtDWUlLB16cCHfXpu8zuVWyNZvcYusQCzElpcyzI5D+K6jLy+WkLNat95XnhtRbsNCz/egI
 sY950LmyjGu5DB3JGq8/DvSlNhlUx1igLI6DXRvoU/CGdVtfFvuDDNGrprFlIsUpSGQCyG4F5
 b6AHML4aDeA6kASbZ7JgPOB0Kko5oxYjdk2aq0vzo1zfI0nyu38XMGAm8KXGxzWdOMAxONcXF
 CBT8pbIL0WGFwqnE7476zENXziWp0AcwGHuOREzE81aV5gSEF198LODxDXilNXgShFe29S25c
 b0V/4TARQm5jg00YV3/Z5mbw==

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

Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099A4C99
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675967; cv=none; b=G/+ZjRIo27D8VnuH8xAbXtiiGTfBtWRmT4tBcit3jV+rN1mjql6xVnerKvDbgyHg5crrYplpETAf1fw5tX+uC5+agShOqnxIWe7eACLtiKjttodLrKKNAxlhYULTuAqumu0ObLhcrT/eN1ENjF1WLK7kK70MHzI9ZB8tpSHcr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675967; c=relaxed/simple;
	bh=rDPD7D7Zh9lnPSvgNjKMiDIMFezZXO7J6Hh6Wi6yDmc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GmHBtteWMLZQPYT7U2wmVmzD+8IyGolSPio7HjPZ6pwlt8S3PBneHlq2Bh4h2sV0vQyw7ZEFfjTp75GTz8vhEsksxcHK39bBjP9TRoZh6PYjKy1LmnUZ0cVqF+Ryk07uiQLw4CoeJZnNT4F8qDZns5u/hSWBQVKgIOyUmEhPaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pJhhr18I; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pJhhr18I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719675956; x=1720280756; i=l.s.r@web.de;
	bh=AWTi6rLJAjnB2ZvDPtVywAj7JaK5Y2DAOO16XOlv09w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pJhhr18Is8TVe8eqyGWSvWC5MogT1VENz4jXLWKLb7vzD/ZMC85YU7Sco+lTuQnO
	 IdmcpxQPgS45onWwzCQYsSPOWnZ3lfhx2+C6V04Sp5JHC13zS0S40PXbx/abkly6L
	 /Qzo7WxrgRqjcCk5/nrnw7gOogKKBP4/wSG/PtUOFNb/4mw39BRTBs1XsjLV7Gq2q
	 KUTbDVMqUEPvK92QrwIpLaeehj9xmAsX3yr7FiyNc/49pT6QsCMyxYL4ooGmrKRzu
	 KLOClnjDg1IFu82uq8WBDmnRsAJHcKcg0xsB6PHCrIBFhYlpJ/+iTVbZTfaXeLzwX
	 O9oJgxE/dIB93QzcvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1rxHzo24Aq-00bgUW; Sat, 29
 Jun 2024 17:45:56 +0200
Message-ID: <16223dec-c117-4f8f-958f-bfc407882b4b@web.de>
Date: Sat, 29 Jun 2024 17:45:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/6] t-reftable-basics: use TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mSSRVcEsH8ntGYGRtJU3AGOctxnYRCBkFsSQa3mGLatGFSPrLGa
 ffleUfjgfCAFmyiZMbLUKYa2VKSxkPOkJd0hiRYLdBdXj8BGu0zZpCBBKEKs9hzLIt9SBzZ
 NHshpH8IweEx2HRD9+nnePZvKe3kjcMKP3xJuZ2uOq100RnawI5RcpnE5iYb48vaEcku6uT
 Cb7DnmYLeX4tiBcbfjyTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NPErNEtb4m4=;YfTm/2YfGcdwAJjQsEylF7uUjwU
 kLmL9Ylx/k+aM018EU2kSQrGHBsg4bjrWywH8jqJ6zyM8EwEQksJ/QNTSAq4/Wf1fBu+cAAt/
 70mI/fzoy9sEZuDaye+Vfnr+mEDendasfxodOKPICd0kylXLXQZD7ZxjdRIcyjxCZ+HUofR2w
 PZZ406vtmwM23QiisdyeZram6ezqHod9UulfF2ETzr6IihumFT+QpA6UsYFwasLRLCRmoR05Z
 NkHXZNYhJ5hVSRx9Xhb+fvvNXZRfgIXLTEZXTvhfmFan5syN090CYXE7mxi/+8nYdgp861LuE
 hoTao0cjMnjHJDPVvixyL3OYLZrWDkU6m3tNuddiGCiTqaNs49U4DwYD8flv94YKZ7KA8ZwzV
 o3vdpk63ITAGgKe5DHiv8uRCIlSriZG6qW0WRxO0RRZXNh6Rjmtje5qn0lD4kpT9/AsFwblM5
 UKlevyZsICOxuvrmanizWo7nybP1vZTVgihtlxlMvYFfzJ7Ux9EgWaRxvED8nxbvaOdl/zR5T
 lcRdlCO8zCzLLEdXlvFpoY907km9sLxvW/rstdr4yJqtA0PH2MyLOyyNqpfidN7QGInS7f2kx
 GiCQr8vq76iBPds1Xv6k+O+z6hRanzWQtlxWVNh2qdwmVgDJ5hvqg3P/wBBzJKNrnEGoimdU6
 S8GG5zBmPRkWECdzpXXCaABxuCN+IX0N9Kf13NRo/m6CWjdJ2CEFdclMu/zMFbNPuaRvVg5y0
 TJQjIQiZ7LNHcIN5/2+GNGJqR49WF3UJi+R/gaSrnxE8PbB1xLyMqfHIIqOxJhUFi5H0/o476
 duicSBX062qyZEWqxDiVOaiYu17cigZYU2jYl203y0mQE=

The macro TEST takes a single expression.  If a test requires multiple
statements then they need to be placed in a function that's called in
the TEST expression.

Remove the overhead of defining and calling single-use functions by
using TEST_RUN instead.

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
index 4e80bdf16d..e6e789e741 100644
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
+	if (TEST_RUN("binary search with binsearch works")) {
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
+	if (TEST_RUN("names_length retuns size of a NULL-terminated string array=
")) {
+		const char *a[] =3D { "a", "b", NULL };
+		check_int(names_length(a), =3D=3D, 2);
+	}

-	check(names_equal(a, a));
-	check(!names_equal(a, b));
-	check(!names_equal(a, c));
-}
+	if (TEST_RUN("names_equal compares NULL-terminated string arrays")) {
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
+	if (TEST_RUN("parse_names works for basic input")) {
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
+	if (TEST_RUN("parse_names drops empty string")) {
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
+	if (TEST_RUN("common_prefix_size works")) {
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
+	if (TEST_RUN("put_be24 and get_be24 work")) {
+		uint32_t in =3D 0x112233;
+		uint8_t dest[3];
+		uint32_t out;
+		put_be24(dest, in);
+		out =3D get_be24(dest);
+		check_int(in, =3D=3D, out);
+	}
+
+	if (TEST_RUN("put_be16 and get_be16 work")) {
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

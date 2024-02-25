Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C36101E6
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860458; cv=none; b=sbdNKzylEL5aG4djThlNlpfYXjVbv4+bcSgQnSOaTtzlvE65irlNJ4e8vKwvgl5C2fBqd3pVDHs3kvmiFgznYzAR2F9q1DFxN9sVAEtz2ahOiES8SakvfJnpP6+E5zeqOkWbtwu1Zzo7i1U1aBomiZvAP/fC8oirNN7R/P6ipSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860458; c=relaxed/simple;
	bh=cplDe8+3sbJRXNxyopiCIeGZJKUUvDWSPNcDZLgjC1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3KNNW8rCJMfHJLL4iPL1mzz3QdkvToJ9gXkHjOXtr+JN2fmMkV8y4y3ELnG4Vq6FtuDQml4ywD5i/4a9v04GmtR0bFQ/93/INyqb+m/Mfjq7oEdVw555f7WfFSKOLVk4nXoezFd3XDrK9HhRnxmTOlO6+II3rDudtLSYRUJueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aoFg+ZaF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aoFg+ZaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708860452; x=1709465252; i=l.s.r@web.de;
	bh=cplDe8+3sbJRXNxyopiCIeGZJKUUvDWSPNcDZLgjC1Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=aoFg+ZaFL7DJBBCDW+33VSF/CAu0bRJxAEbhL9NDMihKzVSFgsosVOIzRvdTIEbj
	 XBx94yZGX0ezjuSUcTk/YnFMDWtaObmTmJ+Kcp3/k77uJ+LDGJPjGxRqJua6WxQa6
	 tVxqtQkGtBL/AZCEkeKIcyhUqYeajPSAoT6S6x6yr6TR8glNXUg9pcWK4gIVVXsSx
	 xAZa7WvkwfmgwLTHPP6RMAq7JCJN0MQhTn6+gF9yCUOKvuuGf8PB8EXZDCDf3mzZo
	 GdFeCBGEWTYqkQTIfOc9xQPJmY73etJEWZJOt91ElMNzzacJ3nExUtLDhHmf3gHle
	 F0PNeGcrPkytpDc0rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MHEXc-1riaNX3gEy-00DQQz; Sun, 25 Feb 2024 12:27:31 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] t-ctype: avoid duplicating class names
Date: Sun, 25 Feb 2024 12:27:19 +0100
Message-ID: <20240225112722.89221-3-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225112722.89221-1-l.s.r@web.de>
References: <20240225112722.89221-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:doGiVtemON0tgJW3dQ3OSP7ueAAfMYpWXtBICLZ8MuU0Eqtv4QD
 I9OwjbDG778cS7qmjDM8MkbMA6zFTiOZVRQV6rBotO9fb2MyvQfn+CPxXOOkJ4HFIZ3UKJ/
 9JWAhC4M/SOG9gbdCPT+Tuxlovb1OkAO6J+mv8Qx2CTopbgw40LdfixdrQ+tkbyCS+eUt7I
 V7KI5o4QbkEfMEu6BGaSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dBIwU8Hw4oU=;aGvgLzf2AsNy1grgcDEdCYe1xqe
 4ogpG+xhjF5Yt1PqEJ8FpOJ1M8LNR+coY0hZDMwhn4c5qt/YwaRtP0ldXOeIhjq/CodVyCxR4
 T2jSN5PRUz10677SphQUUaVh+prJRr8nBNsEUsMANxEgQwucxFulZSWO4yHmHhqEgx8VU/jAf
 8dtF7/rnZr+nRHxhRhqtHj7tM7kkSzjQyiZg/sMqmGSQObUXktPMBjkSQamd1N9HBfOH04T/H
 W5D5lXB/7zqJPui7zhsP6Yzf1ehaVLR6Wl+xjqfvs/l2QiHurcF8HQ3Q3aInxLf9+qV6baPme
 qut3N/tckuVlmwpFShAOSARgiYSN9A31r7ASISJv02PzRKIBsoEHJnwjGAMxdQNEUQVGJdeeD
 jTq9Es8zlxgVoz4/gAJ0lXN6uSKDER7yxHc2dsnO4VvVaC1FI8nsVIXy3MHTK1lcHipOWZN/a
 CrInqWiIG7bgA2r5V7M9zdz8DQtBN/La8RiDRl7QbG9G35B/GMGWM9JMgkij4xZ4nG7Rk8DZI
 /mLHaROM2Upsm2ZL8NFFFTx1UIx5LF+4Y4qg+7U9aaqep4YzBn2vqNeuwUTNqZdbMH5UK4pc1
 Xauz+3jhbDiVEx2IAd9OyoDaPbP5ySIo96vN2pzKwFRS7NAioNlzl80Xo4DptnTKmG+U4OXFx
 jzPEQ0w1ROJRpEX3icQ+EXUD+AjRNhAIwKQ4NBOOVeCAKFKOVtWQWB4aQtHLj4RfY9/NgAtQB
 DXYKzhXe/yLzbSGFbs5Qu9lItcaiXzkIqEFmR6iQhnLlyNc358CGxPV9Hj+YWv3thebTT/siA
 U41My2BdLu39CzEJRWE0seHAZGzygk6WxGIu9jgDe2xmM=

TEST_CTYPE_FUNC defines a function for testing a character classifier,
TEST_CHAR_CLASS calls it, causing the class name to be mentioned twice.

Avoid the need to define a class-specific function by letting
TEST_CHAR_CLASS do all the work.  This is done by using the internal
functions test__run_begin() and test__run_end(), but they do exist to be
used in test macros after all.

Alternatively we could unroll the loop to provide a very long expression
that tests all 256 characters and EOF and hand that to TEST, but that
seems awkward and hard to read.

No change of behavior or output intended.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 68 ++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 64d7186258..56dfefb68e 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -1,18 +1,18 @@
 #include "test-lib.h"

-/* Macro to test a character type */
-#define TEST_CTYPE_FUNC(func, string) \
-static void test_ctype_##func(void) { \
-	for (int i =3D 0; i < 256; i++) { \
-		int expect =3D !!memchr(string, i, sizeof(string) - 1); \
-		if (!check_int(func(i), =3D=3D, expect)) \
-			test_msg("       i: 0x%02x", i); \
-	} \
-	if (!check(!func(EOF))) \
+#define TEST_CHAR_CLASS(class, string) do { \
+	int skip =3D test__run_begin(); \
+	if (!skip) { \
+		for (int i =3D 0; i < 256; i++) { \
+			int expect =3D !!memchr(string, i, sizeof(string) - 1); \
+			if (!check_int(class(i), =3D=3D, expect)) \
+				test_msg("       i: 0x%02x", i); \
+		} \
+		if (!check(!class(EOF))) \
 			test_msg("      i: 0x%02x (EOF)", EOF); \
-}
-
-#define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " works"=
)
+	} \
+	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
+} while (0)

 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
@@ -32,37 +32,21 @@ static void test_ctype_##func(void) { \
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"

-TEST_CTYPE_FUNC(isdigit, DIGIT)
-TEST_CTYPE_FUNC(isspace, " \n\r\t")
-TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
-TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
-TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
-TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
-TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~")
-TEST_CTYPE_FUNC(isascii, ASCII)
-TEST_CTYPE_FUNC(islower, LOWER)
-TEST_CTYPE_FUNC(isupper, UPPER)
-TEST_CTYPE_FUNC(iscntrl, CNTRL)
-TEST_CTYPE_FUNC(ispunct, PUNCT)
-TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
-TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
-
 int cmd_main(int argc, const char **argv) {
-	/* Run all character type tests */
-	TEST_CHAR_CLASS(isspace);
-	TEST_CHAR_CLASS(isdigit);
-	TEST_CHAR_CLASS(isalpha);
-	TEST_CHAR_CLASS(isalnum);
-	TEST_CHAR_CLASS(is_glob_special);
-	TEST_CHAR_CLASS(is_regex_special);
-	TEST_CHAR_CLASS(is_pathspec_magic);
-	TEST_CHAR_CLASS(isascii);
-	TEST_CHAR_CLASS(islower);
-	TEST_CHAR_CLASS(isupper);
-	TEST_CHAR_CLASS(iscntrl);
-	TEST_CHAR_CLASS(ispunct);
-	TEST_CHAR_CLASS(isxdigit);
-	TEST_CHAR_CLASS(isprint);
+	TEST_CHAR_CLASS(isspace, " \n\r\t");
+	TEST_CHAR_CLASS(isdigit, DIGIT);
+	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
+	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
+	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
+	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
+	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
+	TEST_CHAR_CLASS(isascii, ASCII);
+	TEST_CHAR_CLASS(islower, LOWER);
+	TEST_CHAR_CLASS(isupper, UPPER);
+	TEST_CHAR_CLASS(iscntrl, CNTRL);
+	TEST_CHAR_CLASS(ispunct, PUNCT);
+	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
+	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");

 	return test_done();
 }
=2D-
2.44.0


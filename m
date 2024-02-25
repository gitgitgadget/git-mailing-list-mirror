Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F99101EE
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860458; cv=none; b=g5x65F0O1bboRqgjNc+L2VdQdl81oENnAHB+QcufqSZFgjdlCt5Wk3k7E2y4N5KoYTMkkuldmKTuvmEgUW2w/kGQJQ+nooGqkNpQdYETTemgCUrpi33H8E3u9WmUQLzhfFyjeY8PZqNGcAXek3Tl9avDGieGQPZKxDWZJhDhLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860458; c=relaxed/simple;
	bh=8komURkiaR9Lmpi+htOmIqA0N8A/Rv9UquYHy0Yf6ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6JN2YUgr/QMGysltQWwJOsz1qU3iNVqh3fNqWuQEw3XJW9l8j4LyfgpfB/AzOH7BX6pcgjGdMztga+G+/zBXmytAj0AV18tTeuOH5ZpQ74s8qglTzdfOm6P0XnUNDNkCd3nYNavyWAN80X8RQ2ZSlAgx7BAsqzzSC47KXSs9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SbwcEzqk; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SbwcEzqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708860452; x=1709465252; i=l.s.r@web.de;
	bh=8komURkiaR9Lmpi+htOmIqA0N8A/Rv9UquYHy0Yf6ac=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SbwcEzqkE83goZpuJegBEsNs2jG7unXlzEh+Ijqx9bgtBMwrLbzyW8Dyj9mxojna
	 3HP9TpGUFSv48EPttGZ0QUhN7FU1MpUlw1hILMuCVJUv8B+W9z44yGph3NDYOrqxb
	 Jv3oCaHDAd5FVAidj9WThjdNX9jwglGPKAd7mj6vDdn+a1t//vmad+YaCw4IpB7AU
	 SoBndj7ssfN3BmuyHuhYHjH0lMBm/niRKfJ7R3lLu6QH3gf/VM8ycF8rY8JbhA2p5
	 aLrVjiIyJ7Eu8wrzyJyKwqTJ2qNyWCphnKHNWCtwpOvsdefrMnZr4frTygkoMJoUZ
	 IjEVPth7AZQDu6nkjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKuOP-1rLIu90Pj3-00LMPs; Sun, 25 Feb 2024 12:27:32 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] t-ctype: do one test per class and char
Date: Sun, 25 Feb 2024 12:27:20 +0100
Message-ID: <20240225112722.89221-4-l.s.r@web.de>
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
X-Provags-ID: V03:K1:TwuEsTkzKDSEOMMh+rWPf3fOVbOkKjj36/u9jZWYw0BUcxUzgEe
 ByVJ6KXJ/W1hrxIYT0ZaE/ZAbRZo/cVHgEll0ANdu5e9He8njY38uxcbO1fkgqK1GnYDKFB
 e0N+M3yvhYtgo5BRl0TVwk4dS2sect7WZueekiz/ftmeSL4G5ciYZxVX8BraLDBJutIkdwm
 0fUWF/UstZA3QzrxHqRWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CTCvJ6E4qR8=;QO3UhwEY64il3Hr8GP89krcfVpQ
 PhBPQQFT/UHKjipH6GMT4NEFaBoVGv6LOvrWrocUcnLDmUSs1McyT6Ii4URFJ2Mz/rmuY5NFI
 o9oxKgWRqWyhwia2OD1Lpfi45sY07B8ipsjfsZZLD7yoYdoP5Wi0lUIwP68ZlaPB4XyZrll9C
 MSt4rPx4R9bBA8UDhlDHtLWc9yWeu8IsupMpLBZiDz5pwH3AxvMOjupt2xV6K0UO7pFCLtAlM
 S/cbGcFSJMcGKLk42s824FtaFFJyTuHLNgkgHxeP9aPkT4+BJrjTSMbfvrIOybWmALIYUbKof
 d82ETv8WwqlXOYCTYg8lRyPZAWmLbvyScttmDs/O6ewUtMGz69eF8etRoMc+bckjY8ETfm7mA
 6hCyctODXcn/jf1xZgrm2E3lwZ0Gb8DP8Sr9zwwWyOzCT8N/L61JIN/FGyzjxzkzYsVntd0xy
 Pw1qisJeSjNdSd2nw26rHPRQl5NwZdK5A9JewER722Oo77HhLs4bX74D5nmErzcZqPX+tz5YB
 +6zWrg4S/3vUMD0TWFtcIlzEgkrAf0xK7pDL5Ds3n6jBqHzHjCcR6A7H2fxyw+5ELCfd1R1CB
 iumMiIaQowN5cL4ZWpbNkyGlZtvNvLBEn/zGE+1schQxg9zU8EMwbYfFb+7Csw24xMFg8oLCK
 r7Bmy/nzIsSg3nz0NZIIKyAxHT5iLaa6HnW8AAlETFXkGtonxhK/eH+x822qV4zK5aZmEKgyB
 XHolRuUq5UBrVjTrW+jATEQAnw2a/mOhSTpRz3VOyDftn/vYO9rR4fXXmmtc2H4bAMW/OV9tq
 xWAdSC9x5VPpImmtGnVO5BYFxNMA/n6Br4Ge0vseridgc=

Simplify TEST_CHAR_CLASS by using TEST for each character separately.
This increases the number of tests to 3598, but avoids the need for
using internal functions and test_msg() for custom messages.  The
resulting macro has minimal test setup overhead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 56dfefb68e..aa728175a6 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -1,17 +1,12 @@
 #include "test-lib.h"

 #define TEST_CHAR_CLASS(class, string) do { \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
-		for (int i =3D 0; i < 256; i++) { \
-			int expect =3D !!memchr(string, i, sizeof(string) - 1); \
-			if (!check_int(class(i), =3D=3D, expect)) \
-				test_msg("       i: 0x%02x", i); \
-		} \
-		if (!check(!class(EOF))) \
-			test_msg("      i: 0x%02x (EOF)", EOF); \
+	for (int i =3D 0; i < 256; i++) { \
+		int expect =3D !!memchr(string, i, sizeof(string) - 1); \
+		TEST(check_int(class(i), =3D=3D, expect), \
+		     #class "(0x%02x) works", i); \
 	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
+	TEST(check(!class(EOF)), #class "(EOF) works"); \
 } while (0)

 #define DIGIT "0123456789"
=2D-
2.44.0


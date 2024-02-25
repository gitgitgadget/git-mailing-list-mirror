Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF228FC1C
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860458; cv=none; b=VINe46kJGeppD6Z5JpIR7Ak6cBC3BghPYQu/SP28R6RWJoualeAU5K8oYaG62GtGFaIdGBgTmhSTSyxazAwBt7rmh38BMMDKHyCzG/qLTI4L2JtNFyb8Z/2dehXzDjV828k434oDaNSNKIHWF/Lk9NisZbC8RrCRgXBoz40fDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860458; c=relaxed/simple;
	bh=CrkFY6UkGwl6MP7KJS6PYC1d6QmOqzJQmeXT/9tQbmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqq/aGJ73dFR4QkJjP0CiwsVqI5vL4jLTlrt0HIpAtmulWLfp5xfX2fX3TWXX1ftlKMMfYK0OApJaCjfRZ5+j8k6wLZ2wZjzoRzPpIn0rmQRklpBWXRtyyFfiHSTe1hCRQ+OZUoeiVnevpZqzdGBGWFFo2EeBoxEhW79kC7eUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=u5DbrjnS; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="u5DbrjnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708860451; x=1709465251; i=l.s.r@web.de;
	bh=CrkFY6UkGwl6MP7KJS6PYC1d6QmOqzJQmeXT/9tQbmI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=u5DbrjnS7muSt096cchJl6R+tBGb50w+WNEayPfsjydY9chtmlOkvvfX25JCC7gy
	 3gfXvacFPsOya3mN8CkiFi+ATb5jjSGhr6uCO2w/CDTJmYEXSCdpJkkWOf0fEnrHw
	 2rmIJYWqfXb25ve6jzD0cZyCLSQQiz7XXP4QzYlsnG0NqVumI4tnGz7P7Wc6XLgNn
	 H0QzOk2R9+Rinb+mYy1U86csVMFtdWhSFtOD0CK1t043OpnrVYRw3yj03dkjrbQ1+
	 uI5fkIGutElAAgnNcLJ2CgaMICzhNorn/aC6n1hlpACgiWc4V1psFAWV9kFSLFXcG
	 7Ls5x7AWiHfEzyNqNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MWi5s-1rOrff2j7Y-00XAEz; Sun, 25 Feb 2024 12:27:31 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification string
Date: Sun, 25 Feb 2024 12:27:18 +0100
Message-ID: <20240225112722.89221-2-l.s.r@web.de>
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
X-Provags-ID: V03:K1:Agw/MSAws2DaOdm09NdfesyS1MqGzXdrH9uK95iXp59f23Dj9YT
 T2/YRKU6gncxMdgxT1FJAlCd9QQJN5P9FX4Ij/66dQsWJNl7SEo7jFrm2BE0ytRRm3IMvFR
 gq+V04c4PHxd1htaTDwJMxFCHXCnuF8hWH6XlKIPEc2dA4y4VEzN5Dhb7FspSEE9q/G3qfT
 QbbrcCOQFEfs93sv7wtQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NvE+9q1eoKQ=;6RqpSSZxmsfxv/9YRjX9tCYYy4x
 uqDPmqsow863ORjERLygvUHTzGnp7eoJn5I6E8xtBPP49ZWw2FxTPFJY3QYq7TnO+AbmQY3DN
 crgGZLeU7gyoCoKWC4mVKuvFIPiTDHHi7GLlRQ5MVLOrzt6MhdiZa++GAy6T5KUlD/FUHDPay
 N43qULxF02vidsHc/Xy1RtRgjXmEDo2YP7tf72+SL48XKVHkjhtJt8J9l4WSTcRM7uRlS+k4M
 Dh0r7lf4WREMy3GKt7+r3mkpbVYx0wdyiQixzlSn0c4rr3rF5hHxCjIjBsDTQev5UnBb6X20m
 u8F1pGy8KjLWm9eYrpcu9X+l7E0mdKh4dVYDW+Ub5cpvOsYg9Qnunr54IJd8QwU0FNt4XdNEu
 OB/BS9dciLEPDitUX7csbMofAIwaWaAjeIg7YQ+jjwIjpvuxu3WafmyA6SAtNE9OHn7ntQewc
 7wS4toDaNVYu+7DOCTQro0Fbph8f7YL1Nj/iljOXFGnVzn18No7NEQELsuK6pMXlsNZUHcs4o
 t83h+IvbxuMAp6ta4a2VSHAaNmM79AE5djEGUDvhKfNTR1QVw28mk9Q6Zt8YA0dcLtkPt/Lt3
 nSDsv3PlutG2Ur7XXBue1AvCqacSjkLmm5nntOsv8KUMLgOOv1US/CFJMxYuHmtcr8g7mVM38
 iK8wVqkG6ARHRE7hEX5rREPncgN4YcLi9wBLKAoid+wljKgwGIo8bA0On0RnGTVwyNttN4l1t
 RcwIhMPBdWLXyAIBf2Uq2UrDSikJETtnmYzadOaAW3pS+TpH9V+LSKMwVputzcFfyJLSc52v+
 oHlPq3CIkD2B+5cznz6tm9b8pce38RKLnSgnn5sCdB8eU=

Replace the custom function is_in() for looking up a character in the
specification string with memchr(3) and sizeof.  This is shorter,
simpler and allows NUL anywhere in the string, which may come in handy
if we ever want to support more character classes that contain it.

Getting the string size using sizeof only works in a macro and with a
string constant, but that's exactly what we have and I don't see it
changing anytime soon.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index f315489984..64d7186258 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -1,23 +1,11 @@
 #include "test-lib.h"

-static int is_in(const char *s, int ch)
-{
-	/*
-	 * We can't find NUL using strchr. Accept it as the first
-	 * character in the spec -- there are no empty classes.
-	 */
-	if (ch =3D=3D '\0')
-		return ch =3D=3D *s;
-	if (*s =3D=3D '\0')
-		s++;
-	return !!strchr(s, ch);
-}
-
 /* Macro to test a character type */
 #define TEST_CTYPE_FUNC(func, string) \
 static void test_ctype_##func(void) { \
 	for (int i =3D 0; i < 256; i++) { \
-		if (!check_int(func(i), =3D=3D, is_in(string, i))) \
+		int expect =3D !!memchr(string, i, sizeof(string) - 1); \
+		if (!check_int(func(i), =3D=3D, expect)) \
 			test_msg("       i: 0x%02x", i); \
 	} \
 	if (!check(!func(EOF))) \
=2D-
2.44.0


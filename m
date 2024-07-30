Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3C1A0AFE
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348622; cv=none; b=R4k0VMmZAMO6kWeMjj4YYySKGWoFXZtio+ZbOHJLlRXJY6l9lQV+2ppVtpnXRahW2snnzXBi9Nn0kLhESACIp/tyk9t68wnLMU0vxHTXPOkw5smISP+2NyIMSxN2Qq7LU2VSTv3Xe3Cex9botmg7fYtYvBg4PlYpUgwKI5iYTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348622; c=relaxed/simple;
	bh=VQuGozWgtncEtWDYDjKZVyjD2Uim76r9Syw/4hbxugU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltKfb12LOjgf5kKaT5B+aeGs2fTwQeS2fNivyVAL0nCY6xVs8Qad8x8BrIArc5MjU3L2fQoO3d5mqfVLfMss/RNxO9NDN1226cSeWGe7i2xVJdDKrwxza1GlHL5fGaobhNTwJB6xQcYb3EB2+dB4XSs7V8igKhfd90O3j8cKjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ggnEke4c; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ggnEke4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722348610; x=1722953410; i=l.s.r@web.de;
	bh=dQJDQ5JWlC4O3nIB5XFWeRb4OOTCHpwa4OP76DXDJWk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ggnEke4cAzlDa4K+JYUlL4/y8LXHDOFufkfzAGzeRz9mRWcMxfmGMVYiNM5f9yHt
	 T3+eb9N0WxP8x9lITcl1qsHpPYw0gdjKumAUkw1Q0nk92dhdLwRdWdfNvZePlQmtG
	 QhOJkEHCki/EXYNUtHmbySSM43q7tijsEjCHcNv8YpRCZj/MGouQ0MJ65HUf2r97x
	 5jqHCy82aJ2H76r90yAZAYDADGRKpQsXL2Qsp7qwcKzvSLJ/Ca1mOFTagDP34KI2P
	 pQYSsuN2TIm3M4HNIppiZrIXa6KJcHnh+l7BLtamsOi07WvnwW9YzJQG0N69bwFlC
	 +/ArtOdXcyWA0clFsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1rpGbS2dwJ-00nqiY; Tue, 30
 Jul 2024 16:10:09 +0200
Message-ID: <d037d4eb-63ba-4d1b-b36b-7ba1eccf730f@web.de>
Date: Tue, 30 Jul 2024 16:10:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/6] t-ctype: use if_test
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, Kyle Lippincott <spectral@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Language: en-US
In-Reply-To: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yWwy2VDQTvGAta3GApoRhYMf+o9WIq5flNDfoOLCLk6KOtuuBiC
 mQ+He/6OaICEorhm61l3IBavGCNntk7tYhwefjCQfxXdU6nx+qw4mfatkVaEkQZ/CNdyATe
 3NsAXhUgsLsxwVejvH8gyZCW0r4By6II1Yc/byeNLeihqdpOcQW5E+gnmwOcfYrgYwGgveA
 Ulu0YSzWsSfHTxtqw1r6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A8H6Hs/0DaU=;qX2Vi4580uBm0DW5KzmRwzJTcWC
 USQT1jpSIrsKuSrMDFtgjefgA4agr9wLuqC85+rYLytSjTJfRNdpQOvZgbsIImvsREKrvbp7A
 WMUsEfY6PGU1ikFo0gslHCS13cCY9dEDiFuiNU7blBxA+i1aww5ZfvmEy/ctdy98GZKiQ2XPY
 6mgMvTa2efKXagdmklXA5uj00uNg5k5aS8M1XaNXdZc4MIB4kNc+zRR8M4zPfUvUXDiaTm7DU
 LWqDSyvROJixf2JX8so5ysZGnvBMRf3wr+ZEIPp35kQdSB6siA+l4CgR7etm1/tmMP4iROyx0
 hZOs5Uui9SHIB15pB1fV1MspN0KGXhws3rMUAhqbq/pacf1E4uDF8Imh+zupctYpJB/sjkMjM
 cFuX6j3O+LjtQlxKmf7Y3d9EQLDPX5+Cb/oXG536YlLFJdxoJ25htPzVQJNjUXqtb1Dgf+mjM
 fy3w5iegXmhzuqW+sANCIbRAVbGaaTOPcsxEzr+0PJjEeARmTvC/1Qdq3220L2WhVp/6GYNpg
 hHG5xpjmWfWTBAg5rUH+nFIYq33zEAcd+0Z4t014x2pXqMzcdE9piKJR4+eWoKDY5z4K5NgjX
 KcyRgyUaLIbwf13C1b1hAsM0+7C4f2p5A2TFE036z3rUk8NxxlLBSoGoIgGhJFZdO2UYu7fV7
 8gWguZ14qIaZWfWRFR7oTIbiyB6VCllANETSeu/E9JptCgHLQjbLSAAxvzRxONdARb1zAyZ9F
 JOIWYRH/kgPF4gXzi4SfSWUP6pG7Jm0SoQI+84A+FVk6egTcBkg53tq81mnG1proxCcbHFwTv
 pmCM9/gCnF0wnvs6+g30jMrA==

Use the documented macro if_test instead of the internal functions
test__run_begin() and test__run_end(), which are supposed to be private
to the unit test framework.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..e28a7f50f9 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -4,15 +4,13 @@
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
+	if_test (#class " works") { \
 		for (int i =3D 0; i < 256; i++) { \
 			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
 				test_msg("      i: 0x%02x", i); \
 		} \
 		check(!class(EOF)); \
 	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
 } while (0)

 #define DIGIT "0123456789"
=2D-
2.46.0

Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C7443D
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721542970; cv=none; b=lMoldUSkPkYRa3ANAdAMs4OzvFl2RNR8YyZ6ZuFoT878QTBM62F+hwgQiQ1lZhOq15I0vJIHmDunVt/WnuL5+IKFeHkaCTOe+TloAOYtlQLlKmVjiwbTKx32hq0PZ6wpCfd1fZCE2szIxrjv1QzrlVyFIRHIGiq7mK2Sxlq8b38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721542970; c=relaxed/simple;
	bh=438lcOvmlew/vUJkbq2Wo+GsT0Zjvn85P8sXcjgd4ew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gzw8mLcBJi7GDrNZlsNvejTZBek2Xa1Be2CJlaF1CyncZznXuTf3PeUKc2l/zSX7OThEsJFEjaLmJFz+bAeUNWjVm9gOqq6xt2Hm3VsRo/YJ33XEyR6qlHgnLy5xdXUxQrzYsplGm/oz1qEbGIGXic9QlewGRL8D7rtV4ij2I5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=TDSq8y3/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TDSq8y3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721542957; x=1722147757; i=l.s.r@web.de;
	bh=KNsd2zaRe+Lni3oRy7QaGElWYVhhLSZsuuFxqqYmBS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TDSq8y3/q4KRcLuBQ7hrPAbwluNTRtBvnTAjvWsrPPTQRixfgP4+2qF248km+pJy
	 +1+BYSwXBCAJEn81WqYnV6hVImet2yhzP6Ty8w7KOYPZt6H1yosoMJKV+9P9QH4XG
	 80TEJvswynJ+KW0N6DSeD4TrWksMjCFLLUJL13bGohOWitqbp2vqLQ8IVd+t7iRKk
	 UvMk95GJ+oLigtRGiFQjDmt93hVHnEdoeRRyj+vePCgJGlMpJE+qmvZGrkr7R0Gsw
	 flLmmLn0HPyOsk+MygHk+Bf+U+RbrGnDApL6xtuhrnJsJUZOAj+ms09w+LM5dETmb
	 kpJx1fuBQBfcwXYjnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjIb-1srCN006YZ-00WYTx; Sun, 21
 Jul 2024 08:22:37 +0200
Message-ID: <d97ae165-988a-4f33-a61c-8254fe138fbe@web.de>
Date: Sun, 21 Jul 2024 08:22:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/6] t-ctype: use for_test
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
X-Provags-ID: V03:K1:CQkCLgtF+U0WYmWlDqV9UIbTdrUj8ktjs5Mc/2KnvSaoUj8PqbU
 0l6mUA/pd9Apsoqb9stxrpCulcpX2FhaluMD3U8TQTIbmlU4GorbyHqfQbaStnnuO+c5WaN
 mM8rGyl/M6AIc5iIl0mTWhN0r1uW1mHWo5wehmOUjsAA6xdRjeOJO+2ZJHr0IORw5dxpHHw
 ab50PBGHU3t5/Umtw64NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3e+OszmtUl8=;fkfrsca39cH/YNJlp+EcgOCu0bz
 hG720F0NFlEZBLS0pmw5I3oPcKCkQ2nqGTM4ki7/J7a5UUj6XKg7kNaToV5TQAEm00fktkA5v
 aPLM6HZQ78k7NZervuS+SlWCDtVHz5rZYpUbYhHgqCDDyqPW2QS+FzxTFasIk1JHvPa5g043i
 hjUTOpeRS0eOaoKsbdmYP2wvt+poYDpoLAF749CO8N15QJc2hXKMIhhj+0BJdEVXCz4RIRe5h
 4eDLat/BTHYU6hqPK1FzCKZ6FrI0TVbAuLsstJ6K1zwDe8+qD8tfC4s5onhLoXW2veh4L2cLL
 +E9V+JnQ7xVe9Tqfjc6BDR3N3nlSuilFC/pEMNg+RlTp5yZfbMTaltce5KryKH2Pem7cxkkCV
 glkn5BMfbnM1r0pO95XaGJs4u3y8i9YwjrwdKOvc+wGTtSs5VVFfyexFnIGpW5EgpUDezIYdL
 wicBzBMCV8Gm3l4KZh5fGqz57fwtdxlnCrHf5fSMP5zYAUwVl6GrIf9e1hnLkiBMzRWekm45W
 QXQD3zRXbar7BgN+hE3SM4XOA3L8ek0LY+QCfsA9hLABx49pVera+t56saPGbbrZv/hSo7Tjb
 Od+/vK9lIvfLzJC+0c0nEDIGdUEsxFkz1UKcGwwZTyTCcPhskS2Tp74HYrXNhre2NJ2+Hbg2h
 4YGZTuMiG9AR0U5PzuwP0kxrgi5BS6Qob24Hum1bynjEovn2hlTCRkZISEwvcd7ejwN7EfkQJ
 3L/MQC/+hrWEGh+iaMC2Um2Q3BhEPhcNSjT9pSarL36ye4TCPge4PIr4+0/QiaS+B5qXQngPk
 9xOTFSpZHO2yNwFxMtijOUlA==

Use the documented macro for_test instead of the internal functions
test__run_begin() and test__run_end(), which are supposed to be private
to the unit test framework.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..92a05f02b3 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -4,15 +4,13 @@
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
+	for_test (#class " works") { \
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
2.45.2

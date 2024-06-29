Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA184FAD
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675869; cv=none; b=HQXgrxmL6Ns6L+BI7tdmXDIU0FF9+sUh70wERaUjJq+xsYtvdm4dODbUPgkM3o3qS/XHjySYPsMd5Iim3ZKM5YxtpodZAP6s//3tcWzGbE/kT1BidOWPJmqXDNRwIXp31hkE0hHaPpOzXOveuUYAAq7ij1JOGwRxNpftNDhExfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675869; c=relaxed/simple;
	bh=iqx0pCWgACmPsxQ7vLGynXXixnAjOjYS4ISm4xml0Jg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aMDFGKOcsDQVxrI++p6WSglc5GJaIzMeyzMikowMe4gavVD/4bPDuO38M1JSSTLeGXcU/6DU3CZZV227n5ISUU1WtMvCa6H7nnGHj90WvKZjHCa9IWD77V79SLhdOthYpkWKKc0uBHVupazxl6D5ZWMysXgnY25yZlZxWYmsZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=c/EYdvhE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="c/EYdvhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719675859; x=1720280659; i=l.s.r@web.de;
	bh=gaGP69e46uktmhFyFF30ONan6Siv+QKziM27MOkx05I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c/EYdvhEzXkxC3So70UN8tuR/g0IadG+uCVBg+Mm8Rym5QuUXSho6+zd7h9diMMR
	 Zeh4KA6ySHAk+ieSMtNqJzhGOMeFnisjgX6WlPYwgogcjrJpWiWLkdQdCqQVqk8iP
	 FXl52VhEdfHQzIxGhcuuBdsOFOPwd+SopDqatN4xGgdVrhimmxn1V+n+XGWWK01IT
	 TADwxpgPfNYb2HUJnK1hVT3YtGgt+G8zsYymL6YC6Xn6qgfDqTGS0z3Gee0b76bqB
	 UKWfAh2FWLMnbZ9Laer0CkVQnZTNc1Hmuv0SW0LvTOG1rDOpQ807UUDy7uu5Ivbzx
	 nnBxmISeZIDvN2G/TA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1sMfSp0lTw-00wfAa; Sat, 29
 Jun 2024 17:44:19 +0200
Message-ID: <abb96bfc-ed97-4c8e-a99a-0dadce45398e@web.de>
Date: Sat, 29 Jun 2024 17:44:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/6] t-ctype: use TEST_RUN
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Language: en-US
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V42wwa8gA90Eaui3oJ1UMupleU+WcM+JpoisQdLRcwCA35gvHig
 EF0Iv4FxzaDf2QXpGlqUwbqSnxDmaGpVdwNrN1hMVkZiYWJXHtOJ0Uy9lVJ2J4YS0nwtSwC
 pE/2vqCRrZRgds8uZOfVQ3jbEgPOzsmf7KDw+M3jiRsk2WnM1GyC6D9s7LHiGE/ql7eVoPJ
 c26+4w0PIvLO8iuY22irg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z/rvNYLlkK4=;Hl19SwDNswem9Paq6K0nNy/jwHu
 6dk3pFSjJaDbhCGij/OR7Sq6sqyPZk77OT6bW1vtGZYKsUFLwVAqdJq2nlsZU3uWwcZtxHauM
 8ymxzz6JFZOdfW6s0lPPCRtpL8olPeZX2rNgl9Z5wx5QV4BnCBzTDoEDqGsGVYLcSxb+RA+0d
 GMtaNMbd/XjLCpbqnWDkGMO1zeVa5FdsZnLcgoE5fPXQlCwOGY4KPgPRNa1JlHtn8GoAN+cmQ
 Cpb1fWHesfnpjVb25dUHF+NK7JcCpRSO6f301SZC0UFlzPpt/QgSUq+d0sJ1Pr+qn4p0tBO5Y
 BkZKhsHyEct9iLOGzn2S0A/2FlohyGu/VFfQCGQxxYnSXUS6i0Hg8jQYYd+9LnT0llyZZan+e
 xcR1BS3T8mgqMvDz5HivlgLD0J1Q5iwjQR4xnchu6TnhcTk+OPs9aJr9XLWJV+GRUfbufu2IZ
 HP0baO6z27rf7XKARjrY2koz3p2v4Ic1rIGupNy8+XciHI7r8wCvTEVMcST68dEvgLIquxBwf
 h6V1OlLtT4RAGqV+Et3/RE+9Vn1nEcwloj8ESHZ7s3X8gjKMAEJFIWiaqYppyYhEHebmoSeTD
 HLInz1XuACsaELJyJ80R7lfe44On9cDKeLZ/US6pX+k6z6td0zBFnb5zbBuMuiKNLHXZHLaAN
 DwQLxKzrDSlIQ6FrGd5Gt6w2Jg73cLbXQmAMeqddRN59kHM3UltRBLFNrGgytjN8RLEbIWkjI
 h+XCkC5yStoH5iymtNlwB2aiUMlK+EBsraowJIPWjn04BXiiYo3mM0JfU/Cik8n92DVAB27pg
 avB7mpEE5DChx1sQ6HE0XhDArO0/LCicJKtRJHagkbEzs=

Use the macro TEST_RUN instead of the internal functions
test__run_begin() and test__run_end().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-ctype.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..04a66dc105 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -4,15 +4,13 @@
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
+	if (TEST_RUN(#class " works")) { \
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

Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1141C67
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435890; cv=none; b=ifU8hm0e3l311A44QMl1+2J1U7tftR6tSIqdAYmZ9bzdZfm2h8OoWL8rJiz5nM/U2sHbP4x33tL/PgX4KbQeBmn/c02k3WCJ+jPxw5Q8QTIxqnxtA18+f4NK/yyu5QpX6Qqxb/NaEen1TELRD88h4I1A7DjUFlJIoHe+6h81gnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435890; c=relaxed/simple;
	bh=P7sq7xrb1Jw67hi8jtjDAB9PfCH4tv45f4KafnTS3xU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=gKycB2zzK4RyhEvHG/B5zHzRTJ9yFDcNqQ8Lm8qD+QNavSGixqY6o/luxH5z7NYcY/zeos/64fua+95K7AsfowRbdyG9bgFUsVBp+wVcr0rCOThNr01G+Rzhxjd4rP4urXfSb6gF1orSvKm95L5DZLNm7P0HFJ1hjG4llFfk8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CVDeTEA+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CVDeTEA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712435876; x=1713040676; i=l.s.r@web.de;
	bh=B3RvkvPkbjo087rv7GZ9syTaRx5CoKFVvEr7gD4hgV4=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=CVDeTEA+nF2rRzNgD5Qrb/MnWmpi8E4Ttx76FPaVkzGKDtK6AkPLuiTCxyvktYzK
	 yG/EjZjf/STuuXsDnV9V8JxBcT46/dKcMSwZm+IM868rXE7/RaHEqQifEieq+GlZQ
	 ukLGLwIY4Aw49MEJO7tbtNkUcl8k6FRZahaWlSjHTTOUmcKYz+vNtDfREOgUwwKY8
	 ZAe0kRcIZVJekmtMT64b79P06fGlkcOahazRufGEizIwB/jXtuJSNaKXScK6nHX48
	 MwY9r9ZFtt81LekydzUcBpepS1iRhTRtIXcVrOilGOkLCF1hwxWCmjUIv1mKlJbTs
	 SL1WQRgxnGZMSIFAGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1sG3Gb0o2n-00VyId; Sat, 06
 Apr 2024 22:37:56 +0200
Message-ID: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de>
Date: Sat, 6 Apr 2024 22:37:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] reftable: use xmalloc() and xrealloc()
Cc: Han-Wen Nienhuys <hanwen@google.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:de/a0te3nUHNHKZzslhK7eXtJ5RYeMk7M8dGlle7fmL8sGLzT6L
 WH5hblCmw3oq02DtWDmitd6YYHlsaxIsnZsQ0leqPAXOlkAoyq9+4n9yuD3d0FwtV4MskTh
 El70EHTjrkgl+afWtm0kqjSGtIZabedLq/jbp7Ww2Ll/MYfIVDpMCCectoYcYnVQuSd7DHG
 wau//JFEDmb6R4Dd/jkQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uBcnCUk4oQI=;iSKRHPmpEi0u3eV5nqIsMo6ZLoH
 lFv4fFER6lXl3wvmyhoTe5zgfX75UpFMtwIbTjI/tuss4NnbUu7SujU/jNj7KXLSmx0CzAGQd
 TxdI+c6ohnhzcUwkonB8sIZss2VN3QHZ4vl+hmLFiJBNe2tkTkYhpwy+7LLtuQuAWAQOItv4D
 R1jOFJ5E/4oYXvX1eq5kIwLhROzKri7n9AKJz2S2MYDxjgWRnKS6wC2x9Slo1EqfbYXYnYY87
 wlHCg04pjtM6xkYvVSSws76ZHP9tE7wQHddb6QfqGFONg+z7iodHcwcxgXUfCOntU9d0uJSq5
 T20r/wqS2NQFndR+NCn15a3MqyYuVcWv/i6XcBRVx/jrWByejC1WkvlfZWtsS4Q5rjuo53rlw
 vLJuW5vtCUtxysjRkJfU04pxvqwsfdtKZLCFEMJKprvqY0/GRc4NwQe4avGw50XDYZAgF5OHa
 lGf0ZjXk8GrSnGphnlEASC8VBC42BsLrrO3Rpos9SEcHT6zGGLUiGSLssTsaIIhEAcW4PYD48
 cZaFhl9gclbVwVam/hjOpp2bjPj+rT1romf0noBMNeTrkObt1nh1NUUbWbBDsAU5Wrk+NtyHL
 3vRFVvQSlNMnBL58aHFWQcdrzH1xY+1XR6Ku+cn7HkOWJgfIzsDXYT4MgmxzQbqE8xuKbZPip
 1fq67d2Q25tT1/bKbyDFZMsqSaRS2pLuCNR3QNpsVNo61OsjPdBk2FoTC1bfLbg0L7JMG9XmG
 4W6HF/4h3OoT9Zr/IiVcOpYejtus+hTl+eG8cbk9r8kYek2wjqoFqstV60TsSP9dxSnJormd7
 Vb6gPFOz9aGuwEVoUiZSdtkbMpei/YYqo6+MlBFn2C0qk=

malloc(3) and realloc(3) can fail and return NULL.  None of the reftable
code checks for that possibility and would happily dereference NULL
pointers.  Use xmalloc() and xrealloc() instead like in the rest of Git
to report allocation errors and exit cleanly, and to also honor the
environment variable GIT_ALLOC_LIMIT.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/publicbasics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index 44b84a125e..f33a65df34 100644
=2D-- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -19,14 +19,14 @@ void *reftable_malloc(size_t sz)
 {
 	if (reftable_malloc_ptr)
 		return (*reftable_malloc_ptr)(sz);
-	return malloc(sz);
+	return xmalloc(sz);
 }

 void *reftable_realloc(void *p, size_t sz)
 {
 	if (reftable_realloc_ptr)
 		return (*reftable_realloc_ptr)(p, sz);
-	return realloc(p, sz);
+	return xrealloc(p, sz);
 }

 void reftable_free(void *p)
=2D-
2.44.0

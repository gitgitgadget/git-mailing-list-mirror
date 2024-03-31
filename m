Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87785146D6E
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711911193; cv=none; b=fIdggggL4+5VVgyuzQZnB+mAth6b7d5VLc5FdX/eJRfHhGPhOwmDJOI47yj4Z98Oqc+Md3Spyme2sN1Fbh0OxpmTpOS15iqQU0XLHkg/v1ApbQxYL1RH0fne9a01WoYzsGQKSkK+4RffDc663SnT6QwSldF+4FjpywHWv+huqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711911193; c=relaxed/simple;
	bh=bMpch+5qpvH5ZmIKbAIb6y0IUBWoexWyS+zmqjVIQec=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YgNOWoHg3d6pjOcENzmVw8BHEmUKTS0YfLMc/R63CtVEuSsZ2qgIsSM5Sn8PaWkBrW631m1lk8yImYTeWzdbLNmCch4Bdyuu7lZWs/oGtp6/DwwYp9YFjhgNHsb9BQKuX6cRq4bcjgg7lIOpOZ82gLYDSv55w7BqOsyuoDEsSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ni8s78qy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ni8s78qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711911188; x=1712515988; i=l.s.r@web.de;
	bh=eivzBLd8ZNZVf0xV4/odW6/+MS7GHO1zsmD/cU/mS/c=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Ni8s78qyI1NSR+27rUhlYtBTeqtJmesiMWlHoBmveh0u/iRtlyJNG6r7UOKvXNel
	 sTzmVbFXY0jk32YtHicuHle5CHPB14gRe3umfS705QDssTYgxRK5uQO8aUrnxpkOy
	 Gf5rBh6akYuGXpth65TOSSg42tqrCQppUQbvzI6scGEhI1ZPnrCKCQtBlv2eHmwXX
	 mmDbVnBaUpUZLydS9wRywsuZTLcxRrUgIotMvrn83pst8zSNsH3dGjWboPa+tWCrx
	 2jLV8SnzFBrqWxTTaDyA3GHsrxOydClTjXUV0+1EQ34Ce9vLdLFjYOLUNC1dI54xX
	 qnTY0cuBI8ODq0sNGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1ruZjf0K7T-008IXT for
 <git@vger.kernel.org>; Sun, 31 Mar 2024 20:53:08 +0200
Message-ID: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
Date: Sun, 31 Mar 2024 20:53:07 +0200
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
Subject: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ajyxNXusKEYN/64wAedlk1fEDSxuOuHtcrV/6A7AyPjGzu3ijpv
 3V+Z2TCqKmPyWOiyII1n5vwfzLSVjN10iIVsh9wAIbwp7TRXNKD4Dhythp5AAUWKSjk1KId
 Xx5Pm1QEv+iX0IvcskRwSJc+Unlunb8aEsz9NIq8uPdA0BCKGCdChhGOJ4KSCQ9j45Oa2sA
 G58FpkTje9F9rrcWrd+WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cm+OCI/6fNw=;MWzKMJ2CSavUBI9htN7EphNHkf0
 E1PUcwv6n5n5BdJVORPT/3P5acJasK8BNZSgjrWLz8afBbzogYNSN8DmVoj2KftioFnBzoQry
 3y7iF0x9VDmgUF8bUDyb8lpCU1l3qwVBnBC9a8PebDT+ustQHH2fA5Gc8QAXis9iYNpDLFiyo
 mzTsnJYDfbVGn01ktZshgaDVx2NSYOM6FwvPF2kGnSd0r/vs3Owo1C2DI6zuqainNhtvF3ScB
 ocNNLDMF3GAnjC0vWzCa5sTjRBGt7ZfWOOtGz5sQhnzYWCHFm929sw9I46U+mYQYZ2I3L8D6a
 g8vOAp/6+EJiMOQNPqAHA+WUQLDSgZseaDZu0X/Zf3oj7Qibk4xkr0+yFS6AVfYvAfvGGqq47
 m4C7DZSrtOm4+2ArS8gPkjmHMj9c3NnfXeA5Ml1HaXjmZLFSh+h+KZYrb4gjX28LGLlHIFEa/
 Adc494jd6K1DB8MCBhz1XzAfg62Eb8OOBPBGzxweS/0AYXS3K+FwtfeMBY451bWvXfk0MVke5
 VPO+Aj5QzKvr7cVnQUSF+J0JkeS5PmgZ/J+Gz5X6Cu8dfrsBebhFC7JLw//5RFNq1bZ7aJxDZ
 yuAoLdzwrT0wFl+pz5sKqEBBHTc+MYPU2o1f0CIh4UvyGnZK13hFnj6qSRYGj1NCcNkCot8wU
 YbX3SP27hYEtmYX/Riyb2ZwWvv5Ti6nratuKZ8jUDkObjbTyjLw8mlsM0+/th16R/7Hru4ed+
 Y06pcppdQw4rxiDdZvIjth15L+SvIyBSHbtqmwdGtaaaGrgLl8CqGmO6EFikmbe2NUofEhNO6
 K4C5zqdKsAV5SkOGGuCggoCm3jjhMYnAF0Avad+X3WMd0=

If len is INT_MAX in mem_pool_strvfmt(), then len + 1 overflows.
Casting it to size_t would prevent that.  Use st_add() to go a step
further and make the addition *obviously* safe.  The compiler can
optimize the check away on platforms where SIZE_MAX > INT_MAX, i.e.
basically everywhere.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mem-pool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 2078c22b09..3065b12b23 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -115,6 +115,7 @@ static char *mem_pool_strvfmt(struct mem_pool *pool, c=
onst char *fmt,
 	size_t available =3D block ? block->end - block->next_free : 0;
 	va_list cp;
 	int len, len2;
+	size_t size;
 	char *ret;

 	va_copy(cp, ap);
@@ -123,13 +124,14 @@ static char *mem_pool_strvfmt(struct mem_pool *pool,=
 const char *fmt,
 	if (len < 0)
 		BUG("your vsnprintf is broken (returned %d)", len);

-	ret =3D mem_pool_alloc(pool, len + 1);  /* 1 for NUL */
+	size =3D st_add(len, 1); /* 1 for NUL */
+	ret =3D mem_pool_alloc(pool, size);

 	/* Shortcut; relies on mem_pool_alloc() not touching buffer contents. */
 	if (ret =3D=3D next_free)
 		return ret;

-	len2 =3D vsnprintf(ret, len + 1, fmt, ap);
+	len2 =3D vsnprintf(ret, size, fmt, ap);
 	if (len2 !=3D len)
 		BUG("your vsnprintf is broken (returns inconsistent lengths)");
 	return ret;
=2D-
2.44.0

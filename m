Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77D101DA
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861204; cv=none; b=UlUE5fbNxwLY7D4NnpZJ1wq85YA/fNrfBiAEVdoZqnVEQs3FgNeiuTJBUQCFBH4HRwK+R13qzqvjsa3zhplF0oFabu2rTxBbQUuZPPVKtIjTx67FO9KuCzH5Rn+Ea5RkdMCLKaKqBpbpBf/jj6KGX57qCYy3KC10jSEBiACv6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861204; c=relaxed/simple;
	bh=FYH++5g1qSoBKX8tiB4AelL1cCcVrS6Ul5pI+3KBgk0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7ZMQI8wHZzAFgYIupCs5GglmMjqI4e3qa7FjQSSwWdeeAYH9vw1tCMaov2uwDVsuPQq+3qlWE1iB972/i1ctJAYhmD8HEdopWNeRyNGndb7dA9nxsfwEdZLNDdocB+EEK4sf+nugZECZvIVoNG8NEi4tpu3+GqpNd2hT2isN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Zfln+wlO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Zfln+wlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708861198; x=1709465998; i=l.s.r@web.de;
	bh=FYH++5g1qSoBKX8tiB4AelL1cCcVrS6Ul5pI+3KBgk0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=Zfln+wlOx+Q9aKNHMpPR+WSGysXPgMu8d8iPZi4s60d61HCS/rmZD7aYN0Gj07Vl
	 jxQmRlCYPDH8tV6zNK8/zZoOZFTAXqSi69lC2mwOIwyroXbzCKdiiFHM1WHDy9O5D
	 xMOTS2AcLwF2avzuc96zKXhwhhU7JMtq5e7Ci1F942aPDQWZ7msmHH9Ok8cTYVo05
	 lVCgZ8d7T92ijdI04e5L4IBvt5pEmkjXtD+4i4nVlF2YaH2XSXhTyp/OBplD2GAED
	 nGO3lp58ezP0tiN+0isKmPYoM5nBcOYK0ziT+JjD3nY5rhM/ALD/EuIn6ig5f4diy
	 Vr6W+QSwRaP1heRx6w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MActe-1rkmRS2EKe-00BXdV for <git@vger.kernel.org>; Sun, 25 Feb 2024 12:39:58
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
Date: Sun, 25 Feb 2024 12:39:44 +0100
Message-ID: <20240225113947.89357-2-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225113947.89357-1-l.s.r@web.de>
References: <20240225113947.89357-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7V0L47QAk4F5Xw35mif/RmTmiUSwR95kI1lZiB5Ips8TYbSDJeC
 Iyl8dl5/AfD7SLUWLuLn65jWYYRVNmxLNlxhrWcK1AjOgbfKb7INX05YdTnSMYXBFoXirvC
 j5RlaIOZ8kwJ5z7p/nyR6Z6f9F8fRY/x36/WoXwk2KjqPbJ5w6BirjAcY/MYEX8i2cDlBiv
 jE++L7uOkkOOGecpZiMyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YikoBwScmCE=;ZnsILH2EVD1HG/okCqlm1VAp3eo
 q7lTJgckQxfBC4bCqPOOnIqHhTndjxyUXb49xq9eNhOJv6J6mBUatwlxg4A/nuaZ6pfn/sYxl
 dV6qzA5TkaqeKnZID84WgHFWgSgFRMm2+Z+0KAAquRlB2uZB1xWoklEHq+tUkocbMeGREjLA5
 4F147hNY/ESWhV7xA58/laaYABkXvhGdXLr7101ley9RGVUptqoLJFpY5upVjJtuKrnRdGdy+
 qosYc99OfQTcCqDxYV3NurvX2GSqHWn41LK6Sh3HqqST4vCSupUimLvsEQ32EqWrjXEfegDrN
 QPjQTFFsiqnaXHZ/2ykuAfBQtby5i5l1yGiR1Mb3j/0ArM9u8GRa9tB4TLwzukWivWY4FoBn3
 w44rroxY/nzBIJLZY3hxDgnxRit3SYTWn/xPXFNcGFBNO+stV9h8k0+8CmN6AAfKgkdevyLIi
 R5BD/MlhOL63B/22NRCsrh/9f6A6nWKpAF1G/dUZ3AQC8PuMfqN9APJIIOvQ2ppefgn2sWyju
 YjNv5LIbLV87+gCaRP+BhfntPCaIuwE1odGNkUzBlHm/mR+OvOZFvSzHYhcsOmxiaI1oDvbM0
 XKmVQ8GvMwlVZwk1spQpXY2rUNcrd9c5eDHvkz+x4Bqd/Br3wNiI5XHT6XTKdWdAr9G7zGNr7
 TO2KQWZQg1Y2autb4lFBi6Hmx+Cx/0/MSb//CX5+iPov5Tg3ZGrjI6zoPe0wBfbtnRHSVUJc9
 k3VTjTu6lxJWWF2mm5OcLmUGFjVs0XcLdcdMghwJA5goj9FBLedL+TPtQzBL4DSMgrHTNoWUz
 w8ROLmwX9k+Hi3aIErzL+vT7DbjOi2SZHWVu1zSXFXS24=

Add a function for building a string, printf style, using a memory pool.
It uses the free space in the current block in the first attempt.  If
that suffices then the result can already be used without copying or
reformatting.

For strings that are significantly shorter on average than the block
size (ca. 1 MiB by default) this is the case most of the time, leading
to a better perfomance than a solution that doesn't access mem-pool
internals.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mem-pool.c | 39 +++++++++++++++++++++++++++++++++++++++
 mem-pool.h |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index c7d6256020..2078c22b09 100644
=2D-- a/mem-pool.c
+++ b/mem-pool.c
@@ -107,6 +107,45 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t le=
n)
 	return r;
 }

+static char *mem_pool_strvfmt(struct mem_pool *pool, const char *fmt,
+			      va_list ap)
+{
+	struct mp_block *block =3D pool->mp_block;
+	char *next_free =3D block ? block->next_free : NULL;
+	size_t available =3D block ? block->end - block->next_free : 0;
+	va_list cp;
+	int len, len2;
+	char *ret;
+
+	va_copy(cp, ap);
+	len =3D vsnprintf(next_free, available, fmt, cp);
+	va_end(cp);
+	if (len < 0)
+		BUG("your vsnprintf is broken (returned %d)", len);
+
+	ret =3D mem_pool_alloc(pool, len + 1);  /* 1 for NUL */
+
+	/* Shortcut; relies on mem_pool_alloc() not touching buffer contents. */
+	if (ret =3D=3D next_free)
+		return ret;
+
+	len2 =3D vsnprintf(ret, len + 1, fmt, ap);
+	if (len2 !=3D len)
+		BUG("your vsnprintf is broken (returns inconsistent lengths)");
+	return ret;
+}
+
+char *mem_pool_strfmt(struct mem_pool *pool, const char *fmt, ...)
+{
+	va_list ap;
+	char *ret;
+
+	va_start(ap, fmt);
+	ret =3D mem_pool_strvfmt(pool, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 {
 	size_t len =3D st_mult(count, size);
diff --git a/mem-pool.h b/mem-pool.h
index fe7507f022..d1c66413ec 100644
=2D-- a/mem-pool.h
+++ b/mem-pool.h
@@ -47,6 +47,11 @@ void *mem_pool_calloc(struct mem_pool *pool, size_t cou=
nt, size_t size);
 char *mem_pool_strdup(struct mem_pool *pool, const char *str);
 char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len=
);

+/*
+ * Allocate memory from the memory pool and format a string into it.
+ */
+char *mem_pool_strfmt(struct mem_pool *pool, const char *fmt, ...);
+
 /*
  * Move the memory associated with the 'src' pool to the 'dst' pool. The =
'src'
  * pool will be empty and not contain any memory. It still needs to be fr=
ee'd
=2D-
2.44.0


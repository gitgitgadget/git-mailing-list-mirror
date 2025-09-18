Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F920C488
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239801; cv=none; b=lAqCdlVpOsFGLLYzZvIc+1HExLT1+VTnA9iyDzIEft6+aF3ZTDRpS7K5dFlivmpig97ZE7jg4QSeE7R+LKDDMMx6vlK+XtoXIP91prVWAfUk90qU/yw00dOiS9MJUm44Etz3eEExGCRhOglqEmb2ORlUGcP0bYpdpkf8s5Vwfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239801; c=relaxed/simple;
	bh=iNPZ6zToN3/coANG7+P3BaZatp7jypphFiA3XbL9+0U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CSt1/AJEEVVGKa4fryZtCi8a8yJJWSO/9SrQpkM7iVgFSmq2gMS82xVuo8ayk9e5NSc4OSx3yWNNqi77J7Dxsf3E1I39NVEKsXaktwfWORWIDyMnXm6wj3PYya2vNaux9VWdbwBu2tu8tzC68gUtS5D0Ph/T9DvK+ZWfri4Zw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDuF/vCH; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDuF/vCH"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-76b8fd4ba2cso13155626d6.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239798; x=1758844598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o4F823WXDlNlLg2iEhmJIRh6r2lzFNm80iwvaMOhHg=;
        b=DDuF/vCHLlimoP9iBvwuzgMAfu/x0w0oYOe/VM5i6Rt3CiTXQ1x8KIRdvpNzODFe6O
         6mLdauzf7nLeicYDuMkBqW44DR/A0/BNR6IdBo5q96eoog243I8uCIvYDuTHSuIyVABn
         3Rie3+NNSj4Mb4cbb4DKL2X9zVASHeVzsSVXSez6RqxMLqgx0UezPB32aw2ux0CCdvQE
         CCeOvrfp1NL3VwGCyMBwa3T5FtcYkswOgZ3BWOmlcWebO5h75WWZu6HP09Mi5Z6krAcw
         oNp/AKnRIBL7jQKp7yh2UdYeFo+aiYaRxfnHYrdr4dLUr2StMI2WgzWxZ2t2+yZX9bAR
         4hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239798; x=1758844598;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o4F823WXDlNlLg2iEhmJIRh6r2lzFNm80iwvaMOhHg=;
        b=GxrO3Ugf8EOkWCZDLen7C6cbxCco+hjGlvyKGT82MTRvbJVgnksONaqr/pT1M8TJzv
         zGwBATPEHRD5M1qrmhdWsI4Js+Myvc7KDHatEUSRlxC4NEpPFGXmfYpe/putOlcM45Lw
         IY0J9eggbt7i0ksgMDLRhPDBUEz+6ObEjXS4QKk1hH9Ki6LSwxvACELC/bJ42ju7WYmm
         /nTGVl8xWKtPkQ28MPTd+D0R/+QbwSNDFD95m5V8UAXnKUa8SorEDW/QT3AwnszWOF1q
         tIFC4LTpBhu/n+3N296CLZGwR3hGdChDOSt7Vbbcgvc9UY2RfNQwPj7ZoNYe0giVA+BO
         q1tg==
X-Gm-Message-State: AOJu0Yz70ZpbTA6fzJC+5x6XQmH0CFExzbO7gfeSdFSQkiF0jyFqqW4D
	IgF7WhBTj4OBQMl2vHYt8C8oaN84jVAoN4oU92SECbuuq/hfP0z43XoA5130qYI2
X-Gm-Gg: ASbGnctzwpZ52iaYwTTO9RVRju31Ia1cIbRC6cqJAmpui9p6McROckFigF8Bymse0+X
	lqtrYiSwE7M91GT+jb3ZtL3WQLIvB4MHNmhcIVqvqqp0AHsPGNHST+qj6k/966jjYhq87rMWRmT
	/gEUmt8aOYs9wGxK/I6qpGYk9ZepB9t8e40CKiOvNP0cuON329bekmw48Gf5YUf8UtOTBTcRLqg
	T+YS+/W6hu4kfnY3m0/Hfjy+C+1gyAuVdvftufZn8DK/sbxmCOyhAz2cdAMMve1F0At/gE0YoU6
	rz/Nsgeok1wTClZ+2fvgHJZ1HhI7yjiMvTdfkLJaljvOFnNICdCKB+MA9Y83v6dc8mw9WjEDH5r
	BbZYLnEEAKRWiQr8DXOdsCrJXj3pxYMCmIAlzYGTldFbK6fx8nic9Jg==
X-Google-Smtp-Source: AGHT+IElo5PRRsHCHUZEnpELWlOdmYoD1h/EWTwZGFKbqkXLzpCBEV8CHkrO8umk0zP7H+Bm18UGFw==
X-Received: by 2002:ad4:5e88:0:b0:78e:e166:72a6 with SMTP id 6a1803df08f44-7991312e1a2mr16645946d6.23.1758239798080;
        Thu, 18 Sep 2025 16:56:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79344899d37sm21185486d6.1.2025.09.18.16.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:37 -0700 (PDT)
Message-Id: <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:23 +0000
Subject: [PATCH v2 04/10] xdiff: delete xdl_get_rec() in xemit
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

This function aliases the fields of xrecord_t, which makes it harder
to track the usages of those fields. Delete it.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..b3793e81e2 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,21 +22,11 @@
 
 #include "xinclude.h"
 
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
-
-	*rec = xdf->recs[ri]->ptr;
-
-	return xdf->recs[ri]->size;
-}
-
-
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec;
-
-	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
 		return -1;
 	}
 
@@ -120,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -160,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec;
-	long len = xdl_get_rec(xdf, ri, &rec);
+	xrecord_t *rec = xdf->recs[ri];
+	long i = 0;
 
-	while (len > 0 && XDL_ISSPACE(*rec)) {
-		rec++;
-		len--;
-	}
-	return !len;
+	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
+
+	return i == rec->size;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-- 
gitgitgadget


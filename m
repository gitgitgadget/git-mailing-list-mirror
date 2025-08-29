Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A724DCEF
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496557; cv=none; b=Ik7f5SVsBy4/D2tqRlOeyFqy5tX8rSCnm6+8mX/VlJf+GPemfRKBfkPrexjVVX1emtulYuZJAs1XD4NiNT/5VwJ65K2FmFyCpK2UeheQSHOcZpAfAZPh9iIdrWrLdla5mmRSmcuh8bH5KFpQKTgPXGJY49ZI3SPFzmCEZUw/+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496557; c=relaxed/simple;
	bh=6+j4cPtFKFIVH94pjubtJeKGVVYsh2fo+oMDEywoL4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g781keYpU4zRvAKQAlCav2kCNRPWU1YXfSwkdsi80Mrvf7+oTtd1UFkN8SuFpTkDE2z3jSV5cmCwPf1+GjudQg59I9+bW06kjc7uQHs/rLj8H2LcrnxnSNxaI34Wtk+rqz3W1pAfQhmCi0hPLT/ZjyGB/qkAz8fzRQJwWzzKhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KINmX7wG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KINmX7wG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c8bee055cso1327074a12.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496555; x=1757101355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRuauxKmDnCWRMe3eAZqnwlO9yEYZImEFmFo11uDBuY=;
        b=KINmX7wG8IJwdQiXv+awZm9ZWSYhQcg794bK663447DmfxJY5AqnjGurXsfa4RHC03
         wGPXABVd9NRvHeRbez9Hv3E/X+T+eV4MkJTRb8Vc2qJzqEwmpd4auZ6XL8EEfEJQmbgj
         QKNMPLBbbGg1OkYMHEV3yzAlBu+iqE+35Avh3bjIzOYtPvitsU8SGuQHSLvMG8JTS/4K
         eWRNnf5w6ml//Fcx4R0Zeyh/ZCsLmQ9LsTIG7b/FrbX8Y/asrjbI2OZbnnLjPLTFiS5w
         exvxwVj+mtd7J5oSyRvT9EznPdZXksS4iUI5Whmydbgkva8QEAW51KmbPQv2ZHNtkQ+Q
         S3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496555; x=1757101355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRuauxKmDnCWRMe3eAZqnwlO9yEYZImEFmFo11uDBuY=;
        b=W19QyXzzQO8hR0NqtdW8r8NmlTZtaPSMMJbzGDV2gEkIfABUkzTagPQX5e//n4jnYN
         4n+dJ2VDt2CziTnti5uWyA/8pOhQqsbKGrLlirPY+dgoXX+dqFH3L5VDwnitwI/YzCgB
         uEuSMTCqyekmP3ehTQXyhvQ0/jPOLxZFbU+/x1FO01SRXaw/fueOTi7937lmO1DXKAYf
         stxZ79iQxeoTK9RDdjT2TO2DwNkCnTFL8wJWw7CId7tfSCYZVGgmzNz9KN7Q2bf8RbIf
         uz4q3DHsMYZqs7Llkz3RtjUH6mAlERYVYFsPacgVhXyogh7zYqpbEQiHSSm4IMhany5h
         snrQ==
X-Gm-Message-State: AOJu0YwVByc6/vmQtH7RahVFSjoazQf2P9Jdt96MTbBTXZXNMnAiFO44
	jkb/buKjSGdGx4T5ZEPGq4BaaNw4rMU8Pe/bY8ipBiMhqU3DpveWwEADpvxAHA==
X-Gm-Gg: ASbGncvUUzdjak3vEttk8U8MvIIvjkuEsMhlEPM3EyCUsPKAYNDAhaZqxGmXE4B12zS
	u/jeF0pjEzbKkFSOOQIWVGerav19PSFMF4JalqXjLU2GySWdWlrTeb786Vc2X0cbZmvh/uL0D7B
	EkXoeKXpsQVegDL5ZQOlgChZPxWlVADmM/BpT8lOBfjc+JEyqFa3VEo6uGgeQzy1sfsOua/vJQn
	SnCn6tdqviw8hKQ6v92oLwKJJHkgxN+CHu8cQVGUyE79eu8X8qJV3HkuyKOtujM2EJiE/iKA5ex
	Y3oqnoMMC0YAK286Mr8fk1p+hyc3NCdfpEo2kLqB1omGQzATXrkdy7eUaUWjmwCEy9Ego+69c9b
	3k9eoOLmXHOlX8ZpD86uC6vhezPTw4/AlBcQKF9yPX9tru2lW
X-Google-Smtp-Source: AGHT+IHbCKPwkK9rjnazw3mNVCBQkT3tZD3wXc5PNczxpMJpcsGqEt5ipTZazsFOBWKQtnCKwwtnig==
X-Received: by 2002:a17:903:178b:b0:240:8cec:4823 with SMTP id d9443c01a7336-2462eeea432mr360338685ad.41.1756496555334;
        Fri, 29 Aug 2025 12:42:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90ecd1sm3523892a91.21.2025.08.29.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:34 -0700 (PDT)
Message-Id: <0cd2168512465f1d131e8bddccb4be584f34b6c2.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:14 +0000
Subject: [PATCH 10/15] xdiff: use one definition for freeing xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Simplify xdl_prepare_ctx() by using xdl_free_ctx() instead of using
local variables with hand rolled memory management.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 60 +++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 00cdf7d8a0..55e1cc3087 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -129,86 +129,74 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf) {
+	xdl_free(xdf->rindex);
+	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->ha);
+	xdl_free(xdf->recs);
+	xdl_cha_free(&xdf->rcha);
+}
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	long nrec, bsize;
+	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs;
-	unsigned long *ha;
-	char *rchg;
-	long *rindex;
 
-	ha = NULL;
-	rindex = NULL;
-	rchg = NULL;
-	recs = NULL;
+	xdf->ha = NULL;
+	xdf->rindex = NULL;
+	xdf->rchg = NULL;
+	xdf->recs = NULL;
+	xdf->nrec = 0;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = (u8 const*) prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			recs[nrec++] = crec;
+			xdf->recs[xdf->nrec++] = crec;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
 			goto abort;
 	}
 
-	xdf->nrec = nrec;
-	xdf->recs = recs;
-	xdf->rchg = rchg + 1;
-	xdf->rindex = rindex;
+	xdf->rchg += 1;
 	xdf->nreff = 0;
-	xdf->ha = ha;
 	xdf->dstart = 0;
-	xdf->dend = nrec - 1;
+	xdf->dend = xdf->nrec - 1;
 
 	return 0;
 
 abort:
-	xdl_free(ha);
-	xdl_free(rindex);
-	xdl_free(rchg);
-	xdl_free(recs);
-	xdl_cha_free(&xdf->rcha);
+	xdl_free_ctx(xdf);
 	return -1;
 }
 
 
-static void xdl_free_ctx(xdfile_t *xdf) {
-	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
-	xdl_free(xdf->recs);
-	xdl_cha_free(&xdf->rcha);
-}
-
-
 void xdl_free_env(xdfenv_t *xe) {
 
 	xdl_free_ctx(&xe->xdf2);
-- 
gitgitgadget


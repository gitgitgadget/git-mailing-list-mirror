Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F437286424
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926526; cv=none; b=PMZ4acnZwvYsZXjJk6E8tfi5sd8tqNx+HgF+Rod3ktogildvonexV9zeu6MNHW3djWo8j0eu0fttSCaH/u+GQ2pEedffNOYbAHUZ8lhyPIEsS9chs+IC4KFCv1xXd871Cf1YPKZKmk4z1TwZUmW31Fz6QtQzuiHJVq8zabVxNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926526; c=relaxed/simple;
	bh=zLaLm+acLxRKWT4dJMbCriLwPg8F3tVK9tlJCwmesl0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dd3+lj+EDGg6Kxtr/D1KYpko25nrPglwuO4yE6Cfkd7FO2imd2ShK411CWcmbJEi3aMEanFkx1zt9YQLWjz9iv9ZnCVQy8yQxN5mSQrXTFnLVxekZJhSkeX8WaFx2ASHj2hvvyMOsFH/vPvJGWLWxYFeb3Z3riybmxx3OBuqQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXG3qaNN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXG3qaNN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33292adb180so2529291a91.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926524; x=1759531324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=GXG3qaNNB6NtEYdPsAv5WqOhaMaKDYeKa61xRj8wdASJR/WsTQWdivOmGOuGKgJBKC
         cpCMJtxypRGArg7T13dcNZ/MEA4Y8WHp2W2R7nM8vUtm2HZD/zbb3si2fOx/DbgQGzOM
         4lDcJ1x95UUjYWvVPRwWUvDbadhXAJEwmoqUykFK2al0u6r2DYicUbGTTn9+TpDex3UM
         lKMxgBxhmZHj/QZTV9Q2r2dcDYsDy3VcDujPZ+2f426ETOVQ8gtp85JAlb3/f/9OdTPi
         lfOUpPeCrjAwQyylWpo9I11B5/TGiEV7MOny1Dfvs3nZL3SuarAvGbpdAMFJPecY919A
         9a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926524; x=1759531324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=dvOmcRW7tVE9BsvXLnrzeh0zqEaaEgKhWLqHsOSG9UZl+d76bQ1Adrezofv/3Ieuyh
         uLCEzhCFjnF33d1gNS27Z7pvm18G7yn++Lf9f4SJiZJS3pXFTpb6YIkcLN+0bzU86wLh
         v2FsgSOgpziAQhaEX2E4JVyO8JcR4zwih696r+wX5DLmgXH5HfCM9tL+ZVbylhQkkhmG
         IIrMDKvHVDZnQmyretjpD/kqoQHW/fooS40Sir8zQoiLTzEZC1IeiVjbbAA+TJS3cqQW
         /pUlPwMiX6OR6ELHa/GcEEqpghv1paVHx1euMJ7dlxZHOSKQT17SN33ME1jphnVLkzvm
         9TeA==
X-Gm-Message-State: AOJu0YzlS3cgpXj1QuC+BoojU1xcE8PdLXiHVZhTD1cvDiYAD8Twvhnb
	ywdxNHAtumGGkBMgf+DZ3pArRoOtkdK006TVnvX3ASefaw8Dpqq/Y7abPWIrKA==
X-Gm-Gg: ASbGncvDIArPVwAZtd0630MuPuYBohduYT9wFlLfYlsFO/JmRggJlCFTcSEBscxChDE
	NMrWPmiCv4VVQ8fdQfkbta8hdDEkNfmLMumyGbzdhXmNbM0+Hxw6pBjtdHWaUjkoOEFPZDVkLUx
	5UmpNBiBc67yLayhlggPrmBLt/C5WGx4nXwMkWrmjvJ41d/N6gyaQ98zxQd43ZUNFEFujtehmz5
	rt8LEXicbzWZbGvC/lci13ogVXjgwIb0iIeuPJ3QU7Ixc7umT/RxfI6bQipCVheD1WuPjt+LYhQ
	YJyGlbcUBdjsV1aEiTaukB2LuA1sUOT9CwOVIcfxadFGTUzFIX/OTbNC2nrGpqjVlGiH8hSEeBU
	BhYrsh3d4+BNiOBKjKvoXlKTVkTrop4zV3jI=
X-Google-Smtp-Source: AGHT+IFcuwzTyIwktZHhy7tmri4u7vd5X6fDeSLYQQfiFABSind5M0P5BhF6m6ZbMg/jQeesnU86AQ==
X-Received: by 2002:a17:90b:4a92:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-3342a257491mr9209540a91.7.1758926524065;
        Fri, 26 Sep 2025 15:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7c960sm6583393a91.18.2025.09.26.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:03 -0700 (PDT)
Message-Id: <0cfd75b1ffa3f02cf1230866e6a060e653691825.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:49 +0000
Subject: [PATCH v6 02/12] xdiff: delete local variables and initialize/free
 xdfile_t directly
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
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

These local variables are essentially a hand-rolled additional
implementation of xdl_free_ctx() inlined into xdl_prepare_ctx(). Modify
the code to use the existing xdl_free_ctx() function so there aren't
two ways to free such variables.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 78 +++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 249bfa678f..96134c9fbf 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,99 +134,81 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf)
+{
+	xdl_free(xdf->rhash);
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
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs;
-	xrecord_t **rhash;
-	unsigned long *ha;
-	char *rchg;
-	long *rindex;
 
-	ha = NULL;
-	rindex = NULL;
-	rchg = NULL;
-	rhash = NULL;
-	recs = NULL;
+	xdf->ha = NULL;
+	xdf->rindex = NULL;
+	xdf->rchg = NULL;
+	xdf->rhash = NULL;
+	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
+	xdf->hbits = xdl_hashbits((unsigned int) narec);
+	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
 		goto abort;
 
-	nrec = 0;
+	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			xdf->recs[xdf->nrec++] = crec;
+			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
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
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
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
-	xdl_free(rhash);
-	xdl_free(recs);
-	xdl_cha_free(&xdf->rcha);
+	xdl_free_ctx(xdf);
 	return -1;
 }
 
 
-static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
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


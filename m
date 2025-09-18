Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350322BEC5A
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239797; cv=none; b=TI4lphCtKshtw0GggHvBrHrKt8p60l0gmBuQ/w1/hSErUsv2r5MR+8+CdUz8YDbOGcXZaL9ReD52AeAzJToCpbhR4NwFYUzzU1AsCcsK6/o/BLxfxiBpAqnfx76Lv9p2VOq1uV48eKKroMjTGEVORRlP+bmtqXxgRgnFgkUgStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239797; c=relaxed/simple;
	bh=Vuyah6ETdpTEkoP/NIJmf3xhjZ4tftsfUKDsmxtzWeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rRBQoBibDNps5Tx0EA5pulJtsg0CTlj4HlsDbhR7vYbFlZ3t00SPOKVsAIyDYbafRm7ssYGRBFa1ffKW2gVSiDSNCFiHAF0nulbxoEYXBH+GaWdh4dclL4xjfu/iW5YMlkwdA03wgK1YlfQ3L9vZ6Ww8SxbojV2gCdiDyFYcBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn6odzmU; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn6odzmU"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-827ec18434aso153067885a.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239795; x=1758844595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBrPsmBFKukZ+KW5A7lw05n9uGb7ctXSsHjXMkk77ew=;
        b=nn6odzmUDsd+7cT0w3wKlqWTRlQ5jNazJhUIeZLQmt4i1tNTmEFNY4Z9Ak+y4ZKa1P
         aqvMqMFKE7N5hnISF/PDgefbkB9K5gRcYFhawREvxy7EUZQ8yDNJJvrldGjGbVqS1jRm
         GfZcgC5wUQXjAdeEti/r5tbXWQUKKqqEtAIOImbsmw4LN9AZjrahF0+YAzMJ9Z35pnUS
         N5xb74zNjo+p2HXQt0ONLNUI05/wYZvbWEF4Xn1+3c0JQrND+VgJu8D+OYtqxcEQufRt
         SU0fKgNteuUt/jfGe1onIJ7Cufq21K5IeHdiIIXWaKIdhJDeizHU91ZVZxIct+ARphbg
         9NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239795; x=1758844595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBrPsmBFKukZ+KW5A7lw05n9uGb7ctXSsHjXMkk77ew=;
        b=Muq36QNH0UfNiCW+kYS93qneMOnnmXcVbXM0to1iq0NnxBEUFxHR4QcbwmyDxESqwx
         v18IMPZ4Ondbm0RBF6aFv9736AVcrlBooC8Yte8fkeiWzZbtiJuTDARxzyzJHeGT+OZ6
         zbJuWLSWFjIif9Kn0gs2rhu/za4WrB84YLfq45kQa/Hkv4wUjkFegDQgjE9W9tR6ALHB
         sy6gQaXDHikRvCIC09gKerBGQBd9nob0YrZtc5Pa5lfKBaGBfwFx27VY6v7AA7uo8yhQ
         vMt1//4HOIkSJaZynoNcIFCSe2782p7f6MtFCFPyUBEgBW7xPPGVy+a4bl7nEYO/YisD
         b3VA==
X-Gm-Message-State: AOJu0Yy2IUL9fERsxuY2VrRVOU+Vk/OCFiFRlpXMCXX3uZ4tzk0Fl/Rh
	NpN3NF7weXEpKY33FD59zPPBVelMInXTtZvuPd/Wj325Bu/Z2D4rnd9n0sG95icm
X-Gm-Gg: ASbGncuTolytVlNF4CFMiqs98VVBYbgqpj2oq23lok5FhnLGyMoAdi6uA9n95e6P1Ek
	sJWe1CT3p7LI8n5pnfzJtp2aL0Ku9McDhAVHSbryEQ73XMnv9yLgq2HcL7CXW20IsjzFLpfggCG
	eJ6Tgj/a+np2y4qveLaPNsG3x6h46yHpCo9KoPqawClEoC5qE/N+SPF2UmfHc1Aksk40dzlhif2
	WCHKPBGKxZ1+HY0IxDrcubz7MQ4CgtzlIlGS4dAXRYpO/iZg93qPP+NTTrifPD8k1l1flrh5itR
	jayok+nwQNywTBt/LnG9SZmJHrlUCci/PrIig9g5p47knQzmJ4PcYSwWkEWpkyKn04NGHRsun9+
	G8KRGqQ7wnv5rKatVs26bAd6xXm/EKomnm4+kJzu6ulE=
X-Google-Smtp-Source: AGHT+IEC1+zeq1LYdmWBPLWo4vxhPd2Dexci7h+n72RrywXGvbQJAnSSGhxHzEEsiW8ldBp5bjLs7A==
X-Received: by 2002:a05:620a:3193:b0:826:105b:9731 with SMTP id af79cd13be357-83bafb3774fmr144787185a.83.1758239794677;
        Thu, 18 Sep 2025 16:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm21164881cf.18.2025.09.18.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:33 -0700 (PDT)
Message-Id: <b79157e64f0950d25a23c50a8ea83cfddf67ddf5.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:21 +0000
Subject: [PATCH v2 02/10] xdiff: delete local variables and initialize/free
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
index a45c5ee208..fe02fd7925 100644
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


Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE107246BD7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496555; cv=none; b=OQIiO8WlPzCE3r5CjhhWdbHk5A+/Lwex0Cih59wVI22R2f8Xbc+nOGeMEcBh7IfjulMycWCKTV4rqHjI+hwps2H1ix9/lSESe/9ru2igfoh7NqM5WbZyqorDqUpQCSGN8/pDrT0FrncSJ8Ttdu+A7hrNWE8hRb+pIZ7JUDY99IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496555; c=relaxed/simple;
	bh=5T+DRRnLAdXr5FpLKldOAMRPT1DoDgbTo1b5AvYymkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EMqN8LVmT5KoiXOk9zr5gDkvGRRNCQnxzE+xzGYTt2phntcgJ0zgNywS0Kz6oOwjiG45ovDY/xBnAg0Xvu3ao4GfCPH3a4i/AmiTUeUAeNJP+1IchYlJYgr/4PgXVFj+ImUmgQsupUYPPV403u1h2EifS36mYOuZyN01LpnEnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3AOx83J; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3AOx83J"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722e0ca299so774551b3a.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496553; x=1757101353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvK1cIHCOc85O4Zvf/EkEJd6jzMr6rHhaKLG8O2oKyA=;
        b=C3AOx83JXOtRYfMbS8W2UoOWxrjPYF1RRdaLVUf+FwwweOAyFgrZxW6gKrnZfAPVGx
         ONKAV5krJ/JEYbuQSNr5UOO4QtE9g1hkv7nkpW5EuFufRsmATW9Er0ytG3/id0qqTRnL
         sCRPGLWYGqeP5Z2iccTso9q3LNrc2rBnYovbP/tbHE0zhO6RqJlO2vbepU9EVLbE8ZWL
         OXu6WQyoWTnYGsYQ1mL0rdwC1z9vpuyG5YImKikrgW9DSnbB4CtVizUKTliI09jaiTKV
         PFZslFzu76zGavlwgrwFt6Xd75rIXuoYCwQEeiDwYUD4aru2fmAUSJ/oV13B1ceqRCuy
         eDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496553; x=1757101353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvK1cIHCOc85O4Zvf/EkEJd6jzMr6rHhaKLG8O2oKyA=;
        b=g0m++KTURDcKrdt2NnyxJ6ssdFzAz9zZ+ENbn3kQHPkApYG7HTyAg78oicRX4GOrdQ
         uUn9VWkWnBpPSlsZC84Y1Hn11OgqOpbjYhFUKCLaDvkdilm4rbuekTvDCrxs+avFTVQB
         E5ZyvUuN7uMwW8MEaZjaCpxkg70nTXwX7A0Nr9/VEoerUv2JWSTUZRcTNVfoFMI17eD5
         MR3vgvNqTWq88miu9w/rzFD3s6Y5Y9C4p57prSIthq7UiFZrxW/WY8Mjt7LXtgICYMuh
         FfHYG3jh02sZ11AIcXYP0ruwKifJO/FDlmE5UUbUXOhmZvm8UMimO5aycSpotwev3CX7
         /PQA==
X-Gm-Message-State: AOJu0Yx6dXmx5m/wpsz6SmQbI5193ZOReRHGTIKyNl6KkU7fwNtmmxXi
	RQdQUhOQDVMrnpoFhUT3zn41HZ3EKzpWjT7+4YcqnzoduqOsbJhGOqeoqhcgKw==
X-Gm-Gg: ASbGncsUgXP/sr8L0hvgUR0YAXwlF95P+p97kgHOm1qW0ga642KR0wxmlIv7UqcgBGn
	U78ZvBeKElzFQUY8MPtyjE+EElSoVSrgh6ynxTeiNXGw0tb+Lh/OeHzNB+hLQMRyMcGR/+4Cfuu
	NZpYSc/fjHJQeCps4fWajvVmDZYZYqET5Dj4vYv85eFOaI0JrRr3gFBk3O1z55F7CZTae/YkUet
	bwFEb1j1EhTLu2SoMaeMmI8XzWAhgirxmgLH9cpT7t+oZr2QgCfQadRAJ4htbczPuH9b7Z3qHvH
	e/wO9MYjs2bJLjUeZ0R0pswmrOX+wwKvj8PysyDAeHWltQpZ31AME5gV+7pz1t0r0t2pDI+UsO1
	MsU2xk1Y56tDs/JIzfDdoLVpypBFsuaiKvLxMGA==
X-Google-Smtp-Source: AGHT+IFUezbgx3W9pWWhfHSmDf6zn2FluLhzpOelFUH27awhDsGrMLr+ynccR8Xjw6ovoCHx5hdZuw==
X-Received: by 2002:a17:903:1aa3:b0:240:417d:8166 with SMTP id d9443c01a7336-248753a2704mr180643475ad.19.1756496552608;
        Fri, 29 Aug 2025 12:42:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906596416sm32016165ad.118.2025.08.29.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:32 -0700 (PDT)
Message-Id: <c7cd71dae0081369bc9f94f64b04099d40e991a0.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:12 +0000
Subject: [PATCH 08/15] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 24 +++---------------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208..ad356281f9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,23 +125,17 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long nrec, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 	xrecord_t **recs;
-	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
 	long *rindex;
@@ -150,7 +143,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	ha = NULL;
 	rindex = NULL;
 	rchg = NULL;
-	rhash = NULL;
 	recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -158,11 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
-		goto abort;
-
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -176,7 +163,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
@@ -194,8 +181,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
 	xdf->rchg = rchg + 1;
 	xdf->rindex = rindex;
 	xdf->nreff = 0;
@@ -209,7 +194,6 @@ abort:
 	xdl_free(ha);
 	xdl_free(rindex);
 	xdl_free(rchg);
-	xdl_free(rhash);
 	xdl_free(recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
@@ -217,8 +201,6 @@ abort:
 
 
 static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436e..8b8467360e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget


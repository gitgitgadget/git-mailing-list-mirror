Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C431AF2A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570716; cv=none; b=fwK8egRZ0gO2NQayt/XaGr1Y1YSMBuHHm2rRhCbwIl/uGlviLgVirteOuCaC8TehFH8poxoqJPs5c9DqvhJkfdM0UdkueMXeYemC14jf5n+I1JGzHPO9SWzpHCY+LxrlPx/YHPFTe1EGNPOQXol9YSbzYU0jxc0l/TnaalZLRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570716; c=relaxed/simple;
	bh=zejrKiRM2CWHXswyfUP3N98+xfqSySoV4HBV8AsHsIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Jz5HZWx9TskkS5v2XmCXuBQEg/F2D+okDb434aaziAwIscPR0wNpaH/gOTg6Z5YWvtkCLHyQ3r5nfDdXyrkpeYt7AEOtm08oFqv0oay1sotd2ekiNSP6Mum3S14T7sKSZLxRInoOQtzCyXBiGgMAk0c2K1qDpUeXKrEggZBMWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNaUWF+P; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNaUWF+P"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8d9fb6fc138so48222639f.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570713; x=1759175513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=QNaUWF+PMGEKnnWrD4jWVnORB+gniN8Av/8b/ZqsS0Dw+r2veM1dMEn3TXsVoR8ujQ
         kJ33jKK1pXMP4XjVEgwblM2NC8qDw2+TXpIsd+sfnqHy4Teaw5RCXHfwEwA734Q6muOj
         wj+dvrGddmxsnggXIBF3bJNHGt3wqDXmW/R94A7Jhy6kz2sE+53Htho23EQI+9L6fst7
         mn4owl/BYpvOphhyxzVsQzb28Oz+KM8PZ/h4iArVrT/TnyPWm9Zi8x/2mjvWIffdyiNs
         KHsABbHxRGOnzq59w+WfjtGvpyzd/YzPHTl4BYory+ESixCukElGE9x1IbJJtVwXpZLU
         3mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570713; x=1759175513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=UXIoU8Erj1N2mtalAUlDSCppOhODBHh7Gx/MVm6C+n7xD5rF+RHiMaLfVr9lwCDq/P
         SSvf5c8KL4D0/xyMFqrB/e7K9EsRJ6JgG26BlJiXivsImdMYjumpyRUp5k2KtxL8sOLU
         Bsy/QYJT1jPVPgQ+2CikHfEDL2jjF2xeuXFx38yM8h7lpuhSnD7T5SzNIlV5aMaTWz1w
         IKaaYpq8YK63gsjioJ9JiztMiNGIiAncPs+fdvq/+/EZJNTphIxw+kj19Bzk0lyhcq1X
         JsAA/1YUCAtx3aIJPQNkkFDzE3U1rBs6hLX1iL0X2ZzjAQso1NmPq4AuNR9mbPajwB1H
         5VRw==
X-Gm-Message-State: AOJu0YyZOH8ZusPFsCVPD0buQr0wR9bJydfW2uyemQ+AcC+g53/qcR2i
	e5LkZEU3QnJgv+WELo/1tnt2NMhluHZU1hhpUTXhCrSwu5U9jBlkbza4sDqyqA==
X-Gm-Gg: ASbGncuA1Y3T74ZcZn0tXPy9SxdV2fhytI8TcWGviDExPmxxP+6XY5ORd243p7d4biN
	CDfeCEZHwCB0wm52TK6YXThhEJPzQzSg32CP+6p8aDeWpHn+mvkZdqrJ2Ifqq+j8gornnPnmRVu
	KBSAwf6e4rqqfXtFHugigGFLpWpJrZ1bkIqMvJtWaCPMa7mkPGnIDKvinkaFjQKhUySd1BSYTyZ
	RWGXzuTQn/NENSLEKwSyawYkbNGVu4KmPRshiPH6SDB0ExgDrw/PjfERftm+68LCaOVcDpTqd7u
	ZT6aSaedGA0BhyKIs/6ZQ9Ku3a7NIj0G918mpA4crMvz7WsanaVcmqGyoHAvXVVrtBIxVKB0E2f
	7owUQivRS3TemdeKaBcG29NLx7w==
X-Google-Smtp-Source: AGHT+IFvwN8DZkSI6neoBx+enSt5FPs3OmhmgqsrzJLzlelFiVjZ1on4CUZDp00iVP7iMQZSB9I4tw==
X-Received: by 2002:a6b:d210:0:b0:887:1472:e991 with SMTP id ca18e2360f4ac-8e21c69aa19mr33560239f.19.1758570713603;
        Mon, 22 Sep 2025 12:51:53 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56b5a45csm5980935173.70.2025.09.22.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:53 -0700 (PDT)
Message-Id: <bf16453846575c7a56e6543d741065f98cd04395.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:35 +0000
Subject: [PATCH v4 06/12] xdiff: delete struct diffdata_t
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

Every field in this struct is an alias for a certain field in xdfile_t.

diffdata_t.nrec   -> xdfile_t.nreff
diffdata_t.ha     -> xdfile_t.ha
diffdata_t.rindex -> xdfile_t.rindex
diffdata_t.rchg   -> xdfile_t.rchg

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 32 ++++++++------------------------
 xdiff/xdiffi.h | 11 ++---------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfb..bbf0161f84 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -257,10 +257,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
  * sub-boxes by calling the box splitting function. Note that the real job
  * (marking changed lines) is done in the two boundary reaching checks.
  */
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
+	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
@@ -273,17 +273,11 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 	 * be obviously changed.
 	 */
 	if (off1 == lim1) {
-		char *rchg2 = dd2->rchg;
-		long *rindex2 = dd2->rindex;
-
 		for (; off2 < lim2; off2++)
-			rchg2[rindex2[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = 1;
 	} else if (off2 == lim2) {
-		char *rchg1 = dd1->rchg;
-		long *rindex1 = dd1->rindex;
-
 		for (; off1 < lim1; off1++)
-			rchg1[rindex1[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = 1;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -300,9 +294,9 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		/*
 		 * ... et Impera.
 		 */
-		if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
+		if (xdl_recs_cmp(xdf1, off1, spl.i1, xdf2, off2, spl.i2,
 				 kvdf, kvdb, spl.min_lo, xenv) < 0 ||
-		    xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
+		    xdl_recs_cmp(xdf1, spl.i1, lim1, xdf2, spl.i2, lim2,
 				 kvdf, kvdb, spl.min_hi, xenv) < 0) {
 
 			return -1;
@@ -318,7 +312,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	long ndiags;
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
-	diffdata_t dd1, dd2;
 	int res;
 
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
@@ -357,16 +350,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xenv.snake_cnt = XDL_SNAKE_CNT;
 	xenv.heur_min = XDL_HEUR_MIN_COST;
 
-	dd1.nrec = xe->xdf1.nreff;
-	dd1.ha = xe->xdf1.ha;
-	dd1.rchg = xe->xdf1.rchg;
-	dd1.rindex = xe->xdf1.rindex;
-	dd2.nrec = xe->xdf2.nreff;
-	dd2.ha = xe->xdf2.ha;
-	dd2.rchg = xe->xdf2.rchg;
-	dd2.rindex = xe->xdf2.rindex;
-
-	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
+	res = xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, xe->xdf2.nreff,
 			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
 	xdl_free(kvd);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 126c9d8ff4..49e52c67f9 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -24,13 +24,6 @@
 #define XDIFFI_H
 
 
-typedef struct s_diffdata {
-	long nrec;
-	unsigned long const *ha;
-	long *rindex;
-	char *rchg;
-} diffdata_t;
-
 typedef struct s_xdalgoenv {
 	long mxcost;
 	long snake_cnt;
@@ -46,8 +39,8 @@ typedef struct s_xdchange {
 
 
 
-int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
-		 diffdata_t *dd2, long off2, long lim2,
+int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
+		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe);
-- 
gitgitgadget


Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A529BDBD
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274330; cv=none; b=LillJPThPwQ+/tweOlrZ6Mqs1aWm2LfjQ8acNXaAAVvxOzdaTdXuRqwG6PnHord7tDDAXHkSkVBh2OiymWm60qNmJQj3lA8AyrPELhADF29ygYTxBO0Qb0PXiL2dBIRxddRE3QArFUIYiYfKGKhjDkoaC00wXgVPV2M1b6ho7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274330; c=relaxed/simple;
	bh=zejrKiRM2CWHXswyfUP3N98+xfqSySoV4HBV8AsHsIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R9w+wweGz03xtDUgCPgrHLTo7HJBlB2aEDac7HTcFFtepXFj0W0mu25yIiCQVcQuc5Yyd9UBAsC9b1GHCrNYxwCKZcOvU79TKWJH/1nBNvTs+iRqkpjgeq+72UNkyS2ATJ8iWqgTUWwmDSCB6q3xH6HYuBkq3DNYVpRkZqUeAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXFDXrdL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXFDXrdL"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b548745253so56246361cf.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274328; x=1757879128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=nXFDXrdLZkhaNkw5UOZLBDyFTv3RqAUgWx45XbNerN21MdSAla5T8o2AJckNxEzaFu
         /FTm5fwzqVSlTrJK8nAiBfEz0q762Ig5UdOg/tD3EhtoZd6pLacFjfLBzI0/UUBvXVAd
         l0r4O7RDOfb3GMm2nqyEiNEPwohaS5WFpIT6gMopj2dA9anRCnAeL0bKkkB5D2utYGQM
         4rr6dVSK74m3Eeb/uDIXV1mmydTf1ocZwJ8BCJQ4Zoy8H5rjoXf8B0WmzQ5YYw/XH1wA
         JQ8HSV8ZUTPRjd7ysGXFg3FcDRzoM0zIq8y4ghDZOwu1sclxRXhMxWHib/yr8QM9T+ot
         4b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274328; x=1757879128;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=KRaRZMvmjvQWhd2gIG3Oi2FwV23n4XNcYUBwrl6EYIeM4bg/OFtvbhdr+/72Ug8GVw
         Q1Pw23w8DOhDr37H9Yo6hSgj18+DulkSLROOjon/tVQiyqXoTI3cGGFNej+1D8vr2ROW
         yH7aTZJ04dW9AbKdkfLm9bAkjDtcD7q75m3/yXs6cVSSWZYF4/DAeAqwEyHTiz3WmMes
         4xmL2ha+CLQuHyCeFCEfHvDEEuGS7hITvArh9XeY0sschYUEMKYKwDIJfNDwQwpzk40p
         0XvsRR6cfWYc+E399ebkguHVqG2WVst8GpNhe+49hZT9hho1wlMVv7s38jetQIJqLXy3
         gaKA==
X-Gm-Message-State: AOJu0Yzz6PNL2nRr9flv6WZ4ZYHIgim8hBf2r0YT+rlacBVJJ5fxNUPt
	5EP1QVEED4HyKuZwKVP4rLIRAF8ZvjkSVDRNLc62Yu9rEkMxW98e/04YvDv0VGeL
X-Gm-Gg: ASbGnct4jISxFOeDCS278zQHTNGMHpYeSFysCgt4PAH6Ebfuvv+BAx4vA4Z4DOjNaxh
	A1+vkNJwFPH9IJD+D1PPFcprQr/nNAMxSIATEjbOvqB4KCxrKfG28T8C+WYz35noxQyN4I7HoG/
	efpV7LZSZBeVshZOb4EG+5ALOd+QZ5rR3eJi90kgsNmneq269CwVf/T0PbyOKvB8DyKoW4o2GE/
	R9Apj2aXuhBhDRR2oz/tAUr04Nzki7ycdJ+G5u0PQq72SucTCsGQCEo6GuinBs/HBi2ffGVkdsZ
	ggbLqtx/sqEmJnl4gztiRtBWNv1No85+5Y6odFrm036z2pZZZnKYjOnUkL9efT+3TLzIbDP+ddn
	ijp5f1cvRSZR9dPYKZ4xNZiw=
X-Google-Smtp-Source: AGHT+IHYRBx3Fg3EEzj6rV7R3RkPQmFy2Vl7C2cCziu1wrWfT9zBo6QLcEJK9Y+e2aPtDKQNgkyfuw==
X-Received: by 2002:a05:622a:181b:b0:4af:890f:ff9a with SMTP id d75a77b69052e-4b5f836d8c6mr62806841cf.4.1757274327694;
        Sun, 07 Sep 2025 12:45:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7838edsm84253161cf.39.2025.09.07.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:27 -0700 (PDT)
Message-Id: <6cf371ec13d3e57ea7d679a0170951d0b0346349.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:08 +0000
Subject: [PATCH 05/17] xdiff: delete struct diffdata_t
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


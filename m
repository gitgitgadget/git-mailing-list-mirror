Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2F30EF67
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662684; cv=none; b=q90wXcM0s5h155+Lkn+NHBf4nbmrZJrxb92+KyPtJ0c6S++aP6IiDIAkAC+azm7p1CQZAtua32ZxT7n0XQhpBsZShgRKCr3HHi9BJpAPfDkhJNnUtBK6HM0WgV8G0HFJ4c3ZJQh8E69rpS/8YSZSRtMvujcsrYcnkTZmpeT2vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662684; c=relaxed/simple;
	bh=zejrKiRM2CWHXswyfUP3N98+xfqSySoV4HBV8AsHsIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t3MQAYkACNLplP22IMS+20aVdzQ/KKbtbr+DRc6+V3fxppQZN+vvKokAEZgF09CbjVM44Q4Ok1sjwS1Q3V5EKMuJLF9lNr1l1nhCDMbwcfenPMXujqSW+U7ulVlDvXwhq+6pzvR52HdK+jHRvOWL0OjRnBCmdH+iXkz8CJV36d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmUMvD0a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmUMvD0a"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so2212341b3a.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662681; x=1759267481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=TmUMvD0aLts5mLBqssLzKLt3wqWfdJqhlun43hnYNw/g+HmUKqnakEK/A6g5/YmFw3
         cDE3sXlK8ETUSP9ABthaLIt/PqumoDor7j/SfuQ7eHrMlyxoWDnxxOO98vSc6AlfgpsM
         v39T0ZLI1eDtvfeTQIaUc+wWk8BwTKsIWal6v6tTjtVYiabD+oj2BUYE0rRGpDlXIFNV
         6/e1SvLyPsDxtC5woPQguvR6bVrsYuRKP7vhS43d0FHos9SdiuF7ZpaRcpUxRbu2ys8C
         l4a0HrSXGLEH8VXmIh8VPSBkssOqZPDUyI5SbDUjk0UXJoTIekJhNuGDYE1bJsBcWvgn
         4QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662681; x=1759267481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB5dXkFmZhV/7QB2sUSgNwH6HYy+KsDLd6IWSEcjAeo=;
        b=utFdN04N0fUqGvQsQEEaH2go/CPuTTeliCh73WO88+jFm35Fb+7Gr57uh4CqIIHomx
         5o+N+JyPBiCOHvlb0QHTC89SOxnTzjgAbVHU7xnwxmH4k8VdEEzPvF87Ievz1A7kOkbw
         BWr4L1yWHF9x8+8qLKrxXTdIbGIdHVH2BS1mDfDSZBmd/ubD7tEn0c3Eg3eRODKYoWq0
         1oxIcYeq1Jg2aIUNACZVVg/lB+lGUA88w5giQo+NDwqc3iZnsAK4f59awwU9EuVcBTuS
         TNEFOAOZ69meO7vQori6jHRp8pOO6w/oFpOE2lsfeNOSuVPXs8YVG/NVuEhe1twjL+7I
         V4SQ==
X-Gm-Message-State: AOJu0YzD0obVLOXrdo55GM8NTAtkYjl3CxXVqc3YXXIJivbuyUTbPlRN
	9+JQWVEVQfFAWm3K+H4OAhS3B+l9EkwbDLZgTCak0L3mOz4C8GctLBFdexdKuu/X
X-Gm-Gg: ASbGncs8GOaFzTX+ux/aHwPp3A3cNQlurbv+cxzBm3rxeq2QzsOlMXjUU6m9P8LGTH/
	Fk1P8BWBQgASkL/xcx5wnL8LpeF6tNF/7qu59wod77sZKW3kiFW3OLC60HeJ9q7o+9UC9zprFNb
	5FpHmLRJc3fTckjRRHmIRAsV/29WjJWPYLwmCj2Dqw54xCyUlo7iRKN9Nn0dpShFjDb1Szv+EZ6
	Pwh9Yo1m3KwwvpsA5RZe9R2W2qn+cQj8tjwUuVbQX3Aw2wTShY8wWxECWrSyCHNfLZASfTS3ng7
	gCXWMA6DEbpH3tbtG70vBvYG3UXOiW9JygwMHid7WBOOGd7Dsyq6Owk6taGN0SJetdRLl8gzSMu
	mvxtkfn7Oa9i21jQxMu5xU0ZgCg==
X-Google-Smtp-Source: AGHT+IGbvV8E/qlqgbUZYHoiFum+cqtnX5LnB5NCEFwf/rZqa9GOiMWdgb+VjIcMKy1y7JNdXXyNTA==
X-Received: by 2002:a05:6a20:4305:b0:2ac:7567:c070 with SMTP id adf61e73a8af0-2cfdf4794bemr4225927637.9.1758662681563;
        Tue, 23 Sep 2025 14:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a6c47aa2sm1743002a91.1.2025.09.23.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:41 -0700 (PDT)
Message-Id: <2a3a1b657ec5f422525f61b8047b3631a587ddf1.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:23 +0000
Subject: [PATCH v5 06/13] xdiff: delete struct diffdata_t
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


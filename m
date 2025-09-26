Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660F2BF009
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926532; cv=none; b=UHPW0rzhOJQOuXtJvbo4xLtnuR6nDxBKNcCAWG7HEmoFl4HF8o9FFqNOi0EbSkXwpYpdtjBW5lhajX+6JiZ98SBKMwa1YaYP39q0pkKhF5umZgzRButznwa4uhgNdfYzg5bFH3nHkUcv/U8+NfzOzmz/XdmlzxU1atdz7ohHmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926532; c=relaxed/simple;
	bh=4ffyndziyhHIuHeYG009hlUjNuYdogIWeR/9qL7mtsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VYwvn44EZlXKBYkmn4jHE0LOMOYZZp+8+ARhf5bTwi8MtqbXBRjibcWb0PP3W+PC/YJUQiahOE3LNe6uEiodz0LFmOav8loLchszP/YzxyMwJH53Dl0tixKEOrNjYMhPheDmQJu7AhQZUUof2DmueCD+UItksPDGTxtYVzBhI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4LMMAzf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4LMMAzf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so3709270b3a.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926530; x=1759531330; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=K4LMMAzfsqQgC2vRtUNHn/3OG9fvwbyiXG+YuTBVTdw76mdapUQiDJoY3m3Scxp22i
         EFP1LJGdnzwxfgdRy3ItU0Bca31aj8nKF/cwKKUbwgBGE+ZCwJXhKvTGDSaf+Yjw62ij
         +HJZyv91ysSDgq4rCx8QWpVdY1vyMko8PUR0RPnO4MD91L8ZLCnlahLMVtO1hPC2vBoa
         fscBEjP2Ep43NyNGSz2ONN/KweBTZ6Wl0u3p72j2ISrpEPYthXVbzBkiMXgdZSSPYaJ9
         hc6gY68X78jJ+u2A9YjJmWvyAvsqB0Hc17YTwXyM1jJNbgsAO50G4Ry4dg6xf2HZRN2E
         plUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926530; x=1759531330;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=wDvaIbuPNf0da8DTTSmB/yJSX76t3zSY4JkcYKcQBBZlAzIyPnaq0Cg4SMS0J+WTG0
         mN7PKYiRHHNkrRgAzOnH/bqWTzyJ6wuuw+lFE134MJ2947WFv3f4R2jno4tZ8GzNCcl8
         7Fw1Urc+HoZthGd8dOtRohf5y3VsOIp/+35Z/gjoc0aS7qA1fkLljHLRXAktHoOkWl9S
         JUzs2KN4TgDBdSrFrY47HO6icnalTMp/4rVNDNxCKISEszgeUdjALtaKUl9P0/jvVCAZ
         xO/tOy2mRipaH2Cd6jvQ+z5mUIg2HmxXGrr7QH/3+fd6l8lCG3gvlWYD+2xuCI6KSBfA
         TQtQ==
X-Gm-Message-State: AOJu0YxuApXRr/sE2VXlZHwSFhIbwDxsfl3Qj8otXkTBfd0sf9SznP41
	WyKRN7GxYNOYdfOCi3EeFBNpUSVh0blwZJ2vyF9TythjhfD/QAwn6AXTEg5rwKHP
X-Gm-Gg: ASbGncsQmaJ4rvJKt6b77MJJPdXYaCF/mLYedbj8r5JLJKLHLN4WMLviP/FUzdm+2D4
	HJzZiSCizb3G1IrJpRFIAvSszmHEDspAT8MJ1g/kUvWWyBmmBEXRPoHT5db2qRjk64itQxot8bA
	CSD3hKdHV6vfUkhmWNQQ8lzxYnFGwNwHEJF2gaCbLHUfV80LQMR27fj1lNGzH30WY5AYIBB7MgV
	EecKVhJYr1iDxguR3EMrmw45pgNG20Vi4ApBb5d5p0nevisIDet0KRqhjZGABWi4OkUbkktb0W6
	8j3A+k2RscK1QwhX6/2eCZsprQYRyWp0ghuVNE5tm5/mLM7jRvN+Ic/TuaQKdV3gBexcney7ueX
	E0/vRo1oWAr7Brt8AfaK6+OX8
X-Google-Smtp-Source: AGHT+IE8Z9ztzGkC7VxcoA9GRYaSDmSm2C1b9M3K1emrcOupjg5NPnhhhh3anHXe5rKcxsFp2FW0yw==
X-Received: by 2002:a05:6a21:7e82:b0:2ef:4635:4fff with SMTP id adf61e73a8af0-2ef46a02466mr6675593637.26.1758926529951;
        Fri, 26 Sep 2025 15:42:09 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023d5c73sm5204345b3a.41.2025.09.26.15.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:09 -0700 (PDT)
Message-Id: <637d1032abbd33b7673d3c101267816fbf1a343c.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:54 +0000
Subject: [PATCH v6 07/12] xdiff: delete redundant array xdfile_t.ha
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

When 0 <= i < xdfile_t.nreff the following is true:
xdfile_t.ha[i] == xdfile_t.recs[xdfile_t.rindex[i]]

This makes the code about 5% slower. The fields rindex and ha are
specific to the classic diff (myers and minimal). I plan on creating a
struct for classic diff, but there's a lot of cleanup that needs to be
done before that can happen and leaving ha in would make those cleanups
harder to follow.

A subsequent commit will delete the chastore cha from xdfile_t. That
later commit will investigate deleting ha and cha independently and
together.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 24 ++++++++++++++----------
 xdiff/xprepare.c | 12 ++----------
 xdiff/xtypes.h   |  1 -
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bbf0161f84..11cd090b53 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,6 +22,11 @@
 
 #include "xinclude.h"
 
+static unsigned long get_hash(xdfile_t *xdf, long index)
+{
+	return xdf->recs[xdf->rindex[index]]->ha;
+}
+
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
 #define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
@@ -42,8 +47,8 @@ typedef struct s_xdpsplit {
  * using this algorithm, so a little bit of heuristic is needed to cut the
  * search and to return a suboptimal point.
  */
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
+static long xdl_split(xdfile_t *xdf1, long off1, long lim1,
+		      xdfile_t *xdf2, long off2, long lim2,
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv) {
 	long dmin = off1 - lim2, dmax = lim1 - off2;
@@ -87,7 +92,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdf[d + 1];
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 < lim1 && i2 < lim2 && ha1[i1] == ha2[i2]; i1++, i2++);
+			for (; i1 < lim1 && i2 < lim2 && get_hash(xdf1, i1) == get_hash(xdf2, i2); i1++, i2++);
 			if (i1 - prev1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdf[d] = i1;
@@ -124,7 +129,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				i1 = kvdb[d + 1] - 1;
 			prev1 = i1;
 			i2 = i1 - d;
-			for (; i1 > off1 && i2 > off2 && ha1[i1 - 1] == ha2[i2 - 1]; i1--, i2--);
+			for (; i1 > off1 && i2 > off2 && get_hash(xdf1, i1 - 1) == get_hash(xdf2, i2 - 1); i1--, i2--);
 			if (prev1 - i1 > xenv->snake_cnt)
 				got_snake = 1;
 			kvdb[d] = i1;
@@ -159,7 +164,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 + xenv->snake_cnt <= i1 && i1 < lim1 &&
 				    off2 + xenv->snake_cnt <= i2 && i2 < lim2) {
-					for (k = 1; ha1[i1 - k] == ha2[i2 - k]; k++)
+					for (k = 1; get_hash(xdf1, i1 - k) == get_hash(xdf2, i2 - k); k++)
 						if (k == xenv->snake_cnt) {
 							best = v;
 							spl->i1 = i1;
@@ -183,7 +188,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 				if (v > XDL_K_HEUR * ec && v > best &&
 				    off1 < i1 && i1 <= lim1 - xenv->snake_cnt &&
 				    off2 < i2 && i2 <= lim2 - xenv->snake_cnt) {
-					for (k = 0; ha1[i1 + k] == ha2[i2 + k]; k++)
+					for (k = 0; get_hash(xdf1, i1 + k) == get_hash(xdf2, i2 + k); k++)
 						if (k == xenv->snake_cnt - 1) {
 							best = v;
 							spl->i1 = i1;
@@ -260,13 +265,12 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
 	 */
-	for (; off1 < lim1 && off2 < lim2 && ha1[off1] == ha2[off2]; off1++, off2++);
-	for (; off1 < lim1 && off2 < lim2 && ha1[lim1 - 1] == ha2[lim2 - 1]; lim1--, lim2--);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, off1) == get_hash(xdf2, off2); off1++, off2++);
+	for (; off1 < lim1 && off2 < lim2 && get_hash(xdf1, lim1 - 1) == get_hash(xdf2, lim2 - 1); lim1--, lim2--);
 
 	/*
 	 * If one dimension is empty, then all records on the other one must
@@ -285,7 +289,7 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		/*
 		 * Divide ...
 		 */
-		if (xdl_split(ha1, off1, lim1, ha2, off2, lim2, kvdf, kvdb,
+		if (xdl_split(xdf1, off1, lim1, xdf2, off2, lim2, kvdf, kvdb,
 			      need_min, &spl, xenv) < 0) {
 
 			return -1;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3576415c85..22c44f0683 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -133,7 +133,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
 	xdl_free(xdf->recs);
 	xdl_cha_free(&xdf->rcha);
 }
@@ -146,7 +145,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
@@ -181,8 +179,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
 		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
-			goto abort;
 	}
 
 	xdf->rchg += 1;
@@ -300,9 +296,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (dis1[i] == 1 ||
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff] = i;
-			xdf1->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf1->rindex[nreff++] = i;
 		} else
 			xdf1->rchg[i] = 1;
 	}
@@ -312,9 +306,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (dis2[i] == 1 ||
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff] = i;
-			xdf2->ha[nreff] = (*recs)->ha;
-			nreff++;
+			xdf2->rindex[nreff++] = i;
 		} else
 			xdf2->rchg[i] = 1;
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8b8467360e..85848f1685 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -52,7 +52,6 @@ typedef struct s_xdfile {
 	char *rchg;
 	long *rindex;
 	long nreff;
-	unsigned long *ha;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget


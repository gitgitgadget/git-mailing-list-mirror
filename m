Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8330C36F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662685; cv=none; b=gCxGQTzozPJo4oPQNvEO+dTNNdvOB5vdu9Fkva8TxXh2HovOdwB7DX2GG+26SR+glCrC4AllbGlfXLDOHl7/8NL8pB31loIXL0/wSpw1zV3Z+dLlct1gPewwqQpQYP6itKttytUf3i/2oNiC3T+FpjXDFIriz8eRbWXpRbqS6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662685; c=relaxed/simple;
	bh=4ffyndziyhHIuHeYG009hlUjNuYdogIWeR/9qL7mtsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oW1wg5tfbDDGBKd+JvGMdW1AW7LDIarV71rI8+qLcfBOU+N/4pGdbCSQWEsOg4DxZcMVV+wsCXDuGP/1qAcQlkK2mkbHiW14prGQIFRModnilL5rgk7rhPTDhn0ED55YL2dBbUorHolh+WNCkHcnKLYZmdjjyr+UKQ3iYvshmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXmB8GGX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXmB8GGX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6209472b3a.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662683; x=1759267483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=lXmB8GGXLqswSW/cVHSLBDG7zf5BAwZ8QvMieiTlhYtRy7Y2nP2RhyDnb5z6zXI/Yg
         sTfBiQnnlHrie6RIwbQrEcUQu1bOffyN9wsy+Yp2cREBQMr2T74rBeS66w2G6T9/kPlA
         cRqHerzk31aM1RRwEQGtClv6QdkPPH4BoANWIHbcdr8eosSaaVSGqqyIbsJ8vHoySN7r
         lrJCa1Kv0syRWl4htEQZFMUTK3F9jjziOtqwT5VoyrOAL4RWRFqQcmelxpCMYThH5PNS
         yq5ey/yiNg+HEz3DE6gX7S5IQ4AGDkXRY4yJqGtc7/DtoQi629A1VghYXCMUJsFuSd4d
         c3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662683; x=1759267483;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfMvptJJvfkRovwlo/33OdZap/BiQk4tTTuyNi1QMCY=;
        b=YdZfydC14gToSbaBjQkPgvkhUY8Ux2XQyrvP2rG471UrsCUjRdba0VeTvv682zmlGU
         mzE/Hd+qco8bOOHE9GmhpEjY0/TTUTlJPDsB72HyjSakRpaTdroO93MGgcc3I/pAtRqS
         ba5sglR+uJA4x46mPF6OKv8wCSl6dOtD+uS6hqDw27nINhHeg0bhJt4rIdgP/wsuotJe
         v1POG7CR3fnw1PvP8pVyb/XYkNW54CKzxPKOQoHuBE1MmqJ61vzJ7HIcxefimHrJVIc4
         juobXbyDPN1/DyxghiV8ErhcF7/ZeMKsNcXTq82UnIG6Fzay/u6wH+QzZsMHqgNMt/f+
         J+3A==
X-Gm-Message-State: AOJu0YwOAYFoUFs5JgTsnHt4ceQYQVdWKJdIdanoopUaDINqdO8adGG+
	DZRT/OT1WZyPfo/33GMeXx3RA6z+7Vc20C+CsZsCDGekqsi3cJ99GYh0HZF6DwnQ
X-Gm-Gg: ASbGncuclWVhKUq6muGJGs8AQu4hI88/AkZvNt/TrQF9iDoUiy92P7X7BCBWOImJMJJ
	sKSpBUlJRlSwFnIZMCuRS1Cu5IEHLUsUzrmIAD648n3M52iOlIgThsO/FXom9l6Y/OHeTGvjD0x
	b+fk0wjX7WShOh+4yqwlT9SNDsxU3D3gtMDXExJ2iR4urp42i3QSAmNZ1oAlHQkCQq3cN8GdtW9
	UWC0FQnRo+fhkRJb6c/Bzfwb5PAgNZ3X9UmEfdLVPb3phA2HyCOdYYixs6eTEi1bSbIt+QEPyEM
	ZJiHWumiTvIOGycFwu5RshisCYXl98gMBH9KbIIwU4yiPPzAJww5xDnwMW8YLDkAlvfmtLlXBI1
	WjbAdu2Ion3eO5UsS9apb7Pb6nw==
X-Google-Smtp-Source: AGHT+IFEt+iG9uss99exZ+vKWmW3NajZSTIuLo6LiypPNv3/6G2FrM2cexYRYUbJNN1s4DIL9Hj4VQ==
X-Received: by 2002:a05:6a00:cc4:b0:771:ef50:346 with SMTP id d2e1a72fcca58-77f53a2c4ebmr4432295b3a.15.1758662683078;
        Tue, 23 Sep 2025 14:24:43 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2af8e535sm8611759b3a.33.2025.09.23.14.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:42 -0700 (PDT)
Message-Id: <4c6543cbe390b37c7847cae6b2a8cc4223c225bf.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:24 +0000
Subject: [PATCH v5 07/13] xdiff: delete redundant array xdfile_t.ha
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


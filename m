Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2E31A058
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570729; cv=none; b=r1/32vbpP+N79noTIsTnsKmSEvJDOjmcEOVE8phON6MorkC9oRbpVW8ZEP2bo38dYo/FuuXuw+svG1nBa6xGFjN1s/BLhYcVrwpaKKc+eF5YaBYAubC7HO6/ZQLG4Rlwtpt9oIpzYC1BpVW6x/SJ4Uo09te/Dg+tc35R8gnV7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570729; c=relaxed/simple;
	bh=ZV3MnpGmFw4WPFrDf7GtLPf08/iB3wbi1UeFKwRCOTI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mq/bYvmoAGGoWt20ACvFpi316lcUtUvpmX85Jxt02qddgq4ISE+RqlPNUcdv5nEcsvqhcx9O7rQFHc7N62LvLUAG/PM8KiOLLnNbj4cc6m5BDRuYO3sdafATPaPealD/vjBfUXi/mdBMlgJrryq0P/nMp0nYTY5xzqEA+R2jUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZwyEQ2D; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZwyEQ2D"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4256f499013so10242295ab.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570727; x=1759175527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QyYfzDW976KYyiSgnXECUI/sS2R0J2KxPzP4McpykY=;
        b=eZwyEQ2DpcoKHL1fkGpj2iRO9w6kJIbma1WGgtPQ6doPIVX2NQxn7pkHGL35n1gUuF
         vLIoJb3+opyeHhmiLk/1OmKO7dp4Vvlx/0aOnJCiONS7i70iPXf0ynYk7jYAc6Q3ohwN
         GfMwEQ6wqGpQQKNUJBSKc8IJ27xRBl4Aq32STXM4/akGBn/6Mb8Ekcix8st5IunSdtM7
         iso9QQ4Kg374dSykhL8OLEROQHY9kB4gYR7RHv3kowaRXCgS8F4XB2CX9vQ9RWvk/H67
         UvMbmgyL3SGz1So5NWio6MviHQBR71o3yE2fskt+2iFXjDvzZg1Je8k29a8XeOs7vMKo
         eAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570727; x=1759175527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QyYfzDW976KYyiSgnXECUI/sS2R0J2KxPzP4McpykY=;
        b=V7Oly3nZmMmQ5wrNpaSuRa69CT5OAvwWKFm1nZ7YGYFJFsDk9tUI84SBOMwB2nQa0O
         6JlqZXJopgONFCT5MqvNENW2HPfyfk2I8nLMUlcd2ZZVPTS7534ZXtqwRjLiVp9Nu5x3
         4h9bnSeB+Ij4fguPzc0WdT8uTyspk/O6/yZvIta9fpzJg1BAd1kpJwtxGo74OKGA7KDY
         8pRrUG0FCBNiAcd4yvOKMuwGbkQHV4q6YUCrL2JgEuUNeR7MEcEMpYL5502AcLxZeOBp
         Nh9ckDKvzSQaBGsu0cTmrP2S5BjoHocoQJ7xuWbD5WCxI7oggHJzkU2WXhdzGajZA67T
         dpnA==
X-Gm-Message-State: AOJu0Yx9F3J6zDFAoTtjgRzJeJizOVjpEfea9+2bOg7ztFkxENTkCXwZ
	cEsyca2xqf514w4rgCKrsrfn9JGLg1XY/3+tK470F5YxrxRAYmICiUfZD8my+w==
X-Gm-Gg: ASbGncv+wrG27t1wQfm2iSMkLlKlzZryGyxqGmTPv4F9HxXSfltqhVOUUzKWIFw98fF
	AYlVyMA682f5Fgg6vVwVV4tjQf/z7qNtV6OpvU3WA8k7YJVkGB23nubk5ggoITwzaS0l1U66ZpM
	D8eUQWKyrSR3ibW0Q4FipOaEicHqwAQsDTOAwqwyJURWu01XIEeyGZIskHqZgLxWf5ZpjSd5E9C
	8uB8ouy/BM4k/OKYPQuWBxpJwWgjG5RoOqd+ell8fC3DaFZREtNnTf+6YQUTVsNSL6eoPbT6Oec
	UvuOFYvwCvIJfsfCBZpVU8VThkTV2FuLJnx1uaHlknWOvEGi2XYfCA+pH4A0G2L2RtioGCE3Rlb
	3J2Ulp/WqQU470ENA6GS2DPFW6w==
X-Google-Smtp-Source: AGHT+IF2P0SQomW9JVc8m1SSyF9rS96F7maEokUA/xpxlCp8y8Xc5bmqfnvNC9MN+Q62YtAlNxAyEg==
X-Received: by 2002:a05:6e02:1a4f:b0:425:720f:deec with SMTP id e9e14a558f8ab-42581eae239mr1623375ab.31.1758570725653;
        Mon, 22 Sep 2025 12:52:05 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556bf59a051sm2703194173.80.2025.09.22.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:52:04 -0700 (PDT)
Message-Id: <b544c15a6762ed5675a632b3ae75eb58db0d888f.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:40 +0000
Subject: [PATCH v4 11/12] xdiff: use bool literals for xdfile_t.rchg
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

Define macros NO(0), YES(1), MAYBE(2) as the enum values for dis1 and
dis2 to make the code easier to follow.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 12 ++++++------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 27 +++++++++++++++------------
 4 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 83c4cff6f7..6213ce7a03 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -753,8 +753,8 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->rchg[g->start++] = 0;
-		xdf->rchg[g->end++] = 1;
+		xdf->rchg[g->start++] = false;
+		xdf->rchg[g->end++] = true;
 
 		while (xdf->rchg[g->end])
 			g->end++;
@@ -774,8 +774,8 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = 1;
-		xdf->rchg[--g->end] = 0;
+		xdf->rchg[--g->start] = true;
+		xdf->rchg[--g->end] = false;
 
 		while (xdf->rchg[g->start - 1])
 			g->start--;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 4d857e8ae2..ad88406656 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = 1;
+				env->xdf1.rchg[line1++ - 1] = true;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = 1;
+				env->xdf2.rchg[line2++ - 1] = true;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bf69a58527..042e889348 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = true;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = true;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 27c5a4d636..f152e3acd8 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -29,6 +29,9 @@
 #define XDL_GUESS_NLINES1 256
 #define XDL_GUESS_NLINES2 20
 
+#define NO 0
+#define YES 1
+#define MAYBE 2
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
@@ -212,9 +215,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	 * current line (i) is already a multimatch line.
 	 */
 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (!dis[i - r])
+		if (dis[i - r] == NO)
 			rdis0++;
-		else if (dis[i - r] == 2)
+		else if (dis[i - r] == MAYBE)
 			rpdis0++;
 		else
 			break;
@@ -228,9 +231,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	if (rdis0 == 0)
 		return 0;
 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (!dis[i + r])
+		if (dis[i + r] == NO)
 			rdis1++;
-		else if (dis[i + r] == 2)
+		else if (dis[i + r] == MAYBE)
 			rpdis1++;
 		else
 			break;
@@ -270,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis1[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -278,26 +281,26 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
-		if (dis1[i] == 1 ||
-		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+		if (dis1[i] == YES ||
+		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = 1;
+			xdf1->rchg[i] = true;
 	}
 	xdf1->nreff = nreff;
 
 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
-		if (dis2[i] == 1 ||
-		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+		if (dis2[i] == YES ||
+		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = 1;
+			xdf2->rchg[i] = true;
 	}
 	xdf2->nreff = nreff;
 
-- 
gitgitgadget


Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4A2C08BF
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926538; cv=none; b=mgZL7eFSSTY+C+P1QSf51WFmRJHsv375UPNCPu2uNcG2DIMgRzBxysALn76qHK1lxMyvBRX1nTOHVkI/sS1fvLgD34k8+CXFosvqkXWI4UsJOoV2vUF8eCiRVyHCZlVRNbuBTDtzDZFeRxiaZHi0mAf7l8uVNfVUYhkdOz2VnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926538; c=relaxed/simple;
	bh=hEcHIR0XKcsfG69wWOjF6GMCsbBVuG1Gt4DYwZ0JDbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QPwzuRVNcXHMoE3Dc1+zMJ36+07768j+UE/6BZqOJtT8TzXvLu0tKTZnm6D54HQTaV7SiJ04TsF5W/EmzKQ7bZa72VT20Ry/C1DLXYxdsCLgwNBaN3+ZccRSbZfGcmAgDM+C9bvKEB5U4f9nhQ4I4nkkZzVBLPwlc89NVXqDnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmMOc8Fl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmMOc8Fl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330631e534eso2736584a91.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926535; x=1759531335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjaGdeiU3y1J4318+KHiBYMkFhnKsKdROJYcaXYIp7c=;
        b=LmMOc8FleSFB1VsxJ+qSDnASwpzPlzxM/v659wZoS71qv0O9BIFeS0FvEWaz6QnrXX
         x0c/n5SjrTXrpVuwJT96rx2UC62dNotq3s7FfkxodklNsLsFb0NhK0DcghqAxRo7AyJm
         An1KmYUyN4NpUFOVMMFGZTZLv5fSlUZdSH/7/y6n6Og89wJOO8XQQ8P1XzjFtRnptmPU
         tQl4QiyqtGnKhKNEvva8KMGFRTbR3zHYP2ueEW1Ryg/HeVCpOFNTPg3rQ2eKyUz3RCsQ
         hGRNRtn7F7lq8YzygrhGQ0SFfw6/cnK+7yUUqLFh58yk5DsHIYbSTCIHztneelqVHcaW
         H/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926535; x=1759531335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjaGdeiU3y1J4318+KHiBYMkFhnKsKdROJYcaXYIp7c=;
        b=vLX98RBut/ZB4i3CLCMCXkbewzDBpP3LLJknrKUkEgRTpnG+JB9qzgREvafgwrduT4
         jOOgZ3Lz1wEWBuonZCz2CeGgLZ2EYKHzkrPNO91UnDWyicB0Envb0AW+HW8WSrRN982Y
         vRMEwGAssd3ysVpG92rDfEij/Sk6P3xJ21jhhKK+Ga1ItPoUloEkAnREQkriMhLRO9lV
         3c7ShdoGUkKdwys48fbNWhNCDZ9S4oM1ioyRgpLoWnZZ4YEImVgqHrX6kv4EW7zNUD7K
         AEW7CyhTpuYEhc8jLQopQsnOuiTdRxlKle+2ggGt8Y8n4MijO65tzwblGBf9KanBoKMJ
         ChUg==
X-Gm-Message-State: AOJu0YzB+Gnul4UPClw8kAafvG7Cd8dDv5xvyO6hneVwuPG68zEdiUp/
	QY7XBAxsqZXSd67r+Z2TWsP21e8goICIWAHAAMKMZN2AX7peC2Iyic4CV4fSQbyU
X-Gm-Gg: ASbGncuWlJlHS/6uq/DwNHSCnUYi84ctUjXt5OyYjEeA3bYtD2zh7s46aZV9uotWT3h
	FUbRPRmM0Eymvlh4d4EiQzUjIJmfHf496klS7YFvIPoQhIhIKZcVlcFN39kXzV5ev+pkOBGrMol
	tbten3x88GJir4kKQcnPXRMrXPVQ8TMGjmbCfHNDi5AaV+ERXl9+Yd1ZAMQVm+DJHhC3L/Rjiq2
	fyuX3Ma9BCF/zmPLVAzuKCeTONEsYxckgYpyjPGeFntV7r2Wvcszp90cE+mZ8E8baoLQ2TyDf48
	uMn0/bckGo1AH1wicuCdiUl2rLBocVJ4wlxT/mc6BrABTQCM8SJTVyR7bWb7fjkTDHrAa7VhrRw
	tPDC2+52szO9MBDmEsPANJhhWShWb+h5tT/sNRFntHJU=
X-Google-Smtp-Source: AGHT+IGuoZHRlaVKsVZ5pxdaKpr5asgGJPEJvZpi+vuQeBBB8IWsVa8zPHnkd9oh8LpAl2IytxM0gg==
X-Received: by 2002:a17:90b:350c:b0:32b:8b8d:c2d1 with SMTP id 98e67ed59e1d1-3342a2b13fcmr9242815a91.21.1758926534596;
        Fri, 26 Sep 2025 15:42:14 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c559fd56sm5575486a12.38.2025.09.26.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:14 -0700 (PDT)
Message-Id: <f08782a97795662cca744817a33bd8d9e340b999.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:58 +0000
Subject: [PATCH v6 11/12] xdiff: add macros DISCARD(0), KEEP(1),
 INVESTIGATE(2) in xprepare.c
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

This commit is refactor-only; no behavior is changed. A future commit
will use bool literals for changed[i].

The functions xdl_clean_mmatch() and xdl_cleanup_records() will be
cleaned up more in a future patch series. The changes to
xdl_cleanup_records(), in this patch, is just to make it clear why
`char rchg` is refactored to `bool changed`.

Rename dis* to action* and replace literal numericals with macros.
The old names came from when dis* (which I think was short for discard)
was treated like a boolean, but over time it grew into a ternary state
machine. The result was confusing because dis* and rchg* both used 0/1
values with different meanings.

The new names and macros make the states explicit. nm is short for
number of matches, and mlim is a heuristic limit:

  nm == 0       -> action[i] = DISCARD     -> changed[i] = true
  0 < nm < mlim -> action[i] = KEEP        -> changed[i] = false
  nm >= mlim    -> action[i] = INVESTIGATE -> changed[i] = xdl_clean_mmatch()

When need_min is true, only DISCARD and KEEP occur because the limit
is effectively infinite.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 106 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 37 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b9b19c36de..55e3b50ce6 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -29,6 +29,9 @@
 #define XDL_GUESS_NLINES1 256
 #define XDL_GUESS_NLINES2 20
 
+#define DISCARD 0
+#define KEEP 1
+#define INVESTIGATE 2
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
@@ -190,15 +193,15 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
+static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
 	long r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
-	 * Limits the window the is examined during the similar-lines
-	 * scan. The loops below stops when dis[i - r] == 1 (line that
-	 * has no match), but there are corner cases where the loop
-	 * proceed all the way to the extremities by causing huge
-	 * performance penalties in case of big files.
+	 * Limits the window that is examined during the similar-lines
+	 * scan. The loops below stops when action[i - r] == KEEP
+	 * (line that has no match), but there are corner cases where
+	 * the loop proceed all the way to the extremities by causing
+	 * huge performance penalties in case of big files.
 	 */
 	if (i - s > XDL_SIMSCAN_WINDOW)
 		s = i - XDL_SIMSCAN_WINDOW;
@@ -207,40 +210,47 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 
 	/*
 	 * Scans the lines before 'i' to find a run of lines that either
-	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
-	 * Note that we always call this function with dis[i] > 1, so the
-	 * current line (i) is already a multimatch line.
+	 * have no match (action[j] == DISCARD) or have multiple matches
+	 * (action[j] == INVESTIGATE). Note that we always call this
+	 * function with action[i] == INVESTIGATE, so the current line
+	 * (i) is already a multimatch line.
 	 */
 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (!dis[i - r])
+		if (action[i - r] == DISCARD)
 			rdis0++;
-		else if (dis[i - r] == 2)
+		else if (action[i - r] == INVESTIGATE)
 			rpdis0++;
-		else
+		else if (action[i - r] == KEEP)
 			break;
+		else
+			BUG("Illegal value for action[i - r]");
 	}
 	/*
-	 * If the run before the line 'i' found only multimatch lines, we
-	 * return 0 and hence we don't make the current line (i) discarded.
-	 * We want to discard multimatch lines only when they appear in the
-	 * middle of runs with nomatch lines (dis[j] == 0).
+	 * If the run before the line 'i' found only multimatch lines,
+	 * we return false and hence we don't make the current line (i)
+	 * discarded. We want to discard multimatch lines only when
+	 * they appear in the middle of runs with nomatch lines
+	 * (action[j] == DISCARD).
 	 */
 	if (rdis0 == 0)
 		return 0;
 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (!dis[i + r])
+		if (action[i + r] == DISCARD)
 			rdis1++;
-		else if (dis[i + r] == 2)
+		else if (action[i + r] == INVESTIGATE)
 			rpdis1++;
-		else
+		else if (action[i + r] == KEEP)
 			break;
+		else
+			BUG("Illegal value for action[i + r]");
 	}
 	/*
-	 * If the run after the line 'i' found only multimatch lines, we
-	 * return 0 and hence we don't make the current line (i) discarded.
+	 * If the run after the line 'i' found only multimatch lines,
+	 * we return false and hence we don't make the current line (i)
+	 * discarded.
 	 */
 	if (rdis1 == 0)
-		return 0;
+		return false;
 	rdis1 += rdis0;
 	rpdis1 += rpdis0;
 
@@ -251,26 +261,38 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 /*
  * Try to reduce the problem complexity, discard records that have no
  * matches on the other file. Also, lines that have multiple matches
- * might be potentially discarded if they happear in a run of discardable.
+ * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, nreff, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
-	char *dis, *dis1, *dis2;
-	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
+	uint8_t *action1 = NULL, *action2 = NULL;
+	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
+	int ret = 0;
 
-	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
-		return -1;
-	dis1 = dis;
-	dis2 = dis1 + xdf1->nrec + 1;
+	/*
+	 * Create temporary arrays that will help us decide if
+	 * changed[i] should remain 0 or become 1.
+	 */
+	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
+		ret = -1;
+		goto cleanup;
+	}
+	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
+		ret = -1;
+		goto cleanup;
+	}
 
+	/*
+	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
+	 */
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -278,32 +300,42 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
+	/*
+	 * Use temporary arrays to decide if changed[i] should remain
+	 * 0 or become 1.
+	 */
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
-		if (dis1[i] == 1 ||
-		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+		if (action1[i] == KEEP ||
+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
+			/* changed[i] remains 0, i.e. keep */
 		} else
 			xdf1->changed[i] = 1;
+			/* i.e. discard */
 	}
 	xdf1->nreff = nreff;
 
 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
-		if (dis2[i] == 1 ||
-		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+		if (action2[i] == KEEP ||
+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
+			/* changed[i] remains 0, i.e. keep */
 		} else
 			xdf2->changed[i] = 1;
+			/* i.e. discard */
 	}
 	xdf2->nreff = nreff;
 
-	xdl_free(dis);
+cleanup:
+	xdl_free(action1);
+	xdl_free(action2);
 
-	return 0;
+	return ret;
 }
 
 
-- 
gitgitgadget


Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578A30C629
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662693; cv=none; b=ctbRUiWsBqgRMGANpt6UHR71VBu/LeDtw8HSB99UiwzeaCZmqLyWj0DZAd8a80+OUCHroSoQNNZJOOp7NHemtTCwzwpab0f6vUwdXJKoAJOIYyYQeMwRiswXqXCm567W141FoPAYSKR72wkKtJCKG4cwxU5KMyrv9g8acQE7/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662693; c=relaxed/simple;
	bh=wiNV711XOQ3htY33WFXMnCUleJt7BVd7CB2C50CUGd0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gTf3lY1uzoEGZYJhbnpofRXsFZWI51AW5IhUI3mCTeGVZKQCI6+m1y0hfmuraLH3nUblfipiBMO5EQ0C/UovJr2uKV4Y9GbnTIrhdodXYEi4MgHb7OHZX0OIxHislCu7Oqgqh8afFVHfUHFNCBa1/Zew42cjTKXT3ZIfE9nQRrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVLV0D8V; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVLV0D8V"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso5738746b3a.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662691; x=1759267491; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEkhnn93/EtdBufBsT2wuugzbkiAoO9WuoJsUNpD/5U=;
        b=lVLV0D8VierZ9RseUfZEHkjbKNjUAd1Xp5weIii1vwL9APa4ObRoelcjbNsKQFHLw7
         rWhQ4bimnaKjhbkai4M8j9xmGKviEOOkZJwetJFxh7DpWJZHgZpc674avM2okID8dc8m
         gtkDLvPQunYeBkmbsg7oRVo+TuEkZ2CupHKjayw4lziiC1Z9+6L1os1qd/AMd3RbBBGv
         O82IlY1kyJQgfK8umTlU+kofYUmqEpeiW04APMVDYLSeWvBzH+wDwr1W4/A2f+EIrb6G
         yV5uWEjSXVd2SY8JzGoDzyjxhbMrAMqfj5KqCxibYZfqxN3dVGF9/cslOcjFsRl898Ml
         qy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662691; x=1759267491;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEkhnn93/EtdBufBsT2wuugzbkiAoO9WuoJsUNpD/5U=;
        b=t8uCEOqpVj8xchWS8IxGkn+S9e4Ys8k8sw2AMrt5TgPhRQI5A/Hl5qGrS50OwIwINw
         hcFQn3WpKzfy/FYQEMcScRrIVpYldES15SflUB7ydEhdWGPbRmLDPpZgf+U5Ew/4rm2M
         o4I6wzfrcZ14p1aLVp6p415Qq8MMuygi9ZCQh8JoYPajNGpoCoUssiz+HgctfNY319IQ
         pj5PwDNRlTargsm5OQCPQskmb4XoEmdKzaLsUVzBINkTHpmEvRzsE+0HqaGzEXEFsV1d
         q/LzfS8+ZrAUbrYNRrQIZGc/kNAdI3Sg/Dg9RzR9YWyPMX4KTo53A1goKb8BT/OblNkh
         xX8Q==
X-Gm-Message-State: AOJu0YykpN+PbSMsrpJYKlxKlbndvS68d78HlIWKRgcCZ6X/QJC4PDM2
	PYGVEgoet4wpBXI/oykTP7e+1YKe2iln76NhL8+Nf4seGNfXqtG49y239LsCp8F9
X-Gm-Gg: ASbGnctd0OC7KfVJgs7d4+imCBjHiDYtIZ9XAkSHGlZU0ZeV6Ff8Qc8qEjrJp7xrepE
	FNYAu8wErRkzv+gietMVkbrRuKP3fkV3voDENfI2V2O5a5FzPNg5MkjovUDHQGkSERUr6PI6iN2
	MDLnStlxSnxSZGnJtva8TyxqEo0bcT9ayCLDcI6vKgukBrFHMwnKX+5iz3TBEWwNJwMj42Ugb+1
	9s0NSKXNoLvRbmHPtM15co3OabCgMNvCBz2LxHJ5Cuw3Qr30OUQVnKomJRxRDPW4vFpqtz7mYWu
	kXyMD69aqWymKgw7bG+aTpAgbFBOrLDOd9SV/ZHMQV6Mxm/RKF78Rj5GuhU9RaTwCw+AFggL2ne
	ZZFQrprLlsJYJ6VTZM9DhlCwClg==
X-Google-Smtp-Source: AGHT+IFbXHc795uzEnydIm7eI5sQRqhaffX3AUu+rEM+K55zgUUlrs9I/KXJFnP07ZxWrN8drgq+nQ==
X-Received: by 2002:a05:6a20:4320:b0:24d:7926:bb29 with SMTP id adf61e73a8af0-2cfd4836d34mr6062532637.5.1758662691008;
        Tue, 23 Sep 2025 14:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f3286222esm7692246b3a.55.2025.09.23.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:50 -0700 (PDT)
Message-Id: <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:29 +0000
Subject: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2)
 in xprepare.c
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

Rename dis1, dis2 to matches1, matches2.

Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
matches1 and matches2. These states will influence whether changed[i]
is set to 1 or kept as 0.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 90 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b9b19c36de..e1d575f779 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -29,6 +29,9 @@
 #define XDL_GUESS_NLINES1 256
 #define XDL_GUESS_NLINES2 20
 
+#define NONE 0
+#define SOME 1
+#define TOO_MANY 2
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
@@ -190,12 +193,12 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
+static bool xdl_clean_mmatch(uint8_t const *matches, long i, long s, long e) {
 	long r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
-	 * Limits the window the is examined during the similar-lines
-	 * scan. The loops below stops when dis[i - r] == 1 (line that
+	 * Limits the window that is examined during the similar-lines
+	 * scan. The loops below stops when matches[i - r] == SOME (line that
 	 * has no match), but there are corner cases where the loop
 	 * proceed all the way to the extremities by causing huge
 	 * performance penalties in case of big files.
@@ -207,40 +210,44 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 
 	/*
 	 * Scans the lines before 'i' to find a run of lines that either
-	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
-	 * Note that we always call this function with dis[i] > 1, so the
+	 * have no match (matches[j] == NONE) or have multiple matches (matches[j] == TOO_MANY).
+	 * Note that we always call this function with matches[i] == TOO_MANY, so the
 	 * current line (i) is already a multimatch line.
 	 */
 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (!dis[i - r])
+		if (matches[i - r] == NONE)
 			rdis0++;
-		else if (dis[i - r] == 2)
+		else if (matches[i - r] == TOO_MANY)
 			rpdis0++;
-		else
+		else if (matches[i - r] == SOME)
 			break;
+		else
+			BUG("Illegal value for matches[i - r]");
 	}
 	/*
 	 * If the run before the line 'i' found only multimatch lines, we
-	 * return 0 and hence we don't make the current line (i) discarded.
+	 * return false and hence we don't make the current line (i) discarded.
 	 * We want to discard multimatch lines only when they appear in the
-	 * middle of runs with nomatch lines (dis[j] == 0).
+	 * middle of runs with nomatch lines (matches[j] == NONE).
 	 */
 	if (rdis0 == 0)
 		return 0;
 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (!dis[i + r])
+		if (matches[i + r] == NONE)
 			rdis1++;
-		else if (dis[i + r] == 2)
+		else if (matches[i + r] == TOO_MANY)
 			rpdis1++;
-		else
+		else if (matches[i + r] == SOME)
 			break;
+		else
+			BUG("Illegal value for matches[i + r]");
 	}
 	/*
 	 * If the run after the line 'i' found only multimatch lines, we
-	 * return 0 and hence we don't make the current line (i) discarded.
+	 * return false and hence we don't make the current line (i) discarded.
 	 */
 	if (rdis1 == 0)
-		return 0;
+		return false;
 	rdis1 += rdis0;
 	rpdis1 += rpdis0;
 
@@ -251,26 +258,41 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
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
+	uint8_t *matches1, *matches2;
+	int status = 0;
+	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 
-	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
-		return -1;
-	dis1 = dis;
-	dis2 = dis1 + xdf1->nrec + 1;
+	matches1 = NULL;
+	matches2 = NULL;
+
+	/*
+	 * Create temporary arrays that will help us decide if
+	 * changed[i] should remain 0 or become 1.
+	 */
+	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
+		status = -1;
+		goto cleanup;
+	}
+	if (!XDL_CALLOC_ARRAY(matches2, xdf2->nrec + 1)) {
+		status = -1;
+		goto cleanup;
+	}
 
+	/*
+	 * Initialize temporary arrays with NONE, SOME, or TOO_MANY.
+	 */
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		matches1[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -278,14 +300,19 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		matches2[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
 	}
 
+	/*
+	 * Use temporary arrays to decide if changed[i] should remain
+	 * 0 or become 1.
+	 */
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
-		if (dis1[i] == 1 ||
-		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+		if (matches1[i] == SOME ||
+		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
+			/* changed[i] remains 0 */
 		} else
 			xdf1->changed[i] = 1;
 	}
@@ -293,17 +320,20 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
-		if (dis2[i] == 1 ||
-		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+		if (matches2[i] == SOME ||
+		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
+			/* changed[i] remains 0 */
 		} else
 			xdf2->changed[i] = 1;
 	}
 	xdf2->nreff = nreff;
 
-	xdl_free(dis);
+cleanup:
+	xdl_free(matches1);
+	xdl_free(matches2);
 
-	return 0;
+	return status;
 }
 
 
-- 
gitgitgadget


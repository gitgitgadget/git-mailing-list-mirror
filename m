Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E22C234E
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141883; cv=none; b=WI1oDKD8v4AxyNnBUmYrAL875Sc9K7JIBWEWltQG4Bek5RVRagfj5UB9vc7apIlX4cAo33kMj69kgMku/v+j0uaSM4HTIA+H4tFdv+lbn25zGZ0/otr7hx7d/9W3/zc6knsKKE8zTHcZTHXGX9GdafgFP6ayL4boAo3G5SnWwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141883; c=relaxed/simple;
	bh=2bEDi1H1q0nKCGiEbLIuQ2hQ1yrFJFN0F07bzDWmFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2akylgEtkFN3eww7aN4NGKNRloqiIVf6Jgc9x8j1V7hmSq19pjylV/3szUWAWERR8dmj9XGcsfCzhjvoRmjD+wzbkc3XifR8gvRRBJmMp0kLkIOh391c7KjkqolIAO5XxPGVW9IthQlWG50sU4cVmy+C3+DclDJfFrwZ/LldDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/HG/5I7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/HG/5I7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so13038945e9.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141881; x=1775746681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUFR2AqGeYLu5DEn11t3TDvnw4wUi5rZGoaWXdMELL4=;
        b=G/HG/5I7xvH2IpeJclQ2ECO143G/WzhaxFEAPYYPLEKTuOAQKtmGNHRAF0gADFzVhb
         VG124uFkioKQn7phAwN4iKhlqghc5b3CJHTy1g5tx7wVyOCqFtoHw7U+RxFCyiXNrnFn
         FHEUkK36USFEmVihXUohkV58qrtj4oYgPMq+tPakrHsM8Ori419rfaT5Vj/RDQc5WvFw
         f3V4e1cClIF0JjPFK5m79HsSsPsmFwe3i8lCRN772+A3HtnkkNW643xt4xB0mGpdjFLD
         7kyKVH+OU4RdWg1vP1xSHXS3h47IHBJFX7yB7BfHZpAq6GOShI0MvbcMcKNDtbo4YbH3
         QPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141881; x=1775746681;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUFR2AqGeYLu5DEn11t3TDvnw4wUi5rZGoaWXdMELL4=;
        b=skYNkidVVPUTEfH0pHoujdPaOyxI9f5pQ6D5fO0s0h0OHFkUgwJB9VWyGdW8CauZWH
         GeP7pAH5hEyLm3MOP0te48xdYeUmvqUQUTekziLXJcEnf18vaWwCBXIbc9L+ojNwf2nu
         dgIXS7hB1kTZYTvUK5CFvV8CV8MSrXIYyfiM9L+uXZiPopOpMWPCGuYrjXyMBUuyTwBL
         q1DjDdTtygQWFLrHWJTHPdz5elXm7ej7TZTT0FWWuoOOQcA+KI3IKi78wRZmX40UzM8T
         jqofBds2X06+ZIufKVeL1d2UmiBDYEKT7Ni/yWk7dc3BvjKG84yf31iaA3zGDIVo8IUM
         bkOQ==
X-Gm-Message-State: AOJu0YxgO36rJBAbzpCF0TeyqjXeAixvGjMftaApOtgrh2PqEKjrpMmn
	CvihpWCWqLBx5mytlOf4RK1pQJBMG1FqUfjvSyB6OGiW/CiEQkG/n1nXrU14nw==
X-Gm-Gg: ATEYQzzWGL59K+LczLA4i3AvEiynxsKmpxy8XDNyc/IcbsjW5tA5Eq7aSqoAFpCKixI
	Z0rSY/j4JAzCHqbyLVpWnNqN/MhzQshBkZGlQN7IaJFXw5PIHFKLt9ZM/CD5d/zIHXu999dRtHC
	kxGjnKrFF2K865Anr6dnmVNbnXebTUmcdDj3TTZiXxvEkHPXF4hZJT+0HKTfhIWydRxVU0UE9IJ
	JbptxiGFVPNWPrxfkVlIJ0+5KYKqqxKTgG7PMEiZiQlttUZk4Prf8ChkO6ZMqq32n1wiiI4cfFk
	g+HiPrCbqQv8bbSZyz73FalXNpEDZ5j1FJ3L5H861BAePKMvlujwrJSM+g0DCIxbZdhumoF4YQL
	fijAKCEeLW9zGUeWvJlrmvllkgcUdjckq+T5i2VK0/FwUMi8XFPQJ2uZXVOcKTxVcQsdbkH+nrG
	9kH/MtDIa1uHWDQwug5bMC90r0tg==
X-Received: by 2002:a05:600c:c10d:b0:486:fab9:a578 with SMTP id 5b1f17b1804b1-48883575c11mr108065705e9.11.1775141880591;
        Thu, 02 Apr 2026 07:58:00 -0700 (PDT)
Received: from berwick ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b6230sm70913705e9.24.2026.04.02.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:58:00 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/4] xdiff: reduce size of action arrays
Date: Thu,  2 Apr 2026 15:57:41 +0100
Message-ID: <447b8c0af1746d61bfa26e7908a784583ab5dc2e.1775141855.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the myers algorithm is selected the input files are pre-processed
to remove any common prefix and suffix. Then any lines that appear
only in one side of the diff are marked as changed and frequently
occurring lines are marked as changed if they are adjacent to a
changed line. This step requires a couple of temporary arrays. As as
the common prefix and suffix have already been removed, the arrays
only need to be big enough to hold the lines between them, not the
whole file. Reduce the size of the arrays and adjust the loops that
use them accordingly while taking care to keep indexing the arrays
in xdfile_t with absolute line numbers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1f2e8c6b4b9..4bb3a8ef41c 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -273,16 +273,19 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 	int ret = 0;
+	ptrdiff_t off = xdf1->dstart;
+	ptrdiff_t len1 = xdf1->dend - off + 1;
+	ptrdiff_t len2 = xdf2->dend - off + 1;
 
 	/*
 	 * Create temporary arrays that will help us decide if
 	 * changed[i] should remain false, or become true.
 	 */
-	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action1, len1)) {
 		ret = -1;
 		goto cleanup;
 	}
-	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
+	if (!XDL_CALLOC_ARRAY(action2, len2)) {
 		ret = -1;
 		goto cleanup;
 	}
@@ -299,8 +302,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+	for (i = 0; i < len1; i++) {
+		size_t mph1 = xdf1->recs[i + off].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		if (nm == 0)
@@ -311,8 +314,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 			action1[i] = INVESTIGATE;
 	}
 
-	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+	for (i = 0; i < len2; i++) {
+		size_t mph2 = xdf2->recs[i + off].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		if (nm == 0)
@@ -328,37 +331,37 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+	for (i = 0; i < len1; i++) {
 		if (action1[i] == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
 				action1[i] = KEEP;
 			else
 				action1[i] = DISCARD;
 		}
 
 		if (action1[i] == KEEP) {
-			xdf1->reference_index[xdf1->nreff++] = i;
+			xdf1->reference_index[xdf1->nreff++] = i + off;
 			/* changed[i] remains false */
 		} else if (action1[i] == DISCARD)
-			xdf1->changed[i] = true;
+			xdf1->changed[i + off] = true;
 		else
 			BUG("Illegal state for action1[i]");
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+	for (i = 0; i < len2; i++) {
 		if (action2[i] == INVESTIGATE) {
-			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
 				action2[i] = KEEP;
 			else
 				action2[i] = DISCARD;
 		}
 
 		if (action2[i] == KEEP) {
-			xdf2->reference_index[xdf2->nreff++] = i;
+			xdf2->reference_index[xdf2->nreff++] = i + off;
 			/* changed[i] remains false */
 		} else if (action2[i] == DISCARD)
-			xdf2->changed[i] = true;
+			xdf2->changed[i + off] = true;
 		else
 			BUG("Illegal state for action2[i]");
 	}
-- 
2.52.0.362.g884e03848a9.dirty


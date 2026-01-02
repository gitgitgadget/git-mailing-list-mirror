Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C5315D27
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379952; cv=none; b=VjPnCR2bXKk9ewBMjWUQgOukOUiWhdekyYNE6HNLfajLV/KssTwCALdmnaWDh0JUmA3qCEyLyJYTQrrs510mmt1Y5XQhQ+cypx0x37DaxbMqjayJX4vxvwgXYtORUxi/qZ9/BKu9MGbtccEIXC3n2sJQkNum8WWqX3CSCa/5BLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379952; c=relaxed/simple;
	bh=hO6TLZsofctuLlmZckGxSu0e/foxakL3radY7KCuj00=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HpXkEhkVKH1RL06VFPqbeKf4nXceqdy4FOBVcDfe84ehrjeBSymRFOgGYr9kvKQPU1BJkr4W1lbniiqm7G4c1GBSx+kRUGsvUgel5eAw3kRRVk5Li1CNG8VXpB5RekfnWXFdL+onKDA3ZfYYfVvAm8PqX5aAyfeWqRlLlsJBHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg5/4lGP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg5/4lGP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bf5ac50827dso7918144a12.2
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379950; x=1767984750; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIHQnPU9XpGfGvFQpRF5ejWcpQZDm3hy+7ttrAll6y8=;
        b=fg5/4lGPyDeiM6iPsIMlGNQVLU7kheCicC9Sx6U/6eC2xIktaZAU1M5JpkiDksggDg
         BiApsBnU7rDELmDmoyJPdTCfeF/cXUH4MbjPePhJ6JAYFV2bDgwzrawGa3z+b6QujwoT
         2i2dTKzcBmwHAwAiFDr4GvoeI14mGlIEJ4OddGOeaMV/LkOmChvRnBpj3SsZ//SWSLLw
         FZYs9NmZxyUl9Kg97kGN9byVHo++hjqFH/GaORjCq4J1jnm1ymQYbPUHRySV76QkuZaA
         zz8xd83hWLsKH4pMf+xX1Ky2eg2SVEVW9/02DIvIxUU3/72TlZyEDvgOWHYOKpYqYbMd
         3pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379950; x=1767984750;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIHQnPU9XpGfGvFQpRF5ejWcpQZDm3hy+7ttrAll6y8=;
        b=XuINtbwDUNEgSVC/6XQSjgtYQKudtpaAYeUcztvuAYwnTXZdqN8hLgWJiELCYPo2bB
         Og4uTlvix8GXVF4SfwCmGSzhzK0PmuE6i0DwKP+zJTfnPoVlD++A98Tnf1DJWuxTtDuk
         F7gHskx9MV7SM4leEECKsJHy4s6+G1XTkD9dgSiXMVxQip3UHir6K847UTo1jsBafseF
         BKmObJQxu8dqMSBFwevk55XbZ4V0dHwShSDumgqvXgtn6lztybLBXKBQNczI1t+cn6HN
         vrPf0DCFdQIr8uEiE7oWTm7I60YM5dWLEg4dtaWtoDOt1xRA7MjtPSrtSWQ5ZGKOsknq
         Rujg==
X-Gm-Message-State: AOJu0YydXPzTaDzPYIfZzf8xOWrfIr+crj4u6VYvvl1v3dmGViYSAnZN
	QQMVRn6MbZSYr4EKi06a6xsxIBolnHGRyPzM02wkY0DzL2W4yueoQlwk+IqYzA==
X-Gm-Gg: AY/fxX7mMKGh6zNv8ibNvk+b3LdIsU+l1sLvmDEDxLpbC0Di84dfTM4aEw9NZVmDzdn
	G8q88j4JgblozqKhgJRgy4aaTcTJhYwuLFDVl3Yif2SM8z/VlQiOSYYtL7ikTg3MCdiaEHFrAw+
	z++LBSYYo1iGn/wMxhhK/QCx7Th9clBt4SmiVIK4LvqlDb12hjnREtO4kTclM0WdHeh7ds8MeJc
	WqPb1Tbca3OHy2+6xNV36Ji9NFNnstrHt0kOXTPpFqOBuy3pt3Fy1xsj50e1mspzO4G+aa7jYio
	uuVDrTUewGgWzrAtG9CG77uUd252uWpDR1ponvUSXy/FMXQz02NwMfY7IgeN4MdyawRaYBUL8UP
	NtUN7a5YFFcuYrl3PQNj6ZJiOHZ46KnfwP2+vyRklja8ifvGZSVDVx+lzg1G/no7A9mdYbyFK6P
	dRgis6tYN0ZPzF7A==
X-Google-Smtp-Source: AGHT+IHVb06FP8FzboCS3/IQNBxKSGvS315NPuJeOyB7cE2uGoZawwOi9l1XJJACjyOfc/EXolOn5g==
X-Received: by 2002:a05:7301:640c:b0:2b0:520c:df62 with SMTP id 5a478bee46e88-2b05ec13924mr36248719eec.19.1767379949744;
        Fri, 02 Jan 2026 10:52:29 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm92971755eec.1.2026.01.02.10.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:29 -0800 (PST)
Message-Id: <53e4840c1653772379dc8d5c883b34717b81ac43.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:17 +0000
Subject: [PATCH 03/10] xdiff: don't waste time guessing the number of lines
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

All lines must be read anyway, so classify them after they're read in.
Also move the memset() into xdl_init_classifier().

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 52 +++++++++++++++++++-----------------------------
 xdiff/xutils.c   | 20 -------------------
 xdiff/xutils.h   |  1 -
 3 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 34c82e4f8e..96a32cc5e9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -26,8 +26,6 @@
 #define XDL_KPDIS_RUN 4
 #define XDL_MAX_EQLIMIT 1024
 #define XDL_SIMSCAN_WINDOW 100
-#define XDL_GUESS_NLINES1 256
-#define XDL_GUESS_NLINES2 20
 
 #define DISCARD 0
 #define KEEP 1
@@ -55,6 +53,8 @@ typedef struct s_xdlclassifier {
 
 
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
+	memset(cf, 0, sizeof(xdlclassifier_t));
+
 	cf->flags = flags;
 
 	cf->hbits = xdl_hashbits((unsigned int) size);
@@ -134,12 +134,12 @@ static void xdl_free_ctx(xdfile_t *xdf)
 }
 
 
-static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
-			   xdlclassifier_t *cf, xdfile_t *xdf) {
+static int xdl_prepare_ctx(mmfile_t *mf, xdfile_t *xdf, uint64_t flags) {
 	long bsize;
 	uint64_t hav;
 	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
+	long narec = 8;
 
 	xdf->reference_index = NULL;
 	xdf->changed = NULL;
@@ -152,23 +152,21 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
-			hav = xdl_hash_record(&cur, top, xpp->flags);
+			hav = xdl_hash_record(&cur, top, flags);
 			if (XDL_ALLOC_GROW(xdf->recs, (long)xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
 			crec->size = cur - prev;
 			crec->line_hash = hav;
-			if (xdl_classify_record(pass, cf, crec) < 0)
-				goto abort;
 		}
 	}
 
 	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
 
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
+	if ((XDF_DIFF_ALG(flags) != XDF_PATIENCE_DIFF) &&
+	    (XDF_DIFF_ALG(flags) != XDF_HISTOGRAM_DIFF)) {
 		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
 			goto abort;
 	}
@@ -381,37 +379,29 @@ static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2
 
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe) {
-	long enl1, enl2, sample;
 	xdlclassifier_t cf;
 
-	memset(&cf, 0, sizeof(cf));
-
-	/*
-	 * For histogram diff, we can afford a smaller sample size and
-	 * thus a poorer estimate of the number of lines, as the hash
-	 * table (rhash) won't be filled up/grown. The number of lines
-	 * (nrecs) will be updated correctly anyway by
-	 * xdl_prepare_ctx().
-	 */
-	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
-		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
+	if (xdl_prepare_ctx(mf1, &xe->xdf1, xpp->flags) < 0) {
 
-	enl1 = xdl_guess_lines(mf1, sample) + 1;
-	enl2 = xdl_guess_lines(mf2, sample) + 1;
-
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
 		return -1;
+	}
+	if (xdl_prepare_ctx(mf2, &xe->xdf2, xpp->flags) < 0) {
 
-	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
-
-		xdl_free_classifier(&cf);
+		xdl_free_ctx(&xe->xdf1);
 		return -1;
 	}
-	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
 
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
+	if (xdl_init_classifier(&cf, xe->xdf1.nrec + xe->xdf2.nrec + 1, xpp->flags) < 0)
 		return -1;
+
+	for (size_t i = 0; i < xe->xdf1.nrec; i++) {
+		xrecord_t *rec = &xe->xdf1.recs[i];
+		xdl_classify_record(1, &cf, rec);
+	}
+
+	for (size_t i = 0; i < xe->xdf2.nrec; i++) {
+		xrecord_t *rec = &xe->xdf2.recs[i];
+		xdl_classify_record(2, &cf, rec);
 	}
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 77ee1ad9c8..b3d51197c1 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -118,26 +118,6 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	return data;
 }
 
-long xdl_guess_lines(mmfile_t *mf, long sample) {
-	long nl = 0, size, tsize = 0;
-	char const *data, *cur, *top;
-
-	if ((cur = data = xdl_mmfile_first(mf, &size))) {
-		for (top = data + size; nl < sample && cur < top; ) {
-			nl++;
-			if (!(cur = memchr(cur, '\n', top - cur)))
-				cur = top;
-			else
-				cur++;
-		}
-		tsize += (long) (cur - data);
-	}
-
-	if (nl && tsize)
-		nl = xdl_mmfile_size(mf) / (tsize / nl);
-
-	return nl + 1;
-}
 
 int xdl_blankline(const char *line, long size, long flags)
 {
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 615b4a9d35..d800840dd0 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -31,7 +31,6 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
-long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
 uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top);
-- 
gitgitgadget


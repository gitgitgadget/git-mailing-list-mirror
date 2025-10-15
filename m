Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B9303A2E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563117; cv=none; b=M8Ypcx8CFfGslOpU+0yc9vRYGQF/p6egD6p1XZZ+LJy39p+ptRqvtQX0S60qfsL+rkCRD7qfihyXytir3yV9mjgpdfWKOxWlXNqy9H28FbH/L8iYdtsAuxIzjuMwkHUFCSRjfPEIT5/qX6ikuY1LaYSuzacl7hSIGbrkxFlFw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563117; c=relaxed/simple;
	bh=evA89fpsn+GQ+ie3//gHCoH1D+eYIh5S9xL6/q0LQ2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UZaXckc8D075HFgm7zy8BpKRyKpM/7ioGOjBHhghvUMhrreXiQWYZG0TZE0ENMEObbx5itGh6I0WmJDgJqwaP9i2/5EATmBG1UWd78wQp+WIVD8zvbqgVmTl7G3pXdM4+oOSmdght3vEG8lwmeB2BDNKjEp5SiEC3kXvJfFr+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+jyZPWI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+jyZPWI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so5812978a12.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563115; x=1761167915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tVdE5QySaQ9wxUKzG7EzVMEmV0HPwJ+gHMEw3MMdD4=;
        b=M+jyZPWI6AvrjsxIE36YUVFM6lzdNp7A/vcBDdwvvuH+vEEV7IH0M2ye/iET3bX5+s
         6ZDU7vBnA9AKseFSafLX/GermWT5cO/A7sVoppRxgUQLu8wHSP1666yCctMUf1cjgNp3
         c00QvrZkwP+dw/fE9ze0ZZx5Mug6wNbG4omdL1w3GGT5ZLfGanqeiphX9mzvRDKwK4Qw
         Yxs+2yVV6+DUQrTCC1wpqce+eU07UiVIN2CW7hMDZh2zH/FXd6cDSyUfz7BLxzzzjSRd
         m2Yne9uDDviWPyHPzBPKMi7EQBunVqFKaQsfYV3G5liL5IgJ+Lpb64aRQhesKUvcwWqG
         jlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563115; x=1761167915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tVdE5QySaQ9wxUKzG7EzVMEmV0HPwJ+gHMEw3MMdD4=;
        b=BSlnZg+7SetMH9X6VV2gMmRA6HjXSwaqyR4MlR6WgIHrhTUEslrP2b8vFVf0eR90Eo
         cTe+OwUnOzT0ORJe9MTGdf2O9ByZt1i95itq6wRilwzYZDvuTOO5lpPBQ69z27u2+Ehl
         k2fZ+YobFr8jqSJZQADgemviahYhOnzq8U5J5cf+eFOw7N+qz+jUrpVL5yr0LMJOSkkb
         Rn0BTKIm2hcPan/nNsiHotG8kglBKG3oJ8cQS7NXW104uAeuWqoa/ta36F4MM4uDtxgC
         igH4S8pm6jZowwb3McEFKT3c/YzAD2hqmWDLg5L1hQwC2hp1U62pn0YnVLS52vhbsk0y
         kfOQ==
X-Gm-Message-State: AOJu0YwLc1kbu8WAcCgSHZanb92IUoFV4UXZEbMGqOi6UAF9H8G79a/G
	svJYtSNt2oATEsesHqmHYhHnS4QgRk+kRE1xV5vMCmZXxqAdGhvl7kjCy10s5mlI
X-Gm-Gg: ASbGncsMacXfqTZIE2ViEOonTn0cHC1aDDxFA/WxxQ6m98mJdtYOw6upJHLpX7qnX81
	cHwypIt5qIL5O7988ncV9FddkStMWsRyQ1j2M1yTwlLeU8zhTfqndTzhOEvzB1+m+aD4reMz12A
	jLxQnWjiFdAxBRmFlYuiv36/QxSuLVAi1FEygpwDbVvQOTqIVse+LU9s13TCFWF07/wRp74zqAG
	lYTgHCPt7HAl1nI1sS+nNykSurg02uDtcNDVf75x6NJoFWZVQlBh7fCPFCpifnw/Y9hWFGhzEBC
	hVAcz4YYdd1FehYDCBe/VJpQybJq52tjn4UzVwa6aEBxHzKit/eN8MYGFaZxWPSZnN+LWJAmN52
	ponUITCsroPEcV9DUvC18sSDgCx1Vr2iBfW362DZIUEUWrKTXlzYNHn2E0TCFRPuQb0VMdBTcuo
	tjOfbz2lYXzA8=
X-Google-Smtp-Source: AGHT+IHBiE7eCc1ZJP3bddzlDA817NjLJXbIhublVnVnp8WDN7ngYIGK9bAWxpzb+SGNQlCaS9EK6w==
X-Received: by 2002:a17:903:910:b0:264:70da:7a3b with SMTP id d9443c01a7336-290272e7d60mr383775935ad.49.1760563115029;
        Wed, 15 Oct 2025 14:18:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab1ca0sm5896575ad.96.2025.10.15.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:34 -0700 (PDT)
Message-Id: <518e5f5557e9bb30727d0d26433d64117269d159.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:21 +0000
Subject: [PATCH 9/9] xdiff: rename rindex -> reference_index
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

The classic diff adds only the lines that it's going to consider,
during the diff, to an array. A mapping between the compacted
array, and the lines of the file that they reference, are
facilitated by this array.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  6 +++---
 xdiff/xprepare.c | 10 +++++-----
 xdiff/xtypes.h   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 759193fe5d..8eb664be3e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -24,7 +24,7 @@
 
 static size_t get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
+	return xdf->recs[xdf->reference_index[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->changed[xdf2->rindex[off2]] = true;
+			xdf2->changed[xdf2->reference_index[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->changed[xdf1->rindex[off1]] = true;
+			xdf1->changed[xdf1->reference_index[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c690bafeb1..1dd420a2ff 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -128,7 +128,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rindex);
+	xdl_free(xdf->reference_index);
 	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
@@ -141,7 +141,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
-	xdf->rindex = NULL;
+	xdf->reference_index = NULL;
 	xdf->changed = NULL;
 	xdf->recs = NULL;
 
@@ -169,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->reference_index, xdf->nrec + 1))
 			goto abort;
 	}
 
@@ -312,7 +312,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[xdf1->nreff++] = i;
+			xdf1->reference_index[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
@@ -324,7 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[xdf2->nreff++] = i;
+			xdf2->reference_index[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8016222de9..373ccefa28 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	size_t *rindex;
+	size_t *reference_index;
 	size_t nreff;
 	ssize_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget

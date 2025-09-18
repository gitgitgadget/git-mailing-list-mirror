Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF682D23B1
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239800; cv=none; b=gKdA1BI3ZaB19/P98x0HlXxVYUfzIohqlsItg5VktzPgRrAsalEH11d4ld6dfWVEYJFq0MuOqwywFzXx+ZWqPDoWU2YVLG4cTZAGRixCrWNJVD+BqBcaTOCV1pjLXzMTZPO/YT3bOpG0S2UicT9MS14fs3ove6PoRf1qJkrIrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239800; c=relaxed/simple;
	bh=WLIUa6ZrYvogYXTs4lcE9b+y7U2JWpT8EveqGDW3nXU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=opek1Mjg9kON7qc4coRoM9POa78/4L7sk6jm3d/4QDtEHuKsbA/LrUB1//9yAC24r0RprxnkcZayQ3dCkmAqNLjnzfar8pNu5nHbLKaWu+RyE1HAflGInSETDCjIJFE5pHyZtnSwecuMrUApav01B9CmzZgpJ0TpdLLQoUFz8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN500sov; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN500sov"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b61161c30fso13012871cf.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239797; x=1758844597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnK1oxFLkKPc1cBSOhMfGPiE+2d1++QlFr7byHIsQts=;
        b=NN500sov0EStkaz9Og1vzACCMxei4h5jiWtdt4/9jOcjeifXce+9CTRuNguaSrjto2
         aG/Wo0Lm6yuSYuG0qG0mqsE86Zvfg3pVH5L4+GLZLk8wvnUwJ74GTcTb37+EHwD4qn0p
         gGSJK5TYvwKgWCj9rZSHPuadARHICxUPfGHLZDmwxjafWBAxvXGxh98tyBSr64ZRTjIE
         rg3fhTs+Ad+xHKCJrdVsRKAdaXWP5zegp9x71s1CYYp2C8LOtwb4Ec6wf/SuLJygu+t5
         dRX9yx21knfoZOV0XPv6bwY/iIxpPXnyKkZkTjblMP/pc43sRwPXLO8zBjjLFZaFCMEa
         hJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239797; x=1758844597;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnK1oxFLkKPc1cBSOhMfGPiE+2d1++QlFr7byHIsQts=;
        b=g2r//O+YDVMKLc0zrOCmUuyq6Qtlumvq2gW6OrsoaIE5Kxu88Ni0NiADSDe/Qi85Zm
         HrfW8OIr44GB8F2Ri5szEaNneMBvy/UL4vol6c4cmXhY0kYlNwR+e8FXIEURix82C6zt
         jYcVmBoLIG1zlj0MaKW+zecsMmQ92R1liqN5pZ0gKbS0vgfTj8l4yv7j8wD9VF66uF5h
         oMw3lctFYSE1Cn8LSw1q01P223JezvQAkouNq/k74UyAhRxuZJkAl3hnZloSKXqw1BN0
         nTsL6iEWtWS3ybvZpdqsKEkJtlokhh3jFcfQdW8T+WnywzFEGyeQ5UIVlgHd/jY2LJVy
         hlGg==
X-Gm-Message-State: AOJu0YzF2mxYJBVr7CHXrNPOzNbSHYh6Ielbcxjx7k/yZ5KUXwKOe1DR
	WS1IUFXnPYTwowvHsmtDzQmJ+MAzySN5n5ztUXy5cAFkDGcs6EAy6px6F2gZVhUb
X-Gm-Gg: ASbGncthhsNZAGDBC1tiyTcb17yfyCHq0x5XvMS92fsaWpsLlqo2Yj5DuENzWKhprlu
	jRni5E6vx5zLFXu6rukO2B5vtOSTomV8o3+6U9v3PO+3oXgNwk58kWa/7/hhcN7FagkpQ3PfCTz
	3TrqPli49OMdu8Yyp69Hw9t1DXmG4YzYqgOFp37eX5xgJ/dCvtbA1EF5dNSHm96pUqrJt9xwuGs
	phBOAMgI8aKbXC5ZL7LE9jrNZ+RDlvdfGfCfBziMYvTCe2xe9RnqLa6l9KHbhLNITelEKQ/jZmK
	U1nJ/Mnsu/i3NfsTbzU5iRBPi4CROPvtGjvx1SORR8MM5Xf5XVfy+dGTeCIA75hbDrMQmgsSc1c
	hbuJ22v8rWgNri+fuO068X9BW0zFtHBrCo80i9DS/adY=
X-Google-Smtp-Source: AGHT+IFYHIbdV6wV44+AaVXRcfTTF0gnjHRQW0sCgvtHtvHU99z3tGDx6JNeMeyvEqAOKg66uvm19A==
X-Received: by 2002:ac8:7d06:0:b0:4b5:ee26:5360 with SMTP id d75a77b69052e-4c06f07de6fmr16085601cf.28.1758239797019;
        Thu, 18 Sep 2025 16:56:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b279fsm20432601cf.33.2025.09.18.16.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:35 -0700 (PDT)
Message-Id: <2e8de5be03f7166059d735a99573520e35ff9a31.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:22 +0000
Subject: [PATCH v2 03/10] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 15 ++-------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index fe02fd7925..7acca1cb38 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,17 +125,12 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
@@ -155,7 +149,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
-	xdf->rhash = NULL;
 	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -163,10 +156,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	xdf->hbits = xdl_hashbits((unsigned int) narec);
-	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
-		goto abort;
-
 	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -180,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			xdf->recs[xdf->nrec++] = crec;
-			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436e..8b8467360e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget


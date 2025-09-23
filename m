Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0130DEC5
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662679; cv=none; b=u3YgeYExDTwbxI9fbhA2LdJJRWhlFR/SKTBtGg8WRi02a0IcF6tHdgkfwoRtYz8TAah7+r+eb4CqV/xC61e972RLBiBUtdKBQUPFFzIR1g3HhyxxJCCQRzWr1pLOZWdoXTDZQre3gysC4S1tvJZChhbXKdXUKh7WgqJPKas8RsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662679; c=relaxed/simple;
	bh=H0vk7Iho1uobFZT1woK07XACFDhpd2nfLTMK+RFC4Hk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HL70kCFyZ6AizUx14/reERcGxh4mJ3lgFmH4oFx41JELb9RKgZsdsmOLfuFK8JOdYsJ6BDbFouZRqegbMIvWLci9a/FiaG7DuoYPbF04ZYub8jQLRaiq6Hy0m85/NWc5ZF5u8YgHb00N9nAI1WT2RGPXTkd/X5q2QRAYhgDIxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d//Jfzp/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d//Jfzp/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso4126370a12.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662677; x=1759267477; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=d//Jfzp/dvrmiS4CeDTn0JaqY4IuRxPlIZpuOD0/Dqow60n32iy2agMttuVarl3RjX
         8l9X4uLbmmr7lNuUPYddxXLw7xZiFE6IFw8kqtVaj3oEmWX1h04bA4DxjvmZw1vppzTW
         pF0eNL0ohf2cxrE5t3MJcbBazxbrweWF4LvwqXgOFLutor86G9emfiRTCQeRtz5H2jiN
         pJ7BEtO5NWy68OJjkj9Elr7Sx29/Ij1l+io0CsNE4334RHKfZQwryhBCAqIiItfyDUss
         sysFeA3Y9cDe1h9SDM4Kg5EQTn2XMujYfrd2ZGFXBxIHeWJpA2LIE4aLY0GyqgyoN2CJ
         X94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662677; x=1759267477;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=PNfUd4PWIp4wiQvQJSgALkSe2Z8Sp+mdaIV6gTKqA0iiuvjRqal0zbNCogh1SEGAiL
         6Y5br7aZpNcxnzjukZmDM8lXBoLipZnt7hGG5zaQv7cJSq0w/My0V8Dl9qfJhgPlZenL
         o3JyGJk7y9YjgqT9t0RNovQBD7JsKmDS9/gs8iU7CP3HeSZVO1zGwAaWprOK/NQgp0Io
         AaJ/77C77J3mWZ3D6NC6XnZsB9JXyeJngvKUx3fyocqIalQ79PfhipiSB5JJUxi1Zkcd
         T9Sun0ScC9VX6RbMvLsBfori/J5tmTsh3ULVgJOnp9pml6Nc56Tzz+1m5OK6Glr2Ziv+
         Gfiw==
X-Gm-Message-State: AOJu0Yz2d8HoRyqhQQkg6PWMdbsZ9yC9QQQ4SvIeynoN9/To7LN/rDJj
	FL/lDHdUZyBTkmAkngiMWYjQ3CUVvUPx8TCfU8rCSvSTeZJAfWIyHlw01rTtGr2W
X-Gm-Gg: ASbGnctlOH9GiGnEkifE4z3qKST0/MI8Xv+AbN5hn55VMDcmBZiXSfSvQVCntjbDsll
	q0JFOqpmRN6hcGozRgoEnSG/CnGsr88Cz+t8flYGdhl+4V8jX9nv2rkVBSXNPffweyVLJddExn8
	9in6EvPGcCuMvpsTNE/M9hHBysMB4sPL3j93YCCprAMpSBTW6+1mPw24QhOvFEara1hWk3zSYG3
	6Cln+wiuGBUUHOSKs+syORCOrbnQSl0WFxG83YMV/oZibyHdLqlkoATS2zpLJC02WvdPpkN/WOP
	qIbsEGND9Dr2tOqpRtpfiyBv+XaCndBcVLqdCvQspGfhip8cnajInwCwnPyDT4AW7fRemSWHJVu
	SYRE0ExNoqEGTihyXQvmHRPRVGw==
X-Google-Smtp-Source: AGHT+IFWVvvw3ISTTiiPjoHVudIE2oFqfoKbtiCJmslNvIr6pPuCq1MLqNm44mbC9kHc0y0VNjQYFQ==
X-Received: by 2002:a17:903:4044:b0:267:f121:6a88 with SMTP id d9443c01a7336-27cc5bf8416mr29841845ad.42.1758662676868;
        Tue, 23 Sep 2025 14:24:36 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55283ea850sm11211988a12.13.2025.09.23.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:36 -0700 (PDT)
Message-Id: <92c81d2ff6059b0d91f9d919b36303af953f4d09.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:20 +0000
Subject: [PATCH v5 03/13] xdiff: delete unnecessary fields from xrecord_t and
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
    Jeff King <peff@peff.net>,
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
index 96134c9fbf..3576415c85 100644
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


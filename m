Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2C29D294
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926527; cv=none; b=rGJ9r3GPvO+5e80sIRitx19j4PTK9kSz1RffXdC55wzrenawkrbGvzAnnB2+h3An3Ohqdq8WqLDI/AKfbfTJdg0N5MNqufxpTyBCcsGvV1D2paRoMJ9FBE5GrmmRtlVk/PzoFXbVPRNotTp7QStxTQirQHcsLYoey6gNNBCT/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926527; c=relaxed/simple;
	bh=H0vk7Iho1uobFZT1woK07XACFDhpd2nfLTMK+RFC4Hk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RjYydLvFwGyiCS4G6C7DQBljiwXnKEhEHiUa5CUFE3uLvM/G+lKt/ZeIzrrb9kVve4SO7OfKR67rWJOLCi5xffm7z5urc6GqiNeuYvijg7W91A0aLA7lFISL9yxZaHI/CNSdLk/WAe3tJSv2UKjPpbPkG1XewXAIkq0Zzk/w+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5euzffa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5euzffa"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f343231fcso1765761b3a.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926525; x=1759531325; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=h5euzffafkk/nDSLaVnuPLrwPFdrPEo5eW9KBJfHywERwg7LpXF1stPd/HpcuUvpB7
         VQ5Juvev43vIBTYeYu0Y8agWOrXJq1fhO0aSVsdJ+NgpHiuoNWDO4w8Nzbbh1Q58Iv93
         cWlAkvIh06GLw/BHo1x4qXjluOW+jaS2FlBnbXFOW7ncHLovIeNBRl8+Y4Txyvvm6JPh
         FeTsnc1J1Cpff/NQP7I4roQvNsEvQR0QfDd+cFn5k+PJY1zH+XLdvA8SwnHCMiarHsk+
         X6ICa0I0BxRlAp3rnUGLH7B8SHNwy6+S5+AfYORwCuYmO2Rq4RK7bxtJJL6RwFp3ZOfd
         LzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926525; x=1759531325;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=eRWBgMvkZFDzAxbVCuLkGxgyWmDa/jQrjH1fgkLOX0gVa5OAR4vA3el0QyuxfbMimF
         97pNExFWbucVz4a4Mv6t+RvLX4ae2fdb06ZFAMlBmR4ddUG+OJaLBnJXC8Fv8mYG2IZq
         NhedA2vef+yR/ode+t9NsN1EbVFtZDdnJqUwVaL+8SKJEo2t6R37OxIMXgwILf61Mc29
         y+e82FYr7NIxWCQVKwn4jmIIe7ktT6H4Y1oOMuNjEvwp5spwzT18ALG1iFfOKGG7D4VD
         QaHgDkOv/FHD1HXqNm1PWuH/aqicZ9spdocncCP+6XA6tILg4LNhtlYZF537rT9B9AAe
         wyWQ==
X-Gm-Message-State: AOJu0YyLrszxDsalL0Ea7191a/w8Qodx5MbPoks1YVg2wwFMJ/uP3y+w
	iHYCiUtKtzGt07pNGcZ8eWOs3Ac5/lNfmFFhreQbFB+V/GsfVaT6xbx03+RCnQ==
X-Gm-Gg: ASbGnctIFjNlLoinf/YTx2gki4oB+jNT9LnkqQ7Bn47CUyE+VK2QS1q4VjRdlTIPMim
	VAgz67i/SP54K1tOaXEYWNXB8upOaghfRYsqgQuAd42B0UrXiNpzTjl/Gqvpjx0TgoKOOK/fI8I
	iUnk2yMAcbCDVAJdwm40jgWEO+7sg3z8Yj2gQ93oma4HN/RcASXAbf6uiBq5nE5P6BRoXsLXIWh
	ufl/W+5fANUwZH/c4F5Acey+jEP/NtZAqpIjwdu/OLHvf6GW8cbBZX4FHKQYyG7z67ce+SgaVLg
	VIbk4Tnv9Kk2fNAvwyM8Vvxpwg7GMM3bDc7P56oldsp+G81li6vUyMe43uznLpQJgS7HJz63oPY
	7eCJ6sMNzoR5+O245wX+M4bLs0xNR6xlMFY8=
X-Google-Smtp-Source: AGHT+IGnVl4DlllPFonkWfHAyRtRAkXa/b6b+umtQZA8zV7hAyQGnN9nO9EWoOXuog1rClIt1E9vBQ==
X-Received: by 2002:a05:6a20:3c8d:b0:24a:8315:7f3 with SMTP id adf61e73a8af0-2e7d68d48c6mr11341974637.58.1758926525271;
        Fri, 26 Sep 2025 15:42:05 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238b19dsm5392181b3a.10.2025.09.26.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:04 -0700 (PDT)
Message-Id: <92c81d2ff6059b0d91f9d919b36303af953f4d09.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:50 +0000
Subject: [PATCH v6 03/12] xdiff: delete unnecessary fields from xrecord_t and
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


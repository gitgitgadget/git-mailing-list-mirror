Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0F29AAFD
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274328; cv=none; b=CN0wPIJIdNuxQNEIvEvlZRjQxBoN+ITrfuLlZk5dnYBuDV6D2f2FjAlav723lGDKwS7JAYCe6yaxRgcfNFWKujp7voXJ4efsttjLctjdQNp565J8/M0wLwcV0KNsDREixdGMebCtu2Wi7pDOjDnqOphVKy0fswskPTq9Nqts7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274328; c=relaxed/simple;
	bh=LctHZmip8xCV+rfcWlS5ldedQBFgXPOIv+kZrJunmn4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LtnnTxE5Bk1Fd3aIVifaoeBS071cwvbcWkWKhP/NEwFrf+M4Vb+ge7nRuAhhz4Zv4QrdvJwzh3AnuTgC0uCWCGn/ioRRCiLikQNQeiz2dveIj5tv6A5SafjkT0/5bOzi6cfUFDDHzF/yPTS8HVjrAxKbn5hkOe6WYZS+4d9Pj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue4Oz3Va; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue4Oz3Va"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-72816012c5cso32072036d6.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274325; x=1757879125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k3TQ18olQ8WslVKMlQcUDvd2k8TgGXGhlfSRWO5cy4=;
        b=Ue4Oz3Va2YO/nuasKenokHYr1rDe/deysJwn3rIrKdSk0iXKDO+Zr3F/Zn6kws9umR
         xdQcfVa3psVraDRN8TC0NyrozyvO6VrcpvP8kEmGd+zkAmLJnN3AVBe6cFzDN66OD+VY
         hdFYQZtMBOlqUabv4EYSD8v66b27Ka3C5oZjw5KhlXCI+ViZRXC1+xJyu0GYNQU7mLjS
         KPXfZUK3dlrc74ft7bPiPhq13eXTact30Tvuk6mk5b1ZL4YF880AS5cMuotfBVKCSmf5
         HUi9Y+oLrF1MRcBjtQBJHT4Eyq/l19qQgsljz09tZmNek/vazWlwirmHRbbKiApzo8Qi
         NhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274325; x=1757879125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k3TQ18olQ8WslVKMlQcUDvd2k8TgGXGhlfSRWO5cy4=;
        b=PQKqCR46W8ZjrMsMQ7jM0L1aogdh9q7zktdj7f99Ia4NkvB+zaNcwINC+IFe4gLutT
         GrQjmRBrPcsE5htltdbav6X9qvdC3eVuebrOaaUOE5/Y5fJ9hfcavLNVy6ZxhAOb1oLu
         MUwbRPKaNzbHy58AprhTGvOY7Gq/5WW+7i12GokGTkowV3gGiKbrYxx5gwj4dKZQuvpQ
         I/Bta5gP62PfO+IGPVJqnIR+6rhKICyqpDIawd0Fjvf7KP5S5Ktz+OkSQgN7L9mW91yy
         MlPeQS4qSFKeur+WcuqoKQngjd0BeL50W2xVRLumtWeIU62rrBjtYNK6g7JGc3Ibohvv
         aTCg==
X-Gm-Message-State: AOJu0Yyzzfqkkgu1P1oSnVYOH6J9Kbutw9YTJ0HRgIFf14Fk5eWkNBVK
	BVm5zxX7T0Sszb3yA9ggHC/7NFoBKoAVU9eiY8ADxOOBaUxra7BtNBSN9QwlUV4a
X-Gm-Gg: ASbGnctRUklRtqmZ+Nwv/eHacQsDeHwG2Qj5OW/1mrHQ13nBHjLssr/2wSaEqW0Tgnb
	i4BxBb9zwIJK/3pRbj1UZLVzBHYb8LJI8QsbgsasPGITpzSTgbSytWMXr03DqRB2DIWP0SoWibM
	YSP6PMozINwIq89xBZLhf/p/szhqBfib4+q+L6GCDyEMpa1YEKTjatVyA8/YmrbXi/im1WZAJPQ
	Hy5ZA4L0nu5y6nu891jOvQ1KS3+cmVS5bNLhCuT4TTT3Z4v7VosQ2aZKxCz1sT7hMFlSRLHCPID
	C5uoe1/8lbQzRLAE73EQWe26eoL4yCOE8rB8R3Y7NMA5MOc7a6LEBr/3KhPmaEyZcZ22Z2LHQiE
	kMYwJGlFuZBTkHNEAMmMQN3k=
X-Google-Smtp-Source: AGHT+IHEa4VyY84jRUNDBJXJm4pixsMfRLkLc8Of3GhESyu5kuLYjvirAqogGNvzYeHUjnA+ToqRKg==
X-Received: by 2002:a05:6214:f05:b0:726:b098:4f06 with SMTP id 6a1803df08f44-73919c9f1famr55996716d6.8.1757274325347;
        Sun, 07 Sep 2025 12:45:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7426533bdeasm23203716d6.39.2025.09.07.12.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:24 -0700 (PDT)
Message-Id: <7d5e387916eaf4afd40afc85b1678306b8a5f076.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:06 +0000
Subject: [PATCH 03/17] xdiff: delete unnecessary fields from xrecord_t and
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 15 ++-------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 2ed1785b09..91b0ed54e0 100644
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
@@ -126,10 +125,6 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
@@ -137,7 +132,6 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 static void xdl_free_ctx(xdfile_t *xdf)
 {
 
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
@@ -156,7 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
-	xdf->rhash = NULL;
 	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -164,10 +157,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	xdf->hbits = xdl_hashbits((unsigned int) narec);
-	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
-		goto abort;
-
 	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -181,7 +170,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
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


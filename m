Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABF3176FF
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295000; cv=none; b=OK+3j/oldVwb7aZaTdFvQxJ4cJQkeV92BSD8y/IaAHU2YjEhyabFAsTpadi2kyAJuoDoJvBKLzW3d8Gj4/0RQOAExgGBAqQfSD1qbq76pD9iFCg8s6aUHxA4bvdoFjmoCz+VLP+3QnaMjGlVFK3laQJMIoqPXxrNi+eCdbrq+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295000; c=relaxed/simple;
	bh=Vuyah6ETdpTEkoP/NIJmf3xhjZ4tftsfUKDsmxtzWeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Aps0E+GotMwzKv1d/xfknRQ+iFHEBogX0lyc0oMD4fX0/K240qESGVWepzl2HU2d6aNME0Wi7KVQF3XJFYIsjKo6MpfVT6jj07e45WMOOI8txUx26aebjhB4lVu497ggj1vfqnYsGv29AauGG+QTjd+0bjNXhUBQ05ZuAg9Bh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVKwwBqa; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVKwwBqa"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4248b320541so177325ab.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294998; x=1758899798; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBrPsmBFKukZ+KW5A7lw05n9uGb7ctXSsHjXMkk77ew=;
        b=eVKwwBqa9UQEi8RC/7GCX8f+CICalOkkwib1iNtWqHQfxkUVJkH0zAvxYVUUsJ83CY
         4jg0EIp7mwMXSZI60JhSEFZrLwTJsYbZ2WVqmTqeW5/k6pCiR0TLaK/Mp/FlIwrYpN9d
         C//HmFLIGvo/IoO74cwWZHfoMeB7AraVhlLOr2ddnE/I1mXGleZn46vZ7ChMk51rQDbr
         BaZHmjBpSbmFNB1Tkb7pCa9+yW4F+yt3OMVQ3gjKoPp+8MNAln4I1OI5PQn60hWpgadx
         Xco1ajf7SzfKP1jFUGVtlelp0CEApwoKf5+f9qzOgWpsj+iM3kpuuD5jNydOOzBJhaGP
         EEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294998; x=1758899798;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBrPsmBFKukZ+KW5A7lw05n9uGb7ctXSsHjXMkk77ew=;
        b=d1LvMU23uYDd6nj95xhPzGhAe93eATxQnLomC7f2dk2RmqzSKcw/tgORUCUBvh2Npe
         Hw+gqb0j/XeltaR7ilJeMF04tWAdWsPUTDW7QoId+CFk6iLWa2dT0Tb01r5EClVgvVK6
         Cl6OhQ4Hyi8wNQ0PKkJ5yHTkHwpl0hRm/RzvN9DAaxVvjkmgT5H2U8skziZt7JSfKFuD
         TDswxiSZL6YoWELTRDyq6lsf92bEVbQ+TBPYeC4k0aDXQGE2OD4F4lKlGEx310Ha6GV4
         VntuKMSr5DrqKNNghlb69TPb0kiw9/Wo7/0kA5s9CrKceU9z0oBFdFItmWlFBTbu8nPx
         bpYQ==
X-Gm-Message-State: AOJu0YybtX1aDaXLlDanXyPyeermhspvbLgzjEzg4mSIPus23IN5qp6N
	uIKrVR6P0cuFd/XI8N3sGjIRAhCKcqMG5uPnzEwS3iJRC5Lo/USPD91DhOmFbav8
X-Gm-Gg: ASbGncuIZtTrLvsfX8yB+JwfKZdmnYQAmGHHHftmfDp2/R6DA7PWRBaxokuPaj9Vkpr
	vuYGUPp9OqU1EJV2p/2OGJc1GaLexqZ3khD6Zyo7dN0APXcZ1198ynUN8H5tC26tpzNlaJTj7pB
	HhAEZ1dUAEZ7G5ksmWwkobB8nfPPiYhKkf7vAFyLGSyyE1gnUpSYexsCDBMGiaUOhIF7ak8/AmB
	/WvGqYBitpVmTPdPzbQsE5PGOKZCRIjKFTWf4NBdzno42a7ScIPBOjUNXestsDFRJnc+chihFBv
	ZKFHSUK7KeHVOTxRGDmQcLpo/iqcdflQ4dSKoiXnXAvNaJoxhi4Od8L61oKjGzXFwgomQqwtMCc
	LncNBIUedeQfrnSEZ/tb4zKZ1cQ==
X-Google-Smtp-Source: AGHT+IFEQzFndrMMpVZf91G8GDCtYLjtO0YM8IkFzOGrnCpwQgpV+TjvmkAL9mhQW2qW1Dm2QA1wvA==
X-Received: by 2002:a05:6e02:349f:b0:424:89fd:73da with SMTP id e9e14a558f8ab-42489fd7584mr15203025ab.7.1758294997542;
        Fri, 19 Sep 2025 08:16:37 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e33753fsm2278276173.24.2025.09.19.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:36 -0700 (PDT)
Message-Id: <b79157e64f0950d25a23c50a8ea83cfddf67ddf5.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:24 +0000
Subject: [PATCH v3 02/10] xdiff: delete local variables and initialize/free
 xdfile_t directly
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

These local variables are essentially a hand-rolled additional
implementation of xdl_free_ctx() inlined into xdl_prepare_ctx(). Modify
the code to use the existing xdl_free_ctx() function so there aren't
two ways to free such variables.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 78 +++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208..fe02fd7925 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,99 +134,81 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf)
+{
+	xdl_free(xdf->rhash);
+	xdl_free(xdf->rindex);
+	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->ha);
+	xdl_free(xdf->recs);
+	xdl_cha_free(&xdf->rcha);
+}
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs;
-	xrecord_t **rhash;
-	unsigned long *ha;
-	char *rchg;
-	long *rindex;
 
-	ha = NULL;
-	rindex = NULL;
-	rchg = NULL;
-	rhash = NULL;
-	recs = NULL;
+	xdf->ha = NULL;
+	xdf->rindex = NULL;
+	xdf->rchg = NULL;
+	xdf->rhash = NULL;
+	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
+	xdf->hbits = xdl_hashbits((unsigned int) narec);
+	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
 		goto abort;
 
-	nrec = 0;
+	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			xdf->recs[xdf->nrec++] = crec;
+			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
 				goto abort;
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
 			goto abort;
 	}
 
-	xdf->nrec = nrec;
-	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
-	xdf->rchg = rchg + 1;
-	xdf->rindex = rindex;
+	xdf->rchg += 1;
 	xdf->nreff = 0;
-	xdf->ha = ha;
 	xdf->dstart = 0;
-	xdf->dend = nrec - 1;
+	xdf->dend = xdf->nrec - 1;
 
 	return 0;
 
 abort:
-	xdl_free(ha);
-	xdl_free(rindex);
-	xdl_free(rchg);
-	xdl_free(rhash);
-	xdl_free(recs);
-	xdl_cha_free(&xdf->rcha);
+	xdl_free_ctx(xdf);
 	return -1;
 }
 
 
-static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
-	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
-	xdl_free(xdf->recs);
-	xdl_cha_free(&xdf->rcha);
-}
-
-
 void xdl_free_env(xdfenv_t *xe) {
 
 	xdl_free_ctx(&xe->xdf2);
-- 
gitgitgadget


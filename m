Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8172F39BE
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570709; cv=none; b=tHliQjeE0tcGJJWesBVAr8ScOnrd5m/NhIDyBhltdpsKoWfFsm2lLhk8ZRlL7BWuk3v6fTUMHuxWWijF8Ww0e5XuEmCYY0v/tKNN0FOOZ5HMw/0E0ZguD9wtWups1ZfAHKC2aC4uimNqfCOOMAoP5lOw/QfQQfOCghTIcLv/l7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570709; c=relaxed/simple;
	bh=Eoy8OK8PESnNoLZ5qIFd+pIalmqG6lGs9UrjiWW1pXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AQzfYxQLR2D/2uHAbRI4/m29YlGt9stHdySTyCbhJJAT6wvkaMqTtc69YFBuJVs9dPUOsvWGIEpAjdJIajGIwH1g5bHMdURJawU7kzsyOIsPmineowCqU17zh2j7RsV1WQf63nyWtnmk/Otnh2Bh8fjZtnX/011L9xSWqdTsAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/6GBrKQ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/6GBrKQ"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42571642aa7so10727895ab.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570706; x=1759175506; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=a/6GBrKQSjOGtzuyQyVrLGqBANuoQ0s7buN7TSJ0GAvWZPpDWb9yjXDO76UNcDxQea
         coIhW9Dwk/Vdsuu1hWKBMZmslrOojOEHzNwW83dmQ84SblxAMjI1fmyHWRLnU1Yfpl6a
         0LmW+j/rbQxWkds1ieMznTFZbhqUxiDtQwl0kI8hxIoDmItIU9cqTJ0AcA2YuY8YH2/C
         zuvJboAlOerk+YX42yVsBn0jF+svzu421sAZHadusPjK2pYh4NhF+JbkQGeI0i7tzurF
         wZ6tK3H7YlBGt3hFQjHs1vRBVqWf4lgI2/5wB7k0STEYdqtN+xWdiMSHFg7xpAcf7tvo
         rbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570706; x=1759175506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=W6FcV7NTH08FSz9wfn+0xe9ILtIkH4OZh0BBPV95FSgxspzCTHJtn1FKRjgHo58WXG
         +NkD0+dxuCdL5oCQmI5P4r/+Xi4cB9mQHMRXTMJYqoHZ3PyBuIA9RrWyKci1YwqoyaHi
         2pTTVoI8dCGN7pfYqKUdtM6wkVOovvqEcGP0iBx8hD1JU/FklsQjCfdigjWtcRSyKY8A
         BxL8N4Mz+QCKPU1PUVlKCKg5nbGihpe34b9tBeYdlZWc05GXVdxi5zi6YPde513KYW2c
         L9Guj/vnQn5tV724sJbJpIjaQV2Phd3S4HDzIBN8wro9MS+62ip0wMP95hkt5eWezwNH
         klHQ==
X-Gm-Message-State: AOJu0YzRuho6PpBiykyGXuGAqnuL/9HSoQ98PfmX9Q/kMdBh12iaEFmG
	Y0uWw2cep9+zyJr8cXPKU3wgUp/6sBltMkVMv0Yzafa4YgGlpASlP7LE+/8B7g==
X-Gm-Gg: ASbGncs+V27wau6d6pBKlVcrZwOU7FT2I7gY0ppyOikv02rXYhiPcCerR4bOhoC5shH
	wAthSNsEzBLwhodZX0/k0KNALluTQZsccofw3xLy1Om4ppUj6at7t0mbH5O6N1shHPVeBl+rO1e
	PbHOProS36Ew7HRoABe0bJTHKB4COyaFQHbaTvmuXHpEKLdJ27Gd26IQqG5gy/9Ru1GhHqSfa98
	tZx6ZrZMfwBbuO1uhs+0ivc63xERF4Ry4rOOxmXvF+p3NEIxQ5/pkn0uUVN80kbMuBT6zs4Oh6v
	iBTFIgayx/Ci/2lKpIsIzQGe1rvZNLFW3W0ve6HD7lVHxAsgZjuU2zB73K1a3YWLapkjPP+mXMk
	3I45t/xUmGP+3BqI/yQy4zB3S/A==
X-Google-Smtp-Source: AGHT+IFqBbYTQA5n2N+XLw8Ph6oWv0omtLISaRa51GBHH9n6wn5KK3MxBCDHL2+4+gHVIPcV4OnXqw==
X-Received: by 2002:a05:6e02:3804:b0:424:8120:546 with SMTP id e9e14a558f8ab-42581eca60cmr1495715ab.32.1758570706422;
        Mon, 22 Sep 2025 12:51:46 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4257d3a98fesm10294235ab.32.2025.09.22.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:44 -0700 (PDT)
Message-Id: <79d1099656f5b86831e8b4b784daa42368f5a2b1.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:30 +0000
Subject: [PATCH v4 01/12] xdiff: delete static forward declarations in
 xprepare
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

Move xdl_prepare_env() later in the file to avoid the need
for static forward declarations.

Best-viewed-with: --color-moved
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 66 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e1d4017b2d..249bfa678f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -53,21 +53,6 @@ typedef struct s_xdlclassifier {
 
 
 
-static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags);
-static void xdl_free_classifier(xdlclassifier_t *cf);
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec);
-static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
-			   xdlclassifier_t *cf, xdfile_t *xdf);
-static void xdl_free_ctx(xdfile_t *xdf);
-static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
-
-
-
-
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	cf->flags = flags;
 
@@ -242,57 +227,6 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 }
 
 
-int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
-		    xdfenv_t *xe) {
-	long enl1, enl2, sample;
-	xdlclassifier_t cf;
-
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
-
-	enl1 = xdl_guess_lines(mf1, sample) + 1;
-	enl2 = xdl_guess_lines(mf2, sample) + 1;
-
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
-		return -1;
-
-	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
-
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
-
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
-
-		xdl_free_ctx(&xe->xdf2);
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-
-	xdl_free_classifier(&cf);
-
-	return 0;
-}
-
-
 void xdl_free_env(xdfenv_t *xe) {
 
 	xdl_free_ctx(&xe->xdf2);
@@ -460,3 +394,53 @@ static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2
 
 	return 0;
 }
+
+int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		    xdfenv_t *xe) {
+	long enl1, enl2, sample;
+	xdlclassifier_t cf;
+
+	memset(&cf, 0, sizeof(cf));
+
+	/*
+	 * For histogram diff, we can afford a smaller sample size and
+	 * thus a poorer estimate of the number of lines, as the hash
+	 * table (rhash) won't be filled up/grown. The number of lines
+	 * (nrecs) will be updated correctly anyway by
+	 * xdl_prepare_ctx().
+	 */
+	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
+		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
+
+	enl1 = xdl_guess_lines(mf1, sample) + 1;
+	enl2 = xdl_guess_lines(mf2, sample) + 1;
+
+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
+		return -1;
+
+	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+
+	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
+	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
+	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf2);
+		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+
+	xdl_free_classifier(&cf);
+
+	return 0;
+}
-- 
gitgitgadget


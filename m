Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5896145B3E
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274326; cv=none; b=irsab9XzdBNqQMZr6AVKmaKzCNyeSQ6Dbxy2kVJMw1BOQ9F4inMwbuGuOlV0LcZP2TlViQrZ6y/YcAd56NpiFh8G4qOh7gNNnc4iYYjuAVYuP99AB/q9Teogi3ujQJKRLEF7ScC/h3wpr3cmYVDpm4XmZh4BLmaTZWRHCaCp4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274326; c=relaxed/simple;
	bh=yyGGyJwbZmFH9erhYdnDQVMsrUEadZoi+c9T9MP8R+4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B1DYqqGmWS4qW+mn6wOZ5VbV3R4t0FdHiVI8j6HGEZjib7ZDySi4wBJsAIJkY1JD0ZouCvv6MF9GeofOd8ThcjolQ0fih536j/JZEgtsP6x8KVv5bYGumuPOh6WRUlAF5K4w1kgiqEPBr0Fa/R3dpEpeZX0bB6kFTTLL7umD0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXJnLtU/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXJnLtU/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80cc99fe980so381124085a.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274323; x=1757879123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMyKjHhICgd/lZlrHTgqq0INgNOG8RjMUkZvD6tVE3A=;
        b=TXJnLtU/rSoBAFg5WW3uBXqCtdUldDQNkoNsg6yhQAm4n51JlH8/WrUhS5ELhFxJju
         sg/zsewjxu7FliLjYtKqnsG0KMC9AKvKHGgmSucHZ3BjC2X5cdpj42cXSeb51v6pADEI
         fkbtxQ9Ig5QNd+vbeZ5fHuNr1APunNNO3FnJ/GAbyJG/EI5pkVAHvmaCDM0RjUziI9Rg
         9zn8h70gwa4ookaOvUOmaohV8nl3y4IoikEvl3ehAdMg2vWgpHYmkMiT91W5FBAPQ8+5
         k8VRnHIA9owiaXuA17b280AluLPKML5XmZKWWcSAtV+zsTMykErSR/6+L5ZS0u7Iqmh3
         8Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274323; x=1757879123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMyKjHhICgd/lZlrHTgqq0INgNOG8RjMUkZvD6tVE3A=;
        b=j+zqbznfa22y4ccNtjfCb1w4GoF92/1NJTOI+BVSh7vs9LqBrde/1fMFtqm4ZtOEc9
         U9TYJxHT8YYJ6EnwHt8wUUpydpgswq6RF47o28LzBBWqEW42txp89W8m4OG6qjlgYf03
         aWJPE1XmuKbnSjrIcKiBeU31kHsv6Y6HCnIxFGtgtD+vTqNcMhf54dF4UM+xKNqugIni
         kRWd90hw0Ktj0tPIZbsBOotFHZi41nw3TYbhodX/lrAzkIY2jNV9zDdpgA2GDV+UZwxl
         EhPFXHqf+V3XXxtlCAaK1Udl2s0O8QCmWzu6MCrxBLmjkQeHgd0rkYq6kav/hUfQMrnP
         Mcww==
X-Gm-Message-State: AOJu0YwfrepgvfEZshWgiCE+eXGNoLbQqaUSOOh4yUmO7YWPqpyAtkxn
	MZVPOddwLKuhaioVFdhoWABgF7Ac49MF9122KSpNEgcIc1CHFCjuP7IsyW1hXE8u
X-Gm-Gg: ASbGncvycQ9ApPF4A70PpEfyO7+jJVnn96wHkgLlZazKRxZePnNIYnT6G2mrfFyZN3s
	mWyMCJdXCLodhWp+wVIJ3S2Ic+ryjenFOb4ivG7rMXoWJcTdm+m12HGkXSSpK51F9IHUdwiUUOm
	J/2qnVTMtWlZ6tON8Cs8sFddakwRvhygJEQ4sjGro9epL0fq+OD07QrgoyLJ9Y+ce+dk8xPrBK1
	MJVm4B+NhByBWYqyZE+gb11dTFUagJ/aCBVhkpTZqEcszso4cCsZ/j743zIe61jRR58o71cLt8Z
	E65EEfJrxc5uktJ7L+bdGiyJG5fuEJ6csPJM8w1gQug9xYWgoBSlkMnDGLutyAnJZ0GhAbautNr
	m9MSaK3eG66FAe3Ae1kJC+o0fceKAB6fGwA==
X-Google-Smtp-Source: AGHT+IEtS8RTo3ycmmZn5K5zvF3VcKMRcRxzYDekkkUmA2XpxKOydg/kKCj4hmc3So1dJ8sJh/ahtA==
X-Received: by 2002:a05:620a:4483:b0:807:198c:8880 with SMTP id af79cd13be357-813beff5f23mr566223585a.18.1757274322952;
        Sun, 07 Sep 2025 12:45:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f799b83sm87194661cf.45.2025.09.07.12.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:22 -0700 (PDT)
Message-Id: <9cf9d09c079060bb03556db270a3100ca62c6ba0.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:04 +0000
Subject: [PATCH 01/17] xdiff: delete static forward declarations in xprepare
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

Move xdl_prepare_env() later in the file to avoid the need
for static forward declarations.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 66 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e1d4017b2d..a45c5ee208 100644
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
+	    }
+
+	xdl_free_classifier(&cf);
+
+	return 0;
+}
-- 
gitgitgadget


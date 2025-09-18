Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3E208A7
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239795; cv=none; b=BQUkt2+xmrHzqERLpELqW3oV/Ql+B170ViIsSEXJSOR9uJciqmWCqaS9IhYWo0x6cAu8OgqTr+n6X8QtYUiNL4jC+ZPm8+SE4eeS7rP0+WQpqmMnZUcgf4+jCaF8QTzCn1Lkm59u1avzl70Q2e+bvmaJ9uPdjmXUxY6Q6ZsQVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239795; c=relaxed/simple;
	bh=tdL3sbhllOs2HxTYEeArCw3djMbOqN6Cw57m9QGzwos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZXPpWwxoMzeJFKF0uU0F53fw3Lm1ODP6Gt5rfB4CcoPBvcM9F8v7fXWBw8AkRWrsPJbLFhvsaBqfNWedgTMQAyEGYdCpk8kIYy2ivdtmdA5XcSpst1P8dDdq6JuF+mCvQ8dQTOo9aUC3eegz8dg6baMTLGmVhE5fIEQLqp3gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baCOjH5L; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baCOjH5L"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b61161dd37so9792631cf.3
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758239792; x=1758844592; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5FbEnqiElnpC6FbWKiLcegXM5pLQlUSDTHfYtY46wk=;
        b=baCOjH5LVFxDdW6dHrbP+7GY/aSBlDwvjkAeK2ZAAQU/1Onc20XE+2FKCZffQuwcRl
         GNHdYHO+r6R2vxPNcjmiHaQQJo4tqWUvlHTXw93RH3Mn6GEp78AzhVffvrA/DKcU7ZZA
         0oZm2FW0HthP30KtTOaqgv8PQSlwsxG6wzz5o2qfPYJEUsx88PfSC9vJXd2OJujAwD64
         7t5yuwGH3HYGIBzYALERdRB2tF12V+T9jWIns7zzOGRzRAF6Qf75RtyjTsda8W0LzuZT
         RReRV1k1Y/N6HmAHy/nUiPsDcyBE+//eS52CKbw4/2+42hD20/HPbRojPjDJosytAONQ
         n4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239792; x=1758844592;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5FbEnqiElnpC6FbWKiLcegXM5pLQlUSDTHfYtY46wk=;
        b=V1dxC9rwcs78XQ+s4heHnblRUSb0diCy6vfsffBUpnSb4n/JoZepVa07bWBktcZBg6
         olXFqD1EZj8+jtuDDkxpJb0n5GAUmZVf5CISzTBSAO8XY7n1UgUrqwV6Q/o/N25Ws6Jm
         r+t9P8E9tXeq5r/iQe5ifrJn4mREr5IX13r28ohkBU0VV2UiiRWE25rlgncfHL1tCRMK
         dlh16wEZC1ZgW8Ynk9LVklxDAI/3QlFIvqoV/Fyfo5CkEH4hJbqBB99MgtKQ0UhWMK/J
         VaG/vl8WCyMqjLxzzHvagFoV23AaxwFDZXhx+YkhPHXyJMOZGS9sWIaWmtmkBnZdHxPO
         AVtQ==
X-Gm-Message-State: AOJu0Yx8VlpFFIZJe6GZvixu0tDnlQksABY+gE8OporZ1g3yMhDKIOAW
	NDxwZUUjL7RIqjoH2UuasPbr8hpfUzOvoTP7L8Z4ahbK4Z3SSX9bNgQ1PVWbo6gh
X-Gm-Gg: ASbGncs7XdDEwrSduNEx0k48oJJnX/Vg21oT+clgjRlcS0dWmbpQcA0XAa/Vro+JcFd
	OBIn7VNE45lElXIPqOPp+SbBB1q18yTF8yrZH6lEjZPCw2ksWSjco2idWhKW6A7blmPH3Rny3Pm
	dOsMxl9puMd6oKGO5tafjGl3h6mjxmCAi0G+hzFRO7M9lKjDUHHaGwlDYzxf8PhNLaYH7I6cQow
	J0SKDAFgyBMJaypV7p5FHmS0r+Vmc49x7FqPBhA9EI/xxzIO7ZUc1sSdb3ukRK5yQr1sGnXdH2o
	wBaQcGuiACQw+C0SqMro+I0PVUJucCLwHGf73rQMsyAgudYYVQluBlINaFLmMMjNMKWYHd38y+j
	aeCzP8o96JALIIWRW3IHccLvmPgaphAu/JYuR1QWBV8w=
X-Google-Smtp-Source: AGHT+IEIbifaJS1dzt+476mN1C7zeaVAnD0ncKLoSkOE0r2kF/06ZuyKvQT5BGbAeR+E00MyoAPd1g==
X-Received: by 2002:a05:622a:14f:b0:4b5:dc7c:a6ea with SMTP id d75a77b69052e-4c073106ac8mr13706971cf.49.1758239792120;
        Thu, 18 Sep 2025 16:56:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363240f538sm242826485a.56.2025.09.18.16.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:56:31 -0700 (PDT)
Message-Id: <784cffcef564b31a32c401b35f33610b85126f7b.1758239789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 23:56:20 +0000
Subject: [PATCH v2 01/10] xdiff: delete static forward declarations in
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


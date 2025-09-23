Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F330FC36
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662692; cv=none; b=VUo+Z+vv3r6VX4rdPF3Ll0ulze0Dg8nZNbr0b0TOM5VXfbPR1wOoYt2j7qCCVTTHwVDDJ/WQeNwwbiBBDWxl59VkJIMFv67tQKLTnAjn9tdh0FkoLyEayRLYAzTq3FJK+LUrbaXBqtWNXM+v3pf0/sFU/lp2Atw4kaLhR5S+SbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662692; c=relaxed/simple;
	bh=mgeQ9/8PtcanITzKiAJFQlNGNSseLsUtq3ky6ExnuJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z/vdcBJLqZRc5uB8MFZq9BTVB5/OAQ/nGzM6pPKGi5XThRGY3FAMta0pdcUg9aPROGbPx+OKxOZJUvgc5hUSQN/o8bFcXV6BLINO00elstLrGWo0b7xBnv7em3fHH1XOL1Ht+wNMmjqc47uqqIf1+K/HFSNu5TWMFEF+rEWC5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG3i//7/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG3i//7/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698d47e776so45286575ad.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662689; x=1759267489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/jEjuJ4ntPi7xwXRh3SO+ozBZ1wjtKhGxwrOrMV5uM=;
        b=VG3i//7//MJoAWYE3D16TxxC1wZh42barGuwfYnUuoYQ+voXpgqze4FWOdYsFylRjU
         RnRD9vvUNKqsXhsxETv69QsunKq4C+uTYWLyYbpZgYJHGs+M2eRyDyoUrt4hkzoO8O27
         mzxwPBYRClTpS1Lxf/cWnnIazL+UifnMLjKeO0SrSSF0XzvdnVSjfDHb4WLwQwX+of5J
         C7q77jSExZMFrzscNFI9Pv7OAUyfBeAm9ZuI6iGiCzlFGbWBMNBQ95P/pi3imOqs1yts
         LCwIihgT2uVsBIqID6GWP+1OwuV90d7Or6N8av3ali1wXIogg0CR33j9vrLVlTGivMCq
         uXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662689; x=1759267489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/jEjuJ4ntPi7xwXRh3SO+ozBZ1wjtKhGxwrOrMV5uM=;
        b=NLcJQVgMdVH5RBfAZ/jm2H5gmvcU++AQKu93q4lKxOzxErgglvzP+omlpgVUkZfTDj
         +MxUiPYx66J3Kitz8SPV/u+habtJb2S/lC7kubkFfxCMClBaFvro19jREICYwwsxd4oM
         +dKJUECTqQyN5+a1SCX0iA2XL5cWRPgTF8pe8uYvQ4q2OblSDjOd356C0kcA61SOCOsP
         UFWNul8Tkbm8noBciEoQNf+u/xls8EGYzxzty2DnQDx4vbzP10cAp0Xykejxsl9Zw+7Y
         ekQgRaQW/0LfS9fRQ4UeBVUWLkD/s96A7KUUZiD291s5QSdke1Qszmkl2BACKLyuvg3e
         arWQ==
X-Gm-Message-State: AOJu0YxgAQDNXl+FWZQgsqmgD97UTs5ldNfvhczAGUFWh1t6bn4hrirC
	V4gtMAfy9YCyg+q7oocwwsyxdgzy8Wlw+CE6pDrsI5T3kPki2kohk7e+nLVD7KgW
X-Gm-Gg: ASbGnculmLp2zj9jRlQWDY7igqxGeze5JAKg0mzlxnsCdPhP373Rjl21f2v1gGqKCFh
	m5y1ga1gHCf1mRQetIao509N93BJAwNicA8GLg6h1hMrbdaSCVHP2pA4JDTqpaZrMCAB/HftPRz
	D0g1eEdSxa0jE667uiUBc/9pkDoW+klRXVpZlDYba1vg8XgvdnRyqhmyoN8yPTnM3i9+v4W8NOu
	uu3RK9OSv1QqgKKLDJS67hs4KkVHmS7ESIumqhctwkEqrxo+T8DkFtVWn2sOs31d72UO2wEDDUd
	3AAGnx5fPnYyirkH/bd406X7ylgFhjiL1tpEsjGPDyLpSk9EsX45x5DigFmXfUJSaATcRh8W51D
	0oJiSjOLa/wIPXkBi8k9lkcWm/A==
X-Google-Smtp-Source: AGHT+IG3fAuWpn2eA/EJgh0kT4aV0G2PB985cnFsY+7eJtp/aqtBYxxH6rbaqbft2oCas3Oj5ftVnw==
X-Received: by 2002:a17:902:fd10:b0:267:c172:9734 with SMTP id d9443c01a7336-27cc07f0c25mr32124605ad.7.1758662689550;
        Tue, 23 Sep 2025 14:24:49 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm167614815ad.35.2025.09.23.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:48 -0700 (PDT)
Message-Id: <570ab9f8983d7507cd8f1937176f3268255da416.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:28 +0000
Subject: [PATCH v5 11/13] xdiff: rename rchg -> changed in xdfile_t
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

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 28 ++++++++++++++--------------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 12 ++++++------
 xdiff/xtypes.h     |  2 +-
 xdiff/xutils.c     |  4 ++--
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 83c4cff6f7..5535452061 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = 1;
+			xdf2->changed[xdf2->rindex[off2]] = 1;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = 1;
+			xdf1->changed[xdf1->rindex[off1]] = 1;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -708,7 +708,7 @@ struct xdlgroup {
 static void group_init(xdfile_t *xdf, struct xdlgroup *g)
 {
 	g->start = g->end = 0;
-	while (xdf->rchg[g->end])
+	while (xdf->changed[g->end])
 		g->end++;
 }
 
@@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->start = g->end + 1;
-	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
+	for (g->end = g->start; xdf->changed[g->end]; g->end++)
 		;
 
 	return 0;
@@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->end = g->start - 1;
-	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
+	for (g->start = g->end; xdf->changed[g->start - 1]; g->start--)
 		;
 
 	return 0;
@@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->rchg[g->start++] = 0;
-		xdf->rchg[g->end++] = 1;
+		xdf->changed[g->start++] = 0;
+		xdf->changed[g->end++] = 1;
 
-		while (xdf->rchg[g->end])
+		while (xdf->changed[g->end])
 			g->end++;
 
 		return 0;
@@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = 1;
-		xdf->rchg[--g->end] = 0;
+		xdf->changed[--g->start] = 1;
+		xdf->changed[--g->end] = 0;
 
-		while (xdf->rchg[g->start - 1])
+		while (xdf->changed[g->start - 1])
 			g->start--;
 
 		return 0;
@@ -938,9 +938,9 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
-			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
-			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
+		if (xe->xdf1.changed[i1 - 1] || xe->xdf2.changed[i2 - 1]) {
+			for (l1 = i1; xe->xdf1.changed[i1 - 1]; i1--);
+			for (l2 = i2; xe->xdf2.changed[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 4d857e8ae2..15ca15f6b0 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = 1;
+				env->xdf1.changed[line1++ - 1] = 1;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = 1;
+				env->xdf2.changed[line2++ - 1] = 1;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bf69a58527..14092ffb86 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 27c5a4d636..b9b19c36de 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -126,7 +126,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
 
@@ -139,7 +139,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xrecord_t *crec;
 
 	xdf->rindex = NULL;
-	xdf->rchg = NULL;
+	xdf->changed = NULL;
 	xdf->recs = NULL;
 
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
@@ -161,7 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
@@ -170,7 +170,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			goto abort;
 	}
 
-	xdf->rchg += 1;
+	xdf->changed += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
 	xdf->dend = xdf->nrec - 1;
@@ -287,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = 1;
+			xdf1->changed[i] = 1;
 	}
 	xdf1->nreff = nreff;
 
@@ -297,7 +297,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = 1;
+			xdf2->changed[i] = 1;
 	}
 	xdf2->nreff = nreff;
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3d26cbf1ec..c4b5d2d8fa 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
 	long dstart, dend;
-	char *rchg;
+	char *changed;
 	long *rindex;
 	long nreff;
 } xdfile_t;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 332982b509..ed65c222e6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -425,8 +425,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
 
-	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
-	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
+	memcpy(diff_env->xdf1.changed + line1 - 1, env.xdf1.changed, count1);
+	memcpy(diff_env->xdf2.changed + line2 - 1, env.xdf2.changed, count2);
 
 	xdl_free_env(&env);
 
-- 
gitgitgadget


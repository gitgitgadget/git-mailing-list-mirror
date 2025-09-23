Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E30CDBA
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662696; cv=none; b=t+k1zfkdwhS00eAVsop8VwGhwfe+guPuoIB/QaWB/kZZF8UodXcr0uj7PaqeLYnj5gpVPaKV/bC5ig/w5jKuOZ04aN6ausu86CoRvoSBnRjNyxF+uUlAoCp/5jJLIHh2jSOp9fAO8bkzf3dSVBBHMBaJuBm77+uZu9cog3jNahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662696; c=relaxed/simple;
	bh=bjcwUmGL3V4ZDOUDRG/VDG6nUfuuXTrlSwSBEq8bBxo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JBZoR4m33SorzDEaS7ba1p9HcHJQ8n2RYUCI4G3h+bOzanZbWhmWcuMTcW+DCjq32uVN55HfvLtXUAQQ6ebLZcoKM164MlFIvBLLiRU+SsMnekCQnXI40lJcbns+ch6sz0+3sFjxIs8gU+vb3e/Nayv2lUru8vYlSyQwCZN0jLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMkrFlPJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMkrFlPJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323266cdf64so5114325a91.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662693; x=1759267493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnKAyk4iRTtIyK+xnlr6b+PZFFh2v0itdXW8rIkytik=;
        b=SMkrFlPJS1VpNW2dE+8WXQbLOkJOt0zmgPP+hSfyvLpVjJWqP4H7zFBWFGOJoCEFyv
         muG3aUi/z26kBtawM4Xd+2SrnJT7KCtyhsKe/IQcqmjiHsrocBI1ofMVrgujMHr0FOh+
         LN3dlRd4lTC7cAudDYNag6zeBR5M8h/zdW0Vk+/eKEQwqIzvUNIItH9PYNzV1+y3mM/O
         uOoviEawBj/gRVNy4EMP8YtYwXiH55CNc/sENIG6tmUyxnrjayoi9ptlZl/r/Zlgzmbs
         axkPao5h0t0DwN1VaFN1sc04v6P1OhDD6INcWZrs5wmt4JfKylXOdkIbUGLEgbbS70tP
         d+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662693; x=1759267493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnKAyk4iRTtIyK+xnlr6b+PZFFh2v0itdXW8rIkytik=;
        b=hYbdHg7cEsBU0FpIin9Qykc4tp18RtAHtBzkd78R+r7G1RCW+nvPnW15cmHqWjw8G8
         q4FbdjRPajFUyeS0kxPxRQcnNjZULWB0bZbsse4FSttQ80RjjGe1zllpMsVXpZFpZlWF
         GPND4lemyiVMpwiMJEG5/HFHVs1O67Ae6go20AvTvtGjoXgDeRiJqlETWasA8f18XlOM
         YllSXeamEyUVqIu6wHSS8S9vtiQGZPCASbAvosQioO2RNSN+sCgHnOsplZhFFNR64LEv
         9trmCslnrTGL+JueEoywkS8m8plXvn+/7y1s4PmVhGdVcSWh1S/Sn3SeDYMoLBRlcdKl
         4kdg==
X-Gm-Message-State: AOJu0YyfD4hKUHyKESuDFHejNoBQubiKvL4Qw8olMDp3SN1WD9+Dybqe
	/nKLmWQHMVNY0Ya+p3b8y5GPmqvLKu5tEkRb6dG3Yyi0V1U94Zj0HZtlWG0ql/Mj
X-Gm-Gg: ASbGnctZTwGUSU2kTbXteiIwry58a9CU/2f5YIOY8mzzR7TYCamBQks1jfx9d8xsKh/
	SMmbUBsug0HXIb4iiL4yJqTV9OCZ3L261uxyRUvymoZu1039P9MyhUf+LAWa0V5AVzixYU3l3nq
	rQK/CWqrxRQF6qouVdixzB5l9TcPFtij47JVmNPQCc+pxoikGbZuaaE33Bjo0ww5hXVe6UUDT0I
	EKaUILxIaiM5iSbq7JCDskzfHKbiRDXawMdyCWdy9L8D6fnawL3C2fTdnZc4iOP23cJZngSAcn4
	xtPbCgoeeFmUOGNvdgjhoJ+sFNOeX6wi635Qq8HaZ86ItBviFPkBY/rYrDqkJxR70OgqJCRW3hY
	VsfctCzqkeAJIDiA9pw1SNV/gsQ==
X-Google-Smtp-Source: AGHT+IF+q5dkDNbq46yArssyUvagjm93983DOlUNXEBbSyiAWXRSu9qRWNIlZTK1RI9Q+aUUW0Z6Yw==
X-Received: by 2002:a17:90b:2243:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-332a94f538bmr4764049a91.3.1758662692721;
        Tue, 23 Sep 2025 14:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdbf18bsm121272a91.20.2025.09.23.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:52 -0700 (PDT)
Message-Id: <975e845bfa80fe838433f7f64759a72f6d565aea.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:30 +0000
Subject: [PATCH v5 13/13] xdiff: change type of xdfile_t.changed from char to
 bool
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

The only values possible for 'changed' is 1 and 0, which exactly maps
to a bool type. It might not look like this is the case because
matches1 and matches2 (which use to be dis1, and dis2) were also char
and were assigned numerical values within a few lines of 'changed'
(what used to be rchg).

Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
for changed[k] makes it clear to future readers that these are
logically separate concepts.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 12 ++++++------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 12 ++++++------
 xdiff/xtypes.h     |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5535452061..b902be9d0e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->changed[xdf2->rindex[off2]] = 1;
+			xdf2->changed[xdf2->rindex[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->changed[xdf1->rindex[off1]] = 1;
+			xdf1->changed[xdf1->rindex[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -753,8 +753,8 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->changed[g->start++] = 0;
-		xdf->changed[g->end++] = 1;
+		xdf->changed[g->start++] = false;
+		xdf->changed[g->end++] = true;
 
 		while (xdf->changed[g->end])
 			g->end++;
@@ -774,8 +774,8 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->changed[--g->start] = 1;
-		xdf->changed[--g->end] = 0;
+		xdf->changed[--g->start] = true;
+		xdf->changed[--g->end] = false;
 
 		while (xdf->changed[g->start - 1])
 			g->start--;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 15ca15f6b0..6dc450b1fe 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.changed[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.changed[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.changed[line1++ - 1] = 1;
+				env->xdf1.changed[line1++ - 1] = true;
 			while (count2--)
-				env->xdf2.changed[line2++ - 1] = 1;
+				env->xdf2.changed[line2++ - 1] = true;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 14092ffb86..669b653580 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.changed[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.changed[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.changed[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = true;
 		while(count2--)
-			env->xdf2.changed[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = true;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e1d575f779..070d220f3b 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -273,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	/*
 	 * Create temporary arrays that will help us decide if
-	 * changed[i] should remain 0 or become 1.
+	 * changed[i] should remain false, or become true.
 	 */
 	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
 		status = -1;
@@ -305,16 +305,16 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	/*
 	 * Use temporary arrays to decide if changed[i] should remain
-	 * 0 or become 1.
+	 * false, or become true.
 	 */
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (matches1[i] == SOME ||
 		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
-			/* changed[i] remains 0 */
+			/* changed[i] remains false */
 		} else
-			xdf1->changed[i] = 1;
+			xdf1->changed[i] = true;
 	}
 	xdf1->nreff = nreff;
 
@@ -323,9 +323,9 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		if (matches2[i] == SOME ||
 		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
-			/* changed[i] remains 0 */
+			/* changed[i] remains false */
 		} else
-			xdf2->changed[i] = 1;
+			xdf2->changed[i] = true;
 	}
 	xdf2->nreff = nreff;
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index c4b5d2d8fa..f145abba3e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
 	long dstart, dend;
-	char *changed;
+	bool *changed;
 	long *rindex;
 	long nreff;
 } xdfile_t;
-- 
gitgitgadget

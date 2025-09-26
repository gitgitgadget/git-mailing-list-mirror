Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25694298CC7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926539; cv=none; b=LeT8e5UttYzRbXO1URQ7FtfhWLcjvZW9og5lVGYDYL2Py7FMw7cf+8T84Qn2TIaH5JeJ3l2G54YNY/R/1HloWyKOrePFfhlRLOwe2EGIp952QOafTkPQROxUcY6naFZqI2x9gI0eYADjnS5k8qwHaxiuEm3LeFtadj2h1gqcx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926539; c=relaxed/simple;
	bh=uQM2PvtRNv4Lu1M+6tSQiaviOyrv3Q08qYgSGh8spwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gRb7aWHqbQj8gZbdl0Wdjz8EHqeZP7lFTkydwxin5cWsppZNhZHDWZHJ8rLFYtzrXFG3uO2Yed6Ln6nW1VXfDcs4IwNzT6XYLj/iG/Q0f04BmtJJogZh7EGsDPD8dB9gfxvpjvP0W8JbjE0k9tCVNSl8xtSpogZjn4QKIa2u16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmy7aUC8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmy7aUC8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso2013181a12.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926536; x=1759531336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGGdbG4Ty6xfOjluhmXajtMy8fnzRzYwInJxuG2fjQo=;
        b=Tmy7aUC8nHwJBMAWTgIb1cK6+gvJrrHPfr2FSWfEUkOVWxKpKy2rSTvryWilUIAiTK
         vt3tiAirhBpj3Bc917wzCuavb9LQKUMe3ZwCtVWugYMeOeKzu5KTglj1Li5OKduji9f6
         9yFmpudj7HyUJEdV2nbgqRjjJGLePaLVvKUXNJDLLm4DE5V7mAQ4torFEg0aGbMvZ0xY
         phR73kcATrwr5o43elNefQNP+VOxMCVebMS3JlwMfnUnqil3MlCrKtGs25KatGZHTpjq
         Ka6Ejh78mjFSXb8HkSm4RLa94QW2gVA/w0vge48g6jusTXcydpn8XSNwDhAY+ln5hQ2t
         srUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926536; x=1759531336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGGdbG4Ty6xfOjluhmXajtMy8fnzRzYwInJxuG2fjQo=;
        b=U142VY3334v1PS8wuR4txCQUHNPM8QKAIhz9Vne6x/hzuckJTyPGCe4M88WAjgp47x
         IGg1zmORM6tPrUNWASy1HE8qRHRtAus5bKqstj7I+/0rgNav8KVJuRPD6VnS4i+DILQD
         QrBi3/Zsp9qdAfJ/qWwFcZWX/40XWT1NZQMsSJS0cB/VI4qdsO0SnlaiQ5boD3lLEsDS
         XiHVmTmnKR47+uKnUamtMgKjPf1kZjAWmYPsBphIn/PAyp/Ob+8arDu8bi1C2+f2OeuX
         Xvnf+WwoWhi9JhFcp1bkRbJYwrTovjgt5LZ+tf6tLRWNvmUGgjM0vpFFW9zA7iRtXzrz
         m73Q==
X-Gm-Message-State: AOJu0YyF/sIj+72N6Aglb8Bm5UW+4k4L3banSGYdgF0fSHSr9lCVZnQ5
	ztnzOFqsteRBksF7+zXCRyHMbcyUl30qecDvCA/uKaDuhCJr2MWPLyT2be18Sfii
X-Gm-Gg: ASbGnctGsXe+jmzoZZA48VHpgiTagM7dwTc29koNS+iGJ+4s3QdrMBgPU92AWWMUA9r
	g9GQ31+drtM4A6IKdkOj+p+irGgJLZSC/QbfcGVGCWgzqDR5WcUlqI5gPqngexVVvOacD8YDZtb
	0SXPENpG4SLv6B79l89a8mOGxB2VDXCall5i4OcuXnVW5pK4rwH2fZNcBTY5jdGKsoNqZfbntZY
	iBYJJtKMk0rCQMgIRGfhivvSmbbu8TuOjpxeWV5dci1M7K22TrkyoOMFAZqqpLWtzhnnYuX8prF
	NXi1wXExjRGoB6CVh8h8M4/8vg7/mo97NvLc8AZFqzw6fvsEY4Xg79zowGnrR521KXYSRa/+e12
	DK8mEzx89E2IIYnEcGRJqsvxVB7vSJmubmDQ=
X-Google-Smtp-Source: AGHT+IF+39KUPaQLYL1XIoMc58FO9l4I0HeA6asBbeNnCa4Lq3p1Gq7Xn6PBAh493hSlw7ajD5XHog==
X-Received: by 2002:a17:902:f546:b0:273:240a:9b6f with SMTP id d9443c01a7336-27ed4a76ec0mr94975045ad.39.1758926535736;
        Fri, 26 Sep 2025 15:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69952b3sm64067215ad.96.2025.09.26.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:15 -0700 (PDT)
Message-Id: <83e1ace5bdc16f76fcf236d7178d1be420961505.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:59 +0000
Subject: [PATCH v6 12/12] xdiff: change type of xdfile_t.changed from char to
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
to a bool type. It might not look like this because action1 and action2
(which use to be dis1, and dis2) were also of type char and were
assigned numerical values within a few lines of 'changed' (what used to
be rchg).

Using DISCARD/KEEP/INVESTIGATE for action1[i]/action2[j], and true/false
for changed[k] makes it clear to future readers that these are
logically separate concepts.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 14 +++++++-------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 12 ++++++------
 xdiff/xtypes.h     |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bd5b31c664..6f3998ee54 100644
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
@@ -932,7 +932,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	xdchange_t *cscr = NULL, *xch;
-	char *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
+	bool *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
 	long i1, i2, l1, l2;
 
 	/*
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
index 55e3b50ce6..192334f1b7 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -273,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	/*
 	 * Create temporary arrays that will help us decide if
-	 * changed[i] should remain 0 or become 1.
+	 * changed[i] should remain false, or become true.
 	 */
 	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
 		ret = -1;
@@ -305,16 +305,16 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	/*
 	 * Use temporary arrays to decide if changed[i] should remain
-	 * 0 or become 1.
+	 * false, or become true.
 	 */
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
-			/* changed[i] remains 0, i.e. keep */
+			/* changed[i] remains false, i.e. keep */
 		} else
-			xdf1->changed[i] = 1;
+			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
 	xdf1->nreff = nreff;
@@ -324,9 +324,9 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
-			/* changed[i] remains 0, i.e. keep */
+			/* changed[i] remains false, i.e. keep */
 		} else
-			xdf2->changed[i] = 1;
+			xdf2->changed[i] = true;
 			/* i.e. discard */
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

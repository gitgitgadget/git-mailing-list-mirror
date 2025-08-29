Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF41253B71
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496562; cv=none; b=jAP/vMDhZzsb+XSctACG+tCz6y/swdWM+MCMoUAZQ2RLbd7pGpW7CZdomTjPGl6wpl+Cnts6nckXAIdSy3AyBnb/JwLxfBmFxQ4Trd8yzxQi1jBxdNpxhXYlA9ioopu77N1oB4ro+icXaoe86pecyS8nmndx8Fny33cazRv67uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496562; c=relaxed/simple;
	bh=N6nqg3MweofOzPgnMR2vKlPAblnfUFsy5aAHvsiwhL0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZR+xGvAOSbXtUd5lXb9uEkuWpWiT61PoZi2kdl4lMknMAboHegdroxY3cGpPzUvMUyoRtUvG7bqQgLDbg7VQN1scnhwh4IOfxz+2qiqXV+2EGshuGSPNX3RFmtzM2kH/3i7nopr6rBwRLt6Hm2DXHiz+bzYSMQaPQsFeRTAPzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBlqq9s0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBlqq9s0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445824dc27so21714615ad.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496558; x=1757101358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenBAcWnSomCsE88jzPqaOp56MUmT0cKptlIiRNf4Jk=;
        b=kBlqq9s0PwLiOM/dYuQG/mkfa36ATFG7oOvQHUxYh4EoNxrjbgWpKNDKfpBJfzi1ZO
         lmP0S0yb3u/V0Zw5AMvbCKSyZU74+KvLd18aSD1wiHY0QwfD5hJqqC/I9z/6lmKyOMzz
         Bl0AI/41BOfyaJY53gfwzwBgOBvpR9+bvOANndY0QoTd4MJyc8WzFqpbq32yUxq2EarO
         6D+7xrxBqfklUef4mqnsFl7p9oJFIZekOHY0o4doBW04eBvSShwNy/HiwByUCLE0c3z9
         1KB+vy2MA5qXRdzTOnrNnk4hTHXgB6Mlu7tpCDYwDa5qnSVcav+US8eVaH/mK/Hgp6mX
         2nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496558; x=1757101358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YenBAcWnSomCsE88jzPqaOp56MUmT0cKptlIiRNf4Jk=;
        b=HFLthsdw4dEcmTD6GsKS3iHi1AK+Z2PKEH/OdbtSbr2X04qP9p/HsZdi+OEMaJGYJO
         mSjydkKrbgNiUlTw94GAXE5OmfxCVJQqMQRpnaihcc2AqqcX17DyMaHBYRxInbCWgOsr
         2uo50YHuoAuEt61TL1swNi4hZdJ7ZM29DIqMV29u2AsO+y0nypz4oW8A2loZOVf1DSLT
         +YZisIXUGF9SFBjZrNB45Y11+thmn0eaimhYuElWJozb4zFL2wyfjsTWu0wpn3Ni9+f0
         /Ct9xX/ccB8GSfUrvZ24Ly4hNS0MBFX6MLzJk44QsU64BqdtiDBkAMJitfiCu6SSUi8P
         gu5A==
X-Gm-Message-State: AOJu0YwxJya7aPM0Y3rmkO7H4NsUcJWipBWjZA2ybuxznjwxMbq8uzCd
	I24rJmXMXqny7xvAsQ05oTArrlzOOemlFKL8nAIwYWbGXYORhVCM6W74ZfOnbg==
X-Gm-Gg: ASbGncuKzLmN1zxW4/RGEMvdff3x/xce++CqUl/coJeS4rJlA4zFIzYDS51JdMVvTgQ
	h3+cAcgL7xuJGyJCxBiLAgRyrKchzLDWABx3C04BPFuIY+OuKZltMUGTJ9x3xAWml4ZM6zewQAA
	6zJ0ei21l5qr/tAi72vLIvqFU15Y5XwA/1JEn72Ap3keoTp1SSJjcr0TGipN/rgQDrGN1QVXxi7
	x+T/cYMGsPAA92x+WO4ggpXV2gGI6ABYhj44KArQPzcXrRqpP8onk1C8PO1YG+LmveVb2AqDOe0
	dRwJBagtOTEmfZLwVHxTfQvNNEcelGmKOa6vWZBM5GJiQdpEymgRN1LuHklSyAnFTNEXEVvkDDV
	eLKUW6k2+tIGdnVtsLIZjPge8JCSJI1cd5oWiYA==
X-Google-Smtp-Source: AGHT+IEOkfG2wLMiy6NKQsVp/1iOaofvUssGEwjWFl5x6bMde0WTksupHRuBrKod0EFWxBcq5bf+Tg==
X-Received: by 2002:a17:902:cf4c:b0:246:7d4c:9f90 with SMTP id d9443c01a7336-2467d4ca180mr379445525ad.6.1756496558032;
        Fri, 29 Aug 2025 12:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905bb2c81sm31946465ad.75.2025.08.29.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:37 -0700 (PDT)
Message-Id: <d8f561e1730c6a4274bd13f23fd96cd9468a07c6.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:16 +0000
Subject: [PATCH 12/15] xdiff: delete nrec field from xdfile_t
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

Because of the data structure cleanup in the previous commit, the nrec
field is no longer necessary. Use record.length in place of nrec.

This commit is best viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    | 10 +++++-----
 xdiff/xemit.c     | 20 ++++++++++----------
 xdiff/xmerge.c    | 10 +++++-----
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  | 34 ++++++++++++++++------------------
 xdiff/xtypes.h    |  1 -
 6 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 3b364c61f6..bcab2d7ae5 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -496,7 +496,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 {
 	long i;
 
-	if (split >= xdf->nrec) {
+	if (split >= (long) xdf->record.length) {
 		m->end_of_file = 1;
 		m->indent = -1;
 	} else {
@@ -519,7 +519,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 
 	m->post_blank = 0;
 	m->post_indent = -1;
-	for (i = split + 1; i < xdf->nrec; i++) {
+	for (i = split + 1; i < (long) xdf->record.length; i++) {
 		m->post_indent = get_indent(xdf->recs[i]);
 		if (m->post_indent != -1)
 			break;
@@ -730,7 +730,7 @@ static void group_init(xdfile_t *xdf, struct xdlgroup *g)
  */
 static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end == xdf->nrec)
+	if (g->end == (long) xdf->record.length)
 		return -1;
 
 	g->start = g->end + 1;
@@ -763,7 +763,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
  */
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end < xdf->nrec &&
+	if (g->end < (long) xdf->record.length &&
 	    recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
 		xdf->rchg[g->start++] = 0;
 		xdf->rchg[g->end++] = 1;
@@ -950,7 +950,7 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
-	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
+	for (i1 = xe->xdf1.record.length, i2 = xe->xdf2.record.length; i1 >= 0 || i2 >= 0; i1--, i2--)
 		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
 			for (l1 = i1; rchg1[i1 - 1]; i1--);
 			for (l2 = i2; rchg2[i2 - 1]; i2--);
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index bbf7b7f8c8..11c2823eca 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -147,7 +147,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (l = start; l != limit && 0 <= l && l < (long) xe->xdf1.record.length; l += step) {
 		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
@@ -191,14 +191,14 @@ pre_context_calculation:
 			long fs1, i1 = xch->i1;
 
 			/* Appended chunk? */
-			if (i1 >= xe->xdf1.nrec) {
+			if (i1 >= (long) xe->xdf1.record.length) {
 				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
 				 * a whole function was added.
 				 */
-				while (i2 < xe->xdf2.nrec) {
+				while (i2 < (long) xe->xdf2.record.length) {
 					if (is_func_rec(&xe->xdf2, xecfg, i2))
 						goto post_context_calculation;
 					i2++;
@@ -208,7 +208,7 @@ pre_context_calculation:
 				 * Otherwise get more context from the
 				 * pre-image.
 				 */
-				i1 = xe->xdf1.nrec - 1;
+				i1 = xe->xdf1.record.length - 1;
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
@@ -240,8 +240,8 @@ pre_context_calculation:
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = XDL_MIN(lctx, (long) xe->xdf1.record.length - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, (long) xe->xdf2.record.length - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -249,13 +249,13 @@ pre_context_calculation:
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
-						 xe->xdf1.nrec);
+						 xe->xdf1.record.length);
 			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
-				fe1 = xe->xdf1.nrec;
+				fe1 = xe->xdf1.record.length;
 			if (fe1 > e1) {
-				e2 = XDL_MIN(e2 + (fe1 - e1), xe->xdf2.nrec);
+				e2 = XDL_MIN(e2 + (fe1 - e1), (long) xe->xdf2.record.length);
 				e1 = fe1;
 			}
 
@@ -266,7 +266,7 @@ pre_context_calculation:
 			 */
 			if (xche->next) {
 				long l = XDL_MIN(xche->next->i1,
-						 xe->xdf1.nrec - 1);
+						 (long) xe->xdf1.record.length - 1);
 				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6fa6ea61a2..f48549605d 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -158,11 +158,11 @@ static int is_eol_crlf(xdfile_t *file, int i)
 {
 	long size;
 
-	if (i < file->nrec - 1)
+	if (i < (isize) file->record.length - 1)
 		/* All lines before the last *must* end in LF */
 		return (size = file->recs[i]->size) > 1 &&
 			file->recs[i]->ptr[size - 2] == '\r';
-	if (!file->nrec)
+	if (!file->record.length)
 		/* Cannot determine eol style from empty file */
 		return -1;
 	if ((size = file->recs[i]->size) &&
@@ -317,7 +317,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			continue;
 		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
+	size += xdl_recs_copy(xe1, i, (int) xe1->xdf2.record.length - i, 0, 0,
 			      dest ? dest + size : NULL);
 	return size;
 }
@@ -622,7 +622,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 			changes = c;
 		i0 = xscr1->i1;
 		i1 = xscr1->i2;
-		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		i2 = xscr1->i1 + xe2->xdf2.record.length - xe2->xdf1.record.length;
 		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
@@ -637,7 +637,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		if (!changes)
 			changes = c;
 		i0 = xscr2->i1;
-		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
+		i1 = xscr2->i1 + xe1->xdf2.record.length - xe1->xdf1.record.length;
 		i2 = xscr2->i2;
 		chg0 = xscr2->chg1;
 		chg1 = xscr2->chg1;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 986a3a3f74..e1ce9a399f 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -370,5 +370,5 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
+	return patience_diff(xpp, env, 1, env->xdf1.record.length, 1, env->xdf2.record.length);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3b33186c15..9b46523afe 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -138,7 +138,7 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 }
 
 
-static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
+static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	long bsize;
 	unsigned long hav;
@@ -148,7 +148,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
-	xdf->nrec = 0;
 	IVEC_INIT(xdf->record);
 
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
@@ -164,7 +163,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	}
 	ivec_shrink_to_fit(&xdf->record);
 
-	xdf->nrec = (long) xdf->record.length;
 	if (!XDL_ALLOC_ARRAY(xdf->recs, xdf->record.length))
 		goto abort;
 	for (usize i = 0; i < xdf->record.length; i++) {
@@ -173,21 +171,21 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		xdf->recs[i] = &xdf->record.ptr[i];
 	}
 
-	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->record.length + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->record.length + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->record.length + 1))
 			goto abort;
 	}
 
 	xdf->rchg += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
-	xdf->dend = xdf->nrec - 1;
+	xdf->dend = xdf->record.length - 1;
 
 	return 0;
 
@@ -274,12 +272,12 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	char *dis, *dis1, *dis2;
 	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 
-	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(dis, xdf1->record.length + xdf2->record.length + 2))
 		return -1;
 	dis1 = dis;
-	dis2 = dis1 + xdf1->nrec + 1;
+	dis2 = dis1 + xdf1->record.length + 1;
 
-	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt(xdf1->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
@@ -287,7 +285,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
-	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt(xdf2->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
@@ -334,21 +332,21 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
-	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	for (i = 0, lim = XDL_MIN(xdf1->record.length, xdf2->record.length); i < lim;
 	     i++, recs1++, recs2++)
 		if ((*recs1)->ha != (*recs2)->ha)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
 
-	recs1 = xdf1->recs + xdf1->nrec - 1;
-	recs2 = xdf2->recs + xdf2->nrec - 1;
+	recs1 = xdf1->recs + xdf1->record.length - 1;
+	recs2 = xdf2->recs + xdf2->record.length - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
 		if ((*recs1)->ha != (*recs2)->ha)
 			break;
 
-	xdf1->dend = xdf1->nrec - i - 1;
-	xdf2->dend = xdf2->nrec - i - 1;
+	xdf1->dend = xdf1->record.length - i - 1;
+	xdf2->dend = xdf2->record.length - i - 1;
 
 	return 0;
 }
@@ -388,12 +386,12 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
 		return -1;
 
-	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+	if (xdl_prepare_ctx(1, mf1, xpp, &cf, &xe->xdf1) < 0) {
 
 		xdl_free_classifier(&cf);
 		return -1;
 	}
-	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+	if (xdl_prepare_ctx(2, mf2, xpp, &cf, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf1);
 		xdl_free_classifier(&cf);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 5028a70b26..c322e62fbf 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,6 @@ DEFINE_IVEC_TYPE(xrecord_t, xrecord);
 
 typedef struct s_xdfile {
 	struct ivec_xrecord record;
-	long nrec;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget


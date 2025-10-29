Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB131B82C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776403; cv=none; b=ed1y7OGa4wVkdaYglyPGhGtJy736dzwZHzH3lSTkPwbz7EMo1ABOCFHLgSmls5AGr9Tfsf+/k/lKS79gxhSR6dM+jBBBw4CZAZ188/GMzEPwbyVVPKR8P7IMlh9mbOgiBU+q7euxsprmACFdmajDYhwgNSa51a4Fdx+grZDAXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776403; c=relaxed/simple;
	bh=UHUVIrxocjT/6TyU1qtZEDst29cael90rFJ+Jcta0yI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CBjOIyzTlQkMgB3VNbL9uYb9mffrJG4r66j/Wy4q03pAmp8CEBTxh9wPyMM1kjphk8XoLwlhrG0jOxUH+PMHmUS1sLfMllSlES40Rw7eC9frj8HLovyOY+16q4X/b63D9Rg69jfNI815ZOIOqc/KY6G91MQBKi9UkFCkQsjZNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCFrxuYm; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCFrxuYm"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-945a5731dd3so15630439f.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776400; x=1762381200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI9RskYJJY60s6SaiwkO7wvj55lgd+vcaxtzp/UQW5o=;
        b=gCFrxuYmL7P5VtyqmWFDdO5d/sghhHG3KvtwC80UCjNRoCw22W/w6Ro+U1mso1uV2e
         T4sBEHl9db6q+znvAdnv/17MmU2xf4ukxajFYvpI6xa5zvCUD1vrM0KAqxlcC2H/Fl/o
         dpxTLNLE5rGV/ldoFPJMUBcIgXz7B9c98rKmjGAYiuaB/Rpzm0gfBDJGpC+ChXbO66sU
         ffOazKxr90eB3PFJLwOQA/pCI8JpYSq+QaMPPzQW5+SqgAnYjZAZL56YewTWbHM1mhZw
         VjloP2JJJ5XAQ4OR5aLfTnyU25iystSh56ex36l5ppiaoJbOBOAiP15431osV9YPa5Bh
         kBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776400; x=1762381200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI9RskYJJY60s6SaiwkO7wvj55lgd+vcaxtzp/UQW5o=;
        b=oPPJgbsa0019LdziSBT7/F3lVvAx7MG1qsh5U1rbfMUAFG5pdJm0tFRbsu1OPuwNks
         Z5Rfqk1k5WLEch7KIy6OBrrKz0eF2JDd3e+3Soid1hqP/dzUJ4Gq8Kg5DqQjdjIWwB8Z
         aYRlowWNGtpdN9kOHIMo9n+Gj2GtpeGC2gAGy+5D0ApUL8rl08CTuCLetoxZTakRBwdi
         bG8/28IoieXuAmjSvEt6Wygn+GwIG2oafH69qS4jqicIhoHaJu8YE1Tf5UcBD8eWrp6E
         RRVeS6QckDuxCsnEqGL96pn7QBa6J9tNyGG8hgOLYnlRUYBSRjOzIBglkgYh+a6z1jDH
         8G0A==
X-Gm-Message-State: AOJu0YyPxgYXtylbs9g8FDAjPRoRh7kBkovs0t4bcEbe17js2cn6poyL
	UVNEfaK9dApzKCftnsqOjNe1+C8Z/wTmOZG84IC9BnbCxR6/jHgmWWZzegiWNw==
X-Gm-Gg: ASbGncuKa+bsXmnmqcwKd+OjG1QChQMfbOYXXRXddLvEQcZn83CmQccXp4iV/TMBpj1
	1v54NqDTSamd419lYaypxWhtHijt3k4gGGkuV8PrK5D9mu5qZZKo679gCwPm8Sf2la+Q7abx95T
	oCQLkADIFPdrNCnsB7goWu2/qivveL0PKFFOEYIy1IRkCc6zP9H8iwYsUwM6aMSCpybBg7ztarh
	vwFTvPB3t4hDwNNn5qvht0WLuWxEXKodjPTPPYRl9U5UwJK5BYs3urpn59hK8jgzkLgqChpZeRW
	rDvD2IPPcwUWZe3lSQ/oCQC/7YzHk0IgQjzrVoO78MXunsMwZWY01QK1GX4KvJOU/ULecqzEcBr
	pSSBlicN8A9ETkCoH6S71lRx35dDvaDcXlceh/cAuZCDOXVXhOkDwLWfQTZ2sBiDFcu/Ht1hoOw
	5deA==
X-Google-Smtp-Source: AGHT+IFaYJIFJGgM6O5/hGeaycJC44S2HLzfvmGL6eYJoCzS9ApBzk8xXuRycSgYXHzGaCidESiXww==
X-Received: by 2002:a05:6602:1606:b0:945:ab4c:4eb7 with SMTP id ca18e2360f4ac-945c9886082mr700722739f.19.1761776399977;
        Wed, 29 Oct 2025 15:19:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea72e668asm6080028173.13.2025.10.29.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:59 -0700 (PDT)
Message-Id: <f91be17858ab39292ab6667636d9573da937d248.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:45 +0000
Subject: [PATCH v2 07/10] xdiff: make xdfile_t.nrec a size_t instead of long
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nrec describes the number of elements in memory
for recs, and the number of elements in memory for 'changed' + 2.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     | 20 ++++++++++----------
 xdiff/xmerge.c    |  8 ++++----
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  | 12 ++++++------
 xdiff/xtypes.h    |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 436c34697d..759193fe5d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -483,7 +483,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 {
 	long i;
 
-	if (split >= xdf->nrec) {
+	if (split >= (long)xdf->nrec) {
 		m->end_of_file = 1;
 		m->indent = -1;
 	} else {
@@ -506,7 +506,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 
 	m->post_blank = 0;
 	m->post_indent = -1;
-	for (i = split + 1; i < xdf->nrec; i++) {
+	for (i = split + 1; i < (long)xdf->nrec; i++) {
 		m->post_indent = get_indent(&xdf->recs[i]);
 		if (m->post_indent != -1)
 			break;
@@ -717,7 +717,7 @@ static void group_init(xdfile_t *xdf, struct xdlgroup *g)
  */
 static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end == xdf->nrec)
+	if (g->end == (long)xdf->nrec)
 		return -1;
 
 	g->start = g->end + 1;
@@ -750,7 +750,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
  */
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end < xdf->nrec &&
+	if (g->end < (long)xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
 		xdf->changed[g->start++] = false;
 		xdf->changed[g->end++] = true;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 2f8007753c..04f7e9193b 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -137,7 +137,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (l = start; l != limit && 0 <= l && l < (long)xe->xdf1.nrec; l += step) {
 		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
@@ -179,14 +179,14 @@ pre_context_calculation:
 			long fs1, i1 = xch->i1;
 
 			/* Appended chunk? */
-			if (i1 >= xe->xdf1.nrec) {
+			if (i1 >= (long)xe->xdf1.nrec) {
 				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
 				 * a whole function was added.
 				 */
-				while (i2 < xe->xdf2.nrec) {
+				while (i2 < (long)xe->xdf2.nrec) {
 					if (is_func_rec(&xe->xdf2, xecfg, i2))
 						goto post_context_calculation;
 					i2++;
@@ -196,7 +196,7 @@ pre_context_calculation:
 				 * Otherwise get more context from the
 				 * pre-image.
 				 */
-				i1 = xe->xdf1.nrec - 1;
+				i1 = (long)xe->xdf1.nrec - 1;
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
@@ -228,8 +228,8 @@ pre_context_calculation:
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = XDL_MIN(lctx, (long)xe->xdf1.nrec - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, (long)xe->xdf2.nrec - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -237,13 +237,13 @@ pre_context_calculation:
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
-						 xe->xdf1.nrec);
+						 (long)xe->xdf1.nrec);
 			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
-				fe1 = xe->xdf1.nrec;
+				fe1 = (long)xe->xdf1.nrec;
 			if (fe1 > e1) {
-				e2 = XDL_MIN(e2 + (fe1 - e1), xe->xdf2.nrec);
+				e2 = XDL_MIN(e2 + (fe1 - e1), (long)xe->xdf2.nrec);
 				e1 = fe1;
 			}
 
@@ -254,7 +254,7 @@ pre_context_calculation:
 			 */
 			if (xche->next) {
 				long l = XDL_MIN(xche->next->i1,
-						 xe->xdf1.nrec - 1);
+						 (long)xe->xdf1.nrec - 1);
 				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 0dd4558a32..29dad98c49 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -158,7 +158,7 @@ static int is_eol_crlf(xdfile_t *file, int i)
 {
 	size_t size;
 
-	if (i < file->nrec - 1)
+	if (i < (long)file->nrec - 1)
 		/* All lines before the last *must* end in LF */
 		return (size = file->recs[i].size) > 1 &&
 			file->recs[i].ptr[size - 2] == '\r';
@@ -317,7 +317,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			continue;
 		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
+	size += xdl_recs_copy(xe1, i, (int)xe1->xdf2.nrec - i, 0, 0,
 			      dest ? dest + size : NULL);
 	return size;
 }
@@ -622,7 +622,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 			changes = c;
 		i0 = xscr1->i1;
 		i1 = xscr1->i2;
-		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		i2 = xscr1->i1 + (long)xe2->xdf2.nrec - (long)xe2->xdf1.nrec;
 		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
@@ -637,7 +637,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		if (!changes)
 			changes = c;
 		i0 = xscr2->i1;
-		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
+		i1 = xscr2->i1 + (long)xe1->xdf2.nrec - (long)xe1->xdf1.nrec;
 		i2 = xscr2->i2;
 		chg0 = xscr2->chg1;
 		chg1 = xscr2->chg1;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index cc53266f3b..a0b31eb5d8 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -370,5 +370,5 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
+	return patience_diff(xpp, env, 1, (int)env->xdf1.nrec, 1, (int)env->xdf2.nrec);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 16236bd045..4ee9fb60cd 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -153,7 +153,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, (long)xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
@@ -287,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
@@ -295,7 +295,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
@@ -348,7 +348,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
-	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	for (i = 0, lim = (long)XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
@@ -361,8 +361,8 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
-	xdf1->dend = xdf1->nrec - i - 1;
-	xdf2->dend = xdf2->nrec - i - 1;
+	xdf1->dend = (long)xdf1->nrec - i - 1;
+	xdf2->dend = (long)xdf2->nrec - i - 1;
 
 	return 0;
 }
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 742b81bf3b..17cafd8b6e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,7 +47,7 @@ typedef struct s_xrecord {
 
 typedef struct s_xdfile {
 	xrecord_t *recs;
-	long nrec;
+	size_t nrec;
 	bool *changed;
 	long *rindex;
 	long nreff;
-- 
gitgitgadget


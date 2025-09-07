Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968929E0F6
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274335; cv=none; b=JshdreUXdrag6swH9J+jyrIIUeBKTAGW6gO5xPdmXkrTgvKbEj3cPOe0xidgoNHviDuI4xgdZIySY17knJQxwSSjjg0UzunOSAJ6cG89zA5lM2Gl2a6Mf9QpIiBz1XkkxVloTEFf3ILFGmSK3bwK+F8FPZD6uWe6+FaByFERc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274335; c=relaxed/simple;
	bh=HdaJ3b/IKLLaTNtIppKoOp+F0XltCkjeGTUBLcdVuA8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I4wKFDwTJcBwqrxJiA8Q05bNFKagCKXDXB99Quy8CYsJBZG7W7WnCAWTVYuxNSlePsZQvxjL20LQO/aJPPf5CmwrALXkw68zc+jX7CrlWAEijrSlan9x/otbmEGmdKP7TpE9CzHaPnRFGL61FXQhlLOF+UtRWRGIrnC/7uHTf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq0bOUgD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq0bOUgD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-72374d6a6caso42652386d6.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274332; x=1757879132; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaFxJumcKx/Oc0XqgxT9FwRSiPymZgO3vBuTpOqZ7XE=;
        b=Wq0bOUgDuCj4CfF6MlAEvz4zOTppfRIduPTz7QAxxUWtMfI2afreisFvAXkfG6TsB5
         6um2yMffSoaRHFPj4B2jIcvjmzjp32S73eoyvbpWlHwLnJmCuBNUYGWfI+7ydHLhsuyN
         iUR729n7qKTy0eWDklXSKfzi++1aviSMQbJVe5lDtwNXWqSSPqNxv9SWVoUgV0QfBvac
         UgNCXsLELxRnPVrejf0zdHlrLGfDnNP6wl7UtVRomNJsnlSa6kldlAwjsjZeX5RJMDqk
         ZUNABTLMxRilwRUTSG6WyGk5ccW7mNqVaK1/y8ovruolnyfBLO5KQ/sKlXzcYS1q6IRG
         b+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274332; x=1757879132;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaFxJumcKx/Oc0XqgxT9FwRSiPymZgO3vBuTpOqZ7XE=;
        b=c9kPOeR/6HTOdfpdJ2lmWbuoqLbL5B2K5Ge1uXoB6bNw1cAxspoVpN/ICvMQM2HspL
         U+vMLzTRxwtSEZbfzwAf+LRWrijGa6VIAE5JjiaD4vI30N7bvU8q06uz5pevQrv19HBp
         wEhl0bPaPBj4lmCj8e29oBdZMN25n/Cii6q0Bo6x8au3AlHXykJ/7WBWn50XtRRxc9R9
         Rjk+6eZ1fX3bEWxxXV1x1P1HojyOu1zIw062+UUUj6rVYn86RjaUlTqrylOCAd6kUOqD
         JVnOimvYv0myo7+TpOJ1GCFGdTLf6zNeM2M4PrNgoSL21KlFFhK/4xcs4fv0BU3MPhI8
         AJ5w==
X-Gm-Message-State: AOJu0YyhFgTTF14Y9J0TsbrPDSrlODMRRhmLw1JSQwFep5NmhbiCOxKl
	vnCmEEoAx0Ejvu2zUYM64gkGHCoeXTifpXyP2IHnYNRjnpz3CMF9A39c0FZFl4yc
X-Gm-Gg: ASbGncuoyuqSGmqU4WRMXALrgG5dcoWzp+NG3z+0KBtnRyfxwb/m+Kk0Cyf7NEv8zAW
	aztOYHSP3/JMNX0NFCYL3YVUymDexJpt9V4542Y+MjBsCnP1VCloZ0SvRs/olaCRLtfutd6GKwa
	3h8R6NhwEIu6ouJySDRojvKGk38A/Q1izZ6pyabUA/JafPszf6DZ4CcRzQw/IbBWKCio29CNg0e
	LMeuf2RfMZ/RQFrwIGYZW81TGY9f84/WR6nLVpBNeC/LROrZHaT/a+jwp8bHpwD3B/vcYlGtJL0
	+qRTJ+44ZAob9avmZb1hfKovZW580NrfQcmuMgOPlonaTGIJxvJj0B4se821f0Z9e4ZKldLNPBo
	HdWnIGp4Qk2Cmrs1JLK05nIQ0jIME37ThxLmt8ZBiBVUp
X-Google-Smtp-Source: AGHT+IFKUGr7YeHYU8mzjf60rmqWiqBfIgoOIXWe15rQzDZnSarqh0QYVmv3Uell3oT53fhMUDZz9g==
X-Received: by 2002:ad4:4e0c:0:b0:73a:e51d:1834 with SMTP id 6a1803df08f44-73ae51d18edmr37332796d6.9.1757274332347;
        Sun, 07 Sep 2025 12:45:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73a16bb3ff5sm35785266d6.1.2025.09.07.12.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:31 -0700 (PDT)
Message-Id: <d1657f51012c8ee97f81bf5e3550aa47a0c5b70c.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:12 +0000
Subject: [PATCH 09/17] xdiff: treat xdfile_t.rchg like an enum
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

Define macros NO(0), YES(1), MAYBE(2) as the enum values for rchg to
make the code easier to follow. Perhaps 'rchg' should be renamed to
'changed'?

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiff.h      |  4 ++++
 xdiff/xdiffi.c     | 29 ++++++++++++++---------------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 24 ++++++++++++------------
 5 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2cecde5afe..7092879829 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -27,6 +27,10 @@
 extern "C" {
 #endif /* #ifdef __cplusplus */
 
+#define NO 0
+#define YES 1
+#define MAYBE 2
+
 /* xpparm_t.flags */
 #define XDF_NEED_MINIMAL (1 << 0)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a66125d44a..44fd27823a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = 1;
+			xdf2->rchg[xdf2->rindex[off2]] = YES;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = 1;
+			xdf1->rchg[xdf1->rindex[off1]] = YES;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -708,7 +708,7 @@ struct xdlgroup {
 static void group_init(xdfile_t *xdf, struct xdlgroup *g)
 {
 	g->start = g->end = 0;
-	while (xdf->rchg[g->end])
+	while (xdf->rchg[g->end] == YES)
 		g->end++;
 }
 
@@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->start = g->end + 1;
-	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
+	for (g->end = g->start; xdf->rchg[g->end] == YES; g->end++)
 		;
 
 	return 0;
@@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->end = g->start - 1;
-	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
+	for (g->start = g->end; xdf->rchg[g->start - 1] == YES; g->start--)
 		;
 
 	return 0;
@@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->rchg[g->start++] = 0;
-		xdf->rchg[g->end++] = 1;
+		xdf->rchg[g->start++] = NO;
+		xdf->rchg[g->end++] = YES;
 
-		while (xdf->rchg[g->end])
+		while (xdf->rchg[g->end] == YES)
 			g->end++;
 
 		return 0;
@@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = 1;
-		xdf->rchg[--g->end] = 0;
+		xdf->rchg[--g->start] = YES;
+		xdf->rchg[--g->end] = NO;
 
-		while (xdf->rchg[g->start - 1])
+		while (xdf->rchg[g->start - 1] == YES)
 			g->start--;
 
 		return 0;
@@ -932,16 +932,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	xdchange_t *cscr = NULL, *xch;
-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
 	long i1, i2, l1, l2;
 
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
-			for (l1 = i1; rchg1[i1 - 1]; i1--);
-			for (l2 = i2; rchg2[i2 - 1]; i2--);
+		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
+			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
+			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 4d857e8ae2..c2e85b8ab9 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = 1;
+				env->xdf1.rchg[line1++ - 1] = YES;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = 1;
+				env->xdf2.rchg[line2++ - 1] = YES;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bf69a58527..20cda5e258 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.rchg[line1++ - 1] = YES;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.rchg[line2++ - 1] = YES;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 92f9845003..36437f91bb 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -215,9 +215,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	 * current line (i) is already a multimatch line.
 	 */
 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
-		if (!dis[i - r])
+		if (dis[i - r] == NO)
 			rdis0++;
-		else if (dis[i - r] == 2)
+		else if (dis[i - r] == MAYBE)
 			rpdis0++;
 		else
 			break;
@@ -231,9 +231,9 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	if (rdis0 == 0)
 		return 0;
 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
-		if (!dis[i + r])
+		if (dis[i + r] == NO)
 			rdis1++;
-		else if (dis[i + r] == 2)
+		else if (dis[i + r] == MAYBE)
 			rpdis1++;
 		else
 			break;
@@ -273,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
-		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis1[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
@@ -281,26 +281,26 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
-		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
+		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
 
 	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
-		if (dis1[i] == 1 ||
-		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
+		if (dis1[i] == YES ||
+		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = 1;
+			xdf1->rchg[i] = YES;
 	}
 	xdf1->nreff = nreff;
 
 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
-		if (dis2[i] == 1 ||
-		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
+		if (dis2[i] == YES ||
+		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = 1;
+			xdf2->rchg[i] = YES;
 	}
 	xdf2->nreff = nreff;
 
-- 
gitgitgadget


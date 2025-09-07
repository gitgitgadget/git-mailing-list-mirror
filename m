Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6832BE036
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274343; cv=none; b=m9x73O2rhZPJ5ImYeFnHYb+Tqm+PZDpjfWy8ZR+2l5WOn/0mj6iLLkwWPt8OH+Ewlo05XQoQU5k9yZmAt974hvdg66xZ1GUTow2pRASS6TTngcun2shdZxxDAucRMqnvUNyA23qUEc9Nmnk7/vKSs4/iG/G5+ScZ1AL5L6zW/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274343; c=relaxed/simple;
	bh=fwCikxlC88F+v2wv8l8MF43e8/e+W/GQDGpVeCHJwKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bNAzdMY6oklAnuhQ6YFiwYUd7BekG0qFebUaX5IXoLRcT8J1GGtXN+Vcxz9aoYQSGlns58S7mPqDOLyrEonKZF0cAB/Mx0jvPeofg09PsUbUEBe0iT9wufiMWUQwHNARdVh5aFRplMMTEKOqW1qqUPHsnQqlWt95inOlg6Gd4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJUlm6F/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJUlm6F/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so24177431cf.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274340; x=1757879140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vQ6N/4xUSHWlZjED2vnN9tEtheCZzYEzdNn0QXNtb8=;
        b=KJUlm6F/nmyhbWjh7gaxdkE/ffHfCaGludfg0lThxSB5ikSyrOFTN9vP69hjSW9C9t
         wyV51RBmlYh1Huvik/srHlgIbBuZH8YUehS9rSFzKjOZQQDwbctYS2/9Pc3dqptrIwxo
         giKMD+s85Y8xdXT+RDaJKwq6AlfKJXihirRxzc4IpYRBtoU13RcPtpsc6Gq5s+kHpsMV
         D0wmPcO3sSi05cpJ1ES7vhdwgUSc76zEPqazVA9b2F27PrBIHXBzacThgNXKD/zEbdiD
         NhCMJAP5pAyntHWUciQOjHn8Xy5U4kkiUCxZWSpAI359YLUTJ3CA6mewKHrfq3lqumDZ
         5xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274340; x=1757879140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vQ6N/4xUSHWlZjED2vnN9tEtheCZzYEzdNn0QXNtb8=;
        b=Ul+IlNkKBgrFYvyV8jL/PGRIoc0nxkKh6azLKqf1mGayju7ivYEJLRZMR0mPo4LAcd
         PWDuP3Pls83YeNy5CMoigbpfy+reYHFZ0inM/VKRIRF3XzzDrqN7Fnt7rGbfADQmA+2I
         LXT0unwCzC4IUOjpx8faLa/KwYreYVVyQ78w9h4cPOx73g/vneyPzlvC75p9O1bhPbjw
         J+kD5WZOCkQEZeIzDfQmm48TVeTwC4DSGT6sB7snQOmCz/HJIX6JqjrgCycAfN8iwaAK
         ZC84u3jrbpDQVAjtMDcuM9WQJrt4YUX+72EFq/HKAAIjaiwXbWuYk/g7Mh9bdHZMqAwR
         +kpA==
X-Gm-Message-State: AOJu0YxwiLJsqnnImQu6lEhrSaLSlqFyHhP9cll3BTGwYQhPxQygqEeL
	IJZhDNevRIlo39Vm2QuaMhxRGJquLrmJoRsLNXXhc0AJyCyRy1rey/15RfAOqHpY
X-Gm-Gg: ASbGncu8bJe66IPE1/P7IeA8wP0GIpTziLddog2vN9/gdb0ywN/ey/ib+dhp4ZL9PDu
	rJKPmsB89GPIrBVlf3J9t0owow3e0eeXwTUWozfCFxTeWDBhZk9zXh/yGXxc1jmkN5E/qFU5OEi
	4ooH/wEUMhFSIwzQ+ejHeze5a8Aa5hgt2qASExQapF9/Me0q4gz6xqkhLh3c2Yx8fiEEAtWKMWe
	+nv/6phYPSF29RmlDKKOc0p2xDprmTqHGBUddZShAwq/RTAY9+XRnNqooMpHMLH/NirWjjBTGCL
	JGT0FY+O+VqyTlaLguYH8P0DarzaZuDHXxbVeXs++D9WLLptnQz8fmSQtCzElJEaT7E9p/qr9wH
	hVH+suQ4NIuy5p9pHIbX6njY=
X-Google-Smtp-Source: AGHT+IFyYZ1EADt8gJE4D4aM63foMHUCZOuPyyzIqcrK31BnVGE+5tk2OPl1vdUxjdyCIhvTCC8KGg==
X-Received: by 2002:a05:622a:1a19:b0:4b3:b34:9395 with SMTP id d75a77b69052e-4b5f846e130mr45592161cf.65.1757274339979;
        Sun, 07 Sep 2025 12:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aab5a062fsm911301585a.48.2025.09.07.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:39 -0700 (PDT)
Message-Id: <0a180f69ff3cd4ac9efdee9546613df883cba9fe.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:18 +0000
Subject: [PATCH 15/17] xdiff: make xdfile_t.nrec a usize instead of long
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  8 ++++----
 xdiff/xemit.c    | 14 +++++++-------
 xdiff/xmerge.c   |  4 ++--
 xdiff/xprepare.c |  6 +++---
 xdiff/xtypes.h   |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index c8d351705c..ee72f5ea3b 100644
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
 		xdf->rchg[g->start++] = NO;
 		xdf->rchg[g->end++] = YES;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad3e859c57..aa63aab749 100644
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
@@ -228,8 +228,8 @@ pre_context_calculation:
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = XDL_MIN(lctx, (long)xe->xdf1.nrec - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, (long)xe->xdf2.nrec - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -243,7 +243,7 @@ pre_context_calculation:
 			if (fe1 < 0)
 				fe1 = xe->xdf1.nrec;
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
index c1a003326a..1ebcbb4e3a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -158,7 +158,7 @@ static int is_eol_crlf(xdfile_t *file, int i)
 {
 	usize size;
 
-	if (i < file->nrec - 1)
+	if (i < (long)file->nrec - 1)
 		/* All lines before the last *must* end in LF */
 		return (size = file->recs[i].size) > 1 &&
 			file->recs[i].ptr[size - 2] == '\r';
@@ -622,7 +622,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 			changes = c;
 		i0 = xscr1->i1;
 		i1 = xscr1->i2;
-		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		i2 = xscr1->i1 + (long)xe2->xdf2.nrec - (long)xe2->xdf1.nrec;
 		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 9ec2a5d078..d990fe1c9e 100644
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
 			crec->ptr = (u8 const *)prev;
@@ -332,8 +332,8 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
-	xdf1->dend = xdf1->nrec - i - 1;
-	xdf2->dend = xdf2->nrec - i - 1;
+	xdf1->dend = (long)xdf1->nrec - i - 1;
+	xdf2->dend = (long)xdf2->nrec - i - 1;
 
 	return 0;
 }
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f2b53a6553..41986c6603 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,7 +47,7 @@ typedef struct s_xrecord {
 
 typedef struct s_xdfile {
 	xrecord_t *recs;
-	long nrec;
+	usize nrec;
 	long dstart, dend;
 	char *rchg;
 	long *rindex;
-- 
gitgitgadget


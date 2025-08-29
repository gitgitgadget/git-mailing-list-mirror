Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18424A06B
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496557; cv=none; b=ZVGUIir+4G45bio21fjVKaelZIF/RYnqAPvFF6Sb2pmBN8AyT+DJngjl8QmvFwHa5kuVAA5EBIInozF191Y1lxXmnefBTOGruUKhOD+mTpzIQS9BLy2ksq/nFtMdzbQ8Pec5G8cd6CY/IXEZj4B9bxKDm1XSNAE0cGuCP71z73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496557; c=relaxed/simple;
	bh=rdVl+NMqRaxJBBUQXoMRhF8T8ETpoikCCAzU5wSHSBY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sa5tXG0koSdPkvNImvXoujFvgsfBxJr/DGcagGw+zCDzOaZJl7+XtYZ9OAca48IILySoxEmAosP9a56N9Yp3P1OIFW4VjQXvHJQ5ThUPD0TXNA5wnLOFJO72p2j0cBYrfGmLmvOGuG4DwgclU8QRx9gouZ25bDFswTXcCYCmIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8vYK8ch; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8vYK8ch"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445805aa2eso27204915ad.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496554; x=1757101354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvfHKFQJyR3zxny+G408KXW0UC+oH8iFsudkWO/1/JA=;
        b=O8vYK8chWpvzgk8hKeXgF7Qq4l9m4wicihgvtprk56l2tfWfkfJKpYplwWxNwQW1CG
         GDPKOUgz/DW/vzE7dVfm4nBc1zxrLi6xxUEXWvbBIIgrMVQZLwHlhLf5n3IaXBHgvEDj
         /zTTLWEXZZ9adq6V87Yyk3MiABjecuhG8Ee0Ul/qd5AW2UvkLuhoNV/906MfFw2my9rp
         vGyKZlRsYIZM7lmNSivfO/0Z62ZC5F4jIAU0juz5AQusNVK+es4GmoMjLxYkVsjvL8MY
         FSh1PkZnd663oRTr/ujapxqfRggkChg3bfq+GdU2guk/78hN2hvrqbIlQ6DhkDurpRz2
         /oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496554; x=1757101354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvfHKFQJyR3zxny+G408KXW0UC+oH8iFsudkWO/1/JA=;
        b=dl8AfROr9pxR1Fbti+Z9QpA3vb/v8wgiETLlnbkFxuD1z96OAe+HlzQgofsCmt6Gfb
         judTWEq8h78aeHknbalhpWlWF0hxz15mVURB9boNFqVlEMOjm+DetsObat2xooPdWslv
         b449Osp3mFCJEwnRWwIe+wP/gVMYLrW+iPsjqvuZCs1V6YTDFCD9cTNSTVNAtNnTE+m0
         uXI+KQ3kEVtVMZ+r1qQhqbUtqiT0YoX7KDRsyKTxTM7zpubVb431/bO6uceSlxn06ai0
         yDcXgHp3Yvt1C242OTpqByMBm0O7dE5Tm4H7Jl1jYSFOGV6JdeVWmKpOuY8irZl6CTEK
         +kEg==
X-Gm-Message-State: AOJu0YwChZrah0LacvjVYEf1/GKKNyN/8A2o643kBqAsIfcRqQO1VkmJ
	h7u/pjsBunR3OMbLZBMKofh5TT3L/rjM9VqrsU289hH9QglVIgvG+w2znZn3kA==
X-Gm-Gg: ASbGncvS4WMAe2qM+kWTKDa6btQWmu94qZlKe1rbNbPami+7WnCRMlaTIwlnU+tKIdW
	abaXwWVU5p0dm7uzr59BWNKJe8bN2N+MwJgoaUQma3V/xc6EZYLkkVX7xE3YdwV2vgvmI13nhfo
	x31MhfqFjo9bUBU04WIaQo3azcPnzmHpHCAcb+v7z7RDRrCaz9HJJqCRdQvOll8TqVRR06humFP
	MZy/J4N5q+GjHUMes0ZF+wXtGHhZtl1klZgRPivvQMuMBhXRDw+vh95xS3asd2MbgPIlfp5mZI8
	2BUAtRrWENChWPubpxY9qIYfMBeOBrp9QhrGqIy2BGgMUfTRihkC+5Jilb4sI2MFwiI6vkxflSk
	6Ryo0YqiIoh66XsQd6lVOzrfAZD6v/gV7Q2sAWA==
X-Google-Smtp-Source: AGHT+IGK/lYKjFl4ApjNUaOi7guyBvV9QGKi5BdYhoTkeiICULNseqCdmsPgXCQ5jJG7uALDYyXHZw==
X-Received: by 2002:a17:902:f54e:b0:249:1f6b:3268 with SMTP id d9443c01a7336-2491f6b3935mr37971885ad.18.1756496554050;
        Fri, 29 Aug 2025 12:42:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da26a3sm32887925ad.88.2025.08.29.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:33 -0700 (PDT)
Message-Id: <1096c8f0a400b7dd86d28b740a5d94bdea9bb60d.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:13 +0000
Subject: [PATCH 09/15] xdiff: make fields of xrecord_t Rust friendly
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

A few commits ago, we added definitions for Rust primitive types,
to facilitate interoperability between C and Rust. Switch a
few variables to use these types. Which, for now, will
require adding some casts.

Also change xdlclass_t::ha to be u64 to match xrecord_t::ha, as
pointed out by Johannes.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  2 +-
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  8 ++++----
 xdiff/xtypes.h    |  6 +++---
 xdiff/xutils.c    |  4 ++--
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfb..3b364c61f6 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -418,7 +418,7 @@ static int get_indent(xrecord_t *rec)
 	long i;
 	int ret = 0;
 
-	for (i = 0; i < rec->size; i++) {
+	for (i = 0; i < (long) rec->size; i++) {
 		char c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
@@ -1005,11 +1005,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline((const char*) rec[i]->ptr, rec[i]->size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline((const char*)rec[i]->ptr, rec[i]->size, flags);
 
 		xch->ignore = ignore;
 	}
@@ -1020,7 +1020,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	size_t i;
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
-		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
+		if (!regexec_buf(xpp->ignore_regex[i], (const char*) rec->ptr, rec->size, 1,
 				 &regmatch, 0))
 			return 1;
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 1d40c9cb40..bbf7b7f8c8 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -24,7 +24,7 @@
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
-	*rec = xdf->recs[ri]->ptr;
+	*rec = (char const*) xdf->recs[ri]->ptr;
 
 	return xdf->recs[ri]->size;
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b..6fa6ea61a2 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t **rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
-			rec2[i]->ptr, rec2[i]->size, flags);
+		int result = xdl_recmatch((const char*) rec1[i]->ptr, rec1[i]->size,
+			(const char*) rec2[i]->ptr, rec2[i]->size, flags);
 		if (!result)
 			return -1;
 	}
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch(rec1->ptr, rec1->size,
-			    rec2->ptr, rec2->size, flags);
+	return xdl_recmatch((char const*) rec1->ptr, rec1->size,
+			    (char const*) rec2->ptr, rec2->size, flags);
 }
 
 /*
@@ -383,10 +383,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		 */
 		t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
 		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
-			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.ptr;
+			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - (u8 const*) t1.ptr;
 		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
 		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
-			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
+			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - (u8 const*) t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
 		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
@@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
 static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
-		if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
+		if (line_contains_alnum((char const*) xe->xdf2.recs[i]->ptr,
 				xe->xdf2.recs[i]->size))
 			return 1;
 	return 0;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 77dc411d19..986a3a3f74 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
-	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1]->ptr);
+	map->entries[index].anchor = is_anchor(xpp, (const char*) map->env->xdf1.recs[line - 1]->ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index ad356281f9..00cdf7d8a0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,7 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
+	u64 ha;
 	char const *line;
 	long size;
 	long idx;
@@ -96,12 +96,12 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
+	line = (char const*) rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->ha == rec->ha &&
 				xdl_recmatch(rcrec->line, rcrec->size,
-					rec->ptr, rec->size, cf->flags))
+					(const char*) rec->ptr, rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -159,7 +159,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
-			crec->ptr = prev;
+			crec->ptr = (u8 const*) prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8b8467360e..6e5f67ebf3 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,9 +39,9 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	char const *ptr;
-	long size;
-	unsigned long ha;
+	u8 const* ptr;
+	usize size;
+	u64 ha;
 } xrecord_t;
 
 typedef struct s_xdfile {
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 444a108f87..10e4f20b7c 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -418,10 +418,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 
 	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
 	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
-		diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
+		diff_env->xdf1.recs[line1 + count1 - 2]->size - (u8 const*) subfile1.ptr;
 	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
 	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
-		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
+		diff_env->xdf2.recs[line2 + count2 - 2]->size - (u8 const*) subfile2.ptr;
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
 
-- 
gitgitgadget


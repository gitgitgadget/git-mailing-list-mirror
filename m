Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6E224B0C
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784353; cv=none; b=YAo7wu1kgvfYOEgL1XG3XbV0pwc5Cle5xHByWOxwkJlv10Nsv3+7Pz5pxKRRa6UPm5iEdERs1p6fv/yYzMMzSxuCE3/onHDG3z3sZouo14Rhc1XZ9OmpaEtyJpnt+m48TJPxDpxGddX+zqM8q1vRHJ/60OSGn4tNmdvpwM4WRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784353; c=relaxed/simple;
	bh=h/w6Q9Oe+zY1Dq+2pfe5JkdiqDPGv3EpWn2QuRZG9JY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D9lc/qFTVZjtD87PhLXVWkEsOOkJllstnuvnmMzDqlyHvC5N3Hce/bdsbEzFQJbbBYAwcjkE5Fdg72kEz8zohjLpxxoOXYxbrScu/J8JEIT4e6RqbpSTnFcWxvqY754y0CbT1LzfnzSXmyH9+aENHWN6Uo3iAWtiUjPF2ZHdWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vah4KJmw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vah4KJmw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso1209595f8f.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784350; x=1753389150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dXak3P+3rWUB/7wjec115ICwbPLOPpMmxOTpkUuVq0=;
        b=Vah4KJmwHY0zPIhETtxXfI1HF9QRDhFWNnvuPHWwnqFShjiofsi9rSH1O3+xsC+UFS
         3G8MyGrfbtQd1D9F+Pn5Af7dxVF76cLOXfgE/9oLJ0f5VOiq3Ppl5QxTDqVGyecq5RTH
         Saa7ON/Cl2q7rT/8NVn3FGNg+jAq8ZkaEjbFy933kCkefygS7/SmFp1R7X2D6p5TgjHA
         DWAVXrl3NN1xkUXsScV5KCs/vjZDbwcIF+ubcBY7YBAkowGugbLk8yxlSbT3KuPxyZt5
         neFngzNFeMNQ3PgwDxeeWLaNaTdMNmPviT4MyWs3Grq8PK47n9NWJAyOBcVF++X6XGut
         E4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784350; x=1753389150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dXak3P+3rWUB/7wjec115ICwbPLOPpMmxOTpkUuVq0=;
        b=eELOSer5Mdpu2HXYoxiwe41joa4qYObJLMeeb4Y1AaEQwsbfUDa5ZLUH9dWFW+gVlo
         2lQ3y+kTpk83utNcaaJl2uv5Z53kkqPHoy+tO5LlLiNl16v1jy1c7YylRJfaIaweRNhI
         X4D3CRLrMFVZ26IxMGn0drP9lxKMCBf24+VXNURnAgxxbBJAc8Q5g/YZUCdE1Dw2mG1W
         acDbA0q/iqUpJKj/QLsjQHyZbNxAFJNf32YRQzUHLc7eHn2hdE5kO0lEZlPZuNA+EkQb
         WtH0u0qitQHqrX87+P8oL9ECvX914rc2v1VpcwdRL6cDYdXnzf91fCrFpmGyn268ZvFx
         bcpw==
X-Gm-Message-State: AOJu0YyOCHXRgQ7QDzCeMna97qG+Kf/j5nFLkJKlS35LnZJQjRjVXIHc
	8APdzjm+A7SH/2KuwWirx92cY7CBypxygh8Ixys5QucmtaR5v3csDSxivyH9tA==
X-Gm-Gg: ASbGncuSQ9lwV+ivvpfbW03a+8kvOGH8pQq5WeGSHbpynuTA2WjbVUMiRzDQj/wj+C4
	Gov3+jU44otGBsrdA6Rrg85ONIcpsxpvyuPCtX0kFIDAguN7lJhPe6iyFz3QwNp1VtVZRNwYusG
	RkSE8UsrVgLW/XpbJG2NN6+i/m1gV8ApCE+x4LIkj1W5FLTBHHhUmAh0fskBNklYddnfnbIYzQd
	DANvgmNIu0oBa5BhaUJ0V8D4f0azx2c9VQ8NO9O4H5ncCnzGPEFx31jlg93VfYL6M6cHJCRdr+w
	2WxJxEdTyxsoqjqC0LP9S+79pNx2QPnsOO1oo9eha2jBsQBwPuM6QIRG/S9ZrR/upQIyUQQt2ia
	GTHJHtoX9rTqIJqeSsmA+CZA=
X-Google-Smtp-Source: AGHT+IG7kOPyw4bLzDgIFmBpJ4uhQqaRkmurSVejbSfkcnpm6yHLjao8cl6hJl3HNFdy91n3FQFM3Q==
X-Received: by 2002:a05:6000:24c5:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3b60dd73204mr7168073f8f.27.1752784349781;
        Thu, 17 Jul 2025 13:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d5f5sm21750120f8f.56.2025.07.17.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:29 -0700 (PDT)
Message-Id: <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:21 +0000
Subject: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

A few commits ago, we added definitions for Rust primitive types,
to facilitate interoperability between C and Rust. Switch a
few variables to use these types. Which, for now, will
require adding some casts.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  2 +-
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xtypes.h    |  6 +++---
 xdiff/xutils.c    |  4 ++--
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfbea..3b364c61f671 100644
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
index 1d40c9cb4076..bbf7b7f8c862 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -24,7 +24,7 @@
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
-	*rec = xdf->recs[ri]->ptr;
+	*rec = (char const*) xdf->recs[ri]->ptr;
 
 	return xdf->recs[ri]->size;
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b36..6fa6ea61a208 100644
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
index 77dc411d1937..986a3a3f749a 100644
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
index ad356281f939..747268e4fdf7 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
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
index 8b8467360ecf..6e5f67ebf380 100644
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
index 444a108f87c0..10e4f20b7c31 100644
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


Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7962FBDE4
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159828; cv=none; b=da9E3C2TDMSJUpqU0QL76R8xzNI2deN/ntlKcHHZ6fLSk+wn1IdxzvU6eTEbxSOlzTA+bl6Ww2SjX6LSBfaPndzin2hF1rSsEbhRtfI/WvRPHV0FCtEP7NA1x7QBtfWVtZWMkzbRVEU2Haz4s9oZDMGCG+QPNug4bZ3Zuuw/TrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159828; c=relaxed/simple;
	bh=fvxzW7rowj+MZhOn4tKmpaUZpUQgnsrq293uMeDiRLQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W/38FaqXhagqJEEXkcZGpL5yZE9HcRhTAWy58POQprFHT28XEUW+PVggNSvvakzCD5UMJjPwLB/aS1db1uspRiq7BVmwBZdjNEHwLlKRQxeF+JmCR+MtxLxmzDKY3qpxOgSvwVwYt1+6HAZBDTzjXKkZomazqxENGz2EYTMQbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUgPWOSx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUgPWOSx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e982506fso28685835ad.2
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159822; x=1763764622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjnhHpF5AFOHU5lp/fKeNgZbSZi4hqRA76KAtkYNKwc=;
        b=XUgPWOSx41uVvvnjuCKnRWHJBfbPblfXgJ+UIFyxIj+sL6kHYFMVHsFJv7zUeSX7pP
         d5T1pYyJQWLGjvXrg5BR5k1yhmoGwnPz7FaaCOu2x+ODSdTOX5ShNmj2t5Fza93IB0Q3
         ggWq9eyg7G6LPR+0s/KTqgcV6jCk534rDkC4jNQL0jZBitpaIt66uIqWDBmdk7eAu/K5
         TKn1k26XgU8F75P3Cx7c3txL9VHaQvqsos3asI6pOLkYhYMDFIOpa4aukQkdbsYGwF+R
         xUc09pg44MHK9sWiLxuuuAukLmAwpmhKCa86zhNghotX832b88RHQcSeyKwgyuRYonv4
         KQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159822; x=1763764622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjnhHpF5AFOHU5lp/fKeNgZbSZi4hqRA76KAtkYNKwc=;
        b=gOHmFeuKupymuuQ6fnxJrnPk7Z4kZi6j/rYe4L8u2CQA2BLev9xEU8YkYsvu+kUc3o
         QFNg3V0zHssm+5q9U1z91vVAW2E1cgNkGEwVdS1zSWllTedVKNktWCDSWTK45okeLiLB
         7kCIPxBe1rgw1ruQkZPbiG+mMrZWWq6sNWcwyMwcwBiSkkMkncamc80vuI4rOUGyD0Dh
         a11OaAVDFRqw8ogGiZXt80bClAS+vWtAlJiKsRIb797nLEAoA82CXXRAsC9FijDsfV5t
         hiG+M8TOqLu7YF3Lmd0IifAD8h7QR3bfjJAgy/yC8cEdDN1sG7sTMTE5fDEpBFS2Tdbp
         p21Q==
X-Gm-Message-State: AOJu0YwWRzVuJq2PMXGDtPtXzj984+cylKXf612uYMFR5lYddMfoU4Rk
	7rxoxJZIj7gmZnSEUsVlV7/0D+LU752ski4KGFePOPKquwI7f0YsL/HsIGAwxIPF
X-Gm-Gg: ASbGncue3YxKIQq/Hz+WgmNa6Z0AwatmZqda2Xfnu3bfq2iwZfXtHY+Pmfpzqs62JRr
	SQql+6nV6W7eUVSGntg3aSSxl7iZbE2rh1BcA3l7Ro+W/xppgCLe0q5XzkZy6b92Yk0ZcO161Gq
	nAcaLlVsv+ZlI3IndH1hfdfkht5mQUFrnx0NJRD41hPE0Wcg259so4emKVrZIvPXFSJ9i7tIjoS
	vHGWBIFKxjEhCh1Hc4hULiEF9B4WQvS9rYWngrtSHDb81RtPEo91v95gb+JbOc8Ssuo9jqKgd31
	qdCR00EE9BgZoviYiwhOjPb5x8PSJszVYUbQeVZFTXW2673pPHtvkUWh820PIAshISliNtNrl24
	eBVbFBVB8m8kWzkliU+omfWX5NfN8gabBhY1cRSRNnZFAcRt2Pf/FsbTLldReAkQPzMmwrI63WU
	eosg==
X-Google-Smtp-Source: AGHT+IF+lXifevmkNit8HoZZGnGvlTxZNcJ0P8jt/QRZMIwi9+ZkhsxvN9oydFHrPjhKAOPsjY3tZA==
X-Received: by 2002:a05:7022:786:b0:11b:6b46:3792 with SMTP id a92af1059eb24-11b6b4638d1mr700824c88.40.1763159821937;
        Fri, 14 Nov 2025 14:37:01 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b86afe12esm1496455c88.6.2025.11.14.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:01 -0800 (PST)
Message-Id: <042fbb11d03606879503846e86fac65e6e74d02a.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:49 +0000
Subject: [PATCH v4 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of char
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

Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.

In order to avoid a refactor avalanche, many uses of this field were
cast to char* or similar. One exception is in get_indent() where the
local variable `char c` was changed to `uint8_t c`.

Places where casting was unnecessary:
xemit.c:156
xmerge.c:124
xmerge.c:127
xmerge.c:164
xmerge.c:169
xmerge.c:172
xmerge.c:178

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  6 +++---
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xtypes.h    |  2 +-
 xdiff/xutils.c    |  4 ++--
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6f3998ee54..411a8aa69f 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
 	int ret = 0;
 
 	for (i = 0; i < rec->size; i++) {
-		char c = rec->ptr[i];
+		uint8_t c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
 			return ret;
@@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
@@ -1008,7 +1008,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
 	size_t i;
 
 	for (i = 0; i < xpp->ignore_regex_nr; i++)
-		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
+		if (!regexec_buf(xpp->ignore_regex[i], (const char *)rec->ptr, rec->size, 1,
 				 &regmatch, 0))
 			return 1;
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index b2f1f30cd3..ead930088a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 {
 	xrecord_t *rec = &xdf->recs[ri];
 
-	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
+	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	xrecord_t *rec = &xdf->recs[ri];
 
 	if (!xecfg->find_func)
-		return def_ff(rec->ptr, rec->size, buf, sz);
-	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
+		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index fd600cbb5d..75cb3e76a2 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t *rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
-			rec2[i].ptr, rec2[i].size, flags);
+		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
+			(const char *)rec2[i].ptr, rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch(rec1->ptr, rec1->size,
-			    rec2->ptr, rec2->size, flags);
+	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
+			    (const char *)rec2->ptr, rec2->size, flags);
 }
 
 /*
@@ -382,10 +382,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		 * we have a very simple mmfile structure.
 		 */
 		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
-		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
+		t1.size = (char *)xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
 			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
 		t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
-		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
+		t2.size = (char *)xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
 			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
@@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
 static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
-		if (line_contains_alnum(xe->xdf2.recs[i].ptr,
+		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
 				xe->xdf2.recs[i].size))
 			return 1;
 	return 0;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 669b653580..bb61354f22 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
-	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
+	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 192334f1b7..4c56467076 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->rec.ha == rec->ha &&
-				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
-					rec->ptr, rec->size, cf->flags))
+				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
+					(const char *)rec->ptr, rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -156,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = prev;
+			crec->ptr = (uint8_t const *)prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 7a2d429ec5..69727fb299 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,7 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	char const *ptr;
+	uint8_t const *ptr;
 	long size;
 	unsigned long ha;
 } xrecord_t;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 447e66c719..7be063bfb6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -465,10 +465,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	xdfenv_t env;
 
 	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
-	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
+	subfile1.size = (char *)diff_env->xdf1.recs[line1 + count1 - 2].ptr +
 		diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
 	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
-	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
+	subfile2.size = (char *)diff_env->xdf2.recs[line2 + count2 - 2].ptr +
 		diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
-- 
gitgitgadget


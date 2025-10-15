Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815C2F83D8
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563108; cv=none; b=lT/QMjYS5v9hJX5Ok0nCcjYEZg5zOqk3jdPMpd1XmJHkZLCry7jO2cSGeUl/8pr6QjyPPCsEBZmIEhbbNAJGwc0+PXoDWKzHxS2+TpYo83CR+k8wwKWiIpv4Rvsbz5CXyHKK5llkrK59GRmUVNeQ3dvGhG7vBZ4PBUfGi9TyhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563108; c=relaxed/simple;
	bh=kxFqDl3FTfJ53k6niRFQZvs8MSL5qxx58HwnM8ZBOaI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CFeiKhgZ3K7pi3KFI7YxDu9qHiAkKTtCSa2mFDNAxAiOdEnwIPTv+0+eb/JZl5TkaB/OeCb9WcxyEYCFY46hnyxE3/7Jau4zB/foH9YyHOjs23hpOFz6WFp4B7/W49+zSJq0yAk0d8tw7YyxEEEkLOPuYcSBfHyATryQX+n/8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxxpfjOY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxxpfjOY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so1181983a12.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563105; x=1761167905; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WgmlY+Q/3kweLW4gWMfzVXlqZgALNWrcj1LBtTQfY8=;
        b=PxxpfjOYwFe+yrZ3CS0zN7DcTx83W/Gc06BNgbnSwQMMSppD280EnmNgsBGyUof7i0
         3wsJK6EcCUghBCzBWmtGCeSz50/lCOQPBp60Md5PU+hAaBkVIkdEx4OdEHtwvbDvUkB6
         egwQsYapnlRxZcizkF1ZEJlzhcUiVrL44p+jtaok9NXTiCACdRQOnVvVyPeLgupahbTl
         nK4ZUTvL/l0HOktR8O/lB7T2kPrwDPySy8zdiaYcwigfoX2mRqEWCXRsK+gWgrCrYRlo
         XpEWeFIt+1+cXxV9Z6PrIKc4wdExPX6zEw0RI39hyXy7MZakDO2z0gdIxV1cibAdx6EE
         9anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563105; x=1761167905;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WgmlY+Q/3kweLW4gWMfzVXlqZgALNWrcj1LBtTQfY8=;
        b=SSPg3w0UnZj9fCVuGGMHxflcaojSc8jhC11wnU5+xr4pt5cblh+DjsVNe3ZW53XJ8b
         5WYxGv0K0Z4/jlh8uJtP/C1E8+XIJXewGz1z3h+52P5GZIDlemFiMLjOGfmeuz3/6ou8
         NCNN4guN1pnw+pmXvlmY3SxKY6YoNZcCjy2zee+rDb4kqgJ6TzJMHk/d2JeTp8xfkdR2
         joetfyCaUuync8gjW0NXsm9UNl1Jbjr/yoVQl6wld+JQwFcwjxKfqaE3cY0i2OJ7yf3w
         cpsKo3+Wh3iyKFk+YdtE7j6f15m4MeHcvHbkm9TrDl160rJYO2qmlc8hFthhRQi72qX1
         fZHw==
X-Gm-Message-State: AOJu0YxUUY/4hmJ7s4SbqALFGNHWChfaSC3z90fzSLS+kW/aH9Q8y6wt
	eynCvct+cx36HfhiN6IM+FTVVD9iszSfjX9xFLe4ofYNcn2voCYz86LzxYCnVg==
X-Gm-Gg: ASbGnctQzd3KytvAcwFABoYA4HYZPg2zf9OMi9caFjrO/+3DwQJOBj5OGZxr7p3aY47
	OMcoXnOlnwUWrFv7w06tFEx/9X2kU3TJlFJmSq5gmdGhwcQCSLb9yquV6/91WVYreQTOBq1yz0K
	3sruC1b5Mf/hGw9HoAYiP6ZU2WNN+I6pvJIjjDEtmm1G4SzO07hAMxC74teC2m7ivjYlipAe7SY
	ATatjEAwVJ9O0K8sGJHB3N286nK8XVOJIv/VTfhOMW3mPfoek3VyfONMw5S094XhFjeKZ0kvY+J
	+KxcDMdggolRMtpGhguJbVJUoi3h2Vi30dn13f0ySehyRN2EDnZZx1qq7tZH3kgeN5gdY1twRTY
	zx7ctJtj7yauY+vk+HURpGSIc/FGAUTiIJY8Z9WsSdyNxRbKrG7n7HFJZjPg5EcrG0Y1im135h2
	ru
X-Google-Smtp-Source: AGHT+IEviqPjXPy0uTp1CtcpoH1MyBMsjBZqTNImi1/O2gxhnfj/Hwo/ZzLKrJMnjz//mLVDg/kg+w==
X-Received: by 2002:a17:902:f641:b0:28e:cc41:b0e1 with SMTP id d9443c01a7336-290273ef139mr364793435ad.36.1760563105318;
        Wed, 15 Oct 2025 14:18:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afd74esm5893245ad.113.2025.10.15.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:24 -0700 (PDT)
Message-Id: <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:14 +0000
Subject: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
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

Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
referring to bytes in memory, rather than unicode code points, use
uint8_t instead of char.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  6 +++---
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  8 ++++----
 xdiff/xtypes.h    |  2 +-
 xdiff/xutils.c    |  4 ++--
 7 files changed, 22 insertions(+), 22 deletions(-)

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
index 192334f1b7..4cb18b2b88 100644
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
@@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = prev;
-			crec->size = (long) (cur - prev);
+			crec->ptr = (uint8_t const *)prev;
+			crec->size =(long) ( cur - prev);
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3514bb1684..57983627f5 100644
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


Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD22BD586
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274339; cv=none; b=G/UsbIgc94e/LnEfDsiiZCL2grZCSRaAEfZqJg3VNyWAvbNTNuE0n4ljxdSL2Xqgc/c6r3bcXH2Up3M5kq1nHBfPuTcjLZTCQwUPthfNFex3CZ21gnh43P0O46z/yg5nXjmxU8kmMrLz/7poShC5q9funXgx7CFearQ5m01N8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274339; c=relaxed/simple;
	bh=m1n1hoSq+eIduzGwM+y4I/tNjeyh7SmW0qrfYVPnF+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Amv8VUpAOfcfwqHPTfKWU3n8RAvtXURgfvPyC9MBl7WLJppRn51oksdUIUWFF6gOX8BlnPnC0d8I6JDI9Yt3A2ypEpXxGX5jTia186jQaFWgne0NUCdtSTUPwjkfOQGwPDexLEpEVnCRGP7F97mf8eDoiHKRV3TkN4hiNaXdz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOkAATLi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOkAATLi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-816ac9f9507so53771685a.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274336; x=1757879136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGDa4iObuTWe+MeSODcO7/nSNnS1c+Byh+3a8ohDvUA=;
        b=iOkAATLiQF3pRMBNrSL917b9jJbocy06/eybD0BTlps84FmnwBrBftB7mEe7tmGX4W
         6iP17sQoOy2emsUL503ztD4eNtRJYVGT86BSgnqvdu9Y64VG4pFYG2RvHknJfPFg5M8b
         +iWcfabPye3J+bKkhMIOg6hfoBrHCHBI3VaybUkKgyeRMUFVrAPKRz1E2cHmZzWCPXUT
         L7WmH3qu+KjWYUAhXQxpncknAYfg8RFo6gZcCR4VTN3Yfo9SE/AopPnyV91HzwLDphkw
         XDChn3pzhSbqjKL/lLXo6SxNiFFJY79Vf/u16WOB2Zr2Pf+DLme4Ns1sFkpxNySdNlXo
         qOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274336; x=1757879136;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGDa4iObuTWe+MeSODcO7/nSNnS1c+Byh+3a8ohDvUA=;
        b=bY1u+cE0aZ5rnXvF1l978sGa1njyv8WUN1D4/UTiVg5TQPQnAtSA+56cgR/VXD2dYA
         jPJk2yP7nrmw6GKCLO8rThq4WbD5GP4pWwivuo4BgAcYS0/aGyQPQVZ0Rn3zZ4JZhx6/
         KN4lbtA8RDhQhuTNgihZPLRAuMhq5laZSNdLN47DyAYFLoUBEV6GAJxd57mTpx4uNmsR
         2c8kc7bz4XEF27bIg2q0Fx4CeMrlus1QXJtmXo/rrvrTkHGuDq4QGUzjqq8ixToD7E2l
         hJAqcfKOydsgVW3GVZNnDmLMnEptJXwL41bfbvLiqEfjgyyeVy2z0AmSs31gTBosyUp2
         JXGg==
X-Gm-Message-State: AOJu0YxCijR6wQWCC01Ql0KlEZQ0baPxnS9/U5Y7npvqtaLxSs4cQUSm
	EG897HRZGs6YhQFdryjfZReROMtjEmZgNYFQ4yLdqWwJGh3NqXxQoktTYux5/jIr
X-Gm-Gg: ASbGncuE4AzHueMaAtoitK6ZDhRkp6haYcIPGWGDglNu48xRPSnqGzSNeaLqESet8vv
	nF0GCG/NPlu6UbTdHX3sSZ5plwUWkwKNLqxrLCrjYoTgh37YO4Ku/q75pyR/nRrTruipzo1xNgZ
	HFxbvK3LZqEYpNUQQLYv6HlS2cmg6zpC1LqYfqdm2SKlzG6FaGm2cR6fv/vv3MWDhs4mJmhgFvX
	eegmuYMqpVbLlMl6FoXggceiSqWt/7i2Tp1gSpaHo2UceVNAojil5yl3XWaVnyYcJtIRmK2Ntwp
	WbliuvwcxJQIdiC0riQ76D6CHrvvbT73vWmbFy1H4QS3dXwqcXW/fzvFpe2IBcu2x/Up5SfKHJa
	ZmQOabwK0ALstd/ADvVKlgYtaQC/+WU+5nQ==
X-Google-Smtp-Source: AGHT+IGh0yXCTXpP4LhkNZTYHiSwmAgozRuioy9KUcgHSs5sAOvAJ8kmA1k5bWF+ema0nLDpBs7ihg==
X-Received: by 2002:a05:620a:7118:b0:80e:6cd8:a9e2 with SMTP id af79cd13be357-813c2efc955mr647880185a.28.1757274336373;
        Sun, 07 Sep 2025 12:45:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81572a9d43asm242831085a.66.2025.09.07.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:35 -0700 (PDT)
Message-Id: <182f93b60bc9d9631d3e38e30c45cd57c8a3c1a9.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:15 +0000
Subject: [PATCH 12/17] xdiff: make xrecord_t.ptr a u8 instead of char
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
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     |  6 +++---
 xdiff/xmerge.c    | 14 +++++++-------
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xtypes.h    |  2 +-
 xdiff/xutils.c    |  4 ++--
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 44fd27823a..370813d2cf 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
 	int ret = 0;
 
 	for (i = 0; i < rec->size; i++) {
-		char c = rec->ptr[i];
+		u8 c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
 			return ret;
@@ -992,11 +992,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
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
@@ -1007,7 +1007,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
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
index 20cda5e258..9181815fd4 100644
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
index 36437f91bb..f5c04afe50 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -96,8 +96,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
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
+			crec->ptr = (u8 const *)prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 80afb98bf4..a1a9a61840 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,7 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	char const *ptr;
+	u8 const *ptr;
 	long size;
 	unsigned long ha;
 } xrecord_t;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 332982b509..530addf1c6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -417,10 +417,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
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


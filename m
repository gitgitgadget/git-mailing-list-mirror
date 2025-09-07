Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4C29E115
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274340; cv=none; b=caVJcv18IGGhAY5VMVJo7yMbt2FR4O3UwDM9r7HJ1HHAdr8gkq5yuGAvFgWfrpMVcZBuTlxWzDwvcAN1Uncw58EA2f0nEz0PmRb7AH0d74xh7mfPL0+74iYjuM3OWut0xX0bO+CaIghJgRA3K2qWpKHyc5FlwMpwmVc9McIwTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274340; c=relaxed/simple;
	bh=bhqAqzUut/9ixU4WzoL2KweGQnbLuB0t9VjzEqSWm3k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oQQ4PtIhql5JgZwfoNXxIl5mZypHuwegiIy0jiWw5VIiITGgjmqjF7OEYTY7a24evUkejNsaiGwIwRs6rkUsX5njuFEfs4YKRK46xtPn4B3nKD+uXFjIRwMYr3bCHuJeuj3oK/c1ZwMfQRkz7ewpwSznKqEhShs06yiLS15mcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azAHdAYK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azAHdAYK"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-811b06efefdso273512885a.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274338; x=1757879138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDDUn203kznJRFPMHPrI15kCILy0Ny0qjj1IqPKXcg0=;
        b=azAHdAYKs5oFkxLH3BuHyOnPB9LBLmG27IP2zDebxHCsSf5XXOhrvaAcxcMeheg60k
         5CbF2jlSsBxtlW/hXQibAAaGiXemYLTgnn1tZVTS8w7QNAAZw9qvs+xTOx9SYPxMz3Rv
         t40osqQ0CSHVf3IAxIKtcVrLIwAL1uWXwv/G9iHeylasGz3Xaus2C1dPav4HNMY82+DX
         HwB9UZjqJxwquqkMOoKFBq2dmDYNTMTtr/t/Gt1vNOZIrGvQrBHoK+gsQ6UC8oWrKN16
         erXq+QioOrvE0Z6BJZc1hsFGyNpp3ltNmACYodyKg5KbJNd1TP+oiaagcHhvzg5bwtYR
         /QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274338; x=1757879138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDDUn203kznJRFPMHPrI15kCILy0Ny0qjj1IqPKXcg0=;
        b=G5BKeGBrw/m4Vz43/kZ8WTnB3FCdOUyuekueB9n8qLSiLb5r/mrrTANt6VWYJdEgih
         u7SWDbwbNkiHOjG4Op6mktNQXx5mc6naJEsls94+OBLG9ENTSh5Ae5Ex4lWjbm8twkHh
         r5SQ2KyPEK6fRKIWmzUcvaAsP4hc0IM7KBfVY55TZeenMegnpkG0eGN9RSZTgbgbero3
         1OBP+VgkFLRPcloX4jhTb2O6oce+Dsd6FKVCdoZPLNiJnu+Zw8SrwHlpW14fTdmb/FMj
         PqgBhojgS+ng+4YWIW4lDuxnf+KxDuuICVQNGJR2v/q6SJaL5bMIFhSAgov2wlk3jKRE
         EODw==
X-Gm-Message-State: AOJu0YxlR9m2AhCEuU/8xO/Qxif1yfsRfJ18SvS4VdApw9wOBVx8ipzf
	YQLS8zN+cGAaEWbYQuo8ZLSN0htFoZInkHWMPfdFwgWJ8yfXdn/2nma17BDHMVQv
X-Gm-Gg: ASbGncutDcLn11rAv09E4+9+kmguxWC4NxyjaVsCyA+A8AXKvy6mStpQAUqbfjUTFQz
	MciicoP2srOnyfWX0ZgcK5ezcM5s1WceWbEq1+IxYG137957uVcFFG7upkIw/6XuprbAyojNq/S
	baagAKrGl91k6pZ6R1NQkrntoxgcIsrSYp0bzRQ3E+w+jCwwANAfNwcktOe+NTZq7GILLf1KdFw
	Jhl002NNvbB1ohrsZwY3lP/dHaNYPYB00JcwXhuOs02NFgEGJZv4lQz1LQTqFerK2qqHPpdZxaG
	ZPzFo2dI3h5b7eJ5a/boRv5jY0D05pHq30RcSUMpU1OtgM3FaeUVBzz+MJiu5F0CLmz8fA1cxtb
	O3FpPcMvdTOOryXOTyvvSna8=
X-Google-Smtp-Source: AGHT+IGl2uoPAtlfDGZwUOwOnA25y/XvSuc1TwsODYrnXm3IEzF7f+QvDefwlJt1nVHujkHPnbi9kA==
X-Received: by 2002:a05:620a:19a5:b0:7fb:d1bf:5539 with SMTP id af79cd13be357-813c1e8ede1mr578822985a.51.1757274337540;
        Sun, 07 Sep 2025 12:45:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aac237b0csm893361585a.63.2025.09.07.12.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:36 -0700 (PDT)
Message-Id: <f7aaef8f36ee8fba80b49c0c1267a8fb9bc513af.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:16 +0000
Subject: [PATCH 13/17] xdiff: make xrecord_t.size a usize instead of long
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
 xdiff/xdiffi.c   |  7 +++----
 xdiff/xemit.c    |  8 ++++----
 xdiff/xmerge.c   | 16 ++++++++--------
 xdiff/xprepare.c |  6 +++---
 xdiff/xtypes.h   |  2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 370813d2cf..45cc9ce116 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -403,10 +403,9 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
  */
 static int get_indent(xrecord_t *rec)
 {
-	long i;
 	int ret = 0;
 
-	for (i = 0; i < rec->size; i++) {
+	for (usize i = 0; i < rec->size; i++) {
 		u8 c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
@@ -992,11 +991,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, (long)rec[i].size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
+			ignore = xdl_blankline((const char *)rec[i].ptr, (long)rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ead930088a..ad3e859c57 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 {
 	xrecord_t *rec = &xdf->recs[ri];
 
-	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
+	if (xdl_emit_diffrec((char const *)rec->ptr, (long)rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 	xrecord_t *rec = &xdf->recs[ri];
 
 	if (!xecfg->find_func)
-		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
-	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
+		return def_ff((const char *)rec->ptr, (long)rec->size, buf, sz);
+	return xecfg->find_func((const char *)rec->ptr, (long)rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -151,7 +151,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
 	xrecord_t *rec = &xdf->recs[ri];
-	long i = 0;
+	usize i = 0;
 
 	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 75cb3e76a2..c1a003326a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t *rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
-			(const char *)rec2[i].ptr, rec2[i].size, flags);
+		int result = xdl_recmatch((const char *)rec1[i].ptr, (long)rec1[i].size,
+			(const char *)rec2[i].ptr, (long)rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -119,11 +119,11 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
 	if (count < 1)
 		return 0;
 
-	for (i = 0; i < count; size += recs[i++].size)
+	for (i = 0; i < count; size += (int)recs[i++].size)
 		if (dest)
 			memcpy(dest + size, recs[i].ptr, recs[i].size);
 	if (add_nl) {
-		i = recs[count - 1].size;
+		i = (int)recs[count - 1].size;
 		if (i == 0 || recs[count - 1].ptr[i - 1] != '\n') {
 			if (needs_cr) {
 				if (dest)
@@ -156,7 +156,7 @@ static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_n
  */
 static int is_eol_crlf(xdfile_t *file, int i)
 {
-	long size;
+	usize size;
 
 	if (i < file->nrec - 1)
 		/* All lines before the last *must* end in LF */
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
-			    (const char *)rec2->ptr, rec2->size, flags);
+	return xdl_recmatch((const char *)rec1->ptr, (long)rec1->size,
+			    (const char *)rec2->ptr, (long)rec2->size, flags);
 }
 
 /*
@@ -441,7 +441,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
 		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
-				xe->xdf2.recs[i].size))
+				(long)xe->xdf2.recs[i].size))
 			return 1;
 	return 0;
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index f5c04afe50..d62a329d0c 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -96,8 +96,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->rec.ha == rec->ha &&
-				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
-					(const char *)rec->ptr, rec->size, cf->flags))
+				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
+					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -157,7 +157,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = (u8 const *)prev;
-			crec->size = (long) (cur - prev);
+			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index a1a9a61840..6f83a9f4ff 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -40,7 +40,7 @@ typedef struct s_chastore {
 
 typedef struct s_xrecord {
 	u8 const *ptr;
-	long size;
+	usize size;
 	unsigned long ha;
 } xrecord_t;
 
-- 
gitgitgadget


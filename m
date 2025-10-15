Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DB2F49FB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563109; cv=none; b=gJUTRKTLVvHy/lSd2gkIhi0GUd2cGnie4ydi5tU/U+dvWxTqnfFTlIrWPyDdSghcCXorFqdRnBaLLME981MjCNDOqBswSsUkNv3eQkRzxIRsaAS+MGkSnpVcdTdwOKUuAA+jH8L4Gw++ZCD1ipQ1gfDEUOubiPr/a9nvE9ocmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563109; c=relaxed/simple;
	bh=TC0wN2fI2FgMXjl5wC2YxPv/cs+NmE1xUgN3az52TkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CjsOqvUWOAXtQNInrrab3to3oYv6gRAUCzoyxweK4UZGhkM3EU7NkWMH58G17VmGf0W8N1PYCwqRF3y9bnGpvaPbWqvnztG8ojrs0cxlqUG4o4C1pWwOh7DG+nDUcelT7ocWcmRq9dD0PdheIffTjOEMD3vrde+uCBohAtngq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvZp2yLi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvZp2yLi"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so64695b3a.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563107; x=1761167907; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZUrogplD551R7gCUpxVe7/U5jA1Fandym6CEI4cG+Q=;
        b=JvZp2yLicSI4aaOOjqyr4M55BIv7zr3kVEXjfA6O4UJGz9I25vWxxVSr5+9do9T4E1
         7dZgCsKTyQjb5YL/fFZ3qiSmc2Tjll1BIViPGbmonX4CAwe2KPuuVgb7yR+nQMLNFPfL
         G3vY1NfVlRFMZwD+46KE4xKaJkATAN+p7W4P7NO3h4sX4qOR60ugEmpWyjkC0jTzGzU/
         0NYTxEj2VoiIfpKDCb4EpCyI8mDycJVGEqokAKzAMiQ3AwlAYCL/toAv9Z7a6td37maC
         Y5TwFqTpV9w4e1LlzFRNlDRoGGdXQ0m3jj4AhTYaN4wafX6bLc75NiuqHoBTBo9smtM/
         3djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563107; x=1761167907;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZUrogplD551R7gCUpxVe7/U5jA1Fandym6CEI4cG+Q=;
        b=EaDNVWoySJBZ89FdYEtBxroMA/POPRIds5kEEI7EJXc1DBwNQ3VE1CRh1OMGM9CR/0
         Iogq3fv6eVocTOvnP0KPfDC2hkkmIRtwCBzWzYOQDlmAjD/UK1dzsL/inKTez/2qPSzJ
         21lXapMgEJpDquxDYh1AaWUGhf4qIVTPqDze64095GICJA9hsaJDPhSBJ0X1XxcSqoQB
         gMI8WwvzRDcyUfUQnZpD/7rmDoCI6oZ55el2x/TwLUbn1mPkwdetnSO9pxlMEhuvO9ya
         HFZ14gxjhJnMv6zeBGdlv2Cv/2NT7ZT3ukUjKImrENbnN3ZX3/lRC0BmFmdOWqYpxqEW
         cvcg==
X-Gm-Message-State: AOJu0Ywa4zBeV42Zyw9uzdlhCyScFNW3ORXGc4XsnYNR3jIayggBHJNS
	97xu8+Wl0Y9n+mKxo3tKecgfoOwzmMECnorRjyEW5kzCcMZ+O/aX5Kkeo4XzrQHo
X-Gm-Gg: ASbGncv0vldbwxwI5FFQIzvU3caPzpJLvNAEUTjSTBBbhe2Z0jcbdYCMUrldtBxL5jm
	e2ZgCk7nwPheIX0FczMPvvaw0t4n20HfHcE/NlNVQRBlsv6pmyXIwNO/DVhXc7CN2zjRo/MeSeB
	w/FR8sfLlbCTvEjgYBA9pS8d7hzkugvp8wgYZOC5AvJ4J8Uzl7obPgRftKxNa+ggykVrnE3rUPl
	DgbdfKVxiG3+CwrGtOPmtpnEhAxJPAZTlKAenUeq3X1ZCV5XfXc1z6KX+C1IfvgbLxEw2j6hBo8
	Is+OntWrVwkE8RG4UQQ7np6i/QiH0XEhKaj+rady4INqpk7D8hK2/A/QWDW83mH9rV7KtPdFREj
	GpTkZ0gpQ2hZMy/ZcIc6RHvfjARuxA8IZGJ9MAO09Sw==
X-Google-Smtp-Source: AGHT+IEwZhDavY/GT5lbvTMLFAy+J/2smD4J2+SEWa5+Gr+HspQ0v0gl0qYU/oEf8tLc9tAFm02C3A==
X-Received: by 2002:a05:6a20:7d9d:b0:2f8:c8f5:2e5d with SMTP id adf61e73a8af0-32da83e695bmr38207702637.45.1760563106609;
        Wed, 15 Oct 2025 14:18:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b73334asm19809585b3a.21.2025.10.15.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:26 -0700 (PDT)
Message-Id: <ae15ed712123c151b7856b56a2da9393fa5943fa.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:15 +0000
Subject: [PATCH 3/9] xdiff: use size_t for xrecord_t.size
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

size_t is the appropriate type because size is describing the number of
elements, bytes in this case, in memory.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   |  7 +++----
 xdiff/xemit.c    |  8 ++++----
 xdiff/xmerge.c   | 16 ++++++++--------
 xdiff/xprepare.c |  6 +++---
 xdiff/xtypes.h   |  2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 411a8aa69f..edd05466df 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -403,10 +403,9 @@ static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
  */
 static int get_indent(xrecord_t *rec)
 {
-	long i;
 	int ret = 0;
 
-	for (i = 0; i < rec->size; i++) {
+	for (size_t i = 0; i < rec->size; i++) {
 		uint8_t c = rec->ptr[i];
 
 		if (!XDL_ISSPACE(c))
@@ -993,11 +992,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
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
index ead930088a..2f8007753c 100644
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
+	size_t i = 0;
 
 	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 75cb3e76a2..0dd4558a32 100644
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
+	size_t size;
 
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
index 4cb18b2b88..b3219aed3e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
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
 			crec->ptr = (uint8_t const *)prev;
-			crec->size =(long) ( cur - prev);
+			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 57983627f5..00d2d8c8cd 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -40,7 +40,7 @@ typedef struct s_chastore {
 
 typedef struct s_xrecord {
 	uint8_t const *ptr;
-	long size;
+	size_t size;
 	unsigned long ha;
 } xrecord_t;
 
-- 
gitgitgadget


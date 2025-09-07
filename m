Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CA2BDC3B
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274342; cv=none; b=ilvOYf77ff4fKyXxUP4aEDU+IshSfRG+QBR1mCaEIU5DLwTCGVXHibMQ8BlWwLr4hTCGbW8HfGHPDNFeik7knkgNISK7mEQDtgvJ7vDG//3UhFPusFRpM1KQxszy1cbZpuPx2oa91cVzdka4uqLzf2dPXsOJdIY7hqcB8k3rJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274342; c=relaxed/simple;
	bh=uSiIRJ48k2gok6h07tZK/LHmhP+H+3Xcj6DdATS2rNg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Tt9An0Ff9w2RHrLyYbOfxgdpCqOdocMD2nqrg6Ku/vuTBnOPuthz/VT4KKo3xutTilMScr1rjYlVa8YVPQ4cJfN9PG2CM9qvhVW0zAxobYOmO4xtRpCNwD03jSb4gVSrduDty0UhYDrC1SsAYB9t7EB0vpGSU+4avvdVWBowZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AINenlX2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AINenlX2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70ddadde2e9so29461036d6.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274339; x=1757879139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJSf6/QPTNAOkiqdhPa4kZKgnRJqZoU7ZtzVFkLMJSk=;
        b=AINenlX2teDW2Hz4FYzYrjSecK0/tSvuZoQ2rZQ2pvRlOSJ2XetqMXLi8pMSJEJhu+
         FleylgHxv6UuINzmTwrhZ1YM15kFUpKtr6EtFjPgfVZ+39plOhJb2UWkfsYsV4LpTmix
         Pq5092EJf7r9Ot4uI/q4OWfsuVt7ZBNHZiq7Ke5bAk/S9G3gWz6/XsF0sW0ml0LWBMDC
         wDO4LitwYVfR7pBJLjwlJf1MQ0FYF/9qjLnFT3q6cegUkLxpAIowXhcCQgyi+tA/6kwX
         4rX/7xFIF9rx1r7U6yD2EPFu5MaePUVbLAAxlUS0BNFDUxDK2X0e1r3t7mM+ZNMS/Mmp
         lrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274339; x=1757879139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJSf6/QPTNAOkiqdhPa4kZKgnRJqZoU7ZtzVFkLMJSk=;
        b=fw//lqTrdHuprU5VhLLbMU0awX0+feI/scnpXObMfXlAtBuAV7njoxxpkNpKmRS/9P
         6H4jyBPa85DP9JSWrK/ZYIUhBnfHfLU3fOvguciItaylZbX4ze3vW5YwrcTpsP4ACPtC
         BupwSTJxDncJ1ThERdtoA91j8rH8N/bViANG7GtrOhLdH0hzfiXa7K03520neqBv9m/n
         si0c8gdZo0J+HPsRcD43wHIVkDf8LCr1whD+oFspcXOIRasBJBsLmsMmwH56Fn3PMZRc
         zOcszP+MpXlgxhKb1tDkSfulzhAGofVuBtwJmVPTXqrWCt8NM4QkSfS3KIg/ALwNdLVs
         8oGA==
X-Gm-Message-State: AOJu0Yzk+WMz/kLw58suHZ0QhW99OFxx4cBIXwF58PjRA3N6tvoYlAnD
	0EL1EU6NTVvnuCX8/XXNQQ3uoHTtXc6D3GpVNp0rf/PrHu2UbTZrH0JrFtEnJXLR
X-Gm-Gg: ASbGncuIXyTbavHPC2CwAQwofJz81Ez9cosZ5rU9wizMHVOvLIV5ccVp/tnndivt7r7
	0lAw9OW3w4Ag4VJqTvqzV22IlWN/98OsWBPyCWp33t+ZDyYh492B5Tan+dhbFc/4XvCWUVlscyY
	ryCkPPFyQX7prU1qo0M6jBkYmdgRhVMetkYebAF2munMlihatyuASt6Hn3hEIWkpq6SAWtOXn2R
	qJ/YnDFn4WNr038qOv8H/idxxFX0CMkHTg6bSL/eRbjKNulE/O4kaxjEOU9JgTRFgcD7yYVifPS
	AuEjktxqSVZfVzNHae1EANVK5TZzQKaKtG/9DM7ley20DFg7rtuU0zVZnTl15d0ze+A4aZKFHTw
	P/vivldltgyva9PnJWUeoh28=
X-Google-Smtp-Source: AGHT+IE9Saja3e8J70uENXJUuTQIJOlI+hALh0JahOoJ9O+YvIK3vn9xXWK6+c3YVbeRXtdIfJDLCQ==
X-Received: by 2002:a05:6214:20aa:b0:722:2301:2ee with SMTP id 6a1803df08f44-738f96e2caamr54035136d6.0.1757274338782;
        Sun, 07 Sep 2025 12:45:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b46661b9sm110383716d6.47.2025.09.07.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:38 -0700 (PDT)
Message-Id: <af96763036e13480ed4e6dfedcade5b2c90e414c.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:17 +0000
Subject: [PATCH 14/17] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
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
 xdiff/xdiffi.c     |  4 ++--
 xdiff/xhistogram.c |  4 ++--
 xdiff/xpatience.c  | 10 +++++-----
 xdiff/xprepare.c   | 18 +++++++++---------
 xdiff/xtypes.h     |  3 ++-
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 45cc9ce116..c8d351705c 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -24,7 +24,7 @@
 
 static unsigned long get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].ha;
+	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -385,7 +385,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
 {
-	return (rec1->ha == rec2->ha);
+	return (rec1->minimal_perfect_hash == rec2->minimal_perfect_hash);
 }
 
 /*
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index c2e85b8ab9..4c827b0cba 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -90,7 +90,7 @@ struct region {
 
 static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 {
-	return r1->ha == r2->ha;
+	return r1->minimal_perfect_hash == r2->minimal_perfect_hash;
 
 }
 
@@ -98,7 +98,7 @@ static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 	(cmp_recs(REC(i->env, s1, l1), REC(i->env, s2, l2)))
 
 #define TABLE_HASH(index, side, line) \
-	XDL_HASHLONG((REC(index->env, side, line))->ha, index->table_bits)
+	XDL_HASHLONG((REC(index->env, side, line))->minimal_perfect_hash, index->table_bits)
 
 static int scanA(struct histindex *index, int line1, int count1)
 {
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 9181815fd4..e400d85072 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -48,7 +48,7 @@
 struct hashmap {
 	int nr, alloc;
 	struct entry {
-		unsigned long hash;
+		usize minimal_perfect_hash;
 		/*
 		 * 0 = unused entry, 1 = first line, 2 = second, etc.
 		 * line2 is NON_UNIQUE if the line is not unique
@@ -101,10 +101,10 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 	 * So we multiply ha by 2 in the hope that the hashing was
 	 * "unique enough".
 	 */
-	int index = (int)((record->ha << 1) % map->alloc);
+	int index = (int)((record->minimal_perfect_hash << 1) % map->alloc);
 
 	while (map->entries[index].line1) {
-		if (map->entries[index].hash != record->ha) {
+		if (map->entries[index].minimal_perfect_hash != record->minimal_perfect_hash) {
 			if (++index >= map->alloc)
 				index = 0;
 			continue;
@@ -120,7 +120,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 	if (pass == 2)
 		return;
 	map->entries[index].line1 = line;
-	map->entries[index].hash = record->ha;
+	map->entries[index].minimal_perfect_hash = record->minimal_perfect_hash;
 	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
@@ -248,7 +248,7 @@ static int match(struct hashmap *map, int line1, int line2)
 {
 	xrecord_t *record1 = &map->env->xdf1.recs[line1 - 1];
 	xrecord_t *record2 = &map->env->xdf2.recs[line2 - 1];
-	return record1->ha == record2->ha;
+	return record1->minimal_perfect_hash == record2->minimal_perfect_hash;
 }
 
 static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d62a329d0c..9ec2a5d078 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -93,9 +93,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	long hi;
 	xdlclass_t *rcrec;
 
-	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
+	hi = (long) XDL_HASHLONG(rec->line_hash, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->rec.ha == rec->ha &&
+		if (rcrec->rec.line_hash == rec->line_hash &&
 				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
 					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
@@ -111,7 +111,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->rec.ptr = rec->ptr;
 		rcrec->rec.size = rec->size;
-		rcrec->rec.ha = rec->ha;
+		rcrec->rec.line_hash = rec->line_hash;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
@@ -119,7 +119,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
 
-	rec->ha = (unsigned long) rcrec->idx;
+	rec->minimal_perfect_hash = (unsigned long) rcrec->idx;
 
 	return 0;
 }
@@ -158,7 +158,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = (u8 const *)prev;
 			crec->size = cur - prev;
-			crec->ha = hav;
+			crec->line_hash = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
@@ -271,7 +271,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		dis1[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
@@ -279,7 +279,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
 	}
@@ -321,7 +321,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs2 = xdf2->recs;
 	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
@@ -329,7 +329,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs1 = xdf1->recs + xdf1->nrec - 1;
 	recs2 = xdf2->recs + xdf2->nrec - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dend = xdf1->nrec - i - 1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 6f83a9f4ff..f2b53a6553 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -41,7 +41,8 @@ typedef struct s_chastore {
 typedef struct s_xrecord {
 	u8 const *ptr;
 	usize size;
-	unsigned long ha;
+	u64 line_hash;
+	usize minimal_perfect_hash;
 } xrecord_t;
 
 typedef struct s_xdfile {
-- 
gitgitgadget


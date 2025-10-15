Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A530149C
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563112; cv=none; b=Lc1tWUSDhjBdae12rMImAc7EKIJHAMpZfi1KdmgvIfhkY531G8wS4FNl7WwZ6dOzrBKGsO1X7Iz5DXdFoLh5E3KFdyqwqwCav+Yr8ZQBzwslap18nCowM0KspwsaeU5mCIJz2z+XI0ptTWkR5pMb1iDol/+KboEEPFzOq+2z1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563112; c=relaxed/simple;
	bh=qWSJfl21VSbS8/RlhdGStaJ/ge+UELVjT2MQi4Z0oAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CJdwj0PufiQ4uD0+wG6vU2Qhjqu/HB2XzEfV7UccnIlb/y/vE88Myrybb5YFZtfyKgxDCIpDXe7XXG1lWnGsBXJUTlu4ghqsKIeNqTUVosfbi2h67FALy/60e21o8s6MoWYih12Yit62i1+kd2/3BX4PJhVyAqprLxx3Bm5OO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAwjUXfv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAwjUXfv"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-789fb76b466so73212b3a.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563109; x=1761167909; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPyvcY7H15fnVMQafBRwTdoquvAUGAEb0rkYioX0Ck4=;
        b=mAwjUXfvcJG00zvEYzauX4r4DRO0UK1RTgMI3u8o3gQ+rI7+rJoR8ffIAN4XEQ6fH0
         Thj6W7H/1F//HM7OhLusT1ETF05YzWSlpB72Y5zmyGn1fYxUthLvXOboh5eAjPI4L+BE
         0kvp6KM8NwF6X6BYFOcRBnqaXewdoRTPG5L1OwSTqQwSDdxp4WtsoSTY1Sr80l7bpxMj
         utbG3lXBb0n/L6fbqKboaxFGaZhUqkoJ+a5eiQLuDmAsMe6fJYeQc14kYgDGBbezMXe9
         A4lwdtjjaYERDhDokiQ6ILYYFaSQ8r9584oRWtF8xyFWMJaFOlz63xrwBj0kkGCUa3lR
         n9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563109; x=1761167909;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPyvcY7H15fnVMQafBRwTdoquvAUGAEb0rkYioX0Ck4=;
        b=pijdn+Am5+QGDm43C2PTu0LY5xyBDXKci21OTLnuQTPpTFqSr7pYPQzq57LTTUFr6C
         He7BypUjgZxgEZvIPacQ5kqSBNhLghrVKGTKAuoey+3YCKlkkvb/H5VeLQKWDu7M8so8
         Aue+uJBRGfI15MTC9LyVFx9lKYu48U8R+n8EXbf7ORDKIqdxwroYzyXu0Mdp7k2pxf3e
         EQ+0PR6FGWrNf3a+EeeTMf2OZkt1NWMw/XBJlFgWNOYaSFQR09ADY/dB63B6pu6R0H2d
         SvAyEAJgtcLAlEQXfn9Mbg1CaV8wksZNw3+/PBpo3xaNV77nOgDXg88Iy7ulxYmhXAKa
         b9BA==
X-Gm-Message-State: AOJu0YxGSrpkTzSTIgl54+Wirb6+TxbVnIXQS+4K5JqZHZtqUK0bZXpY
	jlmXUgbL7spmWEAxQlKnaQPAY4rMVDyexahUehWju/mOdZIsfSv5BkEpgFdpI43Z
X-Gm-Gg: ASbGncvdSyA3GhpAsdiOEzWmCARdgYs2+8x1x5NFpZWC6Dl3P92/3LCSWIzAZ9HwmYc
	wKyw9Bv+wNLYKIaV5YzxZTBoloGw1HXInvurh3z/V3zJw6zwJFnpDaaoUkkhFyhNQGbeeQ+vNYP
	pq1nwN8vrkaM5ZjVGIt7W5P02UigDaKnq5zI+uq/yqbdNJRG1sGeGj2jU6qc2osYWG9M0q4dd9n
	xudhmY0ddkUz2ceqTnacuEfp/ScZyiRQVGeaAPdnthUqoUpgq1AQunvUGoM+L1FC23cmy8e8xmh
	hJcRucLL7W5AvA6ljwRWhn72A9zYUFFlBRUtitrdNA/jO8UpBy8LNnk1FLD5k6kAooWHKI90Q+n
	PlKBCGGcpaKmsdeH7g3HQWuLTGSQf9FcDzLGWrQ6zyk0hlQaw13nXui8xoKdBEwtYok8KFPrEz4
	agHVtsn8ckLj8=
X-Google-Smtp-Source: AGHT+IEmC2BoBVGYO8+ZWCXodwKbGMJzOXfgGRdDoWhss6pGZsGKQu2I7nkHTaq92Iwi9jYRgwvIhw==
X-Received: by 2002:a17:902:ef0f:b0:27c:56af:88ea with SMTP id d9443c01a7336-290273a5f20mr300150015ad.60.1760563109099;
        Wed, 15 Oct 2025 14:18:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099af9173sm5853715ad.102.2025.10.15.14.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:28 -0700 (PDT)
Message-Id: <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:17 +0000
Subject: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and
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

The ha field is serving two different purposes, which makes the code
harder to read. At first glance it looks like many places assume
there could never be hash collisions between lines of the two input
files. In reality, line_hash is used together with xdl_recmatch() to
ensure correct comparisons of lines, even when collisions occur.

To make this clearer, the old ha field has been split:
  * line_hash: The straightforward hash of a line, requiring no
    additional context.
  * minimal_perfect_hash: Not a new concept, but now a separate
    field. It comes from the classifier's general-purpose hash table,
    which assigns each line a unique and minimal hash across the two
    files.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     |  6 +++---
 xdiff/xhistogram.c |  4 ++--
 xdiff/xpatience.c  | 10 +++++-----
 xdiff/xprepare.c   | 16 ++++++++--------
 xdiff/xtypes.h     |  3 ++-
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index edd05466df..436c34697d 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,9 +22,9 @@
 
 #include "xinclude.h"
 
-static unsigned long get_hash(xdfile_t *xdf, long index)
+static size_t get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].ha;
+	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -385,7 +385,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
 {
-	return (rec1->ha == rec2->ha);
+	return rec1->minimal_perfect_hash == rec2->minimal_perfect_hash;
 }
 
 /*
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 6dc450b1fe..5ae1282c27 100644
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
index bb61354f22..cc53266f3b 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -48,7 +48,7 @@
 struct hashmap {
 	int nr, alloc;
 	struct entry {
-		unsigned long hash;
+		size_t minimal_perfect_hash;
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
index 85e56021da..16236bd045 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -96,9 +96,9 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
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
@@ -120,7 +120,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
 
-	rec->ha = (unsigned long) rcrec->idx;
+	rec->minimal_perfect_hash = (size_t)rcrec->idx;
 
 	return 0;
 }
@@ -158,7 +158,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
 			crec->size = cur - prev;
-			crec->ha = hav;
+			crec->line_hash = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -298,7 +298,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -350,7 +350,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs2 = xdf2->recs;
 	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
@@ -358,7 +358,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs1 = xdf1->recs + xdf1->nrec - 1;
 	recs2 = xdf2->recs + xdf2->nrec - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dend = xdf1->nrec - i - 1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 00d2d8c8cd..a57a8c2c12 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -41,7 +41,8 @@ typedef struct s_chastore {
 typedef struct s_xrecord {
 	uint8_t const *ptr;
 	size_t size;
-	unsigned long ha;
+	uint64_t line_hash;
+	size_t minimal_perfect_hash;
 } xrecord_t;
 
 typedef struct s_xdfile {
-- 
gitgitgadget


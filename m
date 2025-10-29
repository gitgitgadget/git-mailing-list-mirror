Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335AC31D37C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776401; cv=none; b=PMVtTpJh+A3VwwD+0RKGZ+5OgXfEz9nuYUpmIEbo1hUsiwVlUaAA3oO846IK7+QlPTJzqG178+PH1XZd+6olxDWhgOp3o89sgyeoGOtebayYCSvJI5L9cpkg8ISm7zHkJu3Bh5yW9Gb+vJbgLOHZvsYgKmE46PmP8eCEkOP4rUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776401; c=relaxed/simple;
	bh=aF3GUz8uQRJX5+inijdfJYbZxfkrR5mWeRqSWOyHscc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NfkZBeDtbyq9+uYDzFdI2S7TVhlL7l4JGGcyVlxAyuyPJYk+sCmRd9HIzVmwbcT7uZJwRh8kiV6I57m87EaHDTYzul7nLtXpCMOyprzecMW1Tv5aaroL6hFoumHe9qRGOo/GOQz8RsXsYziZtNKy7UPYWd5lSzIIiGsTqzdIZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG4xZ0L9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG4xZ0L9"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-945a6c8721aso15680639f.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776399; x=1762381199; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqhFzpM8oNniTx+a5tIlAJsgtREgSFQSnlyj4M6tKGM=;
        b=eG4xZ0L98D6ie2HsSgM2XLDluxZ3SXKYs5molzEvkYcL19qYec0j7sf1bfmUUrPWZp
         MBJOMFfNnZ2RmD1DzZpj4JmqmjLxZ2toJwWAl01WNiW1tdM4RhwgIoFgr5VvAEHTxzKk
         aNMI/DlWW5qXeS71GL3zkzdCuaYpNyOVURahNcc6bjxfnLJFNPHvmsQp9k4bNz6W76oW
         j3Nb06e97GPjKx+qJ4Q+qEVO1OXUTujN3X7254CzFWZ933tG99ndBiTwNv7ObQFZQB0d
         wB0K3Lx37Y9//0Vz0mZMrRj3zARsl4xO5SPwQvTCO0Xhdcmg9kmRn6lRccPE1Zk03vKd
         Bawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776399; x=1762381199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqhFzpM8oNniTx+a5tIlAJsgtREgSFQSnlyj4M6tKGM=;
        b=trB5+8X4YZMX2/fd+AV83AJDNVlL1CuOCMfKOq6MsniqhKn3KFlIWhKZ4GYzoXTmYG
         JLiRXbPSnij2UI/KE9XQxIZzdWoNFdMg7ftop7cY7OKwJMSkCIALjdR1oHO7/JoAcZLD
         1Zb88Ms2kRCQsAU+RQ/qDGX6teHUYa31mXuO+zG0ERowJj09+P0CAZCdATIDHzBBTDSH
         l4H6rZX8GWQgmwO8ca4SfLSiy7daX4BJcFmnPDv052if8JcpOYV4ZCYB6IqWiGTBxgnV
         6UoLpXKKyf0PdygdOvHpb0ayw7BgacFB1p6dlO7cmL1CbP62CSJyhXVBMOT7xEcM3sXa
         hsDw==
X-Gm-Message-State: AOJu0Yz/6q8MMb7V9AMOT0ddTw1oZ1nrnznH4bhu5LLjL56pBchqyYgE
	gaiScPSaIhAwGsFut/HprlnKlVYKSfAer4I5M1p3vqrPeHJjDnklojo0RQmuIg==
X-Gm-Gg: ASbGncsSp6wTAtFxS4DKiZ7PcR4d/F0L9kdFsMN4ZW/wr8k1bOy+eZBMnws4j1q9LmY
	wdiVff1qnXr4TKFSB8zGG2NJqIHlRbhyHulRmRG+8LqWNflquI3qda37tED7OBuNiUzE1/Otfpk
	cjY2IIff4fqBR8c9vd0gcR8Z70iVELcU1T4muBKWoTayyqpahwJAJxKYkonZ3J/VF8YN9v8qMJs
	bxIIeJY2xwrODCGC6chsO+60ZnxhWhl/o7q04lt1ftA8o9ifGXYXT5tHccHsmoYeE46fZGsing4
	AT1qPn5SQrfyOG7tJIO7Hm/5XUrdqY4ZdQbcYIhb2UaGhQSLhXnSkhnO7zzMmnlm68S4XImhksa
	bSrrlj1uRL7K9ho9YDnI3SaQ6Y3C45cpYetOiXFUumDBKJuz1iDCt6cBa7GG6TCQ4N6mVN5abrF
	uChg==
X-Google-Smtp-Source: AGHT+IHnqOktmatrUcFCKLxOYMUJVSJfCSmCg1UiMx3riNUsD1kAcGt/dueGcExqH3tmrUwOdGTl/A==
X-Received: by 2002:a05:6602:2d84:b0:945:8f09:23a6 with SMTP id ca18e2360f4ac-94815259e67mr180895939f.11.1761776398838;
        Wed, 29 Oct 2025 15:19:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359e743f8sm517480639f.8.2025.10.29.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:58 -0700 (PDT)
Message-Id: <59054ea0cb65718dbac500d342bc960bdb5066c1.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:44 +0000
Subject: [PATCH v2 06/10] xdiff: split xrecord_t.ha into line_hash and
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
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
index 88b1fe4649..742b81bf3b 100644
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


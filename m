Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062B20C480
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921373; cv=none; b=kFp/roJXdPdMf6BEeKvvzUmKAxYrkPwq8DzrvBmLqUHB7rPMCPIOQ2RQx98laUeWIGLK5fppPfP3luyiNsJBIjXyO4PGeeOjASvkH+/uSpmoy+Fhesz+isbTGa8ors8jgzVx7cyBP37hY1XoH7kMlD9U0geNEgX7dRdRIx8AVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921373; c=relaxed/simple;
	bh=1wJodDW6+0c/wzWVR+p8RzpP3tL2OiPwkI1A5kyx9BM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pQUE2yII+n3WvkQwTWQp7yc6YBnLxW9NM295Kcj/yFmNKYenHg7XJEslEaUwAu7f9uwG+c9gcJkL0iCV0QETvfBs6bB6MDIiMFtsS+3hh2ZYsOzEDeecZODQGAApFxxkagjzJv7fp+sotvCAEz8KTaYmbaY+uSg5SvWmRAKdMXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRU0bGPZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRU0bGPZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so713636f8f.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921369; x=1756526169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js5yw378uXJGSLfcA5uw9aWh/wLhGtUwo5cVs80LKRI=;
        b=gRU0bGPZ5sGv+d09/QByPOMj3RDUcpmK2Y/VC4M+5Qwdd4MetP/f9PaMnCptdG92P4
         48z9DtQ7NzKxPCWkoMPDUZtdnAw2eA8D8ETkxPr0jdJgh8NDbwzBqPtVPd30dSBCLUEc
         pvik8vIqqKzXyZdKROaU+ka7wuXTkqqEIQty0ljb4yfVAiipFBpXI2uizhQuBp0KoBDb
         s8PwsTLmSPnh6eGgH8ZQPrViR5AmkLxsMCSTFXQOMDzbvnjy+HTaLLjodP1vtlBo/Ow3
         vU5EgUdqYwyCi6ktET3FJxw/x4QN76NWqw+lfYJXvcUpQ2vYn9ckmxLtq2OLEIH3kKaJ
         SwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921369; x=1756526169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js5yw378uXJGSLfcA5uw9aWh/wLhGtUwo5cVs80LKRI=;
        b=FTIf0h6U+DeHLPlUufGeJXrb1S9CCP+7R8drFyM+Fp7i3SVBe8DVrf/+AwFQcLn/8Y
         +ZCDUsz0thQwgw4Rsyxkx75r2tM8jJSBpW+8BmEIi2KegD7Pi5x85WZeCL5fBvjLCmgE
         hYCibiZ1KycdlD87oH+OChn7+zbohkG1Qqe27KsEoFMKu78Cr6I+g6LWPs1xZQ4FqLDN
         byK8yneXJodT1k2YnzImzUVnRo3iZCEzI28tyKKndw9MfbW53wy4dQWhRzMFkqr+Y3do
         jyHjYz3MQbIy5kBY42+JsgPHamZElAzmAvo/VkJdd5lZSb98IhgaaL9xV255Hcks6QKD
         SW9g==
X-Gm-Message-State: AOJu0Yyfpw7oyhEmjqgTDoD8yljA4TSnldAi0w25UsdRgOTIrXh9v3BN
	4waAJ+0Weg1R+pwuLqDRRfwkVPJa8RGitJp0UAaz9Ft1gDB0pQGZXoI97haDIw==
X-Gm-Gg: ASbGncv6Rt9k+DfuN04cdDGY+wdSUKjGwOB8Gc54Ra9IBcUKP4nP0RFgetL2VKBO3nY
	nAxbTjT8sVCOhj4aRtTPjvu3Aq/zgAA4F6Sz0EkLTeIUaI8eQMFbbCDaAM7bcOjIHtGGziEDBjl
	d8Q/6rn8Nh4iF8hl6UdFlG1Xg1wtFw4Te9AwLUls8Jwn9S0YQe70ztyk3Bzh6Mxs4n8X5ynFxWp
	Ve5FL2mr1o3w/vrnpEL+ANoN4O5b2JXDiOXkNeKL3Z3zWGC2MnsTxnvFy+Gdyfv5NLiFltQRrsX
	0+sL53hp0qIFujOkvFVprsmMhTdV2Cg+mQH0Tbk2g5OBkxgZJQ7MwMwjIZvmWu6p9Qp342nwOJ1
	p9AzqdnO88gSfKkcy3qelkvPmQ+R93KGGHJ/ARw==
X-Google-Smtp-Source: AGHT+IH/W8m5ul5RluZ1v1NE/N6enB2cY65Vpyjjgy1PI5Q2c+S9eQO2aO1gTYcjVw3didx7l1tkjw==
X-Received: by 2002:a05:6000:4308:b0:3c6:fd90:e364 with SMTP id ffacd0b85a97d-3c6fd90e4cfmr1609007f8f.35.1755921368966;
        Fri, 22 Aug 2025 20:56:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e2asm1998477f8f.6.2025.08.22.20.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:08 -0700 (PDT)
Message-Id: <e516ccc8c0abb1705f486c7d0b62eaace38f769f.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:50 +0000
Subject: [PATCH v3 09/15] xdiff: make fields of xrecord_t Rust friendly
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
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
index ad356281f939..00cdf7d8a038 100644
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


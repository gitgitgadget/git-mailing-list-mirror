Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB171CCA480
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiGHOU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiGHOUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19DD222A6
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n10so5467695wrc.4
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXlx9XaXuNvNLQdsz6/VrOiQn03h2ExIBrjBwbaZ+Pc=;
        b=JGjPxpOIInKN3BntO/HlKXs7qvmfsq9IAiz6RICjpDWfgGtnZt2YmerWLUD9jG//6k
         pqS14fUBHJrtvPAsnUE+zDUU/r82DDld801gzh6Jr5opCZ48VhElXTBni+DdawuDWDmj
         UorqBx9qgIhqrCFYMQY8i18C0TvTLTDcLJSnX7Z8KzT8IPDwoKvCIbxOxJBwvrGQ/Zr3
         kNiIvqpsL+r5p2TjRaD3mZ193ZIC9j5+HezgQAoUrckJ7bh65JvXX0AyS/hcgHeXFlNH
         8zqCuoH5pv98I2pLAcc/J9G/1GaF2qCVpOUs+pRicr8eXU0IS/nSQUQdAIai5uxYIEu1
         sdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXlx9XaXuNvNLQdsz6/VrOiQn03h2ExIBrjBwbaZ+Pc=;
        b=BgV2HXur168cntIUgJ2+lCUpmz+VL1i6ilSrf0ouhupYj3fHpEedWS9p6ecD8zkKR4
         3N+CSzTePztbuXSUq/DmpiCTdoFwGwb+kP+sUqGo7Bbaa5b61WNDdpg32wE/o4CNQU5q
         kXKuFJcRwY6r8QZGsCSNKuDTvw7kQbLxqiJzr9biqAmTzipp9TXsCtm4Cl4gUp30Pgtu
         Dteax5M7lGm9ei57gJeF+w35XxQzoqU2ZdtXQIv8CL9JLN1rHFMvFTbQgYOk5tENMwJs
         lJsastaU4hJjntqMERBkn6Dyx4Awj5aYY7i80CN0gJkwGWSTpsBVGDlEQguZLE8GCf/Q
         lBeA==
X-Gm-Message-State: AJIora8yaL5cxh7zB12nANs9BYa5sFZCycXb9r0QGlGZJZGkVP8hXYJe
        k0P5k9iq84hGQg73o8Dx9bYlnOLnuyjCgA==
X-Google-Smtp-Source: AGRyM1s2DdsERLWJlmztA2xSCBL5/x0A2GaBgjD+w6qIkHRF3xnyrLWp0hph80ZYgd6p40t6AhGj+A==
X-Received: by 2002:adf:f48e:0:b0:21d:6562:4717 with SMTP id l14-20020adff48e000000b0021d65624717mr3488690wro.428.1657290036139;
        Fri, 08 Jul 2022 07:20:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] xdiff: use G[C]ALLOC_ARRAY(), not XDL_CALLOC_ARRAY()
Date:   Fri,  8 Jul 2022 16:20:16 +0200
Message-Id: <patch-4.7-19567077b84-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the newly created GCALLOC_ARRAY() helpers rather than the recently
introduced XDL_[C]ALLOC_ARRAY().

As shown in this diff the calling convention differs, we cannot use
GCALLOC_ARRAY() as an expression, but that's an advantage in not
having to relay the "sizeof()" down via a wrapper function.

This also:

 * Fixes long-standing potential overflow issues, as we're using
   st_mult() in the underlying G_[C]ALLOC().  Note that the

 * Slightly optimizes the "XDL_CALLOC_ARRAY", as we'll now use
   calloc() rather than malloc() + memset() (although smart compilers
   will probably do the same for both...).

 * Changes the "XDL_CALLOC_ARRAY" behavior where we'd shortcut if the
   size was already large enough, but this behavior was changed when
   XDL_ALLOC_ARRAY() was introduced, so this is safe.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiffi.c     |  3 ++-
 xdiff/xhistogram.c |  9 ++++++---
 xdiff/xmacros.h    | 12 ------------
 xdiff/xpatience.c  |  6 ++++--
 xdiff/xprepare.c   | 24 ++++++++++++++++--------
 5 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6fded43e87d..077cc456087 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -333,7 +333,8 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	 * One is to store the forward path and one to store the backward path.
 	 */
 	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
-	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2))
+	GALLOC_ARRAY(kvd, 2 * ndiags + 2);
+	if (!kvd)
 		return -1;
 	kvdf = kvd;
 	kvdb = kvdf + ndiags;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index df909004c10..f20592bfbdd 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -266,14 +266,17 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 
 	index.table_bits = xdl_hashbits(count1);
 	index.records_size = 1 << index.table_bits;
-	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
+	GCALLOC_ARRAY(index.records, index.records_size);
+	if (!index.records)
 		goto cleanup;
 
 	index.line_map_size = count1;
-	if (!XDL_CALLOC_ARRAY(index.line_map, index.line_map_size))
+	GCALLOC_ARRAY(index.line_map, index.line_map_size);
+	if (!index.line_map)
 		goto cleanup;
 
-	if (!XDL_CALLOC_ARRAY(index.next_ptrs, index.line_map_size))
+	GCALLOC_ARRAY(index.next_ptrs, index.line_map_size);
+	if (!index.next_ptrs)
 		goto cleanup;
 
 	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index d13a6724629..75506bdf17e 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -49,18 +49,6 @@ do { \
 		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
 } while (0)
 
-/* Allocate an array of nr elements, returns NULL on failure */
-#define XDL_ALLOC_ARRAY(p, nr)				\
-	((p) = SIZE_MAX / sizeof(*(p)) >= (size_t)(nr)	\
-		? xdl_malloc((nr) * sizeof(*(p)))	\
-		: NULL)
-
-/* Allocate an array of nr zeroed out elements, returns NULL on failure */
-#define XDL_CALLOC_ARRAY(p, nr)				\
-	(XDL_ALLOC_ARRAY((p), (nr))			\
-		? memset((p), 0, (nr) * sizeof(*(p)))	\
-		: NULL)
-
 /*
  * Ensure array p can accommodate at least nr elements, growing the
  * array and updating alloc (which is the number of allocated
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index fe39c2978cb..bb328d9f852 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -151,7 +151,8 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
 
 	/* We know exactly how large we want the hash map */
 	result->alloc = count1 * 2;
-	if (!XDL_CALLOC_ARRAY(result->entries, result->alloc))
+	GCALLOC_ARRAY(result->entries, result->alloc);
+	if (!result->entries)
 		return -1;
 
 	/* First, fill with entries from the first file */
@@ -208,7 +209,8 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	 */
 	int anchor_i = -1;
 
-	if (!XDL_ALLOC_ARRAY(sequence, map->nr))
+	GALLOC_ARRAY(sequence, map->nr);
+	if (!sequence)
 		return -1;
 
 	for (entry = map->first; entry; entry = entry->next) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c84549f6c50..d6cbee32a2a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -78,15 +78,17 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 		return -1;
 	}
-	if (!XDL_CALLOC_ARRAY(cf->rchash, cf->hsize)) {
+	GCALLOC_ARRAY(cf->rchash, cf->hsize);
+	if (!cf->rchash) {
 
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
 
 	cf->alloc = size;
-	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
 
+	GALLOC_ARRAY(cf->rcrecs, cf->alloc);
+	if (!cf->rcrecs) {
 		xdl_free(cf->rchash);
 		xdl_cha_free(&cf->ncha);
 		return -1;
@@ -170,12 +172,14 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	GALLOC_ARRAY(recs, narec);
+	if (!recs)
 		goto abort;
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
+	GCALLOC_ARRAY(rhash, hsize);
+	if (!rhash)
 		goto abort;
 
 	nrec = 0;
@@ -196,14 +200,17 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
+	GCALLOC_ARRAY(rchg, nrec + 2);
+	if (!rchg)
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
+		GALLOC_ARRAY(rindex, nrec + 1);
+		if (!rindex)
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
+		GALLOC_ARRAY(ha, nrec + 1);
+		if (!ha)
 			goto abort;
 	}
 
@@ -369,7 +376,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 
-	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
+	GCALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2);
+	if (!dis)
 		return -1;
 	dis1 = dis;
 	dis2 = dis1 + xdf1->nrec + 1;
-- 
2.37.0.913.g189dca38629


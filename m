Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957AC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiF2P0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiF2PZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:25:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11D34668
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so23030809wra.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QWxGaVIjA8wmer+PxC09zUmethOKMXlSyygC3bfXdyw=;
        b=JFLFZLklWsjrLNk5TebZGmmGRmowdt6LcwWG/Y0WqW9xGNAWIf6L/K8N8w/W+xNwYg
         g89HYHTUE7gh84W3w31CrRm/6JCAmqT/VHGzeKruAh6PuBD+5jG2gEi6mCQB6SYJ9YnL
         aVy9U84GYJNWjZeg1FzavOSbzPpwRkCG3M2ApmaU5uGbo5SbwZGvxHbFq/h3TMgefOXm
         51Si/mAiRdrQGOyNr/qJHqpf6+JYnHQHt8JpVdV020pMekBOcPv/oiXL6wh5icw1oWCo
         69L24WmHJALGdE3w0FI2whR4CIkQD2ecXcYofzj2LBTIlNAI25ofTWk4h08X/XtOjgor
         CRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QWxGaVIjA8wmer+PxC09zUmethOKMXlSyygC3bfXdyw=;
        b=f69SdlWUG0DZKvEejMFNZU+8+EMGdA+Evn0xd8O8CAcSy9s6BXsLe/pzBlz2/ry28o
         BbQJl4YMJmJhOXSspWr5nHcW/XSWdwLfjxV3O0lgyfqDLpzTN1ums7h0us0P2I5EsRKI
         tZ5EDSP5YZ9xg9Dl1vLGlnKGYLOA+ejiEfCkwo2v2zjR94jYIphAjS7J+8G3sfMW9MQD
         8YMH/5/lv72pxn0IsZsck82WzsZrXfxgjTAtCCPCrROQLrbpct6yxRxZyMz50Y39j3hM
         wZx4yGGk0O8PEz83HccA+VU0p9eSmoOplCvvs/5eRhxZkbOl4vN/92elpL3XlZh6icX5
         JPuQ==
X-Gm-Message-State: AJIora+U+SggtqVmpibmiwg5Wjv3VEGZr+c6hU11KoIxzdzL1Nw9Gvmw
        1fdw/7cmLgumZ4kRmEaiTAEMB+Rj2VFaVg==
X-Google-Smtp-Source: AGRyM1sHboKnt0e8LpiFKXcHMrFhD4xUZKDCIhPBl0zWrcjJc8wTJ1KiXv9XR1H2OBrZGcTDeuWpdA==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id h1-20020a5d5481000000b0021a3573def0mr3575640wrv.28.1656516338890;
        Wed, 29 Jun 2022 08:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0020fcaba73bcsm17124023wri.104.2022.06.29.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:25:38 -0700 (PDT)
Message-Id: <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jun 2022 15:25:34 +0000
Subject: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a helper to grow an array. This is analogous to ALLOC_GROW() in
the rest of the codebase but returns −1 on allocation failure to
accommodate other users of libxdiff such as libgit2. It will also
return a error if the multiplication overflows while calculating the
new allocation size. Note that this keeps doubling on reallocation
like the code it is replacing rather than increasing the existing size
by half like ALLOC_GROW(). It does however copy ALLOC_GROW()'s trick
of adding a small amount to the new allocation to avoid a lot of
reallocations at small sizes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xmacros.h  | 10 ++++++++++
 xdiff/xprepare.c | 19 ++++---------------
 xdiff/xutils.c   | 17 +++++++++++++++++
 xdiff/xutils.h   |  3 ++-
 4 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 23db8e785d7..d13a6724629 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -61,4 +61,14 @@ do { \
 		? memset((p), 0, (nr) * sizeof(*(p)))	\
 		: NULL)
 
+/*
+ * Ensure array p can accommodate at least nr elements, growing the
+ * array and updating alloc (which is the number of allocated
+ * elements) as necessary. Frees p and returns -1 on failure, returns
+ * 0 on success
+ */
+#define XDL_ALLOC_GROW(p, nr, alloc)	\
+	(-!((nr) <= (alloc) ||		\
+	    ((p) = xdl_alloc_grow_helper((p), (nr), &(alloc), sizeof(*(p))))))
+
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b016570c488..c84549f6c50 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -111,7 +111,6 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
-	xdlclass_t **rcrecs;
 
 	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
@@ -127,14 +126,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 			return -1;
 		}
 		rcrec->idx = cf->count++;
-		if (cf->count > cf->alloc) {
-			cf->alloc *= 2;
-			if (!(rcrecs = (xdlclass_t **) xdl_realloc(cf->rcrecs, cf->alloc * sizeof(xdlclass_t *)))) {
-
+		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
-			}
-			cf->rcrecs = rcrecs;
-		}
 		cf->rcrecs[rcrec->idx] = rcrec;
 		rcrec->line = line;
 		rcrec->size = rec->size;
@@ -163,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs, **rrecs;
+	xrecord_t **recs;
 	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
@@ -190,12 +183,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (nrec >= narec) {
-				narec *= 2;
-				if (!(rrecs = (xrecord_t **) xdl_realloc(recs, narec * sizeof(xrecord_t *))))
-					goto abort;
-				recs = rrecs;
-			}
+			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 115b2b1640b..9e36f24875d 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -432,3 +432,20 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 
 	return 0;
 }
+
+void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
+{
+	void *tmp = NULL;
+	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
+	if (nr > n)
+		n = nr;
+	if (SIZE_MAX / size >= n)
+		tmp = xdl_realloc(p, n * size);
+	if (tmp) {
+		*alloc = n;
+	} else {
+		xdl_free(p);
+		*alloc = 0;
+	}
+	return tmp;
+}
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fba7bae03c7..fd0bba94e8b 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -42,6 +42,7 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 		       int line1, int count1, int line2, int count2);
 
-
+/* Do not call this function, use XDL_ALLOC_GROW instead */
+void* xdl_alloc_grow_helper(void* p, long nr, long* alloc, size_t size);
 
 #endif /* #if !defined(XUTILS_H) */
-- 
gitgitgadget

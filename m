Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC59BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbiGHQ0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbiGHQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8995C9C0
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:25:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso91543wms.5
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pyTDyHG/r3HDiqTRrfYUdwnY/9t53YoZ0wyo4fJc38E=;
        b=GpCdr+bWTbTkITp7S5m7Cnjjdw2zhhOllYYtDGz8z+3cYVcsCdD9y0xswTTbep7XjA
         mzYnY6IQ3dEuVadlaZMj2LcQqtSkvFHXPkPzu8ROYTEaQSpqT/JTZvIG2x2IrpTVvAof
         xeof0jN5uLTSu2+kf8+XwtwffdKF1tz3uXsVgPd1mRvqGxMK4uubSs/6pU9qJ7oPJdO2
         6vxJ5B0ekukDmL0LPiLJpEdxLcoNCd/UYNeW38QvZdlczaRvMRCKPFa9B0m3qPwHn4vy
         u5fxnr04t3WFyCL7jiWXRRlcZGBds3Qgi/mxwZo+PqEOEz/+YC7SaHcTJwu6mdoAdnN2
         EgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pyTDyHG/r3HDiqTRrfYUdwnY/9t53YoZ0wyo4fJc38E=;
        b=cN/1+Sbqo53YRhQyQ5PkveFtAlmrM/1yun+w165e0YmZt7kC7Icd83nJEOSe21Hp5n
         LveG0T0az+SCE2tGDEcdm7o4DC5bLc0sVbJcJa0cUFchHm70oXwsEktOtSSvzsotIeeD
         YtXa+HhIW1ZNAz2vlJsHaG05oN9x6TYTn9wa3pE3nrsHjL5G3fL/fGkkFik2uTUTYQ7T
         hUUmOWOAQAyC9NZfpAbbgJDxGi4ZSRIlrBZ0CO/bWpHNXowv4RqKZDRrHu9hUYOq61GP
         G0vwHjj93ptAMYpgfEr6gNJO3Pf0R09K3EXzTjGM0X1BwwVh17icyx/XcwKXyw393BXF
         bcSA==
X-Gm-Message-State: AJIora/AED8QN/lU0boGcsIZo8DdkpKXAALc/aEJV8PS1auNtAC6QDcE
        ypZjknuVPdJFoTP25yEmocK71KjScZc=
X-Google-Smtp-Source: AGRyM1ufjYHylnEzBkx3xvbCNYMpD4/gUxnLHV24PR1VrCS1mLCiLjRSsrGBVkC99rxwQ5OmGHJJIg==
X-Received: by 2002:a05:600c:3507:b0:3a1:9fbb:4d62 with SMTP id h7-20020a05600c350700b003a19fbb4d62mr600770wmq.161.1657297522474;
        Fri, 08 Jul 2022 09:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b00397402ae674sm2638147wma.11.2022.07.08.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:25:21 -0700 (PDT)
Message-Id: <55fd62dc27d2bccfdb8ac300be23fc33d1795366.1657297520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 16:25:16 +0000
Subject: [PATCH v2 1/4] xdiff: introduce XDL_ALLOC_ARRAY()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a helper to allocate an array that automatically calculates the
allocation size. This is analogous to ALLOC_ARRAY() in the rest of the
codebase but returns NULL if the allocation fails to accommodate other
users of libxdiff such as libgit2. The helper will also return NULL if
the multiplication in the allocation calculation overflows.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xdiffi.c    | 2 +-
 xdiff/xmacros.h   | 5 +++++
 xdiff/xpatience.c | 4 ++--
 xdiff/xprepare.c  | 8 ++++----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 758410c11ac..53e803e6bcb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -337,7 +337,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	 * One is to store the forward path and one to store the backward path.
 	 */
 	ndiags = xe->xdf1.nreff + xe->xdf2.nreff + 3;
-	if (!(kvd = (long *) xdl_malloc((2 * ndiags + 2) * sizeof(long)))) {
+	if (!XDL_ALLOC_ARRAY(kvd, 2 * ndiags + 2)) {
 
 		xdl_free_env(xe);
 		return -1;
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index ae4636c2477..9fd3c5da91a 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -49,5 +49,10 @@ do { \
 		((unsigned long) __p[2]) << 16 | ((unsigned long) __p[3]) << 24; \
 } while (0)
 
+/* Allocate an array of nr elements, returns NULL on failure */
+#define XDL_ALLOC_ARRAY(p, nr)				\
+	((p) = SIZE_MAX / sizeof(*(p)) >= (size_t)(nr)	\
+		? xdl_malloc((nr) * sizeof(*(p)))	\
+		: NULL)
 
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 1a21c6a74b3..ce87b9084ca 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -200,7 +200,7 @@ static int binary_search(struct entry **sequence, int longest,
  */
 static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 {
-	struct entry **sequence = xdl_malloc(map->nr * sizeof(struct entry *));
+	struct entry **sequence;
 	int longest = 0, i;
 	struct entry *entry;
 
@@ -211,7 +211,7 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	 */
 	int anchor_i = -1;
 
-	if (!sequence)
+	if (!XDL_ALLOC_ARRAY(sequence, map->nr))
 		return -1;
 
 	for (entry = map->first; entry; entry = entry->next) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 105752758f2..25866a1667a 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -86,7 +86,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->alloc = size;
-	if (!(cf->rcrecs = (xdlclass_t **) xdl_malloc(cf->alloc * sizeof(xdlclass_t *)))) {
+	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
 
 		xdl_free(cf->rchash);
 		xdl_cha_free(&cf->ncha);
@@ -178,7 +178,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
+	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
 	hbits = xdl_hashbits((unsigned int) narec);
@@ -215,9 +215,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!(rindex = xdl_malloc((nrec + 1) * sizeof(*rindex))))
+		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
 			goto abort;
-		if (!(ha = xdl_malloc((nrec + 1) * sizeof(*ha))))
+		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
 			goto abort;
 	}
 
-- 
gitgitgadget


Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDC32E728
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473070; cv=none; b=fKZQLnuiz6R7U3CU0F5wFsm5tT4U39b7PP4LUYqqEA/RmSZuHFGPZdRm0eBLUMKprEzfmBecYbeHsQXxoJdEvdFOtDMd+Z7s6bK9gihYAR4WFVAqRFM8bxruKNiz854IyZXWCsakUF0hDgmQeQQ9m+oE8Kzx5+O0WZoRTmD7RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473070; c=relaxed/simple;
	bh=mufOMR+GcI0/jUewsXSmpdXKdSxjZus68JP99AOK1w0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jRbBTjq6Cv+Qki74drZwFSxLY91n0q4e/ZjORzG6PV7cVnQWWTo7adSjDN1fHogm/4iuZXkfIxv5aoxOKop9jwKxHeGZsmjApKJ2c8lYzB/u4+F0eFjdmEJ8W5+OYtyBSCkY1umi+HE5Wp1XRHSG30z8cLYNoxqe/zrMaHsbrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkvzqP4J; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkvzqP4J"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4094b31a037so245300fac.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473067; x=1775077867; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukuDWz6AFMRo5J++T+Ni1awE0gz4ndd74lIAyel6Jgk=;
        b=qkvzqP4J5seL0TYLOM4leyHmG6zuvhh6xKCjK7Ty9Xlw6ZvP2FxNKvDg5czCG/unnh
         bgr+WyQDODxHwkpONwvc/VHmuvnSg0v0J+Md6cOUkkPzgmG951uYQ+Js0mpzI5xnQrIJ
         lY1ZrMmtLO6AIXUJGPJm4EZC8QgTXPfX61cD3udBI6hRMOCDhS40vZo2KWj9Yd4Allnz
         Y1zAXEtjsWGthIt9SRBJOqHAS27vx6LCitJtD38U3dbG4v2zaouX5hmNwCALksVIvRY0
         hLL15c31R0mtbe/FdCzUKJF3NeeXCPznRh8YeJ++80xUKCihG+X0ZNbrDMO0xpbk3DHQ
         LAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473067; x=1775077867;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukuDWz6AFMRo5J++T+Ni1awE0gz4ndd74lIAyel6Jgk=;
        b=RxBNpf2pKlz9oJjWrg0H87exLEZlfyg6fUy1pdPeD1LAFJE0j+OHfWXA7Bg3suWqU7
         4oj5XHG29KEkEdD8M6uyMCq1EP8ROvgDCu5ZhqQq7lVxiwFXxxXGEjZkUv6RufRLGHm2
         CszY3gjiouVVpo1PrkrldTvO4UYTUPg6BlozOsHG9PlRjQu/j9QNUoEhe62qmmxm5hRE
         0iyjjw3yb8Rfh0iaVZMrYb0N64LnDUh+Owjz5kWgbligdpmuVqPF+IlEoeCmG4NNB48J
         1EfPaHo1Itfsh2dd3pjqKwIu9S9pKfY3xZhP2dBAtDjPJUn7aryt/e1MpSPuSytqFVit
         U1Fg==
X-Gm-Message-State: AOJu0YwWcGU4G21+sbozHwOaLj1YUXMVyTe/mUJAuOCVhxDLUqkwQ8/J
	cCpX/gmJ2ZuF0FQERjL7g5N1PQGbDB5fHgn6H58GF9enBTWg3mDmI4VMzlua9w==
X-Gm-Gg: ATEYQzwk0Glu00bCeAQSH9wrvFAVXGDQodINdis6B/osaEk212YhA8Xb3kJw4tbe+M/
	mIQF9rRpmD6r3mUmMpHpxlrRf3TwONtUlBu7AxUEMGM1wdRIJFFdwO2zZ8xOuUxYObw2tpAhBKV
	JfyDSY0stQzlXocRuna9Qdjs7a9jllh1RM09G1DYMfikuX4MeoziyuB1FWZEU4PFWS5X32f1DNz
	qhZOCN6gG7vdF+gGjuhWPoFxZhukBqmS/6MiXXo0LL0p3rHS3eIZ3mhmQtPg9BkQD+3HVp2gX9D
	EVMQ7oyhDm4nTbnqSfVruIpnbbRzRdlOUtXqxJf6SqecF6CLtDTWPcgqw34cQ8XGOLASEkvV2ZG
	Rd1rG1h4MWBm+tv4Sesn0dFwjItESV3vWBrLTA6qrTk720JI2+KBsToiFqsdUD4XsIq84SXGKkb
	nwIpJYjy+dQZOFxosDq6YM1Ps7eA==
X-Received: by 2002:a05:6870:b493:b0:409:6227:d313 with SMTP id 586e51a60fabf-41ca70d655bmr2841054fac.35.1774473066833;
        Wed, 25 Mar 2026 14:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.213.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc7ad3444sm586342fac.12.2026.03.25.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:11:06 -0700 (PDT)
Message-Id: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Mar 2026 21:11:00 +0000
Subject: [PATCH v2 0/5] Xdiff cleanup part 3
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

v2 is a radical departure from v1 Changes in v2:

 * make the flow of xdl_cleanup_records() easier to follow

There is no performance or behavioral change introduced in this patch
series.

=== original cover letter bellow ===

Patch series summary:

 * patch 1: Introduce the ivec type
 * patch 2: Create the function xdl_do_classic_diff()
 * patches 3-4: generic cleanup
 * patches 5-8: convert from dstart/dend (in xdfile_t) to
   delta_start/delta_end (in xdfenv_t)
 * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
   xdiffi.c

Things that will be addressed in future patch series:

 * Make xdl_cleanup_records() easier to read
 * convert recs/nrec into an ivec
 * convert changed to an ivec
 * remove reference_index/nreff from xdfile_t and turn it into an ivec
 * splitting minimal_perfect_hash out as its own ivec
 * improve the performance of the classifier and parsing/hashing lines

=== before this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
size_t nreff; } xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;

=== after this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
delta_end; size_t mph_size; } xdfenv_t;

Ezekiel Newren (5):
  xdiff/xdl_cleanup_records: delete local recs pointer
  xdiff/xdl_cleanup_records: make limits more clear
  xdiff/xdl_cleanup_records: make setting action easier to follow
  xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity
  xdiff/xdl_cleanup_records: use unambiguous types

 xdiff/xprepare.c | 89 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 30 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v2
Pull-Request: https://github.com/git/git/pull/2156

Range-diff vs v1:

  1:  adf1395d20 <  -:  ---------- ivec: introduce the C side of ivec
  2:  9bd01bce9f <  -:  ---------- xdiff: make classic diff explicit by creating xdl_do_classic_diff()
  3:  53e4840c16 <  -:  ---------- xdiff: don't waste time guessing the number of lines
  4:  70040ea135 <  -:  ---------- xdiff: let patience and histogram benefit from xdl_trim_ends()
  5:  742f2d381a !  1:  8f9165d477 xdiff: use xdfenv_t in xdl_trim_ends() and xdl_cleanup_records()
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: use xdfenv_t in xdl_trim_ends() and xdl_cleanup_records()
     +    xdiff/xdl_cleanup_records: delete local recs pointer
      
     -    View with --color-words. Prepare these functions to use the fields:
     -    delta_start, delta_end. A future patch will add these fields to
     -    xdfenv_t.
     +    Simplify the first 2 for loops by directly indexing the xdfile.recs.
     +    recs is unused in the last 2 for loops, remove it. Best viewed with
     +    --color-words.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
      @@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
     -  * matches on the other file. Also, lines that have multiple matches
     -  * might be potentially discarded if they appear in a run of discardable.
        */
     --static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
     -+static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
     + static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
       	long i, nm, mlim;
     - 	xrecord_t *recs;
     +-	xrecord_t *recs;
       	xdlclass_t *rcrec;
     + 	uint8_t *action1 = NULL, *action2 = NULL;
     + 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	 * Create temporary arrays that will help us decide if
     - 	 * changed[i] should remain false, or become true.
       	 */
     --	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
     -+	if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
     - 		ret = -1;
     - 		goto cleanup;
     - 	}
     --	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
     -+	if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
     - 		ret = -1;
     - 		goto cleanup;
     - 	}
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	/*
     - 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
     - 	 */
     --	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
     -+	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
     + 	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
       		mlim = XDL_MAX_EQLIMIT;
      -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
     -+	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; i <= xe->xdf1.dend; i++, recs++) {
     - 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     +-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     ++	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     ++		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
     ++		rcrec = cf->rcrecs[mph1];
       		nm = rcrec ? rcrec->len2 : 0;
       		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
       	}
       
     --	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
     -+	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
     + 	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
       		mlim = XDL_MAX_EQLIMIT;
      -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
     -+	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; i <= xe->xdf2.dend; i++, recs++) {
     - 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     +-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     ++	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     ++		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
     ++		rcrec = cf->rcrecs[mph2];
       		nm = rcrec ? rcrec->len1 : 0;
       		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
     + 	}
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	 * Use temporary arrays to decide if changed[i] should remain
       	 * false, or become true.
       	 */
     --	xdf1->nreff = 0;
     + 	xdf1->nreff = 0;
      -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
      -	     i <= xdf1->dend; i++, recs++) {
     -+	xe->xdf1.nreff = 0;
     -+	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
     -+	     i <= xe->xdf1.dend; i++, recs++) {
     ++	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
       		if (action1[i] == KEEP ||
     --		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
     --			xdf1->reference_index[xdf1->nreff++] = i;
     -+		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->xdf1.dstart, xe->xdf1.dend))) {
     -+			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
     - 			/* changed[i] remains false, i.e. keep */
     - 		} else
     --			xdf1->changed[i] = true;
     -+			xe->xdf1.changed[i] = true;
     - 			/* i.e. discard */
     + 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
     + 			xdf1->reference_index[xdf1->nreff++] = i;
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
       	}
       
     --	xdf2->nreff = 0;
     + 	xdf2->nreff = 0;
      -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
      -	     i <= xdf2->dend; i++, recs++) {
     -+	xe->xdf2.nreff = 0;
     -+	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
     -+	     i <= xe->xdf2.dend; i++, recs++) {
     ++	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
       		if (action2[i] == KEEP ||
     --		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
     --			xdf2->reference_index[xdf2->nreff++] = i;
     -+		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->xdf2.dstart, xe->xdf2.dend))) {
     -+			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
     - 			/* changed[i] remains false, i.e. keep */
     - 		} else
     --			xdf2->changed[i] = true;
     -+			xe->xdf2.changed[i] = true;
     - 			/* i.e. discard */
     - 	}
     - 
     -@@ xdiff/xprepare.c: cleanup:
     - /*
     -  * Early trim initial and terminal matching records.
     -  */
     --static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
     -+static int xdl_trim_ends(xdfenv_t *xe) {
     - 	long i, lim;
     - 	xrecord_t *recs1, *recs2;
     - 
     --	recs1 = xdf1->recs;
     --	recs2 = xdf2->recs;
     --	for (i = 0, lim = (long)XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
     -+	recs1 = xe->xdf1.recs;
     -+	recs2 = xe->xdf2.recs;
     -+	for (i = 0, lim = (long)XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec); i < lim;
     - 	     i++, recs1++, recs2++)
     - 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
     - 			break;
     - 
     --	xdf1->dstart = xdf2->dstart = i;
     -+	xe->xdf1.dstart = xe->xdf2.dstart = i;
     - 
     --	recs1 = xdf1->recs + xdf1->nrec - 1;
     --	recs2 = xdf2->recs + xdf2->nrec - 1;
     -+	recs1 = xe->xdf1.recs + xe->xdf1.nrec - 1;
     -+	recs2 = xe->xdf2.recs + xe->xdf2.nrec - 1;
     - 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
     - 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
     - 			break;
     - 
     --	xdf1->dend = (long)xdf1->nrec - i - 1;
     --	xdf2->dend = (long)xdf2->nrec - i - 1;
     -+	xe->xdf1.dend = (long)xe->xdf1.nrec - i - 1;
     -+	xe->xdf2.dend = (long)xe->xdf2.nrec - i - 1;
     - 
     - 	return 0;
     - }
     -@@ xdiff/xprepare.c: int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     - 		xdl_classify_record(2, &cf, rec);
     - 	}
     - 
     --	xdl_trim_ends(&xe->xdf1, &xe->xdf2);
     -+	xdl_trim_ends(xe);
     - 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
     - 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
     --	    xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
     -+	    xdl_cleanup_records(&cf, xe) < 0) {
     - 
     - 		xdl_free_ctx(&xe->xdf2);
     - 		xdl_free_ctx(&xe->xdf1);
     + 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
     + 			xdf2->reference_index[xdf2->nreff++] = i;
  6:  65da408da9 <  -:  ---------- xdiff: cleanup xdl_trim_ends()
  7:  d74722538b <  -:  ---------- xdiff: replace xdfile_t.dstart with xdfenv_t.delta_start
  8:  d0ef5b23c4 <  -:  ---------- xdiff: replace xdfile_t.dend with xdfenv_t.delta_end
  9:  f9b10e71d2 !  2:  62adaa8e5a xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: remove dependence on xdlclassifier from xdl_cleanup_records()
     +    xdiff/xdl_cleanup_records: make limits more clear
      
     -    Disentangle xdl_cleanup_records() from the classifier so that it can be
     -    moved from xprepare.c into xdiffi.c.
     -
     -    The classic diff is the only algorithm that needs to count the number
     -    of times each line occurs in each file. Make xdl_cleanup_records()
     -    count the number of lines instead of the classifier so it won't slow
     -    down patience or histogram.
     +    Make the handling of per-file limits and the minimal-case clearer.
     +      * Use explicit per-file limit variables (mlim1, mlim2) and initialize
     +        them.
     +      * The additional condition `!need_min` is redudant now, remove it.
     +    Best viewed with --color-words.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
     -@@
     -  */
     - 
     - #include "xinclude.h"
     -+#include "compat/ivec.h"
     - 
     - 
     - #define XDL_KPDIS_RUN 4
     -@@ xdiff/xprepare.c: typedef struct s_xdlclass {
     - 	struct s_xdlclass *next;
     - 	xrecord_t rec;
     - 	long idx;
     --	long len1, len2;
     - } xdlclass_t;
     - 
     - typedef struct s_xdlclassifier {
     -@@ xdiff/xprepare.c: static void xdl_free_classifier(xdlclassifier_t *cf) {
     - }
     - 
     - 
     --static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
     -+static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t *rec) {
     - 	size_t hi;
     - 	xdlclass_t *rcrec;
     - 
     -@@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
     - 				return -1;
     - 		cf->rcrecs[rcrec->idx] = rcrec;
     - 		rcrec->rec = *rec;
     --		rcrec->len1 = rcrec->len2 = 0;
     - 		rcrec->next = cf->rchash[hi];
     - 		cf->rchash[hi] = rcrec;
     - 	}
     - 
     --	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
     --
     - 	rec->minimal_perfect_hash = (size_t)rcrec->idx;
     - 
     - 	return 0;
      @@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
     - 	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
     - }
     - 
     -+struct xoccurrence
     -+{
     -+	size_t file1, file2;
     -+};
     -+
     -+
     -+DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
     -+
     - 
     - /*
     -  * Try to reduce the problem complexity, discard records that have no
     -  * matches on the other file. Also, lines that have multiple matches
        * might be potentially discarded if they appear in a run of discardable.
        */
     --static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
     + static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
      -	long i, nm, mlim;
     -+static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
     -+	long i;
     -+	size_t nm, mlim;
     - 	xrecord_t *recs;
     --	xdlclass_t *rcrec;
     ++	long i, nm;
     ++	size_t mlim1, mlim2;
     + 	xdlclass_t *rcrec;
       	uint8_t *action1 = NULL, *action2 = NULL;
     --	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     -+	struct IVec_xoccurrence occ;
     -+	bool need_min = !!(flags & XDF_NEED_MINIMAL);
     - 	int ret = 0;
     - 	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
     - 	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
     + 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     + 		goto cleanup;
     + 	}
       
     -+	IVEC_INIT(occ);
     -+	ivec_zero(&occ, xe->mph_size);
     -+
     -+	for (size_t j = 0; j < xe->xdf1.nrec; j++) {
     -+		size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
     -+		occ.ptr[mph1].file1 += 1;
     -+	}
     -+
     -+	for (size_t j = 0; j < xe->xdf2.nrec; j++) {
     -+		size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
     -+		occ.ptr[mph2].file2 += 1;
     ++	if (need_min) {
     ++		/* i.e. infinity */
     ++		mlim1 = SIZE_MAX;
     ++		mlim2 = SIZE_MAX;
     ++	} else {
     ++		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
     ++		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
      +	}
      +
       	/*
     - 	 * Create temporary arrays that will help us decide if
     - 	 * changed[i] should remain false, or become true.
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
     - 	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
     - 		mlim = XDL_MAX_EQLIMIT;
     - 	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
     --		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     --		nm = rcrec ? rcrec->len2 : 0;
     -+		nm = occ.ptr[recs->minimal_perfect_hash].file2;
     - 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
     + 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
     + 	 */
     +-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
     +-		mlim = XDL_MAX_EQLIMIT;
     + 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     + 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
     + 		rcrec = cf->rcrecs[mph1];
     + 		nm = rcrec ? rcrec->len2 : 0;
     +-		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
     ++		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
       	}
       
     - 	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
     - 		mlim = XDL_MAX_EQLIMIT;
     - 	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
     --		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
     --		nm = rcrec ? rcrec->len1 : 0;
     -+		nm = occ.ptr[recs->minimal_perfect_hash].file1;
     - 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
     - 	}
     - 
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
     - cleanup:
     - 	xdl_free(action1);
     - 	xdl_free(action2);
     -+	ivec_free(&occ);
     - 
     - 	return ret;
     - }
     -@@ xdiff/xprepare.c: int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
     - 
     - 	for (size_t i = 0; i < xe->xdf1.nrec; i++) {
     - 		xrecord_t *rec = &xe->xdf1.recs[i];
     --		xdl_classify_record(1, &cf, rec);
     -+		xdl_classify_record(&cf, rec);
     +-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
     +-		mlim = XDL_MAX_EQLIMIT;
     + 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     + 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
     + 		rcrec = cf->rcrecs[mph2];
     + 		nm = rcrec ? rcrec->len1 : 0;
     +-		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
     ++		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
       	}
       
     - 	for (size_t i = 0; i < xe->xdf2.nrec; i++) {
     - 		xrecord_t *rec = &xe->xdf2.recs[i];
     --		xdl_classify_record(2, &cf, rec);
     -+		xdl_classify_record(&cf, rec);
     - 	}
     - 
     -+	xe->mph_size = cf.count;
     -+
     - 	xdl_trim_ends(xe);
     - 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
     - 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
     --	    xdl_cleanup_records(&cf, xe) < 0) {
     -+	    xdl_cleanup_records(xe, xpp->flags) < 0) {
     - 
     - 		xdl_free_ctx(&xe->xdf2);
     - 		xdl_free_ctx(&xe->xdf1);
     -
     - ## xdiff/xtypes.h ##
     -@@ xdiff/xtypes.h: typedef struct s_xdfile {
     - typedef struct s_xdfenv {
     - 	xdfile_t xdf1, xdf2;
     - 	size_t delta_start, delta_end;
     -+	size_t mph_size;
     - } xdfenv_t;
     - 
     - 
     + 	/*
 10:  1dba6b34aa <  -:  ---------- xdiff: move xdl_cleanup_records() from xprepare.c to xdiffi.c
  -:  ---------- >  3:  8be7e4781a xdiff/xdl_cleanup_records: make setting action easier to follow
  -:  ---------- >  4:  6abd052c34 xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity
  -:  ---------- >  5:  a52787f019 xdiff/xdl_cleanup_records: use unambiguous types

-- 
gitgitgadget

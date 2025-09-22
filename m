Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BB2E765E
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570707; cv=none; b=n3h/OSGprU6GlCDNZ+1FYN1l42mpt8Rdt4Bbc2aC57CyDobNjjNlMThUJfvUfD4GGcS6BJcnmM/vsWc+giT456hXmrNd07WmB2D2kp5fnds5JAeaRWQhL6XcZZuW7JfvjzVLIW56dMMc0prHNW0/FhBtT99aAakRrwu8mGRdfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570707; c=relaxed/simple;
	bh=aZgPjUG9ez0Kszsi3IsNQI2Inqe2BA7heMYW2ZmenY4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=qeqi2+xa+Bnr8C0Zl1Qt3DxDL8d9dtR2eBcsKe2DYF2VVFS6PjoHM47NxolmpNL1kRVcUI5Pi7bb9ByNyn6PLl0hypIPeDFidxtAOMQC41J+nOuxuwVL6qVhEq0ty7WbnxnSGABgSMi8l/dhKi+c4ancj7DxHxFYXnIQSlQ9s/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S77OhEHG; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S77OhEHG"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4248b079780so11172425ab.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570704; x=1759175504; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuunKom7lyJT85Xeh8DMbCgEtMlNSqSkXmtMFmFPyp0=;
        b=S77OhEHGg+yMyq3R8RY0o4j0w6HqTHwlfWo7B+UHgm2brFhetjRl+TVCQEHPQXercl
         EzWy8JDP/DYf+BRhPOZ535ipKEfiPZ1UGxMe8HPPqTIiXSMZWK6uOrMjztJTX7ppLlGl
         gBp+/QCFioY70hQnL5FjPd+HYica27AjvxB3MF0zrMwmItDeBPZ17dTk1UKZIYyBAHMw
         tPpiqgeEc/yLhAz/M3gJIaeXQPsqK91W1J4vSfhm/Votsgj4n2+Hfqifz+1kDma9OB5W
         ZQALA9QYzZrCQUOzcEfRQwqY1txwtgs9WMDROr7UFr46EsO2ERuZDnujDjmfSolo420D
         n0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570704; x=1759175504;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuunKom7lyJT85Xeh8DMbCgEtMlNSqSkXmtMFmFPyp0=;
        b=WDaPqBOUZ8nKb1V9EnnrKStXOko/tTzH20PhcpltNomwTGj1OIH1R3/UdB6d7/ap7V
         9N+U8RMbIgJd2theY2LYZgirvX9oEIiquCywStntLJQa0hQcTaRvc20iGYPaWO9FTXhE
         UNJaihZCnIKxdPXIqBi4ZXVrlFWavv6bbKe9Jj0QG4s9v8ly4N1VMNACXTNKcTXBwveh
         MIxrHPEDu9q6TG5mMp1SNOiQwIyeS6nxwxMJcYC/RyZWRakA8qTpwqKdoB7hHzvePVv+
         UJSRbcWGDBlUwV/APuBO8t28UAQoO4BUQYG1c/UrOcnnI6jey7zkaVrVZkOactPmE7ES
         L1FQ==
X-Gm-Message-State: AOJu0Yx77Uv8PDpIwyeITpEtUWASxF5qPN9EE5m7XhwMVcyuO4zrEQiG
	tat3HzccDVyMBsPI8roftOkKPS4vHQQJiilAyT8s/9HTp6dnNKzN3RQstSkvvA==
X-Gm-Gg: ASbGncvfxgVUpPkPW3UbVUeDRdOJ8IH/3yXMXyYf+H8f+aUIkCVni80kKLTISpbcEEK
	NuMkS0+hWCzJd+t9XuW9B/86lC+USPPbZfUV75ulHy98awunjozkZCTPlUXKQT67zYWi4WgRhnJ
	u+5X5Sh1SrRWX3NY+yEIFC+Br1OCWZAQ44JmHaHFxGrS+RTVLg4u/k73NUe3VktOAQp7fajN8vV
	1MT27ZNbODeBNKKwzebNn/sYzzFQWeypXYsNSDqmXJd55PoWfkpEdqs/YaCJkgs/hkpFyumTGx+
	wSDiMLrxxsuIsnuEgH6TLqKLrmeyqa/l1q5oaGuebZMxYfGlPCYKPQWBmuKQVZBDGAfx7giUbzf
	H6lfZB2NmmVY1amDRKRCCGUYCBQ==
X-Google-Smtp-Source: AGHT+IHrkwri0DyTAGCsSFTba0Ogg+H2xOY+EgY/8I1ChBwfkukBIEfnBewfuHnFOdLAP1su9ZucQg==
X-Received: by 2002:a05:6e02:2142:b0:424:826:4f03 with SMTP id e9e14a558f8ab-42581e78d54mr2075965ab.17.1758570704122;
        Mon, 22 Sep 2025 12:51:44 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4257d076abbsm10481515ab.23.2025.09.22.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:42 -0700 (PDT)
Message-Id: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:29 +0000
Subject: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes since v3.

 * Address review feedback.
 * Split the deletion of xdl_get_rec() into 2 commits.
 * Move NO, YES, MAYBE into xprepare.c, and use bool literals.
 * refactor 'char rchg' to 'bool changed'

Changes since v2.

 * No patch changes, just resending to get patch 9 to show up on the mailing
   list.
 * A few tweaks to the cover letter.

Changes since v1, to address review feedback.

 * Only include the clean up patches; The remaining patches will be split
   into a separate series.
 * Commit message clarifications.
 * Minor style cleanups.
 * Performance impacts included in commit message of patch 8.


Relevant part of the original cover letter follows:
===================================================

Before:

typedef struct s_xrecord {
	struct s_xrecord *next;
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	chastore_t rcha;
	long nrec;
	unsigned int hbits;
	xrecord_t **rhash;
	long dstart, dend;
	xrecord_t **recs;
	char *rchg;
	long *rindex;
	long nreff;
	unsigned long *ha;
} xdfile_t;


After cleanup:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	char *rchg;
	long *rindex;
	long nreff;
} xdfile_t;


===

Ezekiel Newren (12):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete superfluous function xdl_get_rec() in xemit
  xdiff: delete superfluous local variables that alias fields in
    xrecord_t
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t
  xdiff: delete rchg aliasing
  xdiff: use bool literals for xdfile_t.rchg
  xdiff: refactor 'char *rchg' to 'bool *changed' in xdfile_t

 xdiff/xdiffi.c     | 101 ++++++++---------
 xdiff/xdiffi.h     |  11 +-
 xdiff/xemit.c      |  38 +++----
 xdiff/xhistogram.c |  10 +-
 xdiff/xmerge.c     |  56 +++++-----
 xdiff/xpatience.c  |  18 ++--
 xdiff/xprepare.c   | 263 +++++++++++++++++----------------------------
 xdiff/xtypes.h     |   9 +-
 xdiff/xutils.c     |  16 +--
 9 files changed, 212 insertions(+), 310 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v4
Pull-Request: https://github.com/git/git/pull/2048

Range-diff vs v3:

  1:  784cffcef5 !  1:  79d1099656 xdiff: delete static forward declarations in xprepare
     @@ xdiff/xprepare.c: static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xd
      +		xdl_free_ctx(&xe->xdf1);
      +		xdl_free_classifier(&cf);
      +		return -1;
     -+	    }
     ++	}
      +
      +	xdl_free_classifier(&cf);
      +
  2:  b79157e64f =  2:  9142f28fcd xdiff: delete local variables and initialize/free xdfile_t directly
  3:  2e8de5be03 =  3:  13f00f5683 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  -:  ---------- >  4:  311279c123 xdiff: delete superfluous function xdl_get_rec() in xemit
  4:  ddfee67e06 !  5:  d84658ac83 xdiff: delete xdl_get_rec() in xemit
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: delete xdl_get_rec() in xemit
     +    xdiff: delete superfluous local variables that alias fields in xrecord_t
      
     -    This function aliases the fields of xrecord_t, which makes it harder
     -    to track the usages of those fields. Delete it.
     +    Use the type xrecord_t as the local variable for the functions in the
     +    file xdiff/xemit.c.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xemit.c ##
      @@
     - 
       #include "xinclude.h"
       
     --static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
     --
     --	*rec = xdf->recs[ri]->ptr;
     --
     --	return xdf->recs[ri]->size;
     --}
     --
     --
     + 
      -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
      -	long size, psize = strlen(pre);
     --	char const *rec;
     --
     --	size = xdl_get_rec(xdf, ri, &rec);
     --	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
     +-	char const *rec = xdf->recs[ri]->ptr;
      +static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
      +{
      +	xrecord_t *rec = xdf->recs[ri];
       
     -+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
     +-	size = xdf->recs[ri]->size;
     +-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
     ++	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
       		return -1;
     - 	}
       
     + 	return 0;
      @@ xdiff/xemit.c: static long def_ff(const char *rec, long len, char *buf, long sz)
       static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
       			   char *buf, long sz)
       {
     --	const char *rec;
     --	long len = xdl_get_rec(xdf, ri, &rec);
     +-	const char *rec = xdf->recs[ri]->ptr;
     +-	long len = xdf->recs[ri]->size;
      +	xrecord_t *rec = xdf->recs[ri];
      +
       	if (!xecfg->find_func)
     @@ xdiff/xemit.c: static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg
       
       static int is_empty_rec(xdfile_t *xdf, long ri)
       {
     --	const char *rec;
     --	long len = xdl_get_rec(xdf, ri, &rec);
     +-	const char *rec = xdf->recs[ri]->ptr;
     +-	long len = xdf->recs[ri]->size;
      +	xrecord_t *rec = xdf->recs[ri];
      +	long i = 0;
       
  5:  807ce3e5aa =  6:  bf16453846 xdiff: delete struct diffdata_t
  6:  0bacb1191d !  7:  4ef7f243e9 xdiff: delete redundant array xdfile_t.ha
     @@ Commit message
      
          This makes the code about 5% slower. The fields rindex and ha are
          specific to the classic diff (myers and minimal). I plan on creating a
     -    struct for classic diff, but there'a alot of cleanup that needs to be
     +    struct for classic diff, but there's a lot of cleanup that needs to be
          done before that can happen and leaving ha in would make those cleanups
          harder to follow.
      
  7:  e1e94107c9 !  8:  3b6c2127c4 xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
     @@ Commit message
          xdlclass_t.size -> xrecord_t.size
          xdlclass_t.ha   -> xrecord_t.ha
      
     -    Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.
     +    xdlclass_t carries a copy of the data in xrecord_t, but instead of
     +    embedding xrecord_t it duplicates the individual fields. A future
     +    commit will change the types used in xrecord_t so embed it in
     +    xdlclass_t first, so we don't have to remember to change the types
     +    here as well.
      
          Best-viewed-with: --color-words
     +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
     @@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifie
      -		rcrec->line = line;
      -		rcrec->size = rec->size;
      -		rcrec->ha = rec->ha;
     -+		rcrec->rec.ptr = rec->ptr;
     -+		rcrec->rec.size = rec->size;
     -+		rcrec->rec.ha = rec->ha;
     ++		rcrec->rec = *rec;
       		rcrec->len1 = rcrec->len2 = 0;
       		rcrec->next = cf->rchash[hi];
       		cf->rchash[hi] = rcrec;
  8:  fae26d2a04 !  9:  f7b5021e48 xdiff: delete chastore from xdfile_t
     @@ xdiff/xemit.c
      -	xrecord_t *rec = xdf->recs[ri];
      +	xrecord_t *rec = &xdf->recs[ri];
       
     - 	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
     + 	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
       		return -1;
      @@ xdiff/xemit.c: static long def_ff(const char *rec, long len, char *buf, long sz)
       static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
  9:  fd54135560 = 10:  97135495e2 xdiff: delete rchg aliasing
 10:  1e404c3290 ! 11:  b544c15a67 xdiff: treat xdfile_t.rchg like an enum
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: treat xdfile_t.rchg like an enum
     +    xdiff: use bool literals for xdfile_t.rchg
      
     -    Define macros NO(0), YES(1), MAYBE(2) as the enum values for rchg to
     -    make the code easier to follow. Perhaps 'rchg' should be renamed to
     -    'changed'?
     -
     -    A few of the code changes might appear to change behavior, such as:
     -        -    while (xdf->rchg[g->start - 1])
     -        +    while (xdf->rchg[g->start - 1] == YES)
     -    because it appears the value of MAYBE is being ignored.  However, MAYBE
     -    is only ever assigned as a value to a temporary array (dis1 & dis2) and
     -    then as a last step use that temporary array to decide if it wants to
     -    change xdfile_t.rchg[i] to YES or leave it as NO.  As such, rchg will
     -    never have a value of MAYBE and thus there is no behavioral change.
     +    Define macros NO(0), YES(1), MAYBE(2) as the enum values for dis1 and
     +    dis2 to make the code easier to follow.
      
          Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## xdiff/xdiff.h ##
     -@@
     - extern "C" {
     - #endif /* #ifdef __cplusplus */
     - 
     -+#define NO 0
     -+#define YES 1
     -+#define MAYBE 2
     -+
     - /* xpparm_t.flags */
     - #define XDF_NEED_MINIMAL (1 << 0)
     - 
     -
       ## xdiff/xdiffi.c ##
      @@ xdiff/xdiffi.c: int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
       	 */
       	if (off1 == lim1) {
       		for (; off2 < lim2; off2++)
      -			xdf2->rchg[xdf2->rindex[off2]] = 1;
     -+			xdf2->rchg[xdf2->rindex[off2]] = YES;
     ++			xdf2->rchg[xdf2->rindex[off2]] = true;
       	} else if (off2 == lim2) {
       		for (; off1 < lim1; off1++)
      -			xdf1->rchg[xdf1->rindex[off1]] = 1;
     -+			xdf1->rchg[xdf1->rindex[off1]] = YES;
     ++			xdf1->rchg[xdf1->rindex[off1]] = true;
       	} else {
       		xdpsplit_t spl;
       		spl.i1 = spl.i2 = 0;
     -@@ xdiff/xdiffi.c: struct xdlgroup {
     - static void group_init(xdfile_t *xdf, struct xdlgroup *g)
     - {
     - 	g->start = g->end = 0;
     --	while (xdf->rchg[g->end])
     -+	while (xdf->rchg[g->end] == YES)
     - 		g->end++;
     - }
     - 
     -@@ xdiff/xdiffi.c: static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
     - 		return -1;
     - 
     - 	g->start = g->end + 1;
     --	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
     -+	for (g->end = g->start; xdf->rchg[g->end] == YES; g->end++)
     - 		;
     - 
     - 	return 0;
     -@@ xdiff/xdiffi.c: static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
     - 		return -1;
     - 
     - 	g->end = g->start - 1;
     --	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
     -+	for (g->start = g->end; xdf->rchg[g->start - 1] == YES; g->start--)
     - 		;
     - 
     - 	return 0;
      @@ xdiff/xdiffi.c: static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->end < xdf->nrec &&
       	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
      -		xdf->rchg[g->start++] = 0;
      -		xdf->rchg[g->end++] = 1;
     -+		xdf->rchg[g->start++] = NO;
     -+		xdf->rchg[g->end++] = YES;
     ++		xdf->rchg[g->start++] = false;
     ++		xdf->rchg[g->end++] = true;
       
     --		while (xdf->rchg[g->end])
     -+		while (xdf->rchg[g->end] == YES)
     + 		while (xdf->rchg[g->end])
       			g->end++;
     - 
     - 		return 0;
      @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->start > 0 &&
       	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
      -		xdf->rchg[--g->start] = 1;
      -		xdf->rchg[--g->end] = 0;
     -+		xdf->rchg[--g->start] = YES;
     -+		xdf->rchg[--g->end] = NO;
     ++		xdf->rchg[--g->start] = true;
     ++		xdf->rchg[--g->end] = false;
       
     --		while (xdf->rchg[g->start - 1])
     -+		while (xdf->rchg[g->start - 1] == YES)
     + 		while (xdf->rchg[g->start - 1])
       			g->start--;
     - 
     - 		return 0;
      
       ## xdiff/xhistogram.c ##
      @@ xdiff/xhistogram.c: redo:
     @@ xdiff/xhistogram.c: redo:
       	if (!count1) {
       		while(count2--)
      -			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = YES;
     ++			env->xdf2.rchg[line2++ - 1] = true;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
      -			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = YES;
     ++			env->xdf1.rchg[line1++ - 1] = true;
       		return 0;
       	}
       
     @@ xdiff/xhistogram.c: redo:
       		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
       			while (count1--)
      -				env->xdf1.rchg[line1++ - 1] = 1;
     -+				env->xdf1.rchg[line1++ - 1] = YES;
     ++				env->xdf1.rchg[line1++ - 1] = true;
       			while (count2--)
      -				env->xdf2.rchg[line2++ - 1] = 1;
     -+				env->xdf2.rchg[line2++ - 1] = YES;
     ++				env->xdf2.rchg[line2++ - 1] = true;
       			result = 0;
       		} else {
       			result = histogram_diff(xpp, env,
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	if (!count1) {
       		while(count2--)
      -			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = YES;
     ++			env->xdf2.rchg[line2++ - 1] = true;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
      -			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = YES;
     ++			env->xdf1.rchg[line1++ - 1] = true;
       		return 0;
       	}
       
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	if (!map.has_matches) {
       		while(count1--)
      -			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = YES;
     ++			env->xdf1.rchg[line1++ - 1] = true;
       		while(count2--)
      -			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = YES;
     ++			env->xdf2.rchg[line2++ - 1] = true;
       		xdl_free(map.entries);
       		return 0;
       	}
      
       ## xdiff/xprepare.c ##
     +@@
     + #define XDL_GUESS_NLINES1 256
     + #define XDL_GUESS_NLINES2 20
     + 
     ++#define NO 0
     ++#define YES 1
     ++#define MAYBE 2
     + 
     + typedef struct s_xdlclass {
     + 	struct s_xdlclass *next;
      @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
       	 * current line (i) is already a multimatch line.
       	 */
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       			xdf1->rindex[nreff++] = i;
       		} else
      -			xdf1->rchg[i] = 1;
     -+			xdf1->rchg[i] = YES;
     ++			xdf1->rchg[i] = true;
       	}
       	xdf1->nreff = nreff;
       
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       			xdf2->rindex[nreff++] = i;
       		} else
      -			xdf2->rchg[i] = 1;
     -+			xdf2->rchg[i] = YES;
     ++			xdf2->rchg[i] = true;
       	}
       	xdf2->nreff = nreff;
       
  -:  ---------- > 12:  034a4a7b2a xdiff: refactor 'char *rchg' to 'bool *changed' in xdfile_t

-- 
gitgitgadget

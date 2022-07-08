Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A960C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiGHQ0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiGHQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F62A711
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:25:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so21623008wrq.7
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jYGkig7dhsHe04Q4eAR+F8yFyd+WR3pP/6SIXuolRPo=;
        b=FVoq2q5zaDulXdoNHnln9ykPP0GEumakq2TJPlVXMgVsygyPDpDMrB+HFdQCD/ADNW
         VdvVxyUhwNenffgCA99xRyVcxnHmUaZKmChdAH5AimH71PnihB5ZwpVrcPtGnvr4k/Qd
         jkbFXBrBzEXmn1/FnAtP6JaAs6aatZuQe3T3pw/sT8w1g1ma8ExNoVPvmeuGl/7QKAvu
         Z08AKT5/o4h1LCpo/jsCYs3wy3furxR0pfFl2Qq/uLz+/13d7adoOnk8/b+22+EJpIdc
         ubF8E3hc4Pt5d1nhe7T1qo4AZMKDoWQmedLRgFPPUqxVIiNEDql/3j1sOKja35m1wchG
         dApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jYGkig7dhsHe04Q4eAR+F8yFyd+WR3pP/6SIXuolRPo=;
        b=Kr/9bgllqmKk1bPt3+Q5bzDe9RcAf41Ig5iBoGl0OZoM42oFvrqY0u4ZNdpiRFKFlh
         g1jdSZFhlr6/2F2O+4GA1/5S30GwZMI7Mt2e309FBa8UiQGmoOXaeVRgoTjPVGk9Qr6e
         U+XosvDsSW/nhpAqTf4qS+5IK8Aoc0xyE022A3sFSrIrzje9Rw9JYCx6LF4JQhbHcdpU
         0t8mc+uCuFc1jY6MyF7otroMIXHv5eDVqhQ9ntUwOnHNs+SBi8F4kLZSiX1NHCaONiJS
         mV0V/V1l27UobSnrWAA23KeutHb/Qd14W3GBzeTnh2Sw4wZBkw5Mu5ALiFaYjY5PK/TW
         kShw==
X-Gm-Message-State: AJIora8+SKaQTkr7XcABCdkk1FXsKyzRvFjsPpxPqDZ956W3Olwkb8dj
        Wc40ZHTaDXb/iym6ixXJ8uoXt02KQvI=
X-Google-Smtp-Source: AGRyM1sScqIrR5DlNpLiU23T4ez1FisZvs+cPlSaS73sE9j2yTKrQvyuIeHYjsPwiV1OgINg2+xSeQ==
X-Received: by 2002:adf:f5c7:0:b0:21d:7f20:7508 with SMTP id k7-20020adff5c7000000b0021d7f207508mr4147733wrp.458.1657297521528;
        Fri, 08 Jul 2022 09:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003a2d6f26babsm2695852wmo.3.2022.07.08.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:25:20 -0700 (PDT)
Message-Id: <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 16:25:15 +0000
Subject: [PATCH v2 0/4] xdiff: introduce memory allocation macros
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces macros for allocating and growing arrays in
xdiff. The macros are similar to ALLOC_ARRAY()/ALLOC_GROW() from the rest of
the code base but return an error on failure to allow libgit2 to handle
memory allocation failures gracefully rather than dying. The macros
introduce overflow checks but these checks are currently redundant as we
limit the maximum file size passed to xdiff and these checks alone are
insufficient to safely remove the size limit. The aim of this series is to
make the xdiff code more readable, there should be no change in behavior (as
such I'm open to the argument that these are just churn and should be
dropped).

Thanks to Junio and Ævar the feedback on V1 Changes since V1:

 * Patch 2: new, it replaces xdl_malloc() followed by memset() with
   xdl_calloc() as suggested by Junio
 * Patch 3: simplified by the new patch 2, the end result is unchanged
 * Patch 4: added a note to the commit message explaining the choice to use
   long rather than size_t

Phillip Wood (4):
  xdiff: introduce XDL_ALLOC_ARRAY()
  xdiff: introduce xdl_calloc
  xdiff: introduce XDL_CALLOC_ARRAY()
  xdiff: introduce XDL_ALLOC_GROW()

 xdiff/xdiff.h      |  1 +
 xdiff/xdiffi.c     |  2 +-
 xdiff/xhistogram.c | 19 ++++++-------------
 xdiff/xmacros.h    | 18 ++++++++++++++++++
 xdiff/xpatience.c  |  9 +++------
 xdiff/xprepare.c   | 41 ++++++++++++-----------------------------
 xdiff/xutils.c     | 17 +++++++++++++++++
 xdiff/xutils.h     |  3 ++-
 8 files changed, 60 insertions(+), 50 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1272%2Fphillipwood%2Fwip%2Fxdiff-memory-allocation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1272/phillipwood/wip/xdiff-memory-allocation-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1272

Range-diff vs v1:

 1:  55fd62dc27d = 1:  55fd62dc27d xdiff: introduce XDL_ALLOC_ARRAY()
 2:  8bead9856be ! 2:  ea8993a57ef xdiff: introduce XDL_CALLOC_ARRAY()
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    xdiff: introduce XDL_CALLOC_ARRAY()
     +    xdiff: introduce xdl_calloc
      
     -    Add a helper for allocating an array and initialize the elements to
     -    zero. This is analogous to CALLOC_ARRAY() in the rest of the codebase
     -    but it returns NULL on allocation failures rather than dying to
     -    accommodate other users of libxdiff such as libgit2.
     +    In preparation for introducing XDL_CALLOC_ARRAY() use calloc() to
     +    obtain zeroed out memory rather than malloc() followed by memset(). To
     +    try and keep the lines a reasonable length this commit also stops
     +    casting the pointer returned by calloc() as this is unnecessary.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     + ## xdiff/xdiff.h ##
     +@@ xdiff/xdiff.h: typedef struct s_bdiffparam {
     + 
     + 
     + #define xdl_malloc(x) xmalloc(x)
     ++#define xdl_calloc(n, sz) xcalloc(n, sz)
     + #define xdl_free(ptr) free(ptr)
     + #define xdl_realloc(ptr,x) xrealloc(ptr,x)
     + 
     +
       ## xdiff/xhistogram.c ##
      @@ xdiff/xhistogram.c: static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
       		    int line1, int count1, int line2, int count2)
     @@ xdiff/xhistogram.c: static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
      -	sz *= sizeof(struct record *);
      -	if (!(index.records = (struct record **) xdl_malloc(sz)))
      +	index.records_size = 1 << index.table_bits;
     -+	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
     ++	if (!(index.records = xdl_calloc(index.records_size,
     ++					 sizeof(*index.records))))
       		goto cleanup;
      -	memset(index.records, 0, sz);
       
     @@ xdiff/xhistogram.c: static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
      -	sz *= sizeof(struct record *);
      -	if (!(index.line_map = (struct record **) xdl_malloc(sz)))
      +	index.line_map_size = count1;
     -+	if (!XDL_CALLOC_ARRAY(index.line_map, index.line_map_size))
     ++	if (!(index.line_map = xdl_calloc(index.line_map_size,
     ++					  sizeof(*index.line_map))))
       		goto cleanup;
      -	memset(index.line_map, 0, sz);
       
      -	sz = index.line_map_size;
      -	sz *= sizeof(unsigned int);
      -	if (!(index.next_ptrs = (unsigned int *) xdl_malloc(sz)))
     -+	if (!XDL_CALLOC_ARRAY(index.next_ptrs, index.line_map_size))
     ++	if (!(index.next_ptrs = xdl_calloc(index.line_map_size,
     ++					   sizeof(*index.next_ptrs))))
       		goto cleanup;
      -	memset(index.next_ptrs, 0, sz);
       
       	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
       	if (xdl_cha_init(&index.rcha, sizeof(struct record), count1 / 4 + 1) < 0)
      
     - ## xdiff/xmacros.h ##
     -@@ xdiff/xmacros.h: do { \
     - 		? xdl_malloc((nr) * sizeof(*(p)))	\
     - 		: NULL)
     - 
     -+/* Allocate an array of nr zeroed out elements, returns NULL on failure */
     -+#define XDL_CALLOC_ARRAY(p, nr)				\
     -+	(XDL_ALLOC_ARRAY((p), (nr))			\
     -+		? memset((p), 0, (nr) * sizeof(*(p)))	\
     -+		: NULL)
     -+
     - #endif /* #if !defined(XMACROS_H) */
     -
       ## xdiff/xpatience.c ##
      @@ xdiff/xpatience.c: static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
       
     @@ xdiff/xpatience.c: static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
       	result->alloc = count1 * 2;
      -	result->entries = (struct entry *)
      -		xdl_malloc(result->alloc * sizeof(struct entry));
     --	if (!result->entries)
     -+	if (!XDL_CALLOC_ARRAY(result->entries, result->alloc))
     ++	result->entries = xdl_calloc(result->alloc, sizeof(*result->entries));
     + 	if (!result->entries)
       		return -1;
      -	memset(result->entries, 0, result->alloc * sizeof(struct entry));
       
     @@ xdiff/xprepare.c: static int xdl_init_classifier(xdlclassifier_t *cf, long size,
       		return -1;
       	}
      -	if (!(cf->rchash = (xdlclass_t **) xdl_malloc(cf->hsize * sizeof(xdlclass_t *)))) {
     -+	if (!XDL_CALLOC_ARRAY(cf->rchash, cf->hsize)) {
     ++	if (!(cf->rchash = xdl_calloc(cf->hsize, sizeof(*cf->rchash)))) {
       
       		xdl_cha_free(&cf->ncha);
       		return -1;
     @@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, lo
       	hbits = xdl_hashbits((unsigned int) narec);
       	hsize = 1 << hbits;
      -	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
     -+	if (!XDL_CALLOC_ARRAY(rhash, hsize))
     ++	if (!(rhash = xdl_calloc(hsize, sizeof(*rhash))))
       		goto abort;
      -	memset(rhash, 0, hsize * sizeof(xrecord_t *));
       
     @@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, lo
       	}
       
      -	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char))))
     -+	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
     ++	if (!(rchg = xdl_calloc((nrec + 2), sizeof(*rchg))))
       		goto abort;
      -	memset(rchg, 0, (nrec + 2) * sizeof(char));
       
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       	char *dis, *dis1, *dis2;
       
      -	if (!(dis = (char *) xdl_malloc(xdf1->nrec + xdf2->nrec + 2))) {
     --
     -+	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
     ++	if (!(dis = xdl_calloc(xdf1->nrec + xdf2->nrec + 2, sizeof(*dis)))) {
     + 
       		return -1;
     --	}
     + 	}
      -	memset(dis, 0, xdf1->nrec + xdf2->nrec + 2);
       	dis1 = dis;
       	dis2 = dis1 + xdf1->nrec + 1;
 -:  ----------- > 3:  5490fd22579 xdiff: introduce XDL_CALLOC_ARRAY()
 3:  da996677f07 ! 4:  8c24cd7737b xdiff: introduce XDL_ALLOC_GROW()
     @@ Commit message
          of adding a small amount to the new allocation to avoid a lot of
          reallocations at small sizes.
      
     +    Note that xdl_alloc_grow_helper() uses long rather than size_t for
     +    `nr` and `alloc` to match the existing code.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## xdiff/xmacros.h ##
      @@ xdiff/xmacros.h: do { \
     - 		? memset((p), 0, (nr) * sizeof(*(p)))	\
     - 		: NULL)
     + /* Allocate an array of nr zeroed out elements, returns NULL on failure */
     + #define XDL_CALLOC_ARRAY(p, nr)	((p) = xdl_calloc(nr, sizeof(*(p))))
       
      +/*
      + * Ensure array p can accommodate at least nr elements, growing the

-- 
gitgitgadget

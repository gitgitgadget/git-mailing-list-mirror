Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99E18E3F
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926525; cv=none; b=dXr7NVzat25z/0yRLYoIyi3CPcINGs3PUksgHpk/5AJvHz1rWQSqyDJuWykyPMQJVmns7iDS3N+R4P2mLQyOhpzUEQGO8tYPjfbXkqotyjjqBAqhn400vg9uUI+aC2pnjWOUhztCXC5ng5xnO4RZBWf4z47jH/O7EoeQSm6GEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926525; c=relaxed/simple;
	bh=2g8MErdIe+HAZ9KrzGnqeNvc3fUUdlyD8CDI8ex5qS0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=amXgU1gEakQN8L3UpZ5BZ0IU0pzWIwvGSAUvyGsQz03bFMpF/FvdC8DQvMUmCU4Yqrw8Lxi9puRw04HHqR+dmZRB96+WkfHnrmYg4h1wszgzRwx54votiW0imWWKesesthK0R26AS4BF/oprOEgwuA+fdIE1RZ/StdgzfJ8mc84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMN6wbGk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMN6wbGk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55562f3130so1940140a12.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926522; x=1759531322; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tme6D7LwhT3vc1KyNy/Lp8t5iUpfE8vXlI2D38Qlk2k=;
        b=CMN6wbGkb1lr5ydRtaxS742L9NdwPJCHffR4NC6+4A6ZOPLeXmQVsCnxhNcdYtaQQn
         Tox/FnaSdN1rzJpirf+JeI/tXrUngUmnRXYHRoWIi1xhR/EikFrwKqn6GIhVJTWZdcPc
         cJtBwWAmmIacCFuBCe6G0f3G5YtCiVZPJ9Vz2wb/Xg50UkxKwYDVK9Vzv1/hny9PXVC7
         e/cMG8bR8Q2JMFfn15WnZU4SDSq/lrojcclDa4NiltVvZPXWHoqh81qqek9rDvLhuBfK
         dpZetYipSWlBkidhR4YKyIkpYv31eDOLT05O90HMU3MCl61JNsReva5WezjDY0QDfbCY
         /lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926522; x=1759531322;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tme6D7LwhT3vc1KyNy/Lp8t5iUpfE8vXlI2D38Qlk2k=;
        b=bipCImaXq7DxRtp3V/FpYxM/Mm4o/TGdYK1OmBcSEX5LqY7pLDVRrQYdW9POOFEyJ0
         z5+ifKgfT/4mhieSVZOhr9SWo59gRoF1rxXtwDE62UUuWzQ3sDQA7LnbIHA7XCxx7iR+
         pffZlotkpMla4tc/SdZumJIOOqQclndKhXp/OF6EesR8LLCZ2R0oCSxQ0KHXDXdMos73
         rvpagb335ge434FgzQPlm1KbcV+qp4DJxPR94Sdlfcwe5eOX+bqckISZ4YpA3JC+GSv8
         WXvYbiGjZ4o3TF0DXTSb1qcYSb6YYxm51WGcRlJGIfTbKWqIkstrBnWplvJksXxxpp3z
         DyjA==
X-Gm-Message-State: AOJu0YzLLlxwM1+lRQP7fxebdaxQcnyvcfho/2H6h7hBqE531c2HXArN
	m6Ek8q1mWlnWHeb3sxRcHNDCPzcKfrH4rrhGecy4s7H+mmo3jfW9NpymBU5eNA==
X-Gm-Gg: ASbGncvgwYRULEW+iwKRIxO5kLEo/coAqL8a3gndBSst9BNMtFYQfiDhJjvvZl81cMl
	gumPq3jKXmzKv4R3/EZYeuvmONbfKTj8dgHl2F1H7Fe+j1D/Eq5DOqhpUWKmp1ALB5FKazGNovb
	x6W3idafePMjeP4szbBqmJFRcIuC1cNULDaDxUZLFpw2ESv7yXuklz8N+IiMpClYZSq7VvO8xI4
	iyMFOWVDdBOqFsIh7lOxpZzu81kY0ta5yvKtNx8g3uRB5xVTZVy4Q2KVM3TfdXvBF9VkpAUi2b7
	XVRE82GTu3RFsNvpDOFvV7V98sWRhsSoHg3L/u9Shz2lmq84R4FsCPlcCZDc+UuoCFocvgTjSc5
	2Zz5SrTQOMW9tbDWv5aJzOG0HKTDDXjAeMyc=
X-Google-Smtp-Source: AGHT+IE90rHMOmfZddbWcYrlmzqTIDxFihXUuh26lUUzETc4ZnKIXxMXC0zkunNM/UIbCDl1e64r/w==
X-Received: by 2002:a17:90b:3882:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-3342a2d2459mr10487213a91.26.1758926521430;
        Fri, 26 Sep 2025 15:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be1474asm9996448a91.17.2025.09.26.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:00 -0700 (PDT)
Message-Id: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:47 +0000
Subject: [PATCH v6 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
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

Changes since v5.

 * Address review feedback on commit messages.
 * Drop commit "xdiff: delete rchg aliasing"
 * Use DISCARD/KEEP/INVESTIGATE instead of NONE/SOME/TOO_MANY
 * Fix the word wrapping in the comments of xprepare.c

Cleanup of the functions xdl_cleanup_records() and xdl_clean_mmatch() is out
of scope for this patch series. The changes to them are incidental to
explaining why 'char rchg' is refactored to 'bool changed'.

Changes since v4.

 * Make it clear that the field xdfile_t.rchg (now 'xdfile_t.changed') is
   distinct from the local variables dis1, dis2 (now 'matches1',
   'matches2').
 * Use NONE, SOME, TOO_MANY instead of NO, YES, MAYBE.
 * Use bool literals for xdfile_t.changed.

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
	bool *changed;
	long *rindex;
	long nreff;
} xdfile_t;


===

Ezekiel Newren (12):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete superfluous function xdl_get_rec() in xemit
  xdiff: delete local variables that alias fields in xrecord_t
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t
  xdiff: rename rchg -> changed in xdfile_t
  xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
  xdiff: change type of xdfile_t.changed from char to bool

 xdiff/xdiffi.c     | 102 ++++++-------
 xdiff/xdiffi.h     |  11 +-
 xdiff/xemit.c      |  38 ++---
 xdiff/xhistogram.c |  10 +-
 xdiff/xmerge.c     |  56 ++++----
 xdiff/xpatience.c  |  18 +--
 xdiff/xprepare.c   | 346 ++++++++++++++++++++-------------------------
 xdiff/xtypes.h     |   9 +-
 xdiff/xutils.c     |  16 +--
 9 files changed, 269 insertions(+), 337 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v6
Pull-Request: https://github.com/git/git/pull/2048

Range-diff vs v5:

  1:  890e508000 =  1:  890e508000 xdiff: delete static forward declarations in xprepare
  2:  0cfd75b1ff =  2:  0cfd75b1ff xdiff: delete local variables and initialize/free xdfile_t directly
  3:  92c81d2ff6 =  3:  92c81d2ff6 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  4:  7d3a7e617c =  4:  7d3a7e617c xdiff: delete superfluous function xdl_get_rec() in xemit
  5:  1d550cf308 !  5:  7a9380328e xdiff: delete superfluous local variables that alias fields in xrecord_t
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: delete superfluous local variables that alias fields in xrecord_t
     +    xdiff: delete local variables that alias fields in xrecord_t
      
          Use the type xrecord_t as the local variable for the functions in the
     -    file xdiff/xemit.c.
     +    file xdiff/xemit.c. Most places directly reference the fields inside of
     +    this struct, doing that here makes it more consistent with the rest of
     +    the code.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
  6:  2a3a1b657e !  6:  6dce41cd3d xdiff: delete struct diffdata_t
     @@ Commit message
          diffdata_t.rindex -> xdfile_t.rindex
          diffdata_t.rchg   -> xdfile_t.rchg
      
     +    I think this struct existed before xdfile_t, and was kept for backward
     +    compatibility reasons. I think xdiffi should have been refactored to
     +    use the new (xdfile_t) struct, but was easier to alias it instead.
     +
     +    The local variables rchg* and rindex* don't shorten the lines by much,
     +    nor do they really need to be there to make the code more readable.
     +    Delete them.
     +
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
  7:  4c6543cbe3 =  7:  637d1032ab xdiff: delete redundant array xdfile_t.ha
  8:  21bf4b5a20 =  8:  738daab090 xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
  9:  ef6ae7d29c =  9:  59b00b63b8 xdiff: delete chastore from xdfile_t
 10:  7b0856108a <  -:  ---------- xdiff: delete rchg aliasing
 11:  570ab9f898 ! 10:  5702ca6912 xdiff: rename rchg -> changed in xdfile_t
     @@ Metadata
       ## Commit message ##
          xdiff: rename rchg -> changed in xdfile_t
      
     +    The field rchg (now 'changed') declares if a line in a file is changed
     +    or not. A later commit will change it's type from 'char' to 'bool'
     +    to make its purpose even more clear.
     +
          Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       			g->start--;
       
       		return 0;
     -@@ xdiff/xdiffi.c: int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
     +@@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
     + 
     + int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
     + 	xdchange_t *cscr = NULL, *xch;
     +-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
     ++	char *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
     + 	long i1, i2, l1, l2;
     + 
     + 	/*
       	 * Trivial. Collects "groups" of changes and creates an edit script.
       	 */
       	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
     --		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
     --			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
     --			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
     -+		if (xe->xdf1.changed[i1 - 1] || xe->xdf2.changed[i2 - 1]) {
     -+			for (l1 = i1; xe->xdf1.changed[i1 - 1]; i1--);
     -+			for (l2 = i2; xe->xdf2.changed[i2 - 1]; i2--);
     +-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
     +-			for (l1 = i1; rchg1[i1 - 1]; i1--);
     +-			for (l2 = i2; rchg2[i2 - 1]; i2--);
     ++		if (changed1[i1 - 1] || changed2[i2 - 1]) {
     ++			for (l1 = i1; changed1[i1 - 1]; i1--);
     ++			for (l2 = i2; changed2[i2 - 1]; i2--);
       
       			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
       				xdl_free_script(cscr);
 12:  08a0fceb72 ! 11:  f08782a977 xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
     +    xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
      
     -    Rename dis1, dis2 to matches1, matches2.
     +    This commit is refactor-only; no behavior is changed. A future commit
     +    will use bool literals for changed[i].
      
     -    Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
     -    matches1 and matches2. These states will influence whether changed[i]
     -    is set to 1 or kept as 0.
     +    The functions xdl_clean_mmatch() and xdl_cleanup_records() will be
     +    cleaned up more in a future patch series. The changes to
     +    xdl_cleanup_records(), in this patch, is just to make it clear why
     +    `char rchg` is refactored to `bool changed`.
     +
     +    Rename dis* to action* and replace literal numericals with macros.
     +    The old names came from when dis* (which I think was short for discard)
     +    was treated like a boolean, but over time it grew into a ternary state
     +    machine. The result was confusing because dis* and rchg* both used 0/1
     +    values with different meanings.
     +
     +    The new names and macros make the states explicit. nm is short for
     +    number of matches, and mlim is a heuristic limit:
     +
     +      nm == 0       -> action[i] = DISCARD     -> changed[i] = true
     +      0 < nm < mlim -> action[i] = KEEP        -> changed[i] = false
     +      nm >= mlim    -> action[i] = INVESTIGATE -> changed[i] = xdl_clean_mmatch()
     +
     +    When need_min is true, only DISCARD and KEEP occur because the limit
     +    is effectively infinite.
      
          Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
     @@ xdiff/xprepare.c
       #define XDL_GUESS_NLINES1 256
       #define XDL_GUESS_NLINES2 20
       
     -+#define NONE 0
     -+#define SOME 1
     -+#define TOO_MANY 2
     ++#define DISCARD 0
     ++#define KEEP 1
     ++#define INVESTIGATE 2
       
       typedef struct s_xdlclass {
       	struct s_xdlclass *next;
     @@ xdiff/xprepare.c: void xdl_free_env(xdfenv_t *xe) {
       
       
      -static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
     -+static bool xdl_clean_mmatch(uint8_t const *matches, long i, long s, long e) {
     ++static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
       	long r, rdis0, rpdis0, rdis1, rpdis1;
       
       	/*
      -	 * Limits the window the is examined during the similar-lines
      -	 * scan. The loops below stops when dis[i - r] == 1 (line that
     +-	 * has no match), but there are corner cases where the loop
     +-	 * proceed all the way to the extremities by causing huge
     +-	 * performance penalties in case of big files.
      +	 * Limits the window that is examined during the similar-lines
     -+	 * scan. The loops below stops when matches[i - r] == SOME (line that
     - 	 * has no match), but there are corner cases where the loop
     - 	 * proceed all the way to the extremities by causing huge
     - 	 * performance penalties in case of big files.
     ++	 * scan. The loops below stops when action[i - r] == KEEP
     ++	 * (line that has no match), but there are corner cases where
     ++	 * the loop proceed all the way to the extremities by causing
     ++	 * huge performance penalties in case of big files.
     + 	 */
     + 	if (i - s > XDL_SIMSCAN_WINDOW)
     + 		s = i - XDL_SIMSCAN_WINDOW;
      @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
       
       	/*
       	 * Scans the lines before 'i' to find a run of lines that either
      -	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
      -	 * Note that we always call this function with dis[i] > 1, so the
     -+	 * have no match (matches[j] == NONE) or have multiple matches (matches[j] == TOO_MANY).
     -+	 * Note that we always call this function with matches[i] == TOO_MANY, so the
     - 	 * current line (i) is already a multimatch line.
     +-	 * current line (i) is already a multimatch line.
     ++	 * have no match (action[j] == DISCARD) or have multiple matches
     ++	 * (action[j] == INVESTIGATE). Note that we always call this
     ++	 * function with action[i] == INVESTIGATE, so the current line
     ++	 * (i) is already a multimatch line.
       	 */
       	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
      -		if (!dis[i - r])
     -+		if (matches[i - r] == NONE)
     ++		if (action[i - r] == DISCARD)
       			rdis0++;
      -		else if (dis[i - r] == 2)
     -+		else if (matches[i - r] == TOO_MANY)
     ++		else if (action[i - r] == INVESTIGATE)
       			rpdis0++;
      -		else
     -+		else if (matches[i - r] == SOME)
     ++		else if (action[i - r] == KEEP)
       			break;
      +		else
     -+			BUG("Illegal value for matches[i - r]");
     ++			BUG("Illegal value for action[i - r]");
       	}
       	/*
     - 	 * If the run before the line 'i' found only multimatch lines, we
     +-	 * If the run before the line 'i' found only multimatch lines, we
      -	 * return 0 and hence we don't make the current line (i) discarded.
     -+	 * return false and hence we don't make the current line (i) discarded.
     - 	 * We want to discard multimatch lines only when they appear in the
     +-	 * We want to discard multimatch lines only when they appear in the
      -	 * middle of runs with nomatch lines (dis[j] == 0).
     -+	 * middle of runs with nomatch lines (matches[j] == NONE).
     ++	 * If the run before the line 'i' found only multimatch lines,
     ++	 * we return false and hence we don't make the current line (i)
     ++	 * discarded. We want to discard multimatch lines only when
     ++	 * they appear in the middle of runs with nomatch lines
     ++	 * (action[j] == DISCARD).
       	 */
       	if (rdis0 == 0)
       		return 0;
       	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
      -		if (!dis[i + r])
     -+		if (matches[i + r] == NONE)
     ++		if (action[i + r] == DISCARD)
       			rdis1++;
      -		else if (dis[i + r] == 2)
     -+		else if (matches[i + r] == TOO_MANY)
     ++		else if (action[i + r] == INVESTIGATE)
       			rpdis1++;
      -		else
     -+		else if (matches[i + r] == SOME)
     ++		else if (action[i + r] == KEEP)
       			break;
      +		else
     -+			BUG("Illegal value for matches[i + r]");
     ++			BUG("Illegal value for action[i + r]");
       	}
       	/*
     - 	 * If the run after the line 'i' found only multimatch lines, we
     +-	 * If the run after the line 'i' found only multimatch lines, we
      -	 * return 0 and hence we don't make the current line (i) discarded.
     -+	 * return false and hence we don't make the current line (i) discarded.
     ++	 * If the run after the line 'i' found only multimatch lines,
     ++	 * we return false and hence we don't make the current line (i)
     ++	 * discarded.
       	 */
       	if (rdis1 == 0)
      -		return 0;
     @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, l
       	xdlclass_t *rcrec;
      -	char *dis, *dis1, *dis2;
      -	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     -+	uint8_t *matches1, *matches2;
     -+	int status = 0;
     ++	uint8_t *action1 = NULL, *action2 = NULL;
      +	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     ++	int ret = 0;
       
      -	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
      -		return -1;
      -	dis1 = dis;
      -	dis2 = dis1 + xdf1->nrec + 1;
     -+	matches1 = NULL;
     -+	matches2 = NULL;
     -+
      +	/*
      +	 * Create temporary arrays that will help us decide if
      +	 * changed[i] should remain 0 or become 1.
      +	 */
     -+	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
     -+		status = -1;
     ++	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
     ++		ret = -1;
      +		goto cleanup;
      +	}
     -+	if (!XDL_CALLOC_ARRAY(matches2, xdf2->nrec + 1)) {
     -+		status = -1;
     ++	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
     ++		ret = -1;
      +		goto cleanup;
      +	}
       
      +	/*
     -+	 * Initialize temporary arrays with NONE, SOME, or TOO_MANY.
     ++	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
      +	 */
       	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
       		mlim = XDL_MAX_EQLIMIT;
     @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, l
       		rcrec = cf->rcrecs[recs->ha];
       		nm = rcrec ? rcrec->len2 : 0;
      -		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
     -+		matches1[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
     ++		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
       	}
       
       	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       		rcrec = cf->rcrecs[recs->ha];
       		nm = rcrec ? rcrec->len1 : 0;
      -		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
     -+		matches2[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
     ++		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
       	}
       
      +	/*
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       	     i <= xdf1->dend; i++, recs++) {
      -		if (dis1[i] == 1 ||
      -		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
     -+		if (matches1[i] == SOME ||
     -+		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
     ++		if (action1[i] == KEEP ||
     ++		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
       			xdf1->rindex[nreff++] = i;
     -+			/* changed[i] remains 0 */
     ++			/* changed[i] remains 0, i.e. keep */
       		} else
       			xdf1->changed[i] = 1;
     ++			/* i.e. discard */
       	}
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     + 	xdf1->nreff = nreff;
       
       	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
       	     i <= xdf2->dend; i++, recs++) {
      -		if (dis2[i] == 1 ||
      -		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
     -+		if (matches2[i] == SOME ||
     -+		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
     ++		if (action2[i] == KEEP ||
     ++		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
       			xdf2->rindex[nreff++] = i;
     -+			/* changed[i] remains 0 */
     ++			/* changed[i] remains 0, i.e. keep */
       		} else
       			xdf2->changed[i] = 1;
     ++			/* i.e. discard */
       	}
       	xdf2->nreff = nreff;
       
      -	xdl_free(dis);
      +cleanup:
     -+	xdl_free(matches1);
     -+	xdl_free(matches2);
     ++	xdl_free(action1);
     ++	xdl_free(action2);
       
      -	return 0;
     -+	return status;
     ++	return ret;
       }
       
       
 13:  975e845bfa ! 12:  83e1ace5bd xdiff: change type of xdfile_t.changed from char to bool
     @@ Commit message
          xdiff: change type of xdfile_t.changed from char to bool
      
          The only values possible for 'changed' is 1 and 0, which exactly maps
     -    to a bool type. It might not look like this is the case because
     -    matches1 and matches2 (which use to be dis1, and dis2) were also char
     -    and were assigned numerical values within a few lines of 'changed'
     -    (what used to be rchg).
     +    to a bool type. It might not look like this because action1 and action2
     +    (which use to be dis1, and dis2) were also of type char and were
     +    assigned numerical values within a few lines of 'changed' (what used to
     +    be rchg).
      
     -    Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
     +    Using DISCARD/KEEP/INVESTIGATE for action1[i]/action2[j], and true/false
          for changed[k] makes it clear to future readers that these are
          logically separate concepts.
      
     @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       
       		while (xdf->changed[g->start - 1])
       			g->start--;
     +@@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
     + 
     + int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
     + 	xdchange_t *cscr = NULL, *xch;
     +-	char *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
     ++	bool *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
     + 	long i1, i2, l1, l2;
     + 
     + 	/*
      
       ## xdiff/xhistogram.c ##
      @@ xdiff/xhistogram.c: redo:
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      -	 * changed[i] should remain 0 or become 1.
      +	 * changed[i] should remain false, or become true.
       	 */
     - 	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
     - 		status = -1;
     + 	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
     + 		ret = -1;
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
       
       	/*
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       	 */
       	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
       	     i <= xdf1->dend; i++, recs++) {
     - 		if (matches1[i] == SOME ||
     - 		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
     + 		if (action1[i] == KEEP ||
     + 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
       			xdf1->rindex[nreff++] = i;
     --			/* changed[i] remains 0 */
     -+			/* changed[i] remains false */
     +-			/* changed[i] remains 0, i.e. keep */
     ++			/* changed[i] remains false, i.e. keep */
       		} else
      -			xdf1->changed[i] = 1;
      +			xdf1->changed[i] = true;
     + 			/* i.e. discard */
       	}
       	xdf1->nreff = nreff;
     - 
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		if (matches2[i] == SOME ||
     - 		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
     + 		if (action2[i] == KEEP ||
     + 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
       			xdf2->rindex[nreff++] = i;
     --			/* changed[i] remains 0 */
     -+			/* changed[i] remains false */
     +-			/* changed[i] remains 0, i.e. keep */
     ++			/* changed[i] remains false, i.e. keep */
       		} else
      -			xdf2->changed[i] = 1;
      +			xdf2->changed[i] = true;
     + 			/* i.e. discard */
       	}
       	xdf2->nreff = nreff;
     - 
      
       ## xdiff/xtypes.h ##
      @@ xdiff/xtypes.h: typedef struct s_xdfile {

-- 
gitgitgadget

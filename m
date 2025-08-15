Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DE1E8337
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220994; cv=none; b=KzK+F4EuC8wJgBvXl1MWLr2kiD424EM5oNQUUf0VYg7iZcotuLRYxYej7BcFBdiF4dorOwky7uqphj+4TaRyzVAaUAD28kTe2OhKLR897mEJaiCLaVk+8d2pPoFYmMtY40oH6yypjVcUQnRpVkzDZGn8b9ihbegeQdvaTH7MH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220994; c=relaxed/simple;
	bh=CPdNFEA5vxVhBcV9du1nSo1tOlplI0Zdxhu8d7896e4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O5yniL+bG6oRs6L+YjxEXZwKRfHCTYvpJglHTVO3T/ogeaeVm+NXgnR05Q+iUvBMIpkvd9OaUcXnOrkbosPVMYvlSmKW6446JvLKLcsRSOwmk+/hC/6GC5h9w271KsV2Y3LaGXR2yAcxHc3/SNAOGZ/3x68u/z4U/gYq4WG+Zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBJ4xTOT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBJ4xTOT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0b6ac4so7564005e9.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220991; x=1755825791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwh7+nmIAd0F9VVWB/db7tzfuVvcEutPizdAS0aReFU=;
        b=dBJ4xTOTQKCzJwrSAY1CYwowrnPT5Ju+hj/DMlj2Uie7ip9/4mSY8PamVaqQI+W5lp
         Vt5lgtEWpBn0ILTRaC+fEzgwAlG1c6ljsjUi+8DxBsfRCQPuJ6NzWvfljf/h3N6p0648
         aKrWhsHy6eMmkqPKhHh+ZxgdiKgHJs9S9KjAdwyoabUsdLhaj9t9i5C+Hj2GceYfPmN9
         tG7UfnhPFlD1IroRCGsY6vO8tDjnp0PqEHm3hEmtxTilb1vc8/415ZmAdLcICAZ42brX
         YCqthYhpuv3YvGPoJ80QXkbHfHzz2R20q1KLOpqxV6hHvIW5I4ZAc4V5aeGaP8trcm3w
         MOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220991; x=1755825791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zwh7+nmIAd0F9VVWB/db7tzfuVvcEutPizdAS0aReFU=;
        b=geYwLGsM3uV5tAFtduuwC/HmOTGypDEFT7R3+AuNeTrGBcjeYDVxKnJxLZSJ31gxHF
         kZvNSYbdHXQKXhad2Cmnts7WoPUUCQzSZEurAZv8VXoa9QDqHMl0DWow5pwRUKS/FcSv
         jkqxiFBuggdCxDSCFiWBlcChP86/gUG81+UX4X5o1GRLtJXXcUP9XrRAJGg79w4vaRzV
         8fM9wBC5g7/foVu+3byN4vJbt5A1rgC/HIE92TV/2bcZDF7GocsYfnKEWRsJUffIfzGD
         nZLelQi7JrwJ+WXtu9/XVHWegNx8Y3N8U0OQoEAoh/tVhaOEd/zrChOkt4eRCqrjgDW8
         8bkw==
X-Gm-Message-State: AOJu0YyOo4ZVt+plZ9wqweraz6NMe9fXQgk746QykWL7/0YDSFBulg+m
	RhokQEjynQw5IzbtEQz5wDgQ8x+ephkGXgaEGuk7v+asII5giHZQw6u56/BbAw==
X-Gm-Gg: ASbGncu/xO/0bt9eMMhjalnMYpJT7ga5XaXghLLnUjAJvYox8zwH4HkyYKULEb1goY4
	+pP7saC9UjoK7TGWvodjvi4v2qB0UwtoSYS6rzHOoWE+OzvtiLRYHDOXJ6xfzcull7n6D7DfXXo
	yuHUMD8wV33gpFPYeWRzNPTYpCBA8/R+gVZsmqNHmrvb760N7UnJrjTaIn11VDYDsXHQRtUKImS
	N1Im1TelwxYx6N7CBigEDh4ls1l70J9eHxI0QX65zv2s5J7rXbcnIpmB4itFVIsHO4uEXNDR3Hn
	5nR9vl/VGdAAFYjR/IzbPDqL3N2BuicTU19L6yTdhqRQrjBfqKJksLcN34a57MN2aV5fKNpH3n0
	SF+KQW810qBcpqndmayOt7ZWExO543Pn+sg==
X-Google-Smtp-Source: AGHT+IEWiJFF3SbY0E7jBI3hTHkOUjU0C2VEFgwGHjmnTnHV85fZ+CDtLsQAf4mIcx6sHHiOA8fOPg==
X-Received: by 2002:a05:600c:4f89:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-45a21858902mr3539275e9.16.1755220990776;
        Thu, 14 Aug 2025 18:23:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a220e96a6sm472275e9.8.2025.08.14.18.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:10 -0700 (PDT)
Message-Id: <395609aff4bc32e09c48204cdc2974e614675297.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:52 +0000
Subject: [PATCH v2 17/17] xdiff: use rust's version of whitespace processing
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Delete xdl_hash_record() and xdl_recmatch() in favor of xdl_line_hash()
and xdl_line_equal().

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/lib.rs |   6 --
 xdiff-interface.c     |   4 +-
 xdiff/xmerge.c        |   8 +--
 xdiff/xprepare.c      |  29 ++------
 xdiff/xutils.c        | 158 ------------------------------------------
 xdiff/xutils.h        |   4 +-
 6 files changed, 15 insertions(+), 194 deletions(-)

diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index 809c5573c6e7..634b453a21b6 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -14,12 +14,6 @@ pub const XDF_WHITESPACE_FLAGS: u64 = XDF_IGNORE_WHITESPACE |
     XDF_IGNORE_CR_AT_EOL;
 
 
-#[no_mangle]
-unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
-    let slice = std::slice::from_raw_parts(ptr, size);
-    xxhash_rust::xxh3::xxh3_64(slice)
-}
-
 #[no_mangle]
 unsafe extern "C" fn xdl_line_hash(ptr: *const u8, size: usize, flags: u64) -> u64 {
     let line = std::slice::from_raw_parts(ptr, size);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 1edcd319e6ef..71ddccf2cc15 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -299,13 +299,13 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 
 unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
 {
-	return xdl_hash_record(&s, s + len, flags);
+	return xdl_line_hash((u8 const*) s, len, flags);
 }
 
 int xdiff_compare_lines(const char *l1, long s1,
 			const char *l2, long s2, long flags)
 {
-	return xdl_recmatch(l1, s1, l2, s2, flags);
+	return xdl_line_equal((u8 const*) l1, s1, (u8 const*) l2, s2, flags);
 }
 
 int parse_conflict_style_name(const char *value)
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6fa6ea61a208..2f64651a839b 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 	xrecord_t **rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch((const char*) rec1[i]->ptr, rec1[i]->size,
-			(const char*) rec2[i]->ptr, rec2[i]->size, flags);
+		bool result = xdl_line_equal(rec1[i]->ptr, rec1[i]->size,
+			rec2[i]->ptr, rec2[i]->size, flags);
 		if (!result)
 			return -1;
 	}
@@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 
 static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 {
-	return xdl_recmatch((char const*) rec1->ptr, rec1->size,
-			    (char const*) rec2->ptr, rec2->size, flags);
+	return xdl_line_equal(rec1->ptr, rec1->size,
+			    rec2->ptr, rec2->size, flags);
 }
 
 /*
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c0463bacd94b..b9f12184b1bb 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -33,8 +33,8 @@
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
 	u64 ha;
-	char const *line;
-	long size;
+	u8 const *line;
+	usize size;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,15 +93,15 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
+	u8 const *line;
 	xdlclass_t *rcrec;
 
-	line = (char const*) rec->ptr;
+	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
 		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
-					(const char*) rec->ptr, rec->size, cf->flags))
+				xdl_line_equal(rcrec->line, rcrec->size,
+					rec->ptr, rec->size, cf->flags))
 			break;
 
 	if (!rcrec) {
@@ -160,9 +160,6 @@ static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
 }
 
 
-extern u64 xxh3_64(u8 const* ptr, usize size);
-
-
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned long *ha;
@@ -178,21 +175,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdl_parse_lines(mf, narec, xdf);
 
-	if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {
-		for (usize i = 0; i < (usize) xdf->nrec; i++) {
-			xrecord_t *rec = xdf->recs[i];
-			rec->ha = xxh3_64(rec->ptr, rec->size);
-		}
-	} else {
-		for (usize i = 0; i < (usize) xdf->nrec; i++) {
-			xrecord_t *rec = xdf->recs[i];
-			char const* dump = (char const*) rec->ptr;
-			rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
-		}
-	}
-
 	for (usize i = 0; i < (usize) xdf->nrec; i++) {
 		xrecord_t *rec = xdf->recs[i];
+		rec->ha = xdl_line_hash(rec->ptr, rec->size, xpp->flags);
 		xdl_classify_record(pass, cf, rec);
 	}
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 10e4f20b7c31..29e240eb138b 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -152,164 +152,6 @@ int xdl_blankline(const char *line, long size, long flags)
 	return (i == size);
 }
 
-/*
- * Have we eaten everything on the line, except for an optional
- * CR at the very end?
- */
-static int ends_with_optional_cr(const char *l, long s, long i)
-{
-	int complete = s && l[s-1] == '\n';
-
-	if (complete)
-		s--;
-	if (s == i)
-		return 1;
-	/* do not ignore CR at the end of an incomplete line */
-	if (complete && s == i + 1 && l[i] == '\r')
-		return 1;
-	return 0;
-}
-
-int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
-{
-	int i1, i2;
-
-	if (s1 == s2 && !memcmp(l1, l2, s1))
-		return 1;
-	if (!(flags & XDF_WHITESPACE_FLAGS))
-		return 0;
-
-	i1 = 0;
-	i2 = 0;
-
-	/*
-	 * -w matches everything that matches with -b, and -b in turn
-	 * matches everything that matches with --ignore-space-at-eol,
-	 * which in turn matches everything that matches with --ignore-cr-at-eol.
-	 *
-	 * Each flavor of ignoring needs different logic to skip whitespaces
-	 * while we have both sides to compare.
-	 */
-	if (flags & XDF_IGNORE_WHITESPACE) {
-		goto skip_ws;
-		while (i1 < s1 && i2 < s2) {
-			if (l1[i1++] != l2[i2++])
-				return 0;
-		skip_ws:
-			while (i1 < s1 && XDL_ISSPACE(l1[i1]))
-				i1++;
-			while (i2 < s2 && XDL_ISSPACE(l2[i2]))
-				i2++;
-		}
-	} else if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
-		while (i1 < s1 && i2 < s2) {
-			if (XDL_ISSPACE(l1[i1]) && XDL_ISSPACE(l2[i2])) {
-				/* Skip matching spaces and try again */
-				while (i1 < s1 && XDL_ISSPACE(l1[i1]))
-					i1++;
-				while (i2 < s2 && XDL_ISSPACE(l2[i2]))
-					i2++;
-				continue;
-			}
-			if (l1[i1++] != l2[i2++])
-				return 0;
-		}
-	} else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL) {
-		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
-			i1++;
-			i2++;
-		}
-	} else if (flags & XDF_IGNORE_CR_AT_EOL) {
-		/* Find the first difference and see how the line ends */
-		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
-			i1++;
-			i2++;
-		}
-		return (ends_with_optional_cr(l1, s1, i1) &&
-			ends_with_optional_cr(l2, s2, i2));
-	}
-
-	/*
-	 * After running out of one side, the remaining side must have
-	 * nothing but whitespace for the lines to match.  Note that
-	 * ignore-whitespace-at-eol case may break out of the loop
-	 * while there still are characters remaining on both lines.
-	 */
-	if (i1 < s1) {
-		while (i1 < s1 && XDL_ISSPACE(l1[i1]))
-			i1++;
-		if (s1 != i1)
-			return 0;
-	}
-	if (i2 < s2) {
-		while (i2 < s2 && XDL_ISSPACE(l2[i2]))
-			i2++;
-		return (s2 == i2);
-	}
-	return 1;
-}
-
-static unsigned long xdl_hash_record_with_whitespace(char const **data,
-		char const *top, long flags) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
-	int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
-
-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		if (cr_at_eol_only) {
-			/* do not ignore CR at the end of an incomplete line */
-			if (*ptr == '\r' &&
-			    (ptr + 1 < top && ptr[1] == '\n'))
-				continue;
-		}
-		else if (XDL_ISSPACE(*ptr)) {
-			const char *ptr2 = ptr;
-			int at_eol;
-			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
-					&& ptr[1] != '\n')
-				ptr++;
-			at_eol = (top <= ptr + 1 || ptr[1] == '\n');
-			if (flags & XDF_IGNORE_WHITESPACE)
-				; /* already handled */
-			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
-				 && !at_eol) {
-				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
-			}
-			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
-				 && !at_eol) {
-				while (ptr2 != ptr + 1) {
-					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
-					ptr2++;
-				}
-			}
-			continue;
-		}
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
-	}
-	*data = ptr < top ? ptr + 1: ptr;
-
-	return ha;
-}
-
-unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
-
-	if (flags & XDF_WHITESPACE_FLAGS)
-		return xdl_hash_record_with_whitespace(data, top, flags);
-
-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
-	}
-	*data = ptr < top ? ptr + 1: ptr;
-
-	return ha;
-}
-
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
 
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8b4..8f524b72c491 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -33,8 +33,8 @@ void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
-int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record(char const **data, char const *top, long flags);
+u64 xdl_line_hash(u8 const* ptr, usize size, u64 flags);
+bool xdl_line_equal(u8 const* lhs, usize lhs_len, u8 const* rhs, usize rhs_len, u64 flags);
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-- 
gitgitgadget

Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5F31B82C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776399; cv=none; b=LowmSEnglF5hK24BSiYWweA6RT6BDJToKD70ObpW3665yVu+J8Png/eD597L1iMytLBEjfzqeuftqyg8/gfLY9bFtspBxhNWVRlg2SJahCSqziMkRpS4OFrnLrLtb2P9gkReZmHfM9Y2LzcR/j7mVUJOgjtNmox6IRiez89SrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776399; c=relaxed/simple;
	bh=jo1IlnFz42/8SDaTBJZaMSKJ+twLydnjT7arp+1Yozw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QuORvO9aLGRkNu0HjZjgi6GRIkROA5VDyYU3zh3MzCjcHfkW0uz0unGxNCNg9YdY5WYWJ5dSuSApFoM5zRG2x8wqEh5tB9ZpBPss5uLnHTK0WXc4Jt+NXCGcyNR88MDluTCNCy3TdOQEDhj+w6eQ898GTDuH7ExpLcd5+aI9wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6VAz+Fk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6VAz+Fk"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430d4cf258fso1371445ab.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776397; x=1762381197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=M6VAz+FkhdRan6IjGEKjzDOizaQDOViPZD98BWmJyKdcL+eer8gmoXnl5tGcB8l+gA
         /bq+7DWaxpwpqM69aXGQDGAN6DseSn1Lr2lotrfLgA+e7TGM+78FwD+3CZeO1hqE4cSK
         LoYzvTyBE07P98YyZ4romJVdtJ9MfL93Z3L9ih+FmV3wAdZ4VRnGiz4UVw5OkT+URQlR
         fxPQ7CAtziKX3FydfBqh/jkOfmjRi7Hm8bwFehW2NkigzkdxTao06FxzQ8+hfknCwDf/
         xPVVPWqWz3eJ3h6hg48rHemvL9mZFCHtBmaZmSLxbyYL6mg5ir6wzco0OlorL9kXg5Wv
         Tutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776397; x=1762381197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=CwYJK3SmnEXqtNEqGe782WJFZ7b/Swb53PWDMOte9A3jjong7SEyQ/RahjE+2q4joO
         kWtqwjGyvMpVibAZOJSTuMbNkcTbj+dpIJ2tiSOEjDtfNnMdGawnVG5V/kF2KZ+nClhH
         Pa+oaCwmayWndkDB8tA6GjhD9pL1op7Xd3+rHOVoBtnPn9q/gnIOWeR7408VbY2Q27MJ
         TOE9ejqBhQUOzPRr6WsIGbSMzQCZRdoa9H6rotApl+qZPpXK8ftSno8cxTPi8xspCjxu
         OgrlPF8gsz01y/a6MKNVeVsWX0c+wf2mimuJ8SO/LceIgT7MQt/ARIfQbtmPjwF0sh97
         Z1dw==
X-Gm-Message-State: AOJu0YyqeXmqSv3EzIHQq/Dxzqmt3W9+XppijhJ5C4qfgywhCn3uwIyJ
	mtotbPpHMxfjzdxLF0vCnlg3xKCJK9CGsSeSrPc7U1R6qtdfyVjAv8Ct5ludmg==
X-Gm-Gg: ASbGncv3Uhksxhq45B9Tids0zuf93TP+9p71bZV/OVvONqsE26iNWxpHo9jwPLmjYjR
	ebBKeac3YmhYz12iZ3D54JNj3aB6ihpggpY0Tfzw4QZlBNicol3L08WPEheyEBGPJei9Ks57A+a
	LqkRo8fL5rOWYewBCkT21K6XbTXxrkiWbQqCrzk+vPA4Kktvi/hDcqC43ee7BYduyGMLFlg3dfh
	iKN4Q8flE7AIfY0b6Z0xVNSvNkbqd21VsXmDW8E3LNehw/0tB6tnrO2smSAhVv/uUMlSHS8lzMY
	NxFr1kngEzQps71Nu9Wm0WidnGLs+O+lSt/s/wB7FNnSIWLrK7QT3K5A7FULdk1QfsNyE5TPGQ2
	K4COQvbebp83UI8QDR9R5HnzPY+7FNg4bdIzt4HosxqBfBIT1YwDKcBsXBPE8lcWxlzw2VB+j3u
	bVPa80KT35SfB2
X-Google-Smtp-Source: AGHT+IHB4Zc5i1RP4o2l/TD6TLqlCMyUBmCEFhQYqWG42EIaTSgiUR3JZbRgxbhaGzuO/HjL4azRDQ==
X-Received: by 2002:a05:6e02:3e02:b0:431:d73b:ea91 with SMTP id e9e14a558f8ab-432f8e6dd63mr67076235ab.0.1761776396848;
        Wed, 29 Oct 2025 15:19:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e35c4asm5968758173.56.2025.10.29.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:19:56 -0700 (PDT)
Message-Id: <1ade7d8165406bab37007c73627e72f9b9143773.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:43 +0000
Subject: [PATCH v2 05/10] xdiff: use unambiguous types in xdl_hash_record()
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

Convert the function signature and body to use unambiguous types. char
is changed to uint8_t because this function processes bytes in memory.
unsigned long to uint64_t so that the hash output is consistent across
platforms. `flags` was changed from long to uint64_t to ensure the
high order bits are not dropped on platforms that treat long as 32
bits.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff-interface.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xutils.c    | 28 ++++++++++++++--------------
 xdiff/xutils.h    |  6 +++---
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4971f722b3..1a35556380 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -300,7 +300,7 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 
 unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
 {
-	return xdl_hash_record(&s, s + len, flags);
+	return xdl_hash_record((uint8_t const**)&s, (uint8_t const*)s + len, flags);
 }
 
 int xdiff_compare_lines(const char *l1, long s1,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b3219aed3e..85e56021da 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -137,8 +137,8 @@ static void xdl_free_ctx(xdfile_t *xdf)
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	long bsize;
-	unsigned long hav;
-	char const *blk, *cur, *top, *prev;
+	uint64_t hav;
+	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
 	xdf->rindex = NULL;
@@ -156,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = (uint8_t const *)prev;
+			crec->ptr = prev;
 			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 7be063bfb6..77ee1ad9c8 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -249,11 +249,11 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	return 1;
 }
 
-unsigned long xdl_hash_record_with_whitespace(char const **data,
-		char const *top, long flags) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
-	int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
+uint64_t xdl_hash_record_with_whitespace(uint8_t const **data,
+		uint8_t const *top, uint64_t flags) {
+	uint64_t ha = 5381;
+	uint8_t const *ptr = *data;
+	bool cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		if (cr_at_eol_only) {
@@ -263,8 +263,8 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 				continue;
 		}
 		else if (XDL_ISSPACE(*ptr)) {
-			const char *ptr2 = ptr;
-			int at_eol;
+			const uint8_t *ptr2 = ptr;
+			bool at_eol;
 			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
 					&& ptr[1] != '\n')
 				ptr++;
@@ -274,20 +274,20 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
 				 && !at_eol) {
 				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
+				ha ^= (uint64_t) ' ';
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
 				 && !at_eol) {
 				while (ptr2 != ptr + 1) {
 					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
+					ha ^= (uint64_t) *ptr2;
 					ptr2++;
 				}
 			}
 			continue;
 		}
 		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha ^= (uint64_t) *ptr;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
@@ -304,9 +304,9 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 #define REASSOC_FENCE(x, y)
 #endif
 
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
-	unsigned long ha = 5381, c0, c1;
-	char const *ptr = *data;
+uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top) {
+	uint64_t ha = 5381, c0, c1;
+	uint8_t const *ptr = *data;
 #if 0
 	/*
 	 * The baseline form of the optimized loop below. This is the djb2
@@ -314,7 +314,7 @@ unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
 	 */
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		ha += (ha << 5);
-		ha += (unsigned long) *ptr;
+		ha += (uint64_t) *ptr;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 #else
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 13f6831047..615b4a9d35 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -34,9 +34,9 @@ void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top);
-unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
-static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
+uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top);
+uint64_t xdl_hash_record_with_whitespace(uint8_t const **data, uint8_t const *top, uint64_t flags);
+static inline uint64_t xdl_hash_record(uint8_t const **data, uint8_t const *top, uint64_t flags)
 {
 	if (flags & XDF_WHITESPACE_FLAGS)
 		return xdl_hash_record_with_whitespace(data, top, flags);
-- 
gitgitgadget


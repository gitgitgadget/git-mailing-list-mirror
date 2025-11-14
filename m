Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00C2FDC20
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159831; cv=none; b=S9irw39paXpKq4KYF3PyV+bi+h6Dlw+CEWeiX52mgrNR9AKo02IvSfvz0IWIdhOJGZUZgjiXGndNOynHTLzqjnd/tG82/Xxr8mZLNDfSzqeCSP7PtpmTBqTL5SKVS9hg0mD1fluA5OP6oqgm5DlNxju5QcgeOEHZi8P+7B/mWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159831; c=relaxed/simple;
	bh=jo1IlnFz42/8SDaTBJZaMSKJ+twLydnjT7arp+1Yozw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EDEbcUlmaC8icerKLvbK9oL+wtoSPhRLJHse1wtm0ADTQzR+lURdZs75U6CQ1QXpHY7s9TW4Ygo7vkCC0ZMP0hti5DjTBVq7PyDvRCOz2DnoDLWlMsJALb+dS788qTniriC5ajA1qw+T3+HxYCuIRakkvo4jx4knYXQ9DUULUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J93bS4hU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J93bS4hU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so1950859a12.2
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159825; x=1763764625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=J93bS4hUH0IPl26fhkCdBalKTKBezTo6HuAQWh8dwRXF5HKcS843WFp7pupbtfT/CT
         ahoA1xYHKpJTfXsoPgpQZhpsPk/x/Y5i9HHYphS0RKKZ8cuMCdczeaDZeziOtg8BdtO5
         FGCyTkbEcE0pmixnr/Cgc0yhoPwm7DjwybGZqAzeXSr4uuvjP631lb2FrF98fbs9DmMh
         nIpxZiIP+V5XZNbkiGRW8V4I2SSMECOUOjyMKBfdVun+Mg6qDSNSnmuCm63saEsC/QkW
         yb0KgC2BC4Ywh4ChVdAgf5ro5OhWuq110Yg34x0WXFdddAV468M+Syzt5/n/Y6nfHdfs
         RDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159825; x=1763764625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=OcFp1i4TMZ/E/As6EMMqjw7no6HwhjAdrYOvKrY/FD6ktxfW73IMwgnXacoM0GFk0+
         hsrPh9YEF+2nP7DMY73jjYkpj0t/mwosmo2Z5L0ahkYFhiINodC8hy6Rots3p+L34XHs
         8UtVVD3qrO7oLT8Q9eSfAmYU8PGsEJfLGoIy2tS2eQKAg+LW8HGVpQTM8xY1z4SHp+qY
         lWiVqxfOCaL7D4jao5/JU+ey3LeVe+j24YrB+Ig8KJJa8InFBKZ9zHMpnyHwcIxENmul
         XwCjuj6X5z2dxoJT9z5Q7KzxYmT6ZSkENJC+SEdqXJea/zjs1aFny2fYHU20TMQLnF1K
         PAHw==
X-Gm-Message-State: AOJu0YxvYiOhqn0Dpm8ER7khFng5/iek200paEdNJMH7Q1/Vjp4wTTxl
	zNJmchCOwLCqTs07OQmAXM7o7NLxmAxSODXY1blL7O2q/17+Vmg1EhKs4Ot5YMc6
X-Gm-Gg: ASbGncuHiPGWjlM75n5fGI6EKM/m6cOOqSi/05O6HHl+5/+4BMrNBDHlKKRAb10S2ZP
	lt3jpx2od6QcqnZV4zjaCrLS83W9LgR9koDIfcFKsG6RghzuPQ3PtT3MRjNQHHNufyiR95FNnjJ
	t+mfCfr2QwTwiSJL2Ac3ojpVzLKmbHyXmpN2x/pbbPPx0Z688mNpa1NthyYzxsqrqSyECnl83dj
	/mMC97aW9X6UXIgXxnUEOpAJDkYkktRrApfKSU7FDs19or4zNWseiuGemSIsZEzmBoZCkCavHAK
	IGFYsNvxBmZT07Tjl7DSNOmtujIMPKSF1qmKULoUYgjDFFwGhfsSacUlI/5ZHSQMsh2lPXVm/Y5
	JYfilh9B0tb9FsTwy7QLr/LG7xJT8eTpkpqnDswVWMzYnTkbAFG4RQn7gxHjAYzH8p6TFZniEp1
	jB3Q==
X-Google-Smtp-Source: AGHT+IE3DeSPUx1XjZoEgNosgFTNqZNWLBDZ63AcC3iK6Mbg5KtgYLsWpRHKYMYEpxdIS/SjikfBoQ==
X-Received: by 2002:a05:7300:d80d:b0:2a4:3592:cf81 with SMTP id 5a478bee46e88-2a4abb30eb5mr1467494eec.37.1763159824548;
        Fri, 14 Nov 2025 14:37:04 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49da0662dsm14903390eec.2.2025.11.14.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:03 -0800 (PST)
Message-Id: <2ee9a74653e77c395659c8540d9139179478e3fd.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:51 +0000
Subject: [PATCH v4 05/10] xdiff: use unambiguous types in xdl_hash_record()
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


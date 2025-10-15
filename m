Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25E2FFFAE
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563110; cv=none; b=c0Lbw/sKCuCTK9FMIYAesLQOh+zxyJPTUCNXdOocBSC6mDQJ1fB2I61y8AVZSN/AOjrxNgguK5NOIVfQjBy4jm1tzxXdulWEwm5k29+hqscoWACiI8b362IzdGsWRDcttOjILe6XYDH3KpFBuDPi6AXw6GYxpnYE8/xPZvO7WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563110; c=relaxed/simple;
	bh=sOM4Lrp2u6I18C09UueJL2bReXmktcnHkBJ23lHXwHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yrf5UG06VKw3j88JUfVeQpzUqax9kvw/u0sYc3qxIPDZW8m6aqgsEur0qkIao6OsGzL3aX2qWtpSOzpjNK4Yf8a0slWbuIuFa1e7MYYNjHflwIzHFdXW5K7oQhrixifGzXD+HD70xGCnQrEIzYZQ2T6ejYxKsgAyyQlBQecEXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TswvlheB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TswvlheB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7800ff158d5so64533b3a.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563108; x=1761167908; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbDMPnKV9VqNwGSQUSAsZChwvk7MDrECwYGWez1Vs5M=;
        b=TswvlheB1BsHJJIg1bVgQG8CRgBT3809FumFim5VLyIp1QwlAVB45S5D9oGQUjet6x
         mnonashHs6BWUDixySym7nEq4ygIplQnUmy4W2KlZiFREeJd1ThFjfxlfTa/05uj8W3A
         z80z9fexv+BbbpP0BGfdRTw/Gm7DURIvFf+FLWsLzIB8VfnmcddSFu3nYck94R8tOUs8
         bAv/ts++MzrKgyXHTgmILmBrmLY5SwTUrWvQ/70frWn3o1ztvtxhhybSwMAWS3jj94mB
         djo+F39XXUT/pqB5nI0lYXnD1vk1Y9WLBio6m390IYMHiXIt+krxy/fu2qgksTy2rv6h
         ef2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563108; x=1761167908;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbDMPnKV9VqNwGSQUSAsZChwvk7MDrECwYGWez1Vs5M=;
        b=sFu6X3lI/ZRMKvhPdhEzdZC4cRHSl0OykqcU9cuBu3NsokOnNLzZg1HxB7fthTcTwk
         AT37ISPs4xW1XPGUB+6Eydph1UCc6FOcgbaCiYFb4dRrXn9ahVap9UUi0LDuGtItC+Mh
         ZqSDdZyh08VLjez7GrxpQsnNKzPkUvr8kHZ5Fko8zMZzL4d9dEn9ajUbFDZeqb8b8RVW
         f0KT2QK8Q4Tp0Lw3juBPFR9RoG+i5NQB9RRrszpWqKvtyEykFmIUz0/pJs+JFjq0LkRN
         0Z2lq8cIPNoI/cA+Sr5WmsCgs1uIkJ7FYh7vDRwQsZCaw/nuQqjNxIgf7BR11I+w5P+Y
         L6hg==
X-Gm-Message-State: AOJu0YzQLSx6PcNXSijVp3Z7gv8W3moC5PrjWi1PeoGv1Qn74wDAvz18
	oEkCLDHroFaX/WSxtZHpcmOWLhjbOCRhUU+kZdaL9Fi0pliXU/Irpa4DoplHgwnU
X-Gm-Gg: ASbGnctGlbrI3J+G22V4k/jToOe4yyt3N66g6DlBuR8K+kQeIAhO1AtWwHONWpnegJA
	fwY0efRVgxAFbZiUvNcD5FYiAKVE98NfzbKS5QkviTqFWhyMokOk/L8c5TaziLc05DaJfvTydwE
	m0thVEoe0reVb6GFe4lWcYA6uLW7rjKfTMO+4Xha7WGBwAATXZChScW2u+cjMGFVpkvrBYnmXRN
	wk2L5ywEzvOcc1CV/h5fk5WWHu3pCP9jULa30ZGDrC7dsArR7/v4EmVnMwYWaAqvpULFbQNzfyg
	FYma/zRsjv4swfyPaelj+C4Riyzhd2fZ80cOJ+qhbLfVWic4UTxzUyrc4XgE67LTUp42Qnb/CpB
	8u9ma3wGnj3iF7J6fZxdp/ZuyNRCIK2JjRVkmewz/AM69Q/pjHUh87ekbmaISoFM=
X-Google-Smtp-Source: AGHT+IFsiY3vzfJX0vyM5YQogslv3Wzq0P/tkvzMUYsCH+oGXgnnvNfPPr3kCFKcjjHBG6k38F5KMw==
X-Received: by 2002:a05:6a20:6a12:b0:2e0:9b1a:640a with SMTP id adf61e73a8af0-32da80db3e8mr40537202637.3.1760563107810;
        Wed, 15 Oct 2025 14:18:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9932edsm19668001b3a.73.2025.10.15.14.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:18:27 -0700 (PDT)
Message-Id: <7fcd83c99076404960302b64a4f0c8fa1c13feba.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 21:18:16 +0000
Subject: [PATCH 4/9] xdiff: use unambiguous types in xdl_hash_record()
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

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


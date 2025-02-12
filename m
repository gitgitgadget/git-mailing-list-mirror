Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256081FBCA6
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340267; cv=none; b=o71axp8i3rt5/4mfFtnKJUIYj57Q5KYXTZ5lPQbJ1ri79sLhHRSDFuxpIb0+J8pZ7F1dfZ0+hDt1H282WGxTA4swhUhOdI1Ke+tBkDI2Dhy8yxI1WE/kIYrS18s5mHEPqzH0tBBmjo2WqT/pU5Vqmo3QFdDTaMwB6FHQPxTqz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340267; c=relaxed/simple;
	bh=fL69pxwvzP1JuwaqSjCtAJGgN5QWXwwmepS/hBbaCMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwafTb0Z3Knc9sBQWj5TLeE4nkWYqVg1UKhzKN4HeLNjrzxMzPErhg432RQSlOpfsXY86C+V0F0KGlVW85lxmsMHtZNpibHQPwaUUJ93XEj+IjHdo0XwK2uBlQAIvSpu/Olw7fyI/wYhyWM2vlteq26XTgtOfc9figBTV/UbfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtElrf+9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtElrf+9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bfdfb3f4so6117785ad.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340265; x=1739945065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0rNeT5/m+hw80f6bZRvSzGIuOL+13rI13gR1BLQ1y8=;
        b=JtElrf+94GQeDSUMkpqeK+4HAA6UxqrEbKjs4lRDLQw2bc9lwVODHBVkAplqxS/bCT
         JPGFo4ZB7+PfopiXPYpXJkR1cD/H78cUTmmbkgegCiohnP7Da/H5B3axy+ixTsvtUMin
         ucRVXFz9hgvXhw6pfTBCSSfAHPba0XWaQinyiV9P6SCIuFZH22hD5vwPfz6dpJghccxl
         4TfR+Ooz38RZxmuQlL7cCSlZKCrzUJ9f5xMRjQ/NowdLWUdA/xtUdvXyhDiNZ5kMZ2kW
         UO93Jrm+vCRH2PbiXzjs4lr5bxWrzhxU6eRaDqaOUf2n9f0D1bRPxIXdZp5wM8kvoux9
         +81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340265; x=1739945065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0rNeT5/m+hw80f6bZRvSzGIuOL+13rI13gR1BLQ1y8=;
        b=ZIJrgspZTCtdIL4j4aDRykQVlB+qrQb6XgRcVnWu4L8leCr3WMIxLYigHcXWJvHrFu
         ms83c/EYGBvYMm2cJs8tlUtXq8KUGucfMo/Hl5afczmHYGX1N1dyCaDDV4ODns3KBgUi
         r5JU8Jcm28L61idB1dZbSdFYfr+4LrJF0XXkd1ovzgjeH7VlQ4YE/fde+JpSCeQL0Y23
         qsDp/exaCKCnOetX/Z8TTx4gVaCOIdzxqrNJvtj/VdYoy/59LFJNJm8qQexlb5WWXznQ
         fJqTp3GhQOlT4gwmqNRSOfqb4zHpYocQjM3xSlX/7ljq6kQ2TcLbOAzMBYdjUYDhrvOE
         XMmw==
X-Gm-Message-State: AOJu0YwV351F+oMcEuB/VFgYNdA+iQW4GhuQxKBfMvOLnrsq1tOMWKIz
	ILaxjmcewQK+9QK8/eBlUPZNnS+EdAAOtdY2UdAgL9wO+xnjnizpONj7zw==
X-Gm-Gg: ASbGncuKYe9QM5nTUwRg7vhp1KVU1zl6+mtpq5Gh0U8SE6Jqvop2d+b6N23AmMhhC/Z
	NJPenUdrcBI1yKnPpd2FSS8XU9pRErb0hfgAWrZKedolRyekYsbJrPzG03BEPGIyqI0+Jm8C0z9
	IPi0+/oOu8/iaCJoE5ZNRhg+XprlC+cRCqVpQrysQmYn52s+2CFcHOgstFXab8P4x7ok2V9g3P4
	cU5MVgzsczif1RhzV7dOxc9KX+k4Og/j5hyiJ/Lt9AqhNVS7tFzIEd59tQn3dk/D3iZQZxw2woU
	kMSFxLPkvE7P3QS9YzOlCEswUg==
X-Google-Smtp-Source: AGHT+IFSa1DfYD5pEuD28CdGciRJRdUUr0wgkBkf3PGN4qyTKcENcPbn1m+UzehggOGK1rCoyvxjZg==
X-Received: by 2002:a05:6a20:4307:b0:1e0:c77c:450d with SMTP id adf61e73a8af0-1ee5c733a3amr3675166637.1.1739340265444;
        Tue, 11 Feb 2025 22:04:25 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:24 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/6] xdiff: avoid signed vs. unsigned comparisons in xhistogram.c
Date: Tue, 11 Feb 2025 22:04:16 -0800
Message-ID: <20250212060418.1645241-4-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
In-Reply-To: <20250212060418.1645241-1-davvid@gmail.com>
References: <20250212060418.1645241-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparisons all involve unsigned variables. Cast the comparison
to unsigned to eliminate the mismatch.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xhistogram.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 3d2b190fa6..040d81e0bc 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -41,8 +41,6 @@
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "xinclude.h"
 
 #define MAX_PTR	UINT_MAX
@@ -108,7 +106,7 @@ static int scanA(struct histindex *index, int line1, int count1)
 	unsigned int chain_len;
 	struct record **rec_chain, *rec;
 
-	for (ptr = LINE_END(1); line1 <= ptr; ptr--) {
+	for (ptr = LINE_END(1); (unsigned int)line1 <= ptr; ptr--) {
 		tbl_idx = TABLE_HASH(index, 1, ptr);
 		rec_chain = index->records + tbl_idx;
 		rec = *rec_chain;
@@ -183,14 +181,14 @@ static int try_lcs(struct histindex *index, struct region *lcs, int b_ptr,
 			be = bs;
 			rc = rec->cnt;
 
-			while (line1 < as && line2 < bs
+			while ((unsigned int)line1 < as && (unsigned int)line2 < bs
 				&& CMP(index, 1, as - 1, 2, bs - 1)) {
 				as--;
 				bs--;
 				if (1 < rc)
 					rc = XDL_MIN(rc, CNT(index, as));
 			}
-			while (ae < LINE_END(1) && be < LINE_END(2)
+			while (ae < (unsigned int)LINE_END(1) && be < (unsigned int)LINE_END(2)
 				&& CMP(index, 1, ae + 1, 2, be + 1)) {
 				ae++;
 				be++;
@@ -315,7 +313,7 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 	if (count1 <= 0 && count2 <= 0)
 		return 0;
 
-	if (LINE_END(1) >= MAX_PTR)
+	if ((unsigned int)LINE_END(1) >= MAX_PTR)
 		return -1;
 
 	if (!count1) {
-- 
2.48.1.643.g61982db19f


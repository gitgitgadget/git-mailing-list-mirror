Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F8219E0
	for <git@vger.kernel.org>; Sun, 25 May 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748138771; cv=none; b=WRXNX99QAYGdWk4zzJiXObLHMvzRZhTJ91gr+5dq8yv7/xgp249nRnGY7c6mk6h2BqKIMi9tVDPADObVA7iPaOke1R02JsEBsGzpaYueUBdlvrpbyGCi5Jj3wMmx8KDYjF8Qffjgt0j8sj1gOCz8Kj0aLMvJLGWrZ+2kDB6S/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748138771; c=relaxed/simple;
	bh=2che5DasQZJHufC5AUe2xOwDPTuD8Y/kz1HXq3Kx534=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KtDbsF43KujRhGmPAW8law/cfkWNLNC0cFfadKyrNnkRFJqc2/zDy87NuXtT8qmEwVt9ITerxRC+JLuSYbXzPF04dIoIFGnkIDjqvWwlsNNxGph7G3j9dnZthiyRzTp/uo4/uLqOLd9h1cnKx9s+zZfENrTYrvP+0pK/QWsO+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df0JcPor; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df0JcPor"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so6814845e9.2
        for <git@vger.kernel.org>; Sat, 24 May 2025 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748138767; x=1748743567; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=Df0JcPor1V5hTTdcE2XuKsOtVREfozgftuYTmI/Qx+yrJt5V9zMq/j7iMow18z9eN8
         fNzZfHPSDtr7fvQhjxSrBrupU9suA8VoSxGwkibyqB9Czvq5kpXSuhfHQU+quA0PVpVJ
         EK8lVurMtGsSVESGyBzUKPDix3Lh/mfWY05t2wpHKCrQ5pnlVjZj/0dWywuUSnc1Dsxs
         JvCbjtyCnAucsrm76uoS+eqNEBL9I99Wg0StN0voRmp75X+wlamp5aor3IRJa8oy1TYX
         qxU/TpHrkNbLjsMDzS8jKwvWJpVvJIZk7XzEuDmNxBbZFzkBB3ncTTsDrLoNznd/l9Ha
         Imlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748138767; x=1748743567;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=ZbcgPOyvDOcK4Bz+qH85WGJgQ3wAfGvCGVM/jfR5z7fi2IvSvxBPdcGb8FWCsX7QJw
         R+JB4ko/jvWOhj0p+EGOCGGM64tXBkXgAFkHU1+Vh75sx/Qhq5w3cgVrH6sKGxzwNOd8
         k9hTP6a73RunfR+jH3mG3+NcBGpfqJjlOgH3HWKFccg8GIQOA9oOlvTJaaLTrfOdm2ru
         oz6vuUR8P6MOGZDxHE4ocgpi04JKFFNjFIULnvsM6hSAMK0y6/MD5VYbe42AVZ/dGxzM
         GxctAm8Ii197SuDfgbl/gLSeX1XJunCuu4VF3Uzw5wu5xybcN8vBnYZWOXFlu58dvXNF
         3HtA==
X-Gm-Message-State: AOJu0Yz93hKw2aNplUUSZyv8l6hfNSu6dT8L+s/KyWT0Zh6p/4xWiScH
	IsWrJs52GEjTQUyY8GWwJVWAvh5bFmt+XUsDZLCgk81LdYgPTFqg0dJcdy/e9w==
X-Gm-Gg: ASbGncuEq1Hf8Tg4ZJE9y4CgKaxJinen2BBCl7qVzwo0XQ4UMAWJbiMRvwB5R/DN11M
	lU4qvnRDXEsYGOfyqaJY42axhIkCe2eFXtQaeyS7CG2eeG3kRMAvOTQSPx/uUiitx4gy0OC8rxW
	lt6w1fpwMy41qHbXfgcZq4sijh+AvaDS73n6Bb4EPkldegxAFyZHvJKogiCqCm9EfPH/zI6TCPz
	7+LBsQcn+o0SLI/kxKUaPgpsiG/kTaJ1rtDfadZ2bZRVDNQ/GHM+WLMwhZxYHZM/aB/lGBBm+uR
	Lg2MmKhjUB2doigoO4zavC02nmsZXNoBrMVag8JcGS76IMZ5djN2t5IV8rG4dOY=
X-Google-Smtp-Source: AGHT+IFCATtdQkb8T5/DdfU3u75T0b/TiMXebfxgLW5kCPvLUdnYR3r2AddOkKltSy27t7+i67xHkQ==
X-Received: by 2002:a05:600c:628d:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-44c92a549c7mr29145535e9.20.1748138767258;
        Sat, 24 May 2025 19:06:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d4d55964sm581538f8f.29.2025.05.24.19.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 19:06:06 -0700 (PDT)
Message-Id: <cf87aad7c998995bfcb778eba26492614db1181a.1748138764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
	<pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 02:06:03 +0000
Subject: [PATCH v3 1/2] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

After going through the "failed" label, load_bitmap() will return -1,
and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
will then call free_bitmap_index().

That function would have done:

    struct stored_bitmap *sb;
    kh_foreach_value(b->bitmaps, sb {
      ewah_pool_free(sb->root);
      free(sb);
    });

, but won't since load_bitmap() already called kh_destroy_oid_map() and
NULL'd the "bitmaps" pointer from within its "failed" label.

So I think if you got part of the way through loading bitmap entries and
then failed, you would leak all of the previous entries that you were
able to load successfully.

The solution is to remove the error handling code in load_bitmap(), because
its caller will always call free_bitmap_index() in case of an error.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c5..fd19c2255163 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -630,41 +630,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
 	if (load_reverse_index(r, bitmap_git))
-		goto failed;
+		return -1;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
-		goto failed;
+		return -1;
 
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
-		goto failed;
+		return -1;
 
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
 		if (load_bitmap(r, bitmap_git->base, 1) < 0)
-			goto failed;
+			return -1;
 	}
 
 	if (!recursing)
 		load_all_type_bitmaps(bitmap_git);
 
 	return 0;
-
-failed:
-	munmap(bitmap_git->map, bitmap_git->map_size);
-	bitmap_git->map = NULL;
-	bitmap_git->map_size = 0;
-
-	kh_destroy_oid_map(bitmap_git->bitmaps);
-	bitmap_git->bitmaps = NULL;
-
-	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
-	bitmap_git->ext_index.positions = NULL;
-
-	return -1;
 }
 
 static int open_pack_bitmap(struct repository *r,
-- 
gitgitgadget


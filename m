Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FB31E848
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790623; cv=none; b=cUQnhc4PBaF4bdAfo+5Kz/QNbifyLzmS54ElNDbropAvtFFWaMKB/kSTCasV4z2IGN14BewXl00wmsWdkr5m8+x2aEvRMaKsGzZO/tcfQfamkBVpC+tT3aVROGI6jj8wqOxXGhRiGkwNWF83RpePjARzSq6t/7Pzjl1TdmGCPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790623; c=relaxed/simple;
	bh=2WFsByTzos+f42H3JWdYuYHHngR5GH0KKuHdiNuRAZE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mCwSiXiRWF2l6A7QmRN+zdwG76JtHs4di/VjMxrZyscitwVHlpuzmucau+gXsLrk/MCuk9boNtdcumaVVHmDRvB0F1Jg+v8IwgoKbIAvURiPhnJZgQUOeHNPWIfAEPZLUPmggl5Ipusenn8EHHpmqM6SvaF9alx2/p2zIFHCTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVYrL2Vq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVYrL2Vq"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ce9df31840so6734426d6.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781790621; x=1782395421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=heDBTW8UZLfcuxZkQbpkkVUGo9AWguMKzsgaLL2XMIk=;
        b=KVYrL2Vq3iGHz8fb4i3d6YVzKbLoF6jvd3O8kRq6/GK4nSLQQTaL20fpyQzm/HyCC0
         RNviIRg4/Bsmr4D1u1OzsH4OhRvQHQpjswA6OH+HUzl/ItXl3JizlyIo6Fw9E+7pnSVY
         JNt1SJD8lhjiYt2vFcANyIUx7B9EojvbU6uXGDjgIQAJKY31IKtROXleUgO5UpCu77JZ
         izA78BvqJQf7kh1Ya9yHO/8Gu6Oa7Auh3T+J+yyUZ5gwY3zGKoUMyqj5vj8qgdEp9jer
         8IuL8bCxReNuVZamopSQPHpEEsDlJyhlGvCxbtJ8r/X5/Oe1G5AK/aoeYwiVV3Zsi6vr
         vAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781790621; x=1782395421;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heDBTW8UZLfcuxZkQbpkkVUGo9AWguMKzsgaLL2XMIk=;
        b=h/QI/bFo56Z/BOSSAqpeq5rAeBbntlzR7LC/YeNmmT+/FRXK69Z1sfZqhF+IVehVc1
         UMlbOalt1KQLBlFmvHiDijNwlE+ULLa5CuKl0WLtlRbeveFOz99cGN9b4Fz0kBaMpqPY
         TLm/9D3HNvsU/J/8ZcCTScjITL9AtUhMTL25jmyFtuR7HPgjGR8E50e1sM40T26IakXw
         /OG0+b9FjW6hMkRsv1X5Gw+HnTH5FZAfmaGwOUEJdfZsf01QQay5X3H1yBDXOK9Kb5sb
         zmWql30F+sr46pgU2XTjZb5QYJUGGMGLyaEElFtPSF/yA5qLNGdPJIT6v3Q/rAaGBjuZ
         vnjQ==
X-Gm-Message-State: AOJu0Yw6Pad9kVJVJPVihteX+XkezdUtCqXYYZGJwQc2igXl/Xs4DlXk
	RRsC8/R3DQHilDPsKF31UVKJ/UZ/wC7sVmqJ65jcD6RQx83dbIqOHHs6Awy5JQ==
X-Gm-Gg: AfdE7cnw+WRNYLGo9mz9iTnRPYbTTUoPk1hf6wL7bf5OxSAhJWcN/lNg6cWAUV3a/C6
	qeib6HJmNn/SzR+nIU7oU8jTj3TRv1YVWmcrqbmaCdVb8QM3aw8Bm/Q39ho3yrRfm6bCTKlB8ti
	AfkSepWmZ4pWNS0FUlT5XGUQoJWqV0SoZLurITK9wdT+6KNqK0zcwzVhst3pRy195fgKriSU0NY
	dN94w9PDVJ0HVIz7hXCZiPV0ZBZpaFO0xGb0MI16x8R6LNjkj7CsUPUxoYmTPmfNj4DZyg1CqDV
	p1J2LwwgkXait/Iq3454TJfAMHOgPNj4BhWzuuA8Txa5NC2MMXSixl//oaAd/h91QBbZFilQVl9
	9LTMZay+NNGawcSo99M9VNOGuuEeDDICSF652NCK3/lzFNaBYgNZTvzHMyvrEtpe7ZAQuA3Xx2O
	Zqz67XT+XC3ZHs6aaGFg==
X-Received: by 2002:a05:6214:201:b0:8cc:dfa6:3333 with SMTP id 6a1803df08f44-8db5d1d59f1mr109595906d6.32.1781790620654;
        Thu, 18 Jun 2026 06:50:20 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.101.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f19e8ce7sm97575796d6.14.2026.06.18.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:50:19 -0700 (PDT)
Message-Id: <pull.2153.git.1781790619424.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 13:50:18 +0000
Subject: [PATCH] zlib: properly clamp to uLong
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On platforms where `unsigned long` and `size_t` differ in bit size, we
want to clamp the buffers we pass to zlib to the former's size, as per
d05d666977 (git-zlib: handle data streams larger than 4GB, 2026-05-08).

The logic introduced in that commit performs a clamping to the bits,
though, which fails to do what is needed here: If too many bytes are
available in the buffers, we need to clamp to the maximum value of an
`unsigned long`. Otherwise, we ask zlib to use too small buffers, in the
worst case using 0 as the size (think: a value whose 32 lowest bits are
all zero).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    zlib: properly clamp to uLong
    
    I re-read this logic earlier this week... and I am quite convinced that
    it needs to be fixed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2153%2Fdscho%2Ffix-ulong-clamping-for-zlib-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2153/dscho/fix-ulong-clamping-for-zlib-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2153

 git-zlib.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index b91cb323ae..d21adb3bf5 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -38,12 +38,17 @@ static inline uInt zlib_buf_cap(unsigned long len)
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
 
+static inline uLong zlib_uLong_cap(size_t s)
+{
+	return s < ULONG_MAX_VALUE ? (uLong)s : ULONG_MAX_VALUE;
+}
+
 static void zlib_pre_call(git_zstream *s)
 {
 	s->z.next_in = s->next_in;
 	s->z.next_out = s->next_out;
-	s->z.total_in = (uLong)(s->total_in & ULONG_MAX_VALUE);
-	s->z.total_out = (uLong)(s->total_out & ULONG_MAX_VALUE);
+	s->z.total_in = zlib_uLong_cap(s->total_in);
+	s->z.total_out = zlib_uLong_cap(s->total_out);
 	s->z.avail_in = zlib_buf_cap(s->avail_in);
 	s->z.avail_out = zlib_buf_cap(s->avail_out);
 }
@@ -60,7 +65,7 @@ static void zlib_post_call(git_zstream *s, int status)
 	 * We track our own totals and verify only the low bits match.
 	 */
 	if ((s->z.total_out & ULONG_MAX_VALUE) !=
-	    ((s->total_out + bytes_produced) & ULONG_MAX_VALUE))
+	    ((zlib_uLong_cap(s->total_out) + bytes_produced) & ULONG_MAX_VALUE))
 		BUG("total_out mismatch");
 	/*
 	 * zlib does not update total_in when it returns Z_NEED_DICT,
@@ -68,7 +73,7 @@ static void zlib_post_call(git_zstream *s, int status)
 	 */
 	if (status != Z_NEED_DICT &&
 	    (s->z.total_in & ULONG_MAX_VALUE) !=
-	    ((s->total_in + bytes_consumed) & ULONG_MAX_VALUE))
+	    ((zlib_uLong_cap(s->total_in) + bytes_consumed) & ULONG_MAX_VALUE))
 		BUG("total_in mismatch");
 
 	s->total_out += bytes_produced;

base-commit: 7a094d68a27e321a99c8ab6b700909e503904bd9
-- 
gitgitgadget

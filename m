Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513C48424B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632986; cv=none; b=hjoVGcpKaGN+2rTBgJeeDY7G0NgVjIZQS5jajO6CSWRAbODc5iRg9OImBpAPVztHJtx/3uN88e+IfILYiJUF3CFF20BwF/Bt3MeXo5ZlxpUeA8Uln38aC+Y+wZAKQoPyKYBmRMcXNdLVmdTszbLuDOuigglU/iBXkDHA9ZEHTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632986; c=relaxed/simple;
	bh=VEJkkHMHhg05qF4D/ErPkzz6gaD3DIPmaLl1UK8OJVI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HGUzwf4++fRwR3ghe7Wg81R6UZPnrTFa2S425nSsIW4DCkjLMODUfcbFo5E0lBtpbPuOLtq42jsGrSCObBB52eVgCMgoo2A2sVxq5Jv/f+bDllQoZQw26TYaH3ZpKBLAS/7sO3g2vAcMCEmB4EpXzvjCVThPjx5AE02lPFBsKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6wDQGps; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6wDQGps"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a483a552efso274480b6e.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632972; x=1787237772; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/CKWpgHR6aQEkTnThiYfORiqZv6z8VRODX2UwRWmJJs=;
        b=G6wDQGpsV0XirbOScPylljBT3sQXxV6K89dscjaZbIa/PhwQvvqh93qxCfwKiDli/W
         YEdihfo3LPAebvgX8Yo0EA49CeP0vhlFO/js8nILaubZJbgt4yGWgpwUkcIlVwbPWA16
         ug2S4AhbSJk+RoeR2XTIBE6j3OIWxLO/s1sGofU2p1JQysNGl82IY2ZAsOEsmm+3X5pp
         L43PQ60KpVtuKxDqJ5+pWsFg6mJT0j+6pay7YCQ4FRoT+v0KEndC4b/u680fZIkPP9uv
         DDFnIdoHrfcNIXS3oVbYwh8yoqYFYFR/98xeQ4aG2CjL3yniUmaYypOQxjmO7kZmnyKg
         XumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632972; x=1787237772;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/CKWpgHR6aQEkTnThiYfORiqZv6z8VRODX2UwRWmJJs=;
        b=A+r+4wE2Dp/e4sN/2bUjsqv/Q4Hz+VaqEdYrPr+KT2Ga+Ms5YGcHOiOq+tWueUmOd2
         TWXMbYeVt398l7VK9SlgcI7pcedcVwH1TAM4r461HhQbrlbGSHdFaaTPfg9upX6LZ3JY
         jfGG18BC7X+8X97YHeIPqzvv+prP+4dfx5IIobOjeP5vGVKlyYkL1O/uRNgc5mUC+6sm
         lOKAl0w+sjtYg3ELOMADzalqkrpaFfJnIDh+ujk89PMdvFiqHzH+oCl2rSK/Kl6M+uFn
         mRddEhIIsTS4EWxourVaCI7esZGz5F3qBskT1hV1HLG58/uN+/GMaQ6HoiBsUsv0tviE
         WsdA==
X-Gm-Message-State: AOJu0YxL9AvqkfP7GG0gHaXgmvBj8WEn49VVNLvDoEIclHpz1mq7JVcd
	v74Bv9zEIYm8iwdft3nhmyF+6xF9qr4Yc52YKNfrq86fiN/sJEAoJ54CUwrODw==
X-Gm-Gg: AR+sD12IGTMI8EbpiweFkoI67O+Ihl01YuI10Julw09DQ86KSN5+kOb71Su+KBC8vfP
	rztKrkzut7ysN7snetwzgV32Zf1mVvnAkQqSo8/1sYTDusB5yTfyoS/gRzpXCsbpP0K/hzPO5Ux
	qBCYgDkiwbh2T6CLZydAGqMrhGoTzAThLUxo3ABR6QQkNGN8tTQ9xdQXkZV2jAQQX7ajgTIeMbf
	wHNUDXBu7diNe18rO627TmHdt/ObOi3xNHz/k9PKAekVK7dlVM9stv+BYh5czSwRa24MZkJIKiv
	ehCeW4+sYDhx8Y9edqhiwt5mLvsM3HRkVrRove2hBNHzqJVyt7BO6TSMC9WC2KiEKAq0A1i/NUT
	IV5jIOyFk8zAthA7Z28caEO3ZKiipqy5gETTGLo8COomHWXiBBDNlMT/h6W7BvHU05QYLwSPlOW
	ISWlrenSfmteD4QTWqAisF/asnz6h0spODclXeRw4DUaotkZ6qrWyHkNkovAyfms5N
X-Received: by 2002:a05:6808:4fc6:b0:4a4:c12:49d9 with SMTP id 5614622812f47-4b2277a8217mr6513076b6e.3.1786632971911;
        Thu, 13 Aug 2026 07:56:11 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22cfa41f6sm1734594b6e.13.2026.08.13.07.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:11 -0700 (PDT)
Message-Id: <b4004b106709f40ae358246631f5c78ad46aa397.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:50 +0000
Subject: [PATCH v3 12/13] git-zlib: widen `git_deflate_bound()` to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

All four `unsigned long`/`int`/`ssize_t` receivers across archive-zip,
diff, http-push and t/helper/test-pack-deltas were widened to `size_t`
in the prior commits, and remote-curl and fast-import were already
there. With every caller prepared, both the parameter and the return
type can now move without introducing any silent narrowing.

For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
`uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-block
formula (the same fallback it would itself use, see
https://github.com/madler/zlib/blob/v1.3.2/deflate.c#L832-L928 keeping
in mind that for large sizes, the `storelen` would be relevant, also
compare with https://github.com/madler/zlib/issues/549 for a fuller
story) plus the worst-case wrapper overhead. The existing path through
`deflateBound()` is unchanged for inputs that fit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-zlib.c | 16 ++++++++++++++--
 git-zlib.h |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index a3b32d9a86..1c94f90497 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -167,9 +167,21 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
-	return deflateBound(&strm->z, size);
+#if SIZE_MAX > ULONG_MAX
+	if (size > maximum_unsigned_value_of_type(uLong))
+		/*
+		 * deflateBound() takes uLong, which is 32-bit on
+		 * Windows. For inputs above that range, return zlib's
+		 * stored-block formula (the conservative path it would
+		 * itself use for an unknown stream state) plus the
+		 * worst-case wrapper overhead.
+		 */
+		return size + (size >> 5) + (size >> 7) + (size >> 11)
+			+ 7 + 18;
+#endif
+	return deflateBound(&strm->z, (uLong)size);
 }
 
 void git_deflate_init(git_zstream *strm, int level)
diff --git a/git-zlib.h b/git-zlib.h
index 0b24b15bd0..9248d11ca9 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -25,6 +25,6 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 #endif /* GIT_ZLIB_H */
-- 
gitgitgadget


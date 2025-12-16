Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA1344038
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899240; cv=none; b=elGEH2Vihartv3CJqdPJ64r+7/Meg1FleARzjIV0V2BPWSq58bqK5tdKaEZdFJ4HelTG+D3jyJ83OAAwKedPx3BVz1z9leSCROqR4XbvnkACaovJuVqQYQufYPMjcbavuc2mMcheOaRjKK1PAbkL1HFoeG3+Vgi5dtFNxm0rcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899240; c=relaxed/simple;
	bh=5WkFnIXTsTF5e+sKWu7fXN9bZBtF//UBtNLh2A5rl3o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AbYBnGzw8ZBoTGWW/SxhgLDb1dU3c3+z3DU2prphw+aVuFPuUI0yfICOLpbxLJfc2TXSMUA64uH4LerZJbUtDUyQ0zl97ZSxzz44/nr7TTEZwuzxPhDoCWhO+bn8ZgC/SyimA++Nw2lmw9F4apTmyobC9QeNkHNoFscdMjB1nLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiNCNFjL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiNCNFjL"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88888c41a13so56191286d6.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765899237; x=1766504037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niJVurGLRc+6PmQNk5sO1H1BPtBE2BxlOsOceKU+kyM=;
        b=TiNCNFjLk0EJ9U1sMCq3Go53k9csI1mKXPMpYmBWLuQaMKce7QdN3jiwz4cjWyMxkl
         BX+j05GqIKYjIaoJ6MS+JDY92u2tBqScGldob1qnWPRk/wn8GI6yRnbey2JG5VnarS8o
         Qn4YzX9QQsEezeiYm3wCxoL1o7Pe8hBt9F3WHyZidQguQtX+6x3ZyUCGTPsxz6uOamJu
         PPJPkop5XYlBYwDTJC9o/loLPAhFE+VmHRys+6mVor13arlaGa46Wx6HqhituwiNWqnF
         UOVwRkNb+i+xZ929KlOhQce1x6g9xi7mRvketB6TROo/e54RCBnBWvQDfIJn1QeW25JU
         h10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899237; x=1766504037;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niJVurGLRc+6PmQNk5sO1H1BPtBE2BxlOsOceKU+kyM=;
        b=JDFB1WkEZNDvUw9AsWKELjREGaLLZtawsmAKPCDR/cHYBsaR5wC1k0CXaxtBKwsVwk
         AdxCSUMU8zcbP70/s1NqS/i6eEPv9h4pocN753sRKgxLjeiVqP1MKjUYE9SDpSogdwQq
         qpS9UIR7azMdDg/KNq1zq+Gp4y/daIz2Hizt1Tst3BxLdbs38i5SLHgYp3itV7JO847C
         t+anWJIWAkoJbMOA+spEs2t0BnedDLb0LE5LwFC8/hHpYoBPqJ1QzZu2QLUi98PxFJ/8
         rKs3gcUPKKabhuYaSaJaULz7uQJ00fD539VC229ZU0DX6Iml5OpWDAXZfolxsgurc2F6
         FOWg==
X-Gm-Message-State: AOJu0YwNmpZUmBlOW3DGjA6s/d4PlbFGcKP3KVbCmas1COX5zxa4cKpb
	ld40/lHPsb8y2UGxwAHb42wA50jIjOHZCzRLn9l2Py+20EfEws21Fm67aGFrEQ==
X-Gm-Gg: AY/fxX7T/1A5GY+tTYMSCLX+cTGDbkjQ6MMJnSOCNJ/0vvjDEpahX9ZDvTFmnEGqMkI
	RB9sR3HEtbyBj1jK2OEDQjAPIR0aNkO24mlmvQQf3RX8x4kUIg9Atzh63w9eH2lDh1wnP/AUL4r
	7bRoFp5nd8sbGSjzsM6XK/nJrFenyuCXBn28Id8vgaYZpgKgvHxHclZTLbqLro3of7yiIt9MxQ7
	lT6cfaoZz3ESyTXKAg/0v7kwTv4x7Dywa+3dpYowVdyt5yfKO17+SpREefTWBw/H7bLVDwYIXqu
	cEyAtmanNzB0i66KXAzrQlfszeZJ5h/md8ZhGVyl1PGET/GeQ3DDpaqFZCuGH/rkm+A/7O/yVK7
	QIxCr4gJVHlJ2KR3jE8r53Yp4Qhi4PkkVagdLIUBKRv0b4T48HPVX2KkVVDydlmNjg/t3G3rh54
	M079NyRcyEag==
X-Google-Smtp-Source: AGHT+IHIHtDp/BOFllaN9IEWALyaj7YRLsW2Qh35ozzFTtqF5Nb59BUfmSnmFfi5NhtbzSuGXi7HVA==
X-Received: by 2002:a05:6214:518f:b0:888:5924:c9a0 with SMTP id 6a1803df08f44-8887e019d4emr210263036d6.11.1765899236632;
        Tue, 16 Dec 2025 07:33:56 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b5c015sm76254306d6.15.2025.12.16.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:33:55 -0800 (PST)
Message-Id: <3521180e0f73298be7258256289b5852fedf7750.1765899229.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 15:33:49 +0000
Subject: [PATCH 5/5] trim_last_path_component(): avoid hard-coding the
 directory separator
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

Currently, this function hard-codes the directory separator as the
forward slash.

However, on Windows the backslash character is valid, too. And we want
to call this function in the upcoming support for symlinks on Windows
with the symlink targets (which naturally use the canonical directory
separator on Windows, which is _not_ the forward slash).

Prepare that function to be useful also in that context.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..67082a9caa 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -19,14 +19,14 @@ static void trim_last_path_component(struct strbuf *path)
 	int i = path->len;
 
 	/* back up past trailing slashes, if any */
-	while (i && path->buf[i - 1] == '/')
+	while (i && is_dir_sep(path->buf[i - 1]))
 		i--;
 
 	/*
 	 * then go backwards until a slash, or the beginning of the
 	 * string
 	 */
-	while (i && path->buf[i - 1] != '/')
+	while (i && !is_dir_sep(path->buf[i - 1]))
 		i--;
 
 	strbuf_setlen(path, i);
-- 
gitgitgadget

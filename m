Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C7383981
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940016; cv=none; b=ua1+ar+aL3uQm9KKSvCTBmrEbOXqZQmmz8Id8tHYsP8MTCyF2yk55XAXBfeWWLQfugYR2Z1bhlWjUrb4Zy8C1ky9EzAj2Y1CsAN5h775K+l7qbQ832oOODFCkcRVQEMxvEpKPVdhvSwFBPLmv8aloD630HQh4yS4tetkphFNuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940016; c=relaxed/simple;
	bh=T2gc4X7ZZRpun11O9hyf1XCi3A6a+rsn+E8Qx1Vrtd8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NvTYuaw/sazwYOFvlrWT91xA51hX/xQn1e/pNhI5VO3bnYXrV1KtumDxuxL+BnNsYaIzHDJZABA/o0TcrVAsb0nvKisB1W+KejI/M1atWBXuzo39gs6f1nYMAuppJypjGknHGh7tSBH1Yxp9C/QcGPZeQx/FdsDXBuJlU+dZT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDX5A87l; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDX5A87l"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff20870ac7so6688076d6.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940010; x=1786544810; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=mDX5A87lpdPB17Rbo0IAL5SMC8/bjRbnREH3HK8sGKr6lfuWbIUaDVBXiiVyGL+zyC
         IF8X4TKFqa9Ar+bwYBRBLr+b8Szmu1qiCIQiDz5VSamgUQo7pSXpP5T6yocnS5M+L7MH
         S8rS/nh6M8y75tehtwDOiqOYSZn8wO3rT6x3otANT6BnD1di2V4IFpxzo7FFBIQEBy93
         0gHud3nj1kNtIB/9E1Mux6zVDvquIfcS8V7gw+G2UW1uJd+rBjaPNfP8E4wT8cQTTn8T
         q9sBzQC6Y63kQT43cj82jTSIQBJRVjp4PQhCk1RM1quJmJWXTg5ve8Zh6RoBaxd96Yok
         3irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940010; x=1786544810;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ILyrVVd08nn+N9cu/FXvgcHG6hzZpAgakTjwOtMYuNY=;
        b=jaUT5whMp1zMbVJWOq6iXwz6SAl5QVTsE0JDNAoXS6DsAkMLlcLZFcjUexmwK0iCBS
         yxOPPaHIO4bjgTEcd7FZLvgXExT5LGfSeeMKT1AxIQ6j5Sa5SLSwQ3mRltFVJ/svxqvg
         NGqMndVgoCjITcG6q2dYvUdIG9cIBvEKwMaA3Qy8Vhe+pgrPUhtmRdPjNC22VZTQJY0+
         HIpikmNJVDTyAzvUHvysRAximGHfTNcqxBErWo6XKL8bQ34j9OfZWjhwGwuVJK9Brea2
         shZ8kg+WlKFBVdqz+oK9LMvVkijHjlmGOVt+BYakoJ3b7Hak03TrE6i/Uttu4apWKtCy
         WlJg==
X-Gm-Message-State: AOJu0YznR/YOO0V3vRYMOtjuOBzT3VNzFw1cpuYITHJ3OWQI6iEbwp7S
	5aGDjeFGbsWxhgHtynnWqaHFbUzqIqx1ICv2Zjw4mXTetck4epxva3bCHzCL2A==
X-Gm-Gg: AR+sD13pEflqY5fX5Ne0BoVzuPqj7TN1EfePaRz2LYoodBXNCPPaPMfMxRnnmGtiK16
	uKrcoUYyTjFK45hO1JlvdLRPAxnfQoxQq0+4M05gfW7n0ijQuqTcaeAJ0gVqR99PJMlDrxvMtj0
	Sd/on6pyusPPOzWBfEOvZz5L9irA31dwl8+lbtRm6pHLliyn/qNSExW+tKQJEH8F36wULXGXYvU
	vevBaiPkL87UEeWlRddjyzrZPuAOReX1v/jtdhAoOy9Vxpm5VQfMAkYsITWRqEn1LA3yQHJFJdw
	VN8QknQNAZBMiRGR+4xjdTUHCz0wm8HhbmRwTYY+3YFMZM8vP9fWEOmYMKxuUrGQSiX1fDIutfj
	MsDQGB2c5aAdE+GNONyZeMuE6t8PnsWFVxDFiDjigSt91Cppp72FU6rbTznmS04/pa5EKUsD2cK
	g+62HPu4a2mxL4BVuEwj3F+Ai9KrUqKquf2gq4GfCw47aWtF/jdmPRvgr7tHZHaAY=
X-Received: by 2002:a05:6214:252d:b0:8ed:a980:6b2c with SMTP id 6a1803df08f44-908813bd801mr81427336d6.30.1785940010430;
        Wed, 05 Aug 2026 07:26:50 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9088008e99fsm27037216d6.24.2026.08.05.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:49 -0700 (PDT)
Message-Id: <d67201f9b3ad288373fcbb73fed15356b7a795d8.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:31 +0000
Subject: [PATCH 05/12] mingw: avoid over-specifying `--pic-executable`
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

In bf2d5d8239e (Don't let ld strip relocations, 2016-01-16) (picked from
https://github.com/git-for-windows/git/pull/612/commits/6a237925bf10),
Git for Windows introduced the `-Wl,-pic-executable` flag, specifying
the exact entry point via `-e`. This required discerning between i686
and x86_64 code because the former required the symbol to be prefixed
with an underscore, the latter did not.

As per https://sourceware.org/bugzilla/show_bug.cgi?id=10865, the
specified symbols are already the default, though.

So let's drop the overly-specific definition.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index b667c693ec..f6387f4c7b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,15 +757,15 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
         else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else ifeq (CLANGARM64,$(MSYSTEM))
 		prefix = /clangarm64
 		HOST_CPU = aarch64
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		BASIC_LDFLAGS += -Wl,--pic-executable
         else
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget


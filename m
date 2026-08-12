Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F93AAF78
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521189; cv=none; b=fCI1DR0elgDgVHgwcp5ox75fMyW3fx9dFlxt13T6xCSfqXfxJm+4kkiONOqY7gcei81Ev55BJ1Mw3+Y/zf/O7DAkn/1u6eVSixFTkD6Pw3VtBCqD4EQ3xY38sICNm5w4ec234whRtDf4E/7o09XesEqih0Mi+/V8F/RtsCINIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521189; c=relaxed/simple;
	bh=Aq/afT/Zb1a7IfMLveiEW+HqgjjJmt2Rfon5Fw//hIs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FWg2qMdpFnPfDfLwiVdSKLP8FQ6KlmYLlGKrAec+y8P5S4TRMcO5f+hEpdovi3iu4oivXdAk9RScgl5oyWj+5asmA88f0cNMvII6L/qOXs13lvc7w6m8MBot+CGp55w+BY60bm3q0yj3P7qqQRtSOrF8G8nRjxFxFRaecoqYtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjGLjtJ+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjGLjtJ+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso619483a91.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521184; x=1787125984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=XjGLjtJ+P2cpsrF/8cAFDdRgyjL2m9t+R3Xxj3JToPMfmdYvV56VXNb1dq6bS4Ycnw
         VPA7P83jkY9xE5E6pxlu8ChcsnWkBQUs8QcuE1m8H+qO0kslTMvc7hL+Qx0ETR6EotnU
         LkzxVmFeiBSi1PpP/1AWZTE9G+BbM31+woDJDnCBXMifcF6p9cYU5UMljUGA3ckx4pJ2
         wR69ZNZ5sRyDJk6uYAsClRt/TphIZBXMYaRROeP9a9FwoNVz+XxUxYkfUCt8OEKmAs/d
         V2VxJlDH1UNp4kSdVo15HFM8xJBv39UfYQnpvvRdXqJHhA/dqHsLmWLTSVpdbB/S+Voj
         D3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521184; x=1787125984;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=OEmAN0nwFg0vM/CkUyIL7PMU1os3n+PPZfeci3Qlsm+Kaastvq5BqKRoeRsc1bx5fh
         l2Euh7kBy8QH5bOHhQIAxiz3o/aoCCYkrLiLPFugKjZMHt1NQ3ADX7QLCluR/LG+O0E3
         Q17OAq5I9OxbNf5gPhLO+okhAloqzoznG+tjvMQqaWTk139J38vaX3uX0PYZHlO8h9Xy
         PF4W1YxfggH2M0Hz/A1CRha9QP/RCNLxdhj5MmZRLvVEBTJVrGi93wFwK0CF8tB1dMUE
         wGrozXAhULHL+/ymBDzi/EAud/c3TSFIACHLSjc/jzMYtJjWDCXmp4UP39SkARmVVOgl
         h5uQ==
X-Gm-Message-State: AOJu0Yxt3k5Iy/0+iiAxj5cGQg8olfPYGSTel8ohxxbOAncg9ZhgK/MK
	DWnb0puxujo0Q8TcTjIW+6hDOT7ha6XaDfmcLochmhYDXeQfbpAiOUKN7d5K9w==
X-Gm-Gg: AR+sD12rqt+lxpPceOp70bULgnj+YuE6fuqBXKnOnc34in6M1kc9uzzBZY4zaafjUQx
	S8m09NG22BWIXVDXofrE2iOYpj2YGQiR1WjLb+G1kXAMsX8tAXRoiCUZRNAN85CkNfIgX5leKrL
	iuiDYN1ZE5LcPkqCJLYDV5YzULw27toaQ3TwnU4ty8FWCoZbaeL3HPO0sVQr1qAY1PbEHT//IL0
	+necqAHBQZhsAH3Nw1yktbjrR6A5LuaglLAgWDA357Gh437Ms0lWttJ7yVMnRPWbS840iqXzmGV
	0BsVG1Cgfjj9XRIYeM+8Ppw5rmt2SL0W0rzij2dZzeJ73SM0ca/nxeNJqcQ5/7oIXczl+wsG2Zx
	jjIuOtaUfJyNACEl579y/CiwFxbJvdZ9hLvezoXO/34e0AW1E04sz6wNEPFQK9/Pk/ERJflUns0
	CWe8uelFbQS8d8akKTEXgJXBSEol0W2v/ZlPyDAbkFRTT7gx48aH5ea9XgsrdHLcyN
X-Received: by 2002:a17:90b:4d0c:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-393014eb4a9mr2973576a91.16.1786521184478;
        Wed, 12 Aug 2026 00:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94add3asm2472477a91.12.2026.08.12.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:04 -0700 (PDT)
Message-Id: <b49c42c50d0fdae43224b711ae740097e9343d53.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:46 +0000
Subject: [PATCH v2 06/12] mingw: set the prefix and HOST_CPU as per MSYS2's
 settings
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

MSYS2 already defines a couple of helpful environment variables, and we
can use those to infer the installation location as well as the CPU. No
need for hard-coding ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index f6387f4c7b..8363239513 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -754,19 +754,13 @@ ifeq ($(uname_S),MINGW)
         ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
-        else ifeq (MINGW64,$(MSYSTEM))
-		prefix = /mingw64
-		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable
-        else ifeq (CLANGARM64,$(MSYSTEM))
-		prefix = /clangarm64
-		HOST_CPU = aarch64
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
+		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-        else
+                ifeq (MINGW32,$(MSYSTEM))
+			BASIC_LDFLAGS += -Wl,--large-address-aware
+                endif
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget


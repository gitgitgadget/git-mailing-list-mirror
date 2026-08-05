Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264F388878
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940025; cv=none; b=i+lZlMaTMUhOr8JDaktEA6CbAoOXJ7C3sJ1zSkDmjJWA2Fo95g0G0P1s6HKRuI/Cau8BCQ/SvCSyl9Ht1U7t8JPK9BfNuFljLjTPObPrwEr3CWsLP+g7CPI4tzADxwV6Dq7FOZCGn1avYiK5i/HSLb01Uw4ijwLcFGe57orUFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940025; c=relaxed/simple;
	bh=Aq/afT/Zb1a7IfMLveiEW+HqgjjJmt2Rfon5Fw//hIs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oDNQ6KErWpaGFUm9ABvVnorldTr9s4INAHV88oFoEh2Nh7mPzaR+Pgfh/XoZ1PMvLkEdCTQlfHeaOyH7Kt1dQGr0IPNTBijTeJFMPATQseslRnSXXw7I2ZSsSjCU0xCiLuHjTVd7kHRyLve7mA3RjS8e9VFs+hPA/X/q/ayJ1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhn4uraE; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhn4uraE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso8966161cf.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940012; x=1786544812; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=Hhn4uraE4A51lfyrlUH2It2h+M7o5tuz3ynDD3tL+62Nbm3clpYC0vYfg3N2/FWWDA
         74YAux5eNBJR3vB0FoNLBme9AcQvao0wKAFjqz2ru9OuBk6EkVxj2QwAXlpZ5TEuLvaA
         Jt5J/ZfaDjbP91BGb2AyZjBBzpJQdAEgxhLn+unxwkmZwKVJcCN7arHYrmU2SAGo/fIF
         Cl8HLykQbUQUL8XB95ZViA5ZKc0IWYHDIyQLVfytopisme/75gcQKTULGfsc1tv2eplT
         lJ+IXmPH3P85vORQVnEss+4Tj3TCCRQoNBM8NylbjMlPGpZSXoDmSAfEt/nCLbYUTHuv
         2e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940012; x=1786544812;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=qrqynDAXwh6HhSkABZA+aGtQW6c0SfWau1xwsnRONGBM4YQUWScLlLHSKtB2+Ujdkq
         hYOjDfrKkFmpkSNw8uROLJ6boEnR4V7BOQ07UMeGBzU4FkRRrCPAPozIwzWr74hVQzzu
         zqfu98tkxvURMqvErlQ0md8589wioEaGJcxSWenmcApMWfUeJma5ONhntXu4ZGquMgUM
         7hK25HXwv6DBgY/6WhkfhlAA8s6RexEl1LZ/1d+rARkpB5KuIwA115WQ9UXu7D7R79DX
         RukJHI29PzkQmZxQiajgwI8LiZC27QpQoArle3XYDag/caM3e18RVgWXUGfOgKrvlBHp
         7zeg==
X-Gm-Message-State: AOJu0YwCHeyYRZESeV6KNGmZ1KMUcXVfyMmA7bP2OmUsGYJ60FNe88UC
	t7D+c3rj0gn4Y9vjdyBgDaq1n0LxHnLAT48//0lcTkl53FwvmKXNDP12rnpjDw==
X-Gm-Gg: AR+sD120si+iQrPPdQgN0GUf7OZ0hbUD3FtM9ULfGcgXNkmr1+OM219oe+cIQepupdb
	sQl6hspMAkmvod9lI9xA8GInEru1OjGROt9ssiLsfRXWyEPXcbyo97HKcDnFGRKV+89M5jduvcR
	gy1DJUN73E1mZCamoYd/vp2WPXNvCtRw3rESZ3ETgV0GYETqxS1WtGnaQsJ4+hChnd1kPsDlGT7
	2vZao2tyj+ETq98XatIgAe8H6ECfV0VZouk5dQgyRtxa0XpQTggmSmHnbb9KILUBOBNARTLYCvs
	KpRYfEC90UdQbYlUI8HIxVOgBXllkpJsuJ698fT5ucqMl/iLeFivAHlWLJfp06PGGhreqmSZCA6
	73uEnpHgDpgCMPfc0WSSfMkwPskgeWKJ2SVeAOJk5jQx1djzDgUTZiXR1Ej97mQXaYuJMb+IjQQ
	CH9gQ8G52VQqr/jowHvatQMGQOe9KsCipVmQOHveRxvisTMbkEoVJQM50ef6J+/KY=
X-Received: by 2002:a05:622a:13d3:b0:51c:2190:3b47 with SMTP id d75a77b69052e-52ce607a987mr68363271cf.2.1785940012447;
        Wed, 05 Aug 2026 07:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce892a3e2sm20978191cf.19.2026.08.05.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:51 -0700 (PDT)
Message-Id: <b49c42c50d0fdae43224b711ae740097e9343d53.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:32 +0000
Subject: [PATCH 06/12] mingw: set the prefix and HOST_CPU as per MSYS2's
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


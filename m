Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1ED3A963B
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521186; cv=none; b=Krg4NuytQf6SzMG+XJKadF4YvjNlWOadGhlZViCQ/zNVOx4ysudM8jGgB97CcJSKUtFzqRYD4PW0fSs4PADY+N7PKCl5df/CZiPwe+DWWssrxZVaJBFk6e0e3g/Jm0WDO8/CLw1b5Ydi7gDLhr7xFw/E0JogE+BjqAVYNy/8270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521186; c=relaxed/simple;
	bh=E5TAcKaEOCi7ReHacavmPN3FxQB+iBTnP9fH3OdfmNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fG220AUUu7xhXlkGdwpsg68zdpvczs2XNpgdfp7MuY/Ut6GyLAPagr5qwAtbG7sdfWy7VrdW7+q0M1beq8Q+Ec9KV+DDvFfQVh35y+hfGKbfX71lmqG7kC0qCgTduUN/oZv/lwmO0IvnQxvzSyWLdbheWEEpXq3iQp4GfbWT7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoVn3iGJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoVn3iGJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf27856f9cso5341445ad.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521182; x=1787125982; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=WoVn3iGJh7ol4v5ZewvoScll6MYZcga1U8aCnWspsQtRDHW7DPcSzXaX5VCL6yhDt1
         7k58+yWwwul2Q+DAHh6h9DlPqS5WjgCovE9zdQwjm7S5LEtYm2GlBfbMuqemKH5ksuj6
         D2xpNzFUjWkNgHLlcJ8ePyFsM5h3yAP2B6WwBdiXB0iDz3uS1t1TzbJgB+TYKPsqDI2t
         iHhvgkKSOqCxA92HITKT3rNDvfCIVvMUigVinqzDHkS4c6a0v8MAq9Ke0QTXyFuq5R8r
         sI5wEafScApVwjUSCun2OGRzZtjXXjUDkIHCRxDMiuttOli1E07vsV5b6juqIGA10TkP
         6zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521182; x=1787125982;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnTtnwxcdY7RASz7pb7KoB8/awq+9cPpOpxZ/RWp49s=;
        b=QhmiqW1+b0N0WC5YRY5ABG6ffiHyltVaYyuOOjIbaTV1EtqC1dct6W4OOEeAzfBADw
         6p+QKyaXsAqDk13rLx/08P7ahvYylb0Y+5j0rqScxid0eg8CMgrf1zG1d7W50XMXPUEZ
         i2Man20eKkwHMuovltfSbbHYs5v8ucwysuVqeAry9NGW15KLfto9GrvgtZ5g0NKt6pia
         nZ4ghU96xxGus33choFa+upSt2/D9fiu/f4NmbF3qMNjTzy4ws3+ciWLGcMCzGkDTzCE
         WTSZkYUFb6Fn8TOdu6fLnIrNCOWLL6QTinswkgSg9BnaugtM6Jo8Chhk48+Ogd1L/KbZ
         ppeg==
X-Gm-Message-State: AOJu0YzFp0m1jzzAGPDgfCpIQjxA6SoOBa48UVTuGbzjiO4FMoBpuT7x
	UcRxCay+K+p13fF0XmiAcMJvxQjOxHCjOgbcNenIvzOs/LPLlera+ff1Aw9zBA==
X-Gm-Gg: AR+sD11BnLhyx0oHnCw9yLEWpt7YMpTeBJ2FgGn9PVYMhrDLa+wP2A9qS2Ai49K3C3R
	BdD9h2CPJ7GMKXO2Hk0hLFZaFzdEJp793qiPO4fPLEOUr0UQ+OoplwRA60bmbJVirgLtofxd6P5
	vjIKTeOQifVAyCE+FgkU9Wc128vrepCVdkM5Gd78zXtu62MQNJV7eOwpBm97fVzs1J+98rE0PeS
	Fvsjh68TSVVoQ7dhc5RsOj1RlUnryRMblgaW7U7TZJKtNlW54kqoV4xNGXlMKcENtlc1qbOg4xc
	y4hoq6UqcsdLUfV+jw6vtdI5xKrI4eNeROBv0vFGHMpK3uAatBhS4WJVzwSETfui7I+MT8ZaZe/
	F0aDNWUux0dBibeSBGrHWSAFxBzPpaT/rNaGift5DZ4WfsD7Bg+e44eI9D1Rulq/9B1axkmb+4d
	o29r62YdXj+gIRwyP3OEui0xntFETbqWotlXr6aVoguH7pCAuaqJ7sYqtAJNOaQMAb
X-Received: by 2002:a17:90b:4e8c:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-3930165f4c8mr3323116a91.14.1786521181658;
        Wed, 12 Aug 2026 00:53:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8e69789sm2565576a91.16.2026.08.12.00.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:01 -0700 (PDT)
Message-Id: <ad96aedda6a2b22b80200a035b714ca111b97cdc.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:44 +0000
Subject: [PATCH v2 04/12] mingw: only use -Wl,--large-address-aware for 32-bit
 builds
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

That option only matters there, and is in fact only really understood in
those builds; UCRT64 versions of GCC, for example, do not know what to
do with that option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index cc0ed63af3..b667c693ec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -757,9 +757,8 @@ ifeq ($(uname_S),MINGW)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
 		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
-        endif
-        ifeq (MINGW64,$(MSYSTEM))
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup -Wl,--large-address-aware
+        else ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
@@ -768,7 +767,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget


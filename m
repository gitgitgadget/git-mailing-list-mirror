Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67646386C37
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510419; cv=none; b=i+lJeBf3qWNm5CHpU2MW+SQg3a0yfMLGBU4yeBYD8btCbp4vWXw62sq4qYzWtzOZTD+4aP+kViiV43YW5e9RaNGQ30puVeKRSFJGNFyR2BQR1tEugXLDaqCF0R6IoHgZ4McCKjLw6KSziHvZe92QqqCryY+FDedDnbApK4z37vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510419; c=relaxed/simple;
	bh=vBFwfXTc+uqwxxnBeGkaCK4Kz5SDBVFmCD+451H8bGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JiBIzM6jPqAxw+2R9a2v8fw9Wh/56pxDyq87uCVdtLq/vktdtJZN+xiyQGMtS8dqoGFQiJwgbYCNSn/JV7HW55o5ELfUlERK4hWdBjNGoZRz+f2SECsj2lyzlpz5vFYWIsOEo9cBKE3XY/2EVTw9sXDAn8BhFGnWaqd78YrayU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fstSv65e; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fstSv65e"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137bd9ed2b1so4260888c88.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510417; x=1781115217; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8cADhpzUzfAZ0mJSqzUOwTJvEODHuH231VLH9zj2i0=;
        b=fstSv65e7R6c0q/Ix3l/e+21Mh47JN/1yg8JbVD/5JygPo6a6uJitpKCCxT0W/TMZk
         GfesEv9sywFXiQDM/L9VQdBhv6+qv/i7tSJjYJBNaK37lZFZakAVtCZSGQzyeva038kf
         Vi9mu/dYvyc/GgWiXcQMMe+tRj9ChZZuEL6C1v6e4eqyDndmdxaU1GLBtJOlEmBkIU4R
         dgENOzhYk7dLClYxq60+F8UYLEAYH3FCgK7fcDZN7mP1nbmCU/5GUD7nsCLptve7FZZf
         6rUHzyL9tGJUDredJqcJBDAiuE9xFZtIfzyGsgAIljLQnkdlLHUp6mQgZHa8/viWVZij
         5+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510417; x=1781115217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8cADhpzUzfAZ0mJSqzUOwTJvEODHuH231VLH9zj2i0=;
        b=gA9Q9n8UMeGpJwgriJjhbaoxqZEYEBVC9mn8i2TWnUaUUF7nitxa9aHRtmRw5M5c4t
         1vvFI1pfQb8m7uS/eII09m3JmyEiUer8lvv1/Q9bJAe4rUSQvUSro6YHNvhY1ilbY23C
         qbWe9pQIGvITcD2bxJkjNPudw9VhvDrbCcTQu/HWAAeK9A+5emor2r/GztQsDDyrP+Cn
         b/2+7PtYokWJZVMxxJZrU4BNhoaYbNOY4sFsJ8w9D8+4dRfPpgNFupCTcYVI1QCfp0Iv
         jFJN2LHvOL/Nz6vi4AlG4NX/4yR4XCLDtiQcnWZNs098IOfrApBnZ3pzj+Df4pzJi032
         kiTA==
X-Gm-Message-State: AOJu0YxhmdDv0kiEBZiDtn02OVcIPZYogPT/wq+Aq3p83c/ntA097Uw2
	TC8JO3IRUyWa75E/df6E9TaT5tgRZTPR7YnbfTG555Q4+k39rX/w20+Tu/JfVg==
X-Gm-Gg: Acq92OHkB0mvFacelCc5bD81Hn6qs+aQnL23c4PuMKM8rfcEzRWt4piNMGDqOLFj3BY
	B3Xu0V/A/QdkpYl/+4xTsRb0jIbSyXolW4WvUqX1WK4dx7bcOkmaSzACERlF1LpIM64JIvSgX5h
	6lBAah/wGwnfydGNQXTur5YuQXeACWA2g9nE00qD5joB6w95OvyFouN8UnNjYpQGL6CWFFnwH1i
	K5ch5eK1flGVE8xQdokscudElVzi7ptw+wFkd1jLg1t76o06N3VlEJqi258yc3f3dpzDaXnQ9A+
	1NPQftD3B1mBr1VNWhT12Tt+ckxGcJbEWdkgOUjAUyRZAYaROL7lGqruxn9q6nsUJfV6EETYYE2
	enrlhTQHnecjoE/nB9wH9ZSNQp9LzC/8q/eQrvzzAh925ZTckSP6PoZSrlTDIzzGMteluOu5Yq8
	4MoErVTV5pzipAIiAPMwwHnxqPvkVNLTQU2eI0gQ==
X-Received: by 2002:a05:7022:f103:b0:137:938a:1044 with SMTP id a92af1059eb24-137f6bd12bbmr2116496c88.33.1780510417451;
        Wed, 03 Jun 2026 11:13:37 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.11.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm2364934c88.0.2026.06.03.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:13:36 -0700 (PDT)
Message-Id: <pull.2318.v2.git.git.1780510415838.gitgitgadget@gmail.com>
In-Reply-To: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
References: <pull.2318.git.git.1780477489662.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 18:13:35 +0000
Subject: [PATCH v2] git-gui: silence install recipes under "make -s"
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Several install and uninstall recipes embed "echo" calls that fire as
part of the recipe itself, so the install banners (DEST, INSTALL,
LINK, REMOVE) were visible whenever the variables expand non-empty.

Guard the whole "ifndef V" block on "-s" so the loud variants are
selected only when "-s" is absent and V=1 is unset.

Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
---
    git-gui: silence install recipes under "make -s"
    
     * Clarified commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2318%2FHaraldNordgren%2Fgit-gui-respect-silent-flag-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2318/HaraldNordgren/git-gui-respect-silent-flag-v2
Pull-Request: https://github.com/git/git/pull/2318

Range-diff vs v1:

 1:  b9f2b16a8d ! 1:  4e4029c8e8 git-gui: silence install recipes under "make -s"
     @@ Metadata
       ## Commit message ##
          git-gui: silence install recipes under "make -s"
      
     -    The split install/uninstall recipes embed "echo" calls that fire
     -    even under "make -s", so install still prints "DEST /path" and
     -    "INSTALL 644 about.tcl" banners. The existing "-s" block only
     -    clears QUIET_GEN.
     +    Several install and uninstall recipes embed "echo" calls that fire as
     +    part of the recipe itself, so the install banners (DEST, INSTALL,
     +    LINK, REMOVE) were visible whenever the variables expand non-empty.
      
     -    Wrap the whole "ifndef V" block in the canonical "-s" guard from
     -    shared.mak, and drop the now-redundant narrow block.
     +    Guard the whole "ifndef V" block on "-s" so the loud variants are
     +    selected only when "-s" is absent and V=1 is unset.
      
          Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
      


 git-gui/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index ca01068810..d33204e875 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -64,6 +64,7 @@ REMOVE_F0  = $(RM_RF) # space is required here
 REMOVE_F1  =
 CLEAN_DST  = true
 
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN '$@' &&
@@ -89,6 +90,7 @@ ifndef V
 	REMOVE_F0 = dst=
 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
 endif
+endif
 
 TCLTK_PATH ?= wish
 ifeq (./,$(dir $(TCLTK_PATH)))
@@ -97,10 +99,6 @@ else
 	TCL_PATH ?= $(dir $(TCLTK_PATH))$(notdir $(subst wish,tclsh,$(TCLTK_PATH)))
 endif
 
-ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
-QUIET_GEN =
-endif
-
 -include config.mak
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))

base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
-- 
gitgitgadget

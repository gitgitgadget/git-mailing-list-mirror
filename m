Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367074071FD
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780742307; cv=none; b=BQikyotZ8ayyrjCuYdZb97XqcIhfB4LBvtKdDtB0L8myvXQQhloWOPQW8z7LnN8+cUV9Gtnch9WDqx4YKjRP5wS815MiCSBeKVqr60iCJRNXi3NWhKNI+dYLW0WpATVqWIJFbadrC1d5yXxhGoDluf9eLDaaF9FKHoX7jBWQdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780742307; c=relaxed/simple;
	bh=A5FRn8lxgQ/pxspTPk3jdw7dY2znqvFZX7G/QliLKfY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MCn0a4Lor2Tgp3Bk3l+b3efJAE1yGg4Q+AbljH1tnwgwv90bvCzKrjTBtyuMvdrJdbhqQC/Jxzs6SODFceSN2kRoUqj4cFQbesCfrUbT5vEKQsaC6ZXr9c/3Kqc2KzV5TM4I8drN2lBriAIQk5kgMsLcE188Xi07gOGK8T6xwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVcOp9R0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVcOp9R0"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so30487886d6.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2026 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780742305; x=1781347105; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2xJeEGiX9yYC8rWZnHIYtineWHXCMZIrwpfHiCTzaY=;
        b=YVcOp9R0PzEvfwTLWV7lEMRcUjyXmk/AngItghfg49ERA6gS27xS6s9bGPjQdBH5sf
         g098oYkUMdPU+oJoi4K3tOQrEbYIFqX2IYX3VvmAveuocezBovApGEqJdMkZVDSG2bpJ
         nH7DFyqyOsEr/YzJPSoWo/zcQpTlkOgtFA0ga6tX3nZDA0y/ZCZXiTaKs6mO3KRFOSos
         l/iHgd4tiA/yWQuW+AclYcPy4vMbphYxbbpPE1tk+tyUpbYDynX4QhAHg5B9g+/I92Qi
         GIi9Y64v/iuRtxnb222lNquw2RygqjHJupShKX8Nj5Q1jHaYjOIR/vpfDso8YY5t3Jvl
         PxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780742305; x=1781347105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2xJeEGiX9yYC8rWZnHIYtineWHXCMZIrwpfHiCTzaY=;
        b=DtFEfwOBW9FFskeZh/Uxh3DN6JhkbzLa48jYn1NlJ57gGNexpBgjyx66CnLMBN7gsV
         3UdypnofGTuZHAZPFqfo1a1vm/a8nlvebl9L0YTWFs6Lfnzt1eUDl1ZWdID6T79HFuP3
         v37Lm0d4VVzT9Agxopfp2MGFg9Mk5urYUhaWbtjbtnRRodce+jn/umiXyO0EeRyGbqJG
         SlF9yE+xHwJpty5LI+PGrCMSapCiREOAeaKuNE9VgqY1nIJudGJw/woKlk2w8HCvpaRG
         mBQL53WpYdWOo78U7ro1Lrp1YHIw9RrIhdAJ+Y1bFp+7FLtI+gu6w4YLYBu+O8XqJxCH
         otPg==
X-Gm-Message-State: AOJu0YxjL2lVTFk5tho8SNMlJ1ueJ18kaST37CtPXokXBZoCfgk7uNHM
	GTmVL1/MENp+5ArpKWZleE3odN4KAVobhY84rNAUXonH6+m0D45H5nMSHHjOyw==
X-Gm-Gg: Acq92OG6wsbZBVeXblRRbzWchpEX7pBWKNBnhUeKHNpyM8Otqnn7xqiPCRjyx6Wsz/X
	YvMqpCtk3T+pAScu9jKdvh38JnDWOMcpqGeezqBOPcxm8VGHYBLHliCUHyxmSwp9kZ8R1xeqp4d
	yHWI+2dnACWeVxxFcuuu231Xt+D1KK9dncHprOoUzbPZPGcCbhlZspzaHJNTH6gwue8f++iQ56V
	jYgaDRhYraCPd2EBtYCaeOG+TbBgjNcwnilghUfSPHdbpxSORWojROdHyxjWeZX7uDkhKlhbxTY
	CMq4B2SaRSlK8/ffd7+mWnsgcVg839ZD1uuSljaYyitj2/ZobfR4uS+FhOovAy0hWPxAnBdSC+b
	KitwF10pSHvMw6ORjvZIePkNS/m9i+++lgZo9lXmmqVZoUXDObD2PZ9G/nAOhNr1wWgSuK7yUQg
	uGW9jU0oFhxkNgpi/OA3nWAkSGtiOxF1xJwqk=
X-Received: by 2002:a05:620a:2808:b0:912:1:b415 with SMTP id af79cd13be357-915a9cdf822mr1311668385a.26.1780742305072;
        Sat, 06 Jun 2026 03:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a402ff9sm1148737785a.45.2026.06.06.03.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:38:24 -0700 (PDT)
Message-Id: <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
In-Reply-To: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Jun 2026 10:38:23 +0000
Subject: [PATCH v4] git-gui: silence install recipes under "make -s"
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
selected only when "-s" is absent and V=1 is unset. The existing
"-s" check also had its findstring arguments in the wrong order
(needle "-s" never fit in haystack "s"), so swap them while moving
the check to wrap the block.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    git-gui: silence install recipes under "make -s"
    
    Change sign-off email from work email to correct personal email.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2318%2FHaraldNordgren%2Fgit-gui-respect-silent-flag-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2318/HaraldNordgren/git-gui-respect-silent-flag-v4
Pull-Request: https://github.com/git/git/pull/2318

Range-diff vs v3:

 1:  1375fdc1aa ! 1:  27d9fcf26b git-gui: silence install recipes under "make -s"
     @@ Commit message
          (needle "-s" never fit in haystack "s"), so swap them while moving
          the check to wrap the block.
      
     -    Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
     +    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## git-gui/Makefile ##
      @@ git-gui/Makefile: REMOVE_F0  = $(RM_RF) # space is required here


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

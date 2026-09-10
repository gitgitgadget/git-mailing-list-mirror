Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364833F368
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020342; cv=none; b=Dwgp5Mwn9P/JiO8ffUqTEZ+aeLe3JOyBkJ6qBfokH5cFDlKXRkgmCiAJnuqYInYd+pLNEKqvO913Hjdu6SFO2OUK/jEFbuwpVaH5xPg+Aues1F3CcTgDIQ3xePTk/eMSUWFQWhs9eS8m9i9dAdO0DXnLn9sHc7W0vylp1u2oryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020342; c=relaxed/simple;
	bh=Jp+E0t9o9sRWKpoK6KFgVBgXwFmlhOKv9u/FBJUNXHo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N54g45d9d0Nytns9aetqjUkdkbBGUbsq+sC3ZktNsyMP3oZU8DqfDzR0+uAZph8XEtGR3PKK/ZVyfQMwLrILrtNF4B1eeEMeqmtNVRBddvSuCiFmr4iWt+Y11W6qWIfl12rfUTXVv4EuSTb56Eplv+6/tSsaB1yaIEMA1RwJsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLBAyz+Z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLBAyz+Z"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso783229a12.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020340; x=1789625140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FPHZ0VpydBqHJjKB11TdIfeDz3pMNpvnLBk2W0ZLaRE=;
        b=PLBAyz+ZLb1tJeG5+vQOuQrgQY4RrnR1G0dryHpUjBNIcZtTrYbykdHcufO+yFivLs
         QZ+X69+bdHRyugSNmtpu/osNY94JkF/L+hSkTF20SzSN3wgbI5GN5n85gF8A8iVmGKB6
         vZWtm+yItrJ0Mbu24AWiJbX4tOKHBwEgkxzfH26NbLZVVLZydnIXKfyGtxqJJOjT0NwF
         2z2/yj2DRTuCSErL1AxW4RYEZSXVY7yK+O1ZrWqTW9DfNK1HyecKuNgyUpib7nN9xKSG
         qJnJ58qg6ibL5RMIXehtRAH8vGxfK8uadKGSeOwszL8VkAMvpDpHMS8E6eihIQZ8/4Vq
         7Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020340; x=1789625140;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPHZ0VpydBqHJjKB11TdIfeDz3pMNpvnLBk2W0ZLaRE=;
        b=BxnMD01+bCagclh7diqe87nnrgCRVtxWgETMK/pLlYBATUIGpFZJ3+Px0S8Jck5/Fk
         Kw8Z2LyRZHlQO3LyKazqoElZyAQExQwxzLPo2PxW0pCm0X0p8iYGP3lIscNFxopnD1dF
         MqJbGc+8c8WgF3pjbWMpVI38GicNdC2T/W10Ic0+XPlwQXXTZBtEgjDCQtqyPNDOWg3N
         BuZwn2D0myEiSbXk68/vKSr2djOYWJmK2/QDnD/kqJbtnrdkNFkzYnHNrKoxbfy6cU3+
         FNGd+5jBNqfbOmCHYCV0VyEFrfVMBW56zAGB2Yk5HBPOc1fHF+vesY1Xr82k2a+M3a07
         6k1Q==
X-Gm-Message-State: AFuF++nNVTqeCjnwXPaTUyrKOAdeoMXEBDcLxcag97/AUYsivFV8yaVP
	MN5EWrMShnjk9R8v4KqdAEMoqQdN2gGpYuuY/gRmn+lAayIM5ognY/OZ+9i5Hg==
X-Gm-Gg: AYBFou0eZ9+ZPfTWjle66rkOT6mKgIJ9BDKZvxxoWYyW4dbiIxP2Ge+yc8zF6YLtYft
	tlLuw7O1E5r4a1OwNNasMaydH3wmE6Gp4CMX+FquZX0t8V5JPIgZCH9ATrdt1JIpIhbQKFnEfuw
	T3ZRnHNZiGUNwFT1+s86YCQ5szvtRjwnCGM8Cso/lLxtBVFuWX29D/QD0FPVz/Zc1oGCYnszGvz
	SymMJZrH3E9F7NUp6pDkZA9AqfaBY47WOoAzqaeCW0ZIlXy7hMMRHteZw5RsCgC1OTp288V25TO
	LNXXbu2vAQnTulz3dPqCU0nX8Ofod2eVSPji6PrxnscfyeDDHexRRx83I7BfXyoALi5xQ2YACcQ
	tdY67xMwmJg+hw+rN9st8MnHWYgK/W7j2CW73TRa5LJk7dqrIrG6S2ZeBcVtaPhbl80YyK7vlBs
	89OeI77Nx507bm5/BPpL8tev9w1ndomQTea3Tcv4IOQyeTVyOvqfDA7xydijz++yrzbLolLH+UA
	UqUcSbeGf0=
X-Received: by 2002:a17:90b:1d51:b0:39b:3b03:8a32 with SMTP id 98e67ed59e1d1-39d77bf643bmr3158170a91.29.1789020340195;
        Wed, 09 Sep 2026 23:05:40 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434bb7d71fsm17506313c88.15.2026.09.09.23.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:39 -0700 (PDT)
Message-Id: <a9665a33041a572139a9dc057b0a60c79eeceaa6.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:22 +0000
Subject: [PATCH v4 08/13] mingw: rely on MSYS2's metadata instead of
 hard-coding it
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSYS2 defines some helpful environment variables, e.g. `MSYSTEM`. There
is code in Git for Windows to ensure that that `MSYSTEM` variable is
set, hard-coding a default.

However, the existing solution jumps through hoops to reconstruct the
proper default, and is even incomplete doing so, as we found out when we
extended it to support CLANGARM64.

This is absolutely unnecessary because there is already a perfectly
valid `MSYSTEM` value we can use at build time. This is even true when
building the MINGW32 variant on a MINGW64 system because `makepkg-mingw`
will override the `MSYSTEM` value as per the `MINGW_ARCH` array.

The same is equally true for the `/mingw64`, `/mingw32` and
`/clangarm64` prefix: those values are already available via the
`MINGW_PREFIX` environment variable, and we just need to pass that
setting through.

Only when `MINGW_PREFIX` is not set (as is the case in Git for Windows'
minimal SDK, where only `MSYSTEM` is guaranteed to be set correctly), we
use as fall-back the top-level directory whose name is the down-cased
value of the `MSYSTEM` variable.

Incidentally, this also broadens the support to all the configurations
supported by the MSYS2 project, i.e. clang64 & ucrt64, too.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 21f53e3f7e..3a90995587 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	# Assume that this is built in Git for Windows' SDK
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-        else
-                ifeq (CLANGARM64,$(MSYSTEM))
-			prefix = /clangarm64
-                else
-			prefix = /mingw64
-                endif
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
@@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
         ifneq (,$(MSYSTEM))
+                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
+			# Override if empty or does not start with a slash
+			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
+                endif
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-- 
gitgitgadget


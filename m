Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982725228D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020338; cv=none; b=eszdifhuX3IU19pnABM26yefO595hSJLUrn8cXahlyxpbzQFxV+bjFNNPA47cnrHwxYFPI648HUraiAvlZITkt9gNKB38WNxLEE2zF7g0lMudKsOF0V7UhIxO18NYUTNEjmjFdf/T/97aJdYiNaRXOHCCCdQGRVZ/G7kRDaKN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020338; c=relaxed/simple;
	bh=Nks0mAxDUW0BK6BuVIq384nKqd0zsWCbWMgYHnz+2zI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PluYPLDjqDIrpC3RclsSMqdy6DZLO47PS1ZblWowQeoHJK1gwll6r86+G3rS1MRzR2iRl42Ws8NbFoYAUxRRh0O+t0ClAV4bZFodzm7O+QM62B9TEILZC/iH8JsaFnqMR2cw9XlGjFWPrtZoomeq1ZbG/6rNTDmBrmipBMuxeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O802iT5X; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O802iT5X"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so17585815ad.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020336; x=1789625136; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cM93JUXoBsZ+eEQ8mzhy3OqGdw5he62qVGEIEHdZvsc=;
        b=O802iT5Xutbny65nMjxmc4qQwmgOjauTv4VyVz48ZQrl1pmyXT1VbCyJLpDZ075E/F
         5UqQDhQhp43oZdaA2h6GDf7Gp7K9Nhi1g3hR/iK2p41ZNVXSRfuJdXWwvitjseJfe6lO
         WaHeiWI40X2AsppiUHnPxtO4mVyPsmJIX4kL39T7UGifrjQIvpvJmoGs2j4mmyeyanoW
         3ocQ8wVFKHhEJnQwsQ+UBn9XmtodVnEdCDe1SUJz5r79oDPJKwkN+ylXFPsIXRpGBHfk
         PVC9E/9FcyZWL3309bFd+ipXnS/QIXEJouQ1/q2hMut/T9eSrKSTymVmCuibZ/Mpk87S
         eGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020336; x=1789625136;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cM93JUXoBsZ+eEQ8mzhy3OqGdw5he62qVGEIEHdZvsc=;
        b=FMzbjfX9cLqkiV/Otftj1LD285ddthK359QEKVS2CyjSrZMebRpPyOexdPr/Ni/vBp
         cJ5FQOiJ6GVgr6/W7+54sHb/Nd6a+/9kQdIbbvwnt9oUzFwDpYaLvPdSUgjyCdIqnnBa
         t9uyhf4RJ9UYy8QaG5aQKtWTh1kQs4e4bBdmwLvXU8ypnjRn/MEmRLQ1oDiCJaH0SV6I
         7S7em280awAmFRX0bZu1z0HmmML/PUWSXamWUpxjCilGNQ+avn6biT86vddKct596mbA
         yik3rfX1pfciL8QiV/N18m+xONA+uRQ6rAUXy2y37ATb9N3T26dSLAcnfLfm8Qd9TDme
         xU7Q==
X-Gm-Message-State: AFuF++lPHJaeXh7wETFxMmEyKQNVLm8tmJOGcm3bB0HoHxfaC8R/1zn9
	XTLKEhFJkHRpNTW8UfBUs9uMHVqfqc4AW+NdXNvy8mltlJgBDqrGB3NxXrf7Kw==
X-Gm-Gg: AYBFou3vCGAnJv1EEix8gUtl2fOx2/i0ReOE81QaM1Y2r2qBWzU4HiIVVmCgm87J6+4
	E0eMxgLLVZakxzO3RpvbdMslIwCVeAN8zXIY3NjsFik9T2p91nwuW8rGoqXYoLxNu+Q5RisMQHm
	w9i3wYhTOun/5g5rNihDG+Y4m7fEUPhhrP7xMthmWsk22PVmteDr9Dh/XlC7IPce5CvRp1biGBT
	UNWK4eNg8ZxTP7uwFZcnyF6E8vCXijid48fJJodcnxwpkc/eK+Cgef+fmS4HZcVGhBT5ZUD0Z9q
	f/RTQZSgQR13sramoUl+tl4SN2w1Xo/Uq9iMQ66QaP50FgGyDNKVbIvvablIzI1Z1/tOLF5gxqK
	6eH+bTOpOto1XkTx+VrsfR4zSpkYn5w8ijPL90A/iuwke20BOPW48MTQFo4uVzN0LqXsArxf8L3
	3QJX/llZKMIbz+p8d4x3bly/6Tfu3tUkDZSmBvKJ4D59bMooNH5rubTux7zvGRDCRYLimR4glec
	g==
X-Received: by 2002:a17:90b:270b:b0:398:c9be:cca8 with SMTP id 98e67ed59e1d1-39bac13b38dmr16889483a91.2.1789020335842;
        Wed, 09 Sep 2026 23:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm18655006eec.14.2026.09.09.23.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:35 -0700 (PDT)
Message-Id: <0063f2d96a00f0119e67578bcc0b4c8d97ef46e6.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:19 +0000
Subject: [PATCH v4 05/13] mingw: avoid over-specifying `--pic-executable`
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

In bf2d5d8239e (Don't let ld strip relocations, 2016-01-16) (picked from
https://github.com/git-for-windows/git/pull/612/commits/6a237925bf10),
Git for Windows introduced the `-Wl,-pic-executable` flag, specifying
the exact entry point via `-e`. This required discerning between i686
and x86_64 code because the former required the symbol to be prefixed
with an underscore, the latter did not.

As per https://sourceware.org/bugzilla/show_bug.cgi?id=10865, the
specified symbols are already the default, though.

So let's drop the overly-specific definition.

Helped-by: Johannes Sixt <j6t@kdbg.org>
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


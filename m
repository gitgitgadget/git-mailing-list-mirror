Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A390987
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020336; cv=none; b=qz+VJ1cyN5Bq7rx0zkdOA8dfNHa4tii17eWd99O7sqfKyhhmL3qc9edy+FIYtGeUfOm00nA1VIPEJ/NtC480h3p35Que1K7g3NebaU+eJlRf1xzDRH+rZVQQdT56++6sJLY2du4hw3pYWWk+1oHR3zcBKLUAi0t0AEGPe2dVTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020336; c=relaxed/simple;
	bh=LsvtPTI+UTuV0VbGQ/38DTOiwRNz/5ise55/DOaYUFs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PlkZTWdMMEWQFVgN1Fg8L9yx4MQ7ruvyTQ0ZCmI5VI0Ig1IveLhGpfPk5gnh8SaNaBTcse+IzePRyk/ZpvwNV1GtiCJY++jtdPN4XNuiPvivB4C3kMdl6egTyXroqsTppB/bLG1Py78xToxCoRwaPAgR9dkkw6R9sSEwGUFjDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBRwBR13; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBRwBR13"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so7321958a91.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020335; x=1789625135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l4KThZ5Pt49xsQbzvwsPLsfdKb1YZgx6gTHQSo+wVOs=;
        b=UBRwBR13bRc9HYHs63nrLmi0HiORQasAe+qVR3Ek0wYZiU8IbpB8yy3hdUrw1I4PuI
         c5LVowhoYH9ItcpTn8dnWuotUBXqCxyC1pro2PMYvwjWHEQuPqXotjlIePJkdyrXDVzT
         /TY7M//krQJXhUFWfQOHJYfQh/UDOg1LMGB5O3YB0youTwK0hl7fyFGSXOtiy4r6KMto
         dyBl4wwfiUEFfi9O2ZwrGgydPjIVluaGkI0EB5z4tGgYMyygUQpSTIHI3QwUvkSqzdcD
         eCr1Al+k4vPQ2Q58iua89vfIxEqrr7vgnLADGAFlNy30mii7b19ki7nH7fOSVivwfhjN
         7g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020335; x=1789625135;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l4KThZ5Pt49xsQbzvwsPLsfdKb1YZgx6gTHQSo+wVOs=;
        b=qzsmr6wY8MojHR9lrKtnK8jrf9C4Q2c4jhaVsLPhlFF6ccDwr6nsTnuqO1BtyzPFib
         emKqPwMr/K4/kkITX2OLPdQz1iI48SkQ6GLmFFrEGyCEVMqXbf99spwkl7HiQVfJ/tPz
         OlaopRMTjpRCCQof3g7neVjI8ZdQ44akUZ1PsrlM1dja97e2X8tIVzuzupj1XCl1c5xB
         mkLzJtdZE4a3cUXf1lGdQR7GuaDNOxqr2ujNz/k2G+SJGSMfgrvQpnAe8RutSZg1u60E
         CcoKw68LUmWEy6++TPTId6xW/4jcSCLa+TtU5qhC1LyxwgqBVqex0/KEExb3PK6gzxRr
         2v3Q==
X-Gm-Message-State: AFuF++k8YhFYWrE6FTS0s0f9Yzox6KMUs+yD/arH1gNiBSuTbN6RfB3X
	74gN3A64fsnFGGQPnTwwgfejlqKQbt8beSVIC0ml+3FGOaEQmMMpvRiMSUmzvw==
X-Gm-Gg: AYBFou3Z1e9kaqb8whr9Dyqx/BfFTAZ2xLFLozqKz85DWWsgxXkU2hWRjq+iAh4weX0
	Lql00nxxpFzsQkETxBVBVcTM1vRZ30IXkKEbF8bmPY16ypbkAZsZ79Bxu3FyDiZKg38ADmVtERl
	0X118hzukW2PYYlk4RJpVqDjpqWI9Bhc5HSm472O4zo48fyspjufVOwvyAdHvoCyi0ThVIw5J4R
	ONx5hnpRkohoViYAB4Tf7guvhftuqAFAnGZ5YyL6D+ZPxlQs9OpabJaLuBPew6QQIOCrAET6Tes
	5t9wchV64QZWrd7639XkPaUsv1ZZTxaElTCR0GAMQqI9ED8pvIZp2qexVysQTOQNA7T8bF4exaO
	zlEyh8bjBh7YSPH/3YLk6cTi3qkoHXkfaVrk9RcGSyjqdXJ01Ap0tA3YoSbKdBDPxpbbVozGu18
	tflG0h3cxDQ7ZjsqBkWuMBQkg2Rd4b/END957xQU8xjWrgZy24jmzPPqYp9bd2K6lg26MAu7WA
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39b26202ebamr61630228a91.14.1789020334490;
        Wed, 09 Sep 2026 23:05:34 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14344a86512sm22230861c88.10.2026.09.09.23.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:33 -0700 (PDT)
Message-Id: <37c6563d7440b066f562de13bdbc174703a75909.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:18 +0000
Subject: [PATCH v4 04/13] mingw: only use -Wl,--large-address-aware for 32-bit
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

That option only matters there, and is in fact only really understood in
those builds; UCRT64 versions of GCC, for example, do not know what to
do with that option.

Helped-by: Johannes Sixt <j6t@kdbg.org>
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


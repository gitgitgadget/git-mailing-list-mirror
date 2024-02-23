Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DF18EB0
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660121; cv=none; b=ntXs0XBoHsZdmRzDAUvAYOs218W3nPJJ91K+nrBqutgSlkF8Oe51lkSRaMeW0qNNhEYJT+odhGiKHaluaPnZHWDcQPrWO9vWhNt+OCH6DJt31c/nj2C4U0/Y4cgkzVWXvu6N8pCJKPp/wncugjc84hLVP6ILsHVdMzOyFuRjG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660121; c=relaxed/simple;
	bh=sXCTd7atIyxuwdwc8Sf10uZXyAwTEfuUOD7SGA28MwM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lpcD2RMt0jyfwvP4ji/zrtX8JB0F6YtdCJXD/XTCNAskdugTbg9JoRrBrkE/W2l+3htmCPn0ga0E2fFHIUPUTcGXYkj9cG8piDxeywyCISSGIxQnGA7Pz3y4qEdoO2c02eWgGWjJFYJeRsHrsqMb5C7Kp8W9+6EWw0TYG4ReII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoxcmxRd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoxcmxRd"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso5340081fa.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708660116; x=1709264916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oLUi1T7PDdyyMpMYbo9eLV0mBr3CYDn1fwxIVim5mE=;
        b=MoxcmxRdyk/um/HTBze+BsxXILFbp9LBwAejRMGnk+lSIeII1y/pvcl29rRaYBdI3U
         BLboQ7ZhJClQDab/Qkrn4ZUk+urysE2KwzIbWAc7KetlvRXrRuRvZwSEWCmdI8uya4Hc
         w+nd3FT1uKLudSn2uW7zNC2H/Ja2wfcc2SyLDFuWPdSIhPGY1u5NlPcqyuL1gvku2o2f
         YOqZPOtPGpJ3Alqo5zkgFZCSejA19HJLndQfaglfIq3op9xgjs2BgYmX5FXMCr0rtqAj
         ZjhKsUQ/96TVzbGtWdwiYLIW9hrIzeE8gN0lSYfWrDVwkRtMVdEx6GBL6n0YAPuSiwul
         qqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660116; x=1709264916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oLUi1T7PDdyyMpMYbo9eLV0mBr3CYDn1fwxIVim5mE=;
        b=sDGqYL9RGAJUM9zBJvYfbfZOWKHz32o8Yec1q3N3WkGMFiY9wR2dsGY5mR/N2JSBO/
         lvk0x2EL0txBBaLMbCUzUWbzfTLAs4wfBTrGaRafaRnIguASGfeT08z517w+BBDeM03S
         HMRAQbWdHE2O9Y937zhl4JImFcM6qRp9W0dZ0cMmZJ06ALQmhoWD/wSAfWunKA74/mny
         GDG/dpEnoAbaYwMhWiaB0zZr9nht0bMwiIzctxq6UApg1DfXtgj4EgvEP+SRpNnNp7MK
         x1R5Abo1n925kit6i2bON8V2VfwyLlehhJwCTmtPnvrGWTByezk3knHkximZrVEBaBhU
         2lWw==
X-Gm-Message-State: AOJu0YxkTmz4/7VlaKmUL+5BnWGUQkkJUaZBXB7+/NogBL8Satqpe9q9
	/xhqgfcs4plN8mzyb4GXbGPNywJG61i3yT9J4B0pYCan/3aYelu6PP35ICid
X-Google-Smtp-Source: AGHT+IE+tmZpDWFVSbkaGjVR4bkqx7vlh0gJhGiNDuSBHP5ArUAJP0IxXzDB2M53xsjqbhBHZT4h8w==
X-Received: by 2002:a2e:83c7:0:b0:2d2:3978:a11 with SMTP id s7-20020a2e83c7000000b002d239780a11mr475053ljh.36.1708660116229;
        Thu, 22 Feb 2024 19:48:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020adff643000000b0033b278cf5fesm1056121wrp.102.2024.02.22.19.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:48:34 -0800 (PST)
Message-ID: <53e211d7a6551c5d86ea6ecba0ab0e9f6592843f.1708660111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
	<pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:48:30 +0000
Subject: [PATCH v2 1/2] build: support z/OS (OS/390).
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Since the z/OS linker does not support searching dynamic libraries,
and the current setting of CC_LD_DYNPATH results in a directory
to be supplied to the link step with no option as the suffix,
it causes a linker error because the z/OS LD linker
does not accept directories as input.
Therefore, -L option is added.
Also introduced z/OS (OS/390) as a platform in config.mak.uname

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
 config.mak.uname | 12 ++++++++++++
 configure.ac     |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index dacc95172dc..c8006f854e5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
+ifeq ($(uname_S),OS/390)
+        NO_SYS_POLL_H = YesPlease
+        NO_STRCASESTR = YesPlease
+        NO_REGEX = YesPlease
+        NO_MMAP = YesPlease
+        NO_NSEC = YesPlease
+        NO_STRLCPY = YesPlease
+        NO_MEMMEM = YesPlease
+        NO_GECOS_IN_PWENT = YesPlease
+        HAVE_STRINGS_H = YesPlease
+        NEEDS_MODE_TRANSLATION = YesPlease
+endif
 ifeq ($(uname_S),MINGW)
 	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")
diff --git a/configure.ac b/configure.ac
index d1a96da14eb..64569a80d53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -463,6 +463,9 @@ else
             CC_LD_DYNPATH=-Wl,+b,
           else
              CC_LD_DYNPATH=
+	     if test "$(uname -s)" = "OS/390"; then
+		     CC_LD_DYNPATH=-L
+	     fi
              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
           fi
       fi
-- 
gitgitgadget


Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD7246BA5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449091; cv=none; b=S7Dqjct81fIHSUU+ZPt6cXJbznwPDnHG0GUU/nW93FboJ2rIMksr40GamTEbfD8lwhm8dVxnAlV7kkRW7tpis7PEsF91Mqg6iMeMcOsxEpaQS7SX8qVkKbSnEwjQjfs/jsfOU/BQ9wxiEIfLTDdAHWzTyUNALzkzaz0kY88u/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449091; c=relaxed/simple;
	bh=PcXnyVgpZCQDAJJ+JRSLDA1d+7kPK+PA54E+Rs2dEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVj8UnciTrO2PqRiisjEm08HZmDdKbT80a9sDpnyRWdDZzi4D44KWzTQf/aufDzBDV/194CYmGWiPCy7thH0pkcuHiRTSFVTMe/vy3UnBuGZ2hfpSgq1tWlLEGZqZ0zpopSnWX9NSpDUGlrgWXYsNhT5bmKn6yM4+/IWYDbHXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkJO+LDZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkJO+LDZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74924255af4so3613060b3a.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751449089; x=1752053889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnrrVM0vN7XERTqUNUp8tkRj98tC5C/ySm1C8c4gaYo=;
        b=QkJO+LDZmaT+HTbwlcxQeiQLjp9LxjYMNKf1OfxHDY84UWcPz6fg/N/xVYQ+FGrm+t
         orOydyjmZwpR8qshbFQwrnFzXA20ragkBNckq1yVXcC/tl+1L8SKHY3Qu8ulwq/oWNLu
         y+FTsP3J0Nwu6uhCRS7W2KbjQ5YfIy11yYZdd9GsMLWfrRFpB5JUNfDQwkQpliJZPzRM
         zfwGUTuvlRgSw5A/nvI4hCkdzA8KtJKkRKfXXjJmj4ADnJ25Pm44hkXIooXBtDJ5jQwW
         3AkB2d/WksL9tlMbhTTCEPvqWsAep89P0yDXOmRHSFs1q0z5Vv5hdofTR9DKGPSMuKWW
         GccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751449089; x=1752053889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnrrVM0vN7XERTqUNUp8tkRj98tC5C/ySm1C8c4gaYo=;
        b=TdYuv1LeB0cGcNcxKc/6oijMPBjf7fDjwTr7s5aIAeTxJPuLpGsAeSC6ZIRjmh9gJ4
         zhpBrvpmVHx+FnfqaLx6S80EF1OrmDUWVr3NKTqPM235/32YpCkofGvAdHvHyAi3VaLA
         eQSk/t3ZD0HmzPCB8iuk7R0fAtQf3QXinZLCYK3XWJXTeBJ1l8peryDFkWWnITDkIe0P
         Yu/cFwY1fZF9iqI7HbHMBC+RPKRFHRNpnV5/Dyz2pooN0p8Rh5ZpbSE6E6QPKb/Yzg4B
         53QuWJ6m6KG7y2btxk9HuNl1FnII/NAXv+8HSJ8N4XN2R7SlnuxfCoAW4r/8qP7M1TaR
         /1lw==
X-Gm-Message-State: AOJu0Yyb3rOvcehCVeDOEp2ViWMg/YY2165zEPOU5uiY898b8g+XyQTi
	WAo4lwpKFI/A1HRvN3OMtYIjTKr45h9gIPy7ZiWu4S4v5KJQ4zpHvj54QsvCeg==
X-Gm-Gg: ASbGncslHePu0WbvYtQowLzzqlGYOzcLABjGaeM3dPpCqXbD2DT7lYAut8ZBJ/SnCWd
	0E3bLT38b9+WSlMdjAFFFCphitciRjyJhc2kxUmHlOg9G9Uos9ESmtcKu9WaEt4cVgkROta8x9g
	hjcdEKjUOH6aPdFuZ0ibimqLexHd/n0cr1C6GGQwHLvsYj4rEgesdeqWUFB1dh+B93c2OqZrxVT
	MC4UeiN7eYYRD4OwDCSdM9MUbcDKZ5mEXQYGb4iKJn+nsDIlEtiF7M5toxsNrNDCAdU+ugyP0iz
	q5RhlxcxWIzXQFKIw9FuyMiHOB7hc/wFMN0RzU1ZPiSckADRk943WP6ZoHgyVhuOwbiqQXmsZdx
	Ok1RsAPkC2IRVXQ+R
X-Google-Smtp-Source: AGHT+IHnefKe+bOLESlhQJo7DMRH5ckmbBF8Ba3PLSfYtv4Or1a+Z0Utcpfbf/tzqtkUw2OPL1FOuA==
X-Received: by 2002:a05:6a00:2307:b0:748:2d1d:f7b7 with SMTP id d2e1a72fcca58-74b515128ccmr3097428b3a.21.1751449088668;
        Wed, 02 Jul 2025 02:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5579d28sm13501895b3a.107.2025.07.02.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:38:08 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: brad@comstyle.com,
	sandals@crustytoothpaste.net,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v4 2/2] build: retire NO_UINTMAX_T
Date: Wed,  2 Jul 2025 02:37:36 -0700
Message-ID: <20250702093736.36074-3-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.147.gafe0d4ec5b
In-Reply-To: <20250702093736.36074-1-carenas@gmail.com>
References: <xmqqv7p0bpdl.fsf_-_@gitster.g>
 <20250702093736.36074-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A previous commit removed the last user of it, and it is no
longer useful with the codebase moving towards C99, which
specifies its definition.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile     |  5 -----
 configure.ac |  8 --------
 meson.build  | 11 -----------
 3 files changed, 24 deletions(-)

diff --git a/Makefile b/Makefile
index 3868edd349..ba111f191f 100644
--- a/Makefile
+++ b/Makefile
@@ -114,8 +114,6 @@ include shared.mak
 #
 # Define NO_INTPTR_T if you don't have intptr_t or uintptr_t.
 #
-# Define NO_UINTMAX_T if you don't have uintmax_t.
-#
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
@@ -1915,9 +1913,6 @@ endif
 ifdef NO_INTPTR_T
 	COMPAT_CFLAGS += -DNO_INTPTR_T
 endif
-ifdef NO_UINTMAX_T
-	BASIC_CFLAGS += -Duintmax_t=uint32_t
-endif
 ifdef NO_SOCKADDR_STORAGE
 ifdef NO_IPV6
 	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in
diff --git a/configure.ac b/configure.ac
index 5923edc44a..d8c3af161b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1121,14 +1121,6 @@ GIT_CHECK_FUNC(strlcpy,
 [NO_STRLCPY=YesPlease])
 GIT_CONF_SUBST([NO_STRLCPY])
 #
-# Define NO_UINTMAX_T if your platform does not have uintmax_t
-AC_CHECK_TYPE(uintmax_t,
-[NO_UINTMAX_T=],
-[NO_UINTMAX_T=YesPlease],[
-#include <inttypes.h>
-])
-GIT_CONF_SUBST([NO_UINTMAX_T])
-#
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
 GIT_CHECK_FUNC(strtoumax,
 [NO_STRTOUMAX=],
diff --git a/meson.build b/meson.build
index efe2871c9d..27d5f40741 100644
--- a/meson.build
+++ b/meson.build
@@ -1331,17 +1331,6 @@ if compiler.compiles('''
   libgit_c_args += '-DHAVE_CLOCK_MONOTONIC'
 endif
 
-if not compiler.compiles('''
-  #include <inttypes.h>
-
-  void func(void)
-  {
-    uintmax_t x = 0;
-  }
-''', name: 'uintmax_t')
-  libgit_c_args += '-DNO_UINTMAX_T'
-endif
-
 has_bsd_sysctl = false
 if compiler.has_header('sys/sysctl.h')
   if compiler.compiles('''
-- 
2.50.0.147.gafe0d4ec5b


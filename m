Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C285C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F49360295
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhIZKHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhIZKHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 06:07:19 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EEC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x12so162582qkf.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZzsDiumO4n9iCgBjIudAk740+5LpF5Znmm7Ejo9Hf8=;
        b=EZWZmgLP1Cp8CtBKzeLLr0jmx1SuGMUs3j6Q00vJLJeI7mE3Vu9x10VuRWNTEDqos+
         jocRYUbXZnEtOjVXEIUiG/PdCqJzVfkvFF+EHZrSuZo61mJve9JzamaRSZstKd8zgnml
         wA9yOAjHDrX72gv7/xJJ7wnVrXeCnlC7aVekBgudbu3uBGs209DDslad5qHmV2hBmQ+m
         uqcFcR+n4txhbIi2lCeD2Uc9B/sGnkxkHKUOnN+OsbJk22VKy2C9HP8OUCJoBFcGAymG
         iHp0m8RqFn5BXQQGEUXSreLMOcPaEqMNEwIbMgLzeMM5EfZUcvY4S9IOAZTZsg27TT/R
         G0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZzsDiumO4n9iCgBjIudAk740+5LpF5Znmm7Ejo9Hf8=;
        b=TpZcpmPyC08nrnHEQp5+6L6aP3Vt8rT3hnnvHVFN9EMHGC5a3mDYOgHfM4SpNTCZmb
         xBQREnpf89a43bPIfqYDuQbdoS1pRTbFuAIl7NO1aqOoxqkCThjY0DX5P7Q/XnlT4j74
         uHMCgARtT7d6F9dRpsu4qNxFHFPD339517y5evj3VjFfO4/WLMPl6qBGT11AX/prXQUx
         HBxr1BjLLdJM2ZUdBnjvkWPhUbonBUlTvXsGchTgQLymd2N1wtYZTYKcMnK2VRQqFC/L
         sUxlVcpFfClLFhozkuIHKmRop2R/e03OO8tCucVkHbmhqAwhVmMAZPqkLx/Ar5w6Up3O
         dCNw==
X-Gm-Message-State: AOAM533rOtqOm8yhx5PAXa1wW3C/besTwNGr4sjEPVOYn9jS/VnGYp5y
        +b32uMe3aJ9kKyZPCCOMjPsVtYsDH2g=
X-Google-Smtp-Source: ABdhPJzVOAx8YRsdZpQ5vgUZVE3k3dMULl/jfECR9DWd4MCaQJkGBmjL9vkxQW3vz+ptL2+FsRmy/g==
X-Received: by 2002:a37:a13:: with SMTP id 19mr19042294qkk.497.1632650741360;
        Sun, 26 Sep 2021 03:05:41 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 6sm6657579qkc.123.2021.09.26.03.05.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 03:05:40 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 0/2] js/win-lazyload-buildfix
Date:   Sun, 26 Sep 2021 03:05:10 -0700
Message-Id: <20210926100512.58924-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210923065251.21363-1-carenas@gmail.com>
References: <20210923065251.21363-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To easy the maintainer reroll of this branch with the fixup[1] squashed
and the suggested[2] cleanup in the second patch to minimize change and
readiness for next.

Carlo Marcelo Arenas Belón (1):
  lazyload.h: use an even more generic function pointer than FARPROC

Johannes Sixt (1):
  lazyload.h: fix warnings about mismatching function pointer types

 compat/win32/lazyload.h | 14 +++++++++-----
 config.mak.dev          |  1 -
 2 files changed, 9 insertions(+), 6 deletions(-)

[1] https://lore.kernel.org/git/3f963bba-3197-8c52-9828-6d78ef1d25b1@kdbg.org/T/#u
[2] https://lore.kernel.org/git/CAPUEspivB=07OponiMrfXFBrC+L7qjSUuZEV9q-Ug5Z_ShnFNA@mail.gmail.com/

Range-diff against v2:
1:  79354f549e ! 1:  c389b7ad9d lazyload.h: fix warnings about mismatching function pointer types
    @@ Commit message
         happy. A cast is fine in these cases because they are generic function
         pointer values that have been looked up in a DLL.
     
    +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
         Signed-off-by: Johannes Sixt <j6t@kdbg.org>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## compat/win32/lazyload.h ##
     @@ compat/win32/lazyload.h: struct proc_addr {
    @@ compat/win32/lazyload.h: struct proc_addr {
      	{ #dll, #function, NULL, 0 }; \
     -	static rettype (WINAPI *function)(__VA_ARGS__)
     +	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
    -+	static proc_type_##function function;
    ++	static proc_type_##function function
      
      /*
       * Loads a function from a DLL (once-only).
2:  912c443bde ! 2:  b1efbe2c89 lazyload.h: use an even more generic function pointer than FARPROC
    @@ Commit message
         enabled, 2021-09-03), as it will be no longer needed.
     
         Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## compat/mingw.c ##
    -@@ compat/mingw.c: enum EXTENDED_NAME_FORMAT {
    - 
    - static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
    - {
    --	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
    --		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
    - 	static wchar_t wbuffer[1024];
    - 	DWORD len;
    -+	DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
    -+		enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
    - 
    - 	if (!INIT_PROC_ADDR(GetUserNameExW))
    - 		return NULL;
     
      ## compat/win32/lazyload.h ##
     @@
    @@ config.mak.dev: DEVELOPER_CFLAGS += -pedantic
      endif
      endif
      DEVELOPER_CFLAGS += -Wdeclaration-after-statement
    -
    - ## t/helper/test-drop-caches.c ##
    -@@ t/helper/test-drop-caches.c: static int cmd_dropcaches(void)
    - {
    - 	HANDLE hProcess = GetCurrentProcess();
    - 	HANDLE hToken;
    --	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
    - 	SYSTEM_MEMORY_LIST_COMMAND command;
    - 	int status;
    -+	DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
    - 
    - 	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
    - 		return error("Can't open current process token");
-- 
2.33.0.955.gee03ddbf0e


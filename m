Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EEEC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A62613D0
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbhI2Au3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbhI2Au1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:50:27 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E408C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t189so769410oie.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2gHayGbXHdGSC6xUkdq/H1zd+A2QITax01lNUG1AeU=;
        b=eknheDHhPdEMbAA6NZ3Wi8JVAMt537G2+3XWDWn3YxoWZtBjIiIzW9SuIX5ndbliGE
         3Bk/tuTDqJgubJiSk7Bf9K6RKsIwX51GaYEQK9CNdKtHuAlN00ZJp6+p5s/1GS7q5nWt
         IRK68dF9kiGEtExLmyQM/G7Xn/NFmsJxGQdLZN4vt7jj19AS8tvkXvg/+1bXckO3jEso
         bJUuqeaHsMI9k0JGq+xnQYJOZCSW1U4Idtd7xpnoeu6HegPvE9ToAcM8n4nvUpv+tSIN
         ScBfHYuQR9FQ796xRsjAECJOMuxe9yM1xTKDpMtYm3Zq2hNjbY7puk/ZCeG/sbu4Qm6N
         2ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2gHayGbXHdGSC6xUkdq/H1zd+A2QITax01lNUG1AeU=;
        b=PrNj43DsuFS5IpaVuw5wEUzkRKui24HrmMspsYq9kawmORAakeInfj38nYGKmVE8XK
         PipLg6MYNRZoEyTSQreRUIUI6EEB7Ka2Z1EHRWJXQVG4W5nJu+sP4YlW8Vi/r7jLX5mq
         X2RRNvJU8loQ1Udf5WCls6KZwBA6yu5H5jgSIbsGRRVfgJZD98mNPlGbuCQFQoxLQ8RI
         xzFHK5SFoKk20UyKzDJtmBe4G0xh2TYKeo4NOpHyxVvxSxWe6A10SLIZFwj9W5uDgOsR
         jkeO4Pw/68R5SOalMaw/WxIP764ZRhrLArfUT8MdlSCbUHFujSzQlVShiPm9w2Qj6hoK
         nFpA==
X-Gm-Message-State: AOAM53094nPkYW9TP8GPzFcYD525aH4vgm1v9mrSqwZCTSQtjlIbTRdO
        fnWX5TkWaIenL36GAJ7jYsIH0T6PWa8/hQ==
X-Google-Smtp-Source: ABdhPJw9Yw46mqYGyrt/8XFD/CHmE8i4JwAKKkyRMdJsvfdR/DgDEtoPuyHHt1ZPeCR4/uKPDVKqPg==
X-Received: by 2002:aca:ac50:: with SMTP id v77mr5705864oie.15.1632876526667;
        Tue, 28 Sep 2021 17:48:46 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r18sm159924ote.28.2021.09.28.17.48.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 17:48:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 2/3] lazyload.h: use an even more generic function pointer than FARPROC
Date:   Tue, 28 Sep 2021 17:48:31 -0700
Message-Id: <20210929004832.96304-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210929004832.96304-1-carenas@gmail.com>
References: <20210926100512.58924-1-carenas@gmail.com>
 <20210929004832.96304-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gcc will helpfully raise a -Wcast-function-type warning when casting
between functions that might have incompatible return types
(ex: GetUserNameExW returns bool which is only half the size of the
return type from FARPROC which is long long), so create a new type that
could be used as a completely generic function pointer and cast through
it instead.

Additionaly remove the -Wno-incompatible-pointer-types temporary
flag added in 27e0c3c (win32: allow building with pedantic mode
enabled, 2021-09-03), as it will be no longer needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/win32/lazyload.h | 9 ++++++---
 config.mak.dev          | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index 121ee24ed2..2b3637135f 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -15,10 +15,12 @@
  *                        source, target);
  */
 
+typedef void (*FARVOIDPROC)(void);
+
 struct proc_addr {
 	const char *const dll;
 	const char *const function;
-	FARPROC pfunction;
+	FARVOIDPROC pfunction;
 	unsigned initialized : 1;
 };
 
@@ -38,7 +40,7 @@ struct proc_addr {
 #define INIT_PROC_ADDR(function) \
 	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
 
-static inline FARPROC get_proc_addr(struct proc_addr *proc)
+static inline FARVOIDPROC get_proc_addr(struct proc_addr *proc)
 {
 	/* only do this once */
 	if (!proc->initialized) {
@@ -47,7 +49,8 @@ static inline FARPROC get_proc_addr(struct proc_addr *proc)
 		hnd = LoadLibraryExA(proc->dll, NULL,
 				     LOAD_LIBRARY_SEARCH_SYSTEM32);
 		if (hnd)
-			proc->pfunction = GetProcAddress(hnd, proc->function);
+			proc->pfunction = (FARVOIDPROC)GetProcAddress(hnd,
+							proc->function);
 	}
 	/* set ENOSYS if DLL or function was not found */
 	if (!proc->pfunction)
diff --git a/config.mak.dev b/config.mak.dev
index c080ac0231..cdf043c52b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -12,7 +12,6 @@ DEVELOPER_CFLAGS += -pedantic
 DEVELOPER_CFLAGS += -Wpedantic
 ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
-DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
 endif
 endif
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
-- 
2.33.0.955.gee03ddbf0e


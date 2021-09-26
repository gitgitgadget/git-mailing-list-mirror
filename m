Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8AC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655646103B
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhIZKHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhIZKHY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 06:07:24 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64AC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x9so14049780qtv.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmAHDEzt1j5YFMaYns/aI9Hj2fX2ZRg+VYnQxb6Un3k=;
        b=c/GC5H92xjsOQ/lBU3KrW5nOS5KQOXQsOzgecd5TD7gpo4xmusT7GFQdR6FU8uozTY
         thYSCFusHji8IpzhK9ueM+h0Tz9jhVCF/COjOIjZ0PDG7OapkwETQM+4HTZ6jcfYL5KO
         dYlUn0iwDBjNeDQhuoxHnqL9wt36oIM78Wbp0T26/zdWBa+2wK3fq9+WiGgppd+k9RMT
         Iw8WB9wSJ8kyPCqLA3e9vXkg6C7XgAewYwGT0R5bfTrJDAPgeuHQIjg7az5fCM+NQ+ow
         okQfalD7LNGSe10vRllkEZqe3QsIzkIRj9ejb6X5bgPtn6jTpAjHXQ/LvMsV4G8SfaCa
         stMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmAHDEzt1j5YFMaYns/aI9Hj2fX2ZRg+VYnQxb6Un3k=;
        b=DiIdk0uMwKD6yzB+vK4dYa+D38XkalXuP7DADoJuTXR0L5/jP3IucoST+XTr0iGtxx
         AfvOPHxvOabSmRpKK4NPuSVEd0AWdBinyrEVTNLiX56UHZG6/Yr1ALnw4sfUcnOmwvGB
         R43eTVDiFDvi/rWHRKmBpKC3geOjQ74/th4SD2oWzbGUjIv9DL7gLdpN4bOgsNlNf1Dx
         u2r9rChRoKEN2eE74eld/EGt7W5DwBX8bl/IjWVrbZPGIPI0kjkpEV5WIfT08adIPA4H
         +FlPBq5u3Unx1sq4wYDXyqRD0pVOy/Kv95klX4XJr3BcNLTDOqzprrODikbfL/cEWOBR
         9olw==
X-Gm-Message-State: AOAM531wOmICS0uWTxiHADe7xH2uEG3/v5Rlq5ZK+wShFB1SOF/tFKbi
        nCynQnqib6GneGmJJMuJn2DN/BQvGDQ=
X-Google-Smtp-Source: ABdhPJy0tneH5r7q7fGB502OAy7o9L8mHys1cyBCKT1I685HDwljr0f94LSNuljusR7K8tIQMl/8Gw==
X-Received: by 2002:ac8:4755:: with SMTP id k21mr13654054qtp.150.1632650747766;
        Sun, 26 Sep 2021 03:05:47 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 6sm6657579qkc.123.2021.09.26.03.05.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 03:05:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 2/2] lazyload.h: use an even more generic function pointer than FARPROC
Date:   Sun, 26 Sep 2021 03:05:12 -0700
Message-Id: <20210926100512.58924-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210926100512.58924-1-carenas@gmail.com>
References: <20210923065251.21363-1-carenas@gmail.com>
 <20210926100512.58924-1-carenas@gmail.com>
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

Because of the way the function declaration was done in the previous
patch the order of variables that use it had to be adjusted so that
it is the last variable declared, as well.

Additionaly remove the -Wno-incompatible-pointer-types temporary
flag added in 27e0c3c (win32: allow building with pedantic mode
enabled, 2021-09-03), as it will be no longer needed.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3
- removes unnecessary variable moving after fixup in previous patch

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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06045C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4261613DB
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbhI2DVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 23:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhI2DVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 23:21:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F7C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r16so1034640qtw.11
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2gHayGbXHdGSC6xUkdq/H1zd+A2QITax01lNUG1AeU=;
        b=LQLZy383U0c3df5rbDpBNIArsM/R3S3wXu1/l4cpqdZl1w0xUrq4W4A7OEbAtbBeQ4
         3vK991JQdEF7a0tW3bBwrivnEWXW7FNu+2iSinHBok4B0Gs/Bui+ogeG4XRSVCnF1ftD
         yPOBhy1TX8J0szPg5dHOT5mCMpDxOQ4IL7NJJUixEQ3oQ7vjyV25zwGy+5E4XKipHuGN
         fomgltz6tSeaMcuL3maDCkVDzcmI1E/3VYGosjYgwzLLCSddSyECIbE/SCa24+7b5Xq0
         M6V4WP5J398QIu6l+23wZaAgf0yKfNED5e57YPbSTp9c8vBbhBldNRkxe2c7LB73oZa4
         HhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2gHayGbXHdGSC6xUkdq/H1zd+A2QITax01lNUG1AeU=;
        b=m9Xjwm0q577zgOaBHfPZO9cblRB1NK5jrihUF3KV7chGIHFpRYQHCFUS1K8ndNAQwd
         oAnlB29Vq7w7XZl52n43Tgm8dXfac3cKckO5mddwYVRGPb3SHtaWzK8WVxVNdF0Of+Bw
         DqtbPYUwkcG0b06Vc/MsXLQdrtwpj70E8mh59LQTxSeAt9BrMTcOZhNLNWTbzWPMzT/q
         gy4pnHa+sd3WkJP6kvU3LJDXRpgqrK31PGJuLV/WvKt7aHTRnSyT/fPVC0nc4jeOJLg+
         GLUomB2gtJDQ3EumHBmvJNlgeU+G/hnR1lkDKoFUim5rsqhSBhX8P3AyzniR73gMdwZN
         BmyA==
X-Gm-Message-State: AOAM532U6WY9V2x1lXPamDLT0QRKCz4Vi+4TbOj4N47dbem9axQvxtPT
        UEROhz/h3YqzGvWGJ3LmouKh4MDHGD/YPQ==
X-Google-Smtp-Source: ABdhPJy6Ez2Gc1Ddv4MF1ybbo7GEGQ5MDncpLfLWejQFm3SN0kgo9hdzaLz4bRVR4OmCd1qnkCvoEA==
X-Received: by 2002:aed:279d:: with SMTP id a29mr9345037qtd.143.1632885593998;
        Tue, 28 Sep 2021 20:19:53 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h2sm801350qkk.10.2021.09.28.20.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 20:19:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        jonathantanmy@google.com, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 2/3] lazyload.h: use an even more generic function pointer than FARPROC
Date:   Tue, 28 Sep 2021 20:19:39 -0700
Message-Id: <20210929031940.97092-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210929031940.97092-1-carenas@gmail.com>
References: <20210929004832.96304-1-carenas@gmail.com>
 <20210929031940.97092-1-carenas@gmail.com>
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


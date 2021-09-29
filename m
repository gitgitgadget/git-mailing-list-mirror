Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E04C433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1396B613D0
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbhI2Au2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhI2Au0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:50:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517AC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 24so840983oix.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYpv/SVLr56EIWQwhPDNNxFdvuVgd/Y5pQ417vZMAEs=;
        b=WEOYamk6r2onvOuEqdxnJjkcsbP0GmWEYAPinds0EmjWm/l3WspdDUYg2o0IBHtrF/
         Qy2OfQiiYHO66aO2+FW+RbKnMEeGKfVNOZneMzIGyWYJ7DN5F7nt3N185VGv0D9bkD54
         fwBFcDkskkgxN6+fovYQf0I9Wz+5Yoog/teQN4cgyPrfZmVMW6b2lB3nsN06lvZBkXs7
         h6xpxWEYquc/DnXnPidqUjCzRByqgNKKtMmvz7JlWKpfN69wbmqb0DDWQGm679M0ts+H
         fCbUKlbA1GDbHw6OaZ4Yq/I5zFYQibdB4xPFccWDymLxV+GHjyYvjWvffYbgpzKH/Oy4
         uoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYpv/SVLr56EIWQwhPDNNxFdvuVgd/Y5pQ417vZMAEs=;
        b=bXmhY9Uo8NiMVYvncevkudNz0v85WAdsdHh8tOINVd7Dj3/EW/A5/VS4wRbbZVku2+
         P5oRb24awmnhnOYWqDjg0Rw9gVeohaFPp9RyeL2apUR674VrvmizuWeCIYqFcWwa90Kh
         RjVt8rVF9sve2jGuMqTl9UJQH6m0aF/wVC2yjXbq2wwiqDYxmDT7lnO+/SCsmeb8U6wB
         WEEN8vD9QLfGVGjIUbqr0AZDmdPUUvO9Me5qmbFvUCs1nwTAHYd/74gTUNtKjM2X+a6f
         J1R9qBGlFdaQ444+Yxf/5Sgsy9bmHR6127sDEjJ1mGIzaF96na3vUDdaT9xyPRrgBfXX
         f05g==
X-Gm-Message-State: AOAM533tTY5kxsQuX0M1oPBC/TzRNcKCoovKywP+7lv7YYlWrXpzrSDW
        Sn2NCdVONV6erR4e5n4fL3Hyn1qNB39uxA==
X-Google-Smtp-Source: ABdhPJzxBuwPSpcsyfVPJWZIfZ9eLMg2mFPbp8I3urGfnVpNy4qUBWJ0+Fgipc9qQTWpol2zK2aTMA==
X-Received: by 2002:a05:6808:1211:: with SMTP id a17mr5694886oil.91.1632876525493;
        Tue, 28 Sep 2021 17:48:45 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r18sm159924ote.28.2021.09.28.17.48.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 17:48:45 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 1/3] lazyload.h: fix warnings about mismatching function pointer types
Date:   Tue, 28 Sep 2021 17:48:30 -0700
Message-Id: <20210929004832.96304-2-carenas@gmail.com>
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

From: Johannes Sixt <j6t@kdbg.org>

Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:

In file included from compat/mingw.c:8:
compat/mingw.c: In function 'mingw_strftime':
compat/win32/lazyload.h:38:12: warning: assignment to
   'size_t (*)(char *, size_t,  const char *, const struct tm *)'
   {aka 'long long unsigned int (*)(char *, long long unsigned int,
      const char *, const struct tm *)'} from incompatible pointer type
   'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
   38 |  (function = get_proc_addr(&proc_addr_##function))
      |            ^
compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
 1014 |  if (INIT_PROC_ADDR(strftime))
      |      ^~~~~~~~~~~~~~

(message wrapped for convenience). Insert a cast to keep the compiler
happy. A cast is fine in these cases because they are generic function
pointer values that have been looked up in a DLL.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/win32/lazyload.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index d2056cdadf..121ee24ed2 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -26,7 +26,8 @@ struct proc_addr {
 #define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
 	static struct proc_addr proc_addr_##function = \
 	{ #dll, #function, NULL, 0 }; \
-	static rettype (WINAPI *function)(__VA_ARGS__)
+	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
+	static proc_type_##function function
 
 /*
  * Loads a function from a DLL (once-only).
@@ -35,7 +36,7 @@ struct proc_addr {
  * This function is not thread-safe.
  */
 #define INIT_PROC_ADDR(function) \
-	(function = get_proc_addr(&proc_addr_##function))
+	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
 
 static inline FARPROC get_proc_addr(struct proc_addr *proc)
 {
-- 
2.33.0.955.gee03ddbf0e


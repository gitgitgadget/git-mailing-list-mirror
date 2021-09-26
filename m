Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA74C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D0660295
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 10:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhIZKHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhIZKHW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 06:07:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380EEC061575
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:46 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f15so1083592qtv.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C6t1S4rLD3/i7R7m2Vk7zBTL7jzCH8VvVEgE1rayR4=;
        b=G6LHmj7QI3myeFSpTyNmzNGCAXDc/0KnpVJwxDijUKpS1ngcYoF+SFFj23qRPBZG9w
         t8sUOA2D/k13G2tNbToeyGJ5IOWxVaT6V+C4pFFoERVpa8b5Dhy4c8e1aVSOD4R5KxVE
         lkH7r8cqKvioPUo8vt+FV06ufmmATkTwzZ8f2jIIaS2Gbo62LTuDgs4rKn3JAJBT1F9p
         NcLy1H5Vvb7hNx5ZSSskeqyrLAotSEajdBZQiJRpySpoMA7SnorVSCzax5qbt7Xc5Okz
         dS++KlFxWwVfotQ3osIdT28ZZJp+LFeLCFDhFyyUa0YGgOH3P0HW5GsbfUYyCV1DBeuI
         5I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C6t1S4rLD3/i7R7m2Vk7zBTL7jzCH8VvVEgE1rayR4=;
        b=JsMT2vWcK9PkpHXFsUfXxZzaaU7La8Jat1aufKehKD67n2RjGwVaIe5iJQz9oA1Gai
         ENHZ6sT9lIqErTApRp9IzCEcOsg997hZfDCq4kWYo+Z884p33/PFfO4VVTmLxSx+69eM
         g65/fGKaGkofW0p8cW9qp9INgQybyyUW0RiBh3h5ICSX7S7wfTHZtZam23ei/Juqw8Hg
         /vgQZPN7AYZ3e9s/HVPzeuE+mjma8spzuoWHSsDPkR+JN4+7KaDMdbpNqizh82bzbV5/
         L8P7dmn5qoFD4tfs2H10BOjZgGb7nkg+RbgT0EOftqoJCftxcZXqfDZHEND59k7nyz6V
         ZzKw==
X-Gm-Message-State: AOAM533Ph1ydG6kFfPJ3LOu4znD51XoPKap5dVho2h/BjoGo/kiJUg+F
        MaoBBuPQzY6kjsjau+TK3+0/yhxjlaA=
X-Google-Smtp-Source: ABdhPJyxfuMQdX47Sq0JILqbB4vWQyHy2hYeJ/fgjwEecvdyg+XEdx9jJAQ+QFEb+NH9jwHCX4UMzQ==
X-Received: by 2002:ac8:7008:: with SMTP id x8mr13240270qtm.397.1632650745164;
        Sun, 26 Sep 2021 03:05:45 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 6sm6657579qkc.123.2021.09.26.03.05.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 03:05:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 1/2] lazyload.h: fix warnings about mismatching function pointer types
Date:   Sun, 26 Sep 2021 03:05:11 -0700
Message-Id: <20210926100512.58924-2-carenas@gmail.com>
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

(message wrapper for convenience). Insert a cast to keep the compiler
happy. A cast is fine in these cases because they are generic function
pointer values that have been looked up in a DLL.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
v3:
- squashes fixup, acked by Hannes

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


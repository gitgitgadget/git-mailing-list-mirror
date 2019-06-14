Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A481F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfFNKBL (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:01:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34201 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfFNKBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so8535851wmd.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwwxi6eXEQqCEfBfTtjiZARst/PDzFhUXS5p1e1jLaA=;
        b=AHPBYszDApBPmKE3maDpL0+3l57f+X/6TbfMirmq/i4xALmcIsuivUUYhzD8YR+aGI
         PPiHLBy3gTRFN28+ZJ5RbrdnAD2dv9MggUlVfKkCwxRjA7vuVCk+/m0utOP+OaQXkABm
         LspAw9QTwMi8dtlKeAs/TkXH1JMd8bJVqjiuumnlH5EfbjDSy8UjvSKS0ZzwVTROwDSR
         DIqrk51tEUa5RL9tciXZUoncPOHklDSzgtjrlR0D0MN09MDpx0ZtI0O9Fz1oY/bjYFRm
         fJtXQf799WwJTYWhP/yBGK+tdOtGTfJNODs23ebWfpBjIbGdqKtWYfakKzyAw6JR9tlC
         0HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwwxi6eXEQqCEfBfTtjiZARst/PDzFhUXS5p1e1jLaA=;
        b=Uwq2zqdvwCggWX5lHrvmwlscthiPmWLqmUp082hYb/2aG8FYpEOa+CthMi/eSl7XlD
         Fp2yfu7guWWSKO9AWJMQXTdb9cfA1zg3GuKAN5TFR3YR1RkhQbdpF8Xds4dzk4EnoDoW
         k/PZJb1oLMsA4ZRi6O7+8rR1Md1wSzMGMucBoU8aBnhruAzUObe6fzI40v2nlf9Obf12
         fV3yC1LQCMHMPkd3+rNVPhol2wufY6z+8Jcz6vesffzqAgWqe9AccsL22gQczH51m5eQ
         Pi1TxF5F7+2lco+Km8Es/vSShRSplAvIiebcawrhW+9H/0Ghfzr4YL24nHzraJkqZyq4
         anww==
X-Gm-Message-State: APjAAAU9lTgsR2+xB9lz0yuJz0GpIyauSk24zL0woUwIoI6OBSSSeYtr
        /uvOxWaSnHjwWGweeiOEGmeaJutI
X-Google-Smtp-Source: APXvYqw3Zn93KPedsR1Dy+QQ7qXadPViwqouGl/mEgK0cDmVpjt+Gogdib6eSvbwKWbuwHQs1Cgw+A==
X-Received: by 2002:a1c:1a06:: with SMTP id a6mr7340379wma.128.1560506467226;
        Fri, 14 Jun 2019 03:01:07 -0700 (PDT)
Received: from localhost.localdomain (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id d3sm1986988wrs.8.2019.06.14.03.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 03:01:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 3/4] SQUASH??? compat/obstack: fix build errors with Clang
Date:   Fri, 14 Jun 2019 12:00:58 +0200
Message-Id: <20190614100059.13540-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiling 'compat/obstack.c' with Clang on Linux and macOS fails with
different errors:

On Linux:

      CC compat/obstack.o
  compat/obstack.c:330:31: error: incompatible pointer types initializing
        'void (*)(void) __attribute__((noreturn))' with an expression of type
        'void (void)' [-Werror,-Wincompatible-pointer-types]
  __attribute_noreturn__ void (*obstack_alloc_failed_handler) (void)
                                ^

Remove '__attribute_noreturn__' from the function's declaration and
definition to resolve this build error.

On macOS:

  compat/obstack.h:223:3: error: expected function body after function declarator
    __attribute_pure__;
    ^
  compat/obstack.h:151:29: note: expanded from macro '__attribute_pure__'
  # define __attribute_pure__ _GL_ATTRIBUTE_PURE

Remove '__attribute_pure__' to resolve this build error.

With this patch it's now possible to compile 'compat/obstack.c' both
with GCC and Clang on both on Linux and macOS.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 4 ++--
 compat/obstack.h | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 17fa95d46c..6ef8cecb8a 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -231,7 +231,7 @@ _obstack_newchunk (struct obstack *h, _OBSTACK_SIZE_T length)
 
 /* Suppress -Wmissing-prototypes warning.  We don't want to declare this in
    obstack.h because it is just for debugging.  */
-int _obstack_allocated_p (struct obstack *h, void *obj) __attribute_pure__;
+int _obstack_allocated_p (struct obstack *h, void *obj);
 
 int
 _obstack_allocated_p (struct obstack *h, void *obj)
@@ -327,7 +327,7 @@ print_and_abort (void)
    abort gracefully or use longjump - but shouldn't return.  This
    variable by default points to the internal function
    'print_and_abort'.  */
-__attribute_noreturn__ void (*obstack_alloc_failed_handler) (void)
+void (*obstack_alloc_failed_handler) (void)
   = print_and_abort;
 # endif /* !_OBSTACK_NO_ERROR_HANDLER */
 #endif /* !_OBSTACK_ELIDE_CODE */
diff --git a/compat/obstack.h b/compat/obstack.h
index 811de588a4..f8f9625121 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -219,15 +219,14 @@ extern int _obstack_begin_1 (struct obstack *,
                              _OBSTACK_SIZE_T, _OBSTACK_SIZE_T,
                              void *(*) (void *, size_t),
                              void (*) (void *, void *), void *);
-extern _OBSTACK_SIZE_T _obstack_memory_used (struct obstack *)
-  __attribute_pure__;
+extern _OBSTACK_SIZE_T _obstack_memory_used (struct obstack *);
 
 
 /* Error handler called when 'obstack_chunk_alloc' failed to allocate
    more memory.  This can be set to a user defined function which
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
-extern __attribute_noreturn__ void (*obstack_alloc_failed_handler) (void);
+extern void (*obstack_alloc_failed_handler) (void);
 
 /* Exit value used when 'print_and_abort' is used.  */
 extern int obstack_exit_failure;
-- 
2.22.0.589.g5bd7971b91


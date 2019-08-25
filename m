Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0E31F461
	for <e@80x24.org>; Sun, 25 Aug 2019 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfHYSWb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 14:22:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36726 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfHYSWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 14:22:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so10112585pfi.3
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce8YmwsqB0QTge3VkEqVsOagmJJH66qsTQZtHH1jsSg=;
        b=unu6skDlCsfpg8+tufwNCjVV8h9n0BYuVdUhPKhLD2IeVzqqqaPRgBZA5RlqwW3IwT
         RgYzAa8JKLlzi/6/LYrAaJ6BAjI+njseC8ypIwxpAXckfcpzS8/J3sCmnfC42QElwa2k
         DlhUYazwIVEw9nDZenrz1fUmaSH+BCHSmdegwp960Rdn1Xn78evbSDhh+ynMyVbG9OqW
         u1WqCuoh1p7Kw11HDMTGaqVT9FBFwUU+U3O/BBFfkgANT+5hPE9ftAxb0VCMF+6wZ9eC
         BxnGtgOn/7cxGqfnWmg+G5IXe8hdi5u7Kez1Uud+ptOUe84Nh0wuDgGhwa8vdOAThvjx
         1ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce8YmwsqB0QTge3VkEqVsOagmJJH66qsTQZtHH1jsSg=;
        b=mGVxDRlK9kWs8pZErZlfBurFZmFjz8NZQX2eRv1CfFwP95Cm7ilon8MPSvQVzQYtg6
         ebF411HTrsT7s35FjiqC98BqWqUh7YhEHqPFs+iIYII16Vh7wZi3Ml1wcSpWIObUOTdn
         dpiIsnSzF1vMRVHSY6FyKox/HWtCQyLZorFFZt4cTsfMOFLmjY/GrvpdZe3ew09raZoS
         xB5uAWaCBa0A/VKjdS57xM+QYpSPNxt3GaGrKd/hNEyfhFcMDZWRecvjHhZrG4VhDdER
         gRMKBEFvABd93r305kTbMMPvZV5X8DFv8m9p+oXBJVo3b203wFHFaYYFZJl0K5tQVesn
         oUKQ==
X-Gm-Message-State: APjAAAX7eUkkiPXzLh3T4z5V68aUag3hckjU5C4z8GzzZpuoN7qsH7Y1
        Bj6Jopfvis6WNkRuaOmbBzI1OXeSac0=
X-Google-Smtp-Source: APXvYqwTnvy7/tcIAIBA/cZM2ZwmQ+eG+MDL2GvThU4M7hf4IQ68bsXtktZEbsLX+u2O2sZizokCZQ==
X-Received: by 2002:a63:8141:: with SMTP id t62mr12042462pgd.95.1566757349318;
        Sun, 25 Aug 2019 11:22:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y194sm10334693pfg.116.2019.08.25.11.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Aug 2019 11:22:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     cbailey32@bloomberg.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 1/2] grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
Date:   Sun, 25 Aug 2019 11:22:22 -0700
Message-Id: <20190825182223.76288-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825182223.76288-1-carenas@gmail.com>
References: <20190825182223.76288-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e87de7cab4 ("grep: un-break building with PCRE < 8.32", 2017-05-25)
added a restriction for JIT support that is no longer needed after
pcre_jit_exec() calls were removed.

Reorganize the definitions in grep.h so that JIT support could be
detected early and NO_LIBPCRE1_JIT could be used reliably to enforce
JIT doesn't get used.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 9 ++-------
 grep.h   | 4 +---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index f58bf14c7b..3f78ef942f 100644
--- a/Makefile
+++ b/Makefile
@@ -34,13 +34,8 @@ all::
 # library. Support for version 1 will likely be removed in some future
 # release of Git, as upstream has all but abandoned it.
 #
-# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
-# library is compiled without --enable-jit. We will auto-detect
-# whether the version of the PCRE v1 library in use has JIT support at
-# all, but we unfortunately can't auto-detect whether JIT support
-# hasn't been compiled in in an otherwise JIT-supporting version. If
-# you have link-time errors about a missing `pcre_jit_exec` define
-# this, or recompile PCRE v1 with --enable-jit.
+# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if you want to
+# disable JIT even if supported by your library.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories. Which version of
diff --git a/grep.h b/grep.h
index c0c71eb4a9..1a044c501e 100644
--- a/grep.h
+++ b/grep.h
@@ -3,14 +3,12 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
-#ifdef PCRE_CONFIG_JIT
-#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
 #ifndef NO_LIBPCRE1_JIT
+#ifdef PCRE_CONFIG_JIT
 #define GIT_PCRE1_USE_JIT
 #define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
 #endif
 #endif
-#endif
 #ifndef GIT_PCRE_STUDY_JIT_COMPILE
 #define GIT_PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.23.0


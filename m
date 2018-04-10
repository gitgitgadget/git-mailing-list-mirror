Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A15A1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeDJPG0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:26 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46592 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbeDJPGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id p67so13699456qke.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AR/FGSTbbRQ7mbjSp9p+5BEbZMHfXuXp55v0degzBak=;
        b=iBUZSaktxPH5G/+SXINKAWL0AeIu+LwlebCmqH5AHNuD84EhIOd2CyE+uFcei+Y8zf
         hfVJ4NKtqnBDkc6paCKIlWgQw7s7z1B0tdnpdEiE5Hs4hHqlXBYIraygN2PWbfm4iXT4
         SwvxZetA9PMqxpB0uGfU3btZnqWKO1/2En+Ggx0tqvyDwgOWGNoizTYBxxEScd4DqIlm
         fRSUP0VYjvtRMbw/4sr7Q/P2DjRuPhXE2djaQkUBTqvISHlDDCXBJlplcgPna4OaDLtr
         WUNlt2qccUFyDjylNZgbZ829cjO0fOlO+S17n3A4dWfxu2NEZ0UrAEMQZky86+nyuqEj
         PRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AR/FGSTbbRQ7mbjSp9p+5BEbZMHfXuXp55v0degzBak=;
        b=G0nsaHwQfhPWSWMx74tjO06QK/jHkxPGgea3ivOXjrUo9B/LvwLWkTU10gwO5g2TWe
         lS6W9PccpAO1+HUC/uuoMs2B+hdEwxUXPbFT/qiJkPP9FwprLvLLb04ma/c7MNCFsdyb
         YThrmYlmeH9hEtpq8wrEG6vbji3qxNGOT3NWnnnYx2sPMfeW3Jjxor5wwDoPkj18mWIb
         eSDtCmrivzTQT1njXzEwLGbK3jSF1M0rui5/rYxS6lY3Gc7sg0v4NrQPOQlL1QQ8wFsM
         N51v+bY+wbyDC7YnVAOww1LUWNaobyiYUXspwcrxhYM1098oxEwFm6JaeRNDnsxm9+V1
         8SaQ==
X-Gm-Message-State: ALQs6tB12Q3s1sMlctov4QzCZ5H6VJcYjs1qmTd4Q7oEKJb6sgGRvGDw
        t+kIexOuorjHshFuZUQnR1oFKy3R4B4=
X-Google-Smtp-Source: AIpwx4/EcXsS4elvOV6AMkmW9iUFh3zJy+bcr+RGaWst/BUXnnb5vFDliZKPrL9n9D7TdZCR9bnYUA==
X-Received: by 10.233.237.2 with SMTP id c2mr1208189qkg.156.1523372777539;
        Tue, 10 Apr 2018 08:06:17 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:06:14 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 5/5] mingw/msvc: use the new-style RUNTIME_PREFIX helper
Date:   Tue, 10 Apr 2018 11:05:46 -0400
Message-Id: <20180410150546.38062-6-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180410150546.38062-1-dnj@google.com>
References: <20180410150546.38062-1-dnj@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This change also allows us to stop overriding argv[0] with the absolute
path of the executable, allowing us to preserve e.g. the case of the
executable's file name.

This fixes https://github.com/git-for-windows/git/issues/1496 partially.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c   | 5 ++---
 config.mak.uname | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a67872bab..6ded1c859 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2221,7 +2221,7 @@ void mingw_startup(void)
 		die_startup();
 
 	/* determine size of argv and environ conversion buffer */
-	maxlen = wcslen(_wpgmptr);
+	maxlen = wcslen(wargv[0]);
 	for (i = 1; i < argc; i++)
 		maxlen = max(maxlen, wcslen(wargv[i]));
 	for (i = 0; wenv[i]; i++)
@@ -2241,8 +2241,7 @@ void mingw_startup(void)
 	buffer = malloc_startup(maxlen);
 
 	/* convert command line arguments and environment to UTF-8 */
-	__argv[0] = wcstoutfdup_startup(buffer, _wpgmptr, maxlen);
-	for (i = 1; i < argc; i++)
+	for (i = 0; i < argc; i++)
 		__argv[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
 	for (i = 0; wenv[i]; i++)
 		environ[i] = wcstoutfdup_startup(buffer, wenv[i], maxlen);
diff --git a/config.mak.uname b/config.mak.uname
index e1cfe5e5e..a6e734c5d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -357,6 +357,7 @@ ifeq ($(uname_S),Windows)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
+	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -506,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
+	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
-- 
2.15.0.chromium12


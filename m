Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A0C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FD660F44
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbhI1JMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbhI1JMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:48 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8DC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so26040356ota.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+Xgnb+em+kZz5AWvxVo2po/1w+2VKMitOmKDJOHW4M=;
        b=m4jgHfz1CXfrmJtfKsv+Bkpj9koj07LH9JYfb2AvAKzNWec9z0Pkq7yq/hkUaqsZuF
         Zd3/JeMrQ7c/0riHIQIDftpP+o/cmBhUxBjHxy2qfEmgftLtHxv130J5jOh8dO02oeDf
         W3GR4bqUQX67+hlGPlq8w0PtlY6M3bqms3FdZumsH7wnuIpXjTeDsTF6pF4U0EOhY/pJ
         yNr12dUODdFr1tp7zhBUlXRoeaorbIZERG2Gz0Vsz06B40sly7pQ8yuZxLc1Oc+8c3PG
         Cgx/pYrNpXmvU8ADB5cEuvDOwXHJ0L4+ERzQquxti+KQ29QZECCl5vKZSU9rQVnL2fmB
         22EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+Xgnb+em+kZz5AWvxVo2po/1w+2VKMitOmKDJOHW4M=;
        b=QnZ10q8SmZCie46cGZTvZVjR52Zy6EvRG24bxLeb6aH4zWzzrlEvISu+K1fInEzBwz
         ECkKx0TcYEM/aMZ099ZOy/plAzuJk6BtZ4xla6neKwRnnQ8USQ/uIyhxJHA2lMsvnZWS
         LkUMBeQ9iDDefJYH2IYckCY3zI7eVarO29Pue6n9SX/iaFYWLP6+ckC3rbD/990GtMs6
         +P8IOEb1dfqB8kkps9oZCrMFOdJKOOr/M+gWH0w7fcKtyCpPhwBdACU2rhlcjC5WrbUM
         SaHYhA70TlldC61Iq4OnOolAmWYfQ2DEqQXX3Cm7ajqzeEewbAnlTsc7v/6WOhP/NDaz
         YZlA==
X-Gm-Message-State: AOAM533dXAGeCa0+/lb/EKrbCBinJn3/MZKzDNeWQXLflAjTfkkGFIVy
        ZNy+UY0ubtFS9tT0Qb2Za1OQ7RguEXWYDQ==
X-Google-Smtp-Source: ABdhPJy0bp0yakcVKxQmJqT4dnwt3i68ZAQDH51o3t5JHgSyVBQoOVSNPUTwM0Y/KnnBEArODM873Q==
X-Received: by 2002:a9d:6752:: with SMTP id w18mr4126966otm.117.1632820268481;
        Tue, 28 Sep 2021 02:11:08 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r23sm4441250otu.54.2021.09.28.02.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:11:08 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
Date:   Tue, 28 Sep 2021 02:10:53 -0700
Message-Id: <20210928091054.78895-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210928091054.78895-1-carenas@gmail.com>
References: <20210928091054.78895-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6163f3f1a4 (config.mak.dev: add -Wall, primarily for -Wformat, to help
autoconf users, 2018-10-12) adds a second -Wall in config.mak.dev to
workaround the lack of one from config.mak.autogen.

Since 6d5d4b4e93 (Makefile: allow for combining DEVELOPER=1 and
CFLAGS="...", 2019-02-22), that variable is set instead as part of
DEVELOPER_FLAGS which won't be overriden by config.mak.autogen, so
it can be safely removed from config.mak.dev if set instead in the
Makefile.

This also has the advantage of separating cleanly CFLAGS which are
used for building with the ones that provide with diagnostics.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile       | 3 ++-
 config.mak.dev | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9df565f27b..963b9e7c6b 100644
--- a/Makefile
+++ b/Makefile
@@ -1200,7 +1200,8 @@ endif
 # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
 # tweaked by config.* below as well as the command-line, both of
 # which'll override these defaults.
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2
+DEVELOPER_CFLAGS = -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I.
diff --git a/config.mak.dev b/config.mak.dev
index c81be62a5c..90c47d2782 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -6,7 +6,6 @@ ifeq ($(filter no-error,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Werror
 SPARSE_FLAGS += -Wsparse-error
 endif
-DEVELOPER_CFLAGS += -Wall
 ifeq ($(filter no-pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
 ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)
-- 
2.33.0.955.gee03ddbf0e


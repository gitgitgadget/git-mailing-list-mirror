Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B71C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiCILFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiCILFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:05:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA33CC50D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:04:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r9-20020a1c4409000000b00389d0a5c511so74681wma.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 03:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Y0NjIS+CY1bRy5mGkZTuI5JlDYUm77x/O9lkeLYyxKs=;
        b=fZ/SLpob6wWgoZ6IgTWWFlQS4OwCP979tHaSvBYGnYAe7StnzFhGbeL/ZBDRbgJmWo
         l9321imsHKSnM8cFj+OrK+cSdyrYFJkjIpJsFRW/VgamaeV/m2vaGxQ/5mdUsVcTkk/H
         Tsevm1k4z3R8oJKaPHRNjMqhrcSNVI+b7u5BHIEVrYijKtolrOl0Ri3e2BGFVM2wK1Br
         nGKzVTZH8N1+6mgoalyOCUd/ku4100uHhopZEFY8/x7CexlRXWwHzc2w8XnFoUsaUpvf
         cPCPZKtyCKcqEhr8Z7jU5K6ogNZKJGI0nP5/i062kiOFRGeviAaxsPZURPRWlYFTGRzo
         nELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Y0NjIS+CY1bRy5mGkZTuI5JlDYUm77x/O9lkeLYyxKs=;
        b=veo7gw9SGMQbfKbcC+esZCuAUGdBXqZTpvYdptISV4C+LS1+E1A6drE49t3YCQM5XK
         KUoA8m3LKUz+2TBBya+1leOnic7mtV8gU8E7zM3YmgmBKEwezHTK5VH42sz4Gs1P9f2G
         ngkuPZagB9ZweEGFRfQOrCl1GE1AlNUeR/jEuTAk8gBW+bl7k36KnWNT3ecVQkl4KrG2
         vS0jdyImElHCnQNiKyZKGmnVsDepSgjGsHWfl20GczFVbNYHvFa8dz5P4cCu8Bnh/yWj
         X3whgpbCMhBUV7jSSUCLkZdR/G2oCpFp3OyajX4udMZV6uYf8YiSSkIyyb/XZCNCX+AZ
         kskg==
X-Gm-Message-State: AOAM5325Cas2NUSY2TUeSEemGNXmuyiAXtvFAZzCFuEcEWI5wpLp/3EB
        1g2xKnWwv3gnTO0PaI06ezpuDWp+ipg=
X-Google-Smtp-Source: ABdhPJwcpg9JZ+mmK4oQP+2LnPIIK8yohqLOZDJBO1HJF0xgkk0xeWwVmBg/p4zG/uSLNOVPsn2yIA==
X-Received: by 2002:a05:600c:4202:b0:382:a5d7:9ce5 with SMTP id x2-20020a05600c420200b00382a5d79ce5mr2845225wmh.45.1646823850957;
        Wed, 09 Mar 2022 03:04:10 -0800 (PST)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm2072203wrt.63.2022.03.09.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:04:10 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 3/4] terminal: work around macos poll() bug
Date:   Wed,  9 Mar 2022 11:03:24 +0000
Message-Id: <20220309110325.36917-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309110325.36917-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On macos the builtin "add -p" does not handle keys that generate
escape sequences because poll() does not work with terminals
there. Switch to using select() on non-windows platforms to work
around this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index cb653419c3..4189cbb12c 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -82,6 +82,32 @@ static int enable_non_canonical(enum save_term_flags flags)
 	return disable_bits(flags, ICANON | ECHO);
 }
 
+/*
+ * On macos it is not possible to use poll() with a terminal so use select
+ * instead.
+ */
+#include <sys/select.h>
+static int getchar_with_timeout(int timeout)
+{
+	struct timeval tv, *tvp = NULL;
+	fd_set readfds;
+	int res;
+
+	if (timeout >= 0) {
+		tv.tv_sec = timeout / 1000;
+		tv.tv_usec = (timeout % 1000) * 1000;
+		tvp = &tv;
+	}
+
+	FD_ZERO(&readfds);
+	FD_SET(0, &readfds);
+	res = select(1, &readfds, NULL, NULL, tvp);
+	if (res < 0)
+		return EOF;
+
+	return getchar();
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -247,6 +273,16 @@ static int mingw_getchar(void)
 }
 #define getchar mingw_getchar
 
+static int getchar_with_timeout(int timeout)
+{
+	struct pollfd pfd = { .fd = 0, .events = POLLIN };
+
+	if (poll(&pfd, 1, timeout) < 1)
+		return EOF;
+
+	return getchar();
+}
+
 #endif
 
 #ifndef FORCE_TEXT
@@ -397,12 +433,7 @@ int read_key_without_echo(struct strbuf *buf)
 		 * half a second when we know that the sequence is complete.
 		 */
 		while (!is_known_escape_sequence(buf->buf)) {
-			struct pollfd pfd = { .fd = 0, .events = POLLIN };
-
-			if (poll(&pfd, 1, 500) < 1)
-				break;
-
-			ch = getchar();
+			ch = getchar_with_timeout(500);
 			if (ch == EOF)
 				return 0;
 			strbuf_addch(buf, ch);
-- 
2.35.1


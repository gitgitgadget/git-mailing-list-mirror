Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498FC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiCPSzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbiCPSzb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E121829
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x15so4241434wru.13
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ZJnaG7Qrvg1iVlT6oS76xZQrmLcaeNcLfgFeD+xm/BE=;
        b=dH8HzPmRbE+SjJcopIQ7V55Hm4a8m1s4MwO4d3aUiRWxJEctaiGYUu+6DGFoWbbmFc
         Di4fbY07O76jBdZ2etJPvIMrXJgWOTkJgSyWETCWo4VkU6vkJOG5qxOB7LBzTTWhVuZW
         AZyGSp8amCdYziZQPI15Qo4bz0IlXAi3FkTOO+PldzTIYA8f6BjLenmIJVVPk4rJXXLL
         gGmYSHVbwNzF0K+hp4uBubACTPjqopY9MAqDvrX4vSor+8h+zEyKmLVa6zNNzXYxZTWa
         a5as3rhQcD0f9dj8SDRpfBOlKNhtyzPspv8DoUEPxBEkkIHz2574TVcmn4T6ZUFYG6Il
         01zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ZJnaG7Qrvg1iVlT6oS76xZQrmLcaeNcLfgFeD+xm/BE=;
        b=w8ghcRItPJtwt30/KSj8CatB/wDzRH3arGzB+/l5uIctinnxUWReWsxKuskQC2wtSo
         AcdGm7R9msQmdUzfIIxJAEESpXvgJ+rBo0a59QaSL6goAoes/pbpn2UTTealsOtutz/8
         3I0lkwCAaqtGHRwLyC+Mx8rZIkso3Z7pzxegPrxAobq9cKWr24Fy28mKs+IwXLEMlU+/
         lrnrmR15WNGcXW76oYkfEEA+u3LZUZuqo7OmuzqBv3rm8yPywFxqSv58nStoKLY0WaEq
         Y20rDSPRNOXuA1lRk0WyOKSp7odvAjKeBYnuUZFUqiW3Zwqni/9sgVqRBdnhiHXtVFws
         /Lmg==
X-Gm-Message-State: AOAM530c18tmoXkA8scVr7+ULvn31rlYLPUqn4SIvlF06diQs4jLvzJq
        LqJmviwvD3d4yf1aG6If9zDfXgi1GXHORQ==
X-Google-Smtp-Source: ABdhPJwA5kXxkp8Peqn3EkvZDFGIVtl5p1iDsbE4EBfw2SQtkYcSHkG2mGLpF1PEiX356GfO71sFIw==
X-Received: by 2002:a05:6000:178c:b0:203:8b24:42b7 with SMTP id e12-20020a056000178c00b002038b2442b7mr1021911wrg.352.1647456854838;
        Wed, 16 Mar 2022 11:54:14 -0700 (PDT)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm2409144wrw.91.2022.03.16.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:54:14 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 3/4] terminal: work around macos poll() bug
Date:   Wed, 16 Mar 2022 18:54:04 +0000
Message-Id: <20220316185405.29551-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316185405.29551-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220316185405.29551-1-phillip.wood123@gmail.com>
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
 compat/terminal.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 4893294eb6..2ae8a6f13e 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -92,6 +92,31 @@ static int enable_non_canonical(enum save_term_flags flags)
 	return disable_bits(flags, ICANON | ECHO);
 }
 
+/*
+ * On macos it is not possible to use poll() with a terminal so use select
+ * instead.
+ */
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
+	if (res <= 0)
+		return EOF;
+
+	return getchar();
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -257,6 +282,16 @@ static int mingw_getchar(void)
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
@@ -407,12 +442,7 @@ int read_key_without_echo(struct strbuf *buf)
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
 				break;
 			strbuf_addch(buf, ch);
-- 
2.35.1


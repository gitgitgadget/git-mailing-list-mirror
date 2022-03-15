Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18183C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347706AbiCOK7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348045AbiCOK64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:58:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E371C3526F
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j26so28369371wrb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rlSxrIK8uSgVb6L9FxQlZ/+0o5IDpChMZH+9IHC18nw=;
        b=dRJ2H4iS5ShDUbqLRq43svK5MMu6ndvU9jN/YqZbHhUcghQQhVoKRRcxiKm7iUslnV
         qEEmaCTvtCZ3b1C4bNYRBMX8uqXrluVkjtgmg+4M7+ifEy+L7pdB9PZCtly3Gu/Rfsam
         Bt2neBuwPUDIC2D7nPg+CuRZwoSFBPQInbZLS8nJAmeGDbnAV9HVvOOa6qRz6k0tiMSS
         miyQ5RuW9TTmsWaQQ7Es8wTH3JIXR7U1Y46PiKgeH5G6zr9jb8Qz6vTu7P5/z2sHX60v
         yNDH5d1TTMxVSXHXcY+z6VzuuKtDubtkVxMPMsknc1Cjc98ksUuLCRPtw336x33CZ33j
         acSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rlSxrIK8uSgVb6L9FxQlZ/+0o5IDpChMZH+9IHC18nw=;
        b=BFkwvAndmZ6yNG5egELRFIjzyDH0CLEZH/0pAQru5pG5bal/a9ZlscBhJiL/qG2/Pb
         Hw1d+OuU7QaTjutmGhp8+zOsUOiTrYvnBsXrWPFqIqH3dpSaVx2jHODIMElzPHbztN1x
         Y75aGWb0ZKvZptDLf7takFiB9UnPedtfPXSvskRUobiBivZZVS9SFTzlD3z+TKBdwLyJ
         CoZqmm7okzXrbFQjQo7qnh+glQQrM3Y1dWDNHfsB/Yrz8HMqcfO0+QH5GjSUMZx4OS/E
         DKDUwfzazLtWo61/TG+p4xCy2kQhGPwS5ifHn+7Hjhm9UPt3axywit3gG6Ia8vzzRyl6
         FAKg==
X-Gm-Message-State: AOAM530du1IvF56ABgf2/nfh8/W5NxQryW5BlLojfobw/b7Z6qxBAOzM
        jENhhJV7pmyk5bmSKjqSR70rl6HAQvEpEQ==
X-Google-Smtp-Source: ABdhPJzIEXyFtLh5q7KCsHTq74TGMtoVPNO4Ti4qwk5KJ0Bs8JaTkmBl7pSFosxffgkOVsNJDpP1ig==
X-Received: by 2002:a5d:6d8a:0:b0:203:6efe:7961 with SMTP id l10-20020a5d6d8a000000b002036efe7961mr20297066wrs.367.1647341863543;
        Tue, 15 Mar 2022 03:57:43 -0700 (PDT)
Received: from localhost.localdomain (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p16-20020adff210000000b001f062b80091sm15038530wro.34.2022.03.15.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:57:43 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 3/4] terminal: work around macos poll() bug
Date:   Tue, 15 Mar 2022 10:57:22 +0000
Message-Id: <20220315105723.19398-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315105723.19398-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220315105723.19398-1-phillip.wood123@gmail.com>
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
index bfbde3c1af..89f326adc1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -87,6 +87,31 @@ static int enable_non_canonical(enum save_term_flags flags)
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
@@ -252,6 +277,16 @@ static int mingw_getchar(void)
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
@@ -402,12 +437,7 @@ int read_key_without_echo(struct strbuf *buf)
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


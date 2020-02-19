Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD968C3524E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7842B24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4g32THh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBSUeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:34:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBSUeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:34:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so2167243wrm.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C5KPLfghLVF3H1oAYilsqZovlCM05/fDn4pWmjwGGdE=;
        b=m4g32THhQAukWD2Ru3ORwuWDLeB4C1g5MpPG4xVjmof4ij9nQZhnFqmt/BISLm3Q5H
         cSiFyZdZaJIfV3ZkeFsiLu0iMtcpNJwvodGTDYiMbhhe98FT16kgdamic3oj1tWq4eis
         M+Yn5xkTvFgAe8xzHEHjvoyTHjmybnR/I9GjtcNcGqYEIM0tzHwchgilS1oK5TDHPGu1
         JdxQhN96ShgSS4TtFMMwY9gwJuT/kqnKWo5DvV5D4uhO6To3knztefPRVbRWTHObDsRi
         eMPFx8EaipNzp8xkHsZ6se2loLW+Fmc42RreNR0gevAxytU9rXzZM/jBgQP4u7tPiZiB
         LZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C5KPLfghLVF3H1oAYilsqZovlCM05/fDn4pWmjwGGdE=;
        b=tqpHeIcrUjD4UM4ELjmeX3jmd8/bN/uqgDvX6zl3pZY1S8DBaTois79zH5HWPaM2/Z
         XtCl6jB9fH/mt+05Wl475dkCaZwAuQnCoUMSw4jt2KN+MRzZssfMeu7w/fR/VYhv1BKb
         huw3S8XjYG1BLzQbuH/QLiVTiSMnVFKr8gYmXoyerv2J3b69Io+MOKgFaPbEbtvxVx6+
         CFF8UQAtqyjUg06GQc+K4qGHyFymr4voeOv4lnGZHofPSdelmGtF4FbzFiMLgHqMDBQj
         U+FMA2KwOUU4XYG6ZLhqqUcM4BSAhnAv7XI/8tnch8tVyqkRyP5M5kLlqzQbIEIvbn4m
         +hPQ==
X-Gm-Message-State: APjAAAUJIq0XlTVpTw8vx0FeGdrl5dZ4uzOXNLE4Oqrc81oVv9ImN4Sz
        ouEmjemVVO9NcLbTpIu6VwVzsbA4
X-Google-Smtp-Source: APXvYqx5gvfwHKjVZw5R1XH8PTpNvBaD8tcC3MEEby6Q3oRjRnk2o9vbcwpOSwHaBGvnnRVUayUnCg==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr38264480wrg.266.1582144445097;
        Wed, 19 Feb 2020 12:34:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm1239313wrp.4.2020.02.19.12.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:34:04 -0800 (PST)
Message-Id: <a2a145c705e2751d4ced9cc71e62d5c560adb6e6.1582144442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
References: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
        <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 20:34:01 +0000
Subject: [PATCH v3 2/2] advice: extract vadvise() from advise()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

extract a version of advise() that uses an explict 'va_list' parameter.
Call it from advise() and advise_if_enabled() for a functionally
equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/advice.c b/advice.c
index 345319005ac..0c144c69487 100644
--- a/advice.c
+++ b/advice.c
@@ -128,15 +128,20 @@ static const char *advice_config_keys[] = {
 	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
 };
 
-void advise(const char *advice, ...)
+static const char turn_off_instructions[] =
+N_("\n"
+   "Disable this message with \"git config %s false\"");
+
+static void vadvise(const char *advice, va_list params,
+		    int display_instructions, char *key)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
+
+	if(display_instructions)
+		strbuf_addf(&buf, turn_off_instructions, key);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -169,37 +174,25 @@ int advice_enabled(enum advice_type type)
 	}
 }
 
-static const char turn_off_instructions[] =
-N_("\n"
-   "Disable this message with \"git config %s false\"");
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params, 0, "");
+	va_end(params);
+}
 
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
 {
-	struct strbuf buf = STRBUF_INIT;
-	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
 	va_list params;
-	const char *cp, *np;
-	
+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
+
 	if(!advice_enabled(type))
 		return;
 
 	va_start(params, advice);
-	strbuf_vaddf(&buf, advice, params);
+	vadvise(advice, params, 1, key);
 	va_end(params);
-
-	strbuf_addf(&buf, turn_off_instructions, key);
-	
-	for (cp = buf.buf; *cp; cp = np) {
-		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("%shint: %.*s%s\n"),
-			advise_get_color(ADVICE_COLOR_HINT),
-			(int)(np - cp), cp,
-			advise_get_color(ADVICE_COLOR_RESET));
-		if (*np)
-			np++;
-	}
-	strbuf_release(&buf);
-
 }
 
 int git_default_advice_config(const char *var, const char *value)
-- 
gitgitgadget

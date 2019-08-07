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
	by dcvr.yhbt.net (Postfix) with ESMTP id EF85A1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 09:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfHGJxZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 05:53:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36510 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHGJxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 05:53:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so40012335plt.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6CZhifYJ4BSyuCE5YfGskbQDZ2dfgRPvHYZYLB2BPY=;
        b=g1jAkA/KFI/7ZKQXCVFgFHnfaXDmj4NydYPnfE5ZComGsF6ilUrUIsxrw2em0/w0ae
         lNc6c9zcuLTsUD8BR82JgTBJHlnvkkBWo51GBsZEP9NRjAZuNYgqTatqW7woNT9w06dl
         b6vOunwHMX9YLeyV6Nh7asJCc4nGTtu87dsS4SK0BejyfssKesS8g4kn3Xws4q5ccPsJ
         BptclEjzi1TDhjM71a7MhWw7uNC0lZqEpXigEgd1ENJ/FXgEnqHO57Z5n1oouFJiChDn
         pfky/6HMyua7gNwpjuHBlbGZD2ONh+cVjZ85bqnxaTGxNg9ghUXWxiM88pXLzkpmCtTm
         AnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6CZhifYJ4BSyuCE5YfGskbQDZ2dfgRPvHYZYLB2BPY=;
        b=XELtegXbs3GPodYFr5d2R1YJ8Hel/Hb4LYzKy3kV4wQEtO3+RU1NHpmDR9Dn7413Ez
         kwmwm6QDEuhegEwOxnfJyhEkc6hY15MEykG40T+9GZZpu2YwNp88kXlUgr1PXxieS9zF
         EQrAwiOgkseViB8gUjPIHfDuaI12+vpPUc+IcrT7qQr4me8l5M6YYVci7W3x2RKThv/b
         xTI8LkTWci3240Tvq4OOk5F8tXfCLs+hBD4DsIbrehqJES2TeXzttk7xQFLM9JjY9k7N
         ZRV+S4EUVVwp/BncnJ5dH24LLeqmc/JV7efDsl1pReQqB2bGpB5Xva0OJcDo1vOWecYU
         N40w==
X-Gm-Message-State: APjAAAVakkVXMMJK7HnFW3AFzvcOAf45K5HYma3mlPk3Ew7SELaTXVfw
        TzuzORIX/XlXocKL1GP1Ntjd9N/kT2Q=
X-Google-Smtp-Source: APXvYqz7Rmw2RSDoIU0Jqs3N1xOJlA1E+PsVLdzT7BK8ZA5B/gPfgxgDTUQaab+U0W3t1/aaBM5HFg==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr7281755pls.179.1565171604661;
        Wed, 07 Aug 2019 02:53:24 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x128sm134047524pfd.17.2019.08.07.02.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 02:53:24 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: [PATCH] cc5e1bf992 (gettext: avoid initialization if the locale dir is not present, 2018-04-21) changed the way the gettext initialization is done skipping most of it for performance reasons if the locale directories wouldn't exist.
Date:   Wed,  7 Aug 2019 02:53:22 -0700
Message-Id: <20190807095322.8988-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in environments where the build running wasn't installed and wasn't
using NO_GETTEXT the initialization of charset will be skipped, breaking
is_utf_locale()

Split the init function on two, so the initialization of charset could
be done before a decision to abort was made and therefore keeping most
of the performance improvement.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 gettext.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/gettext.c b/gettext.c
index d4021d690c..3ecf456f74 100644
--- a/gettext.c
+++ b/gettext.c
@@ -69,7 +69,14 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
 
-static void init_gettext_charset(const char *domain)
+static void init_gettext_charset(void)
+{
+	const char *current = setlocale(LC_CTYPE, "");
+	charset = locale_charset();
+	setlocale(LC_CTYPE, current);
+}
+
+static void bind_gettext_charset(const char *domain)
 {
 	/*
 	   This trick arranges for messages to be emitted in the user's
@@ -150,7 +157,7 @@ static void init_gettext_charset(const char *domain)
 	   2. E.g. "Content-Type: text/plain; charset=UTF-8\n" in po/is.po
 	*/
 	setlocale(LC_CTYPE, "");
-	charset = locale_charset();
+	/* charset was already initialized in init_gettext_charset() */
 	bind_textdomain_codeset(domain, charset);
 	/* the string is taken from v0.99.6~1 */
 	if (test_vsnprintf("%.*s", 13, "David_K\345gedal") < 0)
@@ -166,6 +173,7 @@ void git_setup_gettext(void)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
 	use_gettext_poison(); /* getenv() reentrancy paranoia */
+	init_gettext_charset();
 
 	if (!is_directory(podir)) {
 		free(p);
@@ -175,7 +183,7 @@ void git_setup_gettext(void)
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
-	init_gettext_charset("git");
+	bind_gettext_charset("git");
 	textdomain("git");
 
 	free(p);
-- 
2.23.0.rc1


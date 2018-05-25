Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172AA1F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030239AbeEYVBe (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:01:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52030 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968376AbeEYVBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:01:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id j4-v6so17562872wme.1
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xESZ+71xCuGltKe+Jl2jJMFEU30gaUgAO0krP10ZT74=;
        b=krC5rGfn+5YuMGOslP+YGwkvbBRWNDgCoDbuyI7pNEmlPWgQiBjPD8p3cUl3armPn+
         O4uyBf2TaHX4H6RzNe6zD2IYm1k+rAdyN2oDy8t0InZTuc7iSU8WsTCfWnn7DyzwOdpA
         W4rBf2e7lrCcjDPoP9bQ3LVwYFqnJ/wWNOfboofp5d8IDl4olOJ0fSSBa4x9hlnls9CA
         6u/Vt8UTS0fFLmAEFDQaovwdlaHoBZQh5YfW6bjUD/wYIPhzDB45PW45Njt9uSDEKvZk
         Do4zU2noDfMnd1ZLKwYtOIH8rHrT2nXQOBC55KmDzo2ktPZJ7mjfaBeXs4O6p/aXO5QV
         EmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xESZ+71xCuGltKe+Jl2jJMFEU30gaUgAO0krP10ZT74=;
        b=Cgyn8caPjSdgtMLplmpp+h+XzN9TgmZO7TPzG/FsZ5JINX5sELWPCP/iYO76Hklv8W
         beINJsACYddZOYRNZM5SwMD+yH80+WzJwS9j17yQSUqLOP3Sma8dseSeR9sgCZSQtDgk
         Hrzb6MpuEtn82wMy37a2B2wGbsS/0C34Z85VzT5/YiaZaMDZwWR34lGT8NncCnQSE3yd
         wXY3Nm+Lce3+dxjDmxCEqRRDPNKVtR9PcVwJoYiR++XWsCc5HVXO+eDnelWe2v8nizJn
         JUtSusauE8ZqkACWw6IxGBup6I95JSjDjNcwrJ7jXa2rH34knwFWTpm6MpB+DSoLXrJ5
         Gi1w==
X-Gm-Message-State: ALKqPwcrEBrDVCS/Zc1lYd+Zj/Wm+jaCYbSYsSv6TDPbN1tJe2J4ag9l
        5KSxRQO3AK+x2QnZRBrKt81D6NRs
X-Google-Smtp-Source: ADUXVKKeA9qq1iHh+QN3uG+CCnR6uVnoJQNi4FD40OpA0zjelnwkaxLIUf31ye27bniC/hGK20RA2g==
X-Received: by 2002:a1c:c5cd:: with SMTP id v196-v6mr2668845wmf.16.1527282091729;
        Fri, 25 May 2018 14:01:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q9-v6sm2520105wmq.45.2018.05.25.14.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 May 2018 14:01:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from `advise()`
Date:   Fri, 25 May 2018 23:00:53 +0200
Message-Id: <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b05
In-Reply-To: <cover.1527279322.git.martin.agren@gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

advice.c contains a useful code snippet which takes a multi-line string
and prints the lines, prefixing and suffixing each line with two
constant strings. This was originally added in 23cb5bf3b3 (i18n of
multi-line advice messages, 2011-12-22) to produce such output:

hint: some multi-line advice
hint: prefixed with "hint: "

The prefix is actually colored after 960786e761 (push: colorize errors,
2018-04-21) and each line has a suffix for resetting the color.

The next commit will teach the same "prefix all the lines"-trick to the
code that produces, e.g., "warning: "-messages. In preparation for that,
extract the code for printing the individual lines and expose it through
git-compat-util.h.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I'm open for suggestions on the naming of `prefix_suffix_lines()`...

 git-compat-util.h |  8 ++++++++
 advice.c          | 18 ++++++++----------
 usage.c           | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f9e4c5f9bc..23445f7ab9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -415,6 +415,14 @@ static inline char *git_find_last_dir_sep(const char *path)
 struct strbuf;
 
 /* General helper functions */
+
+/*
+ * Write the message to the file, prefixing and suffixing
+ * each line with `prefix` resp. `suffix`.
+ */
+void prefix_suffix_lines(FILE *f, const char *prefix,
+			 const char *message, const char *suffix);
+
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/advice.c b/advice.c
index 370a56d054..ffb29e7ef4 100644
--- a/advice.c
+++ b/advice.c
@@ -79,24 +79,22 @@ static struct {
 
 void advise(const char *advice, ...)
 {
+	struct strbuf prefix = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	va_list params;
-	const char *cp, *np;
+
+	strbuf_addf(&prefix, _("%shint: "),
+		    advise_get_color(ADVICE_COLOR_HINT));
 
 	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
 	va_end(params);
 
-	for (cp = buf.buf; *cp; cp = np) {
-		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("%shint: %.*s%s\n"),
-			advise_get_color(ADVICE_COLOR_HINT),
-			(int)(np - cp), cp,
-			advise_get_color(ADVICE_COLOR_RESET));
-		if (*np)
-			np++;
-	}
+	prefix_suffix_lines(stderr, prefix.buf, buf.buf,
+			    advise_get_color(ADVICE_COLOR_RESET));
+
 	strbuf_release(&buf);
+	strbuf_release(&prefix);
 }
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/usage.c b/usage.c
index cdd534c9df..80f9c1d14b 100644
--- a/usage.c
+++ b/usage.c
@@ -6,6 +6,24 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+void prefix_suffix_lines(FILE *f,
+			 const char *prefix,
+			 const char *message,
+			 const char *suffix)
+{
+	const char *cp, *np;
+
+	for (cp = message; *cp; cp = np) {
+		np = strchrnul(cp, '\n');
+		fprintf(f, "%s%.*s%s\n",
+			prefix,
+			(int)(np - cp), cp,
+			suffix);
+		if (*np)
+			np++;
+	}
+}
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
-- 
2.17.0.1181.g093e983b05


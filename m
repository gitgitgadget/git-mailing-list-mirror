Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40CC3F68F
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429E3206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA2/NLlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLUWmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39573 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfLUWmI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so12059054eds.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JET1NJ4q/e6Snx1Om+BJX/knGaLwGYlHv8q0KraWMdI=;
        b=NA2/NLlz5JhNdvEIZYmOc9wa2cAaKsuAbpQuOV2BVX/J0HrKAGOzZdvMoDGMPnXG0+
         hZIvQYD18hPohAaTi/21spmODNTHp9HeL4yWZQ73CC6YWFKm+yjz9zaazZbY7BOSwTQX
         bIrh8bGOymRYA05xC4HBb5YWPrNIVctumRh9IDBL8rDNwLrSUtVfzsJUedmrz57O7lJW
         HGBgSPV1lv2OthCGaCpWbVm7ftz6vld3uYNdNw3yDRKHr+BkMsvOIcxCSc3NKp8ntYSS
         wMvYqtbu8bxVorldDOoY8p4DI4jJNyDmatPha+w843Kg7ciHGHO1aVfvAcRI2ONtXp+P
         mccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JET1NJ4q/e6Snx1Om+BJX/knGaLwGYlHv8q0KraWMdI=;
        b=pBNMfjURzZxZAMiseIgp7xuJ105363JkiswL9cMRM0sQQmuJA7bHgnUC89OkF6uvOa
         vz/KCHDBZauJo1aNDrFiUIFDV4+gIwFpZqv+K809qwx2jE0ZHMCyQiTVo5l4iwBqqtSK
         G7BCG1enGeNUZB/oEWZLX4hgTMONw4I9E4TczEWvRh2Ri161OnDv3uyLGZhK5qcAW/3E
         Z1NOcRVTT8JN1CJpK8mmMGuy8wRdaEZQV1+tDNGqpyjZkaRNJoq8sxhRffhdKutUUp9U
         fnCyhwqNxrdFvhC4FS56Fj0qM6o2NEpbeclyvD4oQC8e9WAwQSv32vfSnVZYZgfneQXD
         nrLw==
X-Gm-Message-State: APjAAAXXf6J35KrULP7QqhxUgOOFcxT5SCHwAfUotXYIceWevd9uBW4d
        zy5kzTD1Ay2Ti6TEJgGG184IINEb
X-Google-Smtp-Source: APXvYqxpOPyNfvmqJ47LkfIlpgZ5w1iqCBqOZiYFev4jSjwN6k/7eCFQJqP+UMKvn5Trq21JXuRD0g==
X-Received: by 2002:a17:906:4d89:: with SMTP id s9mr24449854eju.268.1576968126292;
        Sat, 21 Dec 2019 14:42:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm1558771edl.11.2019.12.21.14.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:05 -0800 (PST)
Message-Id: <6d6794089d23169c7ea20f4d9ad1351ddcd33e51.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:57 +0000
Subject: [PATCH 6/9] built-in add -p: respect the `interactive.singlekey`
 config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of `git add -p` supports this config setting to allow
users to input commands via single characters (as opposed to having to
press the <Enter> key afterwards).

This is an opt-in feature because it requires Perl packages
(Term::ReadKey and Term::Cap, where it tries to handle an absence of the
latter package gracefully) to work. Note that at least on Ubuntu, that
Perl package is not installed by default (it needs to be installed via
`sudo apt-get install libterm-readkey-perl`), so this feature is
probably not used a whole lot.

In C, we obviously do not have these packages available, but we just
introduced `read_single_keystroke()` that is similar to what
Term::ReadKey provides, and we use that here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  2 ++
 add-interactive.h |  1 +
 add-patch.c       | 21 +++++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 77762d75d6..01a2f92f0c 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -60,6 +60,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	FREE_AND_NULL(s->interactive_diff_algorithm);
 	git_config_get_string("diff.algorithm",
 			      &s->interactive_diff_algorithm);
+
+	git_config_get_bool("interactive.singlekey", &s->use_single_key);
 }
 
 void clear_add_i_state(struct add_i_state *s)
diff --git a/add-interactive.h b/add-interactive.h
index 21389851aa..3450359685 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,6 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
+	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
diff --git a/add-patch.c b/add-patch.c
index fdfaa76c3c..ef0469d398 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "color.h"
 #include "diff.h"
+#include "compat/terminal.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
@@ -1148,14 +1149,27 @@ static int run_apply_check(struct add_p_state *s,
 	return 0;
 }
 
+static int read_single_character(struct add_p_state *s)
+{
+	if (s->s.use_single_key) {
+		int res = read_key_without_echo(&s->answer);
+		printf("%s\n", res == EOF ? "" : s->answer.buf);
+		return res;
+	}
+
+	if (strbuf_getline(&s->answer, stdin) == EOF)
+		return EOF;
+	strbuf_trim_trailing_newline(&s->answer);
+	return 0;
+}
+
 static int prompt_yesno(struct add_p_state *s, const char *prompt)
 {
 	for (;;) {
 		color_fprintf(stdout, s->s.prompt_color, "%s", _(prompt));
 		fflush(stdout);
-		if (strbuf_getline(&s->answer, stdin) == EOF)
+		if (read_single_character(s) == EOF)
 			return -1;
-		strbuf_trim_trailing_newline(&s->answer);
 		switch (tolower(s->answer.buf[0])) {
 		case 'n': return 0;
 		case 'y': return 1;
@@ -1395,9 +1409,8 @@ static int patch_update_file(struct add_p_state *s,
 			      _(s->mode->prompt_mode[prompt_mode_type]),
 			      s->buf.buf);
 		fflush(stdout);
-		if (strbuf_getline(&s->answer, stdin) == EOF)
+		if (read_single_character(s) == EOF)
 			break;
-		strbuf_trim_trailing_newline(&s->answer);
 
 		if (!s->answer.len)
 			continue;
-- 
gitgitgadget


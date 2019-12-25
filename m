Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077ECC3F68F
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29342075B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/emTYJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfLYL5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45492 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYL5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so19722244edw.12
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0phmocog8B6q0Tw8zeYRgiTpc3ndWE2xf19kROVrxLg=;
        b=U/emTYJWk3TeBQBzRfXODKDP+0VcN55L7AHOXEezszztS0eqmACgbk3DcDBTY3Z72y
         qZEY6iSs34NiGnI3HqEhi4O4mMYYfC7gIM0qA2HeOMceu0IUFcpStHLsv49SrlrQCDQ3
         z8NZMVbUHiO7NznIjN51Orl1L4cT89ls4K5lDcxqvaPb9p2LklI3fzs7QKEMXDvAS18M
         oM7u4ruQcig5viuJEd6PIz3YSmXkC4Y6GCISCno+03KF45nchna/8+OzWatuB0Wlmbeo
         ZzZ0lklHNgJ5oJynOdyzhLjpW1u14O4M9F9t5Xhpy9YyBbaWp23WHNEUfQFySkPwsFyY
         LDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0phmocog8B6q0Tw8zeYRgiTpc3ndWE2xf19kROVrxLg=;
        b=tPb7wDqLjtDasm/IYxajOsqRiuHf0VoXl/8haTFnTfFBeOm1F53oUC3W8YEWS0fuNs
         E6cJ52+yuvOTj2xaep3WaCKPM88nSTSM1K7LPaEKPU0Oi/3G3bjUPyylFq8Mq7ZwvLV5
         NiLMq+878yBrU5Wfc74P1xI3gTDFi3WChSTm+OPDU1tZMf3s1zkl5q0YXFqNwZA9st7w
         8hbewaZ/Atuxlt0TG5S8aNkNt6ppt0FHrRb8i3MOAIgZrN/jpVZgR1/QCdo5ZpvO7Hoi
         QFDp4TEyIdwTrWl7ufwg4ZH7drt1xfnuDoZTtY7qLQn8PqYZ/On9CJMzvoaFbD4KjNUO
         ECfg==
X-Gm-Message-State: APjAAAU/aE3QEnntynYwPgxorqVwBqiJVsFACWmeFODDTcaKvBnhqT33
        /ZvEwRxzOLIEd+CbheCrMKLlBIv5
X-Google-Smtp-Source: APXvYqw4Di0WwZlnhNgcWmTe17UUf7QtmpmfxsSH8+AteRqKxLPJ4buuLSSNgYFp/WjgxPNLhshq4Q==
X-Received: by 2002:aa7:d80c:: with SMTP id v12mr44839966edq.302.1577275026539;
        Wed, 25 Dec 2019 03:57:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26sm3190273edv.13.2019.12.25.03.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:06 -0800 (PST)
Message-Id: <167dfa37dde5d04192fff40147f8566d74e96015.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:57 +0000
Subject: [PATCH v2 6/9] built-in add -p: respect the `interactive.singlekey`
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
index 9e4bcb382c..39c3896494 100644
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
index 923efaf527..693f125e8e 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,6 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
+	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
diff --git a/add-patch.c b/add-patch.c
index 8f2ee8688b..d8dafa8168 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -6,6 +6,7 @@
 #include "pathspec.h"
 #include "color.h"
 #include "diff.h"
+#include "compat/terminal.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
@@ -1149,14 +1150,27 @@ static int run_apply_check(struct add_p_state *s,
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
@@ -1396,9 +1410,8 @@ static int patch_update_file(struct add_p_state *s,
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


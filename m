Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066AEC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFED21569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaptTYop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgAMI3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgAMI3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so7559652wrh.5
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aND/3GJvNSHXZ8taybupake9AqWWRmBT3O7QXIsD5Og=;
        b=TaptTYoprF5o7GiZwOy1Y+iEWoru5ydii2mVUMb0ehZdUKmbJEUgfpwh8Z52szWp22
         XH2NSnJwMWz60mGnuUQs85AsXRXf27wSI8Vd/9Av2bxNgerBEbju9JCVCfA1J5LXf1ro
         YzVIim9PSq1Rkaa0eo1K4EaUdcqVXC2ZluFMvi1fGvzKlI0qseKRkblhn1xaX1IiqX3C
         0X/ZXdxx2NxqhPlxLJwYdKM/AWMP6JuIvIfI7wBGSmyqllHFKnpnzXl6sLcIZaphc9Va
         wC8tO517jOj3YL97sJG0cOlIo0Z+z6wWM/er86uWZQOq7KR+TkgMwDwbVJzptOqCPCKF
         mtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aND/3GJvNSHXZ8taybupake9AqWWRmBT3O7QXIsD5Og=;
        b=HSpsyQWj2HNtKIJgQrVvTgjhgIlH0YZWyvux2TEDdb2WqJroIFDci2d4O0UVVRxtVC
         mYzFRZNAEEEn/JqpFsQ3UFWZunATy7+xr/R5mszx01ax49f2posxpRiU+1RapYO3lPqd
         9ygjXtaga1cCfjIQgtawHP7+hsGGotBZwdPUg1bxEkWWCW+Iw49/7HjaVF66ObUmdbc6
         eNbZTWZpSv62Rcv/jiqm+zfPnP4GXj7yYqFGo1AuhD6QNt1oqMciMHe4PCLFTC/o2OEE
         wYclB9FuMg11UnpJJrKROlx5SZ5lBmAU5dfriANgefCiL/9TxKZq/6Vvl2JBAuWriBnU
         pdSg==
X-Gm-Message-State: APjAAAW109jKcZ7en3o6FFP4M32BPuDFvmqWLJUp8Z6LH+aqOZcm4PJ5
        R3FDRMkeAk39OiZkTqqauFme/MAA
X-Google-Smtp-Source: APXvYqxXtZqNrhYdHlLkkjhEWpCJ1g6XGoXZ1DGmPgLVZHIlOskcWZJQZHwf+xj4ihXzzEhuafZIRA==
X-Received: by 2002:adf:d846:: with SMTP id k6mr16318724wrl.337.1578904177832;
        Mon, 13 Jan 2020 00:29:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b137sm14015096wme.26.2020.01.13.00.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:37 -0800 (PST)
Message-Id: <197fe1e14adfd8142fa9f4f6c93937d9349d0bdc.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:28 +0000
Subject: [PATCH v3 07/10] built-in add -p: respect the `interactive.singlekey`
 config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index e3cc30ad24..bb6acf5ef6 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -61,6 +61,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
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
index 736bcb4aa7..67741128a8 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,6 +7,7 @@
 #include "color.h"
 #include "diff.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
@@ -1150,14 +1151,27 @@ static int run_apply_check(struct add_p_state *s,
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
@@ -1397,9 +1411,8 @@ static int patch_update_file(struct add_p_state *s,
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


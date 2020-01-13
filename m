Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6525FC33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357FB21744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ypWtpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgAMI3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAMI3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so7560465wro.2
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 00:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d0SCDaEjMx7h4VcUCNKP4T7YIjnAwCxq1dmXl8JxsLs=;
        b=b+ypWtpXaf72aFghRIxCdOaB750hZiq+vNRXzjaxP4obTRDXHpl66SEHqdZvFGGEEq
         2xlBPaWj+5z3PQk5ETWUgNM2KkXw3+0UyzsRjbJx77fY/VrzhWlwCMRJjtatnf+JAwll
         qgRl3dG4FcPXGqxExTLZfs2YXKmABXzokKFCSj4uzp/VgOMXSXk8Ffn1V75yMLC8ycsF
         kcIurjdmFPNq5FtV8gNQmllBq6GuYT6C2SxJH6MSHM1hTklN8A+ub780QoMIoydVP6J+
         pFXndVa5sojfGafiDeLZIjBAXZ0xcfQdbAT965zLbV/arSLl+//b5RxoD8ZwO/8JFgzy
         2j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d0SCDaEjMx7h4VcUCNKP4T7YIjnAwCxq1dmXl8JxsLs=;
        b=OD8a5xl5XDnaNhvdF3iubZ4bh1RXi93cMimX3EcS31vXqrXuXlvZH2rxdwkVgdY0Vn
         tbMP8aAAyyYZ5mfD2drL1zfT82ka35Elxws9ErrWcNPIcfyn7FFpo+fJNv5gC5fC6jX/
         SX+XlAN2zQNms6yXKXwT1JLgQlIBfR4Ttyg5dc1fKxrIyQSHujGthp6rhfilPUcNOe9h
         /ovFPrHrizU1CbExLAusLgIOY8fH3Xzd9TRCacSGKvPKsJ+f0BSqLKZtW4cKDqTLKmNG
         ppau3Jts8QY57Qj3uyzjp/WT5GUXNZ233lO3DzaJEObEwbcJrcpNaE8ubzTlpZqtcdt3
         mZfQ==
X-Gm-Message-State: APjAAAVaSGXfjsMchKR2EQwEByDm6JD2raYUtbESeUhLlZQPJmwu9S3b
        wS8xjjUeLfB4QWo20n5UAbWeOWti
X-Google-Smtp-Source: APXvYqxNNX3c+Rwq4vWOYh2MICvxMZFzM9dmAXXos53PIxJnihMpddzO95hm9WFc5OYuTVZlXLz/lA==
X-Received: by 2002:adf:a308:: with SMTP id c8mr16625677wrb.240.1578904174753;
        Mon, 13 Jan 2020 00:29:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f207sm14487536wme.9.2020.01.13.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 00:29:34 -0800 (PST)
Message-Id: <a2bce01818b6ab0374c19f82acf91b7353f90ef8.1578904171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
        <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jan 2020 08:29:24 +0000
Subject: [PATCH v3 03/10] built-in add -p: handle diff.algorithm
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

The Perl version of `git add -p` reads the config setting
`diff.algorithm` and if set, uses it to generate the diff using the
specified algorithm.

This patch ports that functionality to the C version.

Note: just like `git-add--interactive.perl`, we do _not_ respect this
config setting in `git add -i`'s `diff` command, but _only_ in the
`patch` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 5 +++++
 add-interactive.h | 2 +-
 add-patch.c       | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index b36e5d97d8..e3cc30ad24 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -57,11 +57,16 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	git_config_get_string("interactive.difffilter",
 			      &s->interactive_diff_filter);
+
+	FREE_AND_NULL(s->interactive_diff_algorithm);
+	git_config_get_string("diff.algorithm",
+			      &s->interactive_diff_algorithm);
 }
 
 void clear_add_i_state(struct add_i_state *s)
 {
 	FREE_AND_NULL(s->interactive_diff_filter);
+	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
 	s->use_color = -1;
 }
diff --git a/add-interactive.h b/add-interactive.h
index 46c73867ad..923efaf527 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,7 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
-	char *interactive_diff_filter;
+	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index 7d6015229c..736bcb4aa7 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -361,6 +361,7 @@ static int is_octal(const char *p, size_t len)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -370,6 +371,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	argv_array_pushv(&args, s->mode->diff_cmd);
+	if (diff_algorithm)
+		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		argv_array_push(&args,
-- 
gitgitgadget


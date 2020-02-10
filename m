Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9B5C2BA83
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF13020870
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slTEJrhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJAbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42214 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgBJAbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so5395638wrd.9
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9CUzl0rHQdbRJxpIuAydt9GCzWcDHQJjIx/7G/9ruxs=;
        b=slTEJrhNciadJ+ZzlqMiMLNtQgYI1XMHZ7fD3j49x5Wp6sgOEB82eplglFK7EnLSKP
         T+qSCe5SM4chyFhyiZN9hh/vbOHck3UDBqLaAb/IN3um3naeJvlAUbY3q9qfpAWy4sWU
         KqZ/NK+QrTuSrmQsC9JKVhucMGyeBsAT6b8HHL4COtbd4o5Col8tAWBCUh21aABoXVKc
         WmggMGmgGMfCKknuYU6i7V4OhPNde+9HDacvLOVveExopUMe79bB3QKEUff3Y6ocZRbr
         ZgS2rVk1q4e5zRUlRDv328nrKJbiwis6tjrmAIdBaWNaENezyOkE6k/1YzwXPW3Zao04
         Ca2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9CUzl0rHQdbRJxpIuAydt9GCzWcDHQJjIx/7G/9ruxs=;
        b=STkIrQ1d+7x2AkLseuRBTL2cBw77fiA/bWfOmyijEcjYMxULR4XAzyFfaTjU3E05DM
         di0usgdHFmEw6O1YHhky+wLDuk65Qjdh+wM8EihPqMbaDKs3uOJ9Ibc9eep1ePYxAr+Q
         LGdfPfZJ6Gu3IugEvUTprzs3IoNXFNM/s/TNyhG6wBBLmlChOi+sThlda/ZYjxW+wrK3
         MZ83RISAztq1gi4mc3OgCDDVCLW6y5ylmlvsiPWYIJoN8rMIByjbrEBLJw//T/d0HMaV
         i81aESh+9o6rexPJZEOiIARTx11PXYq06W7jZwMApep4TKYf68qHegQzyfYeA227EKFT
         sFAw==
X-Gm-Message-State: APjAAAXirAMR4GBJEg4n8O7hVgzt3OBQEaZPR/7UDYx44JfB9SonAa0R
        fYR8Hnai+oR2iTJrb0jnsYLbjVtC
X-Google-Smtp-Source: APXvYqzcgKhAqQExrYPJVSlycFuUpIdJiZudozyltB+qkDNKaCaVB6SCV+s6FNq7yzKozb+IF9vJDQ==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr13158092wrm.293.1581294662448;
        Sun, 09 Feb 2020 16:31:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm13805184wrv.96.2020.02.09.16.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:01 -0800 (PST)
Message-Id: <1c4faa7a367baf95d9940f4e9caa1904321601c7.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:50 +0000
Subject: [PATCH v7 01/10] config: fix typo in variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

In git config use of the end_null variable to determine if we should be
null terminating our output.  While it is correct to say a string is
"null terminated" the character is actually the "nul" character, so this
malapropism is being fixed.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98d65bc0ad..52a904cfb1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -29,7 +29,7 @@ static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
-static int end_null;
+static int end_nul;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
@@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
@@ -178,11 +178,11 @@ static void check_argc(int argc, int min, int max)
 
 static void show_config_origin(struct strbuf *buf)
 {
-	const char term = end_null ? '\0' : '\t';
+	const char term = end_nul ? '\0' : '\t';
 
 	strbuf_addstr(buf, current_config_origin_type());
 	strbuf_addch(buf, ':');
-	if (end_null)
+	if (end_nul)
 		strbuf_addstr(buf, current_config_name());
 	else
 		quote_c_style(current_config_name(), buf, NULL, 0);
@@ -678,7 +678,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.git_dir = get_git_dir();
 	}
 
-	if (end_null) {
+	if (end_nul) {
 		term = '\0';
 		delim = '\n';
 		key_delim = '\n';
-- 
gitgitgadget


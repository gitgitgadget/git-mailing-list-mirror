Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B71208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHHQLL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35425 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1308567edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdR1olAKZNZ981DWOat9jkNz15uGDpdIBtJyZe5D3AY=;
        b=KuZmIdE1yGWmGUkQKKdDkHuvI38jzxzyOctY0dJZ3uar0Lo+mwNk7r6KeRMMzfMDCg
         BoDG3vS7FUPVyoatSOpS8LJnTMAgu6hWcC1wp98uvDEh3vqQ5OQqpiHpETRMY7Go9Nwp
         m4OiXt5QWzgCq+8z3RImE9kXeHoI5VnWdpxFwlz61O0/Q9ki9Fo4IhpiMH+iwIku922B
         AJukeZxffUQiDnZ8+iG3C/DBRJGm8DzYuxnLTHbWiBbSAoiYVXkZTJzCrXodScuXk0DT
         kdNzlQdcvjwC+pdYIfq7x/tKCODTD2IQybwDMCcHV8RcVsy0hU1LYCdfv7Xk+DtEP8QM
         JMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdR1olAKZNZ981DWOat9jkNz15uGDpdIBtJyZe5D3AY=;
        b=XDAztttaGcViL57OK/PSFNTDhkCuF7TdtU9En3l3Bl+n7PDcKYRZavypCCUIa0vcrk
         YVG8gyPl7BHmj9TB0/3IZP13P0MdT5bLZp3C831DHid+GjuirhYjg8xqZbfEaqvzvKJx
         oze+AipoXPZQFOlg+334/0pDbrA7zaLF4kjI2DkHxT0GT+5AJscVa4iFAkE9Szjks5h7
         30bmWnulbJA+Jgt7itwnKgeiy7LwqchMLXihsvqBLi/Hicg3sbYC1Zu2C8qgpDfYNKZv
         B4rfwbU3M2M+pI4sfSbK6dLd0i9Epq3+wwsNuzs+/FBrbdt1x6AthBxWkeMr4obdWGTw
         Clxw==
X-Gm-Message-State: AOUpUlEIRrhM1w2H/R3sg/IIfeb6XNJ4Oba3aNQ5pAl49ipcTjhsXbW4
        41PULm0Yv0RYsMa/ShwMqbJAoJKS
X-Google-Smtp-Source: AA+uWPyIfoZ51lOIQIkCVL0f9iZHwztOfcPiRvvapRLzsnQDMbM8Kql1S7aiSxrMWbpvM9ZcGirCRg==
X-Received: by 2002:a50:af03:: with SMTP id g3-v6mr3307979edd.220.1533736283919;
        Wed, 08 Aug 2018 06:51:23 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:23 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 04/11] builtin rebase: support --quiet
Date:   Wed,  8 Aug 2018 19:33:23 +0545
Message-Id: <20180808134830.19949-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces a rebase option `--quiet`. While `--quiet` is
commonly perceived as opposite to `--verbose`, this is not the case for
the rebase command: both `--quiet` and `--verbose` default to `false` if
neither `--quiet` nor `--verbose` is present.

This commit goes further and introduces `--no-quiet` which is the
contrary of `--quiet` and it's introduction doesn't modify any
behaviour.

Note: The `flags` field in `rebase_options` will accumulate more bits in
subsequent commits, in particular a verbose and a diffstat flag. And as
--quoet inthe shell scripted version of the rebase command switches off
--verbose and --stat, and as --verbose switches off --quiet, we use the
(negated) REBASE_NO_QUIET instead of REBASE_QUIET: this allows us to
turn off the quiet mode and turn on the verbose and diffstat mode in a
single OPT_BIT(), and the opposite in a single OPT_NEGBIT().

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b79f9b0a9f..19fa4d3fc4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,6 +79,10 @@ struct rebase_options {
 	int root;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
+	enum {
+		REBASE_NO_QUIET = 1<<0,
+	} flags;
+	struct strbuf git_am_opt;
 };
 
 /* Returns the filename prefixed by the state_dir */
@@ -159,6 +163,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
+	add_var(&script_snippet, "GIT_QUIET",
+		opts->flags & REBASE_NO_QUIET ? "" : "t");
+	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -308,6 +315,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
 		.type = REBASE_UNSPECIFIED,
+		.flags = REBASE_NO_QUIET,
+		.git_am_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
 	int ret, flags;
@@ -321,6 +330,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   N_("rebase onto given branch instead of upstream")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
+		OPT_NEGBIT('q', "quiet", &options.flags,
+			   N_("be quiet. implies --no-stat"),
+			   REBASE_NO_QUIET),
 		OPT_END(),
 	};
 
@@ -357,6 +369,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (!(options.flags & REBASE_NO_QUIET))
+		strbuf_addstr(&options.git_am_opt, " -q");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0


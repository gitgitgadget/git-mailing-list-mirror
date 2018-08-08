Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173EC208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeHHR6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42187 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeHHR6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1460086edp.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4rmi2GBI/+bqSls8GM8y9kSorbvqDaO4nAmNx+upCbI=;
        b=Vjmnr4UY9fLF1HfJ9+niyOnHpBc+D+JT7HySISMnphDUbyTSuxIUHPB2ynOoYVBESi
         cYhEIkj5Gz6PE0svQInp84kcN4t8K/594TnCHaOmKG23EMJPrVA9uIfDrPl4u/J+pHGd
         dSU4uGAyrdPbdiGTVDgBi7p1GOVlIoD2jdU7/8qYMeiH0rlUkd9m3ZxddsdJt38Qh4GP
         k/4vKt5PjuotYfzqbA4tVzZMhAAMFPIoyTNp2L4fO8+Ux2X3IeKunb21+X4eOT37sCW3
         U8OuE0/PpLw8WNm89RVhrXpDM8qpGbbEs7usP7QtqvFr7dIukiMt+7hpU7WR/s2zrPti
         jxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4rmi2GBI/+bqSls8GM8y9kSorbvqDaO4nAmNx+upCbI=;
        b=OStc5AjGDsuWAWF0VZe1f61Ngs2lMgtJqXKMTbHKxvC+nNMPiz1Pt6clRDNC8d/gvO
         RjUfstZ/mEsksQE7U0KxvToFhkIJw2Dl9xun6ep6ieLhOtnAaGlIdhEd/vU7PMpLsO5Y
         VnlF8GIQ9QNVjh0NfF0nZAP8P3457JuEjt1SRwjwu8xBKjHdzLono6mmQ0GgivySaGbE
         H3vLFoL+HE9CVmtgw0HpoSxN7dKM3hqHYEp3OMxyXDxKD5EpzSMlOv237TFPTNPHg4Ki
         3AVD29TpV3zPNCbYRqLnmUrOo1YTJlJ68S3gqUGlfRJzg/kQstEo1FNXGwnu8HB137+A
         bFDg==
X-Gm-Message-State: AOUpUlHiducrOY3zUMK2L5A7Hopvj8zR0Ec7CjHFZw0EksWjFv45fVNa
        gq1Cq5sJpzipScAWQaPcNjcuoVlg
X-Google-Smtp-Source: AA+uWPzidJJHRSEvluRNLIyUpXprFYter/JaQgtULaIpNrOoZGpJYeAYrcYye0eHXqdYJyFF1LdG9Q==
X-Received: by 2002:a50:90e7:: with SMTP id d36-v6mr3733156eda.279.1533742710585;
        Wed, 08 Aug 2018 08:38:30 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:29 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 4/6] builtin rebase: show progress when connected to a terminal
Date:   Wed,  8 Aug 2018 21:21:33 +0545
Message-Id: <20180808153635.19944-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this commit, we pass `--progress` to the `format-patch` command if
stderr is connected to an interactive terminal, unless we're in quiet
mode.

This `--progress` option will be used in `format-patch` to show progress
reports on stderr as patches are generated.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1bb64e7cd7..04974dff6e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -98,6 +98,7 @@ struct rebase_options {
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
 	char *strategy, *strategy_opts;
+	struct strbuf git_format_patch_opt;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -379,6 +380,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "rebase_root", opts->root ? "t" : "");
 	add_var(&script_snippet, "squash_onto",
 		opts->squash_onto ? oid_to_hex(opts->squash_onto) : "");
+	add_var(&script_snippet, "git_format_patch_opt",
+		opts->git_format_patch_opt.buf);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -667,6 +670,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.git_am_opt = STRBUF_INIT,
 		.allow_rerere_autoupdate  = -1,
 		.allow_empty_message = 1,
+		.git_format_patch_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
@@ -1068,6 +1072,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.root && !options.onto_name)
 		imply_interactive(&options, "--root without --onto");
 
+	if (isatty(2) && options.flags & REBASE_NO_QUIET)
+		strbuf_addstr(&options.git_format_patch_opt, " --progress");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0


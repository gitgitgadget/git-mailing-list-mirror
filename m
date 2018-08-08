Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46EEF208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeHHRmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:42:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42109 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRmx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so1434832edp.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8u0Z3uXBkylsEDR6oPHyAt9L69/MYvx4mZotTb4B800=;
        b=LmdY/KZe6JlvWMvwMZwrWbScYYeMGbLmM5A9yGT+mIYSsBZg1hYWDF7gIYDl8LFikm
         pmhTFL4km3clpCSiu7+rCqca062hVxqNmEUUE2GZRt2xagxsHoV31TtLUPqXkbFszKhS
         O5lMQun7Y1Z5VWUuXno1QBV/RNcajvb14kC3gAWqEeR+XzdZNmXgR5D9jKZ8Ij4UFNUy
         Wz7rwy3Yl/O4PQUwGaUbWRYDtiJmRHet6hrqOXwL0dbq9Pknqy10Z/9ExkSg6FVY1CYD
         9d3I8ROOZaQKOBHfp0fESqlg6U1qMj2emqF6znP0ePh+hwHCCAkwUTFDn8AGMqZUXZ4g
         8UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8u0Z3uXBkylsEDR6oPHyAt9L69/MYvx4mZotTb4B800=;
        b=gwYHPHSEbSIlR12izXy3GGZpBUUrWG88smK3MQPK3dMWs1iT8xV0XPj3+dbHthOzqV
         kD7ry9o7na1+gvKi65utGN1/DL0kPYnxXQa/x52h7TPRbQdPvxeelZAUBkL2oqHDGbvp
         e2U8Ou3C+2esIXu6dbC4cniZd6sCyqIwLATgmA9jgh8tFg3UCZkmV+KlPSxjP/JfQ8AI
         T9a7ML4XOycetLC4V1M2FfAtQB2Vt1EN+jtv+utSyldP1ODuvNxYYmF/wN3kTSixOVtV
         zQ4UzQZDfAV0r29RaOf75t6uZ6JoOJpwErXUo/Uk1QDbBD2a1evw05IvMMjcsB1mQIbd
         N4tQ==
X-Gm-Message-State: AOUpUlFHScA3i2Ug19MLSw9EpKkl6o0s7uHKt+jJlDQ6BjbiQNlESGZn
        UpTsUZCH9V7IULSbnDT6zDMj4xT2
X-Google-Smtp-Source: AA+uWPxtYCqqJup2yQ6pm6y5rnT3CNgm5Hb8QtPgMxUVEUvUYJi8vkxQ8E8D3zP1EFdGLwbr0TFFbQ==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr3867763edk.283.1533741764764;
        Wed, 08 Aug 2018 08:22:44 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:44 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 02/18] builtin rebase: support --signoff
Date:   Wed,  8 Aug 2018 21:06:24 +0545
Message-Id: <20180808152140.14585-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for `--signoff` which is used to add a
`Signed-off-by` trailer to all the rebased commits. The actual
handling is left to the rebase backends.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fc9b5a8a60..a491481120 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -93,6 +93,7 @@ struct rebase_options {
 	} flags;
 	struct strbuf git_am_opt;
 	const char *action;
+	int signoff;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -168,6 +169,11 @@ static int read_basic_state(struct rebase_options *opts)
 	if (file_exists(state_dir_path("verbose", opts)))
 		opts->flags |= REBASE_VERBOSE;
 
+	if (file_exists(state_dir_path("signoff", opts))) {
+		opts->signoff = 1;
+		opts->flags |= REBASE_FORCE;
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -249,6 +255,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	if (opts->switch_to)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
+	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -513,6 +520,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BOOL(0, "signoff", &options.signoff,
+			 N_("add a Signed-off-by: line to each commit")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -745,6 +754,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (options.signoff) {
+		if (options.type == REBASE_PRESERVE_MERGES)
+			die("cannot combine '--signoff' with "
+			    "'--preserve-merges'");
+		strbuf_addstr(&options.git_am_opt, " --signoff");
+		options.flags |= REBASE_FORCE;
+	}
+
 	if (!options.root) {
 		if (argc < 1)
 			die("TODO: handle @{upstream}");
-- 
2.18.0


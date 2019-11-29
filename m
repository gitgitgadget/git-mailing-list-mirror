Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ECC43141
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55CD21771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppI4Nht5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbfK2VMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:12:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfK2VMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:12:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so33233348wrl.13
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qJ1a6HTOqBLYgm1IsQ31pUjCVGDn3ReFoq6J95A3NGk=;
        b=ppI4Nht5KK3eQUcY51iyC4SeAQeQSYdEgpqJVvVGWUMQ9PMCNH2sy9IwNsJoN/vIcK
         BAS6G9O3Z1VDJ7ASWztHIgj3xddvtRARdres0rjQ59Xm8O0YNzuxZldyL5N8gQ/ISKRq
         9mGyfLBQ3v/5Mqh37kzN5tAllZxBdZs63S2JOyJCFFo0nN1bU/qZz1Tb3WGU+ihP7LEx
         F2Sq1xB5AdIA8LNlRm6/6/qGWDpF6uuGyQKDgFaiY2BLbb+jemSnVqsPjAU1lxXCNEaH
         cpEM9OnfJM1O/n447m2GZZxxqDg6c+prDTmY7/SdefolU6j/kv551MS7SX+yHjsCCLKw
         LY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qJ1a6HTOqBLYgm1IsQ31pUjCVGDn3ReFoq6J95A3NGk=;
        b=K6v/nPfwE8tIHZnHgHEUyg0jO6G/KVQQSqGp+sVngOJJbw75IfI/wmcXU8VKWnMu2J
         dZkSJnvYoKP2YfsVrRJUTymBMaLgfmhdguKdYrPjcO6h1wqi6j9RJs1b2jLQHhUwZpDq
         A2yAKxSlNY9Q6iQOr0hBj1oap93f7gggeYLiRMyn2j4iLbMRtWqs88yN6odmo6TUsmrn
         NrSRFxFji9Yvpue8zdJUh0v1/Q1JbNhtzff142fshvR5MomCmIAcLEwZ/WuWZ7N21S2m
         EPX2bmVVOmWgG+nly8eEXf4LstaKGr35PhpQQZtl/plcUizsr4px3U08U5zZg7kcODb5
         o6Qg==
X-Gm-Message-State: APjAAAVJJXDIr7XUuA4RfUfjlNgOoCxl3v0yaFDnAhq9JKB1RiUB8P8q
        0KWAZc6067Na+n7DLgRv5nkSXOYa
X-Google-Smtp-Source: APXvYqyH/gULMxSvQDocHxBzyQbss4QJxR64MbjN7ugxwVm/+ErtXtDAkezyKKjeSn9al7UStXQL5w==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr14497472wrv.364.1575061916849;
        Fri, 29 Nov 2019 13:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm7771603wrw.12.2019.11.29.13.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:56 -0800 (PST)
Message-Id: <e4907112e4b7e053b1436b8bcb8337deb5309463.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:48 +0000
Subject: [PATCH v2 8/9] built-in add -i: re-implement the `diff` command
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

It is not only laziness that we simply spawn `git diff -p --cached`
here: this command needs to use the pager, and the pager needs to exit
when the diff is done. Currently we do not have any way to make that
happen if we run the diff in-process. So let's just spawn.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index cba9688bb5..4d7d44a917 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -931,6 +931,47 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int run_diff(struct add_i_state *s, const struct pathspec *ps,
+		    struct prefix_item_list *files,
+		    struct list_and_choose_options *opts)
+{
+	int res = 0;
+	ssize_t count, i;
+
+	struct object_id oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
+					     NULL);
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps, NULL, NULL) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		putchar('\n');
+		return 0;
+	}
+
+	opts->prompt = N_("Review diff");
+	opts->flags = IMMEDIATE;
+	count = list_and_choose(s, files, opts);
+	opts->flags = 0;
+	if (count >= 0) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
+				 oid_to_hex(!is_initial ? &oid :
+					    s->r->hash_algo->empty_tree),
+				 "--", NULL);
+		for (i = 0; i < files->items.nr; i++)
+			if (files->selected[i])
+				argv_array_push(&args,
+						files->items.items[i].string);
+		res = run_command_v_opt(args.argv, 0);
+		argv_array_clear(&args);
+	}
+
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -1029,6 +1070,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "revert", run_revert },
 		{ "add untracked", run_add_untracked },
 		{ "patch", run_patch },
+		{ "diff", run_diff },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget


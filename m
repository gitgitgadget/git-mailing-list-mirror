Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECFC3F6B0
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiHSQdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353014AbiHSQaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEFA11B4E5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb36so9603445ejc.10
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bJo13vnk+tSaOn4gZMMv1jIS+cdw8N2qcc0P1jPH7rc=;
        b=EbnwnazJ/WGoGzmj+84xBMkmOi/ENV3ifZIRjfWH3Fn0lk0ccimiTQBWMQv+WjiieO
         Ccgm3P4di1BBplL0q+1S/zD6IGIDQ/XpU0z31attj8QMa28plQXEuyS1PPZXZJzASJri
         nUQMcrQJm0uOidSUAdk8a7jVnPU9rND438XklBFkEGMDwZm5oML+SMCkA/Ka2MSP4qWU
         R9XFJ8kRDfLRGoKRNwDJJiY6zMqZtSgYZwUBk+B+HSiyyRyU4aK4WQu9G2iCosU2OE3R
         1amf8TVtz6K14Ev5crb5PSMO68nbQoMNLNvJghXe4FTjNzoy3kHugYzRzCX9sUgZA8rB
         6DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bJo13vnk+tSaOn4gZMMv1jIS+cdw8N2qcc0P1jPH7rc=;
        b=kVuRjZZF+NTTtXHzytel5iiaqL4a5lZ3nyZVXnE6+3F3yUrNodMQl5rddTcw7D0kOK
         UwaUxkwwfHIDKj8MQfCM6q/SYHKm2uq/fC8g37tkfiV+jCu/F+7yYOMvxwXvxJDbcsBR
         Rm6wan4xof5Q+PyDnLuw/TwWyTURncRamU6wkLioUGcGnwxs0Uy5tFYy15J0dvDjCNI1
         +qU+M2obAPeMWiufGYRpaFgR/Zny67cF3zEUP1c4ss+s+/LCKJPLrB9E4oUkkQLnd1Dp
         H6EdtKlRRC1MjMnqtgb/OLUTRyukQNi/I+YMp0zsZaaRkXDxhWksABmUU0u/pfP001iW
         Ybcg==
X-Gm-Message-State: ACgBeo0QC2F+KuW/DPp8/oHnhmNf/7YceQhemEL5T8w7tJbUHxjtCYZT
        Lv4L+2ZPFynY6qXUVPGqLqRxvCFkU3U=
X-Google-Smtp-Source: AA6agR7gz902iHXqM3qn9N1QUJ2tVT0r+wRRhMMj717Wr93DQZuQUYiKZ9PifHaJXHSna0EfGzI0mQ==
X-Received: by 2002:a17:907:7f0b:b0:731:b81a:1912 with SMTP id qf11-20020a1709077f0b00b00731b81a1912mr5332559ejc.8.1660925073923;
        Fri, 19 Aug 2022 09:04:33 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id dv9-20020a170906b80900b0072fb3704e49sm2499027ejb.46.2022.08.19.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/20] git.c: update NO_PARSEOPT markings
Date:   Fri, 19 Aug 2022 18:03:52 +0200
Message-Id: <20220819160411.1791200-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Bash completion script can complete --options for commands using
parse-options even when that command doesn't have a dedicated
completion function, but to do so the completion script must know
which commands use parse-options and which don't.  Therefore, commands
not using parse-options are marked in 'git.c's command list with the
NO_PARSEOPT flag.

Update this list, and remove this flag from the commands that by now
use parse-options.

After this change we can TAB complete --options of the plumbing
commands 'commit-tree', 'mailinfo' and 'mktag'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 git.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index e5d62fa5a9..09c126c33d 100644
--- a/git.c
+++ b/git.c
@@ -489,14 +489,14 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
-	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
+	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
@@ -514,7 +514,7 @@ static struct cmd_struct commands[] = {
 	{ "column", cmd_column, RUN_SETUP_GENTLY },
 	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
-	{ "commit-tree", cmd_commit_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
@@ -553,7 +553,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
 	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -566,7 +566,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
-	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
+	{ "mktag", cmd_mktag, RUN_SETUP },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
-- 
2.37.2.817.g36f84ce71d


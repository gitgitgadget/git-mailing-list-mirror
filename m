Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1FCC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2218622472
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLEUUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEUUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 15:20:16 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F7C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 12:19:35 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x16so10583459oic.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjlS/WfLxU19WpWwysXMIdo3oDmJbEjZ9ZGadd5QWlk=;
        b=BeOim27pllql/tg2HRpCNEBL/WvzLCaOzGfI5j+Ak+Emupti3V89niSH7ruA99DvQx
         ncRtA7P7jW348RzqxsLQXd5nWkXE5WfhFqFNxTg5CgPxYm8EjKuJKMq5zIhIbsuhVxbY
         JEYUCPf0xgxd1+1Q+u71Tif5PMebOD5I2/ri+5Fxwx1tLQLb5rZTcMlpfpFyNO7IlUXv
         TW4NoPQ1BQwv0gDfMAK1YLJegGhOCx7xJDytOCceT0YsL5RA6Xkf55JR5/ncmCd7Yhx/
         O4pLO5+5zwudrsHq5KBEBQkaKIuRBIBl/GaiscbTFIW42qZV9lMAiXtLXaGG8sbIrAS8
         3vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjlS/WfLxU19WpWwysXMIdo3oDmJbEjZ9ZGadd5QWlk=;
        b=QFljsobPNFj36gtRn/5f+Ya+StRqgzk5AeD/UIFqKBRmAyH4RbKs6AnNJy3OHxbPw0
         KnC/bz2L36Y/JHgnl+eB86SViAqIjcl1wRyZge8LGbJVl1K+b3DhnyFTH5lkz0IetD5w
         VTdHGW8xO3vtb8sgq5etfYnCj0TX8RjuD0K5Wwl3LdwkpTDWuMllAjfuhROlxIFCSJF+
         x6DKd1PqIyiUo3UB1SZE6RPZUq85IjInNWaxOiH74fAmnjH3zPDyAm2FgDUKBNlE7EAt
         +ac2KLmtyOLy9MgS+3Vgxdcj6ZxQMEexS26yjkZXhKkJCGu9i/5rjuP+rHJqm1JT4vkK
         Kqpw==
X-Gm-Message-State: AOAM5316BPNW4tKVTxwWLFGzKEwGafvpY0l9GXrkFNB8gCJikRCuaXtx
        7mxlGfnlmjDMHx6ZkKpBafGkalYdRITAeg==
X-Google-Smtp-Source: ABdhPJxetCbJrYR/P8DmwI00q8unqHbWUF0LlEzF6U8IVyhcJjvNQYRsNuwarLcbyx76jYKLIWRzZA==
X-Received: by 2002:aca:1a18:: with SMTP id a24mr7460155oia.29.1607199574832;
        Sat, 05 Dec 2020 12:19:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z63sm289107otb.20.2020.12.05.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 12:19:34 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] pull: add proper error with --ff-only
Date:   Sat,  5 Dec 2020 14:19:32 -0600
Message-Id: <20201205201933.1560133-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAMP44s3xqjoJm5AL6dLcS6R-RFGGOdQ39W+ZY3_PWL+WMeCxjw@mail.gmail.com>
References: <CAMP44s3xqjoJm5AL6dLcS6R-RFGGOdQ39W+ZY3_PWL+WMeCxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current error is not user-friendly:

  fatal: not possible to fast-forward, aborting.

We want something that actually explains what is going on:

  The pull was not fast-forward, please either merge or rebase.

The user can get rid of the warning by doing either --merge or
--rebase.

Except: doing "git pull --merge" is not actually enough; we would return
to the previous behavior: "fatal: not possible to fast-forward,
aborting". In order to do the right thing we will have to change the
semantics of --ff-only.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 33 ++++++++++++++++++--------------
 t/t5520-pull.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e0157d013f..44ec6e7216 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1008,20 +1008,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --merge\".\n"
-			"Read \"git pull --help\" for more information."
-			));
+	if (!can_ff && !opt_rebase) {
+		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
+			die(_("The pull was not fast-forward, please either merge or rebase."));
+
+		if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
+			advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+				"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
+				"You can squelch this message by running one of the following commands:\n"
+				"\n"
+				"  git config pull.rebase false  # merge (the default strategy)\n"
+				"  git config pull.rebase true   # rebase\n"
+				"  git config pull.ff only       # fast-forward only\n"
+				"\n"
+				"You can replace \"git config\" with \"git config --global\" to set a default\n"
+				"preference for all repositories.\n"
+				"If unsure, run \"git pull --merge\".\n"
+				"Read \"git pull --help\" for more information."
+				));
+		}
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..067780e658 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,4 +819,54 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
+setup_other () {
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other $1 &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master
+}
+
+setup_ff () {
+	setup_other master
+}
+
+setup_non_ff () {
+	setup_other master^
+}
+
+test_expect_success 'fast-forward (ff-only)' '
+	test_config pull.ff only &&
+	setup_ff &&
+	git pull
+'
+
+test_expect_success 'non-fast-forward (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	test_must_fail git pull
+'
+
+test_expect_failure 'non-fast-forward with merge (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	git pull --merge
+'
+
+test_expect_success 'non-fast-forward with rebase (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	git pull --rebase
+'
+
+test_expect_success 'non-fast-forward error message (ff-only)' '
+	test_config pull.ff only &&
+	setup_non_ff &&
+	test_must_fail git pull 2> error &&
+	cat error &&
+	grep -q "The pull was not fast-forward" error
+'
+
 test_done
-- 
2.29.2


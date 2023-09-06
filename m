Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81717EE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbjIFPXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbjIFPXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E51732
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:23:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so58166861fa.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013780; x=1694618580; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD9GETpmG95sn5RmN4rwg0MjurjAfOhKYJbh8sypqNI=;
        b=ZkLqchZCqOrWbppYSavQb8WqzcGYM2Oz9ESoxd91sjSA9gDZhy4kls2dCqnEAmrtbV
         JZlCABenhpf4merwWoZ9x7t+L4zicVPMavr0m7rica9lGYBwg3s9RNjDsoRdBXc4rBp0
         YE0MYyQoWFZLnhMyW1QpLt8RvwxYVDLvKTUJllTxbtUjgOIqsUUrmK2m6sE9q+gv4Mx3
         WoKG1LNlSSwMckt/bQa0iT05ot0II4X8KQSYEym9Bp8ceBidkIf40JEpMVpTdkr+HmPo
         RGXJScwJBM5v089ryon6VeFbydol1LDRJRxzrKrSLSB+SDxv5Yu8BvXb2mXcSRFuv4o4
         2MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013780; x=1694618580;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD9GETpmG95sn5RmN4rwg0MjurjAfOhKYJbh8sypqNI=;
        b=CxwHafCfZfr79hbZdYrnkfYu53AUkYfxbYYo3otUbUOqLX3UGi49bLOCI+fDt8PXGT
         TnJTiWD4YU7Hl20OhAwm86fw1iVwtndLW5jl8y+6+uAPLzifuOXH8VnwRzrIPzQMIkpS
         xzRMT++bAUz7WIbuPHcVXdwEPnCAyGGzHcUpzIxznoDHN/2r3mtDuwzkL2zeEvxi1XbP
         4DxrI6o/8dc9elS6khxyPdsnvDWUOiAdKdRupR4OJgOjEM/2LYMC8yWoUKvF17PvqYr0
         UURKzNEsL41E5ODV28uGvTvh3t8CiWKWNw3USSWmJNtXqBrFTMYSpOFauWauwCyTF6ZK
         2QiQ==
X-Gm-Message-State: AOJu0YybKhTKe57JUYOVdE1gkPycph4EDwZud19Q/FP8Wac4ODIRZXrj
        X7AsLseNQ5KvBWDwNN69OIi5A8dYaU0=
X-Google-Smtp-Source: AGHT+IEwdJSFevdUBH2MD3tTbjOOKpaA8XjEwoLIRAD53CQucYKZdYeKwbmmVwhGhwsOxOLjG94XKA==
X-Received: by 2002:a2e:9c9a:0:b0:2bc:dcc2:b186 with SMTP id x26-20020a2e9c9a000000b002bcdcc2b186mr2381647lji.36.1694013779610;
        Wed, 06 Sep 2023 08:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c234a00b003fc06169ab3sm23168749wmq.20.2023.09.06.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:58 -0700 (PDT)
Message-ID: <0ca5fccca17af22de6da846d82e960ebe1aa87b1.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:50 +0000
Subject: [PATCH v4 6/7] rebase --continue: refuse to commit after failed
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a commit cannot be picked because it would overwrite an untracked
file then "git rebase --continue" should refuse to commit any staged
changes as the commit was not picked. This is implemented by refusing to
commit if the message file is missing. The message file is chosen for
this check because it is only written when "git rebase" stops for the
user to resolve merge conflicts.

Existing commands that refuse to commit staged changes when continuing
such as a failed "exec" rely on checking for the absence of the author
script in run_git_commit(). This prevents the staged changes from being
committed but prints

    error: could not open '.git/rebase-merge/author-script' for
    reading

before the message about not being able to commit. This is confusing to
users and so checking for the message file instead improves the user
experience. The existing test for refusing to commit after a failed exec
is updated to check that we do not print the error message about a
missing author script anymore.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   |  5 +++++
 t/t3404-rebase-interactive.sh | 18 +++++++++++++++++-
 t/t3430-rebase-merges.sh      |  4 ++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 76932ab7b23..38b0f213157 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4980,6 +4980,11 @@ static int commit_staged_changes(struct repository *r,
 
 	is_clean = !has_uncommitted_changes(r, 0);
 
+	if (!is_clean && !file_exists(rebase_path_message())) {
+		const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
+		return error(_(staged_changes_advice), gpg_opt, gpg_opt);
+	}
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
 		struct object_id head, to_amend;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6d3788c588b..a8ad398956a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -604,7 +604,8 @@ test_expect_success 'clean error after failed "exec"' '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
-	test_i18ngrep "you have staged changes in your working tree" error
+	test_i18ngrep "you have staged changes in your working tree" error &&
+	test_i18ngrep ! "could not open.*for reading" error
 '
 
 test_expect_success 'rebase a detached HEAD' '
@@ -1290,6 +1291,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/patch &&
+	echo changed >file1 &&
+	git add file1 &&
+	test_must_fail git rebase --continue 2>err &&
+	grep "error: you have staged changes in your working tree" err &&
+	git reset --hard HEAD &&
 	git rebase --continue &&
 	test_cmp_rev HEAD I
 '
@@ -1310,6 +1316,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/patch &&
+	echo changed >file1 &&
+	git add file1 &&
+	test_must_fail git rebase --continue 2>err &&
+	grep "error: you have staged changes in your working tree" err &&
+	git reset --hard HEAD &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
 	git reset --hard original-branch2
@@ -1330,6 +1341,11 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/patch &&
+	echo changed >file1 &&
+	git add file1 &&
+	test_must_fail git rebase --continue 2>err &&
+	grep "error: you have staged changes in your working tree" err &&
+	git reset --hard HEAD &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4938ebb1c17..804ff819782 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -169,6 +169,10 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	grep "^merge -C .* G$" .git/rebase-merge/done &&
 	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_missing .git/rebase-merge/patch &&
+	echo changed >file1 &&
+	git add file1 &&
+	test_must_fail git rebase --continue 2>err &&
+	grep "error: you have staged changes in your working tree" err &&
 
 	: fail because of merge conflict &&
 	git reset --hard conflicting-G &&
-- 
gitgitgadget


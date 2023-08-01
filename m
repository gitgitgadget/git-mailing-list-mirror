Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8085C001E0
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHAPX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjHAPXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF62113
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso39917965e9.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903419; x=1691508219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji5cKYBBBlvNVH0DymsD8L4ogLnGMLVhtR09gQ/Tku4=;
        b=m//pKeGSljnojHAnmLyA2rk9Un/E5zCOTENm2R7zrMF8SQ4MrJP3n07mG5/eLcYC5j
         t3J4KOVMllSp7eXIGnNCmK3FCrxWw7P5d4Lhl5B/CnJVrJZe5ppqRhsNbVfExvjOH5xq
         HvwfG4j+6xUbbSoV3p9+iElbBVn/31zhxAQPQ79qXmr6q4pYKTjJCAjkxssoPpekCM8/
         pMdYS4AvUldM2SzN3vFi9Zx/1I3Dzq8PHB57X9zNbsYh4O1VogKd0JkN7dmAhF5ddvst
         hu70akpnlYNN4qEj3SIT7NHxhgglJ5nPL6Zwm4zcJzRh49E1LI3S0dt9W7Q3J1W3+g0l
         CUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903419; x=1691508219;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji5cKYBBBlvNVH0DymsD8L4ogLnGMLVhtR09gQ/Tku4=;
        b=knWh6ijwcFhp011mZ8KR/DQ4o0SeREtVfBKKbak77RvWHZ1S8ZUUIQ5eqftWOLqYJx
         iSMlCaeweQAjx+mU1iVTkI+WrNBBHtXSk9oGmLd8M4vG9sYaSYNsZ4ytqNjiTQrWdCTn
         EUoyw+7lei6N5XBFZeseeXZmNBmckU+r7pjb9d879PkLXcfPDMDMRJW9vuAX27q+kP1j
         G3xuGS8JD9wDTZGaHgftKpTep9++waapqcwJUxuhSJ9PW5Q4jx+YAe/l5uDfnxSirXfe
         me+AvdKtPhKnMdNKw3ud/C4f9B3FXlF2psh87aFPV5t89KKw/wjVM+RrurfL7CR2/ndU
         go/w==
X-Gm-Message-State: ABy/qLYY5qCm9gqBQMMItrKN5zhS8rL2AP3iLTJ3Kps5jpcvdv/ttYrE
        gwSe2yKKgJX9dA8aw+t3W5t9KZFABvE=
X-Google-Smtp-Source: APBJJlGw/K5wSVlgxmx0uemAlp+xaxR6/9JcOeR7oGdFJULRyIcO/rdpJOVYxkgy0IRb6UjdMW6Hww==
X-Received: by 2002:a05:600c:4f47:b0:3fa:8c8b:716 with SMTP id m7-20020a05600c4f4700b003fa8c8b0716mr2668918wmq.1.1690903419284;
        Tue, 01 Aug 2023 08:23:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a7bc3d4000000b003fe2a40d287sm1864088wmj.1.2023.08.01.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:38 -0700 (PDT)
Message-ID: <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:31 +0000
Subject: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
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
index e25abfd2fb4..a90b015e79c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4977,6 +4977,11 @@ static int commit_staged_changes(struct repository *r,
 
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


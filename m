Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1188C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjDUO6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjDUO6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75F9EED
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so13293855e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089079; x=1684681079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2MevsFjzCo/FdzgO3J99SpPyXyqksiZIEkZP51T2rs=;
        b=jEzm7ngR+2GSBIRYB6558eDnaIp5p3ZIkLybtdLrHXtnR1au7qxWCGWKbbjloiXTQk
         yP0ksD4aGl1XXpUqq11zK5LV9ROWU3PvRmvERVvU5Mv67VBSTfR2vpZpi4DMo377/KS3
         dK0OMyDNyXuFfMmqYZlh6iwEflw9bMueF4Y8tc90BxEftZA1KgaiSaHV2e3W4ZPv9NMc
         QmWoOQnOn6Oa6JppDD/E1YBYrkgW+eS/njZjsgI9k2I33q6uAsL0lLf6suFgagdBKCWd
         6oHGTIXIrTo8wOmmIQDKYYxY0VrOKSffQsi8GOR0QqX6gpsY0tbFxcS6CqMugVUiMQ4U
         2fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089079; x=1684681079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2MevsFjzCo/FdzgO3J99SpPyXyqksiZIEkZP51T2rs=;
        b=DEpFnrKfEPH3N4ZU7cPeipJQqSEmfRV8566n5Mq+Z1hDXZ3JSnP0z9/u0+SsXIn1tS
         VmBC2Ypw+iQy3Bh/bl1gfGp9rjPbPRTbYPSRfOP+EYwlamIpulexr/cBE9rYP+AuItu4
         7hC5YINAUyxi4u+8WncBKzsoy/Judxivopgl/DuDj5TcHwNyyOGu/a+oLiklMG5LvD6W
         8okhUQnIRdZIoP4lVXSFfm7wrdSrxQbH/282M/dA8b28mlQGHssT8ONtr7DLyw+SHSjb
         Q0Qdm1KJz/Ez+90K6ZoKkHKXBjfcpgNNcaFImqVdEGSzGhNdT4ikpTbg9UDBpbLx2iYd
         0hnA==
X-Gm-Message-State: AAQBX9c01e6ghOvnyZ5JsNXFFRBcC0BH71bWIp8IMY2avPHBRE1zMJz3
        eothJVrGWRMdj6RdvMENjeqKHHInmLg=
X-Google-Smtp-Source: AKy350YRz9o54B6yIU/JPRuxiupE7Hksq3RmfSkccKtsLEkQMN2Km9shjhY0SGX+IjpDruIyVRiowg==
X-Received: by 2002:a1c:ed01:0:b0:3f1:6f57:6fd1 with SMTP id l1-20020a1ced01000000b003f16f576fd1mr2229352wmh.9.1682089079595;
        Fri, 21 Apr 2023 07:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003f17b96793dsm8351575wmk.37.2023.04.21.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:59 -0700 (PDT)
Message-Id: <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:52 +0000
Subject: [PATCH v2 4/6] rebase --continue: refuse to commit after failed
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
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a commit cannot be picked because it would overwrite an untracked
file then "git rebase --continue" should refuse to commit any staged
changes as the commit was not picked. Do this by using the existing
check for a missing author script in run_git_commit() which prevents
"rebase --continue" from committing staged changes after failed exec
commands.

When fast-forwarding it is not necessary to write the author script as
we're reusing an existing commit, not creating a new one. If a
fast-forwarded commit is modified by an "edit" or "reword" command then
the modification is committed with "git commit --amend" which reuses the
author of the commit being amended so the author script is not needed.
baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when fast-forwarding,
2021-08-20) changed run_git_commit() to allow a missing author script
when rewording a commit. This changes extends that to allow a missing
author script whenever the commit is being amended.

If we're not fast-forwarding then we must remove the author script if
the pick fails.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 10 +++++-----
 t/t3404-rebase-interactive.sh |  8 ++++++++
 t/t3430-rebase-merges.sh      |  4 +++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2d463818dd1..55bf0a72c3a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1055,7 +1055,7 @@ static int run_git_commit(const char *defmsg,
 
 	if (is_rebase_i(opts) &&
 	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
-	     !(!defmsg && (flags & AMEND_MSG))) &&
+	     !(flags & AMEND_MSG)) &&
 	    read_env_script(&cmd.env)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
@@ -2216,8 +2216,6 @@ static int do_pick_commit(struct repository *r,
 	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && oideq(&parent->object.oid, &head)) ||
 	     (!parent && unborn))) {
-		if (is_rebase_i(opts))
-			write_author_script(msg.message);
 		res = fast_forward_to(r, &commit->object.oid, &head, unborn,
 			opts);
 		if (res || command != TODO_REWORD)
@@ -2324,9 +2322,10 @@ static int do_pick_commit(struct repository *r,
 		 command == TODO_REVERT) {
 		res = do_recursive_merge(r, base, next, base_label, next_label,
 					 &head, &msgbuf, opts);
-		if (res < 0)
+		if (res < 0) {
+			unlink(rebase_path_author_script());
 			goto leave;
-
+		}
 		res |= write_message(msgbuf.buf, msgbuf.len,
 				     git_path_merge_msg(r), 0);
 	} else {
@@ -4141,6 +4140,7 @@ static int do_merge(struct repository *r,
 	if (ret < 0) {
 		error(_("could not even attempt to merge '%.*s'"),
 		      merge_arg_len, arg);
+		unlink(rebase_path_author_script());
 		goto leave_merge;
 	}
 	/*
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e2..c1fe55dc2c1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1288,6 +1288,12 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	test_must_fail git rebase --continue &&
 	test_cmp_rev HEAD F &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/author-script &&
+	echo changed >file1 &&
+	git add file1 &&
+	test_must_fail git rebase --continue 2>err &&
+	grep "error: you have staged changes in your working tree" err &&
+	git reset --hard HEAD &&
 	git rebase --continue &&
 	test_cmp_rev HEAD I
 '
@@ -1306,6 +1312,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	test_must_fail git rebase --continue &&
 	test_cmp_rev HEAD F &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/author-script &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
 	git reset --hard original-branch2
@@ -1324,6 +1331,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	test_must_fail git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/author-script &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f03599c63b9..360ec787ffd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -168,13 +168,15 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	grep "^merge -C .* G$" .git/rebase-merge/done &&
 	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/author-script &&
 
 	: fail because of merge conflict &&
 	rm G.t .git/rebase-merge/patch &&
 	git reset --hard conflicting-G &&
 	test_must_fail git rebase --continue &&
 	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
-	test_path_is_file .git/rebase-merge/patch
+	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_file .git/rebase-merge/author-script
 '
 
 test_expect_success 'failed `merge <branch>` does not crash' '
-- 
gitgitgadget


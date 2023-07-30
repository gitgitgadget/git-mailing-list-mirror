Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE8C0015E
	for <git@archiver.kernel.org>; Sun, 30 Jul 2023 01:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjG3BHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3BHt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 21:07:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BF2701
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 18:07:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe110de46dso14823375e9.1
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690679264; x=1691284064;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkgVV2QicVY9UNlICryI/fG2fx8x4rXwev43pi53b8Y=;
        b=qeifF6mdEn355xaNxbBv4jwu87uLKG7ABk/vF/XeJzm3j4ey5jvaXYhwqCvKHL5T5C
         F/k4QTqhS8GBVhin/z5IGzctHdqijrtgjTJwy2UJ+stmkLh7IFNEwapvHw0dAzaxB5wo
         JOHbEDed9dMWprDVW6b3hcyyZYbCrKUIrNDFUQzBYysJhUUWl2t1jzTJTFz9TrqgsFn5
         Md2xQyjXjkW/Lckp/tNiiSzIj0H2IAg0750KZQdeH1+B3M2yQzJSOVbm37xQrOw9mXDv
         3sDHqdDFiR8qdMMEiWEFL2w0ptkZJZhG7oVx6FQLbOJQYEf4LOs+k2tb5b9ykqCO+Bb0
         8MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690679264; x=1691284064;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkgVV2QicVY9UNlICryI/fG2fx8x4rXwev43pi53b8Y=;
        b=fOtIiWYWMSGZ4Cn/zVVg1egCukbdOpzJYGcoAVOGPuSuZR//KJAa9NajsZv+eLgZwm
         06kzxu5Ga3mG6HaIaNAoHMJOS4Y0BbYotrW5auNeGSoxrJCD2jEEbvpxQOicXxa1UE80
         iKBN4Tl9dgogM8MA+wutqe5CJbYcTq8+OZJseF95ceSnEitE4OB62l/Qdb1gMxgZPX8/
         G70cC5bduRykPH1mGLu6f0oWDhzfBSflH6EU4eVY+/dd6I8z6Ej0fJp6IcXXh5t7Ad2l
         9DRie6F4pZPvnoWg/Xgap59B7zYWJ3FcyytIHpqDwLV7OxIRYz9YDlhOrOTmV9Ah9F14
         47NQ==
X-Gm-Message-State: ABy/qLY4Ve/mpflTP2kYgfyBzNVVUwDEXpnIM8NQN81aSQ/vhXOYmhKU
        II3UOi+sS/gcpaA/ySqL3g6PKV5FOVQ=
X-Google-Smtp-Source: APBJJlGBCnbGVG3ZH0qTYs+c4/kQkk0Ji3cri+X8x2eBMHR8R+nTF+dKKO6QLPiWXiEcQY70rwF0MQ==
X-Received: by 2002:adf:fa86:0:b0:315:8f4f:81b1 with SMTP id h6-20020adffa86000000b003158f4f81b1mr4291938wrr.50.1690679264490;
        Sat, 29 Jul 2023 18:07:44 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b00314172ba213sm8688356wrm.108.2023.07.29.18.07.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 18:07:43 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] status: fix branch shown when not only bisecting
Message-ID: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
Date:   Sun, 30 Jul 2023 03:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 83c750acde (wt-status.*: better advice for git status added,
2012-06-05), git-status received new informative messages to describe
the ongoing work in a worktree.

Multiple operations can be performed concurrently in a worktree.  For
example, during a rebase, the user can also perform a cherry-pick.  In
that situation, git-status only shows information about one of them,
prioritizing which one, in order: merge, am, rebase, cherry-pick.

However, when a bisect is also in progress, git-status includes, in
addition to the description of any other ongoing operation, the
description of the bisect.  This means that, in this case, it shows
description for two ongoing operations.

In 0722c805d6 (status: show the branch name if possible in in-progress
info, 2013-02-03), the messages introduced in 83c750acde were improved
to show, if possible, the branch in which the described operation was
initiated.

Unfortunately, git-status only records one branch related to one
operation.  However, in the situation described above, when a bisect is
combined with another operation, it is necessary to record two branches,
which, it is important to note, may be different.

Therefore, when that happens, we show incorrect information:

   $ git checkout -b bisect-branch
   $ git bisect start
   $ git checkout -b rebase-branch
   $ GIT_SEQUENCE_EDITOR='echo break >>' git rebase -i HEAD~
   $ git status
   interactive rebase in progress ...
   ...

   You are currently editing a commit while rebasing branch 'bisect-branch' on '...'.

   You are currently bisecting, started from branch 'bisect-branch'.

   ...

Days after 0722c805d6, this bisect circumstance hit us again; a leak was
introduced in 8b87cfd000 (wt-status: move strbuf into
read_and_strip_branch(), 2013-03-16).

Let's fix git-status to display accurate information and also fix the
leak, considering the branch where the bisect was started separately
from the branch related to other ongoing operations.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c               |  4 ++--
 ref-filter.c           |  2 +-
 t/t7512-status-help.sh | 30 ++++++++++++++++++++++++++++++
 worktree.c             |  4 ++--
 wt-status.c            |  7 ++++---
 wt-status.h            |  1 +
 6 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index cdf70b0ef0..81c03b81b7 100644
--- a/branch.c
+++ b/branch.c
@@ -420,9 +420,9 @@ static void prepare_checked_out_branches(void)
 		wt_status_state_free_buffers(&state);
 
 		if (wt_status_check_bisect(wt, &state) &&
-		    state.branch) {
+		    state.bisecting_from) {
 			struct strbuf ref = STRBUF_INIT;
-			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
 			old = strmap_put(&current_checked_out_branches,
 					 ref.buf,
 					 xstrdup(wt->path));
diff --git a/ref-filter.c b/ref-filter.c
index f0a8e55270..526eebffad 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1894,7 +1894,7 @@ char *get_head_description(void)
 				    state.detached_from);
 	} else if (state.bisect_in_progress)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
+			    state.bisecting_from);
 	else if (state.detached_from) {
 		if (state.detached_at)
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index c2ab8a444a..bbb8e9b8b0 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -692,6 +692,36 @@ EOF
 '
 
 
+test_expect_success 'status when bisecting while rebasing' '
+	git reset --hard main &&
+	FAKE_LINES="exec_exit_15" &&
+	export FAKE_LINES &&
+	test_when_finished "git rebase --abort" &&
+	ONTO=$(git rev-parse --short HEAD^) &&
+	test_must_fail git rebase -i HEAD^ &&
+	git checkout -b bisect_while_rebasing &&
+	test_when_finished "git bisect reset" &&
+	git bisect start &&
+	TGT=$(git rev-parse --short two_bisect) &&
+	cat >expected <<EOF &&
+On branch bisect_while_rebasing
+Last command done (1 command done):
+   exec exit 15
+No commands remaining.
+You are currently editing a commit while rebasing branch '\''bisect'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+You are currently bisecting, started from branch '\''bisect_while_rebasing'\''.
+  (use "git bisect reset" to get back to the original branch)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
 test_expect_success 'status when rebase --apply conflicts with statushints disabled' '
 	git reset --hard main &&
 	git checkout -b statushints_disabled &&
diff --git a/worktree.c b/worktree.c
index b8cf29e6a1..360e2b1866 100644
--- a/worktree.c
+++ b/worktree.c
@@ -395,9 +395,9 @@ int is_worktree_being_bisected(const struct worktree *wt,
 
 	memset(&state, 0, sizeof(state));
 	found_bisect = wt_status_check_bisect(wt, &state) &&
-		       state.branch &&
+		       state.bisecting_from &&
 		       skip_prefix(target, "refs/heads/", &target) &&
-		       !strcmp(state.branch, target);
+		       !strcmp(state.bisecting_from, target);
 	wt_status_state_free_buffers(&state);
 	return found_bisect;
 }
diff --git a/wt-status.c b/wt-status.c
index 5b1378965c..0eb2af63b6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -861,6 +861,7 @@ void wt_status_state_free_buffers(struct wt_status_state *state)
 	FREE_AND_NULL(state->branch);
 	FREE_AND_NULL(state->onto);
 	FREE_AND_NULL(state->detached_from);
+	FREE_AND_NULL(state->bisecting_from);
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
@@ -1569,10 +1570,10 @@ static void show_revert_in_progress(struct wt_status *s,
 static void show_bisect_in_progress(struct wt_status *s,
 				    const char *color)
 {
-	if (s->state.branch)
+	if (s->state.bisecting_from)
 		status_printf_ln(s, color,
 				 _("You are currently bisecting, started from branch '%s'."),
-				 s->state.branch);
+				 s->state.bisecting_from);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently bisecting."));
@@ -1733,7 +1734,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 
 	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
-		state->branch = get_branch(wt, "BISECT_START");
+		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
 	}
 	return 0;
diff --git a/wt-status.h b/wt-status.h
index ab9cc9d8f0..819dcad723 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -94,6 +94,7 @@ struct wt_status_state {
 	char *branch;
 	char *onto;
 	char *detached_from;
+	char *bisecting_from;
 	struct object_id detached_oid;
 	struct object_id revert_head_oid;
 	struct object_id cherry_pick_head_oid;
-- 
2.40.1

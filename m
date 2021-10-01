Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A4C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A87A61A50
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353350AbhJAKHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353310AbhJAKG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF96C06177E
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so14486783wrd.13
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eXgGy+LpkqhTOu6wddtYEhn81YJtBT0sMRG81TaMZyA=;
        b=fC6BGYGolugqoNnWtefpqqKgGZ9s0UeVhKGMTlKmF0BIVEzacvfa8fgP21UP6KZXX1
         Q8edHXjJGRRDw4TAn7A55ZVAI4k973G6QprJB4nkUckqXtc4MgpbPKW/vYc1+Q6w24NB
         7ckVCOTm5BwM/viqtMz+EsBj/XPKBtgqDspdQ0ANUs/+oq/5A4yWRJIZT3hnaTX1V7Nd
         JOF8EuWM1fYDzmh2wr+Sp4vN3nrVW3vCJlGK7jBgK5bKP0ttbD0aEoj0ZE9v67bPe050
         Q+e5x1k/b7Ef0uVphTMDBOvGhFzbvloUWIcSBEc4hzOTnMY6tN8tDVb8Ji9F6RNCZytu
         pFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eXgGy+LpkqhTOu6wddtYEhn81YJtBT0sMRG81TaMZyA=;
        b=hSAbfW2053Ij3eQ5mL0cCkhPbrtAy1OGclDgiLttR9QOzyTK2rVjad67jE3QLRoRiw
         MQmhTmNxzu/350vfpZA/uooL11Rxv6H49hgddRHszbx/DXc+JIKE3q/LyeM5NxmS8L71
         Gb5HRuh/iMzhLUdd0NVVZSC1roDr174FgFps+hGPrkW1ka/PqQchQwxvFuwFt9GhZRZX
         KcyiAxXNb3bMLWh8BNTOb41rHSF3UWnaTHUWOV0M7FaOD+bFzwUaVa/1vxHT3fWUJNFS
         i/Mz1VBoMS/JUhNxWVsw68ivZFHdeL1xR+TXwxGu2q/9g9LTDXAnDQd/2hsyqwAgwNsA
         yiRg==
X-Gm-Message-State: AOAM533Qil2paaLPBm8KHqjIqSrqYbzvbdPa/znuDc2D/7pwWtGduGR+
        QXkeqr54R/bpCdwVpKWbu6U9hbJdjo0=
X-Google-Smtp-Source: ABdhPJwg4iHZITzS9kbt/jayzGtmZgUQGPeRCZoNFhJG+WzZmHrnWG5SYH7F+UiF3PwC4P9NIh9tug==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr11713720wro.25.1633082710413;
        Fri, 01 Oct 2021 03:05:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm5282049wme.38.2021.10.01.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:10 -0700 (PDT)
Message-Id: <e8884efcc83960fc0ea5d5aee72bb9839b4be397.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:05:01 +0000
Subject: [PATCH 10/11] rebase --apply: set ORIG_HEAD correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of a rebase ORIG_HEAD is updated to tip of the branch
being rebased. Unfortunately reset_head() always uses the current
value of HEAD for this which is incorrect if the rebase is started
with 'git rebase <upstream> <branch>' as in that case ORIG_HEAD should
be updated to <branch>. This only affects the "apply" backend as the
"merge" backend does not yet use reset_head() for the initial
checkout. Fix this by passing in orig_head when calling reset_head()
and add some regression tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c           |  1 +
 reset.c                    |  4 +++-
 reset.h                    |  2 ++
 t/t3418-rebase-continue.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c40a8b843f4..c36a8a10e9b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2074,6 +2074,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
+	ropts.orig_head = &options.orig_head,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/reset.c b/reset.c
index 2c32600234d..82bcf2dcb8b 100644
--- a/reset.c
+++ b/reset.c
@@ -14,6 +14,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
 	const char *reflog_head = opts->head_msg;
@@ -43,7 +44,8 @@ static int update_refs(const struct reset_head_opts *opts,
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+			update_ref(reflog_orig_head, "ORIG_HEAD",
+				   orig_head ? orig_head : orig,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
 			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
diff --git a/reset.h b/reset.h
index c0f4e99a3be..91a868c5ba8 100644
--- a/reset.h
+++ b/reset.h
@@ -15,6 +15,8 @@
 struct reset_head_opts {
 	/* The oid of the commit to checkout/reset to. Defaults to HEAD */
 	const struct object_id *oid;
+	/* Optional commit when setting ORIG_HEAD. Defaults to HEAD */
+	const struct object_id *orig_head;
 	 /* Optional branch to switch to */
 	const char *branch;
 	/* Flags defined above */
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 738fbae9b29..be63456c5b9 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -323,4 +323,30 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_orig_head_helper() {
+	test_when_finished 'git rebase --abort &&
+		git checkout topic &&
+		git reset --hard commit-new-file-F2-on-topic-branch' &&
+	git update-ref -d ORIG_HEAD &&
+	test_must_fail git rebase "$@" &&
+	test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
+}
+
+test_orig_head() {
+	type=$1
+	test_expect_success "rebase $type sets ORIG_HEAD correctly" '
+		git checkout topic &&
+		git reset --hard commit-new-file-F2-on-topic-branch &&
+		test_orig_head_helper $type main
+	'
+
+	test_expect_success "rebase $type <upstream> <branch> sets ORIG_HEAD correctly" '
+		git checkout main &&
+		test_orig_head_helper $type main topic
+	'
+}
+
+test_orig_head --apply
+test_orig_head --merge
+
 test_done
-- 
gitgitgadget


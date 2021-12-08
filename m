Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC003C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhLHPBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbhLHPBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:48 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D14C0698C8
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so1963038wms.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y1F0Z9ZyXB7v6sv+xBbDv42cBFlKUUJgK4IDOV/SYXM=;
        b=M2664nQwx9GT0TXYabDOzF569igvrLjMNZ30AkbY9hnD+ScHr8XpdVPLI4vbmBN6JB
         nMobNi30m78Twu3WlJKjgOx1YJcgdIH2g+LQZjEVyBkKuxuWrbXX7BTYr4yBXLx9ZYmR
         Su9LdhaBfqodUhH7WoJjOKQ+qb0/jH2EVADU97615Oa9qp31aHKK0XGMlrQClNndZ2Oo
         TqUvXHgykv15MOBsj4miIcZ6bcpWeNa2NYu6O3SGj4sai/upRc4gE5Ec5AwdmebahAUh
         Pv/TWu03EwMeXqvRQeW3SWyFdCkxqTq3BONbXk+XHOfv9slWxUNbJUe+FknPNBq5r6uu
         ebwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y1F0Z9ZyXB7v6sv+xBbDv42cBFlKUUJgK4IDOV/SYXM=;
        b=avznC64wtiVgGnMB9nRrDCNmV8uqb4+7dL1YT4KfY+lyQ/lhRZ50RlLoNY/jJsTnuk
         6ngc/mMoEwHYOD/aXBUuTUpJkLUK45WgRIF/65ddu/tEV6qz2bUg0y+FeDQLWpHDWeD6
         rMp1tpvmk01tDnQcQ7KY6IxQL0gXqtqeC2IkoXm+mW1tlRWcSEZceax4h7hv5FxeF2cV
         6DzidzG9d67JHVE/xwnw8A/zqNlFqHgojC0I4HDYIvUhn94CvHlXNh8Uo1wUkdDnC+Gq
         +d0E4dkJFTUWmeNUoRqGK2Njn6vu9rTTQKS+2IEh9jpznYzrPAnYIEKhRzybT/vxLyin
         wbGA==
X-Gm-Message-State: AOAM531vTiUaunIyvlvZTFMPP0o9F0FJPitvLVCJs1IcVtLj3S3JuczJ
        KvnLJTLvTwwVLvo0DGHWofQa8UHfQGI=
X-Google-Smtp-Source: ABdhPJxI8TL5NDsny/4SOnAYzf7Q/U9EF/eVLmwLm3m0bWe6AF1kvpzayGuFGFPvQvMfcyBNzrCawQ==
X-Received: by 2002:a1c:2:: with SMTP id 2mr16935180wma.41.1638975493070;
        Wed, 08 Dec 2021 06:58:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm6703773wmq.11.2021.12.08.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:12 -0800 (PST)
Message-Id: <45a5b5e981804c540991a63675909c4155b86b5e.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:58:00 +0000
Subject: [PATCH v2 13/14] rebase --apply: set ORIG_HEAD correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the start of a rebase ORIG_HEAD is updated to tip of the branch
being rebased. Unfortunately reset_head() always uses the current
value of HEAD for this which is incorrect if the rebase is started
with "git rebase <upstream> <branch>" as in that case ORIG_HEAD should
be updated to <branch>. This only affects the "apply" backend as the
"merge" backend does not yet use reset_head() for the initial
checkout. Fix this by passing in orig_head when calling reset_head()
and add some regression tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c           |  1 +
 reset.c                    |  4 +++-
 reset.h                    |  4 ++++
 t/t3418-rebase-continue.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b55a9cff05d..e942c300f8c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1769,6 +1769,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
+	ropts.orig_head = &options.orig_head,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/reset.c b/reset.c
index e02915c0f65..448cb3fd785 100644
--- a/reset.c
+++ b/reset.c
@@ -15,6 +15,7 @@ static int update_refs(const struct reset_head_opts *opts,
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
-			update_ref(reflog_orig_head, "ORIG_HEAD", head,
+			update_ref(reflog_orig_head, "ORIG_HEAD",
+				   orig_head ? orig_head : head,
 				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
 			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
diff --git a/reset.h b/reset.h
index 7ef7e43ea8c..a28f81829d8 100644
--- a/reset.h
+++ b/reset.h
@@ -22,6 +22,10 @@ struct reset_head_opts {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
+	 */
+	const struct object_id *orig_head;
 	/*
 	 * Optional branch to switch to.
 	 */
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 22eca73aa3e..130e2f9b553 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -308,4 +308,30 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_orig_head_helper () {
+	test_when_finished 'git rebase --abort &&
+		git checkout topic &&
+		git reset --hard commit-new-file-F2-on-topic-branch' &&
+	git update-ref -d ORIG_HEAD &&
+	test_must_fail git rebase "$@" &&
+	test_cmp_rev ORIG_HEAD commit-new-file-F2-on-topic-branch
+}
+
+test_orig_head () {
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


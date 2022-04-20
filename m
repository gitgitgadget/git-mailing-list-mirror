Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A2C433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbiDTJ7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377361AbiDTJ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A753969C
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so868570wmq.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O5kvl/S52pJhaRUSJnaztjWAmJ26/3AUh80dthgKV3Y=;
        b=kYBHiItCT4NuNK01QxY/vPDc5LxjpGD4ECq0GVk+fT2QnM/ZUgfKyOPbJEfHp6tB3Y
         IQv8xjIlHNNCq62no9pxZOaDvWaRK6Ss4lMR6M9Z5FW/Ba//7uGfCOy70cBLcmWN22wq
         hR4hoAJK/TWdbREr6XjZI4Lu4wXA3mn8LqR9CnPqAr1q3pKuCTOqcGIWIUeWcvtF4L7I
         OGbN8r4xYDsb1brSvfKYQ9Cb/D4JxfR5aHnTU7h2MaqAn3SE5y/To2UpdooWb3mEGhQA
         BToGXDYXaep7/cZ0fYgc6aGPA+b3DRWi6jmhxWNAwRPt3kZ6yTmPPhsNHboXQDq60rlY
         2piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O5kvl/S52pJhaRUSJnaztjWAmJ26/3AUh80dthgKV3Y=;
        b=nJMrTAkcNUkX4boaWe8YcdRB3Q97cwZyKQx+M7tN7NuNQW+qNo8r67cHgScEkamscm
         UmqpOiM8x3z6ZEQeydfUPrcqKkq3Qh4iWP6EIk2M9IjPGronD4wLhk92nwtseD6tgqOl
         2+l4BEfmrMY6uvmQdJZeAu7i1tJWLdu0S2KK5krSzxGqAvyd6drZGSpKrZ7/o0Xo/Md9
         fPyhMrpEAKiV/WDIMA57wLQHJHzWoPcPtCWMFIN2YODaVXqGU4SbLuylgumyD3yc8If9
         TSTQGAq/w69xvdtD1ZlRFYI4kkcCUX0LJ0WNWdcQ8d+MSgfe2n5fF3kE8D5xKmSUF0Yz
         //HA==
X-Gm-Message-State: AOAM532LqGpPI8TUpnfXLsyww2aYAa1u7NhaT57K02nHv+rTwn048a8W
        I5k3N0AUPn+4tuYt4Qk5j91aV9T2MFs=
X-Google-Smtp-Source: ABdhPJxzAAg6JEMgdDaa4LVUPFZMcAznVGjjGdTsJEWM5LdK0fS/9fg4mjmNzDnMkgMluwaXfgpSdg==
X-Received: by 2002:a05:600c:19c6:b0:392:926e:5023 with SMTP id u6-20020a05600c19c600b00392926e5023mr2811849wmq.110.1650448617813;
        Wed, 20 Apr 2022 02:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d5350000000b0020a99bc986bsm6418475wrv.28.2022.04.20.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:57 -0700 (PDT)
Message-Id: <6c15f00e17064a356ceb2b638e89ee7ea21aff24.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:46 +0000
Subject: [PATCH v2 3/8] rebase --merge: fix reflog when continuing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for a conflict resolution committed by "rebase
--continue" looks like

	rebase (continue): commit subject line

Unfortunately the reflog message each subsequent pick look like

	rebase (continue) (pick): commit subject line

Fix this by setting the reflog message for "rebase --continue" in
sequencer_continue() so it does not affect subsequent commits. This
introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
in pick_commits(). Both of these will be fixed in a future series that
stops the sequencer calling setenv().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 2 --
 sequencer.c               | 5 +++++
 t/t3406-rebase-message.sh | 9 +++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4832f16e675..cd9a4f3e2f1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1247,8 +1247,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int fd;
 
 		options.action = "continue";
-		set_reflog_action(&options);
-
 		/* Sanity check */
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
diff --git a/sequencer.c b/sequencer.c
index bdd66b4b67a..3634ad5baa9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4777,6 +4777,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
+		char *previous_reflog_action;
+
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -4787,10 +4789,13 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
+		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
+		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
 		}
+		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5253dd1551d..3ca2fbb0d59 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -17,6 +17,7 @@ test_expect_success 'setup' '
 
 	git checkout -b conflicts O &&
 	test_commit P &&
+	test_commit conflict-X fileX &&
 	test_commit Q &&
 
 	git checkout -b topic O &&
@@ -107,13 +108,17 @@ test_reflog () {
 			GIT_REFLOG_ACTION="$reflog_action" &&
 			export GIT_REFLOG_ACTION
 		fi &&
-		git rebase $mode main
+		test_must_fail git rebase $mode main &&
+		echo resolved >fileX &&
+		git add fileX &&
+		git rebase --continue
 	) &&
 
-	git log -g --format=%gs -4 >actual &&
+	git log -g --format=%gs -5 >actual &&
 	write_reflog_expect <<-EOF &&
 	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
 	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (continue): conflict-X
 	${reflog_action:-rebase} (pick): P
 	${reflog_action:-rebase} (start): checkout main
 	EOF
-- 
gitgitgadget


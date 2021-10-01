Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F480C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E076134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353416AbhJAKHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353273AbhJAKG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k7so14486825wrd.13
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1Irhq8IsPa+LL7gETWc+PQ//HgECZnjwhNdRzGczCg=;
        b=KJLucpcX+DeN4AwF24Pv+LDaqiMGjr5G4vo6TbVtTBs7zmsQazdMKZCnp0+6o8pyOF
         oZtYB4A6554mzRN4WYQxUKtHoTaScyBxJr5ZRIFxgrgOScxhy5fnnGACRV4pY1Y14KOs
         0cE1ar55hoiS7uF73FXtzRCjwJbxx/CDNJUyA39gQb2vzjLZ/cn77vi+39C5qi7kETt5
         STYq39LRjzwXtWuwGnHa6NZEJ+tD/wWSJL1Becqlq6/QX9qtjDkxvx7JON5pmkh0govC
         j7xXy/4xqn5Cwgy5IM7wYWuRDJORDl1JVAdFe469YHbmmFb9KRpdeiTcP8bcac2KseYb
         +hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c1Irhq8IsPa+LL7gETWc+PQ//HgECZnjwhNdRzGczCg=;
        b=jFB5oevpMBUpXFc9hhHNiinxVAeZCSVKQAECQsMRBWB6ILukFd+o6VRJXVEloYPoba
         WlQEv0IADLvDDz4n4Ov2C0DCk0NMkpEB9iUMeA4qgZinypxKf950gsAYmc1BfKFXzjgm
         x8pY4EKPq+0pnnvmK3xGmqRTXDu7OyzLfzJZOgeJXG1QEVv4XfRtFfYGBMDlDDXb7oUw
         Jk5zRn5bUY142icsrnPu+w7UEjWNJMCFMFEC8i0aw7leTSPiAhmdpPq+gNh5J/W34sLO
         P4z1ySLmxZfrf1qrwN1mn90nNFOrbkfp0Fi0VWaid4Kw5jj5dJjKsyiwmHcwa7/h/V2a
         oZmw==
X-Gm-Message-State: AOAM53025t3L2ZA1MGo7+9tkmqsKrHkQUYpFv9ISm0IzTwcyC9WRorpZ
        F5y77yh1Nf37Lma1aAe1pZfkD/WBeqM=
X-Google-Smtp-Source: ABdhPJzUq3mSqLbau+aIXLrzppmFDkyFWcWxAm+P++urdAjguLACbKB2yPptn62nKByP0g0X2cCODA==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr11079275wro.189.1633082711007;
        Fri, 01 Oct 2021 03:05:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm5408291wrt.67.2021.10.01.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:10 -0700 (PDT)
Message-Id: <2c8c60c3f310a490217b9b1c62b13fca83c171be.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:05:02 +0000
Subject: [PATCH 11/11] rebase -m: don't fork git checkout
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

Now that reset_head() can handle the initial checkout of onto
correctly use it in the "merge" backend instead of forking 'git
checkout'.  This opens the way for us to stop calling the
post-checkout hook in the future. Not running 'git checkout' means
that 'rebase -i/m' no longer recurse submodules when checking out
'onto' (thanks to Philippe Blain for pointing this out). As the rest
of rebase does not know what to do with submodules this is probably a
good thing. When using merge-ort rebase ought be able to handle
submodules correctly if it parsed the submodule config, such a change
is left for a future patch series.

The "apply" based rebase has avoided forking git checkout
since ac7f467fef ("builtin/rebase: support running "git rebase
<upstream>"", 2018-08-07). The code that handles the checkout was
moved into libgit by b309a97108 ("reset: extract reset_head() from
rebase", 2020-04-07).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 36ab6854c6b..9011dd84afd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4217,42 +4217,26 @@ int apply_autostash_oid(const char *stash_oid)
 	return apply_save_autostash_oid(stash_oid, 1);
 }
 
-static int run_git_checkout(struct repository *r, struct replay_opts *opts,
-			    const char *commit, const char *action)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	int ret;
-
-	cmd.git_cmd = 1;
-
-	strvec_push(&cmd.args, "checkout");
-	strvec_push(&cmd.args, commit);
-	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
-
-	if (opts->verbose)
-		ret = run_command(&cmd);
-	else
-		ret = run_command_silent_on_success(&cmd);
-
-	if (!ret)
-		discard_index(r->index);
-
-	return ret;
-}
-
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const struct object_id *orig_head)
 {
-	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
-
-	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
+	struct reset_head_opts ropts = {
+		.oid = onto,
+		.orig_head = orig_head,
+		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		.head_msg = reflog_message(opts, "start", "checkout %s",
+					   onto_name),
+		.default_reflog_action = "rebase"
+	};
+	if (reset_head(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
 
-	return update_ref(NULL, "ORIG_HEAD", orig_head, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	return 0;
 }
 
 static int stopped_at_head(struct repository *r)
-- 
gitgitgadget

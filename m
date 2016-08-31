Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3101F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759407AbcHaIy7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:54:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:59017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933571AbcHaIyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8m7Q-1bowti39o4-00CCIk; Wed, 31 Aug 2016 10:54:02
 +0200
Date:   Wed, 31 Aug 2016 10:54:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/34] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <5ffec2e588a4edc4902e1ab3a2ec3a73a7c3625b.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:G4RgPlZ/Tk5pMlUltSS4i20ELoW8xz+YgwMtVqnu/rWK5aB0Lg8
 0vLlo+o35t3YXiM7YCCCasCGR+kbG2WKZyVBImPWyHi8hIJtCgDxQr0Vyr7LvP+ddWo37RF
 HP0QLVXmgsQPEZozQ0VdRNKeKx2i2eJxV6XsmqVyCbj8O9Sgfs3Z9EK/t6yJZSGECZUyhR8
 /5NpSpOc4zhVVB+t6yGUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+WlAuujwVtg=:6VmvSbQ5X9VXYj+HoYO/hd
 P9bLP7fF4ZQ8ukf7i8/a7AU5yx/uXJeT6TCIQfsDB7DYuZzI+EEp2e0nkWrAMBrxgO7LpEFjx
 RuLItMA6hdcSo4H9OmGYP5jFVpRgS2csyOZRXwcUKUPx8BKK45G9WECaU3AbkJIDsvUj2ffU5
 rvmncvIZpiwpRGp7hbXdk0rDVwpKcbNsCDb/apslwEz6PDsw/5fNgMIK2Nmc/DGVD4CPZuTny
 qAjKMUwmRb+bCbEFhAMlRDtRIwDax7h4gtn6Z8upnFpoY3iadKOvoEn/KH10ts1l5eIL2ukjp
 A+2OssP86l2mQNkv2xJm0dQ6I33GNAaArXcn5cdhN2ComgG9woYrreXiPfr7vC3PYY1tJXvNY
 slzay9KHvpFs7Sf0FhdRKPBh3cJD/BFi5LR1Brm2tt29ZJYnNGFBegAObxJcDSwm6lYpj6jlJ
 ipszAAFLxm0aq6QSZVK0F6rvvyAOY3713t8fYgakRRH1I2An6YAMFn6glc9/S9UbfqreuDDLl
 GB5rfk3LzYdNxNELrJorNHooZC7C+tPkESxj5eNTq3/gGcItv34IdgS0UCG0X02D9zmxp0de/
 0Rjb7EbiEihac7S4Gba36eaSfDWzgJKVFBZzRyemT3hB7YlfnQKTEG5/95UfddJQcC61sbx9u
 PPHKDyT/lTCZCRAGfc295qNMI92nktL7k4Bz2NaYCIxxCdRzIvyye7jtAQ7GR8+At6/8zGZaW
 8oOnBehCuwDyIs1Ta7TGeCG7sAenXcKMSElkeMZpOkxJo4ZCB0zQFU85UUPpBg/gvnyah+SmH
 64JR9jk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new action for the sequencer. It really does not
do a whole lot of its own right now, but lays the ground work for
patches to come. The intention, of course, is to finally make the
sequencer the work horse of the interactive rebase (the original idea
behind the "sequencer" concept).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 32 +++++++++++++++++++++++++++++---
 sequencer.h |  3 ++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a89ef27..5598534 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -28,6 +28,14 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
+static GIT_PATH_FUNC(rebase_path, "rebase-merge")
+/*
+ * The file containing rebase commands, comments, and empty lines.
+ * This file is created by "git rebase -i" then edited by the user. As
+ * the lines are processed, they are removed from the front of this
+ * file and written to the tail of 'done'.
+ */
+static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
@@ -43,16 +51,20 @@ static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
-	return 0;
+	return opts->action == REPLAY_INTERACTIVE_REBASE;
 }
 
 static const char *get_dir(const struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return rebase_path();
 	return git_path_seq_dir();
 }
 
 static const char *get_todo_path(const struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return rebase_path_todo();
 	return git_path_todo_file();
 }
 
@@ -176,7 +188,15 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		return "revert";
+	case REPLAY_PICK:
+		return "cherry-pick";
+	case REPLAY_INTERACTIVE_REBASE:
+		return "rebase -i";
+	}
+	die("Unknown action: %d", opts->action);
 }
 
 struct commit_message {
@@ -407,7 +427,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		/*
+		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
+		 * "rebase -i".
+		 */
 		return error(_("%s: Unable to write new index file"),
 			action_name(opts));
 	rollback_lock_file(&index_lock);
@@ -1186,6 +1209,9 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	const char *todo_path = get_todo_path(opts);
 	int next = todo_list->current, offset, fd;
 
+	if (is_rebase_i(opts))
+		next++;
+
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
 		return error_errno(_("Could not lock '%s'"),
diff --git a/sequencer.h b/sequencer.h
index 688fff1..edd7d4a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,7 +7,8 @@ const char *git_path_seq_dir(void);
 
 enum replay_action {
 	REPLAY_REVERT,
-	REPLAY_PICK
+	REPLAY_PICK,
+	REPLAY_INTERACTIVE_REBASE
 };
 
 struct replay_opts {
-- 
2.10.0.rc2.102.g5c102ec



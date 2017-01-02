Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BB1205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbdABP0s (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:63655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdABP0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzbXq-1cak022MmA-014n54; Mon, 02
 Jan 2017 16:26:32 +0100
Date:   Mon, 2 Jan 2017 16:26:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 04/38] sequencer: support a new action: 'interactive
 rebase'
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <a5d77fc7ffd430b437d3b0dfab4cc0e29f31a2b6.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:C83zQBeiKNMpvcUkpR/TI+45FhRPRAuGZemjJVofkhuJNWSBm8y
 +bF7agN02d2i2wYIph0t44KyR52dPegZPXA7rBrU5BtuLsvXINEJl2fDvg4lAIBwLEGCeKz
 aCRFluopM1s8VSQLk1HJH6gfkTGgq+cqwW1eRofr6jCQTJPNW4tpr1vbeARaGO/Pxjs2QFs
 HRgbyLNegEitTw6YgjgIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:40LlteVKAo8=:/cqUkOIldI7aDH7rBl0+ci
 nLrSSump770G3HSF3Ybho3vpd9FiaucC8Hbl1OEEgBUo9MAPN3DrdxIKAct0Om+hvSjAEOI2S
 TkmWwLAq/BjwCP+bPbur87ctBKMXX9l8/pVN8r+6NmlHeVuUDDyatxZCTMCLGOhT57UdEA2D9
 /oaliL2zxHGIprVVNsQrr5AgbF5Lh/IGNYVwiQjD4kxmBFO58gtAHr3dxGR2rHG7XW8Zw65n1
 3KoqW+dcfuoxX03trADPO+gVm0Nul9rRCIm6dTQQsdqOJZsnarfm97cYypRH1Yb+vAcyLcYFG
 JK024aXtX4mv1IqewvH3ODZ3iw9M1P7w3U9hHM30pNL7dCx8DTeg2ZKm4wgoygVxHp6kKHyVE
 dzfbs2yuENYGQnSIf15C83usPXXnrpcxpAP0QZ/vgv67LSxj6L6Y3ylE9TvL/bvYTdX0HfA3f
 1IjesAO8OyBIyY19/qmNKtS0TGz1EfNp2DTHEd/KYsHvk5u5vb73npFIUmB1AkZOFZ95H80d8
 Yw66QSw+cdW7pXJhov07GjvoNb0GsPNcQ4vWjCF8VJPGX4OLL+4lub8zFDRb1ple5EN776TEN
 rNcpStURlW3J4HY4R8ooOQ3kBqVBHc3HOsvYGHZWLjvIFh+lGjSRdCwF0pTA0skrpn4PrNeco
 MC1leUhaMDMojTHswf5/8pMBHHAymMpUQ+kX72Vl6xjj/3fVgErrUW7aPoe2qBldfqRdLU9Is
 ql49HRAsRfPn0WkOb+6S5Nn3qS1E2iQKJOjvQtdhrFTNR0JNbJJmYKOGICOVe/bCZIpDFE1tV
 89WHr3IzUobG6lQDWvVOuOfxv/uzYUfEPsxg1sbRuJjmgiUYlxw43Z6mjuS5JfY3J5Npu5W1y
 Jw3lzgB7xAXsakqt+kbU/XbNFSIONwOjjzpEf79INkqNFeD+1LW9le2KavN4wopgoGoqDJle0
 ew96VdgFRwSzCAfYi9aKQlvGd8V1BN3xUcDjr9bGBIRqm9PTqajjI4ieZh23o1CzkErHRBjVL
 GutY5G7s2JthKXwADxf/oLc=
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
 sequencer.c | 36 ++++++++++++++++++++++++++++++++----
 sequencer.h |  3 ++-
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 720857beda..690460bc67 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,14 @@ static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
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
@@ -42,19 +50,22 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
-/* We will introduce the 'interactive rebase' mode later */
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
 
@@ -122,7 +133,15 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		return N_("revert");
+	case REPLAY_PICK:
+		return N_("cherry-pick");
+	case REPLAY_INTERACTIVE_REBASE:
+		return N_("rebase -i");
+	}
+	die(_("Unknown action: %d"), opts->action);
 }
 
 struct commit_message {
@@ -364,7 +383,9 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+		/* TRANSLATORS: %s will be "revert", "cherry-pick" or
+		 * "rebase -i".
+		 */
 		return error(_("%s: Unable to write new index file"),
 			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
@@ -1198,6 +1219,13 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	const char *todo_path = get_todo_path(opts);
 	int next = todo_list->current, offset, fd;
 
+	/*
+	 * rebase -i writes "git-rebase-todo" without the currently executing
+	 * command, appending it to "done" instead.
+	 */
+	if (is_rebase_i(opts))
+		next++;
+
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
 		return error_errno(_("could not lock '%s'"), todo_path);
diff --git a/sequencer.h b/sequencer.h
index 7a513c576b..cb21cfddee 100644
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
2.11.0.rc3.windows.1



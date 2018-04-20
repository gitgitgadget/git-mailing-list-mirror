Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C561F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeDTMSx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:18:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:44713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754688AbeDTMSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:18:52 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1eEcva1KhW-00vtcD; Fri, 20
 Apr 2018 14:18:48 +0200
Date:   Fri, 20 Apr 2018 14:18:32 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] rebase --skip: clean up commit message after a failed
 fixup/squash
In-Reply-To: <cover.1524226637.git.johannes.schindelin@gmx.de>
Message-ID: <6d9f6ba1e73d2297cef3619a89ce69122438368d.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sI83kqNQjKU4W9+XwfUGRQaSHY7PbJbE/ZrH6X0a+INZk6gLqla
 n6U/NDZK8bePwGJtd/FqXttfIwVWVMjl913WQfxXcijwcSK0CEmqN5UWqf5IF5KhHUYHJCm
 kYs7LtYBnEkj/5Bj0R/J6ef5vTfuaXIY+ljNm+7Z0RhAb9zO28iMwvCKIpMeMNjlGL6F2aZ
 ccwfNlG8eUDA4c0YbCKvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BdAOgZ+ZjUQ=:F/zWvTJ91rjA0XXx4wVNgz
 65XBogLhg0jp0B2tRDd7x5c92A6oUzgvryr7lgVMugbQMeqyhYE1J5CyWwNVqeqUT+BZSGPyE
 U8mHRq08ekEKDboYZXjLt8dWzfnpfq0NY0yGuT+/gu2XqQE8MNApc2FD69jG7cMgyo+kwnDHf
 mMpKaGr9u2KKVgVkpyGMBLe+HxmqXaf54XIgNd0Y4MAz+6tZq9L98YVQV7RSmPmR8AqOZLeLW
 zs2IFsvlhbvVXwjXRGp5SfYjRccNm79nDiSRPtfp4Eyvzr++gmKC16L4cNex+gfNYX35aWsj5
 ENnI1Jdde4GwdABGe43z6XaqT7tT9eRV2P7SmdlRBLGiYG5GU25NGHM2OChI9Z1W+Z4wAdPZc
 ZbEaB04gAeQw0C3FxrDAQ+/ewfB/yjk95lwyH0FwKxZ0JRqF3n8UwwgHudSzG0sbwbUi6uLSL
 jpT5GqEPcALnNqJxOO8RmIieBEvK96dzfa7zIkzFQ6G9sFQbYjCNGLUP2lmaGacYprv/ibFza
 lUp4fJ7Ul40TYHPmh9M7B6aRrnd8b05iCTrkKLIl5CXX/9u1y1MpTTZuHl7z7WuaK8tbHrQs+
 rq3jDk+CL0UIJm2i6tL8jvWSrjQFyyEja4t1c6pTg37a+7AjQEzU39yzidTVOpHk6PyM0OtZd
 fi7KMBLIfy+UHZPY4rjEEz14Pz3KV8KdfBir9GyIBpGylYfaD7URzLovIvjSx7BlHHlXGGM2I
 IHCuFF/XL0K/+3aA40vPRIZF79NQVlrESiM5MZAIfLJcWlxs8mwfIm3AaqKJpsp41yuMa85pu
 NsLB+mAjpeSXVb6HKUh3e9VEd9Yf+8ZhxIhN/Zi2z9Deg0ciME=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a series of fixup/squash commands, the interactive rebase builds
up a commit message with comments. This will be presented to the user in
the editor if at least one of those commands was a `squash`.

However, if the last of these fixup/squash commands fails with merge
conflicts, and if the user then decides to skip it (or resolve it to a
clean worktree and then continue the rebase), the current code fails to
clean up the commit message.

This commit fixes that behavior.

The diff is best viewed with --color-moved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                | 36 ++++++++++++++++++++++++++++--------
 t/t3418-rebase-continue.sh |  2 +-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a9c3bc26f84..f067b7b24c5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2781,17 +2781,12 @@ static int continue_single_pick(void)
 
 static int commit_staged_changes(struct replay_opts *opts)
 {
-	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
+	unsigned int flags = ALLOW_EMPTY | EDIT_MSG, is_fixup = 0, is_clean;
 
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
-	if (!has_uncommitted_changes(0)) {
-		const char *cherry_pick_head = git_path_cherry_pick_head();
 
-		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
-			return error(_("could not remove CHERRY_PICK_HEAD"));
-		return 0;
-	}
+	is_clean = !has_uncommitted_changes(0);
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
@@ -2804,16 +2799,41 @@ static int commit_staged_changes(struct replay_opts *opts)
 		if (get_oid_hex(rev.buf, &to_amend))
 			return error(_("invalid contents: '%s'"),
 				rebase_path_amend());
-		if (oidcmp(&head, &to_amend))
+		if (!is_clean && oidcmp(&head, &to_amend))
 			return error(_("\nYou have uncommitted changes in your "
 				       "working tree. Please, commit them\n"
 				       "first and then run 'git rebase "
 				       "--continue' again."));
+		if (is_clean && !oidcmp(&head, &to_amend)) {
+			strbuf_reset(&rev);
+			/*
+			 * Clean tree, but we may need to finalize a
+			 * fixup/squash chain. A failed fixup/squash leaves the
+			 * file amend-type in rebase-merge/; It is okay if that
+			 * file is missing, in which case there is no such
+			 * chain to finalize.
+			 */
+			read_oneliner(&rev, rebase_path_amend_type(), 0);
+			if (!strcmp("squash", rev.buf))
+				is_fixup = TODO_SQUASH;
+			else if (!strcmp("fixup", rev.buf)) {
+				is_fixup = TODO_FIXUP;
+				flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
+			}
+		}
 
 		strbuf_release(&rev);
 		flags |= AMEND_MSG;
 	}
 
+	if (is_clean && !is_fixup) {
+		const char *cherry_pick_head = git_path_cherry_pick_head();
+
+		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
+			return error(_("could not remove CHERRY_PICK_HEAD"));
+		return 0;
+	}
+
 	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index b177baee322..4880bff82ff 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,7 +88,7 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
-test_expect_failure '--continue after failed fixup cleans commit message' '
+test_expect_success '--continue after failed fixup cleans commit message' '
 	git checkout -b with-conflicting-fixup &&
 	test_commit wants-fixup &&
 	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
-- 
2.17.0.windows.1.15.gaa56ade3205

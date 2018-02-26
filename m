Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2065A1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeBZVaE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:30:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:47111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbeBZV35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:57 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lgql4-1eLA0O42z8-00oC0i; Mon, 26
 Feb 2018 22:29:51 +0100
Date:   Mon, 26 Feb 2018 22:29:50 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 10/12] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <8ecddf181eeaa9c6bfc9ff573562f9bd9d3d32a5.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Zo1PXs6ZmBjwK/LIdGLU6yR5mLiMVR1tA6qHkiEFr80NarrG/CM
 rGXQ4mqtqAMQ7qf/hQF3uNFGo2Q3tWBIvyLnQMz0uFV310P886UNCvrqqDngsLaEaC/7SYA
 0DhQu5s/YrwE637RLksc9PVNQIQpKrCLaElduyKLnsuH2iTt9wU0gYVCUpPoIAAq9yryYAu
 eZnqewE/Oebh1QbMKEnQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/imq2EeMP1A=:x8NxaaPyilGLmm2OnFgtEJ
 d2FFwj1dvmPJQQTlIkKWDb5Jy4VQkZZzvETuqHnYR0st6Giv4UCmZdMrIQWdo3OkOomyYi3xU
 E5PoOQOOyo+diwCwj0m0pKRpB3QI3ooY/UotlMZhZtEEGyFRWN1YQmhgoDOUqHSBTfbO6G5wa
 tPhVanezmkMdeQS2Q6fgDcw9eC7O8K2ImVxJBkAIn9HJ7eH0VyOwZEdC06I7hqtQEMcLUmWwz
 2BliwVSFNaAg4fG2a8p4SQ6p8L23I1rPA2XEfJDV/pfQRQQdnQKOLUYmKi/Au81c6RoNDK60K
 u+sPG+VEAnVR4Qu5RRU2Z8UbhJgO0leMxGd3c6mcXrFJXv7eO6haqAkgp7deYoPKKCRnoGGfA
 8s65RGvTaXqTaHakYX5/9cTuhncNQy8UCszZXuebE0ObiKxRL9GVmDcFugb/a1TDddWOnx3sI
 axfd4IxXRwqhDYVAlElbyAfJYOWUq0Eh4zpC9iR1BeNEK5Ll0nyPbiwTpahz2+lWDNCmhSlVo
 6iX2OG+elHGiLrzcGSTxLR4iQ4Bj2n71e2xF4YhILyENjMuK9rjN7VBwofjcSR/a9FzSW6CMH
 DOnDj2PXjKXpg+JeY4sZXJupR8no5gW87s1S+3RyoFQz5gOTkVkc2c/0C5TiLEgoCr84FAqVY
 uo+g6Crr4fA3N2GblCJYjFbM9htWydu1R0is+yq9fQChkaxaWjMfBvqLGRG8GXnAk72jSMiT+
 F960IQU3ncgLR/MB3ICMyceo3hs2Oisxe9LgoRUytA7hYuPJDcInJPAmL60VeZyTw9npsoqp0
 UZrVtbBgB/M/kkghbWO+Dn/DY/G9HbqJTfM57Et/BYY+zOHYm4SabmFJoSBxx4Ojbbe07o8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --recreate-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits.

This patch implements the post-rewrite handling for the `merge` command
we just introduced. The other commands that were added recently (`label`
and `reset`) do not create new commits, therefore post-rewrite do not
need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                       |  7 +++++--
 t/t3430-rebase-recreate-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 01bafe2fe47..85ce37cb99f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2980,11 +2980,14 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		else if (item->command == TODO_RESET)
 			res = do_reset(item->arg, item->arg_len, opts);
 		else if (item->command == TODO_MERGE ||
-			 item->command == TODO_MERGE_AND_EDIT)
+			 item->command == TODO_MERGE_AND_EDIT) {
 			res = do_merge(item->commit, item->arg, item->arg_len,
 				       item->command == TODO_MERGE_AND_EDIT ?
 				       EDIT_MSG | VERIFY_MSG : 0, opts);
-		else if (!is_noop(item->command))
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index 1a3e43d66ff..35a61ce90bb 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -157,4 +157,29 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
 	test_cmp_rev HEAD "$(cat wt/b)"
 '
 
+test_expect_success 'post-rewrite hook and fixups work for merges' '
+	git checkout -b post-rewrite &&
+	test_commit same1 &&
+	git reset --hard HEAD^ &&
+	test_commit same2 &&
+	git merge -m "to fix up" same1 &&
+	echo same old same old >same2.t &&
+	test_tick &&
+	git commit --fixup HEAD same2.t &&
+	fixup="$(git rev-parse HEAD)" &&
+
+	mkdir -p .git/hooks &&
+	test_when_finished "rm .git/hooks/post-rewrite" &&
+	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+
+	test_tick &&
+	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
+		$fixup^^2 HEAD^2 \
+		$fixup^^ HEAD^ \
+		$fixup^ HEAD \
+		$fixup HEAD) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.16.1.windows.4



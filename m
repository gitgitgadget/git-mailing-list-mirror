Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AE01F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeBKAKm (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:58413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeBKAKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:41 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MeP5b-1eKcgX3uZT-00QCki; Sun, 11 Feb 2018 01:10:35 +0100
Date:   Sun, 11 Feb 2018 01:10:34 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 10/12] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <90cad9f560f127528b2f1d790c7add43c3bb6543.1518307772.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Zz1MfOTV56ITWkGl7nCPbYwLVd2NyQ/FX/A98xPD2xrEAOfIs7/
 nGktUY93zvMfzzaUENWt7Sp0nmhiHcyFt9G+qbsFs2E6l7mjS8S6IJ+5icxymdkDUVBCCEj
 aoIJ//Q53Tods9lKre5FoCG8VCSu0dF+biTlJ3Q86kuCQn0SdjlsgIvY97BOgJq43xExJns
 jIJ/r7hBwKEWg2paMYEsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VnUbr4iERDg=:PuAEojoJI5guX6ET73awBw
 bal2r+H+jg1xg4mC1r0KD/qHz2OVonQdHzWIz3T49+iuzJyQEZbCj3TuYzcOzBGAJYIcez286
 8mQ6f7q6aG/mc+XGpTRS51WxS/N0Un4lj2k8FfoLxJ8ORQ4UvXOwp28CmLN3SmwntU342iEhu
 IorkFdYDCzIMOpSiUgEX52K8MGswhNqSpfHHGaR3uMXP9QXLMjNlUezLCG+QiHmAcHeLjAboI
 WBF0sddSh+HsHISE76goXMJG+rpqIu+fl6tXwT1GhhFBX+GJ9KIXEf1pY1SU99oUcTCT7IT8a
 kOfT0/E5O1f/LQdXD9/RVF4E4dEZwUY1DTflAXgKJGY8N+NaYo7fYjGMFPnamXr8HWQmbkiRX
 taVdn5RhqHHwWBLcE+pBAo8aXflOhb80M8poSKIaAXGnWzMcboayfBtP2DdJ3p+E66eBv03Qe
 9QnZnWKk+lFzHhF2+XKYKfaEvYGqcgqwA/5hG2YxGd+iotmrUeWZGHgY5qjqsml08OGSr06k8
 7HdZJ+7YaDtZvCAZNfeTC5tHpAunQiDZ1lnm0CULc9PNQidQynNTm7FwxeIuIl9lVqB2CiZTM
 HyAKCSKEI9Y5W+VAMVPw0NFSHcEvhxyZiF8Bzw8Dyx0AOSIz7agGdY7vX+h20AJ/VyHpXph/4
 Bblv57ELqRPjz960YSJrBmxjaKAFolUyDYljQl/XLJnIEht0t2YaaltJ/3rc5wuc05934rT6w
 L18oXXGTZSdaa4aKH6WkWAkqbWPnznuHb3SscMoXTLzQJcpbj/fzIvwIpgeidNYB6U58fUS+J
 1sa0g+pGZnEMXC97hb+mfeuSA1dBfJhGG1Z1GSpFEQsrjk7Qr8=
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
index 7cd091a9fd6..306ae014311 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2452,11 +2452,14 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
2.16.1.windows.1



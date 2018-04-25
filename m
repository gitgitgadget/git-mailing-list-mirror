Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953E41F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbeDYM3w (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:59191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbeDYM3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:39 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfAog-1f0n323WGI-00OrKQ; Wed, 25 Apr 2018 14:29:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 13/17] sequencer: handle post-rewrite for merge commands
Date:   Wed, 25 Apr 2018 14:29:29 +0200
Message-Id: <ae8bea78692ba6e2fb82db8e1cbeee645a71fe04.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:ufB06DLqyGve1FUSw7iVtJa111SH9RJMMutU/UxjxzikQGX/Dq7
 FBDuFln0uX60aU1wthL48W8TaYTcm1sXBPqBUlc/qQNiYiZ5B+S8tywOmK9ZP0JtyauYrar
 gYrYGHnF7bioow+kiQyHQH39jXyGvtAfQHwUbvnEdjpBg15CB7yHky618Nk7+sldjzm4EWN
 iWLBnHtqGMuYBEdCSDdfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0XpKpa8w5ks=:nvBT+J1S7GPs5r8hcWeslU
 FuVLJVggkSokKRA3pinH9wXrJxZ/TjNajhrED6sLByrREBo8t+DIKNf0zVBOepbKEUJ9HwgH2
 YW5KcDN0rYrPxiHDB/AmexTY+WNkK3wVX537z/xNlfti8AsEAYfpJNnj9s6xSoaynB3B4PwAU
 KPpVr1yrOhqZDL5dfp1GoHPGs70a5xGbPKMN3syuPFJj0aVvXcQEZS62uYgeyqDBsLj2Dp6Ib
 N0LDJBxBZmuHrlV2ATQIUrakDxG5SkZ3Zl+16eRbOcsoCcD4EYn7hLlk+Xxc/VFCVBkRYHZ3R
 etImPR5gV17y5wSUgrKGcGCzzh6t/W78UgpccAx4qr8xVQLaZPUY5yQlE6t2u0KnULuwleKNS
 55Uxd2jJM5hLNBqbhpVvBD0qhu3zhnbVfSjAqQV8m2sT9xEQvs8i0m3n6rPI62W6056wMCGbY
 vvcHtHqgLaOaNzqBL1gh7oM0gUCBsKFI+7THfYnQHn5GZirQfPdJ7bVfTq+GwqqN9Ozl18sN4
 K3fZgy7+tIRUNGUIzlO9DdZk6IVs+dEZLMNPAk09QA8g+0zpkInQhYCLcjykLbX9ruQy7JccF
 y9Iewd2b6SuYP6Aa2ritNdoVmIiBwO7Qo/aIhVinVaSFYDWcfWQ7kE/qqqCHW9UBRLMfDuX8q
 mpkX6kyJ248UoUuR0A5mxMq+GhilRt4GlcjBMNrTA1M59LHxDE964fTX/pDQz5p5k0gzGXRCT
 b9yDcVnUSNm1zAYFqgHGm09k947QHvFQVhXG1xsv1cq5eoPSR3T1Z5gXhcRtRubBl7YnKyvjp
 7DGupVZM9Dj9XrFvnV2hENOUmAMLioHPvminwW0vonQSVDNdmRV346HDgCTvj7Mw/bJVNsZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --rebase-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits.

This patch implements the post-rewrite handling for the `merge` command
we just introduced. The other commands that were added recently (`label`
and `reset`) do not create new commits, therefore post-rewrite hooks do
not need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              |  5 ++++-
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index e9297122633..558efc1af6e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3074,7 +3074,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					    item->arg, item->arg_len,
 					    item->flags, opts)) < 0)
 				reschedule = 1;
-			else if (res > 0)
+			else if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+			if (res > 0)
 				/* failed with merge conflicts */
 				return error_with_patch(item->commit,
 							item->arg,
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 96853784ec0..e9c5dc1cd95 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -190,4 +190,29 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
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
+	git rebase -i --autosquash -r HEAD^^^ &&
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
2.17.0.windows.1.33.gfcbb1fa0445



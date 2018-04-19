Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CB11F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeDSMXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:23:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:35247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeDSMX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:23:29 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLO9y-1f9gYl27Ws-000dTk; Thu, 19
 Apr 2018 14:23:21 +0200
Date:   Thu, 19 Apr 2018 14:23:05 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 13/17] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <ffe35be70e7c7a6c5499e5400ee4f649a231298e.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lCHF5AhJlvFEDVQdUByvuWAuJNWTyAH6k1fov0ucc07agutOUmY
 tqNVCCCTKe6xwZRvSA1W2VUfXg1sonejhqVsNU/Wde564u1o7nDy7mbHF5vbVDRhCy3Z0VY
 tsszhKaeD++F1e1vSyHgHme5ldaHhGYmfxpQ62ws4XAeCdfaRNOJ+o0GaHzRE329TlY3aOD
 XPTlvFzW40aRQqPuUEzrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xxKSX73Skqc=:Ovn6oU1EehX9oquqiXA8FM
 dGtzzKEDYo2nx1sRZo8STFoD3Qlpf3KmW3VlhmPsSiJeSUc+kQIaJP7C38LHrYzRlUQQKQDuH
 MTpmpyVn5CCZVn3EXIBs1VFoqyKcmlBVyclfzdhdFMvO7wf/UQ/6NOwV31wr7liqttiKTWggD
 LqEQ9uqPIM5EycvwSlScNrMSMv1EMVf0Cz82C/mjEijKEwnTo4EU0N3GVirNVT7P1zcnOkONF
 4bAFooY2s3BYsiZ4o00KlkRV91V9PW9l18WsOUiChdz5MFehHczohfDRt9oiVP91fHbqjIT2j
 NzXg0oc38VjlRLqu/e3BYbo47qdAHmT1fBQfEJ0iA/8v38tS91gkDfhCn75NKw+qyxQ1FbZGI
 JJ44aJIdFrEPRauBr1O9yKAW2ps1SW8zK4hjAnuXsefFCosjRv2vWRvWuLXmX/okFjWm9ei4p
 uYtEd4343egHO0wu44wX2Nl0xv7D5IkVGHTwnc84IWRt+boge0Dg4vgY8FLKzWe3gRjhTCkjg
 bTh8ur5Tp4pJz1NfV537/eLJXaHfsDobYAzXIpKW8WbJhUy+uiSSAf0h6JVmQQ9DI4Q+zV1fi
 OKHacNEzHIFLKUHj3IrdZACpRJzonDk99qSAo4H5TM9wIjbkjuM1OB/0I7JOty5PBkigJeFkh
 cwuAXaHg2cK1QOkPGAP9AJ7AEaq8q9MuWIgI2fOY08XHU/6EwWOpzegH0m4hyNIQWFz8Osgkd
 iwMy5x4ZBnpB+xkwANnwZVagVLSfjtbHqcP2QXdKou6Dy6Op5//mxsUER/MRBrJWN74oCsVMQ
 eNGMYinfBSrntsmX76DTEoTqY+R+by5aVNCBd6Lp+4eFSuOrIE=
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
 sequencer.c              |  3 +++
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 32ebbc002c1..620a4c3a506 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3061,6 +3061,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				       item->flags, opts);
 			if (res < 0)
 				goto reschedule;
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4b553fc78b1..dedfa09d761 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -167,4 +167,29 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
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
2.17.0.windows.1.4.g7e4058d72e3



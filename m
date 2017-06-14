Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF1F620282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdFNNH7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:64472 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752495AbdFNNHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwarz-1dtf6i44jf-018JP4; Wed, 14
 Jun 2017 15:07:48 +0200
Date:   Wed, 14 Jun 2017 15:07:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 06/10] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <bc86ff44d5fa0ee2bf69ab6a7e06d52d4b9df3d8.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0://Q/SGFMELYxDb4J3b3N3wfyCcLQzH79I0u/Ue2Z4WAxDymiBWh
 xc3KoZBDQui95UdYZW7DxuhCfHnwwEYQLSLEEJA/A85K1Y7q93F1WnVPjMQfj0srRG2sdWG
 AeM3FAZNZmBu1AP+1geUhqS2++9riSP/O1N7692VAHxnYY4eiWR5kTlYLtt4sjqJGlwxxAh
 ohwJchvaLVXXjsNnSZMyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vfCKv+wQ43A=:wqvHzXKeeVQ/XdqAxxcGUx
 j8/qqRkarmBFELE1kAe7y+9ITyGIv+iPuFA+dJqZeeC39J0zhgcw87Il65AAX9wJn9jpO+tdE
 Q6Ob3UrDmI0hVxrTRHW2zcYwhVnidX2QPpSdcPWWdepbX9pNbI48ULqrftCweZ0jilMDTMZj9
 fkdOUnmJByyc8J7K0H08kGJFR5N5vvspNDRQOh33SwwtiH7YUJ4rGu3maQsPtRWEuc1h1jscy
 Etgu3qwkSmkKIPy9FLkGhcnnP6sMh0KH/zLMs2nT/DQlK1hvqQWDof1J9mUdt5MmuLgRDgfTf
 ersACpzsfRZP1CqK3hJC3hPOKJ5/Ht14WB62nBJZfZUGbkNHO6B2ZIOhC0AylF50yy/hKZ/qz
 NQD2C8BdCrZuZHn2JAyi6Ckna/EQ//i262wgCKhIQxNXo7VcW2/k4sYaGT/YtNjklldLSpYGj
 hJVqLguywOfdCO3iDqgXEDApbViyxYWg6oNL3PicQn2xKc0bt/0H8u7KdXbwwqr9cR8aMbpUc
 dOn8J/HVgv1R7jqIUJVvWEerAM2ZbiBoFodN/5QuqzW0t3kATv0YHa0gDoF1+kIHNyWTNpAJX
 e4uY8zbLQVs0sLa/UdATViwf8AjI7mpa4OhhiXq0eP7gTBZbDAL6DE9DS8fpSW7X6ZH+7NgGs
 Os31RdXjNnSdFz0Du8sCMfrjqiZHucKyc8EMWSB1c0m6ui+ZCd50PsrwtX5nU/jLzDc821u2Y
 CSbJwxJjdkNr6QqpwNegYjEIP8AQz8Atr8khXyQvd37/Fcio0Fv0LhZrQ6nqw5TxjT2yNB6xH
 pE27axC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests were a bit anal about the *exact* warning/error message
printed by git rebase. But those messages are intended for the *end
user*, therefore it does not make sense to test so rigidly for the
*exact* wording.

In the following, we will reimplement the missing commits check in
the sequencer, with slightly different words.

So let's just test for the parts in the warning/error message that
we *really* care about, nothing more, nothing less.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5bd0275930b..3b411ea8f1b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1242,20 +1242,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the command isn't recognized in the following line:
- - badcmd $(git rev-list --oneline -1 master~1)
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad command' '
 	rebase_setup_and_clean bad-cmd &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
@@ -1277,20 +1270,13 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the SHA-1 is missing or isn't a commit in the following line:
- - edit XXXXXXX False commit
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad SHA-1' '
 	rebase_setup_and_clean bad-sha &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "edit XXXXXXX False commit" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
-- 
2.13.1.windows.1.1.ga36e14b3aaa



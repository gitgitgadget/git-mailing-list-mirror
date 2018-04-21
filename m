Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904551F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeDUKrH (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:47:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:47497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeDUKrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:47:06 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlDx4-1ebJyO3l3e-00b55j; Sat, 21
 Apr 2018 12:46:59 +0200
Date:   Sat, 21 Apr 2018 12:46:42 +0200 (DST)
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
Subject: [PATCH v8 12/16] sequencer: handle post-rewrite for merge commands
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1804211246250.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KjEyGs29GSQ7ngxXPxo0X/BO7z0IsB2FvlKqA6jfFSYItkrW6Bi
 mIF0J3IqjMBz/nH30LvV4xhJBCjqxEJuDXuZrgf+COybq/ZMimoDNRiLJzc82AM6uBtqRoT
 LUsPi2uoevNIzWqRfj37tglsPFkbRI4HOoOUqJ119OoRJBjyULS2R6/BVGgJ0EHEwpRV3jx
 8jX7Djsr/lorKQTeVcOZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Eq3aSCK7XtQ=:uiRPLSgqZX/YeNxcb+V9DA
 NYrguubuyiiBdzbN/OWuCgLvHtEp9YVTJkxEmJdRgyuJZHQKJnbSaJlR5D3XBTvD+K0CfBjVJ
 NVYab0YWpE/CNAMOmX++fTWPY1SfANVHjRiQdOyAfaUbgtRqfIY9t8ywEBqjsmSpI3wMANxSW
 /U89rNoZ+QWQUVT0SfCqtLmSha0D8sdLdxowuTWKgzFgD4rcaZnz1/lMPQ+CkeuFj3TvlK2hR
 CTwlc1wP2zt3hBBOvwWJzFps0XGk6M2hr2XdIg6jh13OjkxVT4DKGiN27D8A/fI2ynDmtjAqh
 6rouv6LuStttr7VZ1zhYCOSKiy9FKdZvNUr42A06uptsigSZY3RIEDzB52Cz6DpHoRxsSMUKA
 85OHKQzyUkh3iuXV0AOgOrdXrOoTNvoefkKYx5KrXHNel9ebkvLnUY32ZcN3O7hLk3Rwjr7gb
 gKF82QyWM/ISUgKR/Cgvij3yLWJG0ARwoWwLDaFmDXioB2SPtp/y+Vh8IdagnrUHQv+wYpva1
 gWtfsWx3q7DA1uLCEdoxieTv2MXobw/W/DkmFvFkzJin8GBEdscGYwQqwtv/9NBZfE0e6nASE
 gAp4zI6iKZ2L8bb1LBkEyhBa1ec50iechUJJGXdoph0hvU0wwL+qRNfiyGIqCI3EIbQpjP5TG
 in0qQgenZdj72M7lk+tHk3YdLZC/mb76hI82WxUpHXCcoBXhGy84RM4i6o4CToGuA4L1AtEKI
 bU2PttLDPs/HOSw52B+9F31gbqhoeZmUyKXsXAqw8Fmsrj0ahBnGAKu2EPX0gXSgi3H37NftJ
 NFEwLxb6I1jdRnV03o5+MYkhz9t86gUCYNX/H7p6GfoNqfFdX8=
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
index 1e17a11ca32..f3b4fe4d75f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3062,7 +3062,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
2.17.0.windows.1.15.gaa56ade3205



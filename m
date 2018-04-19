Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4312D1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDSMXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:23:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:56911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752511AbeDSMXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:23:48 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFLhE-1fEh3I47oS-00ENhw; Thu, 19
 Apr 2018 14:23:41 +0200
Date:   Thu, 19 Apr 2018 14:23:24 +0200 (DST)
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
Subject: [PATCH v7 14/17] rebase --rebase-merges: avoid "empty merges"
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <61a4f19f84c21632614eb1773f921701e1351638.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+6c0vnShdIM+ybC1dz8TtUDEc+cxCd9ZE9/MjFID67yFd4fLuVB
 ki7fBe3X3HEtakOxDWEWUcdoCkCjEUqDJ2DWhd8h9tsF1Y/Y9XiaPaYmM7LzD72uP5AadlR
 c7UvuMgL3O5vLwHokQp4rCglXQlx63Lz8mEs6rflJa/XfFjCd5xiRWqMkdCHJgd8q3qc8Iy
 vzt0cuILzVP3/MERG7uCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xjgY4Reisec=:Vk7MrL1+iI8tHWtwU5QsFe
 HXZrP5fhnzser8/IbbLUNol9j8tfbtCDdeRLIutgOEbjT2sOYyVHnEOvS3nMtlEKLSY/53Dzv
 msZwRy0BtkR6OeOd3ZAC5yFAOLitJfO846jnIM/lWYF5Mxzkl2bnKzsy+z/JWubMc8rvjPouy
 ogMVnpUues922OryMPTmb5m/1ncqaFZcYZLb94TjabuZGxgp65ru7pvUzlipzi+wapljCqj9U
 ok5xhMR0u2/9Q+/sSuUwR9gnvqM/zmqXy5V46b+vkw0TugcV4xXZV2eqnzot2r5jaCCJaFKqU
 aazPoyMNdv0Jmki9iz9jJcDGCCLulu6nD9BM8bvvgv+vArkTgd6GwexgwK15QGDEE7ruQSuMM
 54AcJoEZcNVC8knUjCQQAPpe4g7pIZkVWlad7AP93b7TBMauJHCV93YrKO4CPcOMiIUY02hmY
 0dpiSpKCP6Xwke4kbCV0jmjO3H3I2YtGjifVV9bjZYRSZ8RAi/MHq/Pt+Ce+wGEDJG8F9GAqo
 DMJmrW64VJ+kZG5PVUM4DcWmbfSF9B2+Hz71JiarFrWEuga/ho29l2JXxYMD2PKz26mr+Kipe
 xHAQosULmK5mcmy+IoyMJG3Mbs3NUnGn0TraHFMwtCPpooBNjzVqTqrWvfmMbAM0ghTpCwZLy
 iKGLzGlBrkS0opxxbbsVhujvf5GwWKFkrHCsWifXCBMDIKymENid5JxOHuYl1I5+M0OKWe1dz
 Xsd0RcmVsvvsu9p69KpSQciBzAyrzRjeRw5r1+YWzNfE1Pr42lPrgKF6+KpFTHuQPgTnEzb5A
 tpkgumADG9KtOhXIBcrWOZIrCCKs1rHUatMszTO2ZKD3Z1laxo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git merge` command does not allow merging commits that are already
reachable from HEAD: `git merge HEAD^`, for example, will report that we
are already up to date and not change a thing.

In an interactive rebase, such a merge could occur previously, e.g. when
competing (or slightly modified) versions of a patch series were applied
upstream, and the user had to `git rebase --skip` all of the local
commits, and the topic branch becomes "empty" as a consequence.

Let's teach the todo command `merge` to behave the same as `git merge`.

Seeing as it requires some low-level trickery to create such merges with
Git's commands in the first place, we do not even have to bother to
introduce an option to force `merge` to create such merge commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 7 +++++++
 t/t3430-rebase-merges.sh | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 620a4c3a506..708b8719965 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2802,6 +2802,13 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
 
 	bases = get_merge_bases(head_commit, merge_commit);
+	if (bases && !oidcmp(&merge_commit->object.oid,
+			     &bases->item->object.oid)) {
+		ret = 0;
+		/* skip merging an ancestor of HEAD */
+		goto leave_merge;
+	}
+
 	for (j = bases; j; j = j->next)
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index dedfa09d761..37c3f73784a 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -192,4 +192,12 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
 	test_cmp expect actual
 '
 
+test_expect_success 'refuse to merge ancestors of HEAD' '
+	echo "merge HEAD^" >script-from-scratch &&
+	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
+	before="$(git rev-parse HEAD)" &&
+	git rebase -i HEAD &&
+	test_cmp_rev HEAD $before
+'
+
 test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3



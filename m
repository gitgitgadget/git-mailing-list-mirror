Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F111F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeDJMa0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbeDJMaY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:24 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Mh9yT-1et2UK1ndZ-00MHRF; Tue, 10 Apr 2018 14:30:17 +0200
Date:   Tue, 10 Apr 2018 14:30:16 +0200 (DST)
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
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 12/15] rebase --rebase-merges: avoid "empty merges"
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <83ed7db2611c092eec775b05537eaa1826b2e664.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IBXHNitII6H4k39OnWH3xF5wa1ix8yBHD0ga/Ox+zzwY2iZENL7
 Jx7rZbWbR7N9ogpi870No47XlzOYt8EVtNqlz8GxYTUsI0cd+QUvITxCATxymz2h9ZwysIU
 L5sN+3scUHHECBU8JyLZkEMVOwmhuHlqaWIsTGq3sMvbA1qsKtK7QpHG/ZGoT0H5V9xPVEB
 YnXUIG6/Er/uXdw3f9nKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:84rDgHQip8I=:mre08mknyUDdLa3zYnNAPT
 K+RR+tl4neOR4qkLpvQECRpV16in3nJXPUQpQ8k5QE+731zZnV6NyfAWBriV1FI9kYHMtmErg
 Ou4oMOJc28xCUWemDD2eO1RMBgPvXXUUzPSlrDfV/XpKdemFQlOaGEfInmf0VO9X+1DFl4hFW
 vHjhdpjOTvteLcpLCijsQw/56Gdn+7z0HHuhjVLceaJMKv/tb3jglXpk06/v0oP2jY9hmTsxQ
 bEpCmI3r9BRFuUCPX72saEZAhkiIb1HgZIweb1P4KHy/z/ircfazlmTPx+ekFNmtxUtADEi4W
 a9UMvyPd1/ciEKD7B+5D3OBHuazK5CiMO4UOmhTB+iHYa8bfpXjUGwqKo58dCRyLej4YQSt1n
 +I9u2s4UKgCINX/MZ6m2BTrE7MO48P8qhNIxHhuOh0NkxueWrNJnAhxmsbeLm462kM32HVF52
 j50rx0VetodfUWrbKEFOu0HvjJgU16Za3bDVPGvjbaUs+QhngKiay32w8OL97MWQKRC2Bb1yb
 +QarHmwyCBY5udqeQDTuF3vcDqnn7/43Erck/jx1jCBhHoH+l7IN5WWYCoq2H56P7phQHIyni
 LtMnONxahTmtKzBQT+epLE3//P5b35MCL3qWgwPWawhj9bl9pSF4KcMNpoktvx7OTLCbv07wD
 XxIjrrFTXMXOo7ThygAOnbhx/6yJvO5bW83516HhpHmpeyOtwe8t+dItdCKLc98GWrA+hBn5P
 z4cH6MaHfAVJO1AA0GjH4ersk5/i98yvYcfb4tewqFEWI4hlxfodBYsjSiCwrwYlCaAz2/uyk
 ZkqY1QcMaoB+puN5dmJ/tEH7wdmhtq+AwjpXHi/2w017Vud09s=
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
 sequencer.c              | 8 ++++++++
 t/t3430-rebase-merges.sh | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 878ff449fe8..60bad5708c6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2788,6 +2788,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
 
 	bases = get_merge_bases(head_commit, merge_commit);
+	if (bases && !oidcmp(&merge_commit->object.oid,
+			     &bases->item->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		/* skip merging an ancestor of HEAD */
+		return 0;
+	}
+
 	for (j = bases; j; j = j->next)
 		commit_list_insert(j->item, &reversed);
 	free_commit_list(bases);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 392c1136973..63faf7c2246 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -182,4 +182,12 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
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



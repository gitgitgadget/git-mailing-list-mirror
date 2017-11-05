Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874ED20281
	for <e@80x24.org>; Sun,  5 Nov 2017 16:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750782AbdKEQ2n (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 11:28:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:49966 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdKEQ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 11:28:42 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LwW8p-1d3PLs2jHz-018MFn; Sun, 05 Nov 2017 17:28:07 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
Date:   Sun,  5 Nov 2017 17:27:28 +0100
Message-Id: <20171105162730.31405-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
X-Provags-ID: V03:K0:faPqug/6NZylse3xnkd/fMfKJNyqQsUFZXJG62B5TAk9cZrqlVh
 lprbDvPGXlXReyIbsC1o4shXOQcMLfeCI6Nkgta7v6ga4Xtq2PN0LjwUjBye5WcnXhB1tv0
 pHhdoLTbJKT5qtHTBH7ReJc76R0QG7nYvXcDHwfPi/CUxe5iaMGhvfLCMWPRx8NV01CqD+G
 XbxYTQ8q7gdEeIBLrcGwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CcYkz7jA0hw=:KJ5a6j9xqop8rSaGdEhfTk
 CBgXjbZHr1Nemo+QQZ60bKtgEMHgW0oDb1HsAlqmikVUsih7eRTxm/6X09YKfxdfGifA4GxFh
 NaptwNKEFlKCjL2/jgR+P4mdp/L91k3OGFTomhJwHP6pSDjPG7wewcl2cdsK9B2dQX9Y18F4O
 dy4GFhIgM4sZbxrHAOUAapeVFAmBjeH0WzSaw9ODrd/jsMoXZsWo6IvEHgQw9wwgkEYvqw0jn
 +zp0bXaVm/w0t1lAMfkG3JRA1mr7Iqnww5FXOMz2olrQR73tWrSwAesi0/cOuHleBzk6cumLj
 Th86yb9yDPEzPA2QjzxrNxiRUm6N7D4x/9t58NA7QXR/9fYrDj0QdodJKFuazLpFwn3kTCql9
 i6N3TToAIDCWEpgDMI5YqklFvxrjg+HG0v0HalvQNUD6A5++5kSKOaIa3M2srbXMk67G3w04B
 k2eEeHrDzQAzp9BZ5v0Q7UItI2X1x6IaCjun+HtTmym3wRCcsnMijbZGI/r99Z/nq6GnH4mb2
 mf4NU94lZB4//Q9bI9f0h8GP3xIw77F0CY6Je5e+VgF3e79QFz3hXWk02JuJNbPwxrr6hNwrV
 JmGkjgaqSinJcEmpoKeE/Ug0AvVPzNV0UpVkiDNh0a4+ssAr9CTPdy2FXZxnhQPqrneaxUQWs
 GlWc6YVcbK8DT2m2vks3PJzV32d1cG3UO77aLzHANZODdFACON8ooa7SMC1pg67T5/XU98y7E
 wn41RXNditv2qdho9rq/LzJ6KvWEp322r7qIiMrldySIxCIbPtBoS/R94+itkxe4ItX6rB4hd
 iKXG8GOLRxXUkcSrHiKptz2AgL6XQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a committish, C, is immediately followed by 3dots (...) which are,
in turn, not followed by another committish, we are usually asking for
the revision range C...HEAD, which is known as the symmetric difference
of C and HEAD.

When describe_detached_head is invoked, it prints the committish
followed by 3dots as elaborated above when it indicates the current and
previous HEAD positions.  For example:

   # Randomly check out one of the first seven git.git commits
   # (Starting with a detached HEAD already)
   $ git checkout $(git rev-list master | tail -7 | shuf | head -1)
   Previous HEAD position was bfcf2d7874f7... checkout: describe_detached_head: remove 3dots after committish
   HEAD is now at 19b2860cba57... Use "-Wall -O2" for the compiler to get more warnings.

"Evaluating" this displayed pseudo-range for the current HEAD indication
resolves to the empty range (C...HEAD, where C equals HEAD).

For the previous HEAD indication, the results of the "evaluation" are
somewhat more difficult to predict: previous here refers to what the
reflog dictates (this is not necessarily the topological ancestor in the
DAG, i.e., HEAD^).  In the example above, the "range" resolves to almost
all commits in the author's clone of git.git.  Running the command again
causes the then previous to current HEAD position "range" to be a lot
smaller.

This could be confusing not only for novices; in either case, no range
should be insinuated by describe_detached_head.

Granted, this "evaluation" is at the moment, if at all, only performed
in the mind of the observer.  And, to be sure, the 3dots *are* intended
as a continuation indication for the abbreviated SHA-1 value.
Nevertheless, we should get rid of them, for the following reasons:

   * they would still be displayed if someone had their core.abbrev
     config value set to the max

   * when the built-in version of checkout was introduced by commit

        782c2d65c240 ("Build in checkout", 2008-02-07)

     no 3dots were present in the legacy git-checkout.sh (see
     contrib/examples/git-checkout.sh)

   * when git-reset causes a new HEAD line to be printed (during a hard
     reset), neither builtin/reset.c nor contrib/examples/git-reset.sh
     mention 3dots

Lest we confuse the meticulous observer, we ought to retire the 3dots in
the circumstances described above.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fc4f8fd2ea29..59cc52e55855 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -404,7 +404,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	fprintf(stderr, "%s %s... %s\n", msg,
+	fprintf(stderr, "%s %s %s\n", msg,
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
 }
-- 
2.13.6


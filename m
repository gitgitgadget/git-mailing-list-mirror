Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8184207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992760AbdD1VdO (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:33:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:55708 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992569AbdD1VdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:33:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lymoh-1e8MhO2lYF-0167t4; Fri, 28
 Apr 2017 23:33:01 +0200
Date:   Fri, 28 Apr 2017 23:32:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 09/10] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <b28721e0c7875e88e15457aa532597e5d43e7279.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NQyLDtzkwua1OPlmvMdfxk9aJQ2QCJhEMbuJzSkofn/awXpfxeu
 0SMwo21sQLPKQ3C+GLN7R9EHvZLOlvesyixeaqSvJQpX6ucFYm0Ambd6D8KRSTbjqE3Pp+Q
 pbE6oelG6Z516bVcrMxL2VUjmZdgmRqVnvcMN+x4xCwKcwU3cAqZr1DW8Dk3tlyNGmIqu/9
 fXFEjNU617WbMks5ayueg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jIa2eNmhqjA=:1EA7UdDaoFr5btXdXCGbMB
 tXv2mAU6VZMAyQemxGX+FXXHIpxEcLGmCuKrFIju2fs9HnYN1V0TEhD5Jc8rr5UefELsNWF3I
 6irojF8X2AOff2KEKBsVNQ+xmLIKXPg83s086P7BwRQF7gIyKcT8CjOrxHF1U+mCs/OiuusJp
 yYYOYVxNd7Euek6nn9lKJKz8LI32HkUWrR0hJ+96Gvrzdh0SX3fbkkFyMPaV4EphgUcY24i4A
 oiaKNlZc6gG2lfJt224Qr/KxMpPm9U6y4/eoq3NdWcjFj8bqaFzDWXhOVHwctYlzC9qLXJdwo
 8IVYzY8ELTLAwJ/GvKQqTmW57+EdJCsSx5rDmW6H2I+IhVe7gcApY8hX0XaXhrFAvpOA+uck7
 rw5D+Omym3O2OP/KfXH47nxRaUb5ZMfa9ziBze3BulbgqtjRK+J3TCwMY/aKJ/eENRngXKuTJ
 XlL//e0m26MLI8ODRLWC56DfWm9itZy78rsbg4UGdPQCXo0d/2X+GL0PfoYXw4rGulgjvhdFl
 WlHifZfdDVGZtc5+ogQWJaOOddHwdxUns2Q+g7rE/zWgeTUxj+xVNOkIVQD14iPJQ+zrKxxrv
 yysYuTU2tJNWD82yH6QFGaVl1pc9L0yTgsu0GsSUB1Yb2ee/dNrfG6e9KcH8QBTHJIPzoiP+z
 1koSYrbHb35WQRwBNjlCqCmzh4UYZDPmuQcA1qtO7iuNCJat7p+h95BsYoKIfiOFEi53VZD0A
 fKUxl0WB5gc9n+yiR3yqeEuSTP1ZX92hVdC7qxESh5tiwxStfyIsuB9in7Hi8LSbs5SWnbrwv
 ZHWZM8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git commit --fixup` command unwraps wrapped onelines when
constructing the commit message, without wrapping the result.

We need to make sure that `git rebase --autosquash` keeps handling such
cases correctly, in particular since we are about to move the autosquash
handling into the rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 6c37ebdff87..926bb3da788 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -316,4 +316,18 @@ test_expect_success 'extra spaces after fixup!' '
 	test $base = $parent
 '
 
+test_expect_success 'wrapped original subject' '
+	if test -d .git/rebase-merge; then git rebase --abort; fi &&
+	base=$(git rev-parse HEAD) &&
+	echo "wrapped subject" >wrapped &&
+	git add wrapped &&
+	test_tick &&
+	git commit --allow-empty -m "$(printf "To\nfixup")" &&
+	test_tick &&
+	git commit --allow-empty -m "fixup! To fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.12.2.windows.2.800.gede8f145e06



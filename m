Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B968F1FC19
	for <e@80x24.org>; Sun, 26 Mar 2017 07:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbdCZHMO (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 03:12:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37854 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750773AbdCZHMN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 03:12:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C81620974;
        Sun, 26 Mar 2017 03:03:07 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Sun, 26 Mar 2017 03:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mplew.is; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc:x-sasl-enc; s=fm1; bh=XeE/zHR8a/NXYOJmv+8rBwTNpU15z/
        q/lGCzO/6+zTg=; b=bVnmntmHCqwYH5Rm29Oe20K/A3KIYEppoGL4h4qHSZYK1z
        XxWO1D5wUUTdRsG0jHB8dxEaE8cES7THNcQP7KSTBWUmLNCY94LxG/s8RdFmboqu
        GpTJYk5q8vPO/WArGeTvtLXdqhplXIoJSKx4jLzru68db8cDwhEyLk7V+oZ2ysjk
        iV2cG7FKdvEwbdMZTTQZ96itcfhg0BXNju2cCyVIJDbGyo42IEvc1FJxSzV13j6G
        woGASR7RXKL88crXVDg/3M7OTsmEYBv79YGlyZ1xo44t3UAoDjfkhDRdsaKcDTEg
        x2/MjKdy4VwesfKIHHU5pzysHqqwCNd2+LJ7223w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=XeE/zH
        R8a/NXYOJmv+8rBwTNpU15z/q/lGCzO/6+zTg=; b=EnE8GXAkvxmt2VqVdS82Hi
        YuoZ4tMr/X0z1kOoHvuSX2bovRmGSuIchi21iAAtZMTf0GBc6Zlbg6PGh2tYS+hu
        A+zTPtOm0ngu4zlGDn6RP3FXFQes3L4txGf/ETyHEtZ4UNmnZwyppmAumM+WExaY
        bofvvcPYrYqO/KLxsmRS4KVJT/1iPZsqIlP7+E2X41qNInsQ8KhEzvq53EmJn4SW
        ahdzC16QGQ7Ph2b1MNCom/r3EEto+/jZ/c8ssMhXxscccH62Yr5s4pDh5S1u/J+n
        sVa91PPPCXTAvLlxZZzEQXAVqyYb+m241cMnEjY74DedqjiZB5lgnAgRfB+YL+FA
        ==
X-ME-Sender: <xms:q2fXWMFCZoetL_tJGVRpVx491KlruptnW9Z_Z6HY4tufphq69sXZfA>
X-Sasl-enc: s8IpJAeSnNcaXeyzZmS/H/tRLOWkHvYqWNUxOTMDjKjq 1490511786
Received: from localhost.localdomain (unknown [64.238.189.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id A03F82436D;
        Sun, 26 Mar 2017 03:03:06 -0400 (EDT)
From:   Mike Lewis <mike@mplew.is>
To:     git@vger.kernel.org
Cc:     "David A . Greene" <greened@obbligato.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        James Denholm <nod.helm@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Mike Lewis <mike@mplew.is>
Subject: [PATCH] contrib/subtree: add "--no-commit" flag for merge and pull
Date:   Sun, 26 Mar 2017 03:02:38 -0400
Message-Id: <20170326070238.64522-1-mike@mplew.is>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allows the user to verify and/or change the contents of the merge
before committing as necessary

Signed-off-by: Mike Lewis <mike@mplew.is>
---
 contrib/subtree/git-subtree.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..c30087485 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -29,6 +29,8 @@ onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
+ options for 'merge' and 'pull'
+no-commit     perform the merge, but don't commit
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
@@ -48,6 +50,7 @@ annotate=
 squash=
 message=
 prefix=
+commit_option="--commit"
 
 debug () {
 	if test -n "$debug"
@@ -137,6 +140,12 @@ do
 	--no-squash)
 		squash=
 		;;
+	--no-commit)
+		commit_option="--no-commit"
+		;;
+	--no-no-commit)
+		commit_option="--commit"
+		;;
 	--)
 		break
 		;;
@@ -815,17 +824,17 @@ cmd_merge () {
 	then
 		if test -n "$message"
 		then
-			git merge -s subtree --message="$message" "$rev"
+			git merge -s subtree --message="$message" "$commit_option" "$rev"
 		else
-			git merge -s subtree "$rev"
+			git merge -s subtree "$commit_option" "$rev"
 		fi
 	else
 		if test -n "$message"
 		then
 			git merge -Xsubtree="$prefix" \
-				--message="$message" "$rev"
+				--message="$message" "$commit_option" "$rev"
 		else
-			git merge -Xsubtree="$prefix" $rev
+			git merge -Xsubtree="$prefix" "$commit_option" $rev
 		fi
 	fi
 }
-- 
2.12.2


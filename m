Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ACC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB44960F46
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhJSVWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:22:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44711 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhJSVWm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 17:22:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E97A5C0194;
        Tue, 19 Oct 2021 17:20:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 19 Oct 2021 17:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=RgRUgw3bF6GRq+0lMvGgdWKD8/
        zeCNBKn/5ZtNnBR5w=; b=JWumSXpP+VimCD6vJUK/MmUtaHSvshfJ8kaCXT9GLm
        wxvfVTLatBwvujlgFCVCDUJMtnBLmpUiD6dhf3ufh2oFbZBLlwW55DEo2J0zZqmO
        cOAj3C8r7UvBzo7AO6pcl9eORluRU6Q86i7uNLMHCRSggroXsprMPyS5KCSejZXU
        VmJuwkUi8uGnRJ0CxR2gy92doNzL9tZePM76KxJ34DVoKgqPDIhZum/bzs1nFQPy
        rWdWXvMoS/qIygC53AgBOra7esGnuxjeyIc63eY4Ok/mtVQy/H0uIH0eekTh5Rnh
        NkxKwYSfgcyALR1c66RjrtQmUjqgVVNP4/wMPNVEhyqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RgRUgw3bF6GRq+0lM
        vGgdWKD8/zeCNBKn/5ZtNnBR5w=; b=YYVU1nFzrpjKzzvgwg1L20meHjL7XqMhS
        uElr+v2jFR66UG0A+1Xq0BNxvGl5m1rWq4vfhjnOPjbSCw1Hv7PiJKUSCuI6FR6H
        H6AEXZRa9YlL2F3K5CrKZa6vJTKUwsaaWE+wjfDlKHCU5jD3nOk0+pf8JkDn2qCj
        IL2ryy2Fob56Jix+DXvu58BoURh33IYlXAMYoDmFUbbdcwarwcLKEkCZMCDJzckF
        nspQam3a/3owNbWrX3HnNx2Le4iI7j/KnlTbclsP/QY2tcT7R++Ai6A05vQJayG8
        8Va/35kagFagdHNTXTGRxjaWzLBupsUax35KxlTGJnS70g41/K0pA==
X-ME-Sender: <xms:nDZvYd4RdWYjYdvjkygEIGwOJOW8cf9Ug8s8oxlV3Lh46aMn0b0Xbw>
    <xme:nDZvYa4rhBIq2_GknyosG_dDxnrwTZ5NkT6CYfaM2kdd-IZxqTJfJjleeTIIP2Nj6
    tKs7-oL6tjc82a-jw>
X-ME-Received: <xmr:nDZvYUdFTcGXFUOamKGjyMrmDmBbr_deqvM-wEfCmwPcdDnRHg1xokzWfpWoIcgObykH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohes
    uhelvddrvghuqeenucggtffrrghtthgvrhhnpeeiueevtdegtdffgeeggfeuteejkeekvd
    dvkeeiueekgfefgfeuueffgeelvdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:nDZvYWK1e26nRbSsf7uSPJvMVYaCCKlTN2LR9iteO-2YTw61mmMkyQ>
    <xmx:nDZvYRILPp7dGZR2ChJFQuIVGri9rfDPqjxzXOs9S8Qp9Qtm_hv38Q>
    <xmx:nDZvYfx-2297yLlWH8r8MSTULQb6WvHpfthXESZo6L8GU6T9KRxntg>
    <xmx:nDZvYR1IPoN2ZzGh4Jhsq_GbpVWeO6nzcVvzAWl1LppP_DbInV62Cg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 17:20:26 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
Date:   Tue, 19 Oct 2021 23:20:20 +0200
Message-Id: <20211019212020.25385-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new vimdiff4 variant of the merge-tool opens three tabs:

  - The first one contains the same panes as the standard "vimdiff" (ie.
    LOCAL, BASE and REMOTE in the top row and MERGED in the bottom row).

      ------------------------------------------
      | <TAB #1> |  TAB #2  |  TAB #3  |       |
      ------------------------------------------
      |             |           |              |
      |   LOCAL     |   BASE    |   REMOTE     |
      |             |           |              |
      ------------------------------------------
      |                                        |
      |                MERGED                  |
      |                                        |
      ------------------------------------------

      NOTE: This view is enough for 90% of the cases, but when the merge is
            somewhat complex, the three-way differences representation
            end up being messy. That is why two new tabs are added to
            show isolated one-to-one diffs.

  - The second one is a vertical diff between BASE and LOCAL

      ------------------------------------------
      |  TAB #1  | <TAB #2> |  TAB #3  |       |
      ------------------------------------------
      |                   |                    |
      |                   |                    |
      |                   |                    |
      |     BASE          |    LOCAL           |
      |                   |                    |
      |                   |                    |
      |                   |                    |
      ------------------------------------------

  - The third one is a vertical diff between BASE and REMOTE

      ------------------------------------------
      |  TAB #1  |  TAB #2  | <TAB #3> |       |
      ------------------------------------------
      |                   |                    |
      |                   |                    |
      |                   |                    |
      |     BASE          |    REMOTE          |
      |                   |                    |
      |                   |                    |
      |                   |                    |
      ------------------------------------------

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff   | 12 +++++++++++-
 t/t7610-mergetool.sh |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 96f6209a04..f830b1ed95 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -40,6 +40,16 @@ merge_cmd () {
 				"$LOCAL" "$REMOTE" "$MERGED"
 		fi
 		;;
+	*vimdiff4)
+		if $base_present
+		then
+			"$merge_tool_path" -f -d -c "4wincmd w | wincmd J | tabnew | edit $LOCAL | vertical diffsplit $BASE | tabnew | edit $REMOTE | vertical diffsplit $BASE | 2tabprevious" \
+				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+		else
+			"$merge_tool_path" -f -d -c 'wincmd l' \
+				"$LOCAL" "$MERGED" "$REMOTE"
+		fi
+		;;
 	esac
 }
 
@@ -63,7 +73,7 @@ exit_code_trustable () {
 
 list_tool_variants () {
 	for prefix in '' g n; do
-		for suffix in '' 1 2 3; do
+		for suffix in '' 1 2 3 4; do
 			echo "${prefix}vimdiff${suffix}"
 		done
 	done
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 8cc64729ad..755b4c0a4a 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -836,6 +836,7 @@ test_expect_success 'mergetool --tool-help shows recognized tools' '
 	git mergetool --tool-help >mergetools &&
 	grep vimdiff mergetools &&
 	grep vimdiff3 mergetools &&
+	grep vimdiff4 mergetools &&
 	grep gvimdiff2 mergetools &&
 	grep araxis mergetools &&
 	grep xxdiff mergetools &&
-- 
2.33.1


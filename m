Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24170C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 18:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiHGSnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 14:43:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCEE272D
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 11:43:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B7795C00A4;
        Sun,  7 Aug 2022 14:43:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 14:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659897788; x=1659984188; bh=hz
        rVUZf85PzmpZqtEYzJQ89w0rLl8IVVAIfgJSkGB7c=; b=g1fnU1lklEYJtnUize
        I5p2LveY1TwpgMRXfO3RzuayrBpak8kmGAW0zLtrIdt2xA8ttyk+wNskMNL57qM1
        v8WlxxR+iFwFT0CLNlHn4gw0UsD4uxffakQZbGb43RfXdrECwj8Cxg6m4Hq9gLql
        jOE9t7tMlx2Id90kulB6fks4WODTwc6OxVKX4P0zNyT+LFzaWV04iUwxYhIcVzkz
        ZBKQgRbYQaqJwxHXDrukmemEWbpYvd6FoahIHLRg9hbA2vOjwnFdtejc3UtZqCVD
        EjBS6hZcyuc7p7oaO8aoDiNLQWdkb+RQGOlcOn/XSmQrlTTosCeJLLkgKGf3jKKZ
        889Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659897788; x=1659984188; bh=hzrVUZf85Pzmp
        ZqtEYzJQ89w0rLl8IVVAIfgJSkGB7c=; b=sRm7Aa6nkXDGCvqvlAQl697v1b2cG
        2Vis/T3RYcYfG7QAKKYJQ3oVRjTKQWcoNCkpfgh2i5X+BW8aMmq06JoE4/x4H2IZ
        9X6yEqxr2kE1vB09ZPhpeHchNq4tcZBx9R7IQLHYVzT4COh1NL5x9+feSwAYf271
        XF4OsQD3LoErI1WT5YJKyYz49xGFF8V4tMdkqAPTGBmfjbCQPlPvU7rrXrXFEIJg
        QGVcd8nPy/1cxaFjS5c1RMyMPZTrybTewn40A8AgbrayuFarQa8JnF1jJfBZc2lB
        2Ke+NOOSfsFsa72yVL1FVR03Wo+fgyi1ZvC/ObQElM0UjtiASfDlHJPEw==
X-ME-Sender: <xms:vAfwYrv9DnJzGBtEEmWVzWhFuPsmNp67wc33VAzx4RkTbD7eCyNyrQ>
    <xme:vAfwYscmsmImQobEXi9Tq8V4W5ENHaHK4MHQJtLRrYtbBKMcpuQDllsy9OlPROk4p
    RoEqW_MEoJzFv5uxQ>
X-ME-Received: <xmr:vAfwYuykhV1EO_VUEX7_SVbu0mtLhnyQVjwr_xIMYngF9pRqYI4ikT-ttZjkLLplpiVca0mBqMWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcu
    tfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpe
    eiuedvgefgvdetteekveettdfghedutedtledvgedvffefgfffvefgueejheevueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfh
    hoohesuhelvddrvghu
X-ME-Proxy: <xmx:vAfwYqOshtqTE_J_ckZ6CZvo3E0oEuvfmyeAuhMMWfo0HzBI8iX0uA>
    <xmx:vAfwYr-3-cbAcfXRNlbwajrpMjLkASXYmtqjOaRtQ8d9SDYWT-xqqQ>
    <xmx:vAfwYqVyY5r0Dfp95j_xtGxcC5BeMxDWmVYQnHaKKDOo2CM367AZ0w>
    <xmx:vAfwYlmJexzKeu1Rckqpqki3WbVLSik4JLCI79R9zGrZHCO2stSNXw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 14:43:06 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH 2/2] vimdiff: update unit tests
Date:   Sun,  7 Aug 2022 20:43:01 +0200
Message-Id: <20220807184301.174251-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807184301.174251-1-greenfoo@u92.eu>
References: <YvAGycJR8Yq3hxOh@zacax395.localdomain>
 <20220807184301.174251-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index ee99a0b03e..651f7f99b5 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -584,22 +584,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | 4b | let tmp=bufnr('%') | execute 'silent 1,4bufdo diffthis' | execute 'buffer '.tmp\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -664,7 +664,9 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	set hidden diffopt-=hiddenoff diffopt-=closeoff
+	-c
+	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | execute 'windo diffthis'
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1


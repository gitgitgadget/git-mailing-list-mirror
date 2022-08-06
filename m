Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CEDC19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiHFSiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHFSiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 14:38:04 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6FD13B
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 11:38:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B61B43200094;
        Sat,  6 Aug 2022 14:38:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 06 Aug 2022 14:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659811082; x=1659897482; bh=ZA
        v1nv9CdXjuBAwIBRDXDbOLLA40y0bS9HuKkcKr+FU=; b=hBos0j6V+WNAY0hKsp
        v+qsx2PKKG6NhxgVZytIgWIuWWQd1bbfbFl+c0rFfLE2DBC7y5Ka/BN20D6Qzf0H
        AVsCL/En8l/aFnmc6jomiGPex8B+LFtpGbRGTr0lKvLLNddcHtgDB4asAfkkbb8Y
        ag1qL7bYfJk8E+FzFeqGTNgy67pz4jJJ5bkxmvTVhc2/EanJI5+lMG5bWlsCcTcm
        UUN0WmC40rdLG8k4BXr9u0Q8h58IxNWWBWta43YhRyYn4MDMP+tsprYhKVy1m+Dc
        VwhGhxwnEoWUKHkCy+vAPuP8cmQ2H/eiHgUNL06nezsf+UHsiw/UjklZAyV/HM/z
        HC7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659811082; x=1659897482; bh=ZAv1nv9CdXjuB
        AwIBRDXDbOLLA40y0bS9HuKkcKr+FU=; b=Mj0+eUQHURWGe/Nx28HIivN5/RqVU
        hys3VOJB9fdpXJFF3IhKG5ij/F812gl2PGzOwjF4uUz8DzfZPn9MTHSTWazOQQzh
        jwB8JJONsGG3AmBCMWnLn9QXFVztFGCc603l7Nj3m8gtW+Y/7jQOPeQOoTLFOCbC
        pFc7aynoVOI1j/hrT7ogqez7jImgNAcSdcntWjj++gZ+fiV46q+cLDaR5T9LAv1S
        jDEvzRzGlUeVPXQWUa0fS5tvv3o2v6tK3oFetvbwVIcPFJiMxT1JPwxjM1h8Cwd8
        PWWeE7tCoubxu2e/Mnt8QbP9L40FvoBm8INhXLPkhMFMqHaSnH6voQ7mQ==
X-ME-Sender: <xms:CbXuYiAv14x59_cQoX5JzqqZj-Bk02QbLHlHalIgYCnHuTgFDdUsZw>
    <xme:CbXuYsjsa8UatGJEkhtVDGWrzUhlqLzEPt10j6MGvNhOtNjvf86ZuMlHfCHP8a-bQ
    DjJRQps8_tMV7TKMA>
X-ME-Received: <xmr:CbXuYlnZb7X_1CUm4BwLPOZnv4gCg0kMhJu-nj8dZ_khra-0XLXikBw_JQcdhZOxj3JV1z-dwlYO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcu
    tfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpe
    eiuedvgefgvdetteekveettdfghedutedtledvgedvffefgfffvefgueejheevueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfh
    hoohesuhelvddrvghu
X-ME-Proxy: <xmx:CrXuYgzt1I7YVLKe1ao-vcLIBB5SKv4_Y4etkvKwy5gLzS2GcqJCAA>
    <xmx:CrXuYnR69UgewBOuTg9llDq56DdApVmGTNy9KqNQ7DuZFJZqHkHf5w>
    <xmx:CrXuYrb3X5ha6QxOvJu2P2VkfOXGlgCp251B4nq3obz8mswGlxCxFA>
    <xmx:CrXuYuINwHqxHIz3wi-reLfpomtBMvuyOouIZgDGCALT2ILKNmJGpA>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 14:38:00 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH] vimdiff: fix 'vimdiff3' behavior (colors + no extra key press)
Date:   Sat,  6 Aug 2022 20:37:57 +0200
Message-Id: <20220806183757.72168-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <Yu6zEiknXKFMJUVn@zacax395.localdomain>
References: <Yu6zEiknXKFMJUVn@zacax395.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

vimdiff3 was introduced in 7c147b77d3 (mergetools: add vimdiff3 mode,
2014-04-20) and then partially broken in 0041797449 (vimdiff: new
implementation with layout support, 2022-03-30) in two ways:

  - It does not show colors unless the user has "set hidden" in his
    .vimrc file

  - It prompts the user to "Press ENTER" every time it runs.

This patch fixes both issues by adding "set hidden" and "silent" to the
generated command string that is used to run vim.

Cc: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..461b8f394f 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -261,19 +261,19 @@ gen_cmd_aux () {
 
 	if test "$target" = "LOCAL"
 	then
-		CMD="$CMD | 1b"
+		CMD="$CMD | silent 1b"
 
 	elif test "$target" = "BASE"
 	then
-		CMD="$CMD | 2b"
+		CMD="$CMD | silent 2b"
 
 	elif test "$target" = "REMOTE"
 	then
-		CMD="$CMD | 3b"
+		CMD="$CMD | silent 3b"
 
 	elif test "$target" = "MERGED"
 	then
-		CMD="$CMD | 4b"
+		CMD="$CMD | silent 4b"
 
 	else
 		CMD="$CMD | ERROR: >$target<"
@@ -310,7 +310,7 @@ gen_cmd () {
 	#
 	#     gen_cmd "@LOCAL , REMOTE"
 	#     |
-	#     `-> FINAL_CMD    == "-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	#     `-> FINAL_CMD    == "-c \"echo | leftabove vertical split | silent 1b | wincmd l | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
 	#         FINAL_TARGET == "LOCAL"
 
 	LAYOUT=$1
@@ -341,9 +341,9 @@ gen_cmd () {
 
 	if echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
-		CMD="$CMD | tabdo windo diffthis"
+		CMD="$CMD | set hidden | silent tabdo windo diffthis"
 	else
-		CMD="$CMD | bufdo diffthis"
+		CMD="$CMD | set hidden | silent bufdo diffthis"
 	fi
 
 
@@ -555,22 +555,22 @@ run_unit_tests () {
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
+	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | silent 1b | wincmd l | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 4b | wincmd l | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | silent 4b | set hidden | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"echo | leftabove split | silent 1b | wincmd j | leftabove split | silent 4b | wincmd j | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | silent 1b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | silent 4b | wincmd l | leftabove split | silent 1b | wincmd j | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"echo | leftabove split | silent 4b | wincmd j | leftabove vertical split | silent 1b | wincmd l | silent 3b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"echo | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 2b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 2b | wincmd l | leftabove vertical split | leftabove split | silent 1b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"echo | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | silent 2b | wincmd l | silent 1b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | set hidden | silent tabdo windo diffthis\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -635,7 +635,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent quit | wincmd l | silent 2b | wincmd j | silent 3b | set hidden | silent tabdo windo diffthis
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1


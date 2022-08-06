Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5CC19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 21:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiHFVaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiHFVaS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 17:30:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17325D2
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 14:30:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E018E32000F9;
        Sat,  6 Aug 2022 17:30:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 06 Aug 2022 17:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659821415; x=1659907815; bh=4o
        TUKw8vfHSHT3mzmFYGj5QOdXd8mVE3FE5ZAYaM8q0=; b=hlqFufudxXAFvBM4RU
        rXV5FoFscGZ1koeltLRLYE2/HIHVawI8M2OyM9/PjaUeAIzXaFITIfFbw0i4raBf
        5QNyHRZkvstjFZQW/nGH3itSmvBPRqZQxtMT/GseaPsq5J0iH4QrBytugysTSKtS
        qj6qPdrVih7owbwzhiOmvvSPJkFCQKphNV318bnikQcEbryPmM3ZcCaxHXHH/Hqh
        NmYyD+/CTu4VOjYxSOiR4OLAvDliwV8RVPKCa7yo9GWQUAcFMM11uDO23jsj2nG4
        awjzefrlY88HoNcDz2g8t9CJy5JvfCromugD5Sss64KaZbIoBnNqAV3yUBSpgrOQ
        AogA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659821415; x=1659907815; bh=4oTUKw8vfHSHT
        3mzmFYGj5QOdXd8mVE3FE5ZAYaM8q0=; b=V4TC0wt/JgF60hfYMg/Qy8lze6QCU
        VTTotzoL4plPxNZTUg8F20V7pb2C0aouSumynbfMG6mvd2O0zzLT1EWMuqD/d65I
        hKV3O+cgPE7hdR+hqWMW6gJ9o1JGiwuvSeIHqKmx/wwxbxLtldCRt6LR3+IRbOW1
        mZsHSUBOcoxCtqAx4vnxUJSCyRyj617jNCG896yo6ednKdsvqwExxNcIxtHgu+C2
        3Sn9tO5aE6AhPqqnAiA8AgFRPGj1hNy+ZJxvB/rJaRDUEkpaPXRUB+Idwo8QVIWS
        6gxB4CB5hiY/we9HrpdI+75c/ISJrLQng4X/pJsiEPZdin7BUEvG4j6Tw==
X-ME-Sender: <xms:Z93uYjwH9-ecSo62bVfwTOs79j3lNA19K8oyCI7WE9pcN8oe7znKhg>
    <xme:Z93uYrQY9K_cZzp9GIJERx2b6VLTNrEtyHcc7AYzF_3uIxETjhZt8SD5IwDZVPJoA
    JHRGiRVRPMmRDZHrQ>
X-ME-Received: <xmr:Z93uYtWUcA407B6nYwwJDsVvJsvtuKzE5hItQSOjeU9PdEV1Dlmm8dzOSIgR9bFaS5cNuHDDAi_y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefgecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhho
    shcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeelfeefvd
    dvfeduueelteevledvveetteduvdekgfffjedvgfduudffgeefudeuffenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:Z93uYtgo5nrDmEzpH81-diaJEWFNb2vsveP4mj8mdxDk6jGJv81OfQ>
    <xmx:Z93uYlA4FVA_IXAazB5pNsAG4UfCxbkoYre9dDDWX8Je2lkSj17E1Q>
    <xmx:Z93uYmJ2R_SvG-akPmuAFKeMkMQIqHusraRXOYukjuuNXGkt-gjFpw>
    <xmx:Z93uYi53mPUUnBh_Kiz_1HLHBfh9E97fqvKK6qlKvD3XOrIHWvs8Ew>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 17:30:13 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH] vimdiff: fix 'vimdiff3' behavior (colors + no extra key press)
Date:   Sat,  6 Aug 2022 23:30:05 +0200
Message-Id: <20220806213005.92045-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <Yu7ccuxYATwsJ7CF@zacax395.localdomain>
References: <Yu7ccuxYATwsJ7CF@zacax395.localdomain>
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
 mergetools/vimdiff | 65 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..238963071a 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,8 +29,8 @@
 ################################################################################
 
 debug_print () {
-	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
-	# to "true"
+        # Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF_DEBUG
+        # is set to "true"
 
 	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
 	then
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
@@ -341,17 +341,18 @@ gen_cmd () {
 
 	if echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
-		CMD="$CMD | tabdo windo diffthis"
-	else
-		CMD="$CMD | bufdo diffthis"
-	fi
+		CMD="$CMD | set hidden | silent tabdo windo diffthis"
 
+		# Add an extra "-c" option to move to the first tab (notice that we
+		# can't simply append the command to the previous "-c" string as
+		# explained here: https://github.com/vim/vim/issues/9076
 
-	# Add an extra "-c" option to move to the first tab (notice that we
-	# can't simply append the command to the previous "-c" string as
-	# explained here: https://github.com/vim/vim/issues/9076
+		FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
+	else
+		CMD="$CMD | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp"
 
-	FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
+		FINAL_CMD="-c \"$CMD\""
+	fi
 }
 
 
@@ -555,22 +556,22 @@ run_unit_tests () {
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
+	EXPECTED_CMD_04="-c \"echo | silent 4b | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp\""
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
@@ -635,7 +636,7 @@ run_unit_tests () {
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


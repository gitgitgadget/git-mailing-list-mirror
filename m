Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC5C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 16:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiHFQ1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiHFQ1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 12:27:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8910576
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 09:27:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F6B75C002F;
        Sat,  6 Aug 2022 12:27:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 12:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659803254; x=1659889654; bh=GF2PndHS/X
        8u7zH3rjCSkwgil7Rw8MRdPP9Tm/xKVf0=; b=sJVrAyKq4IJcUS7p2koJycSpGs
        UoBz0c2cvkYM+rpj/c9ODPHYCJUoNCtZlgT1TcwhZil+dshTsADti3SQorGNf4Yw
        3+JJhM5v/WgDOaIoh92St/yNNyxNBd8yPBUenhH9hIAthwuKmfoWog22Xmhif3au
        grHmngmsJGeD8fZ1bEmetzlDAxUB80N3ewlczgp+YWDOVE7ltDLFokyg79oxjN0l
        nlRPKJps2Fw8X9TdyLYI2i+POX0Grw+e5W7hdiWRWF3wPpS5YXDxb0nk6PbmDYNw
        aqizmzlSsVYnUdcTmSoNceGRchcza+esZfKM+Y9LGD7Ln6pTBwTKk3hbSlpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659803254; x=1659889654; bh=GF2PndHS/X8u7zH3rjCSkwgil7Rw
        8MRdPP9Tm/xKVf0=; b=jee0YHuCvebutQ67DLsiYWg/x4VN4uquuQsQpR0P1pps
        cliKwqyAAMefnxG/GKOAxnHMbaXS/NmmLbKmQ/on8tATyYOK2AVz8NZydWLKKT/a
        qC4GpVCJxmFN4pMxwYNI/IBXJ6DSgz24Wof1J+9QscTzdRQhLH5kvoCqCjxch4CL
        h1P2P7WStJQE8RGtLtDiyNzUiIC4cUb4onBFyoIiIE53Ob1bs8oi7sJhCcKihH6S
        lbMWJ83SSZ9w+NJgB87ebQGwvqHMmGKJdgh5aCDZC70OZIUm1jvliT8Qa7W7onf+
        JCkaEZDwuxsaysV0I+zYtAHo1N76VwGKbB8zH4B6Dg==
X-ME-Sender: <xms:dZbuYqKMyHdP3dhBi5wR98xVrUkF_deCkpMQu68Jm2tfYSKjP4kCtg>
    <xme:dZbuYiKJC5i_z8nl4ua8OtgNAeI7Xs910BV41tpgOJPTZEn_0NhfUauebHjRNsVIK
    eCUyP1W9_aGT0tRcg>
X-ME-Received: <xmr:dZbuYqtH1vj2guf3-PVY_IfOP7YKUbrMlTUUpFK2kHrDSXXKLGXbUGGV0-iarrMH1b6W6dF8mCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:dZbuYvaRJxgS1-kIdIw4O1IvOQY3wpQs3f9OjW2eDkwc1jiQvxvtCQ>
    <xmx:dZbuYhbuB_UptqKPa6PEWCFcQLz6hmNJpqEhLUWnAo_fI3doMp82-Q>
    <xmx:dZbuYrC_doV71EjoxxfAb4BpC5bWeYRB9VsZ-bHRFOrtjkrtQw3W5g>
    <xmx:dpbuYiCPJuN5-J3u3ghaK_DJd9wOK_6HcJaSt9Tg_scDtGZ-JoHYtw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 12:27:32 -0400 (EDT)
Date:   Sat, 6 Aug 2022 18:27:29 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
Message-ID: <Yu6WcRM7NNVXjt5D@zacax395.localdomain>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
 <Yu6V4cIajhoMhB3t@zacax395.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yu6V4cIajhoMhB3t@zacax395.localdomain>
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
index f770b8fe24..a64134364c 100644
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
+	#     `-> FINAL_CMD    == "-c \"echo | leftabove vertical split | silent 1b | wincmd l | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
 	#         FINAL_TARGET == "LOCAL"
 
 	LAYOUT=$1
@@ -341,9 +341,9 @@ gen_cmd () {
 
 	if echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
-		CMD="$CMD | tabdo windo diffthis"
+		CMD="$CMD | silent tabdo windo diffthis"
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
+	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | silent 1b | wincmd l | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 4b | wincmd l | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | silent 4b | set hidden | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"echo | leftabove split | silent 1b | wincmd j | leftabove split | silent 4b | wincmd j | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | silent 1b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | silent 4b | wincmd l | leftabove split | silent 1b | wincmd j | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"echo | leftabove split | silent 4b | wincmd j | leftabove vertical split | silent 1b | wincmd l | silent 3b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"echo | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 2b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | silent 1b | wincmd l | silent 3b | wincmd j | silent 2b | wincmd l | leftabove vertical split | leftabove split | silent 1b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"echo | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | silent 2b | wincmd l | silent 1b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"echo | -tabnew | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent 2b | wincmd l | silent 3b | wincmd j | silent 4b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 1b | tabnext | -tabnew | leftabove vertical split | silent 2b | wincmd l | silent 3b | tabnext | leftabove vertical split | leftabove split | silent 1b | wincmd j | leftabove split | silent 2b | wincmd j | silent 3b | wincmd l | silent 4b | silent tabdo windo diffthis\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -635,7 +635,7 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	echo | leftabove split | leftabove vertical split | silent 1b | wincmd l | leftabove vertical split | silent quit | wincmd l | silent 2b | wincmd j | silent 3b | silent tabdo windo diffthis
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1


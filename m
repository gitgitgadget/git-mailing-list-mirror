Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EAC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 05:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiHHFfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 01:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiHHFfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 01:35:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02A527B
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 22:35:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1BF493200302;
        Mon,  8 Aug 2022 01:35:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Aug 2022 01:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659936910; x=1660023310; bh=21
        GZPtRIO+8QAAS9/NQ6Il7S3f+a9uv7fAhdDyET9oc=; b=L25STkZ5qlS7Qn+SL/
        gdXOzMaQvs5WHZcgtgIiYgdeJRHoVPX+udRI2/Ctc6fOPJ4M20Qd/0RZwEFExlLY
        MgkmEiTSEtx6rLw/VOBlIDsmaDev4UoQMgVGsZAJQWQK8oj70++GlYon326C/mBH
        M8cvUP7wDs13XlvgXVpFtDVdHWDiFiQQaqpBKaYGxyAG9czd+8VpFrD9Q2AwHGj3
        +XjcLiZihGXI9o5j2QtbxdHbk7sdCEiWwgur2neetxLI5P/sUJyUO9lIr2Ig+V0y
        QpiQqoZ5x6I3gYPMUgQFDfRlspeeQKeSpULGF+sixJuKq9r4zme8+vdiKSvfKrpK
        bO2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659936910; x=1660023310; bh=21GZPtRIO+8QA
        AS9/NQ6Il7S3f+a9uv7fAhdDyET9oc=; b=hTGXfXkn3nGRUfIWLwAPI1l/rEJDC
        KUnTuUkB9WA0pInMWZ6g0nDYXfzd4FsClQY9emefHPpNNsQmASO/YSd648l9BdRL
        OaBKEuktM5Ooqz2djvto/cO1sINljLPMFY4Th7Cs4FZwa393p9xhRaZO8rxQEVrj
        2+GTzTV2x4wLXkvqb6kOfF2fOP23uw0yGzz5SkyamRkvrOWowixhkKZ5fW4jSajw
        fUqroNj6Qh27HDPdXlhakftTM6GRPUFqREIU7MicLP3vdrozUXI7zSxj9dQFeRM0
        4FbLfONo2t2PPUKRSi+VUVuQ0lWnTnr0UmAyWOJCDLnSKjK40LbIr9EBw==
X-ME-Sender: <xms:jqDwYoytcQMbaWlFsltfRCgmhT4141AE0SC3CYtq5jXywTicTza4PA>
    <xme:jqDwYsTIWEaNhTBm9CM_WO9eOSpl7cTHcHxECT3VyfJQ-Onv0ZTuLn6iOg1XnYDmr
    FFvcdRAheJ2oXcyhg>
X-ME-Received: <xmr:jqDwYqXrPbz8g3yq-MXXVdogp7-PyniFMb-M0d7KFA-MT2M1O5oNWrt0uy9iDR2ByS_wKLgxjIYJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhephfgvrhhnrghnughoucft
    rghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnheple
    effedvvdefudeuleetveelvdevteetuddvkefgffejvdfgudduffegfeduueffnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:jqDwYmj_El-yq9aoYqyMTh1b8H1bMf3HUq1GykCLdaWdA5dcI_bR0w>
    <xmx:jqDwYqDzsWwtvRkkIhrC6FzBzva3AnS6_rp_ndXyvTXKzV1h3cVIig>
    <xmx:jqDwYnIXDQHMipRCEvW41Gih7DkMvbGP62qm_EygYpwp6uN_25J_mw>
    <xmx:jqDwYr6Pc6sBO3f3uEzIPbO63csIU831nQA5DHtBfCGlYTCCkY0kgQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 01:35:09 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single window mode and colors
Date:   Mon,  8 Aug 2022 07:34:58 +0200
Message-Id: <20220808053459.184367-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808053459.184367-1-greenfoo@u92.eu>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu>
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

This patch fixes both issues and, in adition:

  - Unifies the previously "special" case where LAYOUT contained one single tab
    with one single window.

  - Fixes colors in tabs with just one window.

Cc: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 69 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index ea416adcaa..f8cd7a83f0 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -55,12 +55,40 @@ substring () {
 	echo "$STRING" | cut -c$(( START + 1 ))-$(( START + $LEN ))
 }
 
+enable_diff_mode () {
+	# Auxiliary function that appends extra vim commands at the end of each
+	# tab section to enable diff mode
+
+	NUMBER_OF_WINDOWS_IN_TAB=$1
+
+	if test "$NUMBER_OF_WINDOWS_IN_TAB" -eq 1
+	then
+		# Tabs that only contains one window will "diff"
+		# against all loaded/hidden buffers
+
+		echo "let tmp=bufnr('%') | execute 'silent 1,4bufdo diffthis' | execute 'buffer '.tmp"
+	else
+		# Tabs that contain more than one window will
+		# only "diff" against those windows
+
+		echo "execute 'windo diffthis'"
+	fi
+}
+
 gen_cmd_aux () {
 	# Auxiliary function used from "gen_cmd()".
 	# Read that other function documentation for more details.
+	#
+	# This function returns two items
+	#    - STDOUT:  The vim command to use
+	#    - RETCODE: The number of windows opened in the current tab
 
-	LAYOUT=$1
-	CMD=$2  # This is a second (hidden) argument used for recursion
+	WINDOWS_NR=$1 # Number of windows opened in the current tab after
+	              # having parsed the provided "LAYOUT"
+	              # If applicable, this variable will be updated and
+	              # returned in RETCODE
+	LAYOUT=$2     # Substring (from the original LAYOUT) to process
+	CMD=$3        # This is a third (hidden) argument used for recursion
 
 	debug_print
 	debug_print "LAYOUT    : $LAYOUT"
@@ -232,6 +260,7 @@ gen_cmd_aux () {
 		after="wincmd j"
 		index=$index_horizontal_split
 		terminate="true"
+		WINDOWS_NR=$(( WINDOWS_NR + 1 ))
 
 	elif ! test -z "$index_vertical_split"
 	then
@@ -239,16 +268,27 @@ gen_cmd_aux () {
 		after="wincmd l"
 		index=$index_vertical_split
 		terminate="true"
+		WINDOWS_NR=$(( WINDOWS_NR + 1 ))
 	fi
 
 	if  test "$terminate" = "true"
 	then
 		CMD="$CMD | $before"
-		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$start" "$(( index - start ))")" "$CMD")
+		CMD=$(gen_cmd_aux $WINDOWS_NR "$(substring "$LAYOUT" "$start" "$(( index - start ))")" "$CMD")
+		WINDOWS_NR=$?
+
+		if ! test -z "$index_new_tab"
+		then
+			CMD="$CMD | $(enable_diff_mode $WINDOWS_NR)"
+			WINDOWS_NR=1
+		fi
+
 		CMD="$CMD | $after"
-		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$(( index + 1 ))" "$(( ${#LAYOUT} - index ))")" "$CMD")
+		CMD=$(gen_cmd_aux $WINDOWS_NR "$(substring "$LAYOUT" "$(( index + 1 ))" "$(( ${#LAYOUT} - index ))")" "$CMD")
+		WINDOWS_NR=$?
+
 		echo "$CMD"
-		return
+		return $WINDOWS_NR
 	fi
 
 
@@ -280,10 +320,9 @@ gen_cmd_aux () {
 	fi
 
 	echo "$CMD"
-	return
+	return $WINDOWS_NR
 }
 
-
 gen_cmd () {
 	# This function returns (in global variable FINAL_CMD) the string that
 	# you can use when invoking "vim" (as shown next) to obtain a given
@@ -333,25 +372,15 @@ gen_cmd () {
 
 	# Obtain the first part of vim "-c" option to obtain the desired layout
 
-	CMD=$(gen_cmd_aux "$LAYOUT")
-
-
-	# Adjust the just obtained script depending on whether more than one
-	# windows are visible or not
-
-	if echo "$LAYOUT" | grep ",\|/" >/dev/null
-	then
-		CMD="$CMD | tabdo windo diffthis"
-	else
-		CMD="$CMD | bufdo diffthis"
-	fi
+	CMD=$(gen_cmd_aux 1 "$LAYOUT")
+	CMD="$CMD | $(enable_diff_mode $?)"
 
 
 	# Add an extra "-c" option to move to the first tab (notice that we
 	# can't simply append the command to the previous "-c" string as
 	# explained here: https://github.com/vim/vim/issues/9076
 
-	FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
+	FINAL_CMD="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"$CMD\" -c \"tabfirst\""
 }
 
 
-- 
2.37.1


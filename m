Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D61C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 18:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiHGSnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 14:43:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF3B272D
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 11:43:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FCD85C00A7;
        Sun,  7 Aug 2022 14:43:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 14:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659897786; x=1659984186; bh=46
        /EteGm6im/quohN5ASqqNdTABvvcsUf3bHdQJtMho=; b=cXe/a1+We2eKiXeF7e
        mIGIYKNvNYMgsLI2JXY7oZLORZt0rLKjFec63MUU/oEFG1xI9UloX2aZOVGuA4JD
        Q0qaOmrjrfLj3KyHR1GadgxB6RKY9cWutvdTdbvMICk87eQcWInoC7ioPqr6A3RB
        kIBCokY2qv0M3zcapiEIH4h1ov2tRQXClQzG7+XDsZ/1xSOdKE2XERC+eS3IXQPZ
        GnkkRmhPNUQtrpzg/Qirr30ogd9koYH20YDnXcP8ueeqPdRBkK1+DJgxlmzG7vAG
        Jmt1hbW3TJz+F+KZ5px+6a7sqFbKlC3oR1Y5ROpWNpAX0gC0XIqk/6JrZQPhqa/C
        34Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659897786; x=1659984186; bh=46/EteGm6im/q
        uohN5ASqqNdTABvvcsUf3bHdQJtMho=; b=bomsCYESxXXFqAYdJyiEOWt9Cxy+1
        2cSdz/BipTf6Ux30i3etBzyj8vump2gdw/BaxhAwIOKLfqMYjOJuJwyxZz5T1t3z
        40eadyuUUW1OH/ZRhMt3TPW2ppMp0Bh+/cCAWlsqW8BhPVDqdR8zsincv9NHwFtX
        gx7fVCmVq8lrPHAY/zp5yFhZ1ARkipmlZX46nuTmuxrJVCyqBcEe3CFIzYwSREPF
        O55iRvfDVSTEwligvGUSOpPSRL72eWcFkjHR3SL+cZ4uDXtBuaqyPkY1q7iwzEDT
        rcqdxoRwhm4WCBJW5RZa8q9t/rYSyDOkox5vHoizicm2hqkQs6Hc7E4NA==
X-ME-Sender: <xms:ugfwYujMnQXg3MJabfh2zfXsQgirIMu3QcT9GrfDP-OsV3wDBzTa3g>
    <xme:ugfwYvDKHoh8HuZ5Q6nXH5rgRhln-3WKjPm9zDa1KRBk3b5oK0CsSPg0xZNoW_qne
    VU4-YsuI1oSwT8LKg>
X-ME-Received: <xmr:ugfwYmFgEMxlEJOPQ8GyxeKPETdTXxErMISEwQk88oU37nH6meGg-8UnxuuxS7pOvQyIhECm3dQm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcu
    tfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpe
    elfeefvddvfeduueelteevledvveetteduvdekgfffjedvgfduudffgeefudeuffenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:ugfwYnSb39XjsCT4SZ0DkZYfozs1C6JNqRicBRfvZ_Hay7sfa6Jk5Q>
    <xmx:ugfwYrwsExnoNoaJ3Wd6zEt_q2dHC1t9jDTWLvs9MPRoFEXpjhFYMQ>
    <xmx:ugfwYl6Qka0q3mT1UsC4JrBv-jQ66QENaFCKG9UUvnyllDc7-YrAbg>
    <xmx:ugfwYkohexJGyeMaOTuYIoIbokAGNtDUKsoW4iW9ZUYJ9MqGbkby9w>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 14:43:05 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH 1/2] vimdiff: fix single tab mode, single window mode and colors
Date:   Sun,  7 Aug 2022 20:43:00 +0200
Message-Id: <20220807184301.174251-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <YvAGycJR8Yq3hxOh@zacax395.localdomain>
References: <YvAGycJR8Yq3hxOh@zacax395.localdomain>
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
index f770b8fe24..ee99a0b03e 100644
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
+        #    - RETCODE: The number of windows opened in the current tab
 
-	LAYOUT=$1
-	CMD=$2  # This is a second (hidden) argument used for recursion
+	WINDOWS_NR=$1 # Number of windows opened in the current tab after
+	              # having parsed the provided "LAYOUT"
+                      # If applicable, this variable will be updated and
+                      # returned in RETCODE
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


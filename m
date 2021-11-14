Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717EFC433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3896960FE3
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhKNRl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:41:26 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42031 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234325AbhKNRlX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Nov 2021 12:41:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 66ACB32009DF;
        Sun, 14 Nov 2021 12:38:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 14 Nov 2021 12:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=nVXUGaEK/cLgV
        j6bNVG7rvLuEFJdqeuan2JEGDYCiIw=; b=EbgGPY9t3TyogtQRvD5kcK0zUySjU
        EcmJWPzZw+0XHmULxDs5zZWKFtofUcAFKIthar/aPTw/Fn1Kcx05NHJWpKtg6R8b
        qEj19tVIC6v0FKzMyBdVcIOaK5aJLKQZq3zyxW1HonBlIDsVj4wjrwa16o4GKq9d
        ZPmyrQgABzBhmRlaC/2PmWbGX3PIulkQthvlau98Bx4Jk2zVDPxIfZ625Ua3Lkdy
        pu5TdDzKPnn/Dy6wSFp5qlSvcG9Ck5LlWe3BvxyuEOdwhyRVpz6sqg/bvaUXDlBO
        Kx0OInY8H+iQVOwth9nw3LiSp/FAbDnLc4E36yBvbIWfxCJvOoQLV1tPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=nVXUGaEK/cLgVj6bNVG7rvLuEFJdqeuan2JEGDYCiIw=; b=GnErRciu
        uPX9nsCQx8BClt1KrLtF+4DjwOn5tQBT6aW/VozjRngk0jpTNcz024IIW59DehgS
        cmbzsTLFCxbyWqh1eQaNaLnk3sBy9zIfVRelibuOGuC2FVDGtJmVQ821AU0aIFDE
        pucLD+4MgY3eSP6D7NEFK/Q7fkQZ+V4yRWHw+uknhdx2UU+Kj1ovbrC9PoDGlktA
        5dOqY+PeTVj1xTvhRdjP6UySTHKVSv0PBNys37fzxBVFYxnuW6lWIZatILcZYN6K
        OXi1YIGuV66MY9F/NyeStWaVHFfGRP7cTl5UtO3q4F4JAHQQRHZbcTPpUbW66+ZF
        tgRAF18l9PbQxA==
X-ME-Sender: <xms:lEmRYW2BaXspq1x_xHbz28-9B304VdNWIOKIT23xklckmoAFuAFE1Q>
    <xme:lEmRYZElpnTP1FPC5Zkych4yNlHyH-YnjXJg_-lOxQQkmG8jfetyrwf-SYgFvTY-6
    pVGaaZRTe2vkNWKZQ>
X-ME-Received: <xmr:lEmRYe6cikeKIGuli9T8V8vUSfETEYK_ZdcL-x2Wa9ZmJyEuX865iz4PrMLckhRGkqlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdejgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepueehleekjeejtedviefhueffieehud
    etgeefffekhefgffeludfguefhkeeuiedunecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhdpshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:lEmRYX0RTlPKwXVS3jeZkKRR8EDxyEFdSSRoHVSjvW5A60MWecri9A>
    <xmx:lEmRYZGEc12UG9IWyDnp5lM1EZuygW5jYxIdvsNK_YNeHboHES_Vfg>
    <xmx:lEmRYQ9U3AeTdhpsz1xnFI-ng0KZ74tFsWbFpsdKdGmZFUvMSrH9sA>
    <xmx:lUmRYSNaFoWeFwnRV5bBTl0vK7uiTUq1cyrZnr3ZpnxCrRK4DThOHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Nov 2021 12:38:27 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v2 1/2] vimdiff: new implementation with layout support
Date:   Sun, 14 Nov 2021 18:38:19 +0100
Message-Id: <20211114173820.687467-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114173820.687467-1-greenfoo@u92.eu>
References: <20211114173820.687467-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git mergetool -t vimdiff', a new configuration option
('mergetool.vimdiff.layout') can now be used to select how the user
wants the different windows, tabs and buffers to be displayed.

If the option is not provided, the layout will be the same one that was
being used before this commit (ie. two rows with LOCAL, BASE and COMMIT
in the top one and MERGED in the bottom one).

The 'vimdiff' variants ('vimdiff{1,2,3}') still work but, because they
represented nothing else than different layouts, are now internally
implemented as a subcase of 'vimdiff' with the corresponding
pre-configured 'layout'.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 562 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 535 insertions(+), 27 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 96f6209a04..c7b3cf84a2 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -1,48 +1,538 @@
+#!/bin/bash
+
+# This script can be run in two different contexts:
+#
+#   - From git, when the user invokes the "vimdiff" merge tool. In this context
+#     this script expects the following environment variables (among others) to
+#     be defined (which is something "git" takes care of):
+#
+#       - $BASE
+#       - $LOCAL
+#       - $REMOTE
+#       - $MERGED
+#
+#     In this mode, all this script does is to run the next command:
+#
+#         vim -f -c ... $LOCAL $BASE $REMOTE $MERGED
+#
+#     ...where the "..." string depends on the value of the
+#     "mergetool.vimdiff.layout" configuration variable and is used to open vim
+#     with a certain layout of buffers, windows and tabs.
+#
+#   - From the shell, manually. This is only expected to be done by developers
+#     who are editing this script. When this happens, the script runs a battery
+#     of unit tests to make sure nothing breaks.
+#     In this context this script does not expect any particular environment
+#     variable to be set.
+#
+
+
+
+################################################################################
+## Internal functions (not meant to be used outside this script)
+################################################################################
+
+debug_print() { 
+	# Send message to stderr if global variable DEBUG is set to "true"
+
+	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
+	then
+		>&2 echo "$@"
+	fi
+}
+
+substring() {
+	# Return a substring of $1 containing $3 characters starting at
+	# zero-based offset $2.
+	# 
+	# Examples:
+	#
+	#   substring "Hello world" 0 4  --> "Hell"
+	#   substring "Hello world" 3 4  --> "lo w"
+	#   substring "Hello world" 3 10 --> "lo world"
+
+	STRING=$1
+	START=$2
+	LEN=$3
+
+	echo "$STRING" | cut -c$(( $START + 1 ))-$(( $START + $LEN))
+}
+
+gen_cmd_aux() {
+	# Auxiliary function used from "gen_cmd()".
+	# Read that other function documentation for more details.
+
+	LAYOUT=$1 
+	CMD=$2  # This is a second (hidden) argument used for recursion  
+
+	debug_print
+	debug_print "LAYOUT    : $LAYOUT"
+	debug_print "CMD       : $CMD"
+
+	if test -z "$CMD"
+	then
+		CMD="echo" # vim "nop" operator
+	fi
+
+	start=0
+	end=${#LAYOUT}
+
+	nested=0
+	nested_min=100
+
+
+	# Step 1:
+	#
+	# Increase/decrease "start"/"end" indices respectively to get rid of
+	# outer parenthesis.
+	#
+	# Example:
+	#
+	#   - BEFORE: (( LOCAL , BASE ) / MERGED )
+	#   - AFTER :  ( LOCAL , BASE ) / MERGED 
+
+	oldIFS=$IFS
+	IFS=#
+	for c in $(echo "$LAYOUT" | sed 's:.:&#:g')
+	do
+		if test "$c" = " "
+		then
+			continue
+		fi
+
+		if test "$c" = "("
+		then
+			nested=$(( $nested + 1 ))
+			continue
+		fi
+
+		if test "$c" = ")"
+		then
+			nested=$(( $nested - 1 ))
+			continue
+		fi
+
+		if test "$nested" -lt "$nested_min"
+		then
+			nested_min=$nested
+		fi
+	done
+	IFS=$oldIFS
+
+	debug_print "NESTED MIN: $nested_min"
+
+	while test "$nested_min" -gt "0"
+	do
+		start=$(( $start + 1 ))
+		end=$(( $end - 1 ))
+
+		start_minus_one=$(( $start - 1 ))
+
+		while ! test "$(substring "$LAYOUT" "$start_minus_one" 1)" = "("
+		do
+			start=$(( $start + 1 ))
+			start_minus_one=$(( $start_minus_one + 1 ))
+		done
+
+		while ! test "$(substring "$LAYOUT" "$end" 1)" = ")"
+		do
+			end=$(( $end - 1 ))
+		done
+
+		nested_min=$(( $nested_min - 1 ))
+	done
+
+	debug_print "CLEAN     : $(substring "$LAYOUT" "$start" "$(( $end - $start ))")"
+
+
+	# Step 2:
+	#
+	# Search for all valid separators ("+", "/" or ",") which are *not*
+	# inside parenthesis. Save the index at which each of them makes the
+	# first appearance.
+
+	index_new_tab=""
+	index_horizontal_split=""
+	index_vertical_split=""
+
+	nested=0
+	i=$(( $start - 1 ))
+
+	oldIFS=$IFS
+	IFS=#
+	for c in $(substring "$LAYOUT" "$start" "$(( $end - $start ))" | sed 's:.:&#:g');
+	do
+		i=$(( $i + 1 ))
+
+		if test "$c" = " "
+		then
+			continue
+		fi
+
+		if test "$c" = "("
+		then
+			nested=$(( $nested + 1 ))
+			continue
+		fi
+
+		if test "$c" = ")"
+		then
+			nested=$(( $nested - 1 ))
+			continue
+		fi
+
+		if test "$nested" = 0
+		then
+			current=$c
+			
+			if test "$current" = "+"
+			then
+				if test -z "$index_new_tab"
+				then
+					index_new_tab=$i
+				fi
+
+			elif test "$current" = "/"
+			then
+				if test -z "$index_horizontal_split"
+				then
+					index_horizontal_split=$i
+				fi
+
+			elif test "$current" = ","
+			then
+				if test -z "$index_vertical_split"
+				then
+					index_vertical_split=$i
+				fi
+			fi
+		fi
+	done
+	IFS=$oldIFS
+
+
+	# Step 3:
+	#
+	# Process the separator with the highest order of precedence
+	# (";" has the highest precedence and "|" the lowest one).
+	#
+	# By "process" I mean recursively call this function twice: the first
+	# one with the substring at the left of the separator and the second one
+	# with the one at its right.
+
+	terminate="false"
+
+	if ! test -z "$index_new_tab"
+	then
+		before="-tabnew"
+		after="tabnext"
+		index=$index_new_tab
+		terminate="true"
+
+	elif ! test -z "$index_horizontal_split"
+	then
+		before="split"
+		after="wincmd j"
+		index=$index_horizontal_split
+		terminate="true"
+
+	elif ! test -z "$index_vertical_split"
+	then
+		before="vertical split"
+		after="wincmd l"
+		index=$index_vertical_split
+		terminate="true"
+	fi
+
+	if  test "$terminate" = "true"
+	then
+		CMD="$CMD | $before"
+		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$start" "$(( $index - $start ))")" "$CMD")
+		CMD="$CMD | $after"
+		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$(( $index + 1 ))" "$(( ${#LAYOUT} - $index ))")" "$CMD")
+		echo "$CMD"
+		return
+	fi
+
+
+	# Step 4:
+	#
+	# If we reach this point, it means there are no separators and we just
+	# need to print the command to display the specified buffer
+
+	target=$(substring "$LAYOUT" "$start" "$(( $end - $start ))" | sed 's:[ @();|-]::g')
+
+	if test "$target" = "LOCAL"
+	then
+		CMD="$CMD | 1b"
+
+	elif test "$target" = "BASE"
+	then
+		CMD="$CMD | 2b"
+
+	elif test "$target" = "REMOTE"
+	then
+		CMD="$CMD | 3b"
+
+	elif test "$target" = "MERGED"
+	then
+		CMD="$CMD | 4b"
+
+	else
+		CMD="$CMD | ERROR: >$target<"
+	fi
+
+	echo "$CMD"
+	return
+}
+
+
+gen_cmd() {
+	# This function returns (in global variable FINAL_CMD) the string that
+	# you can use when invoking "vim" (as shown next) to obtain a given
+	# layout:
+	#
+	#   $ vim -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+	#
+	# It takes one single argument: a string containing the desired layout
+	# definition.
+	#
+	# The syntax of the "layout definitions" is explained in ... (TODO)...
+	# but you can already intuitively understand how it works by knowing
+	# that...
+	#
+	#   * ";" means "a new vim tab"
+	#   * "-" means "a new vim horizontal split"
+	#   * "|" means "a new vim vertical split"
+	#
+	# It also returns (in global variable FINAL_TARGET) the name ("LOCAL",
+	# "BASE", "REMOTE" or "MERGED") of the file that is marked with an "@",
+	# or "MERGED" if none of them is.
+	#
+	# Example:
+	#
+	#     gen_cmd "@LOCAL , REMOTE"
+	#     |
+	#     `-> FINAL_CMD    == "-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	#         FINAL_TARGET == "LOCAL"
+
+	LAYOUT=$1 
+
+
+	# Search for a "@" in one of the files identifiers ("LOCAL", "BASE",
+	# "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
+	# where changes will be saved.
+
+	if echo "$LAYOUT" | grep @LOCAL >/dev/null
+	then
+		FINAL_TARGET="LOCAL"
+	elif echo "$LAYOUT" | grep @BASE >/dev/null
+	then
+		FINAL_TARGET="BASE"
+	else
+		FINAL_TARGET="MERGED"
+	fi
+
+
+	# Obtain the first part of vim "-c" option to obtain the desired layout
+
+	CMD=$(gen_cmd_aux "$LAYOUT")
+
+
+	# Adjust the just obtained script depending on whether more than one
+	# windows are visible or not
+
+	if echo "$LAYOUT" | grep ",\|/" >/dev/null
+	then
+		CMD="$CMD | tabdo windo diffthis"
+	else
+		CMD="$CMD | bufdo diffthis"
+	fi
+
+
+	# Add an extra "-c" option to move to the first tab (notice that we
+	# can't simply append the command to the previous "-c" string as
+	# explained here: https://github.com/vim/vim/issues/9076
+
+	FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
+}
+
+
+run_unit_tests() {
+	# Function to make sure that we don't break anything when modifying this
+	# script.
+	#
+	# This function is automatically executed when you execute this directly
+	# from the shell
+
+	NUMBER_OF_TEST_CASES=16
+
+	TEST_CASE_01="LOCAL,MERGED,REMOTE"
+	TEST_CASE_02="LOCAL/MERGED/REMOTE"
+	TEST_CASE_03="(LOCAL/REMOTE),MERGED"
+	TEST_CASE_04="MERGED,(LOCAL/REMOTE)"
+	TEST_CASE_05="(LOCAL,REMOTE)/MERGED"
+	TEST_CASE_06="MERGED/(LOCAL,REMOTE)"
+	TEST_CASE_07="(LOCAL,BASE,REMOTE)/MERGED"
+	TEST_CASE_08="(LOCAL/BASE/REMOTE),MERGED"
+	TEST_CASE_09="@LOCAL,REMOTE"
+	TEST_CASE_10="MERGED"
+	TEST_CASE_11="(LOCAL,BASE,REMOTE)/MERGED+BASE,LOCAL+BASE,REMOTE+(LOCAL/BASE/REMOTE),MERGED"
+	TEST_CASE_12="((LOCAL,REMOTE)/BASE),MERGED"
+	TEST_CASE_13="((LOCAL,REMOTE)/BASE),((LOCAL/REMOTE),MERGED)"
+	TEST_CASE_14="BASE,REMOTE+BASE,LOCAL"
+	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
+	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
+
+	EXPECTED_CMD_01="-c \"echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"echo | split | 1b | wincmd j | split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"echo | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | vertical split | 4b | wincmd l | split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"echo | split | vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"echo | split | 4b | wincmd j | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"echo | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"echo | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+
+	EXPECTED_TARGET_01="MERGED"
+	EXPECTED_TARGET_02="MERGED"
+	EXPECTED_TARGET_03="MERGED"
+	EXPECTED_TARGET_04="MERGED"
+	EXPECTED_TARGET_05="MERGED"
+	EXPECTED_TARGET_06="MERGED"
+	EXPECTED_TARGET_07="MERGED"
+	EXPECTED_TARGET_08="MERGED"
+	EXPECTED_TARGET_09="LOCAL"
+	EXPECTED_TARGET_10="MERGED"
+	EXPECTED_TARGET_11="MERGED"
+	EXPECTED_TARGET_12="MERGED"
+	EXPECTED_TARGET_13="MERGED"
+	EXPECTED_TARGET_14="MERGED"
+	EXPECTED_TARGET_15="MERGED"
+	EXPECTED_TARGET_16="MERGED"
+
+	at_least_one_ko="false"
+
+	for i in $(seq -w 1 99)
+	do
+		if test "$i" -gt $NUMBER_OF_TEST_CASES
+		then
+			break
+		fi
+
+		gen_cmd "$(eval echo \${TEST_CASE_"$i"})"
+
+		if test "$FINAL_CMD" = "$(eval echo \${EXPECTED_CMD_"$i"})" \
+			&& test "$FINAL_TARGET" = "$(eval echo \${EXPECTED_TARGET_"$i"})"
+		then
+			printf "Test Case #%02d: OK\n" "$(echo "$i" | sed 's/^0*//')"
+		else
+			printf "Test Case #%02d: KO !!!!\n" "$(echo "$i" | sed 's/^0*//')"
+			echo "  FINAL_CMD              : $FINAL_CMD"
+			echo "  FINAL_CMD (expected)   : $(eval echo \${EXPECTED_CMD_"$i"})"
+			echo "  FINAL_TARGET           : $FINAL_TARGET"
+			echo "  FINAL_TARGET (expected): $(eval echo \${EXPECTED_TARGET_"$i"})"
+			at_least_one_ko="true"
+		fi
+	done
+	
+	if test "$at_least_one_ko" = "true"
+	then
+		return 255
+	else
+		return 0
+	fi
+}
+
+
+################################################################################
+## API functions (called from "git-mergetool--lib.sh")
+################################################################################
+
 diff_cmd () {
 	"$merge_tool_path" -R -f -d \
 		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
+
 merge_cmd () {
+	layout=$(git config mergetool.$merge_tool.layout)
+
 	case "$1" in
 	*vimdiff)
-		if $base_present
+		if test -z "$layout"
 		then
-			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
-				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
-		else
-			"$merge_tool_path" -f -d -c 'wincmd l' \
-				"$LOCAL" "$MERGED" "$REMOTE"
+			# Default layout when none is specified
+			layout="(LOCAL,BASE,REMOTE)/MERGED"
 		fi
 		;;
 	*vimdiff1)
-		"$merge_tool_path" -f -d \
-			-c 'echon "Resolve conflicts leftward then save. Use :cq to abort."' \
-			"$LOCAL" "$REMOTE"
-		ret="$?"
-		if test "$ret" -eq 0
-		then
-			cp -- "$LOCAL" "$MERGED"
-		fi
-		return "$ret"
+		layout="@LOCAL,MERGED"
 		;;
 	*vimdiff2)
-		"$merge_tool_path" -f -d -c 'wincmd l' \
-			"$LOCAL" "$MERGED" "$REMOTE"
+		layout="LOCAL,MERGED,REMOTE"
 		;;
 	*vimdiff3)
-		if $base_present
-		then
-			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
-				"$LOCAL" "$REMOTE" "$BASE" "$MERGED"
-		else
-			"$merge_tool_path" -f -d -c 'hid | hid' \
-				"$LOCAL" "$REMOTE" "$MERGED"
-		fi
+		layout="MERGED"
 		;;
 	esac
+
+	gen_cmd "$layout"
+
+	debug_print ""
+	debug_print "FINAL CMD : $FINAL_CMD"
+	debug_print "FINAL TAR : $FINAL_TARGET"
+
+	if $base_present
+	then
+		eval "$merge_tool_path" \
+			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+	else
+		# If there is no BASE (example: a merge conflict in a new file
+		# with the same name created in both braches which didn't exist
+		# before), close all BASE windows using vim's "quit" command
+
+		FINAL_CMD=$(echo "$FINAL_CMD" | \
+			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
+
+		eval "$merge_tool_path" \
+			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
+	fi
+
+	ret="$?"
+
+	if test "$ret" -eq 0
+	then
+		case "$FINAL_TARGET" in
+		LOCAL)
+			source_path="$LOCAL"
+			;;
+		REMOTE)
+			source_path="$REMOTE"
+			;;
+		MERGED|*)
+			# Do nothing
+			source_path=
+			;;
+		esac
+
+		if test -n "$source_path"
+		then
+			cp "$source_path" "$MERGED"
+		fi
+	fi
+
+	return "$ret"
 }
 
+
 translate_merge_tool_path() {
 	case "$1" in
 	nvimdiff*)
@@ -57,14 +547,32 @@ translate_merge_tool_path() {
 	esac
 }
 
+
 exit_code_trustable () {
 	true
 }
 
+
 list_tool_variants () {
-	for prefix in '' g n; do
-		for suffix in '' 1 2 3; do
+	for prefix in '' g n
+	do
+		for suffix in '' 1 2 3
+		do
 			echo "${prefix}vimdiff${suffix}"
 		done
 	done
 }
+
+
+################################################################################
+## Run unit tests when calling this script from a shell
+################################################################################
+
+if test "$(ps -o stat= -p $PPID)" = "Ss" && test "$(ps -o stat= -p $$)" = "S+"
+then
+	# Script is being manually run from command line (see
+	# https://stackoverflow.com/questions/4261876/check-if-bash-script-was-invoked-from-a-shell-or-another-script-application)
+
+	run_unit_tests
+fi
+
-- 
2.33.1


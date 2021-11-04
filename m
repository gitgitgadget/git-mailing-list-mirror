Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95EC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CB561207
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKDQMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:12:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57415 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231613AbhKDQMt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 12:12:49 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4445F5C0143;
        Thu,  4 Nov 2021 12:10:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Nov 2021 12:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=W69indtXghxi7
        TiHPOoqQnUF2moxwNMDD7dbN7r4bts=; b=O3Mi+2RAOK1cKk56JmI2O/E0NxQAj
        kQ1zCM4CUyTnmLIHYoqWdpu9LEzI/XQ0l+YmmKOIF7Oa7WH8AJy4rlyB1kkSX79/
        JuCj3k+q5WlRP0Di+yo/vpF4HZVa/+4+POnNztsTSRPMAd2+G9kb73uDTYgg9Nad
        dvFKb64AcPu0kuvXnkrkeAJcua+I971JQ7nza1rktBAt571odF6Kq4LyGYRegaij
        APsvN4T4lzFTef7nT0XkCAtc2OTFDhvA8KWnlVn2NNsWihchgZ1Wi0Rdtl7epkBL
        bW1SNwU0twUzeVjBDI6pt7iJO+9ICgwYPBfyUmXDJvsajmXy4gC72IfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=W69indtXghxi7TiHPOoqQnUF2moxwNMDD7dbN7r4bts=; b=EYhjKBNp
        Po5TY60BA/bqaz8jUS6h6zZZQ5HOvjc09X2V9K8YodKZNsBuMAO/4QDPJU7JivB7
        QsNgRF82446xlU7gz6Wn6WqH26o0gE5h0jIIFbca9tuvMnfc+4+2TC6JX8rWhmw1
        V/7ZYV9XfsBnDetYKjsW9PXB/QDkQky05iQqSiSVd+xHZHR9hpr3W6+BbGR3+ZCT
        U4YpxaEucgrnHPvOVu3gR9sL7UNi18/Bwe1qHsXoKy8QKOsjF59lL7EUMuEciqaM
        vpK+efNI8NjPqmeFps7y4RRNROXa3ZJWhF+X5WrPxbPC6y0p3TZ1B0itz+B/qwCm
        nYF3EDoYF7tDyQ==
X-ME-Sender: <xms:4gWEYZpTH4XonG2Dcgf5xyRd9Oo1ZQMaK_xrRhDRbJO9vZ66TnQtsw>
    <xme:4gWEYboQYbknK8c_6D3bzkApn9xSlZTrGRBi1gAp81of5GHhIiN5UycOqh2PmLLD8
    _ltZXop-Ihi9QL9Tg>
X-ME-Received: <xmr:4gWEYWOTM9IpQMhyNkiBbNvVhINgGnekRAwQzs-aVJlgMrDQn_dhbiGHkvt9hulOyhjBXghcjCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohes
    uhelvddrvghuqeenucggtffrrghtthgvrhhnpeeuheelkeejjeetvdeihfeuffeihedute
    egfeffkeehgfffledugfeuhfekueeiudenucffohhmrghinhepghhithhhuhgsrdgtohhm
    pdhsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:4gWEYU4fiNQiK9uYC6ltq8Dzht9JDIKw743uSxWncjfV121-J8ZO6A>
    <xmx:4gWEYY4sQYbK_F7RpF7YXwLaefT0MrTH8kQhjbaGplApvmoanHTt0A>
    <xmx:4gWEYcgolm_xaoQtaOd5JkSMntUv-eqieIEsTlXrGwsqqMR7KFz4AQ>
    <xmx:4wWEYT0VSuHq8C2QQfhQmAn5liVGtJkq6eqQ8w_tw2KSms12xgrfXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 12:10:08 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH 1/3] vimdiff: new implementation with layout support
Date:   Thu,  4 Nov 2021 17:09:57 +0100
Message-Id: <20211104160959.183402-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104160959.183402-1-greenfoo@u92.eu>
References: <20211104160959.183402-1-greenfoo@u92.eu>
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
 mergetools/vimdiff | 530 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 504 insertions(+), 26 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 96f6209a04..1f2e88777e 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -1,48 +1,509 @@
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
+# Set to "true" to print debug messages to stderr
+DEBUG=false
+#DEBUG=true
+
+
+################################################################################
+## Internal functions (not meant to be used outside this script)
+################################################################################
+
+debug_print() { 
+	# Send message to stderr if global variable DEBUG is set to "true"
+        
+	if test "$DEBUG" = "true"
+	then
+		>&2 echo "$@";
+	fi
+}
+
+
+gen_cmd_aux() {
+	# Auxiliary function used from "gen_cmd()".
+	# Read that other function documentation for more details.
+
+	local LAYOUT=$1 
+	local CMD=$2  # This is a second (hidden) argument used for recursion  
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
+	local start=0
+	local end=${#LAYOUT}
+
+	local nested=0
+	local nested_min=100
+
+
+	# Step 1:
+	#
+	# Increase/decrease "start"/"end" indices respectively to get rid of
+	# outer parenthesis.
+	#
+	# Example:
+	#
+	#   - BEFORE: (( LOCAL | BASE ) - MERGED )
+	#   - AFTER :  ( LOCAL | BASE ) - MERGED 
+
+	for (( i=$start; i<$end; i++ )); do
+		if test "${LAYOUT:$i:1}" = " "
+		then
+			continue
+		fi
+
+		if test "${LAYOUT:$i:1}" = "("
+		then
+			nested=$(( nested + 1 ))
+			continue
+		fi
+
+		if test "${LAYOUT:$i:1}" = ")"
+		then
+			nested=$(( nested - 1 ))
+			continue
+		fi
+
+		if test "$nested" -lt "$nested_min"
+		then
+			nested_min=$nested
+		fi
+	done
+
+	debug_print "NESTED MIN: $nested_min"
+
+	while test "$nested_min" -gt "0"
+	do
+		start=$(( start + 1 ))
+		end=$(( end - 1 ))
+
+		start_minus_one=$(( start - 1 ))
+
+		while ! test "${LAYOUT:$start_minus_one:1}" = "("
+		do
+			start=$(( start + 1 ))
+			start_minus_one=$(( start_minus_one + 1 ))
+		done
+
+		while ! test "${LAYOUT:$end:1}" = ")"
+		do
+			end=$(( end - 1 ))
+		done
+
+		nested_min=$(( nested_min - 1 ))
+	done
+
+        debug_print "CLEAN     : ${LAYOUT:$start:$(( end - start ))}"
+
+
+	# Step 2:
+	#
+	# Search for all valid separators (";", "-" or "|") which are *not*
+	# inside parenthesis. Save the index at which each of them makes the
+	# first appearance.
+
+	local index_semicolon=""
+	local index_minus=""
+	local index_pipe=""
+
+	nested=0
+	for (( i=$start; i<$end; i++ )); do
+		if test "${LAYOUT:$i:1}" = " "
+		then
+			continue
+		fi
+
+		if test "${LAYOUT:$i:1}" = "("
+		then
+			nested=$(( nested + 1 ))
+			continue
+		fi
+
+		if test "${LAYOUT:$i:1}" = ")"
+		then
+			nested=$(( nested - 1 ))
+			continue
+		fi
+
+		if test "$nested" -eq "0"
+		then
+			current=${LAYOUT:$i:1}
+			
+			if test "$current" = ";"
+			then
+				if test -z "$index_semicolon"
+				then
+					index_semicolon=$i
+				fi
+
+			elif test "$current" = "-"
+			then
+				if test -z "$index_minus"
+				then
+					index_minus=$i
+				fi
+
+			elif test "$current" = "|"
+			then
+				if test -z "$index_pipe"
+				then
+					index_pipe=$i
+				fi
+			fi
+		fi
+	done
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
+	local terminate="false"
+
+	if ! test -z "$index_semicolon"
+	then
+		before="-tabnew"
+		after="tabnext"
+		index=$index_semicolon
+		terminate="true"
+
+	elif ! test -z "$index_minus"
+	then
+		before="split"
+		after="wincmd j"
+		index=$index_minus
+		terminate="true"
+
+	elif ! test -z "$index_pipe"
+	then
+		before="vertical split"
+		after="wincmd l"
+		index=$index_pipe
+		terminate="true"
+	fi
+
+	if  test "$terminate" = "true"
+	then
+		CMD="$CMD | $before"
+		CMD=$(gen_cmd_aux "${LAYOUT:$start:$(( index - start ))}" "$CMD")
+		CMD="$CMD | $after"
+		CMD=$(gen_cmd_aux "${LAYOUT:$(( index + 1 )):$(( ${#LAYOUT} - index ))}" "$CMD")
+		echo $CMD
+		return
+	fi
+
+
+	# Step 4:
+	#
+	# If we reach this point, it means there are no separators and we just
+	# need to print the command to display the specified buffer
+
+	local target=$(echo "${LAYOUT:$start:$(( end - start ))}" | sed 's:[ *();|-]::g')
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
+	echo $CMD
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
+	# "BASE", "REMOTE" or "MERGED") of the file that is marked with an "*",
+	# or "MERGED" if none of them is.
+	#
+	# Example:
+	#
+	#     gen_cmd "LOCAL* | REMOTE"
+	#     |
+	#     `-> FINAL_CMD    == "-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	#         FINAL_TARGET == "LOCAL"
+
+	local LAYOUT=$1 
+
+
+	# Search for a "*" in one of the files identifiers ("LOCAL", "BASE",
+	# "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
+	# where changes will be saved.
+
+	AUX=$(echo "$LAYOUT" | grep -oe "[A-Z]\+\*")
+
+	if ! test -z "$AUX"
+	then
+	        FINAL_TARGET="${AUX:0:-1}"
+	else
+	        FINAL_TARGET="MERGED"
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
+	if test $(echo $LAYOUT | wc -w) == "1"
+	then
+		CMD="$CMD | bufdo diffthis"
+        else
+		CMD="$CMD | tabdo windo diffthis"
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
+	# This function is automatically executed when you execute this script
+	# from the shell with environment variable "DEBUG_GIT_VIMDIFF" set (to
+	# any value).
+
+	local test_cases=(
+		`#Test case 00` "LOCAL | MERGED | REMOTE"
+		`#Test case 01` "LOCAL - MERGED - REMOTE"
+		`#Test case 02` "(LOCAL - REMOTE) | MERGED"
+		`#Test case 03` "MERGED | (LOCAL - REMOTE)"
+		`#Test case 04` "(LOCAL | REMOTE) - MERGED"
+		`#Test case 05` "MERGED - (LOCAL | REMOTE)"
+		`#Test case 06` "(LOCAL | BASE | REMOTE) - MERGED"
+		`#Test case 07` "(LOCAL - BASE - REMOTE) | MERGED"
+		`#Test case 08` "LOCAL* | REMOTE"
+		`#Test case 09` "MERGED"
+		`#Test case 10` "(LOCAL | BASE | REMOTE) - MERGED; BASE | LOCAL; BASE | REMOTE; (LOCAL - BASE - REMOTE) | MERGED"
+		`#Test case 11` "((LOCAL | REMOTE) - BASE) | MERGED"
+		`#Test case 12` "((LOCAL | REMOTE) - BASE) | ((LOCAL - REMOTE) | MERGED)"
+		`#Test case 13` "BASE | REMOTE ; BASE | LOCAL"
+	)
+
+	local expected_cmd=(
+		`#Test case 00` "-c \"echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 01` "-c \"echo | split | 1b | wincmd j | split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 02` "-c \"echo | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 03` "-c \"echo | vertical split | 4b | wincmd l | split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 04` "-c \"echo | split | vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 05` "-c \"echo | split | 4b | wincmd j | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 06` "-c \"echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 07` "-c \"echo | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 08` "-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 09` "-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
+		`#Test case 10` "-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 11` "-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 12` "-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+		`#Test case 13` "-c \"echo | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
+	)
+
+	local expected_target=(
+		`#Test case 00` "MERGED"
+		`#Test case 01` "MERGED"
+		`#Test case 02` "MERGED"
+		`#Test case 03` "MERGED"
+		`#Test case 04` "MERGED"
+		`#Test case 05` "MERGED"
+		`#Test case 06` "MERGED"
+		`#Test case 07` "MERGED"
+		`#Test case 08` "LOCAL"
+		`#Test case 09` "MERGED"
+		`#Test case 10` "MERGED"
+		`#Test case 11` "MERGED"
+		`#Test case 12` "MERGED"
+		`#Test case 13` "MERGED"
+	)
+
+	local at_least_one_ko="false"
+
+	for i in ${!test_cases[@]}; do
+		gen_cmd "${test_cases[$i]}"
+	
+		if test "$FINAL_CMD" = "${expected_cmd[$i]}" && test "$FINAL_TARGET" = "${expected_target[$i]}"
+		then
+			printf "Test Case #%02d: OK\n" $i
+		else
+			printf "Test Case #%02d: KO !!!!\n" $i
+			echo "  FINAL_CMD              : $FINAL_CMD"
+                        echo "  FINAL_CMD (expected)   : ${expected_cmd[$i]}"
+			echo "  FINAL_TARGET           : $FINAL_TARGET"
+                        echo "  FINAL_TARGET (expected): ${expected_target[$i]}"
+			at_least_one_ko="true"
+		fi
+	done
+	
+	if test "$at_least_one_ko" = "true"
+	then
+		return -1
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
+	print_warning="false"
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
+			layout="(LOCAL | BASE | REMOTE) - MERGED"
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
+		layout="LOCAL* | MERGED"
+		print_warning="true"
 		;;
 	*vimdiff2)
-		"$merge_tool_path" -f -d -c 'wincmd l' \
-			"$LOCAL" "$MERGED" "$REMOTE"
+		layout="LOCAL | MERGED | REMOTE"
+		print_warning="true"
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
+		print_warning="true"
 		;;
 	esac
+
+	if test "$print_warning" = "true"
+	then
+		echo "WARNING:"
+		echo "WARNING: '$1' is going to be removed in a future version. You will be"
+		echo "WARNING: able to obtain the same result by selecting 'vimdiff' as the merge"
+		echo "WARNING: tool and setting configuration variable 'mergetool.vimdiff.layout'"
+		echo "WARNING: to the following value:"
+		echo "WARNING:"
+		echo "WARNING:     layout = \"$layout\""
+		echo "WARNING:"
+		echo "Press ENTER to continue..."
+		read
+	fi
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
+			-f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+	else
+		# If there is no BASE (example: a merge conflict in a new file
+		# with the same name created in both braches which didn't exist
+		# before), close all BASE windows using vim's "quit" command
+
+		FINAL_CMD=$(echo $FINAL_CMD | \
+			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')
+
+		eval "$merge_tool_path" \
+			-f $FINAL_CMD "$LOCAL" "$REMOTE" "$MERGED"
+	fi
+
+
+	ret="$?"
+	if test "$ret" -eq 0
+	then
+		if test "$FINAL_TARGET" != "MERGED"
+		then
+			eval cp -- \$"$FINAL_TARGET" "$MERGED"
+		fi
+	fi
+	return "$ret"
 }
 
+
 translate_merge_tool_path() {
 	case "$1" in
 	nvimdiff*)
@@ -57,14 +518,31 @@ translate_merge_tool_path() {
 	esac
 }
 
+
 exit_code_trustable () {
 	true
 }
 
+
 list_tool_variants () {
 	for prefix in '' g n; do
-		for suffix in '' 1 2 3; do
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
+if test $(ps -o stat= -p $PPID) = "Ss" && test $(ps -o stat= -p $$) = "S+"
+then
+	# Script is being manually run from command line (see
+	# https://stackoverflow.com/questions/4261876/check-if-bash-script-was-invoked-from-a-shell-or-another-script-application)
+
+	run_unit_tests
+fi
+
-- 
2.33.1


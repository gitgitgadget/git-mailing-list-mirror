Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28FC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350665AbiC3TV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350710AbiC3TVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:21:14 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA89318C
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:19:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 484253201FCE;
        Wed, 30 Mar 2022 15:19:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Mar 2022 15:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=OCFj9cevoIIR0mM1RgBJeCV0NIkswp
        kcRJYaC0wjFTo=; b=Vmj53asEMuip6YxEmJ3nS/2thZCevg9Lf/MiI1IwSSvLv/
        uve6xUaIi96ba+6QJBkBnPGPfRZJBsTEg+9yWbI/Fa2E+QvCE8+zgogk2ZQ9Svh9
        GeG0MeGQzzdEHNKKTp6pAcJZ5mIBQFzUAko9knkiqMx/46pmTEUcGVWQxkGjBui2
        1FYh3WUUzxteID2MbXwfu3B/UzDnMENErkl5etAXaIiZlt1K/h2/8HbKpmHLAdd+
        7Q3tXqBlmq3O9jnIjXHyUfHj0jFQIt4DcvIXmjglojtdjbuyyrKn7cJIZz7zbBaW
        1qO9Byb5k0hkit/oXZNNDGgDYyIpaFfF5hW7As3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OCFj9c
        evoIIR0mM1RgBJeCV0NIkswpkcRJYaC0wjFTo=; b=RhnDan7W+DUtvKsxBThp/8
        ZvLaVNDltqIlqhlXEuc3KGRwJLh26f4mdzI//U8rPUgLJGgo+LIZ4jS29nEKeTiU
        Za5G3so1gtTRX8Aq9+jWDUrNqZyCnXBY6SkO0uHzczLh17CIWng+vuNv1fgAbCZ0
        5U3Pk6wjdB0N5fxHbk2OFWnbTRjj6ZBWneurvHx83KHS0U5HHSmbu094QZQdswbN
        FXiN/P/Q3DvxCyatdpNUvzmTTSPQ3AXgIFpM+eur0RRM0gcH3BNYCZIl8RKcao6r
        9+ZeqYxTS/+GwDWCkSwBhXsTxWbprusdBJYKziaLSVXrG1loWx6ivV8be/IWfy8g
        ==
X-ME-Sender: <xms:N61EYommbSn_WDHzrqksepgoNXnyZE94Ldmt6ZxGgo3X2_zAx9jVOg>
    <xme:N61EYn0akcMzrO6crjbSdN0I9zk7cYEZvpCsZuU3SCoLlI3uaAJ5IDv7rd6nGnMmZ
    NLMX_y17nELCpsgwQ>
X-ME-Received: <xmr:N61EYmrtMGs5_uFEmSYX9OV20rgb23nj8FuC2Hb7ayOE8hWvRrRhDs5zTXdg82Yqb-o8i1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpedvjeffheefiedtleekueeuuddvke
    ekvdegledtffegjefhjeetheffhfehueeiueenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:N61EYkm-vaec5DOHU6jAtx-_lXLDfaxPluy3lXRIlqES9199oGrBxQ>
    <xmx:N61EYm1fT9ombcF4_-QKab3D6C8OhJ35Qvc51q2JDLX2O4smH5PNDw>
    <xmx:N61EYrsr6kIM15h7_Kz-8OzHd_YQDn15AKka8rMfZcgtHTCtwJLV2Q>
    <xmx:N61EYvk9Gp2fy0IxIU0lz9pnRqzsoqQa8iHJWK-ILr3v97kL5flmtA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 15:19:17 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v9 1/4] vimdiff: new implementation with layout support
Date:   Wed, 30 Mar 2022 21:19:06 +0200
Message-Id: <20220330191909.294610-2-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330191909.294610-1-greenfoo@u92.eu>
References: <20220329224439.290948-1-greenfoo@u92.eu>
 <20220330191909.294610-1-greenfoo@u92.eu>
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

Again, if you don't set "mergetool.vimdiff.layout" everything will work
the same as before *but* the arguments used to call {n,g,}vim will be
others (even if you don't/shouldn't notice it):

  - git mergetool -t vimdiff

    > Before this commit:
      {n,g,}vim -f -d -c '4wincmd w | wincmd J' $LOCAL $BASE $REMOTE $MERGED

    > After this commit:
      {n,g,}vim -f -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

  - git mergetool -t vimdiff1

    > Before this commit:
      {n,g,}vim -f -d -c 'echon "..."' $LOCAL $REMOTE

    > After this commit:
      {n,g,}vim -f -c "echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

  - git mergetool -t vimdiff2

    > Before this commit:
      {n,g,}vim -f -d -c 'wincmd l' $LOCAL $MERGED $REMOTE

    > After this commit:
      {n,g,}vim -f -c "echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

  - git mergetool -t vimdiff3

    > Before this commit:
      {n,g,}vim -f -d -c 'hid | hid | hid' $LOCAL $REMOTE $BASE $MERGED

    > After this commit:
      {n,g,}vim -f -c "echo | 4b | bufdo diffthis" -c "tabfirst" $LOCAL $BASE $REMOTE $MERGED

Despite being different, I have manually verified that they generate the same
layout as before.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 558 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 529 insertions(+), 29 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 96f6209a04..9d1bf4f455 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -1,49 +1,442 @@
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
+#   - From a script inside the unit tests framework folder ("t" folder) by
+#     sourcing this script and then manually calling "run_unit_tests", which
+#     will run a battery of unit tests to make sure nothing breaks.
+#     In this context this script does not expect any particular environment
+#     variable to be set.
+
+
+################################################################################
+## Internal functions (not meant to be used outside this script)
+################################################################################
+
+debug_print () {
+	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
+	# to "true"
+
+	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
+	then
+		>&2 echo "$@"
+	fi
+}
+
+substring () {
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
+	echo "$STRING" | cut -c$(( START + 1 ))-$(( START + $LEN ))
+}
+
+gen_cmd_aux () {
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
+			nested=$(( nested + 1 ))
+			continue
+		fi
+
+		if test "$c" = ")"
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
+	IFS=$oldIFS
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
+		while ! test "$(substring "$LAYOUT" "$start_minus_one" 1)" = "("
+		do
+			start=$(( start + 1 ))
+			start_minus_one=$(( start_minus_one + 1 ))
+		done
+
+		while ! test "$(substring "$LAYOUT" "$end" 1)" = ")"
+		do
+			end=$(( end - 1 ))
+		done
+
+		nested_min=$(( nested_min - 1 ))
+	done
+
+	debug_print "CLEAN     : $(substring "$LAYOUT" "$start" "$(( end - start ))")"
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
+	i=$(( start - 1 ))
+
+	oldIFS=$IFS
+	IFS=#
+	for c in $(substring "$LAYOUT" "$start" "$(( end - start ))" | sed 's:.:&#:g');
+	do
+		i=$(( i + 1 ))
+
+		if test "$c" = " "
+		then
+			continue
+		fi
+
+		if test "$c" = "("
+		then
+			nested=$(( nested + 1 ))
+			continue
+		fi
+
+		if test "$c" = ")"
+		then
+			nested=$(( nested - 1 ))
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
+		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$start" "$(( index - start ))")" "$CMD")
+		CMD="$CMD | $after"
+		CMD=$(gen_cmd_aux "$(substring "$LAYOUT" "$(( index + 1 ))" "$(( ${#LAYOUT} - index ))")" "$CMD")
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
+	target=$(substring "$LAYOUT" "$start" "$(( end - start ))" | sed 's:[ @();|-]::g')
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
+gen_cmd () {
+	# This function returns (in global variable FINAL_CMD) the string that
+	# you can use when invoking "vim" (as shown next) to obtain a given
+	# layout:
+	#
+	#   $ vim -f $FINAL_CMD "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
+	#
+	# It takes one single argument: a string containing the desired layout
+	# definition.
+	#
+	# The syntax of the "layout definitions" is explained in "Documentation/
+	# mergetools/vimdiff.txt" but you can already intuitively understand how
+	# it works by knowing that...
+	#
+	#   * "+" means "a new vim tab"
+	#   * "/" means "a new vim horizontal split"
+	#   * "," means "a new vim vertical split"
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
+	layout=$(git config mergetool.vimdiff.layout)
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
+		layout="@LOCAL,REMOTE"
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
 
-translate_merge_tool_path() {
+
+translate_merge_tool_path () {
 	case "$1" in
 	nvimdiff*)
 		echo nvim
@@ -57,14 +450,121 @@ translate_merge_tool_path() {
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
-			echo "${prefix}vimdiff${suffix}"
+	if test "$TOOL_MODE" = "diff"
+	then
+		for prefix in '' g n
+		do
+			echo "${prefix}vimdiff"
 		done
+	else
+		for prefix in '' g n
+		do
+			for suffix in '' 1 2 3
+			do
+				echo "${prefix}vimdiff${suffix}"
+			done
+		done
+	fi
+}
+
+
+################################################################################
+## Unit tests (called from scripts inside the "t" folder)
+################################################################################
+
+run_unit_tests () {
+	# Function to make sure that we don't break anything when modifying this
+	# script.
+
+	NUMBER_OF_TEST_CASES=16
+
+	TEST_CASE_01="(LOCAL,BASE,REMOTE)/MERGED"   # default behaviour
+	TEST_CASE_02="@LOCAL,REMOTE"                # when using vimdiff1
+	TEST_CASE_03="LOCAL,MERGED,REMOTE"          # when using vimdiff2
+	TEST_CASE_04="MERGED"                       # when using vimdiff3
+	TEST_CASE_05="LOCAL/MERGED/REMOTE"
+	TEST_CASE_06="(LOCAL/REMOTE),MERGED"
+	TEST_CASE_07="MERGED,(LOCAL/REMOTE)"
+	TEST_CASE_08="(LOCAL,REMOTE)/MERGED"
+	TEST_CASE_09="MERGED/(LOCAL,REMOTE)"
+	TEST_CASE_10="(LOCAL/BASE/REMOTE),MERGED"
+	TEST_CASE_11="(LOCAL,BASE,REMOTE)/MERGED+BASE,LOCAL+BASE,REMOTE+(LOCAL/BASE/REMOTE),MERGED"
+	TEST_CASE_12="((LOCAL,REMOTE)/BASE),MERGED"
+	TEST_CASE_13="((LOCAL,REMOTE)/BASE),((LOCAL/REMOTE),MERGED)"
+	TEST_CASE_14="BASE,REMOTE+BASE,LOCAL"
+	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
+	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
+
+	EXPECTED_CMD_01="-c \"echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"echo | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"echo | vertical split | 1b | wincmd l | vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"echo | split | 1b | wincmd j | split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"echo | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"echo | vertical split | 4b | wincmd l | split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"echo | split | vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"echo | split | 4b | wincmd j | vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"echo | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"echo | vertical split | split | vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | vertical split | split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"echo | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"echo | -tabnew | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | vertical split | 2b | wincmd l | 3b | tabnext | vertical split | split | 1b | wincmd j | split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+
+	EXPECTED_TARGET_01="MERGED"
+	EXPECTED_TARGET_02="LOCAL"
+	EXPECTED_TARGET_03="MERGED"
+	EXPECTED_TARGET_04="MERGED"
+	EXPECTED_TARGET_05="MERGED"
+	EXPECTED_TARGET_06="MERGED"
+	EXPECTED_TARGET_07="MERGED"
+	EXPECTED_TARGET_08="MERGED"
+	EXPECTED_TARGET_09="MERGED"
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
 	done
+
+	if test "$at_least_one_ko" = "true"
+	then
+		return 255
+	else
+		return 0
+	fi
 }
-- 
2.35.1


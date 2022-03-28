Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636AC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiC1Wcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiC1Wcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:32:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544D48333
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:30:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B9A8B3202010;
        Mon, 28 Mar 2022 18:30:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Mar 2022 18:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=mOtsdbInNbEuLcFmDaOMgPk2FpUW3F
        DjnIsxbsuZ50s=; b=VgP5Kjj7eNirgH5nrYrEwthimzLHBWKVHMj3F6oiNVWIT9
        PibW4yvddhwbRB7nmavu3Odn4fgJm50EIbRpsdc4NX26Oip+1lOPT7LJFqYSJUPr
        i/70+/6oyklndHZ0WOvftz47QbyTi+rRLP/MT4Pp9YcQlC4PWDOP1ywZME1DxFOT
        nQngCy1PQg5zqxjbCDrj+Amkz46+ETTvC4tbwTwvyB6JZiIlXznHT1t3WmuHlhAW
        KEgim2kVfKEbhL8fLDZ1vGH7PtR5XoctrFV1ZqQUTM6wzda+5OBej7520WqH69Ta
        xHNcPYBBAJyg49BV+oCZd9UbvaE/sOXhMVXLNwaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mOtsdb
        InNbEuLcFmDaOMgPk2FpUW3FDjnIsxbsuZ50s=; b=f5DHuyTHH5f9JE3hujLgos
        qLiMyzbP4xIDubuEHzEz1W2wQo/ppHONH4w6B78B4NTYgXO6VgimDdT8V7kXDvEJ
        H6ACrxRmcARZeJSpEWM5YI3s3m09IQRnMf3Q1AXro3y/Z5Lh187Jfs+9y0yYfuv9
        SGbzVJ+ea1ZRb6MMqe733XQZ9awu/sFBWSj+b2ywhPUOsvIHhNV5L9HdOypyJdZ4
        ZSROokJwddeD5977Rp9agaa0/ytiFQx2EU+W9v0izbfpl6fNDLmyudcwESff+Mdb
        cIdIcdYShwEVo9mB6QeqJKbJZWFME8Elsy9KU5tO5iW6Ln+7YDsq8QUsb+03yVbA
        ==
X-ME-Sender: <xms:DTdCYo-mGctgQsIGgsfGmjnAhVrmKj7SLpM7yvT_njWGogc-NWIhxQ>
    <xme:DTdCYguBWlvNGuDJ3AqY-XjAXpPJ0pxI-hNj7tx0BoVNLBqL5jq-2yt_5crQ-wnK2
    4tAVCkqYopPyU9WIw>
X-ME-Received: <xmr:DTdCYuAr_azFG95bZwagpR_UMFvrJPfIQx5d6jOpNB5WjRfBgu_IAnmrlAp2YYeQvzS4Tb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:DTdCYodamhR-krNWk_kwfqKucE5P9w7TO4gPquqZl4mBrJq4TFNWZQ>
    <xmx:DTdCYtOZxTXCXbmvSC0ygiA_D7jjyDcRlHGvKslo1ouxmPoiTePIUQ>
    <xmx:DTdCYimtwLZmsM2OvBHpZn6YcA0gFYTzYViedFtbRx5VT4UJoUVZYw>
    <xmx:DTdCYpDNCYlNRaj4riOp2iiz4jGZKCfkqj3YxWS10-vkOrJJXLy5WA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 18:30:35 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: [PATCH v7 4/4] vimdiff: add description to already existing diff/merge tools
Date:   Tue, 29 Mar 2022 00:30:19 +0200
Message-Id: <20220328223019.271270-5-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328223019.271270-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 mergetools/araxis        | 8 ++++++++
 mergetools/bc            | 8 ++++++++
 mergetools/codecompare   | 8 ++++++++
 mergetools/deltawalker   | 8 ++++++++
 mergetools/diffmerge     | 8 ++++++++
 mergetools/diffuse       | 8 ++++++++
 mergetools/ecmerge       | 8 ++++++++
 mergetools/emerge        | 8 ++++++++
 mergetools/examdiff      | 8 ++++++++
 mergetools/guiffy        | 8 ++++++++
 mergetools/kdiff3        | 8 ++++++++
 mergetools/kompare       | 8 ++++++++
 mergetools/meld          | 8 ++++++++
 mergetools/opendiff      | 8 ++++++++
 mergetools/p4merge       | 8 ++++++++
 mergetools/smerge        | 8 ++++++++
 mergetools/tkdiff        | 8 ++++++++
 mergetools/tortoisemerge | 8 ++++++++
 mergetools/winmerge      | 8 ++++++++
 mergetools/xxdiff        | 8 ++++++++
 20 files changed, 160 insertions(+)

diff --git a/mergetools/araxis b/mergetools/araxis
index e2407b65b7..eb32a7da95 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" >/dev/null 2>&1
 }
 
+diff_cmd_help () {
+	echo "Use Araxis Merge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,6 +17,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Araxis Merge (requires a graphical session)"
+}
+
 translate_merge_tool_path() {
 	echo compare
 }
diff --git a/mergetools/bc b/mergetools/bc
index 26c19d46a5..2922667ddd 100644
--- a/mergetools/bc
+++ b/mergetools/bc
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use Beyond Compare (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,6 +17,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Beyond Compare (requires a graphical session)"
+}
+
 translate_merge_tool_path() {
 	if type bcomp >/dev/null 2>/dev/null
 	then
diff --git a/mergetools/codecompare b/mergetools/codecompare
index 9f60e8da65..610963d377 100644
--- a/mergetools/codecompare
+++ b/mergetools/codecompare
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use Code Compare (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,6 +17,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Code Compare (requires a graphical session)"
+}
+
 translate_merge_tool_path() {
 	if merge_mode
 	then
diff --git a/mergetools/deltawalker b/mergetools/deltawalker
index ee6f374bce..efae4c285c 100644
--- a/mergetools/deltawalker
+++ b/mergetools/deltawalker
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
 }
 
+diff_cmd_help () {
+	echo "Use DeltaWalker (requires a graphical session)"
+}
+
 merge_cmd () {
 	# Adding $(pwd)/ in front of $MERGED should not be necessary.
 	# However without it, DeltaWalker (at least v1.9.8 on Windows)
@@ -16,6 +20,10 @@ merge_cmd () {
 	fi >/dev/null 2>&1
 }
 
+merge_cmd_help () {
+	echo "Use DeltaWalker (requires a graphical session)"
+}
+
 translate_merge_tool_path () {
 	echo DeltaWalker
 }
diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index 9b6355b98a..9b5b62d1ca 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
 }
 
+diff_cmd_help () {
+	echo "Use DiffMerge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,6 +17,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use DiffMerge (requires a graphical session)"
+}
+
 exit_code_trustable () {
 	true
 }
diff --git a/mergetools/diffuse b/mergetools/diffuse
index 5a3ae8b569..ebfaba5172 100644
--- a/mergetools/diffuse
+++ b/mergetools/diffuse
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 }
 
+diff_cmd_help () {
+	echo "Use Diffuse (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,3 +17,7 @@ merge_cmd () {
 			"$LOCAL" "$MERGED" "$REMOTE" | cat
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use Diffuse (requires a graphical session)"
+}
diff --git a/mergetools/ecmerge b/mergetools/ecmerge
index 6c5101c4f7..0d4d609874 100644
--- a/mergetools/ecmerge
+++ b/mergetools/ecmerge
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" --default --mode=diff2 "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use ECMerge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -12,3 +16,7 @@ merge_cmd () {
 			--default --mode=merge2 --to="$MERGED"
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use ECMerge (requires a graphical session)"
+}
diff --git a/mergetools/emerge b/mergetools/emerge
index d1ce513ff5..fc6892cc95 100644
--- a/mergetools/emerge
+++ b/mergetools/emerge
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use Emacs' Emerge"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -17,6 +21,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Emacs' Emerge"
+}
+
 translate_merge_tool_path() {
 	echo emacs
 }
diff --git a/mergetools/examdiff b/mergetools/examdiff
index e72b06fc4d..6f53ca9161 100644
--- a/mergetools/examdiff
+++ b/mergetools/examdiff
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
 }
 
+diff_cmd_help () {
+	echo "Use ExamDiff Pro (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -11,6 +15,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use ExamDiff Pro (requires a graphical session)"
+}
+
 translate_merge_tool_path() {
 	mergetool_find_win32_cmd "ExamDiff.com" "ExamDiff Pro"
 }
diff --git a/mergetools/guiffy b/mergetools/guiffy
index 8b23a13c41..3ed07efd16 100644
--- a/mergetools/guiffy
+++ b/mergetools/guiffy
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use Guiffy's Diff Tool (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -13,6 +17,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Guiffy's Diff Tool (requires a graphical session)"
+}
+
 exit_code_trustable () {
 	true
 }
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 520cb914a1..ee8b3a0570 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -4,6 +4,10 @@ diff_cmd () {
 		"$LOCAL" "$REMOTE" >/dev/null 2>&1
 }
 
+diff_cmd_help () {
+	echo "Use KDiff3 (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -22,6 +26,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use KDiff3 (requires a graphical session)"
+}
+
 exit_code_trustable () {
 	true
 }
diff --git a/mergetools/kompare b/mergetools/kompare
index e8c0bfa678..4ce23dbe8b 100644
--- a/mergetools/kompare
+++ b/mergetools/kompare
@@ -2,10 +2,18 @@ can_merge () {
 	return 1
 }
 
+diff_cmd_help () {
+	echo "Use Kompare (requires a graphical session)"
+}
+
 diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+merge_cmd_help () {
+	echo "Use Kompare (requires a graphical session)"
+}
+
 exit_code_trustable () {
 	true
 }
diff --git a/mergetools/meld b/mergetools/meld
index aab4ebb935..8ec0867e03 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use Meld (requires a graphical session)"
+}
+
 merge_cmd () {
 	check_meld_for_features
 
@@ -20,6 +24,10 @@ merge_cmd () {
 	fi
 }
 
+merge_cmd_help () {
+	echo "Use Meld (requires a graphical session) with optional \`auto merge\` (see \`git help mergetool\`'s \`CONFIGURATION\` section)"
+}
+
 # Get meld help message
 init_meld_help_msg () {
 	if test -z "$meld_help_msg"
diff --git a/mergetools/opendiff b/mergetools/opendiff
index b608dd6de3..44adf8f951 100644
--- a/mergetools/opendiff
+++ b/mergetools/opendiff
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
 }
 
+diff_cmd_help () {
+	echo "Use FileMerge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -12,3 +16,7 @@ merge_cmd () {
 			-merge "$MERGED" | cat
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use FileMerge (requires a graphical session)"
+}
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 7a5b291dd2..f3cb197e58 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -19,6 +19,10 @@ diff_cmd () {
 	fi
 }
 
+diff_cmd_help () {
+	echo "Use HelixCore P4Merge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if ! $base_present
 	then
@@ -34,3 +38,7 @@ create_empty_file () {
 
 	printf "%s" "$empty_file"
 }
+
+merge_cmd_help () {
+	echo "Use HelixCore P4Merge (requires a graphical session)"
+}
diff --git a/mergetools/smerge b/mergetools/smerge
index 9c2e6f6fd7..5410835a6b 100644
--- a/mergetools/smerge
+++ b/mergetools/smerge
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" mergetool "$LOCAL" "$REMOTE" -o "$MERGED"
 }
 
+diff_cmd_help () {
+	echo "Use Sublime Merge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -10,3 +14,7 @@ merge_cmd () {
 		"$merge_tool_path" mergetool "$LOCAL" "$REMOTE" -o "$MERGED"
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use Sublime Merge (requires a graphical session)"
+}
diff --git a/mergetools/tkdiff b/mergetools/tkdiff
index eee5cb57e3..66906a720d 100644
--- a/mergetools/tkdiff
+++ b/mergetools/tkdiff
@@ -2,6 +2,10 @@ diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help () {
+	echo "Use TkDiff (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -14,3 +18,7 @@ merge_cmd () {
 exit_code_trustable () {
 	true
 }
+
+merge_cmd_help () {
+	echo "Use TkDiff (requires a graphical session)"
+}
diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index d7ab666a59..507edcd444 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -2,6 +2,10 @@ can_diff () {
 	return 1
 }
 
+diff_cmd_help () {
+	echo "Use TortoiseMerge (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -30,3 +34,7 @@ translate_merge_tool_path() {
 		echo tortoisemerge
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use TortoiseMerge (requires a graphical session)"
+}
diff --git a/mergetools/winmerge b/mergetools/winmerge
index 74d03259fd..36c72dde6e 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -3,6 +3,10 @@ diff_cmd () {
 	return 0
 }
 
+diff_cmd_help () {
+	echo "Use WinMerge (requires a graphical session)"
+}
+
 merge_cmd () {
 	# mergetool.winmerge.trustExitCode is implicitly false.
 	# touch $BACKUP so that we can check_unchanged.
@@ -13,3 +17,7 @@ merge_cmd () {
 translate_merge_tool_path() {
 	mergetool_find_win32_cmd "WinMergeU.exe" "WinMerge"
 }
+
+merge_cmd_help () {
+	echo "Use WinMerge (requires a graphical session)"
+}
diff --git a/mergetools/xxdiff b/mergetools/xxdiff
index d5ce467995..cd205f9842 100644
--- a/mergetools/xxdiff
+++ b/mergetools/xxdiff
@@ -12,6 +12,10 @@ diff_cmd () {
 	fi
 }
 
+diff_cmd_help () {
+	echo "Use xxdiff (requires a graphical session)"
+}
+
 merge_cmd () {
 	if $base_present
 	then
@@ -28,3 +32,7 @@ merge_cmd () {
 			--merged-file "$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
+
+merge_cmd_help () {
+	echo "Use xxdiff (requires a graphical session)"
+}
-- 
2.35.1


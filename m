Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A77C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiC2Wqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiC2Wqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:46:40 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F023D77C
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:44:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C14623201D2F;
        Tue, 29 Mar 2022 18:44:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 29 Mar 2022 18:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=oz8QCwEPXE2xOZkYpss1V59E5JmT3E
        aHdUmHSLV+XZg=; b=ET6cbPPX8OokkvxFSRsY5/ym6PIBBm76RTTa+1IGoDlSYk
        g39xU/pZGx7caHOtgmUxwXKJQFpPy4n1CzxM9aOyKtXLMuVVONTHe6Z7/xeNptLC
        VjL1toZYHZjHgN9cshkd+y9jE9tZEUDWztGxTJ50Dfj5yw/S4FK/fb5RvINFes++
        ukwWUqYjOeYNVNkbPMlo53zpfYpM+iu/DIkPAo9tbOeUB09gCWHVYwTvmwJZY3ma
        +7qpH7WSs/dvWDsg/mt+IBb+OlNOtpC1i61ZhfVuAHYmTurTcV1ZjynCEpkPH+p1
        6QCMog4bBz0TxXMX+2MU1H3w3JpXDEfXPnvHwJJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oz8QCw
        EPXE2xOZkYpss1V59E5JmT3EaHdUmHSLV+XZg=; b=NTy0TwUyiVlMvj9ONwzgF1
        tTp6FlcS7yvB8IehJRT31VWM22LR71CqPv70FrRRDd6Do5Dj/maMhZlg6lVBRyRZ
        fNdlUhkTMf/jkXvrgL/YtUy32aXHKhfBm7Ueis5DkWVhF20s/uEIOdGTy9jOZCiB
        GqlwAhl211YEc0T1duUm1b8zPS7dMa69I47YNSIjESPsbREf3Ql2K/GEZ+SVmW53
        OdRmITZND923iJkEGH40ItALDmfxQoIXl3efTG4A4yhoChf36vI8Qrvf2ZWSDIVQ
        l8iSnUUejBWr3Gy9jOhwtImVYr4v3btOXXCJ2fWggu7vuH6ckGXZwNSrVlDZjW3A
        ==
X-ME-Sender: <xms:54tDYpeBl3AgrpAbg2jUTmppv9i7L4k3HYZXzNO6q_VtqaZyG1kxDQ>
    <xme:54tDYnPzGcBgBScFjg7RLE6AMKfZIRgmgAdSLbZko12eKRy169cj7zwXFsjDS0x15
    R2BAoaWJPR1Dt_lHg>
X-ME-Received: <xmr:54tDYihSKjsYEdndDQBQmNTL8j9jXucN15e6Nli2S0xf69mOgJZtgYwXIdzc4stl6J6wLTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:54tDYi9XmOhUv6QgezuPikMQ8dPC8pYb2TNXE0Pl2SNJJh8L2R2tAA>
    <xmx:54tDYlsdyURCC33mKWmyl_y8mFeEOdcptQhsovsm9ZTeQTaSqBbvJQ>
    <xmx:54tDYhHey3R72f5kQaaPLOsfUwlj_Om9u1hGUTA4UcLFDckyDilesQ>
    <xmx:54tDYm9AA11_JDKGuMV_8Xcm92iA2yiICdljkCukwDGAUi7_SxylYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 18:44:53 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v8 4/5] mergetools: add description to all diff/merge tools
Date:   Wed, 30 Mar 2022 00:44:38 +0200
Message-Id: <20220329224439.290948-5-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329224439.290948-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of `git mergetool --tool-help` and `git difftool --tool-help`
only showed the `alias` of each available merge/diff tool.

It is not always obvious what tool these `aliases` end up using (ex:
`opendiff` runs `FileMerge` and `bc` runs `Beyond Compare`).

This commit adds a short description to each of them to help the user
identify the `alias` they want.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
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


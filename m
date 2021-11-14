Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A764C433FE
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5936E611CE
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhKNRlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:41:32 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38659 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235630AbhKNRl0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Nov 2021 12:41:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3FD8B32009EF;
        Sun, 14 Nov 2021 12:38:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 14 Nov 2021 12:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wVZmA3nLrU4GT
        JLr8vVjD/MhY3yrkcnD8M3DAvWN8fk=; b=e8iwuyKzt4AbJeZmUYLrJx/vU+aJv
        gG/WvQN+UsTtANVpGXqHqaBlr8e4NiRPSIbtxLpWoqiL5gAOidsUJFqaC1O6+j+Q
        TXIoTOPYmgyUdBeZa+eJ5a4Wwo5MClah1/xGHuDMsgUbEFx8TeQkYgC2fI8ZbF7H
        ixI2YvsPWmBegEGFdwVrKFH6zL0gEf/Z3jouXo/WZKEd9KVFtZOBbhpf97Y0/XWf
        vd1L1YZpyR/XwdpKHwHcJVSnGyVNWZ6NBc6qaAZAzRQrBXEbRNMURZFYO4/YA2JS
        HFVocClsKDgTYD1kEdr+U+nDS0x8bo59CQ4ykQx1BohQ5/wp0OnZjksQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wVZmA3nLrU4GTJLr8vVjD/MhY3yrkcnD8M3DAvWN8fk=; b=kl5h+AVs
        8/ct566+AOMEnvJruW5/fxdx+3GkTMfWjr66dTB3SCxo+RUtho55T3FyyokIIF2k
        UNtOhaLpkeTDwbOawpa9shFwnFUTmdU/rHuFIfkBX5qkZAwPMwIn296NQsnmn8mw
        8ZoRyGkDv++1XRXaFpUTSW3vTp1p5V0J4ZKIwxkoNfqdZmGuOZMDtTmOxqWuWyGS
        pu5Z5xJBJKH9CwCVTj4MmU0xwBQW7pyFvYhh+W71ImCnqxhJdZju2enMv5t1mVY/
        DHpYubY7fRyJ0sfN+B5l3skKKainPkvxQ9YXKybZF6j7yALTyaQoaCDGaCdCW17U
        e6lBtxbQpy8dXA==
X-ME-Sender: <xms:l0mRYddxBTsA16YPb05WhIBuk8HTNmOtbnkz3p1R077qIxMsZ4PwxA>
    <xme:l0mRYbO-wrGeSH2cfr3fMkcCljXpVAeEaYeZ-zhdUbtCQbE4k9H-8TYLfQbSqmG_7
    swV_GO2VzuxwCgLVA>
X-ME-Received: <xmr:l0mRYWhcpKW3mN35QZZn1NbYN2LMIMhUWJKkWLzftFpuIZgT1GORavXk3Mb9--56648m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdejgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:l0mRYW80xNacGNIB0h9GvokLijMtXhZ6WCT9FO9ETFMEu6K7zSTRng>
    <xmx:l0mRYZvRPY3vzwVfMimj9cQQIMhTFYJckFYtA7-C92q-PeL8_qYafQ>
    <xmx:l0mRYVEdbtOf1P1XPnN2WmQab8ayIVCPSvrvi0ZCF9TnpSRHk9c6ag>
    <xmx:l0mRYXWqB0BiOkfwecWvrBkxbk0ENu0hjrM9ELJn5B-AzL-rN_oO9w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Nov 2021 12:38:30 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v2 2/2] vimdiff: add tool documentation
Date:   Sun, 14 Nov 2021 18:38:20 +0100
Message-Id: <20211114173820.687467-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114173820.687467-1-greenfoo@u92.eu>
References: <20211114173820.687467-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running 'git {merge,diff}tool --tool-help' now also prints usage
information about the vimdiff tool (and its variantes) instead of just
its name.

Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
added to the set of functions that each merge tool (ie. scripts found
inside "mergetools/") can overwrite to provided tool specific
information.

Right now, only 'mergetools/vimdiff' implements these functions, but
other tools are encouraged to do so in the future, specially if they
take configuration options not explained anywhere else (as it is the
case with the 'vimdiff' tool and the new 'layout' option)

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 git-mergetool--lib.sh |  14 +++
 mergetools/vimdiff    | 262 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 542a6a75eb..555fdd0392 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -64,6 +64,12 @@ $(list_tool_variants)"
 				fi
 				shown_any=yes
 				printf "%s%s\n" "$per_line_prefix" "$toolname"
+
+				diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname" |
+				while read -r line
+				do
+					printf "%s\t%s\n" "$per_line_prefix" "$line"
+				done
 			fi
 		done
 
@@ -162,10 +168,18 @@ setup_tool () {
 		return 1
 	}
 
+	diff_cmd_help () {
+		return 0
+	}
+
 	merge_cmd () {
 		return 1
 	}
 
+	merge_cmd_help () {
+		return 0
+	}
+
 	hide_resolved_enabled () {
 		return 0
 	}
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index c7b3cf84a2..faef0d6a63 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -462,6 +462,47 @@ diff_cmd () {
 }
 
 
+diff_cmd_help() {
+	case "$1" in
+	vimdiff)
+		cat <<-\EOF
+		Opens vim with two vertical windows: LOCAL changes will be placed in the left
+		window and REMOTE changes in the right one.
+		EOF
+		;;
+	vimdiff*)
+		cat <<-\EOF
+		Same as 'vimdiff'
+		EOF
+		;;
+	gvimdiff)
+		cat <<-\EOF
+		Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
+		opening its own window)
+		EOF
+		;;
+	gvimdiff*)
+		cat <<-\EOF
+		Same as 'gvimdiff'
+		EOF
+		;;
+	nvimdiff)
+		cat <<-\EOF
+		Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
+		'vim' 'focused on extensibility and usability' according to their authors)
+		EOF
+		;;
+	nvimdiff*)
+		cat <<-\EOF
+		Same as 'nvimdiff'
+		EOF
+		;;
+	esac
+
+	return 0
+}
+
+
 merge_cmd () {
 	layout=$(git config mergetool.$merge_tool.layout)
 
@@ -533,6 +574,227 @@ merge_cmd () {
 }
 
 
+merge_cmd_help() {
+	case "$1" in
+	vimdiff)
+		cat <<-\EOF
+		Opens vim with a 4 windows layout distributed in the following way:
+		
+		    ------------------------------------------
+		    |             |           |              |
+		    |   LOCAL     |   BASE    |   REMOTE     |
+		    |             |           |              |
+		    ------------------------------------------
+		    |                                        |
+		    |                MERGED                  |
+		    |                                        |
+		    ------------------------------------------
+		
+		"LOCAL", "BASE" and "REMOTE" are read-only buffers showing the contents of the
+		conflicting file in a specific git commit ("commit you are merging into",
+		"common ancestor commit" and "commit you are merging from" respectively)
+		
+		"MERGED" is a writable buffer where you have to resolve the conflicts (using the
+		other read-only buffers as a reference). Once you are done, save and exit "vim"
+		as usual (":wq") or, if you want to abort, exit using ":cq".
+		
+		You can change the windows layout used by vim by setting configuration variable
+		"mergetool.vimdiff.layout" which accepts a string where these separators have
+		special meaning:
+		
+		  - "+" is used to "open a new tab"
+		  - "," is used to "open a new vertical split"
+		  - "/" is used to "open a new horizontal split"
+		  - "@" is used to indicate which is the file containing the final version after
+		    solving the conflicts. In not present, "MERGED" will be used by default.
+		
+		The precedence of the operators is this one (you can use parenthesis to change
+		it):
+		
+		    @ > + > / > ,
+		
+		Let's see some examples to undertand how it works:
+		
+		  * layout = "(LOCAL,BASE,REMOTE)/MERGED"
+		
+		    This is exactly the same as the default layout we have already seen.
+		
+		    Note that "/" has precedence over "," and thus the parenthesis are not
+		    needed in this case. The next layout definition is equivalent:
+		
+		        layout = "LOCAL,BASE,REMOTE / MERGED"
+		
+		  * layout = "LOCAL,MERGED,REMOTE"
+		
+		    If, for some reason, we are not interested in the "BASE" buffer.
+		
+		           ------------------------------------------
+		           |             |           |              |
+		           |             |           |              |
+		           |   LOCAL     |   MERGED  |   REMOTE     |
+		           |             |           |              |
+		           |             |           |              |
+		           ------------------------------------------
+		
+		  * layout = "MERGED"
+		
+		    Only the "MERGED" buffer will be shown. Note, however, that all the other
+		    ones are still loaded in vim, and you can access them with the "buffers"
+		    command. 
+		
+		           ------------------------------------------
+		           |                                        |
+		           |                                        |
+		           |                 MERGED                 |
+		           |                                        |
+		           |                                        |
+		           ------------------------------------------
+		
+		  * layout = "@LOCAL,REMOTE"
+		
+		    When "MERGED" is not present in the layout, you must "mark" one of the
+		    buffers with an asterisk. That will become the buffer you need to edit and
+		    save after resolving the conflicts.
+		
+		           ------------------------------------------
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           |     LOCAL         |    REMOTE          |
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           ------------------------------------------
+		
+		  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"
+		
+		    Three tabs will open: the first one is a copy of the default layout, while
+		    the other two only show the differences between "BASE" and "LOCAL" and
+		    "BASE" and "REMOTE" respectively.
+		 
+		           ------------------------------------------
+		           | <TAB #1> |  TAB #2  |  TAB #3  |       |
+		           ------------------------------------------
+		           |             |           |              |
+		           |   LOCAL     |   BASE    |   REMOTE     |
+		           |             |           |              |
+		           ------------------------------------------
+		           |                                        |
+		           |                MERGED                  |
+		           |                                        |
+		           ------------------------------------------
+		
+		           ------------------------------------------
+		           |  TAB #1  | <TAB #2> |  TAB #3  |       |
+		           ------------------------------------------
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           |     BASE          |    LOCAL           |
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           ------------------------------------------
+		
+		           ------------------------------------------
+		           |  TAB #1  |  TAB #2  | <TAB #3> |       |
+		           ------------------------------------------
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           |     BASE          |    REMOTE          |
+		           |                   |                    |
+		           |                   |                    |
+		           |                   |                    |
+		           ------------------------------------------
+		
+		  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
+		
+		    Same as the previous example, but adds a fourth tab with the same
+		    information as the first tab, with a different layout.
+		 
+		           ---------------------------------------------
+		           |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
+		           ---------------------------------------------
+		           |       LOCAL         |                     |
+		           |---------------------|                     |
+		           |       BASE          |        MERGED       |
+		           |---------------------|                     |
+		           |       REMOTE        |                     |
+		           ---------------------------------------------
+		
+		    Note how in the third tab definition we need to use parenthesis to make ","
+		    more prioritary than "/".
+		
+		EOF
+		;;
+	vimdiff1)
+		cat <<-\EOF
+		Same as 'vimdiff' using this layout: "@LOCAL,REMOTE"
+		EOF
+		;;
+	vimdiff2)
+		cat <<-\EOF
+		Same as 'vimdiff' using this layout: "LOCAL,MERGED,REMOTE"
+		EOF
+		;;
+	vimdiff3)
+		cat <<-\EOF
+		Same as 'vimdiff' using this layout: "MERGED"
+		EOF
+		;;
+	gvimdiff)
+		cat <<-\EOF
+		Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
+		opening its own window).
+		The desired layout can be set with configuration variable
+		"mergetool.gvimdiff.layout"
+		EOF
+		;;
+	gvimdiff1)
+		cat <<-\EOF
+		Same as 'gvimdiff' using this layout: "@LOCAL,REMOTE"
+		EOF
+		;;
+	gvimdiff2)
+		cat <<-\EOF
+		Same as 'gvimdiff' using this layout: "LOCAL,MERGED,REMOTE"
+		EOF
+		;;
+	gvimdiff3)
+		cat <<-\EOF
+		Same as 'gvimdiff' using this layout: "MERGED"
+		EOF
+		;;
+	nvimdiff)
+		cat <<-\EOF
+		Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
+		'vim' 'focused on extensibility and usability' according to their authors)
+		The desired layout can be set with configuration variable
+		"mergetool.nvimdiff.layout"
+		EOF
+		;;
+	nvimdiff1)
+		cat <<-\EOF
+			Same as 'nvimdiff' using this layout: "@LOCAL,REMOTE"
+		EOF
+		;;
+	nvimdiff2)
+		cat <<-\EOF
+		Same as 'nvimdiff' using this layout: "LOCAL,MERGED,REMOTE"
+		EOF
+		;;
+	nvimdiff3)
+		cat <<-\EOF
+		Same as 'nvimdiff' using this layout: "MERGED"
+		EOF
+		;;
+	esac
+
+	return 0
+}
+
+
 translate_merge_tool_path() {
 	case "$1" in
 	nvimdiff*)
-- 
2.33.1


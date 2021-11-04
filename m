Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B15C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956E160D43
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhKDQMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:12:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43943 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231613AbhKDQMw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 12:12:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1ACC85C014B;
        Thu,  4 Nov 2021 12:10:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Nov 2021 12:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=MUi0RQf7MuZ1D
        ZWnZ8Tyw1fVrnH3NGWM7EVcCSqKPL8=; b=reRLs5ULYYZJS1jq5Bytu9z/e2Dyk
        YI5crNcDZVAw1jVGrdbqE466DVgscSFK4gdtMoHrcb5BG5twvPoNG7gw+3JpHNYI
        JIsEiqpS8Iawn8P+cKicqNYO4FSRDBn+4SkPn6s4kEwPOQnsvUcZ2UXzb0Vz5Irc
        U9zqvVX5UhOvRYqPsaweKFFLDYk/idZ7bzbl3fIfrH3wMpC5SI2Ypk255pVGv8Fh
        PX83zmynsMC008mnyAe64xIvvgFqI7RSJJVJBME88qA86Pg4IOnKycTDfipxgUms
        BQcMuGacKH621aShcmskFS1oHKb25WX5N9PeFTl/OVRusJ109nV0ZlXuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MUi0RQf7MuZ1DZWnZ8Tyw1fVrnH3NGWM7EVcCSqKPL8=; b=QP8Sj6Rh
        VERYiu1tso2IyYfFNsOG92VUalz3CycvZNDfGqzJAj2fLAB6qNCYaEnqBJ/mQREn
        hAqAJGszfB91zBYFSFPIpYFHxYO+qDQXBRx2SovElevi4PZcADn46QkDMkXZ4/xB
        2WFIkp7YgKXmpztq+3RRvP6eaY2wxRXUmelLgVRSGBkloCbCdpxIq0XZUN+nOEcR
        r5GIZqwoQiAdiNw0Ml5Il+wnPmAXhn76s5YmNiNekoc+62DzFT6IbUGMPWvgVxR9
        oDAXbk/a7Mzqib0e3jkt4GpXUqpQTxfIrD+Bj6KHzl2T1zxXeemollmYrzpguEAy
        SfSU2M2/PPGJhw==
X-ME-Sender: <xms:5QWEYd2D45kN68y6ntrjEgJOcppOrSkj7jLtppJTxoRXOl6gmHmPwA>
    <xme:5QWEYUHPCWxROtq8y_aMRbrsTcgjbpKsH-HhriM6LfoMXedNdW9wWGpxlj23tmQd0
    jaaS1orVU8_qX1pEA>
X-ME-Received: <xmr:5QWEYd78rTWZCQEWrd9_XUrHKjUYm38Yzgnc9xwmBlXzlS0bBydruF67Kh1DbMga5eAUpm_LIWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohes
    uhelvddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvdfgue
    egffeuveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:5QWEYa2KzxElcA2Y4ZLD-V7f0X2wgjCWwxtBEG1tvb2Lkphk1P97AQ>
    <xmx:5QWEYQE-tSVDwJP1r8NXwPOIinDcOOgPr617MAn28rRT2XDg4-NzbA>
    <xmx:5QWEYb_osmv81t7SWkSJw9tetVOzN_l0b0E0MELa1EYXeSF-VQab4g>
    <xmx:5gWEYcg1VFyYCbB9Q7iKBGY6DVgqCjRaV8mPNsk_GgmIpMEpHldJ5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 12:10:11 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH 2/3] vimdiff: add tool documentation
Date:   Thu,  4 Nov 2021 17:09:58 +0100
Message-Id: <20211104160959.183402-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104160959.183402-1-greenfoo@u92.eu>
References: <20211104160959.183402-1-greenfoo@u92.eu>
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
 git-mergetool--lib.sh |  12 ++
 mergetools/vimdiff    | 272 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 542a6a75eb..3964cd8f99 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -64,6 +64,10 @@ $(list_tool_variants)"
 				fi
 				shown_any=yes
 				printf "%s%s\n" "$per_line_prefix" "$toolname"
+				while IFS= read -r line
+				do
+					printf "%s\t%s\n" "$per_line_prefix" "$line"
+                                done < <(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
 			fi
 		done
 
@@ -162,10 +166,18 @@ setup_tool () {
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
index 1f2e88777e..aa8fbc0a19 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -428,6 +428,46 @@ diff_cmd () {
 		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
 }
 
+diff_cmd_help() {
+	case "$1" in
+	vimdiff)
+		cat <<-ENDOFMESSAGE
+			Opens vim with two vertical windows: LOCAL changes will be placed in the left
+			window and REMOTE changes in the right one.
+		ENDOFMESSAGE
+		;;
+	vimdiff*)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff'
+		ENDOFMESSAGE
+		;;
+	gvimdiff)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
+			opening its own window)
+		ENDOFMESSAGE
+		;;
+	gvimdiff*)
+		cat <<-ENDOFMESSAGE
+			Same as 'gvimdiff'
+		ENDOFMESSAGE
+		;;
+	nvimdiff)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
+			'vim' 'focused on extensibility and usability' according to their authors)
+		ENDOFMESSAGE
+		;;
+	nvimdiff*)
+		cat <<-ENDOFMESSAGE
+			Same as 'nvimdiff'
+		ENDOFMESSAGE
+		;;
+	esac
+
+	return 0
+}
+
 
 merge_cmd () {
 	layout=$(git config mergetool.$merge_tool.layout)
@@ -503,6 +543,238 @@ merge_cmd () {
 	return "$ret"
 }
 
+merge_cmd_help() {
+	case "$1" in
+	vimdiff)
+		cat <<-ENDOFMESSAGE
+			Opens vim with a 4 windows layout distributed in the following way:
+			
+			    ------------------------------------------
+			    |             |           |              |
+			    |   LOCAL     |   BASE    |   REMOTE     |
+			    |             |           |              |
+			    ------------------------------------------
+			    |                                        |
+			    |                MERGED                  |
+			    |                                        |
+			    ------------------------------------------
+			
+			"LOCAL", "BASE" and "REMOTE" are read-only buffers showing the contents of the
+			conflicting file in a specific git commit ("commit you are merging into",
+			"common ancestor commit" and "commit you are merging from" respectively)
+			
+			"MERGED" is a writable buffer where you have to resolve the conflicts (using the
+			other read-only buffers as a reference). Once you are done, save and exit "vim"
+			as usual (":wq") or, if you want to abort, exit using ":cq".
+			
+			You can change the windows layout used by vim by setting configuration variable
+			"mergetool.vimdiff.layout" which accepts a string where these separators have
+			special meaning:
+			
+			  - ";" is used to "open a new tab"
+			  - "-" is used to "open a new vertical split"
+			  - "|" is used to "open a new horizontal split"
+			
+			Let's see some examples to undertand how it works:
+			
+			  * layout = "(LOCAL | BASE | REMOTE) - MERGED"
+			
+			    This is exactly the same as the default layout we have already seen.
+			
+			  * layout = "LOCAL | MERGED | REMOTE"
+			
+			    If, for some reason, we are not interested in the "BASE" buffer.
+			
+			           ------------------------------------------
+			           |             |           |              |
+			           |             |           |              |
+			           |   LOCAL     |   MERGED  |   REMOTE     |
+			           |             |           |              |
+			           |             |           |              |
+			           ------------------------------------------
+			
+			  * layout = "MERGED"
+			
+			    Only the "MERGED" buffer will be shown. Note, however, that all the other
+			    ones are still loaded in vim, and you can access them with the "buffers"
+			    command. 
+			
+			           ------------------------------------------
+			           |                                        |
+			           |                                        |
+			           |                 MERGED                 |
+			           |                                        |
+			           |                                        |
+			           ------------------------------------------
+			
+			  * layout = "LOCAL* | REMOTE"
+			
+			    When "MERGED" is not present in the layout, you must "mark" one of the
+			    buffers with an asterisk. That will become the buffer you need to edit and
+			    save after resolving the conflicts.
+			
+			           ------------------------------------------
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           |     LOCAL         |    REMOTE          |
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           ------------------------------------------
+			
+                          * layout = "(LOCAL | BASE | REMOTE) - MERGED; BASE | LOCAL; BASE | REMOTE"
+			
+			    Three tabs will open: the first one is a copy of the default layout, while
+			    the other two only show the differences between "BASE" and "LOCAL" and
+			    "BASE" and "REMOTE" respectively.
+			 
+			           ------------------------------------------
+			           | <TAB #1> |  TAB #2  |  TAB #3  |       |
+			           ------------------------------------------
+			           |             |           |              |
+			           |   LOCAL     |   BASE    |   REMOTE     |
+			           |             |           |              |
+			           ------------------------------------------
+			           |                                        |
+			           |                MERGED                  |
+			           |                                        |
+			           ------------------------------------------
+			
+			           ------------------------------------------
+			           |  TAB #1  | <TAB #2> |  TAB #3  |       |
+			           ------------------------------------------
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           |     BASE          |    LOCAL           |
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           ------------------------------------------
+			
+			           ------------------------------------------
+			           |  TAB #1  |  TAB #2  | <TAB #3> |       |
+			           ------------------------------------------
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           |     BASE          |    REMOTE          |
+			           |                   |                    |
+			           |                   |                    |
+			           |                   |                    |
+			           ------------------------------------------
+			
+                          * layout = "(LOCAL | BASE | REMOTE) - MERGED; BASE | LOCAL; BASE | REMOTE; (LOCAL - BASE - REMOTE) | MERGED"
+			
+			    Same as the previous example, but adds a fourth tab with the same
+			    information as the first tab, with a different layout.
+			 
+			           ---------------------------------------------
+			           |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
+			           ---------------------------------------------
+			           |       LOCAL         |                     |
+			           |---------------------|                     |
+			           |       BASE          |        MERGED       |
+			           |---------------------|                     |
+			           |       REMOTE        |                     |
+			           ---------------------------------------------
+
+		ENDOFMESSAGE
+		;;
+	vimdiff1)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' using this layout: "LOCAL* | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "vimdiff" and
+			manually set the "mergetool.vimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	vimdiff2)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' using this layout: "LOCAL | MERGED | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "vimdiff" and
+			manually set the "mergetool.vimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	vimdiff3)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' using this layout: "MERGED"
+			
+			This will probably be deprecated in the future. Please use "vimdiff" and
+			manually set the "mergetool.vimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	gvimdiff)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
+			opening its own window).
+			The desired layout can be set with configuration variable
+			"mergetool.gvimdiff.layout"
+		ENDOFMESSAGE
+		;;
+	gvimdiff1)
+		cat <<-ENDOFMESSAGE
+			Same as 'gvimdiff' using this layout: "LOCAL* | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "gvimdiff" and
+			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	gvimdiff2)
+		cat <<-ENDOFMESSAGE
+			Same as 'gvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "gvimdiff" and
+			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	gvimdiff3)
+		cat <<-ENDOFMESSAGE
+			Same as 'gvimdiff' using this layout: "MERGED"
+			
+			This will probably be deprecated in the future. Please use "gvimdiff" and
+			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	nvimdiff)
+		cat <<-ENDOFMESSAGE
+			Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
+			'vim' 'focused on extensibility and usability' according to their authors)
+			The desired layout can be set with configuration variable
+			"mergetool.nvimdiff.layout"
+		ENDOFMESSAGE
+		;;
+	nvimdiff1)
+		cat <<-ENDOFMESSAGE
+			Same as 'nvimdiff' using this layout: "LOCAL* | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "nvimdiff" and
+			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	nvimdiff2)
+		cat <<-ENDOFMESSAGE
+			Same as 'nvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
+			
+			This will probably be deprecated in the future. Please use "nvimdiff" and
+			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	nvimdiff3)
+		cat <<-ENDOFMESSAGE
+			Same as 'nvimdiff' using this layout: "MERGED"
+			
+			This will probably be deprecated in the future. Please use "nvimdiff" and
+			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
+		ENDOFMESSAGE
+		;;
+	esac
+
+	return 0
+}
+
 
 translate_merge_tool_path() {
 	case "$1" in
-- 
2.33.1


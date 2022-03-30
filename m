Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B8C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiC3TVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350821AbiC3TVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 15:21:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314338A6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:19:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 908B13201FC9;
        Wed, 30 Mar 2022 15:19:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Mar 2022 15:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=+yYKrS2mGKQRMn1yyP2grddp6wKugP
        CKuGMLnOmr4nA=; b=omggbCd0nY3haIPAM8vfLgqmz8aGVT6FHCubeR6oJF1ZOd
        DlAwFAnfdoZtUfhOLaIyB1MvJXTZ9odWFxhlVStlO2BKO687RfowJYVQTfbDPDBT
        8LJu/dE4lUK9kp/qi5maKdEjCCIqnCZJMB4hePP/BMTAM5OmX6+6iaaR7GXKoPTO
        PdXGF/+taxkEXWlVB4vrWlw23+rQxbaClqFAvJtwUFOLQqpQrZHELouYdNZi2Ist
        09OwzXnIQf/RAtJPPtWixGdksz9/Zcer+Vk3ZEiXKJb9rjKjWDHmUBSNIlhLpdOL
        potxDGMR/vkuOHFhSCn78XNJGbw5z1Iq9gRpRYfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+yYKrS
        2mGKQRMn1yyP2grddp6wKugPCKuGMLnOmr4nA=; b=MwtHjmxYS29WKZBxrxwLFO
        P6k+7mD48NgMtb+jYwZAi+fzV6U0er0LQ4nw1/m5hXugATr003UZ+jpre4HyfeJl
        77329JTuTkmLOawFAX7BSxOreMY1mj/x4voidkE/p2Wh8xHXdrIZyvHuagk58trW
        o7C8ODW/l1NIo8X5ZSO5aTYC+/Tn4Y2I+Hcl87euf3WQVPsIThGiBiHu1s7x6Amw
        M8pyyIH5oaKEaKoNfwtcI1TpgSPo3D/pqu/v6IGql4VkZJqQxmVMPjckwx6Losbm
        nd+9ELi6iKdCT1pSV/FePyOEK/Bpzej49BMVGrLCIhpK6ZR2qMOoBoWVcfwJjwVQ
        ==
X-ME-Sender: <xms:P61EYtPUNTz_XgvMMzor0jxa2wj7Pl0WMkn694MBoKRuC_60GHIyYA>
    <xme:P61EYv9Lm3RKQ7mD-1p7Q0qHbIJLTkAEjPBXOIBZVuyxVvZEv_gCuiEji-Jc7dt6p
    8oVewDYGAA2vGGKng>
X-ME-Received: <xmr:P61EYsTN2lRNuCYPYNzik-CYWM5M5EUXgmukbdEDzkV08tmrXGvIcefYDOW35K55Mf--qHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvd
    fgueegffeuveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedunecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:P61EYpsgm6OUJJLjsloyz4I3B9tJgoNXyIhf0e4m-S45QemBfWjlig>
    <xmx:P61EYlfof70cMeRrQuOg0h3GVpA5oBPiqdOishPuuSnBUwT-NogHMA>
    <xmx:P61EYl2zTr1uBejrT7WDmdLf_bv8OQBcL8-d6UyiHv28A8UFxhrSRw>
    <xmx:P61EYvvT-9NtbfBhMDBxsQCcNiAq7Js6cs6bpG13X4j9x6E99Z7LDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 15:19:25 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com, greenfoo@u92.eu
Subject: [PATCH v9 3/4] vimdiff: add tool documentation
Date:   Wed, 30 Mar 2022 21:19:08 +0200
Message-Id: <20220330191909.294610-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330191909.294610-1-greenfoo@u92.eu>
References: <20220329224439.290948-1-greenfoo@u92.eu>
 <20220330191909.294610-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running 'git {merge,diff}tool --tool-help' now also prints usage
information about the vimdiff tool (and its variants) instead of just
its name.

Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
added to the set of functions that each merge tool (ie. scripts found
inside "mergetools/") can overwrite to provided tool specific
information.

Right now, only 'mergetools/vimdiff' implements these functions, but
other tools are encouraged to do so in the future, specially if they
take configuration options not explained anywhere else (as it is the
case with the 'vimdiff' tool and the new 'layout' option)

Note that the function 'show_tool_names', used in the implmentation of
'git mergetool --tool-help', is also used in Documentation/Makefile to
generate the list of allowed values for the configuration variables
'{diff,merge}.{gui,}tool'. Adjust the rule so its output is an Asciidoc
"description list" instead of a plain list, with the tool name as the
item and the newly added tool description as the description.

In addition, a section has been added to
"Documentation/git-mergetool.txt" to explain the new "layout"
configuration option with examples.

Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 Documentation/Makefile               |   8 +-
 Documentation/config/mergetool.txt   |   9 ++
 Documentation/git-mergetool.txt      |   8 ++
 Documentation/mergetools/vimdiff.txt | 194 +++++++++++++++++++++++++++
 git-mergetool--lib.sh                |  10 +-
 mergetools/vimdiff                   |  53 ++++++++
 6 files changed, 277 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/mergetools/vimdiff.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1eb9192dae..faed285462 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -302,12 +302,12 @@ $(mergetools_txt): mergetools-list.made
 
 mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 	$(QUIET_GEN) \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=diff && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=merge && \
 		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
+		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
 	date >$@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index cafbbef46a..90b3809700 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -45,6 +45,15 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
+mergetool.vimdiff.layout::
+	The vimdiff backend uses this variable to control how its split
+	windows look like. Applies even if you are using Neovim (`nvim`) or
+	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
+ifndef::git-mergetool[]
+	in linkgit:git-mergetool[1].
+endif::[]
+	for details.
+
 mergetool.hideResolved::
 	During a merge Git will automatically resolve as many conflicts as
 	possible and write the 'MERGED' file containing conflict markers around
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e587c7763a..f784027bc1 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -101,6 +101,7 @@ success of the resolution after the custom tool has exited.
 
 CONFIGURATION
 -------------
+:git-mergetool: 1
 include::config/mergetool.txt[]
 
 TEMPORARY FILES
@@ -113,6 +114,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
 causes `git mergetool` to automatically remove the backup as files
 are successfully merged.
 
+BACKEND SPECIFIC HINTS
+----------------------
+
+vimdiff
+~~~~~~~
+include::mergetools/vimdiff.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
new file mode 100644
index 0000000000..2d631e9b1f
--- /dev/null
+++ b/Documentation/mergetools/vimdiff.txt
@@ -0,0 +1,194 @@
+Description
+^^^^^^^^^^^
+
+When specifying `--tool=vimdiff` in `git mergetool` Git will open Vim with a 4
+windows layout distributed in the following way:
+....
+------------------------------------------
+|             |           |              |
+|   LOCAL     |   BASE    |   REMOTE     |
+|             |           |              |
+------------------------------------------
+|                                        |
+|                MERGED                  |
+|                                        |
+------------------------------------------
+....
+`LOCAL`, `BASE` and `REMOTE` are read-only buffers showing the contents of the
+conflicting file in specific commits ("commit you are merging into", "common
+ancestor commit" and "commit you are merging from" respectively)
+
+`MERGED` is a writable buffer where you have to resolve the conflicts (using the
+other read-only buffers as a reference). Once you are done, save and exit Vim as
+usual (`:wq`) or, if you want to abort, exit using `:cq`.
+
+Layout configuration
+^^^^^^^^^^^^^^^^^^^^
+
+You can change the windows layout used by Vim by setting configuration variable
+`mergetool.vimdiff.layout` which accepts a string where the following separators
+have special meaning:
+
+  - `+` is used to "open a new tab"
+  - `,` is used to "open a new vertical split"
+  - `/` is used to "open a new horizontal split"
+  - `@` is used to indicate which is the file containing the final version after
+    solving the conflicts. If not present, `MERGED` will be used by default.
+
+The precedence of the operators is this one (you can use parentheses to change
+it):
+
+    `@` > `+` > `/` > `,`
+
+Let's see some examples to understand how it works:
+
+* `layout = "(LOCAL,BASE,REMOTE)/MERGED"`
++
+--
+This is exactly the same as the default layout we have already seen.
+
+Note that `/` has precedence over `,` and thus the parenthesis are not
+needed in this case. The next layout definition is equivalent:
+
+    layout = "LOCAL,BASE,REMOTE / MERGED"
+--
+* `layout = "LOCAL,MERGED,REMOTE"`
++
+--
+If, for some reason, we are not interested in the `BASE` buffer.
+....
+------------------------------------------
+|             |           |              |
+|             |           |              |
+|   LOCAL     |   MERGED  |   REMOTE     |
+|             |           |              |
+|             |           |              |
+------------------------------------------
+....
+--
+* `layout = "MERGED"`
++
+--
+Only the `MERGED` buffer will be shown. Note, however, that all the other
+ones are still loaded in vim, and you can access them with the "buffers"
+command.
+....
+------------------------------------------
+|                                        |
+|                                        |
+|                 MERGED                 |
+|                                        |
+|                                        |
+------------------------------------------
+....
+--
+* `layout = "@LOCAL,REMOTE"`
++
+--
+When `MERGED` is not present in the layout, you must "mark" one of the
+buffers with an asterisk. That will become the buffer you need to edit and
+save after resolving the conflicts.
+....
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     LOCAL         |    REMOTE          |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"`
++
+--
+Three tabs will open: the first one is a copy of the default layout, while
+the other two only show the differences between (`BASE` and `LOCAL`) and
+(`BASE` and `REMOTE`) respectively.
+....
+------------------------------------------
+| <TAB #1> |  TAB #2  |  TAB #3  |       |
+------------------------------------------
+|             |           |              |
+|   LOCAL     |   BASE    |   REMOTE     |
+|             |           |              |
+------------------------------------------
+|                                        |
+|                MERGED                  |
+|                                        |
+------------------------------------------
+....
+....
+------------------------------------------
+|  TAB #1  | <TAB #2> |  TAB #3  |       |
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     BASE          |    LOCAL           |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
+....
+------------------------------------------
+|  TAB #1  |  TAB #2  | <TAB #3> |       |
+------------------------------------------
+|                   |                    |
+|                   |                    |
+|                   |                    |
+|     BASE          |    REMOTE          |
+|                   |                    |
+|                   |                    |
+|                   |                    |
+------------------------------------------
+....
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"`
++
+--
+Same as the previous example, but adds a fourth tab with the same
+information as the first tab, with a different layout.
+....
+---------------------------------------------
+|  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
+---------------------------------------------
+|       LOCAL         |                     |
+|---------------------|                     |
+|       BASE          |        MERGED       |
+|---------------------|                     |
+|       REMOTE        |                     |
+---------------------------------------------
+....
+Note how in the third tab definition we need to use parenthesis to make `,`
+have precedence over `/`.
+--
+
+Variants
+^^^^^^^^
+
+Instead of `--tool=vimdiff`, you can also use one of these other variants:
+
+  * `--tool=gvimdiff`, to open gVim instead of Vim.
+
+  * `--tool=nvimdiff`, to open Neovim instead of Vim.
+
+When using these variants, in order to specify a custom layout you will have to
+set configuration variables `mergetool.gvimdiff.layout` and
+`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
+
+In addition, for backwards compatibility with previous Git versions, you can
+also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
+`vimdiff3`, `nvimdiff1`, etc...) to use a predefined layout.
+In other words, using `--tool=[g,n,]vimdiffx` is the same as using
+`--tool=[g,n,]vimdiff` and setting configuration variable
+`mergetool.[g,n,]vimdiff.layout` to...
+
+  * `x=1`: `"@LOCAL, REMOTE"`
+  * `x=2`: `"LOCAL, MERGED, REMOTE"`
+  * `x=3`: `"MERGED"`
+
+Example: using `--tool=gvimdiff2` will open `gvim` with three columns (LOCAL,
+MERGED and REMOTE).
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 542a6a75eb..9f99201bcc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -63,7 +63,7 @@ $(list_tool_variants)"
 					preamble=
 				fi
 				shown_any=yes
-				printf "%s%s\n" "$per_line_prefix" "$toolname"
+				printf "%s%-15s  %s\n" "$per_line_prefix" "$toolname" $(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname")
 			fi
 		done
 
@@ -162,10 +162,18 @@ setup_tool () {
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
index 9d1bf4f455..461a89b6f9 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -365,6 +365,25 @@ diff_cmd () {
 }
 
 
+diff_cmd_help () {
+	TOOL=$1
+
+	case "$TOOL" in
+	nvimdiff*)
+		printf "Use Neovim"
+		;;
+	gvimdiff*)
+		printf "Use gVim (requires a graphical session)"
+		;;
+	vimdiff*)
+		printf "Use Vim"
+		;;
+	esac
+
+	return 0
+}
+
+
 merge_cmd () {
 	layout=$(git config mergetool.vimdiff.layout)
 
@@ -436,6 +455,40 @@ merge_cmd () {
 }
 
 
+merge_cmd_help () {
+	TOOL=$1
+
+	case "$TOOL" in
+	nvimdiff*)
+		printf "Use Neovim "
+		;;
+	gvimdiff*)
+		printf "Use gVim (requires a graphical session) "
+		;;
+	vimdiff*)
+		printf "Use Vim "
+		;;
+	esac
+
+	case "$TOOL" in
+	*1)
+		echo "with a 2 panes layout (LOCAL and REMOTE)"
+		;;
+	*2)
+		echo "with a 3 panes layout (LOCAL, MERGED and REMOTE)"
+		;;
+	*3)
+		echo "where only the MERGED file is shown"
+		;;
+	*)
+		echo "with a custom layout (see \`git help mergetool\`'s \`BACKEND SPECIFIC HINTS\` section)"
+		;;
+	esac
+
+	return 0
+}
+
+
 translate_merge_tool_path () {
 	case "$1" in
 	nvimdiff*)
-- 
2.35.1


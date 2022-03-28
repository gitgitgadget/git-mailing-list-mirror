Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94875C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiC1Wcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiC1WcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:32:20 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919D048307
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:30:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A4D8132020DD;
        Mon, 28 Mar 2022 18:30:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Mar 2022 18:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=6jZn5REnaK0bM2C+3cU6F7mH8nTNnb
        mQ0dBNLhl3O0c=; b=ZMMjlJBDrJu/KV+2nSiL8zJp74EkoaACnCeupQtT1ljQ5A
        3HzZPofN/eYuz1DXhogO3n9dXDktHy5mpvwd2rD8j52BDsby2ze9/rpPbP5Xwdcd
        wMfk6h2e4t8as2qDEEpUK8B0/q1Hci5pFxgoTeIXOaIrHx2+NlyyI4vMp+JGGGn2
        xr2o3sSwhcBtLpR2ZzsRtPSQ8MBWZ8axZbjZvVle5QiNqzpiK/CPJN63y5WwqBXB
        87SnSe7CidkrLrmoIUXa3VpBkoPI9R85HtvHM01HfGNrL0d74O42ClEZzf58AcmY
        UUMYuCBa1rzk6ScWlpZskRNGGMUctGFnTCBU9xNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6jZn5R
        EnaK0bM2C+3cU6F7mH8nTNnbmQ0dBNLhl3O0c=; b=eKD1rZnl6dD2C6c5D9YGba
        lQkt4Ij/FMQ+K8lsw0ajakM5rEM4bkmt1I7iNDz1n6IReBkHgTiq91/fyqRS0wND
        uwFVJaigEc+vSuS+ZfFArYJc2HqmNiST5th1apBlEgcgA/dcouSwPEhjBKaAfh1F
        F2EntgQKB7O3ScGAEX693Xo7bgtBlr/c5+szr7hOWYbwk1DOpg4DlWNqygv2ySlL
        dxvE8rNP1a62WFVQNa73GkkwUL119qpCbZWaWXe3IPVWlCQ+QwxuMzVDEdxr1g1k
        AUV4wpseuK2+Eos8SfiTF/goYFLD/0hLDSaBiVt9OCjveSVFzlklpto8MKhxAucQ
        ==
X-ME-Sender: <xms:CjdCYvuvPDK_gkHfVtX5UHb2ICPJRiXbjk-88QtvgNLear79YLlAjA>
    <xme:CjdCYgeMTBdcvY9kyeXMd2cUu6aCpaBxZjbxiCW2qkVG5aWsC5P3AlUWtSAAS8K3Q
    UlJdF6aslKSq4w6Cw>
X-ME-Received: <xmr:CjdCYixBOtEU85Lqcefw7nTQVYiRvKIp3QU69Pdc3Cw4FpGlxJ9M0q0tUf8yI6ag8C3fi-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:CjdCYuOzzu0DjfNMI27WFuGaebonp4jOFXQaa31Vh8lkGM6wgQWDMA>
    <xmx:CjdCYv9NKOJhUZUbxx37aCoucMRswtoW7TA8MrACK8Ycp6y_Th-gJA>
    <xmx:CjdCYuXrNgtlpKQUuqyTAXp22Vx6GEDuvFmPUaKa5Nakp_n77q4U4Q>
    <xmx:CjdCYvwJ8sPbzs1C4KduIlViMAbek6v1FHR4HVjaYtFxQQJLPLvJBg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 18:30:32 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: [PATCH v7 3/4] vimdiff: add tool documentation
Date:   Tue, 29 Mar 2022 00:30:18 +0200
Message-Id: <20220328223019.271270-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328223019.271270-1-greenfoo@u92.eu>
References: <20220328223019.271270-1-greenfoo@u92.eu>
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

In addition, a section has been added to
"Documentation/git-mergetool.txt" to explain the new "layout"
configuration option with examples.

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/config/mergetool.txt   |   9 ++
 Documentation/git-mergetool.txt      |   8 ++
 Documentation/mergetools/vimdiff.txt | 189 +++++++++++++++++++++++++++
 git-mergetool--lib.sh                |  10 +-
 mergetools/vimdiff                   |  53 ++++++++
 5 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mergetools/vimdiff.txt

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index cafbbef46a..13f1b234db 100644
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
+	(on linkgit:git-mergetool[1])
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
index 0000000000..f63fc48c29
--- /dev/null
+++ b/Documentation/mergetools/vimdiff.txt
@@ -0,0 +1,189 @@
+Description
+^^^^^^^^^^^
+
+When specifying `--tool=vimdiff` in `git mergetool` Git will open Vim with a 4
+windows layout distributed in the following way:
+
+    ------------------------------------------
+    |             |           |              |
+    |   LOCAL     |   BASE    |   REMOTE     |
+    |             |           |              |
+    ------------------------------------------
+    |                                        |
+    |                MERGED                  |
+    |                                        |
+    ------------------------------------------
+
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
+
+           ------------------------------------------
+           |             |           |              |
+           |             |           |              |
+           |   LOCAL     |   MERGED  |   REMOTE     |
+           |             |           |              |
+           |             |           |              |
+           ------------------------------------------
+--
+* `layout = "MERGED"`
++
+--
+Only the `MERGED` buffer will be shown. Note, however, that all the other
+ones are still loaded in vim, and you can access them with the "buffers"
+command.
+
+           ------------------------------------------
+           |                                        |
+           |                                        |
+           |                 MERGED                 |
+           |                                        |
+           |                                        |
+           ------------------------------------------
+--
+* `layout = "@LOCAL,REMOTE"`
++
+--
+When `MERGED` is not present in the layout, you must "mark" one of the
+buffers with an asterisk. That will become the buffer you need to edit and
+save after resolving the conflicts.
+
+           ------------------------------------------
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           |     LOCAL         |    REMOTE          |
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           ------------------------------------------
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"`
++
+--
+Three tabs will open: the first one is a copy of the default layout, while
+the other two only show the differences between (`BASE` and `LOCAL`) and
+(`BASE` and `REMOTE`) respectively.
+
+           ------------------------------------------
+           | <TAB #1> |  TAB #2  |  TAB #3  |       |
+           ------------------------------------------
+           |             |           |              |
+           |   LOCAL     |   BASE    |   REMOTE     |
+           |             |           |              |
+           ------------------------------------------
+           |                                        |
+           |                MERGED                  |
+           |                                        |
+           ------------------------------------------
+
+           ------------------------------------------
+           |  TAB #1  | <TAB #2> |  TAB #3  |       |
+           ------------------------------------------
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           |     BASE          |    LOCAL           |
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           ------------------------------------------
+
+           ------------------------------------------
+           |  TAB #1  |  TAB #2  | <TAB #3> |       |
+           ------------------------------------------
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           |     BASE          |    REMOTE          |
+           |                   |                    |
+           |                   |                    |
+           |                   |                    |
+           ------------------------------------------
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"`
++
+--
+Same as the previous example, but adds a fourth tab with the same
+information as the first tab, with a different layout.
+
+           ---------------------------------------------
+           |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
+           ---------------------------------------------
+           |       LOCAL         |                     |
+           |---------------------|                     |
+           |       BASE          |        MERGED       |
+           |---------------------|                     |
+           |       REMOTE        |                     |
+           ---------------------------------------------
+
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
+
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


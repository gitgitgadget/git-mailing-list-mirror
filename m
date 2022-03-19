Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D870C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 09:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiCSJNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiCSJNR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 05:13:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942148E1B4
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 02:11:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A32253200E89;
        Sat, 19 Mar 2022 05:11:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Mar 2022 05:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=UoCxkPUVblncpoxBIQY2LaLhDOrPXN
        KNHJQv/CtaBOg=; b=wyRgpJaxdZTd8qp/kJL6tuF9DCJThrQDUB8beA2nAHLZMv
        /7FzTZ3RDHGYeSetPic6aAupYAKDZfc+W6nvrf+mENGqe9FqIEc3oLA3FpXhqqiS
        cQVvimgLHpCQbI5MHuz6OfjNSzoCJTLZhlpvA8EPtHNjlyifpNrrPKk7vzYHtYX3
        IOxAqay9RZjLeIBl96yKGh1MwDF5Elw/+inH2TQRBy0ujPQi3ZRWF5bJPlymAipD
        zbww09JyoY2NOGb5/YW/j4rWeZ3C8YgImGoqv+w/VOTdQvyXX7t9LXgB2BHx4Zoe
        88TbdHEjxABZ7Bg86lwrxEqaWBZ9B1e+D1TKi2Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UoCxkP
        UVblncpoxBIQY2LaLhDOrPXNKNHJQv/CtaBOg=; b=nzYr81EBl01vGBcaAhzH0U
        IYKldLGKhAwflreMlMSg1O9KSKboZREqWoN/99SJcJvd80Sb80HvCnBZfoXczXWZ
        KnnzkM4R9A/963gdRaGURFizS87bORlFgT+MThClJTK5W8rqszvNa6QDo8D0Az4Y
        36nismY14IosgrjG9b1R6P+mvwmrRxqrLvBSiRAkFQLCAPJwTXRxN5NTEgKwax9D
        JJCbz/iK1VVwnRwrEDlfnwUf1UXM+6+AYcx39cV9G+r3sOXnPWY5jk21oiWlGVUt
        javFy5OgBjsNjY3T79Traa+Rm51g//r3wt+xJ6FEMDEKN2qChAd6fcZp5fyGTSEg
        ==
X-ME-Sender: <xms:Wp41Yu7lmSoNjivVAkFNGLKbmbXOceE748uPDwlAaL6k42IO9AJebg>
    <xme:Wp41Yn7WeAtnvDLQH_nW7uSAisRhkkXDzaEpBtY1Ih-E4YIK2WRuv5-n6ycfeKVSg
    Wkv7nbI5EQsggihRg>
X-ME-Received: <xmr:Wp41YtffsGq3PL3nQepZ0weKrc1ZppCria5hFErcheHg0BbLIHUOTeHr3OgVlgAB3QzpWHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertd
    dtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhel
    vddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvdfgueegff
    euveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:Wp41YrLkgWfuYfx-WflhPr6JSaMAwa98c2xv3rf1eKIYXl6wz0jJWw>
    <xmx:Wp41YiIQIjIMfrMcQewHdH6kAw-tAqyzAKXSTwQVWpdRYHjvdIcNFA>
    <xmx:Wp41YswGPs9UmK0HqaIf2E5fGiVq5_3QM_pZX66vP4c-MAx20bUTZw>
    <xmx:W541YkjXNEr9-D1fxGdygdmX2fVakcEC4urZpM-w48y0P0kH40DmDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 05:11:53 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v5 2/3] vimdiff: add tool documentation
Date:   Sat, 19 Mar 2022 10:11:40 +0100
Message-Id: <20220319091141.4911-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319091141.4911-1-greenfoo@u92.eu>
References: <20220319091141.4911-1-greenfoo@u92.eu>
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
 Documentation/git-difftool--vimdiff.txt  |  40 +++++
 Documentation/git-mergetool--vimdiff.txt | 195 +++++++++++++++++++++++
 git-mergetool--lib.sh                    |  14 ++
 mergetools/vimdiff                       |  12 ++
 4 files changed, 261 insertions(+)
 create mode 100644 Documentation/git-difftool--vimdiff.txt
 create mode 100644 Documentation/git-mergetool--vimdiff.txt

diff --git a/Documentation/git-difftool--vimdiff.txt b/Documentation/git-difftool--vimdiff.txt
new file mode 100644
index 0000000000..5788f8e149
--- /dev/null
+++ b/Documentation/git-difftool--vimdiff.txt
@@ -0,0 +1,40 @@
+git-mergetool{litdd}vimdiff(1)
+==============================
+
+NAME
+----
+git-difftool--vimdiff - Helper script to run vim as a diff tool
+
+SYNOPSIS
+--------
+[verse]
+'git difftool' --tool=vimdiff ... (rest of 'git difftool' options)
+
+DESCRIPTION
+-----------
+When specifying '--tool=vimdiff' in 'git difftool', git will open vim with a
+with two vertical windows: LOCAL changes will be placed in the left window and
+REMOTE changes in the right one.
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
+
+VARIANTS
+--------
+Instead of '--tool=vimdiff', you can also use these other variants:
+
+  * '--tool=gvimdiff', to open gvim instead of vim.
+
+  * '--tool=nvimdiff', to open nvim ('neovim') instead of vim.
+
+GIT
+---
+Part of the linkgit:git[1] suite
+
diff --git a/Documentation/git-mergetool--vimdiff.txt b/Documentation/git-mergetool--vimdiff.txt
new file mode 100644
index 0000000000..fb69443d3d
--- /dev/null
+++ b/Documentation/git-mergetool--vimdiff.txt
@@ -0,0 +1,195 @@
+git-difftool{litdd}vimdiff(1)
+=============================
+
+NAME
+----
+git-mergetool--vimdiff - Helper script to run vim as a merge tool
+
+SYNOPSIS
+--------
+[verse]
+'git mergetool' --tool=vimdiff ... (rest of 'git mergetool' options)
+
+DESCRIPTION
+-----------
+When specifying '--tool=vimdiff' in 'git mergetool' git will open vim with a 4
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
+"LOCAL", "BASE" and "REMOTE" are read-only buffers showing the contents of the
+conflicting file in a specific git commit ("commit you are merging into",
+"common ancestor commit" and "commit you are merging from" respectively)
+
+"MERGED" is a writable buffer where you have to resolve the conflicts (using the
+other read-only buffers as a reference). Once you are done, save and exit "vim"
+as usual (":wq") or, if you want to abort, exit using ":cq".
+
+LAYOUT CONFIGURATION
+--------------------
+You can change the windows layout used by vim by setting configuration variable
+"mergetool.vimdiff.layout" which accepts a string where the following separators
+have special meaning:
+
+  - "+" is used to "open a new tab"
+  - "," is used to "open a new vertical split"
+  - "/" is used to "open a new horizontal split"
+  - "@" is used to indicate which is the file containing the final version after
+    solving the conflicts. In not present, "MERGED" will be used by default.
+
+The precedence of the operators is this one (you can use parenthesis to change
+it):
+
+    @ > + > / > ,
+
+Let's see some examples to understand how it works:
+
+  * layout = "(LOCAL,BASE,REMOTE)/MERGED"
+
+    This is exactly the same as the default layout we have already seen.
+
+    Note that "/" has precedence over "," and thus the parenthesis are not
+    needed in this case. The next layout definition is equivalent:
+
+        layout = "LOCAL,BASE,REMOTE / MERGED"
+
+  * layout = "LOCAL,MERGED,REMOTE"
+
+    If, for some reason, we are not interested in the "BASE" buffer.
+
+           ------------------------------------------
+           |             |           |              |
+           |             |           |              |
+           |   LOCAL     |   MERGED  |   REMOTE     |
+           |             |           |              |
+           |             |           |              |
+           ------------------------------------------
+
+  * layout = "MERGED"
+
+    Only the "MERGED" buffer will be shown. Note, however, that all the other
+    ones are still loaded in vim, and you can access them with the "buffers"
+    command. 
+
+           ------------------------------------------
+           |                                        |
+           |                                        |
+           |                 MERGED                 |
+           |                                        |
+           |                                        |
+           ------------------------------------------
+
+  * layout = "@LOCAL,REMOTE"
+
+    When "MERGED" is not present in the layout, you must "mark" one of the
+    buffers with an asterisk. That will become the buffer you need to edit and
+    save after resolving the conflicts.
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
+
+  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"
+
+    Three tabs will open: the first one is a copy of the default layout, while
+    the other two only show the differences between "BASE" and "LOCAL" and
+    "BASE" and "REMOTE" respectively.
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
+
+  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
+
+    Same as the previous example, but adds a fourth tab with the same
+    information as the first tab, with a different layout.
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
+    Note how in the third tab definition we need to use parenthesis to make ","
+    have precedence over "/".
+
+VARIANTS
+--------
+Instead of '--tool=vimdiff', you can also use these other variants:
+
+  * '--tool=gvimdiff', to open gvim instead of vim.
+
+  * '--tool=nvimdiff', to open nvim ('neovim') instead of vim.
+
+When using these variants, in order to specify a custom layout you will have to
+set configuration variables 'mergetool.gvimdiff.layout' and
+'mergetool.nvimdiff.layout' instead of 'mergetool.vimdiff.layout'
+
+In addition, for backwards compatibility with previous git versions, you can
+also append '1', '2' or '3' to either 'vimdiff' or any of the variants (ex:
+'vimdiff3', 'nvimdiff1', etc...) to use a predefined layout.
+In other words, using '--tool=[g,n,]vimdiffx' is the same as using
+'--tool=[g,n,]vimdiff' and setting configuration variable
+'mergetool.[g,n,]vimdiff.layout' to... 
+
+  * x=1 --> "@LOCAL, REMOTE"
+  * x=2 --> "LOCAL, MERGED, REMOTE"
+  * x=3 --> "MERGED"
+
+Example: using '--tool=gvimdiff2' will open 'gvim' with three columns (LOCAL,
+MERGED and REMOTE).
+
+GIT
+---
+Part of the linkgit:git[1] suite
+
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 542a6a75eb..956c276e1d 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -64,6 +64,12 @@ $(list_tool_variants)"
 				fi
 				shown_any=yes
 				printf "%s%s\n" "$per_line_prefix" "$toolname"
+
+				(diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname") |
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
index 5bf77a5388..db6cb75728 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -364,6 +364,12 @@ diff_cmd () {
 }
 
 
+diff_cmd_help() {
+	echo "Run 'man git-difftool--vimdiff' for details"
+	return 0
+}
+
+
 merge_cmd () {
 	layout=$(git config mergetool.$merge_tool.layout)
 
@@ -435,6 +441,12 @@ merge_cmd () {
 }
 
 
+merge_cmd_help() {
+	echo "Run 'man git-mergetool--vimdiff' for details"
+	return 0
+}
+
+
 translate_merge_tool_path() {
 	case "$1" in
 	nvimdiff*)
-- 
2.35.1


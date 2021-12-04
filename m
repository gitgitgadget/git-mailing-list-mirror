Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A306C433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 09:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384387AbhLDJHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 04:07:35 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57887 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1384363AbhLDJHd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Dec 2021 04:07:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EC41E3200F3B;
        Sat,  4 Dec 2021 04:04:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 04 Dec 2021 04:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Jtg7ISc3yOUAI
        X1Jlow5px66T2c6qLIl8mIrOeEtZKo=; b=tQkFYLtL0ersdSnVtOIKgYUZjDXDl
        xYICIvXBbUgIyR3nfp6pSQTFNJTf4MJcu0aAq7s+ozmQfKMJ5GQ9ADzr2J5aKCPR
        YezR7OtnBsVGsLrNPNGCXr+1Az29/SqjmfXU37Obek/TEXnnHePHNk73WEoybk4n
        VxjzTWpCBPzdSugRvwLitb5rUl1eDbJL82zLP74/o+prSRoqQ9+BFZCLa8urYAHl
        EhkETUuTi63PBpyu1vqbm8UwS2bGBfEjUvpwOvpH1oL2vsO6ypmIC0ZCcfzxwvNR
        3vyDLt1DxmeYwdEovC9eWa8GC1aEaRwQ+Pswfgbg+yimLM0Si7HX9uk9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Jtg7ISc3yOUAIX1Jlow5px66T2c6qLIl8mIrOeEtZKo=; b=LT1kXXLY
        caOYi2OLV5hs7jo6jfsJC2yikuu5UW/L6GD5/IUyxJrQehKEk7F6qoQLjs84LMMg
        C7OeWr7fqdmIxoywvy0xUR5DtdxeRRfagkD6JIbg8HQqJBJzHRVtcTpCSpxYHn9Q
        fMsSFxprBi6ZZ+GKkWzhSWrdivNNdnnSFqC6zXyRZBKwTk6xiDvSgABctQYNHD4q
        /xn4BDimO+urffromBO0V9Fpryz6zhPoKV37p5YXUvIwdCqLkakUPMcqNzvjLqXL
        LQOlbwMsJM3AOSoHVLdVraCVUrKwwm+McixOH1HFIOH+cmqqnId22gvqZpf/DJv0
        4Ygpx4qUb/JYww==
X-ME-Sender: <xms:Bi-rYYalzKVBfTIrYyS9g1LvBVVNsX9bCqB2WOHrxXm5W0-wCnEFcQ>
    <xme:Bi-rYTb6VogB-MabMAXsOXVv0iVm2Sj62aKJv1a_jcvD51cqyyU1aPesPvPGEScbU
    VmlyHuMCTHnuoTf4Q>
X-ME-Received: <xmr:Bi-rYS9l_aas0T36HtBHxLIElcmFE3RLs2W9zgs5qkOqAdFDZ4IT9EtHk-8t1is993pc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieekgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:Bi-rYSq7AxEq-LkiOxJ2wN2bJl0qpVdOrepsLAEI4keL4Fz6eqJusQ>
    <xmx:Bi-rYToxustARN0jmkWwg33WPJix0RYtxZl989SDCtVa8GcZifaoGA>
    <xmx:Bi-rYQSu3zSoRk9Yz9oyRBDh1QrqQIgV71E5H6wLaWfm-fuCMxRcvQ>
    <xmx:Bi-rYUd4Zp5BX_TEvk0rkbeCCcN9DmTmCokBt5zAmhnNYgNVWhG0mQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Dec 2021 04:04:04 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH v4 2/3] vimdiff: add tool documentation
Date:   Sat,  4 Dec 2021 10:03:50 +0100
Message-Id: <20211204090351.42369-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204090351.42369-1-greenfoo@u92.eu>
References: <20211204090351.42369-1-greenfoo@u92.eu>
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
2.34.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF5C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 11:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiC0LZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 07:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiC0LZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 07:25:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA764FE
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 04:23:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5300A5C015E;
        Sun, 27 Mar 2022 07:23:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 27 Mar 2022 07:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=5BdYip/D5rdkE+gpOgNaCd3o+u7CM7
        xnR/NzLIFVnlQ=; b=xfl3ZLrwG6IEP60lzp61cIQIVOia2JhImFT4HS90tVkcAy
        PEMYl8aPP1QbzBM2cuTJlh/V6KXwO3nXCGEufzuspi2gw2XTHIJ1bYwcK/uOAqGt
        wLImiA0zoQTNOtm3kwC2GuyTpTlFGSN1MKRaGFZN7KaEWaPvzMwidJ1Z6+0yyZAk
        5Y77X71UXjK3d1I8cVayVdQVPyb42v3QOEoSJ2beebEL9op0asvbpMkExD98vE9Q
        Y9E3M+shvhz07df2Gc3QYRt0nPx47qQ4gOJVzCbIB51kL1M7Fd4JPpMbwZ4jqRpQ
        uY2BhbsVvg8TEPZx4fK0cGZIO6j7Ft89mFslcvaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5BdYip
        /D5rdkE+gpOgNaCd3o+u7CM7xnR/NzLIFVnlQ=; b=ObEefzs/YVZd85T84bM3JV
        nPpWUIrF5C1trrWJ7e7Y3b+sa7HzZyv41r+Plt3L8MCcYfOgnAc20+r7ca6l+wpI
        LyUM6MJ7LTeDo74vXHOqF1ctnzkLRtBy/EYlDyYV9E9TUfVS0s1IckQgY2ooF7c1
        0Jt4rJENW7razxhdgFiN4UEFNsLEsSfCTBBla2HwTlat/g2dznP9swf8xOAJ7VQz
        A3PV56F7HPrAJzgw1Jt55nWF5BTC+sf7d+dEwpgd4S9huy9Xf+NQQM9oSDM1ogBh
        2UfbZUe3m/WClCJZt7riBwC5tM8co3wMyx93X7CZ7E0nkbRTf27B08Nj5VH4/b+w
        ==
X-ME-Sender: <xms:KElAYmNFBPOc8bDqxft-tHch8VwNnQYEmkkfll60bOh8AVVpNZ9mQQ>
    <xme:KElAYk-ZYmhhqG2ux9N6jUIP8WmZUET5oKKXRj8HKpSKtHslTxe5XZ4c29WWaLAW4
    7ewS9WNE_Y1pS-3Zg>
X-ME-Received: <xmr:KElAYtSY7NXplpgP8Z5sC9zGVGW58FJceX_PJpVu7mwSXYh0mgPxxmumMDC63itGdE9Mbn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehhedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:KElAYmv2XqehiFLDv969eKzYw7BCqv9zsFWSIJsrTm_WuZheRuDsTg>
    <xmx:KElAYufRusWqlsW2kZ3_HNmReCHq2M974DrZvnDhPbHJUymIXaY0TQ>
    <xmx:KElAYq2F-1x-2Rg6qZkOrnh46_emhN58E6QXjtvcSF3MkXhcAxQ6PA>
    <xmx:KElAYrGLY3pC-SicqayNBf8VD1YcAILrrv47UbGDVt9460vx1n39JA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Mar 2022 07:23:18 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v6 3/3] vimdiff: add tool documentation
Date:   Sun, 27 Mar 2022 13:23:07 +0200
Message-Id: <20220327112307.151044-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220327112307.151044-1-greenfoo@u92.eu>
References: <20220327112307.151044-1-greenfoo@u92.eu>
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
---
 Documentation/config/mergetool.txt   |   5 +
 Documentation/git-mergetool.txt      |   7 ++
 Documentation/mergetools/vimdiff.txt | 182 +++++++++++++++++++++++++++
 git-mergetool--lib.sh                |  14 +++
 mergetools/vimdiff                   |   6 +
 5 files changed, 214 insertions(+)
 create mode 100644 Documentation/mergetools/vimdiff.txt

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index cafbbef46a..5973ebd2dc 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -45,6 +45,11 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
+mergetool.{n,g,}vimdiff.layout::
+	The vimdiff backend uses this variable to control how its split
+	windows look like.  See BACKEND SPECIFIC HINTS section of
+	linkgit:git-mergetool[1] for details.
+
 mergetool.hideResolved::
 	During a merge Git will automatically resolve as many conflicts as
 	possible and write the 'MERGED' file containing conflict markers around
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e587c7763a..6c6aa29c5a 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -113,6 +113,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
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
index 0000000000..296bc76e98
--- /dev/null
+++ b/Documentation/mergetools/vimdiff.txt
@@ -0,0 +1,182 @@
+Description
+^^^^^^^^^^^
+
+When specifying `--tool=vimdiff` in `git mergetool` git will open vim with a 4
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
+Layout configuration
+^^^^^^^^^^^^^^^^^^^^
+
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
+Variants
+^^^^^^^^
+
+Instead of `--tool=vimdiff`, you can also use one of these other variants:
+
+  * `--tool=gvimdiff`, to open gvim instead of vim.
+
+  * `--tool=nvimdiff`, to open nvim (`neovim`) instead of vim.
+
+When using these variants, in order to specify a custom layout you will have to
+set configuration variables `mergetool.gvimdiff.layout` and
+`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
+
+In addition, for backwards compatibility with previous git versions, you can
+also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
+`vimdiff3`, `nvimdiff1`, etc...) to use a predefined layout.
+In other words, using `--tool=[g,n,]vimdiffx` is the same as using
+`--tool=[g,n,]vimdiff` and setting configuration variable
+`mergetool.[g,n,]vimdiff.layout` to... 
+
+  * x=1 --> "@LOCAL, REMOTE"
+  * x=2 --> "LOCAL, MERGED, REMOTE"
+  * x=3 --> "MERGED"
+
+Example: using `--tool=gvimdiff2` will open `gvim` with three columns (LOCAL,
+MERGED and REMOTE).
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
index e3f442caf3..0380bff302 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -435,6 +435,12 @@ merge_cmd () {
 }
 
 
+merge_cmd_help () {
+	echo "Layout can be customized. Run 'git help mergetool' and check the 'BACKEND SPECIFIC HINTS' section."
+	return 0
+}
+
+
 translate_merge_tool_path () {
 	case "$1" in
 	nvimdiff*)
-- 
2.35.1


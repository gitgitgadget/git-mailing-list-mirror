Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FFC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbhK3UrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:47:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40463 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343737AbhK3UrD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Nov 2021 15:47:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DFC15C0182;
        Tue, 30 Nov 2021 15:43:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Nov 2021 15:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=x5S3DiT+RLBIX
        b6MKVzXLGAssXTm3o+48QdKz4ESbho=; b=E9LRxvLW06dDQXiGGaGuZddif+hNK
        Ggh/p8bJ8ow1dSZlmLtdRiMvfqZmVYYjlFN2uo8rx+0efvmGbas2vZdeZNKXT4JW
        MBKTewlTwmFwomtaSZiDrAYDC+aaxSgD2HhNBpZO7nhmG3+fSoWAzXnTnRViOq4a
        ZeMJS01dKdugf8exs9utaS7CivKb3ZAJmp3DEfelYrhikZv/a/Orbk8gK4vZTq0W
        DtchcHjt6dcFf47zF53yzgalh85ptAEcGZUbs+SWkNwHxms/Pva/avplAOtztGq5
        npCv539Sw8rDCIyb1jiylqSJQFzT5TwPsculuDr+cMjeKUBQf23AOqHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=x5S3DiT+RLBIXb6MKVzXLGAssXTm3o+48QdKz4ESbho=; b=O7zdYLcz
        fHXWZI99hn5GVHD05ZfRUD8+sWqdE5P83vfb+9joKnS2OJC+rARHQwiIhnN7dCXH
        KSfIjUOoPOtx055JOudAXlDU6z1BZXCZsyE5KQhtvIHZfFzSsukzjq+taH78TwBf
        w5pJkWv81KL0gaCKoHknWmEm/VC+Jx3rrM5HmUM2xjs+fquMoD2JtxXpjGJe1fqk
        GWIhbktZ2fgT6l2sxJapXkRpm/b4lbTEydOtp6DwD2tq5Of0N7LUgPNw3p6WWtwF
        MK2+vk4sS4a1UF84wJ2RCInLzn7+WooC5L72sX9r0mBwgC85imrVkfpDgmteDuBF
        BDedjT9EONdSyw==
X-ME-Sender: <xms:_4ymYUOieVBUSb8qYZoVc6Ce6rwIWneCXFVyhKAVC3LGsW7kBFYwww>
    <xme:_4ymYa9kTINtz2KmWvI8z8mhYpe2WF_SgAZxUDhO16f3MUKkLOqXk4sC-49Efl35d
    sMTRu4rxRC9nsGZ0Q>
X-ME-Received: <xmr:_4ymYbRwsBTEz-8Ke4wZM_VsSsLF0qwbJIXJRrv5DH7dCbls1a__Ikb1yuq7ms8rHWUR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedugddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepkeelkeejtdehjeehkeefgfegvedvgf
    eugeffueevudfhheeugeekieejvddvjeefnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:_4ymYcsgNZe772GBQ7mwtaON-v0K15cC5TuzhvK71YB2nTXr80KP2Q>
    <xmx:_4ymYcccfZ6wnvKJYc0y7JQU7axV5BJx2oSyK8qMaTETwLSXFgQwFQ>
    <xmx:_4ymYQ2nen3mmEZn0Qa8LxaVjBBs4A4lCPoiawbrc_W9gY_sISEBhQ>
    <xmx:_4ymYRGoz6l3Fx5W5I485jqaQMHSdp6RNMSrfSYQduDMWnbIUC4adA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Nov 2021 15:43:41 -0500 (EST)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v3 2/3] vimdiff: add tool documentation
Date:   Tue, 30 Nov 2021 21:43:32 +0100
Message-Id: <20211130204333.174967-3-greenfoo@u92.eu>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130204333.174967-1-greenfoo@u92.eu>
References: <20211130204333.174967-1-greenfoo@u92.eu>
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
 Documentation/git-difftool--vimdiff.txt  |  41 +++++
 Documentation/git-mergetool--vimdiff.txt | 195 +++++++++++++++++++++++
 git-mergetool--lib.sh                    |  14 ++
 mergetools/vimdiff                       |  22 +++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/git-difftool--vimdiff.txt
 create mode 100644 Documentation/git-mergetool--vimdiff.txt

diff --git a/Documentation/git-difftool--vimdiff.txt b/Documentation/git-difftool--vimdiff.txt
new file mode 100644
index 0000000000..b520129ee5
--- /dev/null
+++ b/Documentation/git-difftool--vimdiff.txt
@@ -0,0 +1,41 @@
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
+
diff --git a/Documentation/git-mergetool--vimdiff.txt b/Documentation/git-mergetool--vimdiff.txt
new file mode 100644
index 0000000000..b7b419464d
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
+Let's see some examples to undertand how it works:
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
+    more prioritary than "/".
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
index 542a6a75eb..d7420c5d1a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -64,6 +64,12 @@ $(list_tool_variants)"
 				fi
 				shown_any=yes
 				printf "%s%s\n" "$per_line_prefix" "$toolname"
+
+                                (diff_mode && diff_cmd_help "$toolname" || merge_cmd_help "$toolname") |
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
index ed0d8584f7..8614253ef1 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -462,6 +462,17 @@ diff_cmd () {
 }
 
 
+diff_cmd_help() {
+	case "$1" in
+	*)
+		echo "Run 'man git-difftool--vimdiff' for details"
+		;;
+	esac
+
+	return 0
+}
+
+
 merge_cmd () {
 	layout=$(git config mergetool.$merge_tool.layout)
 
@@ -533,6 +544,17 @@ merge_cmd () {
 }
 
 
+merge_cmd_help() {
+	case "$1" in
+	*)
+		echo "Run 'man git-mergetool--vimdiff' for details"
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
2.34.0


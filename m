Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7005FC433FE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A69861207
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKDQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:12:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55083 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhKDQMy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 12:12:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 644295C0152;
        Thu,  4 Nov 2021 12:10:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Nov 2021 12:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=rXzM3CG0fGPYA
        15AzoEllsUqoiKBeB6y3tccQNHRgP4=; b=N1rvnyMcXx8RCnjbL/CFUpvZ7UOkJ
        WFSP+mHYQiJgFX2tqQ89JpzmZnPgTQtFSsRfzdVgNLaORIEY/J4jWSY2AkFaHR8d
        SLHGhP8OLEDwcWg6ooS/kkL+ZX3oiCPO1hGFEbjlA/KIzt9KQqytf78YnCE0TOhw
        Ho0TSKnutkSHErFqS3ygA9gpRrd8QS6ViuKmZ1mSNIWuC5yWYYCE2pHdiwfbF1oT
        kdlL2LVBjDHyqttXE2k6C/EBAHjPewBhAxgKhFkQaAiO/jEaDd5jm0U4pR98vARd
        CQTvyRU/wePQKrqyYkJlmjHmGMdTfx9XUWPBAhPN+izW8mIcpM6L06Q9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rXzM3CG0fGPYA15AzoEllsUqoiKBeB6y3tccQNHRgP4=; b=AcVP2oLN
        mMcGFvD1FklqdJ9icHGjbrK0Sdd3gVcl1pmI0/1EVXCRIs+DOHMgDoKQfjF+PjQA
        Lq8NrICHaAzR7PsYxvemW+iNDlaVb8vxqwGbOyggJpdE+SyX3ReibCi1lEw8PUhT
        Qi4b9Q4MbkOvT9RHuTaVhYKOpMyWlja44KBqKDSg6jkrEN7OAHwhBea7MZNtfIIb
        W/1dSyiw6XjMGAkM1ucXIW50gfrjGNShsiq4Y6NQEGJkwjKcgUTzhpwA7RVwhzBI
        IkdZA8KaZ07RHye4RpRccS591LNj1MKRARmSXme6GSFAv6q6VOZtW86+lmngpiSI
        untl4jxWvdsqcA==
X-ME-Sender: <xms:6AWEYTVMxZFaoobPduFhPQcAiCZWTUhcwuzxkt2dTDTukn0A7kKp0Q>
    <xme:6AWEYbksS9LesehiobiDZhS_0ffKM-Q6YIoQ2zF6sQHg5-mC2WiGOdFLMaeT6fb8A
    3eREpWG1Wp1byUUCQ>
X-ME-Received: <xmr:6AWEYfaYHLRq_3etJufMVorknSJ63fvaV1bGTjAHEnG4fuswm4qdMFqSdL_fCQ7s7NktDvH0kzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohes
    uhelvddrvghuqeenucggtffrrghtthgvrhhnpeekleekjedtheejheekfefggeevvdfgue
    egffeuveduhfehueegkeeijedvvdejfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:6AWEYeWQRf3QPyD4mNHclIBvSxPRk_rZziB8t8Trd-rGDyH741ccGA>
    <xmx:6AWEYdkzLLzuJj8VUMVf5oaJg-bb--RmdQhV_7VRjEEIlLZR9tHDzw>
    <xmx:6AWEYbelWVA4TiLe7_jy_CBDdu3gM3o9KmnDbCcL7fQtMgJ06EVaQw>
    <xmx:6AWEYWCWk9NUhKEtRjzrztlpglUkH7mcpI_CQIive2fbRJEgv6sunw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 12:10:14 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: [PATCH 3/3] vimdiff: remove deprecated {,g,n}vimdiff{1,2,3} variants
Date:   Thu,  4 Nov 2021 17:09:59 +0100
Message-Id: <20211104160959.183402-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104160959.183402-1-greenfoo@u92.eu>
References: <20211104160959.183402-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After this commit is merged, users of "{,g,n}vimdiff{1,2,3}" will need to
set their merge tool to "{,g,v}vimdiff" (without the number suffix) and
the "mergetool.{,g,n}vimdiff.layout" configuration option to one of
these:

  * For "1" variant: "LOCAL* | REMOTE"
  * For "2" variant: "LOCAL | MERGED | REMOTE"
  * For "3" variant: "MERGED"

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 125 ++-------------------------------------------
 1 file changed, 4 insertions(+), 121 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index aa8fbc0a19..9d469c0553 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -436,33 +436,18 @@ diff_cmd_help() {
 			window and REMOTE changes in the right one.
 		ENDOFMESSAGE
 		;;
-	vimdiff*)
-		cat <<-ENDOFMESSAGE
-			Same as 'vimdiff'
-		ENDOFMESSAGE
-		;;
 	gvimdiff)
 		cat <<-ENDOFMESSAGE
 			Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
 			opening its own window)
 		ENDOFMESSAGE
 		;;
-	gvimdiff*)
-		cat <<-ENDOFMESSAGE
-			Same as 'gvimdiff'
-		ENDOFMESSAGE
-		;;
 	nvimdiff)
 		cat <<-ENDOFMESSAGE
 			Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
 			'vim' 'focused on extensibility and usability' according to their authors)
 		ENDOFMESSAGE
 		;;
-	nvimdiff*)
-		cat <<-ENDOFMESSAGE
-			Same as 'nvimdiff'
-		ENDOFMESSAGE
-		;;
 	esac
 
 	return 0
@@ -471,7 +456,6 @@ diff_cmd_help() {
 
 merge_cmd () {
 	layout=$(git config mergetool.$merge_tool.layout)
-	print_warning="false"
 
 	case "$1" in
 	*vimdiff)
@@ -481,34 +465,8 @@ merge_cmd () {
 			layout="(LOCAL | BASE | REMOTE) - MERGED"
 		fi
 		;;
-	*vimdiff1)
-		layout="LOCAL* | MERGED"
-		print_warning="true"
-		;;
-	*vimdiff2)
-		layout="LOCAL | MERGED | REMOTE"
-		print_warning="true"
-		;;
-	*vimdiff3)
-		layout="MERGED"
-		print_warning="true"
-		;;
 	esac
 
-	if test "$print_warning" = "true"
-	then
-		echo "WARNING:"
-		echo "WARNING: '$1' is going to be removed in a future version. You will be"
-		echo "WARNING: able to obtain the same result by selecting 'vimdiff' as the merge"
-		echo "WARNING: tool and setting configuration variable 'mergetool.vimdiff.layout'"
-		echo "WARNING: to the following value:"
-		echo "WARNING:"
-		echo "WARNING:     layout = \"$layout\""
-		echo "WARNING:"
-		echo "Press ENTER to continue..."
-		read
-	fi
-
 	gen_cmd "$layout"
 
 	debug_print ""
@@ -682,30 +640,6 @@ merge_cmd_help() {
 
 		ENDOFMESSAGE
 		;;
-	vimdiff1)
-		cat <<-ENDOFMESSAGE
-			Same as 'vimdiff' using this layout: "LOCAL* | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "vimdiff" and
-			manually set the "mergetool.vimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	vimdiff2)
-		cat <<-ENDOFMESSAGE
-			Same as 'vimdiff' using this layout: "LOCAL | MERGED | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "vimdiff" and
-			manually set the "mergetool.vimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	vimdiff3)
-		cat <<-ENDOFMESSAGE
-			Same as 'vimdiff' using this layout: "MERGED"
-			
-			This will probably be deprecated in the future. Please use "vimdiff" and
-			manually set the "mergetool.vimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
 	gvimdiff)
 		cat <<-ENDOFMESSAGE
 			Same as 'vimdiff' but opens 'gvim' instead (which uses a graphical toolkit for
@@ -714,30 +648,6 @@ merge_cmd_help() {
 			"mergetool.gvimdiff.layout"
 		ENDOFMESSAGE
 		;;
-	gvimdiff1)
-		cat <<-ENDOFMESSAGE
-			Same as 'gvimdiff' using this layout: "LOCAL* | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "gvimdiff" and
-			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	gvimdiff2)
-		cat <<-ENDOFMESSAGE
-			Same as 'gvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "gvimdiff" and
-			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	gvimdiff3)
-		cat <<-ENDOFMESSAGE
-			Same as 'gvimdiff' using this layout: "MERGED"
-			
-			This will probably be deprecated in the future. Please use "gvimdiff" and
-			manually set the "mergetool.gvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
 	nvimdiff)
 		cat <<-ENDOFMESSAGE
 			Same as 'vimdiff' but opens 'neovim' instead (which is a fork of the original
@@ -746,30 +656,6 @@ merge_cmd_help() {
 			"mergetool.nvimdiff.layout"
 		ENDOFMESSAGE
 		;;
-	nvimdiff1)
-		cat <<-ENDOFMESSAGE
-			Same as 'nvimdiff' using this layout: "LOCAL* | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "nvimdiff" and
-			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	nvimdiff2)
-		cat <<-ENDOFMESSAGE
-			Same as 'nvimdiff' using this layout: "LOCAL | MERGED | REMOTE"
-			
-			This will probably be deprecated in the future. Please use "nvimdiff" and
-			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
-	nvimdiff3)
-		cat <<-ENDOFMESSAGE
-			Same as 'nvimdiff' using this layout: "MERGED"
-			
-			This will probably be deprecated in the future. Please use "nvimdiff" and
-			manually set the "mergetool.nvimdiff.layout" configuration variable instead.
-		ENDOFMESSAGE
-		;;
 	esac
 
 	return 0
@@ -778,13 +664,13 @@ merge_cmd_help() {
 
 translate_merge_tool_path() {
 	case "$1" in
-	nvimdiff*)
+	nvimdiff)
 		echo nvim
 		;;
-	gvimdiff*)
+	gvimdiff)
 		echo gvim
 		;;
-	vimdiff*)
+	vimdiff)
 		echo vim
 		;;
 	esac
@@ -798,10 +684,7 @@ exit_code_trustable () {
 
 list_tool_variants () {
 	for prefix in '' g n; do
-		for suffix in '' 1 2 3
-		do
-			echo "${prefix}vimdiff${suffix}"
-		done
+		echo "${prefix}vimdiff"
 	done
 }
 
-- 
2.33.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F171F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbcHISet (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:34:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:58795 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234AbcHISet (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:34:49 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP; 09 Aug 2016 11:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,495,1464678000"; 
   d="scan'208";a="1032607924"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2016 11:34:48 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] completion: add completion for --submodule=* diff option
Date:	Tue,  9 Aug 2016 11:34:46 -0700
Message-Id: <20160809183446.10200-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.701.gf965a18
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Teach git-completion.bash to complete --submodule= for git commands
which take diff options. Also teach completion for git-log to support
--diff-algorithms as well.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 contrib/completion/git-completion.bash | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e1899ee53613..d81ee688c3b7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1207,6 +1207,8 @@ _git_describe ()
 
 __git_diff_algorithms="myers minimal patience histogram"
 
+__git_diff_submodule_formats="log short"
+
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
@@ -1222,6 +1224,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
+			--submodule --submodule=
 "
 
 _git_diff ()
@@ -1233,6 +1236,10 @@ _git_diff ()
 		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
 		return
 		;;
+	--submodule=*)
+		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
+		return
+		;;
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
@@ -1496,6 +1503,14 @@ _git_log ()
 		__gitcomp "full short no" "" "${cur##--decorate=}"
 		return
 		;;
+	--diff-algorithm=*)
+		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
+		return
+		;;
+	--submodule=*)
+		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
@@ -2459,6 +2474,10 @@ _git_show ()
 		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
 		return
 		;;
+	--submodule=*)
+		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
+		return
+		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --oneline
 			--show-signature
-- 
2.9.2.701.gf965a18


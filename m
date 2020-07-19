Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21747C433E1
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9D120724
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="iGiZgRsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGSE0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSE0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 00:26:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F538C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:26:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 22so19225098wmg.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dg2YAc9c4uqxa+eagwTGip8Taf/41hbI9Spn6qwvozM=;
        b=iGiZgRsIBcFdvfKBLNwmcb1JCR3JlE/KL+Zf7Fo3D21CJDtFuxtMMybKHJGgvBv7br
         BFWhLfpt2mzw84rem+HQctzEV/YrVvJkS7N1UTDQ7RmfXkn1mmEOg26zlUq7N2UdvPE8
         hJSQd5u7p3E21cC+9ftRTbMrWhBcSz9JazKORapxX+W6eHru3OCS+VIj6R9n8s1Ga97j
         4NHrIuzcfcxOe7n7Z4eyertV4st2pc9AAQrp5XmLV16xDCxnYRw6TQ9V4uwcdlUnC/OH
         bIEHPeVSNxcXMyp04sYxCXFiJsLhx7oAlrOhM6FK+mEVXNUoKWHoDfwRF2yInnH9dLIT
         Z1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dg2YAc9c4uqxa+eagwTGip8Taf/41hbI9Spn6qwvozM=;
        b=Xu4OQ/i2tHGHIuo/qooPRT42skReosrE0quF3wa5xpEZ5G5a1gR4xDvsa/VX+MoNE5
         AOHUrFZCZ5HMcN+NMDln252ULD1DBnLUAzxqCyaKs7hbds1OOcX5s5ku9FrgmHLU50ZE
         RCp9MR9JQcRrNaCiqwr6CRdGLs+URlCU4kw1plmyQLBHrPFU+4TLZ0bQ8hNe8ZLJ5oeF
         ylLZNtINNzIwhqBJTmOq/siuoLwkXVFkbwQ4AQfJZfTDRgRNznzhH/QF1kH8FiZypkyK
         2fRR3AANGZE0sOkYMtR2Y3O91bMV5eWRNftHcEfXrrmMFplqzlIv/ySvKyhhSW2FTFoo
         uzyQ==
X-Gm-Message-State: AOAM532vr5ePAap6vp3iM6MB7Xe4pegw2WNFWDz9wFr0ex7HVFQTEVsy
        VW3fS6SdJIBWVhIkXIKrrEll31P/WGs=
X-Google-Smtp-Source: ABdhPJzCMsAhkedB7Z4nIwwwYs3gn2hHwnPV8YICZKMbtvHsrmck2lPCkIFc4jSv94WQEWZq2eLYuw==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr15910104wmd.104.1595132769599;
        Sat, 18 Jul 2020 21:26:09 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z16sm23571965wrr.35.2020.07.18.21.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 21:26:09 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>
Subject: [PATCH v2 2/2] Support nvim as merge tool
Date:   Sun, 19 Jul 2020 05:23:38 +0100
Message-Id: <20200719042335.3913-3-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718192001.27434-1-rogi@skylittlesystem.org>
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 contrib/completion/git-completion.bash |  4 ++--
 git-mergetool--lib.sh                  |  7 +++++--
 mergetools/nvimdiff                    |  1 +
 mergetools/vimdiff                     | 15 +++++++++------
 4 files changed, 17 insertions(+), 10 deletions(-)
 create mode 100644 mergetools/nvimdiff

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ee468ea3b0..aed08f8df5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1712,8 +1712,8 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc
-			codecompare smerge
+			tkdiff vimdiff nvimdiff gvimdiff xxdiff araxis p4merge
+			bc codecompare smerge
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 29fecc340f..2defef28cd 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -304,11 +304,14 @@ list_merge_tool_candidates () {
 		tools="$tools smerge"
 	fi
 	case "${VISUAL:-$EDITOR}" in
+	*nvim*)
+		tools="$tools nvimdiff vimdiff emerge"
+		;;
 	*vim*)
-		tools="$tools vimdiff emerge"
+		tools="$tools vimdiff nvimdiff emerge"
 		;;
 	*)
-		tools="$tools emerge vimdiff"
+		tools="$tools emerge vimdiff nvimdiff"
 		;;
 	esac
 }
diff --git a/mergetools/nvimdiff b/mergetools/nvimdiff
new file mode 100644
index 0000000000..04a5bb0ea8
--- /dev/null
+++ b/mergetools/nvimdiff
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 3925e1fc3e..abc8ce4ec4 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -5,7 +5,7 @@ diff_cmd () {
 
 merge_cmd () {
 	case "$1" in
-	gvimdiff|vimdiff)
+	*vimdiff)
 		if $base_present
 		then
 			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
@@ -15,11 +15,11 @@ merge_cmd () {
 				"$LOCAL" "$MERGED" "$REMOTE"
 		fi
 		;;
-	gvimdiff2|vimdiff2)
+	*vimdiff2)
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
 		;;
-	gvimdiff3|vimdiff3)
+	*vimdiff3)
 		if $base_present
 		then
 			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
@@ -34,10 +34,13 @@ merge_cmd () {
 
 translate_merge_tool_path() {
 	case "$1" in
-	gvimdiff|gvimdiff2|gvimdiff3)
+	nvimdiff*)
+		echo nvim
+		;;
+	gvimdiff*)
 		echo gvim
 		;;
-	vimdiff|vimdiff2|vimdiff3)
+	vimdiff*)
 		echo vim
 		;;
 	esac
@@ -48,7 +51,7 @@ exit_code_trustable () {
 }
 
 list_tool_variants () {
-	for prefix in '' g; do
+	for prefix in '' g n; do
 		for suffix in '' 2 3; do
 			echo "${prefix}vimdiff${suffix}"
 		done
-- 
2.27.0


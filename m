Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B31C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1197206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="cy+/kk45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2Vdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Vdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:33:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB3C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:33:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so4375096wmb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbGZmLUaYkjPxv+rShzBRAgdGE8Aq2UjFjR/ZwYxJTE=;
        b=cy+/kk45h5xzPX4rpeIRj7nY16+g2gG/aCFexxpp3R3sTp/ZXcxktWUzKZzuziSaIy
         9WCY75sZwrJYd7pRtFl+xfD1h475+AWwge3ynO2sZllYLNiDWZgoJFzObYaFZT20tPAP
         6C5/VB49jX7/EKw98V9I5Fag5RTrScvcp+9cDiijYeDUeJfsaPQXOpA1bv9lBQ0zCcPV
         704GLGWeH1jw4YPcCiQtpxiJd5z3te+rvbEckS5sbJBzIzKoDAtwBFLqbcVzJoPoaVEz
         ZyjtSTmYYiXLNYFLUFxQojtTPiJ3B6+mUwEZn4vaaVnpfn68wuUEYxeeV0aJig0xAwKt
         cznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbGZmLUaYkjPxv+rShzBRAgdGE8Aq2UjFjR/ZwYxJTE=;
        b=lJYZk7MVuHeY0+vaE/cewc0JCWeVetDQovTm0Vi6irO+WuBbuGEx+Kj1nG0fgDs+om
         y+IgUYzG4TyNdK1bVZyMJknrWfl5jqhPD/xMVU8PiFG2zO7h9iVMh2/kGOYZGvjEf65b
         YPepKpIZDw5JDm+s30duQyLUW2HS2tzuk0M8akzzLWHYd0Peo0V3s8RD6vvnDvGD6MVH
         F7TXfN1qAispfwm4aiNuAsn4c0FlzS1JO2slEu8XMfB5kUJnrnyRE5seec/Mdwsd5zlr
         RTF1qYKka8jy5saz3Q5ywe+0XblFqgFMkZTzSzdnSm0j8toF2hDwPRIAR711cY9aY8H/
         Mg7Q==
X-Gm-Message-State: AOAM533N5PQ9SZyi8a97RkUZDg7Y8sh02BNBZCmtTS2yemdI/ZLbeLzL
        5wIA0CvUWMTKyc94u3dpomlftDjzSbI=
X-Google-Smtp-Source: ABdhPJyd2pWZZszlkYRRJC21MZ3KA9KFYcKPltGL6HqjUkMvAM5Fd0hWpNBYbqnoNooncdmVm7K0lg==
X-Received: by 2002:a1c:6604:: with SMTP id a4mr10140983wmc.81.1596058429680;
        Wed, 29 Jul 2020 14:33:49 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z8sm6402057wmf.42.2020.07.29.14.33.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:33:49 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        pudinha <rogi@skylittlesystem.org>
Subject: [PATCH v3 2/2] mergetools: add support for nvimdiff (neovim) family
Date:   Wed, 29 Jul 2020 22:31:13 +0100
Message-Id: <20200729213113.15927-3-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200729213113.15927-1-rogi@skylittlesystem.org>
References: <20200719042335.3913-1-rogi@skylittlesystem.org>
 <20200729213113.15927-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: pudinha <rogi@skylittlesystem.org>
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
2.28.0


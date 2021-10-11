Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C3BC4332F
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A79361040
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhJKMUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhJKMUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:20:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF3C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so21365638otb.10
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IO8uXgRDXkvDbyHx2ig0cNUOKDO/WuFsGVrGd3qbFkA=;
        b=LMIE50AIQxNdVR7ys94xJUYrQsdaBUtdS62ij4T2mBIQn/tqwC3oaS/K8T+xka9Sb1
         GD6gXWzB6AyabLAPi15fsG4CirFlt59FH4orAIHd5DQO2v5X5saBdGexwilamW2klxqW
         FtFxQ13oew5mJwnARSFA9tqq4hzbV5Q54PXn/u72FBLj5ONUz8zZiMn7OHrXvq/COXqt
         RNmM51Y/qrhPuI0sw0034Cmi29DPJce8oZ5ZHqZLY/RyUJF7bE8LrhvrYxcJN8mBQW2u
         Rs7Wn23YC5jiZkQdbsQii9uvgWhhWzFnwmPK85lRYSeykJOwdUDzu7B/uJFA6P3CIQas
         BAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IO8uXgRDXkvDbyHx2ig0cNUOKDO/WuFsGVrGd3qbFkA=;
        b=KCBln5N0rxBxPrQJ/YUCMHKJ0SarAbPYoVHqam6ZoEQe3zAhN23lTa4oEKDPywdUX1
         PDK2VLEuba2AW+WbH0h9sq2ihzEfTGVh8bnEBMjlXpW8yK8xfwYIgHrKrL1Ng6NC3Xyk
         X9tLtQ2gh/J0cSCp4NjZP3huopUG5Q4h+6cvJkLSIpCEPz74PM1MpJJhk0ulL3wd8hv/
         V8lpTXRem/W2nGe7Za0VSBseJd3YfvzhBM3QxPq1afRmFXjjwpmeofeIohPiVOG8leaQ
         XaSOV5jiPKre3gRTpJSoySwuAyPlTnHRVyNKhKUyDah4eM5SybFv87DjvjuqDCPyNgYt
         KVdw==
X-Gm-Message-State: AOAM53042Ql3Uw0Fphz+nK+MpgKw7EPARu+0GAYpSL0EWEvDLfxHQL+K
        1MsrqPZU5Nd6Qm/4uk0Smq9rLFhtdlbmdg==
X-Google-Smtp-Source: ABdhPJwGS1eVmjDI6w5HeD1dy/l/ngijunSqxXJ2AsHXPGjhFNcKxI0nSJiMfyhVfr4f2VMdy/1U1g==
X-Received: by 2002:a9d:610a:: with SMTP id i10mr6428828otj.146.1633954689839;
        Mon, 11 Oct 2021 05:18:09 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u21sm467892oiv.25.2021.10.11.05.18.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:18:09 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     angavrilov@gmail.com, me@yadavpratyush.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 1/4] blame: prefer null_sha1 over nullid and retire later
Date:   Mon, 11 Oct 2021 05:17:54 -0700
Message-Id: <20211011121757.627-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211011121757.627-1-carenas@gmail.com>
References: <20211011121757.627-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a9786bb (git-gui: Fix Blame Parent & Context for working copy lines.,
2008-09-08) adds nullid (and a never used nullid2) for matching locally
modified lines in blame.

Use instead the already available null_sha1 for the same and in
preparation to making that hash independent on a future patch.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-gui.sh    |  3 ---
 lib/blame.tcl | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 201524c..a69b0fe 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1353,9 +1353,6 @@ set diff_empty_count 0
 set last_revert {}
 set last_revert_enc {}
 
-set nullid "0000000000000000000000000000000000000000"
-set nullid2 "0000000000000000000000000000000000000001"
-
 ######################################################################
 ##
 ## task management
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 8441e10..6ece79d 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -1056,14 +1056,14 @@ method _format_offset_date {base offset} {
 }
 
 method _gitkcommit {} {
-	global nullid
+	global null_sha1
 
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		set cmit [lindex $dat 0]
 
 		# If the line belongs to the working copy, use HEAD instead
-		if {$cmit eq $nullid} {
+		if {$cmit eq $null_sha1} {
 			if {[catch {set cmit [git rev-parse --verify HEAD]} err]} {
 				error_popup [strcat [mc "Cannot find HEAD commit:"] "\n\n$err"]
 				return;
@@ -1106,7 +1106,7 @@ method _gitkcommit {} {
 }
 
 method _blameparent {} {
-	global nullid
+	global null_sha1
 
 	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
@@ -1114,7 +1114,7 @@ method _blameparent {} {
 		set new_path [lindex $dat 1]
 
 		# Allow using Blame Parent on lines modified in the working copy
-		if {$cmit eq $nullid} {
+		if {$cmit eq $null_sha1} {
 			set parent_ref "HEAD"
 		} else {
 			set parent_ref "$cmit^"
@@ -1129,7 +1129,7 @@ method _blameparent {} {
 		# Generate a diff between the commit and its parent,
 		# and use the hunks to update the line number.
 		# Request zero context to simplify calculations.
-		if {$cmit eq $nullid} {
+		if {$cmit eq $null_sha1} {
 			set diffcmd [list diff-index --unified=0 $cparent -- $new_path]
 		} else {
 			set diffcmd [list diff-tree --unified=0 $cparent $cmit -- $new_path]
-- 
2.33.0.1081.g099423f5b7


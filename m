Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C6C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiBOQAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiBOQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 11:00:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD49C1CBC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j26so22058351wrb.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zNfbcs/Jm+I3NHuyz1kCz41o5u4WnxVLf6/YW0I/FMw=;
        b=IxP5/pA1C8Gh8BOYzBIvepkf6Y66w8uNmqoY1hea+zwNBb4ubAM1VZXcbQ/t6Ale5B
         AOCkuFWKqODeMAcqQqxZFB40/TJ/Ekwjyz24TF7GtTrIVS9cg+FHYQdsKimS48dxPBjN
         dPQ9yIdv3f9Gr+/DDwuBSmzpos+wC+CpnuHtAsb3OhLxXaoCo+5RQUIM3+um63XrIPod
         Ck6iXDICXkqX+wC49fjGPvMGCVR2X5BzegW4OGqIKAYO+oTnJFi8E7dZ+o91phFe0BCm
         TmLrymMUqSlvKj+WSQHUZkcb0A8gkvkHjj2D09+n1v6m66kP66wEZQ3tWru6CICwJkEa
         Xzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zNfbcs/Jm+I3NHuyz1kCz41o5u4WnxVLf6/YW0I/FMw=;
        b=xPjxUK+FdBntY4L/2ktnQca6C2hf0RdTM4vKpmTHjDZLt8Y9TMuldWm8VqzXaNrTOl
         ZiFr/tNjmm9LcLiaeBDDJMzjTlGrOovhR+vTCpMiuULwhrlc2xWaSZlDbDozmLKdouje
         v9MUjQV11XN0skY/e03JTF4oZo6Mc5tCbt2L1fyv2FiSnagjL0Krg6QFEsUcTQbTg9Xd
         GWDVqy5wCa4jnx7hmu7IPRRNJneGvcNs3bR5Sbk9gFP6moKtMLVBliBYbC95DztMoJpH
         0mBvisNNF8NPy0HU1dDidXxgBbb97UAIFDcbLfGGXcMZE5gkrKyunTBusrdPIgIxjKDb
         FpBg==
X-Gm-Message-State: AOAM531UOIo/7Co2e/tIr/DFehtQJRNc2+iuiQITtteVcMcYCsraJcQi
        yf5OCyG6+aqDGTvEryDSRTZm+mIndLs=
X-Google-Smtp-Source: ABdhPJzcOLVYAXkhDmGqITqYqgKZe8QnQlqupDgenfrrFXZV6ylCk7bQkCBod13p1fkA9xW7kaK6Yg==
X-Received: by 2002:adf:d08d:: with SMTP id y13mr3651409wrh.445.1644940797583;
        Tue, 15 Feb 2022 07:59:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm25722941wro.21.2022.02.15.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:57 -0800 (PST)
Message-Id: <f065e8c9a90d611888d8aa5ec8753c394f525e8e.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:32 +0000
Subject: [PATCH 22/23] t7527: FSMonitor tests for directory moves
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create unit tests to move a directory.  Verify that `git status`
gives the same result with and without FSMonitor enabled.

NEEDSWORK: This test exposes a bug in the untracked-cache on
Windows when FSMonitor is disabled.  These are commented out
for the moment.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index c0145544ccb..408d614b28b 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -261,6 +261,16 @@ test_expect_success 'setup' '
 	trace*
 	EOF
 
+	mkdir -p T1/T2/T3/T4 &&
+	echo 1 >T1/F1 &&
+	echo 1 >T1/T2/F1 &&
+	echo 1 >T1/T2/T3/F1 &&
+	echo 1 >T1/T2/T3/T4/F1 &&
+	echo 2 >T1/F2 &&
+	echo 2 >T1/T2/F2 &&
+	echo 2 >T1/T2/T3/F2 &&
+	echo 2 >T1/T2/T3/T4/F2 &&
+
 	git -c core.fsmonitor=false add . &&
 	test_tick &&
 	git -c core.fsmonitor=false commit -m initial &&
@@ -354,6 +364,19 @@ verify_status () {
 	echo HELLO AFTER
 }
 
+move_directory_contents_deeper() {
+	mkdir T1/_new_
+	mv T1/[A-Z]* T1/_new_
+}
+
+move_directory_up() {
+	mv T1/T2/T3 T1
+}
+
+move_directory() {
+	mv T1/T2/T3 T1/T2/NewT3
+}
+
 # The next few test cases confirm that our fsmonitor daemon sees each type
 # of OS filesystem notification that we care about.  At this layer we just
 # ensure we are getting the OS notifications and do not try to confirm what
@@ -685,6 +708,22 @@ do
 		matrix_try $uc_val $fsm_val file_to_directory
 		matrix_try $uc_val $fsm_val directory_to_file
 
+		# NEEDSWORK: On Windows the untracked-cache is buggy when FSMonitor
+		# is DISABLED.  Turn off a few test that cause it problems until
+		# we can debug it.
+		#
+		try_moves="true"
+		test_have_prereq UNTRACKED_CACHE,WINDOWS && \
+			test $uc_val = true && \
+			test $fsm_val = false && \
+			try_moves="false"
+		if test $try_moves = true
+		then
+			matrix_try $uc_val $fsm_val move_directory_contents_deeper
+			matrix_try $uc_val $fsm_val move_directory_up
+			matrix_try $uc_val $fsm_val move_directory
+		fi
+
 		if test $fsm_val = true
 		then
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
-- 
gitgitgadget


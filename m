Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1541C6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJUO2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhJUO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E29C061225
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p21so908069wmq.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=COXlRNz5eubvZuyJFl2CvQn08p/blu87ntI7iDlh4dI=;
        b=Y+Jc9RgzwcV3WSvzArlqFHIzd6PHGmMGzCliHzKW6WALNKWuvbrVtbk1ydfn8FX6cj
         H7PuHwSAOjYMbXmUOI+X6lSNYoHtC/1vLBTvtgyNdKd/IaPjx1N1h4mMmS1/UDCdreH3
         0VS8cPU8bAQ8VVlallecFNYFE8WPDCNTo6OIths7s285NNimgVkevrdfqHbCUOhXqwo3
         ao57eFRcTybWwddcvLB1rfzhmw8u46HNOy/8kAZ/qEQYNPaTlYAx1tG2iP0c9WqAdpvL
         FMnefAOKLUyNbGQRA1AcUiAW4IjFRHHDwikeNKVDzi0sD5sGGpzxHr52cDW5BVU1Zv+G
         /K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=COXlRNz5eubvZuyJFl2CvQn08p/blu87ntI7iDlh4dI=;
        b=0/qhhXWOkJP/9BdsRrAtDnxnaqwfMQeslP8+FW8DcuF3+w+BcA8udQ6yz3K6DqQasi
         cFYz9YLo6L7lN4OCIjenpuVpQkundz0ZhRj/FjEE26Tpp5t0iMUmq1fLD2yDoPc04ENY
         z8JUeZe7hHY/LSvRJCUqO0f36iFz0gbhIvSR0ivPzJQIU/NK6nuK6OvDOvq6oDTX66C4
         sZyap2H41KFZk2UM2rnoH8KPJnJXOhZHM63WVgzhIRKO6H3BN+fXVySupQxaAatepfLI
         o//6dJbMhGGD5ubTIgWqIvBGTF30kY3EMFkd7EMzXfh/65Gfqwhqfp5w4lNboG5Pjaxf
         Qgpg==
X-Gm-Message-State: AOAM531dPKd8X9Q3qgsz4X4/uN9wDxf0g+yolFpUnLZhXWs9EA/4HDn1
        Y3mQbYmPm8Fi6U0Onlq4uRC6bYUCHiY=
X-Google-Smtp-Source: ABdhPJw4e083cu2UAGCFWuVpfv4KjLwdsa8kJSqs1twiOMoew7GVGyQ9IS/QosyZxMDajWGYWNq6fQ==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr7386507wmi.30.1634826326064;
        Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm4934512wrr.70.2021.10.21.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:25 -0700 (PDT)
Message-Id: <236b5966257da68c14087b807cb4feef3f1a806f.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:05 +0000
Subject: [PATCH v4 25/29] t/perf/p7519: add fsmonitor--daemon test cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 171644ffc90..e70252ed65a 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -24,7 +24,8 @@ test_description="Test core.fsmonitor"
 # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
 # GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
 #   absolute path to an integration. May be a space delimited list of
-#   absolute paths to integrations.
+#   absolute paths to integrations.  (This hook or list of hooks does not
+#   include the built-in fsmonitor--daemon.)
 #
 # The big win for using fsmonitor is the elimination of the need to scan the
 # working directory looking for changed and untracked files. If the file
@@ -143,10 +144,16 @@ test_expect_success "one time repo setup" '
 
 setup_for_fsmonitor() {
 	# set INTEGRATION_SCRIPT depending on the environment
-	if test -n "$INTEGRATION_PATH"
+	if test -n "$USE_FSMONITOR_DAEMON"
 	then
+		git config core.useBuiltinFSMonitor true &&
+		INTEGRATION_SCRIPT=false
+	elif test -n "$INTEGRATION_PATH"
+	then
+		git config core.useBuiltinFSMonitor false &&
 		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
 	else
+		git config core.useBuiltinFSMonitor false &&
 		#
 		# Choose integration script based on existence of Watchman.
 		# Fall back to an empty integration script.
@@ -182,7 +189,10 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite() {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -293,4 +303,25 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+if test_have_prereq FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	trace_start fsmonitor--daemon--server
+	git fsmonitor--daemon start
+
+	trace_start fsmonitor--daemon--client
+	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget


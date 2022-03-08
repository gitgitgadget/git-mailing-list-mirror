Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD64C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350694AbiCHWRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350709AbiCHWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9829C580DC
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso2094170wms.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=AWHDxp71FooubSOu6NyoomkByJm5Fqm+U3/G0wbVPg3VMxIK0snCmF+rSBDVcEQRqz
         QeJMhNWGitiQlH5GYZ+lueIXBu5j0RpyMGGWJSicifW3atgLy5ZdMdDqpCbW+/K/zMEf
         ++FCNK0b+mrkMEf7H3PIhOg4ZGDjniNrO43X3GYaoCmgsVUKS4O/slDObUe37HvVRsiX
         ImR+TbGAgq5gB/wBjyuUiVLws+rcnahtHjGN6NjrZvC3GylPczcYsCUJmTdn/mv4MdT8
         IZ6251MthyiP1F+jZQ2uUPQRz63L8/sKRSRSghZnXBpbeQZvR/bhhhc9ePdk5Nyh/C9p
         jrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=PhJzE35BMiU3juLt3KrRh9zdZo0NbVB01YLQ7YXN7IWUzqMtvJKq4vH2Mnufw7Rxbn
         CP2IF0QjbcMCrYqPJKBkgi4vq1uZs1hpyTXAa7GI9XkHD7KVGrqkhzks7+H3Nav+Uq+u
         H8CFhd+/R0/0HFdRx6nNiHSnKm5QEcUxL6DpnqvF5ZZqy/v8NORkTedbjFMeMtMgYDVg
         OQUnm8y2GuSqL0biXYIOu5Fa4XNE0ueuz+CbExI466WwO/l4YqTcnAzRbAO2RY+F45Uv
         cI6OGMs29rJe4ZAAt32hQOiFrfn5mXCPIZWKcjTSl3hwx/74GJhZntxM6p14b1Hqx6B/
         8Hrw==
X-Gm-Message-State: AOAM5315GS+7QRfMO4uvjcBbDDGFGP9a86DnGnsTPJQeOoeYV9HmBjjU
        YUP0CnbufK3psHBBBVBaDBpuUW+iInc=
X-Google-Smtp-Source: ABdhPJyNWu4cEW2He/7Umo/s75S1gmX6+muu7f6wVIQ9tbG+cnVaVaScBytH+jR5ZSa/qaAtUBTw7w==
X-Received: by 2002:a1c:7212:0:b0:389:9f29:4e28 with SMTP id n18-20020a1c7212000000b003899f294e28mr5303390wmc.165.1646777751837;
        Tue, 08 Mar 2022 14:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10-20020adfa18a000000b001f04c24afe7sm99708wru.41.2022.03.08.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:51 -0800 (PST)
Message-Id: <4b59013caddc0d8ea6bdc2e4b78166c31b6e0027.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:21 +0000
Subject: [PATCH v2 21/27] t/perf/p7527: add perf test for builtin FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7527-builtin-fsmonitor.sh | 257 ++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..9338b9ea008
--- /dev/null
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -0,0 +1,257 @@
+#!/bin/sh
+
+test_description="Perf test for the builtin FSMonitor"
+
+. ./perf-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+# Lie to perf-lib and ask for a new empty repo and avoid
+# the complaints about GIT_PERF_REPO not being big enough
+# the perf hit when GIT_PERF_LARGE_REPO is copied into
+# the trash directory.
+#
+# NEEDSWORK: It would be nice if perf-lib had an option to
+# "borrow" an existing large repo (especially for gigantic
+# monorepos) and use it in-place.  For now, fake it here.
+#
+test_perf_fresh_repo
+
+
+# Use a generated synthetic monorepo.  If it doesn't exist, we will
+# generate it.  If it does exist, we will put it in a known state
+# before we start our timings.
+#
+PARAM_D=5
+PARAM_W=10
+PARAM_F=9
+
+PARAMS="$PARAM_D"."$PARAM_W"."$PARAM_F"
+
+BALLAST_BR=p0006-ballast
+export BALLAST_BR
+
+TMP_BR=tmp_br
+export TMP_BR
+
+REPO=../repos/gen-many-files-"$PARAMS".git
+export REPO
+
+if ! test -d $REPO
+then
+	(cd ../repos; ./many-files.sh -d $PARAM_D -w $PARAM_W -f $PARAM_F)
+fi
+
+
+enable_uc () {
+	git -C $REPO config core.untrackedcache true
+	git -C $REPO update-index --untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+disable_uc () {
+	git -C $REPO config core.untrackedcache false
+	git -C $REPO update-index --no-untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+start_fsm () {
+	git -C $REPO fsmonitor--daemon start
+	git -C $REPO fsmonitor--daemon status
+	git -C $REPO config core.fsmonitor true
+	git -C $REPO update-index --fsmonitor
+	git -C $REPO status >/dev/null 2>&1
+}
+
+stop_fsm () {
+	git -C $REPO config --unset core.fsmonitor
+	git -C $REPO update-index --no-fsmonitor
+	test_might_fail git -C $REPO fsmonitor--daemon stop 2>/dev/null
+	git -C $REPO status >/dev/null 2>&1
+}
+
+
+# Ensure that FSMonitor is turned off on the borrowed repo.
+#
+test_expect_success "Setup borrowed repo (fsm+uc)" "
+	stop_fsm &&
+	disable_uc
+"
+
+# Also ensure that it starts in a known state.
+#
+# Because we assume that $GIT_PERF_REPEAT_COUNT > 1, we are not going to time
+# the ballast checkout, since only the first invocation does any work and the
+# subsequent ones just print "already on branch" and quit, so the reported
+# time is not useful.
+#
+# Create a temp branch and do all work relative to it so that we don't
+# accidentially alter the real ballast branch.
+#
+test_expect_success "Setup borrowed repo (temp ballast branch)" "
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO reset --hard &&
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	git -C $REPO branch $TMP_BR $BALLAST_BR &&
+	git -C $REPO checkout $TMP_BR
+"
+
+
+echo Data >data.txt
+
+# NEEDSWORK: We assume that $GIT_PERF_REPEAT_COUNT > 1.  With
+# FSMonitor enabled, we can get a skewed view of status times, since
+# the index MAY (or may not) be updated after the first invocation
+# which will update the FSMonitor Token, so the subsequent invocations
+# may get a smaller response from the daemon.
+#
+do_status () {
+	msg=$1
+
+	test_perf "$msg" "
+		git -C $REPO status >/dev/null 2>&1
+	"
+}
+
+do_matrix () {
+	uc=$1
+	fsm=$2
+
+	t="[uc $uc][fsm $fsm]"
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_expect_success "$t Setup matrix branch" "
+		git -C $REPO clean -d -f &&
+		git -C $REPO checkout $TMP_BR &&
+		test_might_fail git -C $REPO branch -D $MATRIX_BR &&
+		git -C $REPO branch $MATRIX_BR $TMP_BR &&
+		git -C $REPO checkout $MATRIX_BR
+	"
+
+	if test $uc = true
+	then
+		enable_uc
+	else
+		disable_uc
+	fi
+
+	if test $fsm = true
+	then
+		start_fsm
+	else
+		stop_fsm
+	fi
+
+	do_status "$t status after checkout"
+
+	# Modify many files in the matrix branch.
+	# Stage them.
+	# Commit them.
+	# Rollback.
+	#
+	test_expect_success "$t modify tracked files" "
+		find $REPO -name file1 -exec cp data.txt {} \\;
+	"
+
+	do_status "$t status after big change"
+
+	# Don't bother timing the "add" because _REPEAT_COUNT
+	# issue described above.
+	#
+	test_expect_success "$t add all" "
+		git -C $REPO add -A
+	"
+
+	do_status "$t status after add all"
+
+	test_expect_success "$t add dot" "
+		git -C $REPO add .
+	"
+
+	do_status "$t status after add dot"
+
+	test_expect_success "$t commit staged" "
+		git -C $REPO commit -a -m data
+	"
+
+	do_status "$t status after commit"
+
+	test_expect_success "$t reset HEAD~1 hard" "
+		git -C $REPO reset --hard HEAD~1 >/dev/null 2>&1
+	"
+
+	do_status "$t status after reset hard"
+
+	# Create some untracked files.
+	#
+	test_expect_success "$t create untracked files" "
+		cp -R $REPO/ballast/dir1 $REPO/ballast/xxx1
+	"
+
+	do_status "$t status after create untracked files"
+
+	# Remove the new untracked files.
+	#
+	test_expect_success "$t clean -df" "
+		git -C $REPO clean -d -f
+	"
+
+	do_status "$t status after clean"
+
+	if test $fsm = true
+	then
+		stop_fsm
+	fi
+}
+
+# Begin testing each case in the matrix that we care about.
+#
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+
+fsm_values="false true"
+
+for uc_val in $uc_values
+do
+	for fsm_val in $fsm_values
+	do
+		do_matrix $uc_val $fsm_val
+	done
+done
+
+cleanup () {
+	uc=$1
+	fsm=$2
+
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_might_fail git -C $REPO branch -D $MATRIX_BR
+}
+
+
+# We're borrowing this repo.  We should leave it in a clean state.
+#
+test_expect_success "Cleanup temp and matrix branches" "
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	for uc_val in $uc_values
+	do
+		for fsm_val in $fsm_values
+		do
+			cleanup $uc_val $fsm_val
+		done
+	done
+"
+
+test_done
-- 
gitgitgadget


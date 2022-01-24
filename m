Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12808C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbiAXTCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbiAXS7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5FFC0619C3
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so36646wmr.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0cTVlvy3koO8kIFX46QMstD+ERk03HMw6aT8GNBxMTM=;
        b=JmgLikkhxHoG2J97PFaZvTa8lwGk+HZOHk3+eLiidHz5H3exheIWxEqaGEfxsFLyLw
         y/OXzwMakzZA2rQ25abMippB5QdvO/XXNyCz4OK1NvLuXuYO/X8ja3gtVxYN9zBZrJEZ
         fYEsEF9VOApXXR1L2br/DWdu7Z9+bKxrzCWPiABunuhJVI34pJJlSOqPZUYa7z9QFiRe
         LpUbPuFzsE1BghKbGpf4qAKFEtXpHSIA1YK3HBKo9OQNu64AU0N2Sc8XaVK6ETL4AlRq
         By9JkrhHiDTX4o6qabSZcpp7//i1r4Rl3T/p9kgswG38CYKhm9SeKBT5aO+QhMQ2TG8J
         L+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0cTVlvy3koO8kIFX46QMstD+ERk03HMw6aT8GNBxMTM=;
        b=AzYpexclwXEjoGzWT33Xim7hYSrkNPaQ3yPDnsNA9taHLtQ6Kx5iHqgCKqUO7W6Kqd
         Xnt/GDrPI2C5FSMorVg+kPx6lcdRaKIS0UqIQhwctb47j2lwM803uW48E08EfthhBMw/
         kT8WAf723XKnSQITnxDOi/zrNaFXXGDCMOkR/+xswPV36b4wchjTSmkUL4EVDYuXfRXW
         3+mUJEGgJ9peQQ4MZlU2gF3P+TbbI/gCHow/GqMPmLcn58iULcNvZaKMPnyxZ5dgEwey
         70s8Y8f+t7Y5/Z3Pi62KbwclFQpzcQpAxEj+6frRAJkx0Rf++3JK/PEY2asiQWb2gWXl
         T1Ig==
X-Gm-Message-State: AOAM532BTdObHwVhY4RcwMwpx63ChAVf6zOM+/GU4mtA8kHq3Wd43hsg
        Z5sCZObk9A74wYsf9WrhYGscPJe1qe0=
X-Google-Smtp-Source: ABdhPJx/Aw8pJG5RXwEp5rg4uJ/2xZ8Um4Kz00QrjsCDM6AhkO8h0W/o/GqvwlEh6YNYWovjn3C2Rg==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr362978wma.11.1643050587358;
        Mon, 24 Jan 2022 10:56:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm7044804wrx.101.2022.01.24.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:26 -0800 (PST)
Message-Id: <98b32630fcd76d591ce64f19314f3081134f541e.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:12 +0000
Subject: [PATCH 7/9] ci: optionally mark up output in the GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A couple of commands exist to spruce up the output in GitHub workflows:
https://docs.github.com/en/actions/learn-github-actions/workflow-commands-for-github-actions

In addition to the `::group::<label>`/`::endgroup::` commands (which we
already use to structure the output of the build step better), we also
use `::error::`/`::notice::` to draw the attention to test failures and
to test cases that were expected to fail but didn't.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh              |  4 +--
 t/test-lib-github-workflow-markup.sh | 50 ++++++++++++++++++++++++++++
 t/test-lib.sh                        |  5 ++-
 3 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c3d38aaccbd..b5fe5f66085 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,7 +719,7 @@ test_verify_prereq () {
 }
 
 test_expect_failure () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-failure"
@@ -739,7 +739,7 @@ test_expect_failure () {
 }
 
 test_expect_success () {
-	test_start_
+	test_start_ "$@"
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	BUG "not 2 or 3 parameters to test-expect-success"
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
new file mode 100644
index 00000000000..d8dc969df4a
--- /dev/null
+++ b/t/test-lib-github-workflow-markup.sh
@@ -0,0 +1,50 @@
+# Library of functions to mark up test scripts' output suitable for
+# pretty-printing it in GitHub workflows.
+#
+# Copyright (c) 2022 Johannes Schindelin
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+#
+# The idea is for `test-lib.sh` to source this file when run in GitHub
+# workflows; these functions will then override (empty) functions
+# that are are called at the appropriate times during the test runs.
+
+start_test_output () {
+	test -n "$GIT_TEST_TEE_OUTPUT_FILE" ||
+	die "--github-workflow-markup requires --verbose-log"
+	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
+	>$github_markup_output
+	GIT_TEST_TEE_OFFSET=0
+}
+
+# No need to override start_test_case_output
+
+finalize_test_case_output () {
+	test_case_result=$1
+	shift
+	case "$test_case_result" in
+	failure)
+		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		;;
+	fixed)
+		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
+		;;
+	esac
+	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
+	test-tool >>$github_markup_output path-utils skip-n-bytes \
+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+	echo >>$github_markup_output "::endgroup::"
+}
+
+# No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e13e1cb9124..076bee58c19 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -174,6 +174,9 @@ parse_option () {
 	--write-junit-xml)
 		. "$TEST_DIRECTORY/test-lib-junit.sh"
 		;;
+	--github-workflow-markup)
+		. "$TEST_DIRECTORY/test-lib-github-workflow-markup.sh"
+		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -1027,7 +1030,7 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
-	start_test_case_output
+	start_test_case_output "$@"
 }
 
 test_finish_ () {
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F8C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiG0XOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG0XNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:13:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEF4C63A
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l22so106164wrz.7
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=R+BrETSMlNBsU78LOI9BAZy4FNrlsZono2VQHwJpy7c=;
        b=Yxv6KSgAsiPACldMb+PdxjTkEr1fD0SqZLn7Q5o+osYOlwcA+1h1Vn3fEu1TyFObbG
         nwqpjjLh10T1de6f0fVxgFojNgpjKKAlQyiYsUP8lc5o2tlHTeo91HFnIhyQa19+qh+8
         ZRLp1gRyVtGxXx71b58k3sUsz4l0ADLmidVqnvRCBEzUsd4SkUFwolK0BodgoSiQZiO3
         BIiBEhD9nY1Ef3QDwmDIhIO2wQQ88cuM8IxksWAoryPfAUJSisbBVix9jtPkN7yUPI9x
         /Sa2mLn8IvlAaVEyKEEEGqy2wmA1h3mE0AtsS/txS6gfWEPIvnJVqi12ZIXHr56Im+Np
         ejrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R+BrETSMlNBsU78LOI9BAZy4FNrlsZono2VQHwJpy7c=;
        b=QxL4hPEuxo8PCyih9CUoZIiNxzrlKp6BJpQJfAI+vMbxshDJ3o4eaOroCSdqsGYTg0
         vxVqmrWddV/l+VLCQ7hbwhkgaCeATmS6tbhhp+svSujQxD6DLykz6al5d2Bx4SKns8NG
         n3xDiXstxZ/NB8zq+bLFlM7E4a6Il7cJQoEREuQR7uh9K2njSvB2EUkEEOysvLWw4bv0
         xI+cpq+6jiQdy7YSAUdCBHY8XMvcv00ta7KbpY8V0isGBU9cM1TilqiGeYPuh8R5N3Zs
         8D+LlzUPSJVyCMFTC0ehMpJfPE7myRJIhXJXcwwr1igeGKFdGRkxRzEAziXx5PEuF3W7
         lenA==
X-Gm-Message-State: AJIora/cqbVAScU5YIqw+LsXsQ36T0xyqO8lorfIgrxFAykfEBLDGi4k
        Ga6faWeN0uLvx7T+NtPBilghByPMV33AEA==
X-Google-Smtp-Source: AGRyM1v5inzjZalCzcob4em6NGFcaDXyztfpexqUN7aaBsPDG+K9NJIezIqSGoB50CWjXaiLG8yKUA==
X-Received: by 2002:a5d:47c1:0:b0:21d:cfe2:fb00 with SMTP id o1-20020a5d47c1000000b0021dcfe2fb00mr15342193wrc.495.1658963632750;
        Wed, 27 Jul 2022 16:13:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/15] test-lib: add a --invert-exit-code switch
Date:   Thu, 28 Jul 2022 01:13:32 +0200
Message-Id: <patch-v3-04.15-f3144af2190-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to have those tests that fail return 0, and those
tests that succeed return 1. This is useful e.g. to run "--stress"
tests on tests that fail 99% of the time on some setup, i.e. to smoke
out the flaky run which yielded success.

In a subsequent commit a new SANITIZE=leak mode will make use of this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh    | 45 ++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 17a268ccd1b..502b4bcf9ea 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -578,6 +578,78 @@ test_expect_success 'subtest: --run invalid range end' '
 	EOF_ERR
 '
 
+test_expect_success 'subtest: --invert-exit-code without --immediate' '
+	run_sub_test_lib_test_err full-pass \
+		--invert-exit-code &&
+	check_sub_test_lib_test_err full-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	ok 2 - passing test #2
+	ok 3 - passing test #3
+	# passed all 3 test(s)
+	1..3
+	# faking up non-zero exit with --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code with --immediate: all passed' '
+	run_sub_test_lib_test_err full-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test_err full-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	ok 2 - passing test #2
+	ok 3 - passing test #3
+	# passed all 3 test(s)
+	1..3
+	# faking up non-zero exit with --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code without --immediate: partial pass' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code &&
+	check_sub_test_lib_test partial-pass <<-\EOF
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	ok 3 - passing test #3
+	# failed 1 among 3 test(s)
+	1..3
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF
+'
+
+test_expect_success 'subtest: --invert-exit-code with --immediate: partial pass' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test partial-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	1..2
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
+test_expect_success 'subtest: --invert-exit-code --immediate: got a failure' '
+	run_sub_test_lib_test partial-pass \
+		--invert-exit-code --immediate &&
+	check_sub_test_lib_test_err partial-pass \
+		<<-\EOF_OUT 3<<-EOF_ERR
+	ok 1 - passing test #1
+	not ok 2 - # TODO induced breakage (--invert-exit-code): failing test #2
+	#	false
+	1..2
+	# faked up failures as TODO & now exiting with 0 due to --invert-exit-code
+	EOF_OUT
+	EOF_ERR
+'
+
 test_expect_success 'subtest: tests respect prerequisites' '
 	write_and_run_sub_test_lib_test prereqs <<-\EOF &&
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 118720493bb..31213b5f95b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -238,6 +238,9 @@ parse_option () {
 			;;
 		esac
 		;;
+	--invert-exit-code)
+		invert_exit_code=t
+		;;
 	*)
 		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
@@ -788,15 +791,31 @@ test_ok_ () {
 	finalize_test_case_output ok "$@"
 }
 
+_invert_exit_code_failure_end_blurb () {
+	say_color warn "# faked up failures as TODO & now exiting with 0 due to --invert-exit-code"
+}
+
 test_failure_ () {
 	failure_label=$1
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	local pfx=""
+	if test -n "$invert_exit_code" # && test -n "$HARNESS_ACTIVE"
+	then
+		pfx="# TODO induced breakage (--invert-exit-code):"
+	fi
+	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
+		if test -n "$invert_exit_code"
+		then
+			finalize_test_output
+			_invert_exit_code_failure_end_blurb
+			GIT_EXIT_OK=t
+			exit 0
+		fi
 		_error_exit
 	fi
 	finalize_test_case_output failure "$failure_label" "$@"
@@ -1229,7 +1248,14 @@ test_done () {
 			esac
 		fi
 
-		if test -z "$debug" && test -n "$remove_trash"
+		if test -n "$stress" && test -n "$invert_exit_code"
+		then
+			# We're about to move our "$TRASH_DIRECTORY"
+			# to "$TRASH_DIRECTORY.stress-failed" if
+			# --stress is combined with
+			# --invert-exit-code.
+			say "with --stress and --invert-exit-code we're not removing '$TRASH_DIRECTORY'"
+		elif test -z "$debug" && test -n "$remove_trash"
 		then
 			test -d "$TRASH_DIRECTORY" ||
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
@@ -1242,6 +1268,14 @@ test_done () {
 			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
+
+		if test -z "$skip_all" && test -n "$invert_exit_code"
+		then
+			say_color warn "# faking up non-zero exit with --invert-exit-code"
+			GIT_EXIT_OK=t
+			exit 1
+		fi
+
 		test_at_end_hook_
 
 		GIT_EXIT_OK=t
@@ -1254,6 +1288,13 @@ test_done () {
 			say "1..$test_count"
 		fi
 
+		if test -n "$invert_exit_code"
+		then
+			_invert_exit_code_failure_end_blurb
+			GIT_EXIT_OK=t
+			exit 0
+		fi
+
 		GIT_EXIT_OK=t
 		exit 1 ;;
 
-- 
2.37.1.1127.g4ecf1c08f67


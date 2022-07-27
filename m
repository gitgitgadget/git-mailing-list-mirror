Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3FC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiG0XOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiG0XOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2A4E62B
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z16so34953wrh.12
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CNck2v6HIV9KLuzoCg+ReY4LBQtDEWtGj/wAq+3L5RM=;
        b=k9t+YeQvlK53LyUqBARSriGZbeGb4MDiipqD6Iyio//wqV5XxQ6DkBLHr9NdMYKpi2
         HEAl9Ott/Bn65SR0RajNpaqxcKhIRl8yM3Iu3l8T0Gusul7Z+DFwHgCQeO8PfbYpoDxY
         ardZ4i4v14tQi3wtZbllN6M1Y6ctiDD+SOajJr73ArsqQeIOJHI0DI9ez3ADSuSgUW98
         vmNQhxO6zUjrg9zKrdrDDi5OI9pQYLdKAluuFApd859ZF4o7AozlNaGP1MVOiyynxQUe
         iGL9/QIU73Wd4Ojry9Vzv5wOK1nu91dLL00UdejUSCHHZn0ZqUFWshHf1P0BCudzqTQu
         NEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CNck2v6HIV9KLuzoCg+ReY4LBQtDEWtGj/wAq+3L5RM=;
        b=QYdrQ+m5cl15WGAW9aotMH6B5YpJsm9ncsQT55EGxAvT6a8Vk5NslbODDZIcyLWCJv
         JnYOBnFIde/AbxPxfXJc/EarfI8Os++NRpgQsZJf6474HkAmKyvfT24orFMlsxoyg5J9
         GFwF5QPPBuw2WLZEjc/1F3AOkSwETV7EMDjPBykhf0zd7oTT3aERLvcGCKQrqcd+jmxP
         1O32euOLBbA7cKeaVkrCHURUPQmv7S3vXZNkcItcNr6c7CEZSt8iOALKzRBj6nxho0bY
         nEjRtDz9HDf+8LjirRrCjXFYRwZxN02WTWjHJoS+nJFllKvK8XUUV5/WLFU/ODNHBPIA
         RWAA==
X-Gm-Message-State: AJIora8o1++k0nZEBSbqsXz3fTcRnv6E8ug/S7k6GlzL2A0zIsAEEdT1
        shOiFf1vJN44BDIoOztxQsth716KEJYeAA==
X-Google-Smtp-Source: AGRyM1sOnFKAiEVJfL+DzVc4C4FBKkghJEMoPkMo7a+aneNZq0Zvaxea53dlaJluvoD6/IAF5+LllA==
X-Received: by 2002:a05:6000:3cc:b0:21e:7f8a:3925 with SMTP id b12-20020a05600003cc00b0021e7f8a3925mr13909831wrg.570.1658963640271;
        Wed, 27 Jul 2022 16:14:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/15] test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
Date:   Thu, 28 Jul 2022 01:13:38 +0200
Message-Id: <patch-v3-10.15-32564b8fcb3-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode to the
test-lib.sh.

As noted in the updated "t/README" this compliments the existing
"GIT_TEST_PASSING_SANITIZE_LEAK=true" mode added in
956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
2021-09-23).

Rather than document this all in one (even more) dense paragraph split
up the discussion of how it combines with --immediate into its own
paragraph following the discussion of
"GIT_TEST_SANITIZE_LEAK_LOG=true".

Before the removal of "test_external" in a preceding commit we would
have had to special-case t9700-perl-git.sh and t0202-gettext-perl.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 17 +++++++++++++++++
 t/test-lib.sh | 34 ++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index 98f69ed13d2..e13063195e5 100644
--- a/t/README
+++ b/t/README
@@ -371,11 +371,28 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
+"TEST_PASSES_SANITIZE_LEAK=true" markings are current. Rather than
+skipping those tests that haven't set "TEST_PASSES_SANITIZE_LEAK=true"
+before sourcing "test-lib.sh" this mode runs them with
+"--invert-exit-code". This is used to check that there's a one-to-one
+mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
+pass under "SANITIZE=leak". This is especially useful when testing a
+series that fixes various memory leaks with "git rebase -x".
+
 GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
 "test-results/$TEST_NAME.leak/trace.*" files. The logs include a
 "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
 make logs +machine-readable.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
+will run to completion faster, and result in the same failing
+tests. The only practical reason to run
+GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
+combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
+first failing test case our leak logs won't show subsequent leaks we
+might have run into.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 067927eb06c..3d0c8896e0e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1451,17 +1451,34 @@ BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
 
 if test -n "$SANITIZE_LEAK"
 then
-	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	# Normalize with test_bool_env
+	passes_sanitize_leak=
+
+	# We need to see TEST_PASSES_SANITIZE_LEAK in "git
+	# env--helper" (via test_bool_env)
+	export TEST_PASSES_SANITIZE_LEAK
+	if test_bool_env TEST_PASSES_SANITIZE_LEAK false
+	then
+		passes_sanitize_leak=t
+	fi
+
+	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 	then
-		# We need to see it in "git env--helper" (via
-		# test_bool_env)
-		export TEST_PASSES_SANITIZE_LEAK
+		if test -n "$invert_exit_code"
+		then
+			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
+		fi
 
-		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
+		if test -z "$passes_sanitize_leak"
 		then
-			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-			test_done
+			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
+			invert_exit_code=t
 		fi
+	elif test -z "$passes_sanitize_leak" &&
+	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	then
+		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+		test_done
 	fi
 
 	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
@@ -1480,7 +1497,8 @@ then
 		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
 		export LSAN_OPTIONS
 	fi
-elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
 elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
-- 
2.37.1.1127.g4ecf1c08f67


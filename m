Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B546C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiAXTBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbiAXS7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:59:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C95C06118C
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r14so15388901wrp.2
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mg3KhFwO9GAljunFpr+hdC3tt+UoQvn0pI9Ay70kHO8=;
        b=OFtyOUs8WSeIGsDXQqmzJtVmlPiEAqGAJcxcihJeSzP4gg/emKSZu+AGs3DCY6eja6
         5BJSj7bVWau9REdyLxIR4ZPJfGeG3p7IbdQ1demJEzK/kc0hz2suy4YViT2IRfUZ1eGd
         TvgdzKBRVEpROShcJY89n+O7mX6vjjBKDDKZnK3aiFoz5MzGpvv16Xx4RAewegVgvbD+
         Knx6hc7L72bcJBWaf2braXFccjMlQKxBSt/mDzdmG+zO4CXy6ISWuzLV5UP3tBB6ciAE
         /x8g0Mi++AY3DsjFt8paxVA7A9rMOLdbgFh3GzWZ9LGFLQlA1Fn2FJ2tjrQsBRLGmPPw
         0TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mg3KhFwO9GAljunFpr+hdC3tt+UoQvn0pI9Ay70kHO8=;
        b=2TepEaWeRYpg5MmYexMxsws7yjyVuAdMFRpDl0TGa6VsBsdAPUCTpskXEHvEUFTldg
         QrM+X3rOEkbJC8g1mbIgwoPp8wvG5T6dlvQEp3iqt8qo0sFA98LdNS4I+R2tIvk33d39
         j1avVT/NAJFqBwYKuLEo7T9TUYUp+AyGHPKjMQimKFUjNYCEfeyB25W6p7GUqfoccUwU
         FcSKq4Y2ZWD2Xn1O5kzjkrpMbUvrvviViUWLuv6MmCKZeNsnPtT1itDOuuPxG9nljGjv
         OZhdA+qa22aCOCdPt++sFfy+wqb3NyUYovgqSwatlyBRdbUHrrQppJGW0rRgS4yyQgL8
         O0xw==
X-Gm-Message-State: AOAM530JsLlK50nn7+6DpuWx9YI2vAHMnpod4EfJOhicPobYzpWG0KCw
        LHTh9K8n2EoCfOULlHtIaHL/f5Wbw84=
X-Google-Smtp-Source: ABdhPJx5lMvKZIo4SE1awHVEFJWjKNlg+EZkPQTRQwDVKc48Y1HS1FxwSQ5HPVguQAa0CrAStwN5TQ==
X-Received: by 2002:adf:9dc9:: with SMTP id q9mr7821727wre.203.1643050583784;
        Mon, 24 Jan 2022 10:56:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm122342wmr.25.2022.01.24.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:56:21 -0800 (PST)
Message-Id: <9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 18:56:09 +0000
Subject: [PATCH 4/9] ci/run-build-and-tests: add some structure to the GitHub
 workflow output
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

The current output of Git's GitHub workflow can be quite confusing,
especially for contributors new to the project.

To make it more helpful, let's introduce some collapsible grouping.
Initially, readers will see the high-level view of what actually
happened (did the build fail, or the test suite?). To drill down, the
respective group can be expanded.

Note: sadly, workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details),
therefore we take pains to ensure to end any previous group before
starting a new one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh                 | 55 ++++++++++++++++++++++++++++++++++-----
 ci/run-build-and-tests.sh |  4 +--
 ci/run-test-slice.sh      |  2 +-
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2b2c0932320..4ed8f40ab02 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,49 @@
 # Library of functions shared by all CI scripts
 
+if test true != "$GITHUB_ACTIONS"
+then
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
+else
+	begin_group () {
+		need_to_end_group=t
+		echo "::group::$1" >&2
+		set -x
+	}
+
+	end_group () {
+		test -n "$need_to_end_group" || return 0
+		set +x
+		need_to_end_group=
+		echo '::endgroup::' >&2
+	}
+	trap end_group EXIT
+
+	group () {
+		set +x
+		begin_group "$1"
+		shift
+		"$@"
+		res=$?
+		end_group
+		return $res
+	}
+
+	begin_group "CI setup"
+fi
+
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong.
+# Set tracing executed commands, primarily setting environment variables
+# and installing dependencies.
+set -e
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -88,12 +132,6 @@ export TERM=${TERM:-dumb}
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
-set -ex
-
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
@@ -138,7 +176,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			cat "t/test-results/$test_name.out"
+			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
@@ -234,3 +272,6 @@ linux-leaks)
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+
+end_group
+set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index e49f9eaa8c0..5516f45f7fe 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -48,10 +48,10 @@ esac
 # Any new "test" targets should not go after this "make", but should
 # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
 # start running tests.
-make
+group Build make
 if test -n "$run_tests"
 then
-	make test ||
+	group "Run tests" make test ||
 	handle_failed_tests
 fi
 check_unignored_build_artifacts
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 63358c23e11..a3c67956a8d 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make --quiet -C t T="$(cd t &&
+group "Run tests" make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')" ||
 handle_failed_tests
-- 
gitgitgadget


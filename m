Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC8C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiEUWTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiEUWTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:19:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5340A4EF69
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m20so4776127wrb.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3L0yUdu/rjFTtYj9ucbGZSQMuykrsevUUqWmK3QrWro=;
        b=UHvRGsd9/Ie5hVfDzHx/HCxa4Wr8ZwklUyklj+wO/2jFIwxgL5SwkhXj4XF8dumffL
         Fki4EKDRsnmj3i+1THitCnRCMEb4r2/4DqGD+MNtQxX+sPudHl6ghG2gb373xlWiuWu9
         R/dvyPCUgO7eMypGthcYaxCO/3Ri/+LIUX25EJuCgqrji2jtvm8tHtAZw50IBlYRFpGn
         CEKO08CmZXtK+GvMakl+1SB78kTIXP9Mzcjh4XuHTEtmfKN0JUWHlLzQ64ZRULCHKUgu
         VIDRXBqgw1EmCOPd8aigPcIHbePhjEBs07Z8CtustiV9j0SSCqpz81ofSQVlNskRnPuw
         k3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3L0yUdu/rjFTtYj9ucbGZSQMuykrsevUUqWmK3QrWro=;
        b=HXT4Cx1XGr93Yvkd4hdxE9Sf8XeQHRnLjmLZu+JZbvql+DzlndyKRm/NvzW/e4fMpq
         OUK2OQimJcv1YKPIDPZ2DnU+hzdHWOnH/ycd+5bIJDk1/jv+8h0NquNOfL9nNAgPRF/b
         B6PCLUIUJ78UmYKi+pRAggGZzZSbeH1f/NDME5C4LfnCaJuL9raR4JKDbyB9W96ure9Y
         M/CUK+kqN6ui1/4Tig/Q3LSNtTtOfj3dxfgkLEQmL+EwLrpHNYtwj414RtNBPZ5eKHYO
         b5fxNEeQysh2dmlepoTdZ0pqrA9U08HZUk4AZF1WSqXU1RxEPU9XuVhOz0bIo6oKVcpl
         cnJg==
X-Gm-Message-State: AOAM533IWXRa/qvmvWP7hfHFDK77B1VSJfOtNfbSiMTgLZ2WIOcc0OTa
        y5cEYxPasdz1NnQennzQgaXW1vK7q6k=
X-Google-Smtp-Source: ABdhPJzErT/SG/9JqnY1trK1rAWqSTEfeJwDsK1oHdxemCWL4N3bD7ErpDPLVU4s16AeaidDu887jQ==
X-Received: by 2002:a5d:6d8f:0:b0:20c:7fb7:d59c with SMTP id l15-20020a5d6d8f000000b0020c7fb7d59cmr14225921wrs.77.1653171544484;
        Sat, 21 May 2022 15:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020adfb209000000b0020c7ec0fdf4sm6983049wra.117.2022.05.21.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 15:19:04 -0700 (PDT)
Message-Id: <7d2284314efc0071ad9cc9b8f2559e07310e35b0.1653171536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
References: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 22:18:50 +0000
Subject: [PATCH v3 06/12] ci/run-build-and-tests: add some structure to the
 GitHub workflow output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
 ci/lib.sh                 | 56 ++++++++++++++++++++++++++++++++++-----
 ci/run-build-and-tests.sh |  4 +--
 ci/run-test-slice.sh      |  2 +-
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 65f5188a550..f8cb79e44f0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,50 @@
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
+#
+# We already enabled tracing executed commands earlier. This helps by showing
+# how # environment variables are set and and dependencies are installed.
+set -e
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -88,12 +133,6 @@ export TERM=${TERM:-dumb}
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
@@ -138,7 +177,7 @@ then
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			cat "t/test-results/$test_name.out"
+			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
@@ -233,3 +272,6 @@ linux-leaks)
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+
+end_group
+set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1ede75e5556..7abfa00adc0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,10 +45,10 @@ pedantic)
 	;;
 esac
 
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


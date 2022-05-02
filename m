Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E39C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386946AbiEBSnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386937AbiEBSnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:43:02 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167909FF1
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:39:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l9-20020a056830268900b006054381dd35so10292841otu.4
        for <git@vger.kernel.org>; Mon, 02 May 2022 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyySv30ZVZApVhSk5xVYCzpCtcoU6O9pvywvdteXq90=;
        b=Z4ljUgZqeq/LLJRScpaor0+yfYdsITRH2Iv6gMv3WMHSEXiTmiDOykg+SMNnUUkqBJ
         3x7R600fojmO8CcB0Ju3EecIVrNzt6y1PsTKAsvTJRz5YFBFOPOecyykik6FwrzVfaa9
         kDeC2fTbuxRl3u6GHHMdcLpONS724UPjoTWc4ZYIbAmQ5AaxMcTHwmESkuC9VK3K8tMd
         pjHYCyTMlzVFGGwqTkKuFRo9F9ePFeDr1vMDAwRju4I1qrWV8vPwvEQSC0wayU+PTjoh
         6FWUmp0mR19+aUd7NxdirvX+JVky5OOXOdqR1pxB3uUXcO77gTO1xJUqn2hZdhaC/b6f
         Eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyySv30ZVZApVhSk5xVYCzpCtcoU6O9pvywvdteXq90=;
        b=IozcHLzB6b7HedeYcEYXhgHVqiOOLSvexQB/ZyUjXmCIBax7doCWwBwtv507iuYeQq
         GR9wDLuJvH0PZ03LIoovYedtY2ARVzJOyoymFygN8JC7RQcIM4J4TXg4S5Nw3JCTTiug
         FlX6gHkDXzAJ+94SU8lHbHTpUlXX/+0KsvsO4UlnauoS7yOneooz9Bwhf8u/W+c/pVpy
         rOz5cN8i7JEv8/9qPJEn9czLDkLrkAKEiSMwTSQDx2UC0Onshjhm24Zm+KW+N/xgAufO
         SOsrqZlW4//ybScoGt4343RjKq8NYJm7Bcm0qQuCWZyfA+k3N2EGvlyHtNSPBkiV+XQX
         Xv0w==
X-Gm-Message-State: AOAM5319IrprJfPzBU9jWQnja/6u5DXDmS+S2ir0JJscAOiN85h5TOPg
        m7bcSQkSyjmzrso8Q/KCS98uXXb4EAY=
X-Google-Smtp-Source: ABdhPJyAJqlGtS2g0riQZqBUzX2xpJ6aCuXHCIA/ArywiBDhVOFzUCBMGVSGBHkhGgABPgI4/24UVw==
X-Received: by 2002:a05:6830:9c2:b0:606:1e0a:cc8d with SMTP id y2-20020a05683009c200b006061e0acc8dmr1986165ott.265.1651516771186;
        Mon, 02 May 2022 11:39:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a12-20020a056808120c00b00325cda1ff8fsm2620952oil.14.2022.05.02.11.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 11:39:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v3 3/3] t0034: enhance framework to allow testing more commands under sudo
Date:   Mon,  2 May 2022 11:39:20 -0700
Message-Id: <20220502183920.88982-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220502183920.88982-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220502183920.88982-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running under sudo, the environment gets altered in significant
ways, so make sure that PATH is respected by comparing the full path
to git outside and inside sudo and disabling the tests if they don't
match.

Additionally, invent a way to inject environment variables into that
environment and create a helper function to facilitate running more
than one command under sudo, while using those variables.

Add additional negative tests as suggested by Junio and export the
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME variable that will be used when
running init in one of those.

Note that in order to be able to call `test_must_fail sudo git status`
or an equivalent test_must_fail will need to be enhanced or be able
to run under sudo, so fixing that has been punted, since the only
protection it affords is for `git status` not crashing, and that is
covered already by other tests.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/lib-sudo.sh                  | 31 ++++++++++++++++++
 t/t0034-root-safe-directory.sh | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 t/lib-sudo.sh

diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
new file mode 100644
index 00000000000..60046927f3b
--- /dev/null
+++ b/t/lib-sudo.sh
@@ -0,0 +1,31 @@
+# Helpers for running git commands under sudo.
+
+# Runs a scriplet passed through stdin under sudo.
+run_with_sudo () {
+	local ret
+	local SH=${1-"$TEST_SHELL_PATH"}
+	local RUN="$HOME/$$.sh"
+	{
+		echo "#!$SH"
+		echo "set -e"
+		echo ". \"$HOME/env\""
+		cat
+	} >"$RUN" &&
+	chmod +x "$RUN" &&
+	sudo "$SH" -c "\"$RUN\""
+	ret=$?
+	rm -f "$RUN"
+	return $ret
+}
+
+# Makes all variables passed as parameters available to the scriplet that
+# run under sudo with run_with_sudo
+export_to_sudo () {
+	while test -n "$1"
+	do
+		local v
+		eval v="\$$1"
+		echo "$1=$v" >>"$HOME/env"
+		shift
+	done
+}
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index 67dd96b9321..0f79648a2fb 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -3,6 +3,19 @@
 test_description='verify safe.directory checks while running as root'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-sudo.sh
+
+if [ "$IKNOWWHATIAMDOING" != "YES" ]
+then
+	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run this test"
+	test_done
+fi
+
+if ! test_have_prereq NOT_ROOT
+then
+	skip_all="No, you don't; these tests can't run as root"
+	test_done
+fi
 
 # this prerequisite should be added to all the tests, it not only prevents
 # the test from failing but also warms up any authentication cache sudo
@@ -19,6 +32,7 @@ test_lazy_prereq SUDO '
 test_expect_success SUDO 'setup' '
 	sudo rm -rf root &&
 	mkdir -p root/r &&
+	export_to_sudo GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
 	sudo chown root root &&
 	(
 		cd root/r &&
@@ -34,6 +48,50 @@ test_expect_success SUDO 'sudo git status as original owner' '
 	)
 '
 
+test_expect_success SUDO 'setup root owned repository' '
+	sudo mkdir -p root/p &&
+	run_with_sudo <<-END
+		git init root/p
+	END
+'
+
+test_expect_success SUDO 'cannot access if owned by root' '
+	(
+		cd root/p &&
+		test_must_fail git status
+	)
+'
+
+test_expect_success SUDO 'cannot access with sudo' '
+	(
+		# TODO: test_must_fail needs additional functionality
+		# 6a67c759489 blocks its use with sudo
+		cd root/p &&
+		! sudo git status
+	)
+'
+
+test_expect_success SUDO 'can access using a workaround' '
+	# provide explicit GIT_DIR
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			GIT_DIR=.git
+			GIT_WORK_TREE=.
+			export GIT_DIR GIT_WORK_TREE
+			git status
+		END
+	) &&
+	# discard SUDO_UID
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			unset SUDO_UID
+			git status
+		END
+	)
+'
+
 # this MUST be always the last test
 test_expect_success SUDO 'cleanup' '
 	sudo rm -rf root
-- 
2.36.0.352.g0cd7feaf86f


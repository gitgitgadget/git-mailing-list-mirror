Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D6C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386283AbiEGQje (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446649AbiEGQjO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 12:39:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACFBC1
        for <git@vger.kernel.org>; Sat,  7 May 2022 09:35:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o18so8161246qtk.7
        for <git@vger.kernel.org>; Sat, 07 May 2022 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYCNT7m3uqq6DTkFQXRUcyeNtptGd9WC323MmwLXBeA=;
        b=eQ9IqpBKLs52TVc441GdagkPBv8QBZRX9T91PchxwU6SiiSXLoNzoxY+ocuWfVFDsa
         fjVL6Yd4Uxvr/gGlfA4EKjB7AnOJUK0Syr61whMkAIfdTeT3viX2rBgLMrZqyy7IuItv
         nTGQMH9l6KMF2D89z0m9rA6gd9VX6AbFfLg/ub7iFabtyyHcMLuwILB16P+5VZG+mXER
         SH3cA9dy7o+W9agS1Cs1wDt4GrF+BPxXIWrYa5e2Xm3w2kF9TcJdHzua5kuk4ZEqgPPy
         wWUkHbNDTBRMavzCv3akUsWlrbsRYFyUYdnwvAeb/x5S+Kou2JR0qvo8LtEcxNx6i1BR
         B0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYCNT7m3uqq6DTkFQXRUcyeNtptGd9WC323MmwLXBeA=;
        b=AQKuehsWnau/Np/mkMRwH7OLA6gHePjPRD0cwc4JpX3d3tjasnd17bwFMSSnc6sspn
         imR/0ErCv+qNbAfldCrHLNl0v0atUBbzwnlENYNqzprYSh04L2xwsAvVD3PB0A5Ya1p4
         sBgo1GKPCk2Uio6OKoOWQBK8tMRExTQfqpKaUy0lrc2Q81hhX/mPMrg+3RHiYbTNLmyV
         i0ihF32Bm71NAaG81+RLyPfah/dXCUGbW2htdI1NJ+LRk7RW6Qsr6C4DVepeIs3jSrXX
         2an7xKubKUYsrtivYmlCwCc5oUN29IOd7AmoV9e06tJPVsGmc6DfAOaPLR/pp70AQY0f
         EEeQ==
X-Gm-Message-State: AOAM531P55Ewfis1c08pVWU+cThrLiXxZ4lbz4C6lrw8MGUtjnO5puDu
        cBj7bmOwr16HUMbstLcmyaErBGCzf9M=
X-Google-Smtp-Source: ABdhPJzCvSOzvfG522UIHw04bkg6x4Gypvzco3/uuBUFR46f1N4gBb+iG7yQMzhBYWkDJfCVMlYVzw==
X-Received: by 2002:ac8:578c:0:b0:2f3:a7b7:878f with SMTP id v12-20020ac8578c000000b002f3a7b7878fmr8235501qta.186.1651941321888;
        Sat, 07 May 2022 09:35:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l15-20020ac848cf000000b002f39b99f6c3sm4244564qtr.93.2022.05.07.09.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 09:35:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v4 3/3] t0034: add negative tests and allow git init to mostly work under sudo
Date:   Sat,  7 May 2022 09:35:08 -0700
Message-Id: <20220507163508.78459-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220507163508.78459-1-carenas@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com>
 <20220507163508.78459-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a support library that provides one function that can be used
to run a "scriplet" of commands through sudo and that helps invoking
sudo in the slightly awkward way that is required to ensure it doesn't
block the call (if shell was allowed as tested in the prerequisite)
and it doesn't run the command through a different shell than the one
we intended.

Add additional negative tests as suggested by Junio and that use a
new workspace that is owned by root.

Note that the specific test that documents that after the previous
changes, it is no longer possible for root (if obtained through sudo)
to NOT add an exception or need a "workaround" to be able to run git
commands in a repository owned by thyself, is marked as a regression
and is expected to be fixed with a future change, which hasn't been
provided yet and that is not part of this series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/lib-sudo.sh                  | 12 +++++++
 t/t0034-root-safe-directory.sh | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 t/lib-sudo.sh

diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
new file mode 100644
index 0000000000..d8a88fb9db
--- /dev/null
+++ b/t/lib-sudo.sh
@@ -0,0 +1,12 @@
+# Helpers for running git commands under sudo.
+
+# Runs a scriplet passed through stdin under sudo.
+run_with_sudo () {
+	local ret
+	local RUN="$TEST_DIRECTORY/$$.sh"
+	write_script "$RUN" "$TEST_SHELL_PATH"
+	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
+	ret=$?
+	rm -f "$RUN"
+	return $ret
+}
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index ecd9dca6b3..5bc416ab81 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -3,6 +3,7 @@
 test_description='verify safe.directory checks while running as root'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-sudo.sh
 
 if [ "$GIT_TEST_ALLOW_SUDO" != "YES" ]
 then
@@ -10,6 +11,12 @@ then
 	test_done
 fi
 
+if ! test_have_prereq NOT_ROOT
+then
+	skip_all="These tests do not support running as root"
+	test_done
+fi
+
 test_lazy_prereq SUDO '
 	sudo -n id -u >u &&
 	id -u root >r &&
@@ -19,6 +26,12 @@ test_lazy_prereq SUDO '
 	test_cmp u r
 '
 
+if ! test_have_prereq SUDO
+then
+	skip_all="Your sudo/system configuration is either too strict or unsupported"
+	test_done
+fi
+
 test_expect_success SUDO 'setup' '
 	sudo rm -rf root &&
 	mkdir -p root/r &&
@@ -37,6 +50,51 @@ test_expect_success SUDO 'sudo git status as original owner' '
 	)
 '
 
+test_expect_success SUDO 'setup root owned repository' '
+	sudo mkdir -p root/p &&
+	sudo git init root/p
+'
+
+test_expect_success 'cannot access if owned by root' '
+	(
+		cd root/p &&
+		test_must_fail git status
+	)
+'
+
+test_expect_failure SUDO 'can access with sudo if root' '
+	(
+		cd root/p &&
+		sudo git status
+	)
+'
+
+test_expect_success SUDO 'can access with sudo using a workaround' '
+	# run sudo twice; would fail is root is not in the sudoers
+	(
+		cd root/p &&
+		sudo sudo git status
+	) &&
+	# provide explicit GIT_DIR
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			GIT_DIR=.git &&
+			GIT_WORK_TREE=. &&
+			export GIT_DIR GIT_WORK_TREE &&
+			git status
+		END
+	) &&
+	# discard SUDO_UID
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			unset SUDO_UID &&
+			git status
+		END
+	)
+'
+
 # this MUST be always the last test
 test_expect_success SUDO 'cleanup' '
 	sudo rm -rf root
-- 
2.36.1.371.g0fb0ef0c8d


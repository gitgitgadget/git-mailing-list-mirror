Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB4C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359850AbiEMBAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359830AbiEMBAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:00:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18328BDCE
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f3so5675771qvi.2
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tISL5BkiYewQ/wT2mijcErBb5YaC7JMSKUYX08h2l0=;
        b=HcRbAuRzOF0D7lND5ysUCzNg5l+JPmsIRDmt/nWz4lhfV8B36iP8a1djS23de1a9as
         NYlOHOpxmMVw17dUbONPhv9ihDEGmUk5GVgCyxhFfeu7gkkV026SkOnXk8No2ZxRQbyn
         kfguQNBa7z8JXeC2hlcltSuVMTDgz0S/PSniMCI0JWa7dG62LBenfpFsJnk8F71l4gQN
         gGRzxm6lhlPg4vBbOUKvqUzusWyl+9t5k485xWTiqSLaXp3osxGBVvs91kfrFiSePtED
         5qdlHugboN14x3BhIwMdh//weFfbmhkJ4BNGKfedfiOqfSCV7tvDVf5l5dqlM1b5BWF2
         +ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tISL5BkiYewQ/wT2mijcErBb5YaC7JMSKUYX08h2l0=;
        b=ZpK9G9cCQfpIVwSIJxE3n8cAp9omXQw8XVPGGHqf60hiZApotWBC9X04Heth74I+u8
         +6pmGyzVzBqHW2ZdzyMOZCEA9/5k+e+lL6RFkTKkxOSw+XeleI9TdyKcEROk2RolpdTW
         Y0xIbhCmIKJmVUFgreq+BD7aNBcW439BO4cWbZEeCreNFdbu+6yU/MVwIwxeZ4b7I4WT
         xWBQ0xzSd0vAtRVmxI4tXNEUkBF5Rkm9wsm2NiY53oKN906fiV7yEkHFdf4Ics5PHlGR
         2hLZTgYRhFxrOxaWwwXludphipiMFpIKPCDt4UUDPEhg3g/tMInpvEZ62jG33Q/3y5ak
         gXOw==
X-Gm-Message-State: AOAM531WiVn+w2Z0OuFRRUZmWTuRs37mYzaTy7PMwEWCvilnGhNmVnbl
        3OpquI62A6DEFq2vAqcwoQgJuefgT/o=
X-Google-Smtp-Source: ABdhPJw4gu1UOEyg0yXFnkNzF7UkwPErK6Qi2IbJp4zVwbY8qU0P/Z7l/mhWWLr6E8WHc7HRBBLVHA==
X-Received: by 2002:a05:6214:21cd:b0:45b:127b:7dd1 with SMTP id d13-20020a05621421cd00b0045b127b7dd1mr2347275qvh.108.1652403637410;
        Thu, 12 May 2022 18:00:37 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s202-20020a3745d3000000b0069fc13ce227sm583541qka.88.2022.05.12.18.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 18:00:36 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 3/4] t0034: add negative tests and allow git init to mostly work under sudo
Date:   Thu, 12 May 2022 18:00:19 -0700
Message-Id: <20220513010020.55361-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220513010020.55361-1-carenas@gmail.com>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
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

Document a regression that was introduced by previous commits where
root won't be able anymore to access directories they own unless
SUDO_UID is removed from their environment.

The tests document additional ways that this new restriction could
be worked around and the documentation explains why it might be instead
considered a feature, but a "fix" is planned for a future change.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-sudo.sh                  | 15 ++++++++
 t/t0034-root-safe-directory.sh | 62 ++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 t/lib-sudo.sh

diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
new file mode 100644
index 00000000000..b4d7788f4e5
--- /dev/null
+++ b/t/lib-sudo.sh
@@ -0,0 +1,15 @@
+# Helpers for running git commands under sudo.
+
+# Runs a scriplet passed through stdin under sudo.
+run_with_sudo () {
+	local ret
+	local RUN="$TEST_DIRECTORY/$$.sh"
+	write_script "$RUN" "$TEST_SHELL_PATH"
+	# avoid calling "$RUN" directly so sudo doesn't get a chance to
+	# override the shell, add aditional restrictions or even reject
+	# running the script because its security policy deem it unsafe
+	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
+	ret=$?
+	rm -f "$RUN"
+	return $ret
+}
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index 6b8ea5357f6..a621f1ea5eb 100755
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
@@ -36,6 +49,55 @@ test_expect_success SUDO 'sudo git status as original owner' '
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
+test_expect_success 'can access if addressed explicitly' '
+	(
+		cd root/p &&
+		GIT_DIR=.git GIT_WORK_TREE=. git status
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
+test_expect_success SUDO 'can access with sudo if root by removing SUDO_UID' '
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			unset SUDO_UID &&
+			git status
+		END
+	)
+'
+
+test_lazy_prereq SUDO_SUDO '
+	sudo sudo id -u >u &&
+	id -u root >r &&
+	test_cmp u r
+'
+
+test_expect_success SUDO_SUDO 'can access with sudo abusing SUDO_UID' '
+	(
+		cd root/p &&
+		sudo sudo git status
+	)
+'
+
 # this MUST be always the last test
 test_expect_success SUDO 'cleanup' '
 	sudo rm -rf root
-- 
2.36.1.371.g0fb0ef0c8d


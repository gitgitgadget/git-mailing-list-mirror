Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D3C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348407AbiEJRum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348388AbiEJRue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:50:34 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B659978
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c8so13121690qvh.10
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cn83vrYcwSmTs+Yn4rucxqISZ4LQ1+HVmZDCs1zjaq8=;
        b=owHyOO3uj+esoWkWViyV7Xbsib9NtszRxCXvReV7/gVY3u1RdPnk73PlL8fJAtabXO
         jilS7npUKn5q7w+HFMO8Gn6ofkCaItN0G0X18O+r3jH/zOOn0W8Q9B+mg7G/C2HfkdtK
         aE5I8E5aaAXw9ZQPjvXY69bP0o7DNKDgonkSWIsPKnvh0PHKA/nhMzHKqxoFyBJyLRR3
         Bm5TVZ6Qe2mABRM8loKoQKNfpgk4r2K9VlTBM63ozHGLyTPMzdli3bZrqpNZHvEYGq2X
         /2OsELEPdow3UfTNrsSeAwz4Rmf0D/UH76P3LVzvC6ltT7yjR6gdqx5O4LdxpqRuVxox
         bwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cn83vrYcwSmTs+Yn4rucxqISZ4LQ1+HVmZDCs1zjaq8=;
        b=kK14em9ctFAAXL6QsYIso27rmShXCefMSiTjodOgVOvbh4EPUTRnBETeDnnUi7ilZ+
         6Yi/OFr8q+gq/nznWvJthHBVnr72EeFj97TYPub+qeTwZ5NYvH30Dxqmz+GyTiV5R7hW
         /84B2h+3XgNo4E5CnupKzxsvf+FI4/sfs7HxC+OE/83AOrONje0bvTShDRkIezfmV8JW
         Lzw/iBIiePVdYJDAGpyvN7Tbdc17kgUOKPVI7GYdVyINsgDH1nGQBpb+UYdPjl4ea8us
         s6nUr6i7G+eTX3lSyFli24Ub+VU6knNGFdKLZSjmZHijLN+tjzLCUY/Z3tmmzDy+czIx
         GF1Q==
X-Gm-Message-State: AOAM532Dgoqam9Zr2e3P61lKCHnQxCYQ/6Sd3bCGSkB1/Bo2UVyjiSz7
        YoFB90dJSJhKmWfBZCzZN88q6nD2VR8=
X-Google-Smtp-Source: ABdhPJy5kMFRT7dwYpKT1AQt4KvNtNwrIGGsgVA9eNpeZvEH0ISiCNP95UUKGf8fVYmTVhPU+qWSgw==
X-Received: by 2002:a05:6214:5284:b0:444:10c8:ee59 with SMTP id kj4-20020a056214528400b0044410c8ee59mr19144221qvb.68.1652204794666;
        Tue, 10 May 2022 10:46:34 -0700 (PDT)
Received: from localhost.localdomain (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h191-20020a379ec8000000b0069fc347ef5dsm8719280qke.74.2022.05.10.10.46.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 10:46:34 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 3/3] t0034: add negative tests and allow git init to mostly work under sudo
Date:   Tue, 10 May 2022 10:46:16 -0700
Message-Id: <20220510174616.18629-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220510174616.18629-1-carenas@gmail.com>
References: <20220507163508.78459-1-carenas@gmail.com>
 <20220510174616.18629-1-carenas@gmail.com>
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
to NOT add an exception or NOT need a "workaround" to be able to run git
commands in a repository owned by thyself, is marked as a regression
and is expected to be fixed with a future change, which hasn't been
provided yet and that is not part of this series.

As described in the comments from the test itself, at least one of the
documented workarounds could fail if sudo doesn't allow root to call sudo
or if root is not in sudoers, but that is very unlikely, and more
importantly actually not what is provided by the currently supported sudo
configuration this test already relies on and therefore adding a way to
validate it works in the prerequisite has been punted for now.

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
index ecd9dca6b3..54f687d787 100755
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
+	# run sudo twice; would fail if root is not in sudoers
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


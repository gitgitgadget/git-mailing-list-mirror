Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED76AC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiECG73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiECG6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:58:31 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBA1A06B
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:54:58 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e128so12995461qkd.7
        for <git@vger.kernel.org>; Mon, 02 May 2022 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+y/IIIGRGhvoOp18B+Q0+f7yBJC0rWUHAbO7GglA8U=;
        b=FOAP3A2mqiR8H289loHYJQ3XQWN1s/5SMWkjMRWZrI7aDcf7XWdB9DlpK6zl6/l9NI
         m5fdaJ6yfKzOFPpdgQzfrWyUZT/zxk4yXYbOGP5gFV2iC/2BZqRycbCv9h8swoIKdczS
         ATvhJaIaOT2iy/tVnyjkREKIk//OFjP/aeoureZtQuEgFYv29pw1Oig5un9MTsMB6Zjl
         Kp40MSb2ibPUVsxgurFBimccBaSjqic9hz0csCrikB5SXH8hd7sqGvh0dPo8RPHCYhZs
         YUqZ44r3eyB75pmF8qmjw9t1VwHbe+WqC/sve+I4FgXGcyZRXWuU9KGW0sgKHeUHwncQ
         8CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+y/IIIGRGhvoOp18B+Q0+f7yBJC0rWUHAbO7GglA8U=;
        b=avA0dX72Z0Bp4lX3eNGBkC3egLxGk3lKNl7rS7DUZs13vJXUU/n8qlnbeHx+Ake/+h
         41HT2QKk6wFY8+4XnUNJYFb4dJBxfGm4OUwzSmEqaU1aF1s+5WffMWY2/GVNA/qFHepZ
         4aaRLYgB2bFGBBJKXdwQacVffcZtbwFjCJxjK8WR5duOS9LjMayJMqsaF9h8Xxf3VhOK
         YHOwXZe9VvZz3ALjTGn8wMmUwdko+Nou6VnPy8xACJYF7QXgiCsBo8h05pu7tkhNQlMt
         Llx17E2MLWJ7lpSsMpkYMMzT7JeODfx0MjK5qp9RBfSRhlFd7EUVvkEbImOIredk9yNf
         79vg==
X-Gm-Message-State: AOAM532YHv9zWAOELM7DQymqROZizyswUoY2VvK63vNSP8dOKCrgxpbY
        l+r4pnnVCAJDcMCqnPnkJby58x+XMRw=
X-Google-Smtp-Source: ABdhPJzNzcdCiutR7PJe1nJU4zdqBqVM9Ua+71D6O7S02oB4jMgS4iUAeLv5PpF8GUeEoK/ayVhatg==
X-Received: by 2002:a37:4651:0:b0:69f:eb93:d212 with SMTP id t78-20020a374651000000b0069feb93d212mr4726807qka.613.1651560897809;
        Mon, 02 May 2022 23:54:57 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t1-20020ac85301000000b002f39b99f68bsm5333369qtn.37.2022.05.02.23.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 23:54:57 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 3/3] t0034: enhance framework to allow testing more commands under sudo
Date:   Mon,  2 May 2022 23:54:42 -0700
Message-Id: <20220503065442.95699-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220503065442.95699-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a support library that provides one function that can be used
to run a "scriplet" of commands through sudo and that has an
optional parameter (currently unused) to indicate which shell to
use to do so.

Add additional negative tests as suggested by Junio and that use
new workspace that is owned by root.

Note that in order to be able to call `test_must_fail sudo git status`
or an equivalent, test_must_fail will need to be enhanced or be able
to run under sudo, so fixing that has been punted, since the only
protection it affords is for `git status` not crashing, and that is
covered already by other tests.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/lib-sudo.sh                  | 13 +++++++
 t/t0034-root-safe-directory.sh | 70 +++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-sudo.sh

diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
new file mode 100644
index 00000000000..9ebb30fc82b
--- /dev/null
+++ b/t/lib-sudo.sh
@@ -0,0 +1,13 @@
+# Helpers for running git commands under sudo.
+
+# Runs a scriplet passed through stdin under sudo.
+run_with_sudo () {
+	local ret
+	local SH=${1-"$TEST_SHELL_PATH"}
+	local RUN="$HOME/$$.sh"
+	write_script "$RUN" "$SH"
+	sudo "$SH" -c "\"$RUN\""
+	ret=$?
+	rm -f "$RUN"
+	return $ret
+}
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index dd659aed4e1..a68e1d7602b 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -3,6 +3,7 @@
 test_description='verify safe.directory checks while running as root'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-sudo.sh
 
 if [ "$IKNOWWHATIAMDOING" != "YES" ]
 then
@@ -10,6 +11,12 @@ then
 	test_done
 fi
 
+if ! test_have_prereq NOT_ROOT
+then
+	skip_all="No, you don't; these tests can't run as root"
+	test_done
+fi
+
 # this prerequisite should be added to all the tests, it not only prevents
 # the test from failing but also warms up any authentication cache sudo
 # might need to avoid asking for a password
@@ -40,8 +47,67 @@ test_expect_success SUDO 'sudo git status as original owner' '
 	)
 '
 
-# this MUST be always the last test, if used more than once, the next
-# test should do a full setup again.
+# this destroys the test environment used above
+test_expect_success SUDO 'cleanup regression' '
+	sudo rm -rf root
+'
+
+if ! test_have_prereq SUDO
+then
+	skip_all="You need sudo to root for all remaining tests"
+	test_done
+fi
+
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
+	# run sudo twice
+	(
+		cd root/p &&
+		run_with_sudo <<-END
+			sudo git status
+		END
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
+# this MUST be always the last test
 test_expect_success SUDO 'cleanup' '
 	sudo rm -rf root
 '
-- 
2.36.0.352.g0cd7feaf86f


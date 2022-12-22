Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098CFC10F1D
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 15:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiLVPOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiLVPOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 10:14:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A01007D
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r126-20020a1c4484000000b003d6b8e8e07fso3914438wma.0
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDKpSmBn+STnbwuijw/6VlfTrIRU0b/XAk8TQ+voHE0=;
        b=eWbcsnaqR6Jrjvt81VTbQgq4A0YTDgIPZLYZjbkFn3RXTJkfi9sMITCllV/ANHpmsa
         yXnZKKMMLgo64wXWUfM8KXI0SUecrCKJ45m+4MZL2WW033SnIu0dXRwwWBOhV9nFU4gq
         4Oi8p9+fZpVy+ScsfUjqdxiIBkINqq9/Zw+VhnZwoBi2rlwJPxrrBH2fUIV/Zn0kQyED
         LEPIUckL+fc8dNwya8qyRukxnnT+LUx4XMT19kC2/X91V07fIiphXFioA8rbPaKOujmV
         UUCQkNd0w8PaIecTafIgzHX0OYW7K2K+UZp9aNEiAmWsB5qB998r/8JmxIXtLhzRYniP
         M2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDKpSmBn+STnbwuijw/6VlfTrIRU0b/XAk8TQ+voHE0=;
        b=4Onfod2mbu9VhWdpPYkYTVZhzYVpd2CMGymXnax11l0ACEkYMbw3mBuuX7liaL8cI+
         w6BzzROllWweOxaDnSMq/1/jXvZlIYNKJUhvC1fGJrWZ+fFBFdEExiEDAe04DlRMaw2t
         FVn5FeFNBUGaRB/3efNhg/Hfb7kbO3xnuPLKvoLIMD9ULEye/Gs0k3H6bv8uwRJt5isH
         6NqG7G7P0EvKzQrMkeeh4lhGoTzcHKm0EBazcfMxx0krvExScpq3UrDguhbX1MmEM3cw
         2llbyi71hYEho7XJw3HF7O5w7exOE+fBsjcFgnYWIW1yAq+tIX72KBMH3kKUShzpwiz4
         DbvA==
X-Gm-Message-State: AFqh2korx5Aya+Wqdq6zu5JrL9HIy8wVV+7A2ii0K5HodjLSJMKoyCiJ
        D3s6lcdlxGLVuBAUiHd26kqyHLYGu8c=
X-Google-Smtp-Source: AMrXdXst77UHpLJqCmQb9AJXcKHvoNkTjCkoalZ4IjIuxaP38Wsbu5XItkGHI6RyDU4YHtWaPx6wVQ==
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr4554727wmb.7.1671722061694;
        Thu, 22 Dec 2022 07:14:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003cfa3a12660sm12017792wmq.1.2022.12.22.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:14:21 -0800 (PST)
Message-Id: <3267a5b3b372d9b33ad3afd22bde7ba5559331ae.1671722058.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
        <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 22 Dec 2022 15:14:08 +0000
Subject: [PATCH v4 02/11] t: create test harness for 'bundle-uri' command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

The previous change allowed for a Git server to advertise the
'bundle-uri' command as a capability based on the
uploadPack.advertiseBundleURIs config option. Create a set of tests that
check that this capability is advertised using 'git ls-remote'.

In order to test this functionality across three protocols (file, git,
and http), create lib-bundle-uri-protocol.sh to generalize the tests,
allowing the other test scripts to set an environment variable and
otherwise inherit the setup and tests from this script.

The tests currently only test that the 'bundle-uri' command is
advertised or not. Other actions will be tested as the Git client learns
to request the 'bundle-uri' command and parse its response.

To help with URI escaping, specifically for file paths with a space in
them, extract a 'sed' invocation from t9199-git-svn-info.sh into a
helper function for use here, too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/lib-bundle-uri-protocol.sh           | 85 ++++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh | 17 ++++++
 t/t5731-protocol-v2-bundle-uri-git.sh  | 17 ++++++
 t/t5732-protocol-v2-bundle-uri-http.sh | 17 ++++++
 t/t9119-git-svn-info.sh                |  2 +-
 t/test-lib-functions.sh                |  7 +++
 6 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-bundle-uri-protocol.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh

diff --git a/t/lib-bundle-uri-protocol.sh b/t/lib-bundle-uri-protocol.sh
new file mode 100644
index 00000000000..2da22a39cb8
--- /dev/null
+++ b/t/lib-bundle-uri-protocol.sh
@@ -0,0 +1,85 @@
+# Set up and run tests of the 'bundle-uri' command in protocol v2
+#
+# The test that includes this script should set BUNDLE_URI_PROTOCOL
+# to one of "file", "git", or "http".
+
+BUNDLE_URI_TEST_PARENT=
+BUNDLE_URI_TEST_URI=
+BUNDLE_URI_TEST_BUNDLE_URI=
+case "$BUNDLE_URI_PROTOCOL" in
+file)
+	BUNDLE_URI_PARENT=file_parent
+	BUNDLE_URI_REPO_URI="file://$PWD/file_parent"
+	BUNDLE_URI_BUNDLE_URI="$BUNDLE_URI_REPO_URI/fake.bdl"
+	test_set_prereq BUNDLE_URI_FILE
+	;;
+git)
+	. "$TEST_DIRECTORY"/lib-git-daemon.sh
+	start_git_daemon --export-all --enable=receive-pack
+	BUNDLE_URI_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
+	BUNDLE_URI_REPO_URI="$GIT_DAEMON_URL/parent"
+	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq BUNDLE_URI_GIT
+	;;
+http)
+	. "$TEST_DIRECTORY"/lib-httpd.sh
+	start_httpd
+	BUNDLE_URI_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
+	BUNDLE_URI_REPO_URI="$HTTPD_URL/smart/http_parent"
+	BUNDLE_URI_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq BUNDLE_URI_HTTP
+	;;
+*)
+	BUG "Need to pass valid BUNDLE_URI_PROTOCOL (was \"$BUNDLE_URI_PROTOCOL\")"
+	;;
+esac
+
+test_expect_success "setup protocol v2 $BUNDLE_URI_PROTOCOL:// tests" '
+	git init "$BUNDLE_URI_PARENT" &&
+	test_commit -C "$BUNDLE_URI_PARENT" one &&
+	git -C "$BUNDLE_URI_PARENT" config uploadpack.advertiseBundleURIs true
+'
+
+case "$BUNDLE_URI_PROTOCOL" in
+http)
+	test_expect_success "setup config for $BUNDLE_URI_PROTOCOL:// tests" '
+		git -C "$BUNDLE_URI_PARENT" config http.receivepack true
+	'
+	;;
+*)
+	;;
+esac
+BUNDLE_URI_BUNDLE_URI_ESCAPED=$(echo "$BUNDLE_URI_BUNDLE_URI" | test_uri_escape)
+
+test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: no bundle-uri" '
+	test_when_finished "rm -f log" &&
+	test_when_finished "git -C \"$BUNDLE_URI_PARENT\" config uploadpack.advertiseBundleURIs true" &&
+	git -C "$BUNDLE_URI_PARENT" config uploadpack.advertiseBundleURIs false &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$BUNDLE_URI_REPO_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	! grep bundle-uri log
+'
+
+test_expect_success "connect with $BUNDLE_URI_PROTOCOL:// using protocol v2: have bundle-uri" '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$BUNDLE_URI_REPO_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep "< bundle-uri" log
+'
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
new file mode 100755
index 00000000000..37bdb725bca
--- /dev/null
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'file://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'file://' transport
+#
+BUNDLE_URI_PROTOCOL=file
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
new file mode 100755
index 00000000000..8add1b37abc
--- /dev/null
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+BUNDLE_URI_PROTOCOL=git
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
new file mode 100755
index 00000000000..129daa02269
--- /dev/null
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'http://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'http://' transport
+#
+BUNDLE_URI_PROTOCOL=http
+. "$TEST_DIRECTORY"/lib-bundle-uri-protocol.sh
+
+test_done
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 8201c3e808a..088d1c57a88 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -28,7 +28,7 @@ test_cmp_info () {
 	rm -f tmp.expect tmp.actual
 }
 
-quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
+quoted_svnrepo="$(echo $svnrepo | test_uri_escape)"
 
 test_expect_success 'setup repository and import' '
 	mkdir info &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 29d914a12ba..5f6966a404b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1755,6 +1755,13 @@ test_path_is_hidden () {
 	return 1
 }
 
+# Poor man's URI escaping. Good enough for the test suite whose trash
+# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
+# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
+test_uri_escape() {
+	sed 's/ /%20/g'
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B719C7EE23
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjB0RU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjB0RU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:20:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E4222FE
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:20:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4290203wmb.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovOhU5TjAcGFLeRMd92EmZ7QHlvXUXVDYVMNz8KO1Zc=;
        b=ZOFG4lXjKEwYgQGkCI7pTRIR1CdljPX5RY8qkMLNJfspQU25PJaQoN1jWCoEfyYx8r
         oBfOzJ2O6woKfyXbLL1VGVdrhMzcnIo90Od52+I8aZitWR9D9fIC/CwqI8ZzB2IVcu1s
         9+7GHCUToIPcCHe75EPhmEcdB5ioTSmoWk4MdOsnpv9ymYze4yYf7LsW/LHXpFw92nnd
         7tWZH+lkyCLPe2eDyDlEK8Kww/MnhZndISr4YIMvEU3qprVO5g6kmLsOe5KkbM7PERYu
         q88kU6AtwcjjidMyZw1VIV2nPnqb7o6USPylenNk0LTeTtaPozuLX+/GN0KBdaHzspKO
         /qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovOhU5TjAcGFLeRMd92EmZ7QHlvXUXVDYVMNz8KO1Zc=;
        b=hQNufQUuWcrpPPpapcsstlA7RSne/P1u7dWFsLxjZMpT+CIpGPPnSswl4dR3L48d0W
         dOzCLIe9O9Qrj0YQBJM4GbJzQmH7y87QAJm8/2pQ2yIvu0zoSgkrEvrba4JtverZaHDC
         i7JnBfsSjJWNWFbM1mGRcNcWtISbXlJmjrwqLE7mStmonJWluolxp1YUnfc6tSSj1Tla
         gpfJIG8YOJ/jkZZ0YIoeaL7Tfa+M0uKedwHs56SA1c9ikQE56sVUfTZh6QJVYI0vsHqw
         RhinZ4u62S4KPqXUN4MUv5fFg3Sk5RArlAiNgdwA1emDx4ZMZdH7V8eM33E/Pl3niYjB
         eiVg==
X-Gm-Message-State: AO0yUKU8h/JdP6U9aD9Bq15szVF/ir42oKRZTrY3EEY2ErFsev71ixJq
        1e5a3IPQFcwVaqbNmQ61edo/8si56sQ=
X-Google-Smtp-Source: AK7set+FUO+J9N7kW9oF7U7UUMeu7mK1xWrJT+qyUCTpmkxkfF1rl+FENt7CiO+S8I0Bu1EcCc5yIw==
X-Received: by 2002:a05:600c:3b99:b0:3df:f124:f997 with SMTP id n25-20020a05600c3b9900b003dff124f997mr7184022wms.19.1677518422954;
        Mon, 27 Feb 2023 09:20:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b003eafc47eb09sm9837994wmb.43.2023.02.27.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:20:22 -0800 (PST)
Message-Id: <f7b234c4038345ec3bd1240aa9b85c90fdff181d.1677518420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
References: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
        <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 17:20:18 +0000
Subject: [PATCH v11 1/3] t5563: add tests for basic and anoymous HTTP access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a test showing simple anoymous HTTP access to an unprotected
repository, that results in no credential helper invocations.
Also add a test demonstrating simple basic authentication with
simple credential helper support.

Leverage a no-parsed headers (NPH) CGI script so that we can directly
control the HTTP responses to simulate a multitude of good, bad and ugly
remote server implementations around auth.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/lib-httpd.sh                 |  1 +
 t/lib-httpd/apache.conf        |  6 +++
 t/lib-httpd/nph-custom-auth.sh | 39 ++++++++++++++++
 t/t5563-simple-http-auth.sh    | 83 ++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 t/lib-httpd/nph-custom-auth.sh
 create mode 100755 t/t5563-simple-http-auth.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 608949ea80b..2c49569f675 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -137,6 +137,7 @@ prepare_httpd() {
 	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
+	install_script nph-custom-auth.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0294739a77a..76335cdb24d 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -135,6 +135,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	SetEnv GIT_PROTOCOL
 </LocationMatch>
+<LocationMatch /custom_auth/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	CGIPassAuth on
+</LocationMatch>
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
@@ -144,6 +149,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
 ScriptAlias /error/ error.sh/
 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
+ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
new file mode 100644
index 00000000000..f5345e775e4
--- /dev/null
+++ b/t/lib-httpd/nph-custom-auth.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+VALID_CREDS_FILE=custom-auth.valid
+CHALLENGE_FILE=custom-auth.challenge
+
+#
+# If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as a valid
+# credential for the current request. Each line in the file is considered a
+# valid HTTP Authorization header value. For example:
+#
+# Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+#
+# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as headers
+# in a 401 response if no valid authentication credentials were included in the
+# request. For example:
+#
+# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+# WWW-Authenticate: Basic realm="example.com"
+#
+
+if test -n "$HTTP_AUTHORIZATION" && \
+	grep -Fqsx "${HTTP_AUTHORIZATION}" "$VALID_CREDS_FILE"
+then
+	# Note that although git-http-backend returns a status line, it
+	# does so using a CGI 'Status' header. Because this script is an
+	# No Parsed Headers (NPH) script, we must return a real HTTP
+	# status line.
+	# This is only a test script, so we don't bother to check for
+	# the actual status from git-http-backend and always return 200.
+	echo 'HTTP/1.1 200 OK'
+	exec "$GIT_EXEC_PATH"/git-http-backend
+fi
+
+echo 'HTTP/1.1 401 Authorization Required'
+if test -f "$CHALLENGE_FILE"
+then
+	cat "$CHALLENGE_FILE"
+fi
+echo
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
new file mode 100755
index 00000000000..bc880bf80f9
--- /dev/null
+++ b/t/t5563-simple-http-auth.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='test http auth header and credential helper interop'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd
+
+test_expect_success 'setup_credential_helper' '
+	mkdir "$TRASH_DIRECTORY/bin" &&
+	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
+	export PATH &&
+
+	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
+	write_script "$CREDENTIAL_HELPER" <<-\EOF
+	cmd=$1
+	teefile=$cmd-query.cred
+	catfile=$cmd-reply.cred
+	sed -n -e "/^$/q" -e "p" >>$teefile
+	if test "$cmd" = "get"
+	then
+		cat $catfile
+	fi
+	EOF
+'
+
+set_credential_reply () {
+	cat >"$TRASH_DIRECTORY/$1-reply.cred"
+}
+
+expect_credential_query () {
+	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
+	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
+		 "$TRASH_DIRECTORY/$1-query.cred"
+}
+
+per_test_cleanup () {
+	rm -f *.cred &&
+	rm -f "$HTTPD_ROOT_PATH"/custom-auth.valid \
+	      "$HTTPD_ROOT_PATH"/custom-auth.challenge
+}
+
+test_expect_success 'setup repository' '
+	test_commit foo &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
+'
+
+test_expect_success 'access using basic auth' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_done
-- 
gitgitgadget


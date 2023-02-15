Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91248C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 21:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBOVeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 16:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBOVeL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 16:34:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4BB769C
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 13:34:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so121142wmb.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfSKXiIrvwW+36Is2X7nmIDcvFU2T78IdSOx9rCc39s=;
        b=IFx8y4jCCNFEqTOqRe96pebZV4tyALxtwzSuojq2DWqEwLQJEMzjuSP+oRQNpySedB
         dH9QVlZz2L7dx5KFpkSfey4QBssPYewrUaEzj0C8h7WRIUMKN9ls4/EImMm8YANM+2Ve
         MZUlcRuynn8JOr+9rU2B/mV7Pspv+RocpC9al5Y3Dm8ch7hZXCTNloGWUxb4rkv/8GOh
         d84xAzrdUmqrqmi1jPe5vp5ekNza1WHNFASfmZ1RYy2M7yTwVwYdoy2k/WvCw4XrIUQ3
         hlYM1a+49zZ++DE6NwRv0/jf8vf3wr9yB2auxAcUnJh8B1JXS8zdTU2o5hJCvbMKUm7p
         MWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfSKXiIrvwW+36Is2X7nmIDcvFU2T78IdSOx9rCc39s=;
        b=7iSFsHXmIDtuSQ1WZ6qmNtM7rBhx0HQmFaYa3as9oupn7GNvmUbevzMjp774e8gBup
         Cx/2+T5NE0yNJsrf8vAXgXfASao5+VNFq0UzqiNX40//ERR4h+5IYrsJoa6xfQm4/L8C
         wvVOQd/hR+Kbf9XEaN4yw/wrM++oT3hH8TWe4KTeSpqfT4HHHR4Kz8GluO/BSL3yPHfd
         oG1rZtPjbCYt9TKeZIFbH/nqePyWkeT8H+m03UTqD3uI/7meTBnUCaCXaRjLYux1Yyog
         xzlRSeWpOFvS/ufOdfbeMqpAvfeQUrYELBxwm+IFC0zu48Egc3RcLRTDVwgXXpwdTPcR
         YIMg==
X-Gm-Message-State: AO0yUKU63g7kn1WfOTWUbFjdhVTY6w0c+eWNqtfRnLqLH/NUMIlJZ+h6
        uqVGwvCzRJCR//AgwHmeCVjCV6vjYKc=
X-Google-Smtp-Source: AK7set+abo3ob01s+hNq09+NXLulylq1u+PZSex1vX+/muJwHZnF5hdpdMxJ5RufxAodJcsTPHrE1A==
X-Received: by 2002:a05:600c:1714:b0:3df:fff4:5f6f with SMTP id c20-20020a05600c171400b003dffff45f6fmr2878429wmn.36.1676496848774;
        Wed, 15 Feb 2023 13:34:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003e00c9888besm3612201wmo.30.2023.02.15.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:34:08 -0800 (PST)
Message-Id: <05449ec892b1205c1e1c90d15facd812b5cbbe3c.1676496846.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
        <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 21:34:04 +0000
Subject: [PATCH v9 1/3] t5563: add tests for basic and anoymous HTTP access
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
 t/t5563-simple-http-auth.sh    | 81 ++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100755 t/lib-httpd/nph-custom-auth.sh
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
new file mode 100755
index 00000000000..2dd35d6fa39
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
+	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE"
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
index 00000000000..e0682039de7
--- /dev/null
+++ b/t/t5563-simple-http-auth.sh
@@ -0,0 +1,81 @@
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
+set_credential_reply() {
+	cat >"$TRASH_DIRECTORY/$1-reply.cred"
+}
+
+expect_credential_query() {
+	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
+	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
+		 "$TRASH_DIRECTORY/$1-query.cred"
+}
+
+per_test_cleanup () {
+	rm -f *.cred &&
+	rm -f "$HTTPD_ROOT_PATH"/custom-auth.*
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


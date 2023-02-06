Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462FBC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBFT34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:29:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F235A2
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:29:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q8so9454019wmo.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2CKa+TP0Sfn3JluAO/UtZlHT9sZS//G8XxA1vZEuFw=;
        b=XjdAzjLk3q5puhMxnBMwIrxhqncqtlZcffP87yfPfHcSq9/oAomLHaCD27p6+k4VMB
         rXSuRW7dTCQLA0QATZ6EtPMKPWRFLBSZBYMtVfi4XlxHb5rAaEqYhC2fyVC4bUv+KoP0
         wdewRaZzdKcu0h8gVjTVhH/prDdjyhtEBa4PSxPFnNWcCcwxRmGy13n1oYUnchJSTDEF
         blTXmRb7PUisObuaskpVhoL0sgFu54g7puE7nJqEDE8bSwe0+g+1SWDxYtyfZQL1qCvn
         FJrkFCDyTIm5KdJJe7qWTY09lcUSB3GHTdYexeu9/PsqjvzMZk1JcSFOgcvqwFoC7yMK
         W+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2CKa+TP0Sfn3JluAO/UtZlHT9sZS//G8XxA1vZEuFw=;
        b=YSXCbvrLazKmyItOQ6TifO6ugWyuG8hSww2F9YLuizyOiTb0mtZDfzOdqCSoYqHtVj
         bLxYR6n8a9GC90+oDkSMFXKTZpA8b1rgFuw8C9gYmkPXt1+EY+Og7MDijsZzT6eHmSPy
         9hl9QISFr5T/i+J6v01O4WL8es3RmdOzb/X7CXGJ6L4z2Q+e18GTV7fiMi/O2NOwf840
         dVPbCzlrWBOPnorKpJzhV1JPojVoCnZ/xtPW9B0zfxPSo0hyh7oHWm5AEprNzz2NVHVV
         nNunq8DOtQjTh8KnXkpoY2GLBoulXWKDbWx8OIZ0GnawqP6lQ/yUOepzatPwPc18SEXI
         bkug==
X-Gm-Message-State: AO0yUKUIx/g63xwx9wPfiUnvc/b5CbYPf9DfNtHUFcFyoPRCUhO6GcOb
        XBxibo+zNikEJSFoCw3Iu8hkaw6iW/A=
X-Google-Smtp-Source: AK7set8v1ertDV8YDtC1oiZ0NKXFVWavjxrlt2rs/8X3PvcqN3bGzeQe3hro7wRUyGsMKuOh1NPYfg==
X-Received: by 2002:a05:600c:4a8a:b0:3de:d9f:3025 with SMTP id b10-20020a05600c4a8a00b003de0d9f3025mr848711wmp.0.1675711792090;
        Mon, 06 Feb 2023 11:29:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24-20020a05600c319800b003dfe5190376sm11171377wmp.35.2023.02.06.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:29:51 -0800 (PST)
Message-Id: <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Feb 2023 19:29:47 +0000
Subject: [PATCH v8 1/3] t5563: add tests for basic and anoymous HTTP access
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
 t/lib-httpd/nph-custom-auth.sh | 42 +++++++++++++++++
 t/t5563-simple-http-auth.sh    | 86 ++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)
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
index 00000000000..8f851aebac4
--- /dev/null
+++ b/t/lib-httpd/nph-custom-auth.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+VALID_CREDS_FILE=custom-auth.valid
+CHALLENGE_FILE=custom-auth.challenge
+ANONYMOUS_FILE=custom-auth.anonymous
+
+#
+# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
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
+if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
+	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
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
index 00000000000..004eac5d1ed
--- /dev/null
+++ b/t/t5563-simple-http-auth.sh
@@ -0,0 +1,86 @@
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
+	mkdir -p "$TRASH_DIRECTORY/bin" &&
+	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
+	export PATH &&
+
+	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
+	write_script "$CREDENTIAL_HELPER" <<-\EOF
+	cmd=$1
+	teefile=$cmd-query.cred
+	catfile=$cmd-reply.cred
+	sed -n -e "/^$/q" -e "p" >> $teefile
+	if test "$cmd" = "get"; then
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
+test_expect_success 'access anonymous no challenge' '
+	test_when_finished "per_test_cleanup" &&
+	touch "$HTTPD_ROOT_PATH/custom-auth.anonymous" &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git"
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

